%%
%% Gamelike
%%
%% (c) 2026 Lyndon Tremblay
%%

:- module(tanach,[bookFileName/2
                 ]).

:- use_module(library(readutil)).

books :- ["Genesis"].

bookFileName(Book,FileName) :-
    string_lower(Book,LBook),
    string_concat(LBook, ".txt", Ext),
    string_concat("./tanach/", Ext, FileName).

%readBook(Book) :-
%    .

%convertToProlog(Book) :-
%    .

file_lines(File, Lines) :-
    read_file_to_string(File, Content, []),
    % Split the single string by newline characters (\n)
    split_string(Content, "\n", "", Lines).

testGen(Lines) :-
    bookFileName("Genesis", FileName),
    file_lines(FileName, Lines).

%%%%%%%%%%%%%%%%%%%%

:- use_module(library(dcg/basics)).

% Main predicate to read file, ignoring % comments
read_file_no_comments(File, Lines) :-
    phrase_from_file(lines(AllLines), File),
    exclude(is_comment_line, AllLines, Lines).

% DCG to parse file into lines
lines([]) --> call(eos), !.
lines([Line|Lines]) -->
    line(Line),!,
    lines(Lines).

% A line is characters up to newline, or empty
line(String) -->
    string_without("\n", Codes),
    %string_without("\r", Codes),
    (   "\n" ; call(eos) ),
    !,
    { string_codes(String, Codes) }.

% Check if a string is a comment
is_comment_line(Line) :-
    sub_string(Line, 0, _, _, "\u202Axxxx"). % Catches lines starting with %

% End of Stream
eos([], []).
