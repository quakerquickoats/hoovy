%%%-------------------------------------------------------------------
%% @doc hoovy public API
%% @end
%%%-------------------------------------------------------------------

-module(hoovy_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%%====================================================================
%% API
%%====================================================================

start(_StartType, _StartArgs) ->
    {ok, Pid} = hoovy_sup:start_link(),
    %% Routes = [{
    %% 		'_',
    %% 		[{"/", hoovy_root, []}]
    %% 	      }],
    %% Dispatch = cowboy_router:compile(Routes),
    
    %% NumAcceptors = 10,
    %% TransOpts = [{ip, {0,0,0,0}}, {port,2938}],
    %% ProtoOpts = [{env, [{dispatch, Dispatch}]}],

    %% {ok, _} = cowboy:start_http(hoovy_studio,
    %% 				NumAcceptors, TransOpts, ProtoOpts),
    {ok,Pid}.

%%--------------------------------------------------------------------
stop(_State) ->
    ok.

%%====================================================================
%% Internal functions
%%====================================================================
