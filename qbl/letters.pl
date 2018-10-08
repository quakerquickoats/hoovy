%% Qabala
%%
%% (c) 2018 Lyndon Tremblay
%%

:- encoding(utf8).
:- module(qabala,[letters/1,
                  values/1,
                  letterValue/2]).

letters(L) :-
	L = [alef,beth,gimel,dalet,he,waw,zayn,chet,tet,
         yod,kaf,lamed,mem,nun,samek,ayin,peh,cadi,
         qof,resh,shin,tau,'Kaf','Mem','Nun','Peh','Cadi'].

blah :- [a,b,c,d].

values(V) :-
	V = [1,2,3,4,5,6,7,8,9,
	     10,20,30,40,50,60,70,80,90,
	     100,200,300,400,500,600,700,800,900].

letterValue(L,V) :-
    letters(Ls),
    values(Vs),
    nth0(N,Ls,L).
%    nth0(N,Vs,V),
%    V.

letter(alef,C) :- C = (1,(yod,waw,yod)).

alef(1,'a').
beth(2,'b').
gimel(3,'g').
dalet().

alef([yod,waw,yod]).
beth([resh,waw]).

letters(1) :- alef.
letters(2) :- alef, alef.
letters(2) :- beth.
letters(3) :- alef, alef, alef.
letters(3) :- alef, beth.
letters(3) :- gimel.

letters(26) :- yod, he, waw, he.

%%%%%%%%%%%%%%%%%%%%

letter(alef,1).
letter(beth,2).
letter(gimel,3).
letter(dalet,4).
letter(he,5).
letter(waw,6).
letter(zayn,7).
letter(chet,8).
letter(tet,9).

letter(yod,10).
letter(kaf,20).
letter(lamed,30).
letter(mem,40).
letter(nun,50).
letter(samek,60).
letter(ayin,70).
letter(peh,80).
letter(cadi,90).

letter(qof,100).
letter(resh,200).
letter(shin,300).
letter(tau,400).
letter('Kaf',500).
letter('Mem',600).
letter('Nun',700).
letter('Peh',800).
letter('Cadi',900).

letterValues(String,Values):-
	maplist(letter,string_codes(String),Values).
