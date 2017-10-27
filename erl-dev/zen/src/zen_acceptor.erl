%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%%            (C) 2006, Ciprian Ciubotariu
%%% @doc
%%%
%%% The network server accepts connections on the port specified by
%%% the application's <code>tcp_port</code> setting. When a
%%% connection is made, starts a client handler (game) and resumes
%%% accepting connections.
%%% See the documentation of module @link{} for details
%%% on how the connection is handled.
%%%
%%% @end
%%% Created : 17 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_acceptor).
-behaviour(gen_server).
-author('cheepeero@gmx.net').
-author('humasect@gmail.com').

%% API
-export([start_link/2]).

%% callbacks
-export([init/1, terminate/2,
         handle_call/3, handle_cast/2, handle_info/2,
         code_change/3]).

%% internal
-export([acceptor_init/2]).

-define(LISTEN_OPTS, [binary, {packet,raw},
                      {reuseaddr,true}, {active,false}]).

-define(ACCEPT_OPTS, [binary, {packet,raw},
                      %% {keepalive,true}, {nodelay,true},
                      {active,once}]).


%% see inet:setopts/2 for valid options
%% if not set, the following values are used:
%% 	      {tcp_opts, [{keepalive, true},
%% 			  {nodelay, true},
%% 			  {tos, 16#14}]},  % MINDELAY and RELIABILITY
%% see man page ip(7) -> netinet/ip.h for TOS values

-record(state,
        {type,
         listen_socket,
         acceptor,
         clients}).

%%%===================================================================
%%% API
%%%===================================================================

start_link(Type, Port) ->
    gen_server:start_link({local, Type}, ?MODULE, [Type, Port], []).

%%broadcast(Msg) ->
%%    gen_server:cast(?SERVER, {broadcast, Msg}).

ip_address(Socket) ->
    case inet:peername(Socket) of
        {ok,{Address,_Port}} -> Address;
        _Else -> {0,0,0,0}
    end.

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

-define(spawn_acceptor(Type),
        spawn_link(?MODULE, acceptor_init, [Type, ListenSocket])).

init([Type, Port]) ->
    case gen_tcp:listen(Port, ?LISTEN_OPTS) of
        {ok,ListenSocket} ->
            {ok, #state{type=Type,
                        listen_socket=ListenSocket,
                        acceptor=?spawn_acceptor(Type),
                        clients=[]}};
        Error ->
            exit(Error)
    end.

terminate(_Reason, #state{listen_socket=ListenSocket,
                          acceptor=Acceptor}) ->
    io:format("** acceptor terminated. Should kill all clients.~n"),
    exit(Acceptor, kill),
    gen_tcp:close(ListenSocket),
    ok.

handle_call(_Call, _From, State) ->
    {reply, ok, State}.

handle_cast({add_client, Pid},
            State = #state{type=Type,
                           listen_socket=ListenSocket,
                           acceptor=Acceptor,
                           clients=Clients}) ->
    erlang:monitor(process, Pid),
    unlink(Acceptor),
    {noreply, State#state{acceptor = ?spawn_acceptor(Type),
                          clients = [Pid | Clients]}}
        ;
handle_cast({broadcast, Msg}, State = #state{clients=Clients}) ->
    io:format("~w clients.~n", [length(Clients)]),
    lists:foreach(fun(C) -> C ! {send,Msg} end, Clients),
    {noreply, State}.

handle_info({'DOWN', _Ref, process, Pid2, _Reason},
            State = #state{clients=Clients}) ->
    NewClients = lists:delete(Pid2, Clients),
    %%io:format("client died: ~p~n", [Reason]),
    {noreply, State#state{clients = NewClients}}.

code_change(_OldVsn, State, _Extra) ->
    {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

process_socket(zen_acceptor_tcp, _Address, _Socket) -> ok;
process_socket(zen_acceptor_web, Address, Socket) ->
    %%inet:setopts(Socket, [{packet, raw}, {active, false}]),
    case gen_tcp:recv(Socket, 0, 5000) of
        {ok,Data} ->
            Lines = string:tokens(binary_to_list(Data), "\r"),
            Props = lists:map(
                      fun(P) ->
                              case string:str(P, ": ") of
                                  0 -> {"",""}; %string:str(P, " ");
                                  I ->                              
                                      K = string:substr(P, 1, I),
                                      V = string:substr(P, I+2),
                                      {K,V}
                              end
                      end, Lines),
            %%io:format("header-- ~p~n", [Lines]),

            Body = case proplists:get_value("\nSec-WebSocket-Key1:", Props) of
                       undefined -> websocket_body(Props);
                       Key1 -> websocket_body(Key1, Lines, Props)
                   end,

            %io:format("body---- ~p~n", [Body]),
            gen_tcp:send(Socket, Body);
        Else ->
            io:format("WEB ~p: no data. ~p~n", [Address,Else])
    end.

acceptor_init(Type, ListenSocket) ->
    case gen_tcp:accept(ListenSocket) of
        {ok,Socket} ->
            Address = ip_address(Socket),
            io:format("~w connected.~n", [Address]),
            gen_server:cast(Type, {add_client, self()}),
            process_socket(Type, Address, Socket),
            inet:setopts(Socket, ?ACCEPT_OPTS),
            zen_client:run(Type, Socket, Address);
        Else ->
            io:format("*** accept returned ~w.", [Else]),
            exit({error, {bad_accept, Else}})
    end.

%% websocket stuff

websocket_body(Props, Space) ->
    {proplists:get_value("\nOrigin:", Props),
     proplists:get_value("\nHost:", Props),
     ["HTTP/1.1 101 Web"++Space++"Socket Protocol Handshake\r\n",
     "Upgrade: WebSocket\r\n",
     "Connection: Upgrade\r\n"]}.

websocket_body(Key1, Lines, Props) ->
    {Origin,Host,Header} = websocket_body(Props, []),
    <<10,Key3/binary>> = list_to_binary(lists:last(Lines)),
    Key1 = proplists:get_value("\nSec-WebSocket-Key1:", Props),
    Key2 = proplists:get_value("\nSec-WebSocket-Key2:", Props),
    Header ++ ["Sec-WebSocket-Origin: ", Origin, "\r\n",
               "Sec-WebSocket-Location: ws://", Host ++ "/",
               "\r\n\r\n",
               build_challenge(Key1, Key2, Key3)].

websocket_body(Props) ->
    {Origin,Host,Header} = websocket_body(Props, " "),
    Header ++ ["WebSocket-Origin: ", Origin , "\r\n",
               "WebSocket-Location: ws://", Host ++ "/",
               "\r\n\r\n"].

%% Code portions from Sergio Veiga
%%http://sergioveiga.com/index.php/2010/06/17/websocket-handshake-76-in-erlang
build_challenge(Key1, Key2, Key3) ->
	Ikey1 = [D || D <- Key1, $0 =< D, D =< $9],
	Ikey2 = [D || D <- Key2, $0 =< D, D =< $9],
	Blank1 = length([D || D <- Key1, D =:= 32]),
	Blank2 = length([D || D <- Key2, D =:= 32]),
	Part1 = list_to_integer(Ikey1) div Blank1,
	Part2 = list_to_integer(Ikey2) div Blank2,
	Ckey = <<Part1:4/big-unsigned-integer-unit:8,
             Part2:4/big-unsigned-integer-unit:8, Key3/binary>>,
	erlang:md5(Ckey).
