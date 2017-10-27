%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created :  1 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_mod_websocket).

%% API

%% inets module callbacks
-export([do/1, load/2, remove/1]).

%% internal
-export([ws_loop/1]).

-include("httpd.hrl").

%%%===================================================================
%%% inets module callbacks
%%%===================================================================

-define(headval(Key), proplists:get_value(Key, Header)).

do(ModData = #mod{parsed_header = Header,
                  socket_type = SocketType,
                  socket = Socket}) ->
    case {?headval("connection"), ?headval("upgrade")} of
        {"Upgrade","WebSocket"} ->
            io:format("ws: ~p~n    ~p~n", [self(), ModData]),

            [Key1,Key2] = plist_get_many(["sec-websocket-key1",
                                          "sec-websocket-key2"], Header),
            inet:setopts(Socket, [{packet,raw}, {active,false}]),
            io:format("waiting for key3.....~n"),
            Key3 = case <<>> of %gen_tcp:recv(Socket, 0, 5000) of
                       {ok,Bin} -> Bin;
                       _Else ->
                           io:format("mod_websocket: no key3, ~p~n", [_Else]),
                           <<>>
                   end,

            io:format("um.....~n"),

            Path = ModData#mod.request_uri,
            Origin = ?headval("origin"),
            Host = ?headval("host"),
            Body = ["HTTP/1.1 101 WebSocket Protocol Handshake\r\n",
                    "Upgrade: WebSocket\r\n",
                    "Connection: Upgrade\r\n",
                    "Sec-WebSocket-Origin: ", Origin, "\r\n",
                    "Sec-WebSocket-Location: ws://", Host ++ Path,
                    "\r\n\r\n",
                    build_challenge(Key1, Key2, Key3)],
            httpd_socket:deliver(SocketType, Socket, Body),
            %gen_tcp:send(Socket, Body),
            inet:setopts(Socket, [{packet,0}, {active,true}]),

            {_Path,[_Q|QueryString]} = httpd_util:split_path(Path),
            [User,Pass,Lang] = plist_get_many(["user", "pass", "lang"],
                                              httpd:parse_query(QueryString)),
            io:format("okay..... user: ~p pass: ~p lang: ~p~n",
                      [User,Pass,Lang]),
            ?MODULE:ws_loop(Socket),
            {break, [{response,{already_sent,200,0}}]};
        _Else ->
            {proceed, ModData#mod.data}
    end.

load(_Line, _AccIn) ->
    ok.

remove(_ConfigDB) ->
    ok.

%%%===================================================================
%%% Internal functions　内部の関数
%%%===================================================================

plist_get_many(List,C) ->
    lists:map(fun(E) -> proplists:get_value(E, C) end, List).

plist_get_dual(A,B,C) ->
    {proplists:get_value(A,C),
     proplists:get_value(B,C)}.

% Code portions from Sergio Veiga <http://sergioveiga.com/index.php/2010/06/17/websocket-handshake-76-in-erlang/>
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


ws_loop(Socket) ->
    receive
        {tcp,Socket,Data} ->
            io:format("websocket receive: ~p~n", [Data]),
            ?MODULE:ws_loop(Socket);
        {tcp_closed,Socket} ->
            io:format("websocket closed~n");
        _Else ->
            io:format("websocket ... ~p~n", [_Else])
    end.
