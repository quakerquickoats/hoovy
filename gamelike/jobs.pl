%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(jobs, []).

%:- op(100,xfx,transcendsInto).

% FIXME: there are two MASONs.
job(atheist, mason, scientist).
job(gnostic, gypsy, summoner).
job(buddhist, zen, monk).
job(muslim, sufi, alchemist).
job(jewish, kabbalist, sage).
job(catholic, mason, sorcerer).
job(taoist, priest, magician).
job(hindu, guru, wizard).

class(scientist).
class(zen).
class(sufi).
class(kabbalist).
class(mason).


%%%%%%%%%5


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
