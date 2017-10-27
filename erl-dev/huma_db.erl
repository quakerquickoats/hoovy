%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%% 
%%% Mnesia helper functions.
%%%
%%% @end
%%% Created : 21 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(huma_db).
-author('humasect@gmail.com').

-export([show_table/1]).
-export([next_id/1, next_id/2]).
-export([init_table/3, init_table/4]).

%%%------------%
%%% json stuff %
%%%------------%

%jsonify([]) ->
%    {obj, []};
%jsonify(Props) ->
%    {obj, Props}.
%jsonify(Object, Fields) ->
%    {struct, Object}.

%%%===================================================================
%%% Tables
%%%===================================================================

next_id(Table) -> ?MODULE:next_id(Table, 0).
next_id(Table, Default) ->
    case mnesia:last(Table) of
        '$end_of_table' ->
            Default;
        Last -> Last + 1
    end.

show_table(Table) ->
    mnesia:transaction(
      fun() ->
              mnesia:foldl(fun(R, _NewAcc) ->
                                   io:format("~p~n", [R]) end,
                           ok, Table)
      end).
    
    %% {atomic,Users} = mnesia:transaction(
    %%                    fun() ->
    %%                            mnesia:read({login


%%%===================================================================
%%% Schema
%%%===================================================================

init_table(Table, Type, Fields) ->
    init_table(Table, Type, Fields, fun() -> ok end).
init_table(Table, Type, Fields, Transformer) ->
    ensure_schema(Table, Transformer,
                  [{attributes, Fields},
                   {type, Type},
                   {disc_copies, [node()]}]).

ensure_schema(Name, Transformer, Def) ->
    ensure_table(Name, Def),
    {_,Fields} = proplists:lookup(attributes, Def),
    maybe_transform(Name, Transformer, Fields).

ensure_table(Name, Def) ->
    % why get result? combine the two funs.
    Result = case fast_create_table(Name, Def) of
                 {atomic,ok} -> ok;
                 _ -> ok
             end,
    io:format("waiting for table '~p'...~n", [Name]),
    ok = mnesia:wait_for_tables([Name], 5000),
%  ok = mnesia:wait_for_tables ([ frag_table_name (TableName, N)
%                                || N <- lists:seq (1, num_frags (TableName)),
%                                  N > 1 ],
%                            infinity),
    Result.

fast_create_table(Name, Def) ->
    try mnesia:table_info(Name, type),
         {aborted, {already_exists, Name}}
    catch
        _ : _ -> mnesia:create_table(Name, Def)
    end.

maybe_transform(Name, Transformer, Fields) ->
    case mnesia:table_info(Name, attributes) =:= Fields of
        true -> ok;
        false ->
            io:format("update schema '~p'.~n", [Name]),
            mnesia:transform_table(Name, Transformer, Fields, Name)
    end.

