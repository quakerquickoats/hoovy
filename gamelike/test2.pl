 :- dynamic verse/3.

% Run: ?- load_tanach('Genesis.txt').
load_tanach(File) :-
    retractall(verse(_, _, _)),
    setup_call_cleanup(
        open(File, read, Stream, [encoding(utf8)]),
        process_lines(Stream),
        close(Stream)
    ).

process_lines(Stream) :-
    read_line_to_codes(Stream, Codes),
    (   Codes == end_of_file -> true
    ;   (   \+ is_metadata(Codes), parse_and_store(Codes) -> true ; true ),
        process_lines(Stream)
    ).

% Skip lines starting with xxxx (code 120)
is_metadata([120, 120, 120, 120|_]).
is_metadata([8234, 120, 120, 120, 120|_]). % Metadata with LRE marker

parse_and_store(Codes) :-
    % 1. Filter only digits, the Sof Pasuq (1475), and the actual Hebrew text
    % This ignores RLE, PDF, and all types of spaces
    include(is_important, Codes, Clean),
    
    % 2. Split at the Sof Pasuq (׃)
    append(V_Codes, [1475|Remainder], Clean),
    
    % 3. The Remainder starts with Chapter digits. 
    % We find where the digits end to separate Chapter from Text.
    span_digits(Remainder, C_Codes, Text_Codes),
    
    % 4. Safe conversion to numbers
    number_codes(V, V_Codes),
    number_codes(C, C_Codes),
    atom_codes(Text, Text_Codes),
    
    % 5. Assert into the database
    assertz(verse(C, V, Text)).

% Keep only Hebrew, Digits, and the Separator
is_important(C) :- code_type(C, digit).
is_important(1475). % Sof Pasuq
is_important(C) :- C >= 0x0590, C =< 0x05FF. % Hebrew block

% Splits a list into (Digits, Rest)
span_digits([C|Cs], [C|Ds], Rest) :- code_type(C, digit), !, span_digits(Cs, Ds, Rest).
span_digits(Rest, [], Rest).
