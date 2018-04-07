%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(game,[]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_server_files)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_head)).
:- use_module(library(http/html_write)).
:- use_module(library(http/js_write)).

:- multifile
	   user:file_search_path/2,
	   http:location/2.
:- dynamic
	   user:file_search_path/2.

:- prolog_load_context(directory, Dir),
   asserta(user:file_search_path(app, Dir)).

http:location(files, root(.), []).
user:file_search_path(files, '.').

%:- http_handler(files(.), serve_files_in_directory(.), [prefix]).
:- http_handler(files(.), http_reply_from_files('.', []), [prefix]).
%:- http_handler(root(.), serve_files_in_directory(files), [prefix]).
:- http_handler(root(test), a_handler, []).
:- http_handler(/, http_reply_file('index.html', []), []).
   
% :- http_handler(/, http_redirect(moved_temporarily, root('index.html')), []).

:- multifile
	   user:body//2,
	   user:head//2.

user:body(hoovy_style, Body) -->
	html(body([% div(id=top, h1('Gamelike')),
			   div([align=center, id=content], Body),
			   div(align=right, p('(c) 2018 Lyndon Tremblay'))
			  ])).

user:head(hoovy_style, Head) -->
	html(head([title('Hoovy Studio'),
			   % 'https://raw.github.com/ondras/rot.js/master/rot.min.js'
			   \html_requires(files('_rot.min.js')),
			   \html_requires(files('game.js')),
			   \html_requires(files('style.css')),
			   Head])).

a_handler(_Request) :-
    reply_html_page(
		hoovy_style,
        [],
        []).

%%%%%%

start:-
	write("Gamelike..."), nl,
	config:port(Port),
	http_server(http_dispatch, [port(Port)]).

stop:-
	config:port(Port),
	http_stop_server(Port, []).
