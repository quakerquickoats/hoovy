%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 29 Sep 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(val).
-author('humasect@gmail.com').

%% API
-export([init_db/0]).
-export([create_actor/2]).

-include("valhalla.hrl").

%%%===================================================================
%%% Actors
%%%===================================================================

create_actor(GameId, Dict) ->
    ok.

destroy_actor(ActorId) ->
    ok.

list_actors() ->
    mnesia:transaction(fun() -> mnesia:match_object(#val_actor{_='_'}) end).

%%%===================================================================
%%% Database
%%%===================================================================

make_hubble_town_t() ->
    Cells = [
             {{-10,-10}, #wall{}},
             {{-10, 10}, #wall{}},
             {{ 10, 10}, #wall{}},
             {{ 10,-10}, #wall{}}
            ],
    mnesia:write(#val_map{id = hubble_town,
                          cells = dict:from_list(Cells)}).

init_db() ->
    ?init_table(val_actor, ordered_set),
    ?init_table(val_map, ordered_set),

    %% make Hubble Town
    {atomic,ok} = mnesia:transaction(fun make_hubble_town_t/0).
