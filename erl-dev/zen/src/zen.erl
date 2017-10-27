%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 27 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen).
-author('humasect@gmail.com').

%% API
-export([start_all/0, stop_all/0,
         init_db/0, make_all_docs/0]).
-export([create_account/4,
         destroy_account/1,
         list_accounts/0]).

-include("zen_account.hrl").
-include("mod_auth.hrl").

%%%===================================================================
%%% API
%%%===================================================================

start_all() ->
    mnesia:start(),
    inets:start(),
    application:load(zen),
    zen_web:start(),
    application:start(zen).

stop_all() ->
    application:stop(zen),
    zen_web:stop(),
    inets:stop(),
    mnesia:stop().

make_all_docs() ->
    lists:foreach(fun user_default:mkdoc/1, [zen, vre, val]).

%%%===================================================================
%%% Accounts
%%%===================================================================

create_account(Login, Password, Name, Group) ->
    F = fun() ->
                case mnesia:match_object(#account{login=Login, _='_'}) of
                    [] -> ok;
                    _ -> mnesia:abort(id_already_exists)
                end,

                Id = huma_db:next_id(account),
                mnesia:write(#account{id=Id,
                                      login=Login, password=Password,
                                      name=Name
                                     }),
                Id
        end,

    case mnesia:transaction(F) of
        {atomic,Id} ->
            zen_web:add_user(Id, Login, Password, Group);
        Else -> Else
    end.

list_accounts() ->
    mnesia:transaction(
      fun() -> mnesia:match_object(#account{_='_'}) end).

destroy_account(Id) ->
    %% @todo
    %% - kick user out of game.
    %% - remove account actor
    mnesia:transaction(fun() -> mnesia:delete({account,Id}) end),
    zen_web:delete_user(Id).

%%%===================================================================
%%% Database
%%%===================================================================

init_db() ->
    ?init_table(httpd_user, bag),
    ?init_table(httpd_group, bag),
    ?init_table(account, ordered_set,
                fun
                    ({account, Id, Login, Password, Name, Language,
                      _Games, _Nothing,
                      CreateTime, LastTime, LastIp, AuthCount}) ->
                        #account{id=Id,
                                 login=Login, password=Password,
                                 name=Name,
                                 language=Language,
                                 games=[],
                                 create_time=CreateTime,
                                 last_time=LastTime,
                                 last_ip=LastIp,
                                 auth_count=AuthCount}
                end),

    %% ウーザを追加
    %% make sure we have some accounts.
    ?MODULE:create_account("dev", "dev", "Developer", dev),
    ?MODULE:create_account("humasect", "sect0huma", "Lyndon Tremblay", player),
    ok.

%%%===================================================================
%%% Internal functions　内部の関数
%%%===================================================================

-ifdef(nothing_spectacular).

make_world_t(Id) ->
    case mnesia:read({world, Id}) of
        [] ->
            mnesia:write(#world{
                            id = Id
                           }),
            {ok,Id};
        _Else -> already_exists
    end.

make_actor_t(WorldId, Location, Class) ->
    Id = huma_db:next_id(actor),
    mnesia:write(#actor{
                    id = Id,
                    room_id = WorldId,
                    location = Location,
                    class = Class
                   }),
    Id.

add_user(Name, Password) -> add_user(Name, Password, ?USER_ID).
add_user(Name, Password, StartId) ->
    mnesia:transaction(
      fun() ->
              make_user_t(Name, Password, StartId)
      end).

add_actor(Id) ->
    {error, not_implemented}.

delete_world_t(Id) ->
    mnesia:delete({world, Id}).

delete_user_t(Id) ->
    [L|_] = mnesia:read({login, Id}),
    mnesia:delete({actor, L#login.actor_id}),
    mnesia:delete({login, Id}).

remove_user(Id) ->
    mnesia:transaction(
      fun() ->
              delete_world_t(Id),
              delete_user_t(Id)
      end).
-endif.

