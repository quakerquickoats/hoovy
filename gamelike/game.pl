%%
%%%% Generation
%%

% god_name
% religion_name
% book_name
% mystical_book_names
% enemy_name
% tree_of_life_name
% secular_book_names
% secular_country_names
% country_name

% temples, etc.

%%
%%%% Player
%%

job(novice, 0, 0, 0, 0, 0).
job(merchant).
job(archer).
job(soldier).
job(theif).
job(acolyte).
job(mage).

jobStats(novice, S):- S = status{str:0, dex:0, agi:0, int:0, luk:0}.
jobStats(merchant, S):- S = status{str:0, dex:0, agi:0, int:0, luk:1}.
jobStats(archer, S):- S = status{str:0, dex:1, agi:0, int:0, luk:0}.
jobStats(soldier, S):- S = status{str:1, dex:0, agi:0, int:0, luk:0}.
jobStats(thief, S):- S = status{str:0, dex:0, agi:1, int:0, luk:0}.
jobStats(acolyte, S):- S = status{str:0, dex:1, agi:0, int:0, luk:0}.

player:-
	inventory(I),
	status(S),
	[I,S].

%%
%%%% Actor
%%

isDead(HP):-
	HP < 1.

equipSlots:-
	[head,body,arms,leftHand,rightHand,face,legs,feet,back].

status([]).

inventory([]).

takeItem(Item):-
	inventory(I),
	asserta(inventory([Item|I])).

%%
%%%% Battle
%%

% strength, speed
% wisdom, ego
% intellect, size
% 

statNames:-
	[str,dex,agi,int,luk].
statNames:-
	[str,dex,agi,int,luk,ego].

elementTypes:-
	[earth,water,fire,wind,spirit].

%%
%%%% Mob
%%

actorMobType:-
	[mammal,zombie,undead,robot,machine,reptile].

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Persistence
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

save:-
	open("game.save",write,Stream),
	with_output_to(Stream,listing(player)),
	close(Stream).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%% Map
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

cellTypes:-
	[floor,water,wall,upSlope,downSlope,warp].

actorTypes:-
	[player,enemy,friend,warp].

start:-
	write("Gamelike"),
	nl.
