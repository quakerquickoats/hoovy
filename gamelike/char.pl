%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(char,[default_status/1,
				is_dead/1]).

default_status(S):-
	S = status{level:1,
			   hp:1, sp:0, xp:0,
			   str:1, agi:1, dex:1, int:1, luk:1}.

status(S,Str,Agi,Dex,Int,Luk):-
	S = status{str:Str, agi:Agi, dex:Dex, int:Int, luk:Luk}.

new(Char,Name,Level,Stats):-
	Char = char{name:Name, level:Level, status:Stats}.

is_dead(_{status:{hp:HP}}):-
	HP < 1.
