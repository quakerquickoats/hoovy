/********************
                     
  Gamelike  (c) 2025   Lyndon Tremblay
    
*********************/

:- module(world, []).

:- use_module(library(record)).

:- record monster(name:atom, hp:integer).

:- use_module(library(persistency)).
:- persistent
       seed(atom),
       monster(monster),
       item(dict).

/*
cellTypes:-
	[floor,water,wall,upSlope,downSlope,warp].

actorTypes:-
	[player,enemy,friend,warp].
*/

attach:-db_attach("database.world",[]).
sync:-db_sync(update).
detach:-db_detach.

generate:-
    fail,
    getrand(Seed),
    assert(seed,Seed).


add_monster(Name, HP):-
    assert_monster(monster(name(Name), hp(HP))).

add_item(Name, Gold):-
    assert_item({name: Name, gold: Gold}).
