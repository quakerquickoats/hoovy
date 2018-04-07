%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(world,[]).

:- use_module(library(persistency)).
:- persistent
   seed(atom),
   map(dict),
   monster(dict),
   item(dict).

%   item(name:atom,
%		cost:positive_integer,
%		weight:positive_integer).

attach :-
	db_attach("save.db",[]).

sync :-
	db_sync(update).

detach :-
	db_detach.

%%%%%%%%%%%%%%%%%%%%%%

language(treeOfLife, holyBook, motherLand).

treeOfLife(above,shin,heaven).  % sea of names
holyBook(middle,aleph,heart).  % humankind, MDL - (m-dalet) - gate
motherLand(below,mem,ocean).   % MEM-ory. sea of MEMEs.

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

god_name(elohim).
god_name(allah).
god_name(buddha).

%%%%%%%%%%%%%%%%%%%%%%

generate_with_seed(Seed) :-
	%atom_string(Name,NameS),
	%string_concat(NameS,".db",Filename),
	db_attach("world.db",[]),
	assert_seed(Seed),
	ok.

generate :-
	fail,
	getrand(Seed),  % this is quite large, takes a full 1/2 screen to print. later.
	generate_with_seed(Seed).

