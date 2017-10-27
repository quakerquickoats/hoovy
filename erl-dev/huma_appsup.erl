%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 28 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(huma_appsup).
-author('humasect@gmail.com').

%% -behaviour(application).
%% -export([start/2, stop/1]).

%% -behaviour(supervisor).
%% -export([init/1]).

-export([behaviour_info/1]).

behaviour_info(callbacks) ->
    [{start, 0}];
behaviour_info(_) ->
    undefined.
