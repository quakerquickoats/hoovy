%% Gamelike
%%
%% (c) 2018 Lyndon Tremblay
%%

:- module(qabala,[]).

letters(L) :-
	L = [aleph,gimel,beth].

letter(a,1).
letter(b,2).
letter(g,3).
letter(d,4).
letter(e,5).
letter(w,6).
letter(z,7).
letter(h,8).
letter(t,9).

letter(i,10).
letter(k,20).
letter(l,30).
letter(m,40).
letter(n,50).
letter(o,60).
letter(y,70).
letter(p,80).
letter(c,90).

letter(q,100).
letter(r,200).
letter(s,300).
letter(x,400).
letter('K',500).
letter('M',600).
letter('N',700).
letter('P',800).
letter('C',900).

letterValues :-
	numlist(1,9,Ten),
	[1,2,3,4,5,6,7,8,9,
	 10,20,30,40,50,60,70,80,90,
	 100,200,300,400,500,600,700,800,900].

letter('a') :- 

letterValues(String,Values):-
	maplist(letter,string_codes(String),Values).
