%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(item,[default/1]).

default(I):-
	dict_create(I, item, [name:"Test", weight:1]).

equippable(_):-
	true.

consumable(_):-
	true.

useable(_):-
	true.

sellable(_{cost:N}):-
	N > 0.

item(equip, sword(weight:20, cost:100)).
item(food, potion(weight:2)).
item(food, apple(weight:1)).

%item(Name,Fields):-
%	default(Name).

