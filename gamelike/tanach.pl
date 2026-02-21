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


%%%%%%%%%%%%%%%%%%%%%%%%%%

%Search for specific words:
%Since the text is stored as an atom, use sub_atom/5 to find occurrences.
%Example: Find every verse containing "Elohim":
%prolog

%?- verse(Ch, Vs, Text), sub_atom(Text, _, _, _, 'אֱלֹהִים').

%If you don't want to parse the .txt file every time you start Prolog, you can% save the currently loaded predicates to a fast-loading .pl file:
%prolog

%?- tell('genesis_processed.pl'), listing(verse/3), told.


%If you ever want to search without the vowels/accents, you can add a helper that filters the Text codes to only include characters in the range 0x05D0 to 0x05EA (the Hebrew alphabet).

% Standard Gematria Map
gematria('א', 1).   gematria('ב', 2).
 gematria('ג', 3).   gematria('ד', 4).
gematria('ה', 5).   gematria('ו', 6).
  gematria('ז', 7).   gematria('ח', 8).
gematria('ט', 9).   gematria('י', 10).
  gematria('כ', 20).  gematria('ל', 30).
gematria('מ', 40).  gematria('נ', 50).
 gematria('ס', 60).  gematria('ע', 70).
gematria('פ', 80).  gematria('צ', 90).
 gematria('ק', 100). gematria('ר', 200).
gematria('ש', 300). gematria('ת', 400).
% Sophit (Final) forms
gematria('ך', 20).  gematria('ם', 40).
 gematria('ן', 50).  gematria('ף', 80).
 gematria('ץ', 90).


% Calculate sum for a string (skips vowels/accents automatically)
text_gematria(Text, Total) :-
    atom_chars(Text, Chars),
    findall(V, (member(C, Chars), gematria(C, V)), Values),
    sum_list(Values, Total).

%%%%%%%%%%%%%

% base_val(Character, StandardValue, MisparGadolValue)
base_val('א', 1, 1).   base_val('ב', 2, 2).   base_val('ג', 3, 3).
base_val('ד', 4, 4).   base_val('ה', 5, 5).   base_val('ו', 6, 6).
base_val('ז', 7, 7).   base_val('ח', 8, 8).   base_val('ט', 9, 9).
base_val('י', 10, 10).  base_val('כ', 20, 20).  base_val('ל', 30, 30).
base_val('מ', 40, 40).  base_val('נ', 50, 50).  base_val('ס', 60, 60).
base_val('ע', 70, 70).  base_val('פ', 80, 80).  base_val('צ', 90, 90).
base_val('ק', 100, 100). base_val('ר', 200, 200). base_val('ש', 300, 300).
base_val('ת', 400, 400).

% Final Letters (Otiyot Sofiyot)
base_val('ך', 20, 500). % Final Khaf
base_val('ם', 40, 600). % Final Mem
base_val('ן', 50, 700). % Final Nun
base_val('ף', 80, 800). % Final Pe
base_val('ץ', 90, 900). % Final Tsadi

% calculate_gematria(+Text, +Mode, -Total)
calculate_gematria(Text, Mode, Total) :-
    atom_chars(Text, Chars),
    findall(Value, (
        member(Char, Chars),
        (   Mode == standard -> base_val(Char, Value, _)
        ;   Mode == gadol    -> base_val(Char, _, Value)
        )
    ), Values),
    sum_list(Values, Total).

%%%%%%%%%%%

% Find verses where the Gematria matches a TargetSum
find_by_gematria(TargetSum, Mode, Chapter, Verse) :-
    verse(Chapter, Verse, Text),
    calculate_gematria(Text, Mode, TargetSum).

concordance_search(Consonants, Ch, Vs) :-
    verse(Ch, Vs, Text),
    atom_codes(Text, Codes),
    % Filter out everything except letters (0x05D0 - 0x05EA)
    include(is_consonant, Codes, OnlyLetters),
    atom_codes(SearchTarget, OnlyLetters),
    sub_atom(SearchTarget, _, _, _, Consonants).

is_consonant(C) :- C >= 0x05D0, C =< 0x05EA.

random_verse :-
    findall(v(C, V, T), verse(C, V, T), All),
    random_member(v(Ch, Vs, Text), All),
    format('Today\'s Verse (~w:~w):~n~w~n', [Ch, Vs, Text]).
