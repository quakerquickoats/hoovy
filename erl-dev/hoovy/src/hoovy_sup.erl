%%%-------------------------------------------------------------------
%% @doc hoovy top level supervisor.
%% @end
%%%-------------------------------------------------------------------

-module(hoovy_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%====================================================================
%% API functions
%%====================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%====================================================================
%% Supervisor callbacks
%%====================================================================

%% Child :: {Id,StartFunc,Restart,Shutdown,Type,Modules}
init([]) ->
    Children = {hoovy_web_server, {hoovy_web_server, start_link, []},
		permanent, 2000, worker, [hoovy_web_server]},
    {ok, { {one_for_all, 0, 1}, [Children]} }.

%%====================================================================
%% Internal functions
%%====================================================================
