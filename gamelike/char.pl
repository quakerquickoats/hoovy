%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(char,[defaultStatus/1,
				isDead/1]).

:- use_module(library(record)).

:- record status(
	   level:integer=1,
	   hp:integer=1,
	   sp:integer=0,
	   xp:integer=0,
	   str:integer=0,
	   agi:integer=0,
	   dex:integer=0,
	   int:integer=0,
	   luk:integer=0).

%statusLevelMod(chi,

buildStatus(S,Level):-
	defaultStatus(D),
	Str is D{str},
	S = status{level:Level, str:Str}.

new(Char,Name,Stats):-
	Char = char{name:Name, status:Stats}.

isDead(_{status:{hp:HP}}):-
	HP < 1.

%%%%%%%%%%%%%%%%%%%%%%%%

% strength, speed
% wisdom, ego
% intellect, size
% 

actorMobType:- [mammal,zombie,undead,robot,machine,reptile].

element(chi,Name,Stat):-
	Name = earth,
	Stat = str.
element(sui,Name,Stat):-
	Name = water,
	Stat = dex.
element(hi,Name,Stat):-
	Name = fire,
	Stat = agi.
element(ki,Name,Stat):-
	Name = wind,
	Stat = int.
element(mu,Name,Stat):-
	Name = spirit,
	Stat = luk.

statNames:- [str,dex,agi,int,luk].

equipSlots:- [head,body,arms,leftHand,rightHand,face,legs,feet,back].

takeItem(Item):-
	inventory(I),
	asserta(inventory([Item|I])).

%%%%%%%%%%%%%%%%%%%%

generateName(C) :-
	FirstNames = [job,david,moshe,abraham,jacob,isaac],
	LastNames = [israel,benjamin,levi,dan,asher],
	random_member(A,FirstNames),
	random_member(B,LastNames),
	C = (A,B).

makePlayer(P):- generateName(N),
				random_member(E, [chi,sui,hi,ki,mu]),
				Level is 1,
				buildStatus(Level,S),
				P = char{name:N,
						 element:E,
						 job:novice,
						 status:S}.
