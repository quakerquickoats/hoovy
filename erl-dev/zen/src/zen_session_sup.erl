%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 23 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_session_sup).
-author('humasect@gmail.com').
-behaviour(supervisor).

%% API
-export([start_link/0]).
-export([start_session/2, stop_session/1]).
-export([which_session/1, all_sessions/0, kill_all_sessions/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

start_session(Id, Name) ->
    %% temp !
    Spec = {Id, {Name, start_link, [Id]},
            temporary, 2000, worker, [Name]},
    %%Spec = {Id, {zen_game, start_link, [Id, Name]},
    %%        temporary, 2000, worker, [zen_game]},
    case supervisor:start_child(?SERVER, Spec) of
        {ok,Child} -> Child;
        {ok,Child,_} -> Child;
        {error,already_present} ->
            stop_session(Id),
            start_session(Id, Name);
        {error,{already_started,Child}} -> Child;
        Else -> throw(Else)
    end.

stop_session(Id) ->
    %% only called from zen_client:close_client
    %%supervisor:terminate_child(?SERVER, Id),
    case which_session(Id) of
        undefined -> ok;
        Pid -> Pid ! stop
    end,
    supervisor:delete_child(?SERVER, Id),
    {closed,Id}.

which_session(Name) ->
    L = [C || {Id,C,_,_} <- supervisor:which_children(?SERVER), Id == Name],
    case L of
        [Head] -> Head;
        _Else -> undefined
    end.

kill_all_sessions() ->
    lists:foreach(fun stop_session/1, all_sessions()).

all_sessions() ->
    [Id || {Id,_,_,_} <- supervisor:which_children(?SERVER)].

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

init([]) ->
    SupFlags = {one_for_one, 10, 3600},
    {ok, {SupFlags, []}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
