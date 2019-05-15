%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(edit,[]).

resources(
	% fire! PRINT, activity
	sin,
	sound,
	simulation,
	% AI! EVAL, execution
	air,   
	actors,
	asserts,
	% water! READ, world
	mem,
	malkot,  %<- managers, methods?
	maps).

% 3x3 aleph,shin,mem
resourceFolders(actors,actions,assets,
				sounds,scripts,sprites,
				messages,maps,methods).

