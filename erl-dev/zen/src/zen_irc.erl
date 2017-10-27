%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 16 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_irc).
-behaviour(gen_server).

%% API
-export([start_link/1, stop/0]).
-export([cmd/2]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-export([socket_recv/2]).

-record(conn, {
          server,
          port=6667,
          channels=[],
          nick,

          status=not_connected
         }).

%%%===================================================================
%%% API
%%%===================================================================

start_link(Args) ->
    case gen_server:start_link({local, ?SERVER}, ?MODULE, Args, []) of
        {ok, Pid} = R ->
            gen_server:call(Pid, connect),
            R;
        Else -> Else
    end.

stop() ->
    gen_server:call(?SERVER, stop).

cmd(Fmt, Args) ->
    gen_server:call(?SERVER, {cmd, Fmt, Args}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init(Args) ->
    St = #conn{},
    Prop = fun(Key, Value) ->
                   proplists:get_value(Key, Args, element(Value, St))
           end,

    {ok, St#conn {
           server = Prop(server, #conn.server),
           port = Prop(port, #conn.port),
           channels = Prop(channels, #conn.channels),
           nick = Prop(nick, #conn.nick)
          }}.

%handle_call({socket_recv,Data}, _From, State) ->
%    {reply, ok, socket_recv(State, Data)};

handle_call(connect, _From, State) ->
    NewState = connect(State),
    {reply, ok, NewState}
        ;
handle_call({cmd,Fmt,Args}, _From, #conn{status={logged,_P,Sock}} = State) ->
    send_fmt(Sock, Fmt, Args),
    {reply, ok, State}
        ;
handle_call(stop, _From, State) ->
    NewState = disconnect(State),
    {stop, shutdown, NewState}
        ;
handle_call(_Request, _From, State) ->
    Reply = ok,
    {reply, Reply, State}.

handle_cast(_Msg, State) ->
    {noreply, State}.

handle_info({tcp,_Socket,Data}, State) ->
    NewState = ?MODULE:socket_recv(Data, State),
    {noreply, NewState}
        ;
handle_info({tcp_closed,_Socket}, State) ->
    io:format("tcp_closed.~n"),
    {stop, normal, State}
        ;
handle_info(_Info, State) ->
    {noreply, State}.

terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

connect(C) when C#conn.status == not_connected ->
    io:format("connect.........~n"),
    S = case gen_tcp:connect(C#conn.server, C#conn.port,[binary,{packet,0}]) of
            {ok,Sock} ->
                %Self = self(),
                %P = spawn_link(fun() -> process_socket(Self) end),
                gen_tcp:controlling_process(Sock, self()),
                {connected, undefined, Sock};
            Else ->
                throw(Else)
        end,
    C#conn{status=S}.

disconnect(#conn{status=not_connected} = C)     ->
    C;
disconnect(#conn{status={_Status,_P,Sock}} = C) ->
    io:format("disconnect........~n"),
    %P ! {tcp_closed,undefined}
    gen_tcp:close(Sock),
    %exit(P),
    C.

send_fmt(Socket, Fmt, Args) ->
    A = io_lib:format(Fmt, Args),
    io:format("send: ~s", [A]),
    gen_tcp:send(Socket, A).

socket_recv(Data, #conn{status={connected,P,Socket}, nick=Nick} = C) ->
    io:format("**** connected: ~p~n", [Data]),
    send_fmt(Socket, "NICK ~s~n", [Nick]),
    send_fmt(Socket, "USER ~s 8 *  : Lyndon Tremblay~n", [Nick]),
    C#conn {status={logged,P,Socket}};

socket_recv(Data, #conn{status={logged,_P,Socket}} = C) ->
    case Data of
        <<"PING ",Ping/binary>> ->
            io:format("**** PONG ~s", [Ping]),
            send_fmt(Socket, "PONG ~s", [Ping]);
        <<"ERROR ",Reason/binary>> ->
            io:format("**** error!: ~s~n", [Reason]);
        <<"NOTICE ",Stuff/binary>> ->
            io:format("**** notice: ~s~n", [Stuff]);
        <<Name,$ ,Command/binary>> ->
            io:format("test: ~s, ~s~n", [Name,Command]);
%        <<Name,$ ,Command,$ ,Rest/binary>> ->
%            io:format("Name: ~s~nCommand: ~s~nRest: ~s~n",
%                      [Name,Command,Rest]);
%        <<$:,_Server,$ ,_Number," * ",_Nick,$ ,Rest/binary>> ->
%            io:format("*** wow: ~s~n", [Rest]);
        _ ->
            io:format("**** unhandled: ~s~n", [Data])
    end,
    C.

