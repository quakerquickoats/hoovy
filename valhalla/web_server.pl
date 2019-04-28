%%
%% Valhalla
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(web_server,[]).
:- use_module(library(http/thread_httpd)).
:- use_module(library(http/http_dispatch)).
:- use_module(library(http/http_session)).
:- use_module(library(http/http_server_files)).
:- use_module(library(http/http_files)).
:- use_module(library(http/html_head)).
:- use_module(library(http/html_write)).
:- use_module(library(http/js_write)).
:- use_module(library(pengines)).

:- multifile
	   user:file_search_path/2,
       http:location/2,
	   http:location/3.
:- dynamic
	   user:file_search_path/2.

%%%%%%%%%%%%%%%%%%%%%%%%%%%

http:location(js, '/js', []).
http:location(css, '/css', []).
http:location(img, '/img', []).
user:file_search_path(css, './css').
user:file_search_path(js, './js').
user:file_search_path(icons, './icons').

:- html_resource(style, [virtual(true),
                         requires([css('style.css')]),
                         mime_type(text/css)]).
:- html_resource(script, [virtual(true),
                          requires([js('interact.js')]),
                          mime_type(text/javascript)]).
:- html_resource(jquery, [virtual(true),
                          requires([js('jquery.js')]),
                          mime_type(text/javascript)]).
:- html_resource(pengines_script,
                 [virtual(true),
                  requires([root('pengine/pengines.js')]),
                  mime_type(text/javascript)]).

:- http_handler(js(.), http_reply_from_files('js/', []),
		        [priority(1000), prefix]).
:- http_handler(css(.), http_reply_from_files('css/', []),
                [priority(1000), prefix]).
:- http_handler(img(.), http_reply_from_files('icons/', []),
                [priority(1000), prefix]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%

:- http_handler(/, game_handler, []).

game_handler(_Request) :-
	reply_html_page(
			[title('Valhalla')
			 %,link([href('https://fonts.g'), rel(stylesheet)], [])
			],
			\minesweeper_page).

minesweeper_page -->
	html([div(id(codeliketext),
		  [\html_requires(style),
		   \html_requires(jquery),
		   \html_requires(pengines_script),
		   \html_requires(script),
		   code(b('***************  Valhalla  ******************')),
		   code('AN INTERACTIVE-FICTION GAME')
		  ])
         ]).

%%%%%%%%%%%%%%%%%%%%%%%%%%%

start:-
    write("Valhalla ...."), nl,
    Port is 8099,
	http_set_session_options([timeout(1800),
                              create(auto),
                              enabled(true)]),
	http_server(http_dispatch, [port(Port), timeout(180)]).

stop:-
    Port is 8099,
    http_stop(Port, []).
