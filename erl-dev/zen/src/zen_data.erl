%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 17 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(zen_data).
-behaviour(gen_server).

%% API
-export([start_link/0]).
-export([generate_class/1, get_class_dicts/1]).
-export([get_text/2, reload/0]).

%% gen_server callbacks
-export([init/1, handle_call/3, handle_cast/2, handle_info/2,
         terminate/2, code_change/3]).

-define(SERVER, ?MODULE).
-record(state, {}).

%%%===================================================================
%%% API
%%%===================================================================

start_link() ->
    gen_server:start_link({local, ?SERVER}, ?MODULE, [], []).

generate_class(Type) ->
    gen_server:call(?SERVER, {generate_class, Type}).

get_class_dicts(Class) ->
    gen_server:call(?SERVER, {get_class_dicts, Class}).

reload() ->
    gen_server:call(?SERVER, reload).

get_text(Language, Key) ->
    gen_server:call(?SERVER, {get_text, Language, Key}).

%%%===================================================================
%%% gen_server callbacks
%%%===================================================================

init([]) ->
    reload_dbs(),
    {ok, #state{}}.

handle_call({generate_class, Type}, _From, State) ->
    Dict = get(Type),
    ClassD =
        [case huma_random:list_element(proplists:get_value(ListName, Dict)) of
             undefined -> undefined;
             {Name,_Info} -> Name;
             Name -> Name
         end || ListName <- [attributes, jobs, families]],
    {reply, list_to_tuple([Type|ClassD]), State}
        ;
handle_call({get_class_dicts, {Type,Attrib,Job,Family}}, _From, State) ->
    Dict = get(Type),
    Dicts = {
      %% any of these will give us 'true' for class tags with no properties.
      proplists:get_value(Attrib, proplists:get_value(attributes, Dict)),
      proplists:get_value(Job, proplists:get_value(jobs, Dict)),
      proplists:get_value(Family, proplists:get_value(families, Dict))
     },
    {reply, Dicts, State}
        ;
handle_call({get_text, english, Key}, _From, State) ->
    {reply, get_text_safely(Key, get(text_english)), State}
        ;
handle_call({get_text, japanese, Key}, _From, State) ->
    {reply, get_text_safely(Key, get(text_japanese)), State}
        ;
handle_call(reload, _From, State) ->
    reload_dbs(),
    {reply, ok, State}
        ;
handle_call(_Request, _From, State) ->
    {reply, ok, State}.

handle_cast(_Msg, State) -> {noreply, State}.
handle_info(_Info, State) -> {noreply, State}.
terminate(_Reason, _State) -> ok.
code_change(_OldVsn, State, _Extra) -> {ok, State}.

%%%===================================================================
%%% Internal functions
%%%===================================================================

get_text_safely(Key, Db) ->
    P = case proplists:get_value(Key, Db) of
        undefined -> proplists:get_value(no_text, Db);
        Text -> Text
    end,
    io:format("P = ~w~n", [P]),
    P.

consult_db(Name) ->
    Filename = code:priv_dir(zen) ++ "/" ++ atom_to_list(Name) ++ ".db",
    file:consult(Filename).

load_db(Name) ->
    {ok,Dict} = consult_db(Name),
    put(Name, Dict),
    Len = length(Dict),
    Counts = if
                 Len > 4 -> {Name, Len};
                 Len < 5 -> [{element(1, C), length(element(2, C))}
                             || C <- Dict]
             end,
    io:format("**** van_data:load_db() ~p: ~p~n", [Name, Counts]).

reload_dbs() ->
    lists:foreach(fun load_db/1,
                  [item,
                   character,
                   monster,
                   map,
                   text_english,
                   text_japanese]).

