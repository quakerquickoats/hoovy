%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 17 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_sup).
-author('humasect@gmail.com').
-behaviour(supervisor).

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
    TcpPort = zen_app:get_env(tcp_port),
    WebSocketPort = zen_app:get_env(websocket_port),

    {ok, {{one_for_one, 1, 6000},
     [
      %% @todo zen_logger

      %% acceptors
      {zen_acceptor_tcp, {zen_acceptor, start_link,
                          [zen_acceptor_tcp, TcpPort]},
       permanent, 2000, worker, [zen_acceptor]},

      {zen_acceptor_web, {zen_acceptor, start_link,
                          [zen_acceptor_web, WebSocketPort]},
       permanent, 2000, worker, [zen_acceptor]},

      %% interfaces (web, irc)
      {zen_irc_sup, {zen_irc_sup, start_link, []},
       permanent, infinity, supervisor, [zen_irc_sup]},

      {zen_data, {zen_data, start_link, []},
       permanent, 2000, worker, [zen_data]},

      {zen_session_sup, {zen_session_sup, start_link, []},
       permanent, infinity, supervisor, [zen_session_sup]}
     ]}
    }.

%%%===================================================================
%%% Internal functions
%%%===================================================================
