%%
%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(qbl,[]).

:- use_module(library(apply)).

letter(ש).

letters :-
    maplist([X]>>assertz(letter(X)), [a,b,c,d]).

vowel(C,vowels) :-
    char_type(C,alpha),
    ok.

genWord(english,W) :-
    string_chars(W, []).

