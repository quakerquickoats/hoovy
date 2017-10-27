%%%-------------------------------------------------------------------
%%% @author Lyndon Tremblay <humasect@gmail.com>
%%% @copyright (C) 2010, Lyndon Tremblay
%%% @doc
%%%
%%% @end
%%% Created : 25 Aug 2010 by Lyndon Tremblay <humasect@gmail.com>
%%%-------------------------------------------------------------------
-module(huma_random).
-author('humasect@gmail.com').
-used_by([{hoovy, val}]).

-export([letter/0, word/1, list_element/1]).

letter() ->
    High = $z, Low = $a,
    random:uniform(High - Low) + Low.

word(Length) ->
    word(Length, []).
word(0, List) ->
    List;
word(N, List) ->
    [letter() | word(N-1, List)].

list_element([]) ->
    undefined;
list_element(List) ->
    lists:nth(random:uniform(length(List)), List).
