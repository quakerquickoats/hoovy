:- module(gunzip, [ lowercase/1 ]).
:- use_foreign_library(foreign(gunzip)).

doSomething:-
    lowercase("hello").
