%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created :  9 Oct 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_game).
-author('humasect@gmail.com').
-behaviour(gen_server).

%% API
-export([start_link/2]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-include("huma.hrl").

-record(state, {login_id :: uinteger(),
                name,     %% will be record for each game name.
                path,
                port}).

%%%===================================================================
%%% API
%%%===================================================================

start_link(Id, Name) ->
    Registered = list_to_atom(
                   lists:flatten(io_lib:format("zen_game_~s_~p", [Name, Id]))),
    io:format("game ~s starting.~n", [Registered]),
    gen_server:start_link({local, Registered}, ?MODULE, [Id, Name], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([Id, Name]) ->
    process_flag(trap_exit, true),
    Path = code:priv_dir(Name),
    Port = open_port({spawn, filename:join(Path, Name)},
                     [%stream, {line,80},
                      binary, {packet,2},
                      {cd, Path}, eof]),
    io:format("port_info: ~p~n", [erlang:port_info(Port)]),
    {ok, #state{login_id=Id,
                name=Name,
                path=Path,
                port=Port}} .

handle_call({logged_in, _ActorId, _Group, _Name}, _From, State) ->
    {reply, {send, [{change_room, []}]}, State} ;
handle_call(Request, _From, State) ->
    %%State#state.port !
    %%    {self(), {command, jsx:term_to_json(Request)}},

    %%State#state.port ! {self(), {command, <<"Hellloooooooo~n">>}},

    %%port_command(State#state.port,
    %%             binary_to_list(jsx:term_to_json(Request))),

    port_command(State#state.port, <<"aoeuaoeuaouao....r.ia~n">>)
        ,{reply, ok, State}
        .
    %% receive
    %%     {_Port, {data, Data}} -> {reply, Data, State};
    %%     Else -> {stop, port_error, Else}
    %% after
    %%     2000 -> {stop, port_timeout, State}
    %% end.

handle_cast(_Msg, State) ->
    {noreply, State}
        .

handle_info({_Port, {o_data, <<$-,Data/binary>>}}, State)
%% evaluate some erlang
-> {ok,Scanned,_} = erl_scan:string(binary_to_list(Data))
       ,{ok,Parsed} = erl_parse:parse_exprs(Scanned)
       ,Eval = erl_eval:exprs(Parsed, [])
       ,io:format("eval: ~p~n", [Eval])
   %%Result = io_lib:format("~p", [Eval]),
   %%send_object(St, {"message", list_to_binary(Result)})
       ,{noreply, State}
       ;

handle_info({_Port, {data, Data}}, State)
->io:format("game data: '~p'~n", [Data])
  %%gen_server:reply(self(), Data),
      ,{noreply, State}
      ;
handle_info(stop, State) ->
    {stop, shutdown, State}
        ;
handle_info({'EXIT', _Port, Reason}, State) ->
    {stop, {port_exited,Reason}, State}
        ;
handle_info(_Info, State) ->
    io:format("unknown info: '~p'~n", [_Info]),
    {noreply, State}
        .

terminate(_Reason, State) ->
    io:format("game terminated.~n"),
    port_close(State#state.port),
    ok .

code_change(_OldVsn, State, _Extra) -> {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
