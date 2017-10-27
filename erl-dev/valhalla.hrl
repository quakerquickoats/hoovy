%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created :  7 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------

-include("huma.hrl").

%%-type(class() :: {atom(), atom(), atom()}).
%%-record(class, {attribute, job, family}).

%%------------%%
%% Map        %%
%%------------%%

-define(CELL_DEF,
        tile = 0,
        item_id,
        char_id,
        action).

-record(wall, {?CELL_DEF}).
-record(floor, {?CELL_DEF}).
-record(warp, {?CELL_DEF}).

-type(map_index() :: {integer(), integer()}).
-type(map_cell() :: empty | #wall{} | #floor{} | #warp{}).

-record(val_map,
        {id,
         cells = dict:new() % dictionary()
        }).

%%--------------%%
%% Actor        %%
%%--------------%%

-define(MAX_PLAYER_INVENTORY, 24).
-define(MAX_MONSTER_INVENTORY, 1).
-define(MAX_STORAGE, 80).

-record(item,
        {amount=1 :: pos_integer(),
         status=normal :: normal | cursed | blessed,
         cost=0 :: uinteger(),
         charge_cost=0 :: uinteger(),
         weight=1 :: uinteger()
        }).

-record(char_stats,
        {hp, max_hp,
         sp, max_sp,
         str, int, dex, agi, luk}).

-define(CHAR_DEF,
        base_level={1,0},
        stats :: #char_stats{},
        condition=normal :: normal|asleep|confused|poison|mute,
        inventory=[] :: [#item{}],
        equipment=[] :: [#item{}]).

-record(monster, {?CHAR_DEF}).
-record(character, {?CHAR_DEF}).
-record(player, {?CHAR_DEF,
                 party_id=0 :: uinteger(),
                 job_level={1,0}
                }).

-record(val_actor,
        {id :: uinteger(),
         class,
         dict :: [#item{} | #character{} | #monster{} | #player{}]
        }).

%%-------------%%
%% Game        %%
%%-------------%%

-record(world,
        {
          id :: uinteger(),
          seed = random:seed() :: seed()
        }).
