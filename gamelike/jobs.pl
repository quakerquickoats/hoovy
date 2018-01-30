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
