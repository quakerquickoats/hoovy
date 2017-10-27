%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 19 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_irc_sup).
-behaviour(supervisor).
-author('humasect@gmail.com').

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

-define(SERVER, ?MODULE).

%%%===================================================================
%%% API functions
%%%===================================================================

start_link() ->
    supervisor:start_link({local, ?SERVER}, ?MODULE, []).

%%%===================================================================
%%% Supervisor callbacks
%%%===================================================================

init([]) ->
    SupFlags = {one_for_one, 1, 3600},

%%    Connector = {zirc_conman, {zirc_conman, start_link, []},
%%                 permanent, 2000, worker, [zirc_conman]},

%%    ChanSup = {zen_ircchan_sup, {zirc_chan_sup, start_link, []},
%%               permanent, infinity, supervisor, [zirc_chan_sup]},

    {ok, {SupFlags, []}}.

%%%===================================================================
%%% Internal functions
%%%===================================================================
