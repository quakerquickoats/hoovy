%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 23 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(val_game).
-author('humasect@gmail.com').
-behaviour(gen_server).

%% API
-export([start_link/1]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE). 

-include("huma.hrl").

-record(game, {login_id :: uinteger()}).

%%%===================================================================
%%% API
%%%===================================================================

start_link(Id) ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [Id], []).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([Id]) ->
    {ok, #game{login_id=Id}}.

handle_call([{<<"move">>, Angle}], _From, State) ->
    io:format("ok,move ~p~n", [Angle]),
    {reply, ok, State}
        ;
handle_call([<<"get_room">>], _From, State) ->
    io:format("get room.~n"),
    {reply, ok, State}
        ;
handle_call({logged_in, _ActorId, _Group, _Name}, _From, State) ->
    %%From ! {send, [{change_room, []}]},
    {reply, {send, [{change_room, []}]}, State}
        ;
handle_call(_Request, _From, State) ->
    {stop, unknown_message, {error,unknown_message}, State}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.

terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
