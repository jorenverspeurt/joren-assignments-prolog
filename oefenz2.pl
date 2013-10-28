% Prolog oefenzitting 2 

%Listlength/2 zonder tail recursion
listlength([],0).
listlength([_|Rest],Length) :-
    listlength(Rest,LengthRest),
    Length is LengthRest+1.
%Listlength/2 met tail recursion
listlength([],Acc,Acc).
listlength([_|Rest],Acc,Length) :-
    A is Acc+1,
    listlength(Rest,A,Length).

%Laatste element van een lijst
laatste([A],A).
laatste([_|Rest],A) :-
    laatste(Rest,A).

%Of 2e element vlak na eerste element komt
naast([A|[B|_Rest]],A,B).
naast([_C|Rest],A,B) :-
    naast(Rest,A,B).

%Vector som van 2 lijsten
vector_som([],[],[]).
vector_som([A|Rest1],[B|Rest2],[C|Rest3]) :-
    C is A+B,
    vector_som(Rest1,Rest2,Rest3).

%Geef voor gegeven sleutel de bijbehorende waarde uit lijst van paren
zoekop([paar(A,B)|_],A,B).
zoekop([_C|Rest],A,B) :-
    zoekop(Rest,A,B).

%Speciale rol van \+: als een query met \+ uitgevoerd wordt wordt de geleerde informatie weg gegooid na die query.

% Grafen
% ((Ook definieerbaar met knoop(member(_X,[a,b,c,d,e])) ?))
knoop(a).
knoop(b).
knoop(c).
knoop(d).
knoop(e).

boog(a,b).
boog(b,c).
boog(c,d).
boog(d,b).

buur(A,B):-
    boog(A,B)
    ;
    boog(B,A).

pad(A,B):-
    padMem(A,B,[A]).

padMem(A,B,Mem):-
    buur(A,B),
    \+ member(B,Mem)
    ;
    buur(X,A),
    \+ member(X,Mem),
    padMem(X,B,[X|Mem]).

% Fibonacci, naief
fib(0,0).
fib(1,1).
fib(N,F):-
    N > 1,
    Np is N-1,
    Npp is N-2,
    fib(Np,Fp),
    fib(Npp,Fpp),
    F is Fp+Fpp.

% Fibonacci, O(n) versie
onfib(0,0).
onfib(1,1).
onfib(N,F):-
    N > 1,
    onfib(0,1,N,F).

onfib(A,_B,0,A).
onfib(A,B,N,F):-
    N > 0,
    Nn is N-1,
    An is A+B,
    Bn is A,
    onfib(An,Bn,Nn,F).

% Gebalanceerde bomen
diepte(leeg,Acc,Acc).
diepte(knoop(L,_W,R),Acc,D) :-
    NewAcc is Acc+1,
    diepte(L,NewAcc,LD),
    diepte(R,NewAcc,RD),
    D is max(LD,RD).

gebalanceerd(leeg).
gebalanceerd(knoop(L,_W,R)) :-
    diepte(L,0,LD),
    diepte(R,0,RD),
    Diff is abs(LD-RD),
    Diff =<1,
    gebalanceerd(L),
    gebalanceerd(R).

voeg_in(leeg,A,knoop(leeg,A,leeg)).
voeg_in(knoop(L,W,R),A,knoop(NewL,W,R)) :-
    diepte(L,0,LD),
    diepte(R,0,RD),
    LD =< RD,
    voeg_in(L,A,NewL).
voeg_in(knoop(L,W,R),A,knoop(L,W,NewR)) :-
    diepte(L,0,LD),
    diepte(R,0,RD),
    LD > RD,
    voeg_in(R,A,NewR).

% Extra opdracht
% Opgelet! Als we maar 1 diepte bijhouden die van onder naar boven
% geupdate wordt loopt het mis na 6 nodes, de 7e wordt op de 
% verkeerde plaats toegevoegd.

todo.

% Expressief

eval(int(I),_,I).
eval(var(A),L,B) :-
    member(paar(A,B),L).
eval(plus(E1,E2),L,V3) :-
    eval(E1,L,V1),
    eval(E2,L,V2),
    V3 is V1+V2.
eval(maal(E1,E2),L,V3) :-
    eval(E1,L,V1),
    eval(E2,L,V2),
    V3 is V1*V2.
eval(macht(E1,E2),L,V3) :-
    eval(E1,L,V1),
    eval(E2,L,V2),
    V3 is V1**V2.
eval(min(E),L,V) :-
    eval(E,L,VE),
    V is -VE.

% Priemgetallen
% ((alle_priem blijft vreemd genoeg de zelfde lijst terug geven))
alle_priem(I,[]) :-
    I < 2.
alle_priem(I,L) :-
    I >= 2,
    alle_priem(2,I,[2],L).
alle_priem(Boven,Boven,L,L).
alle_priem(Onder,Boven,Acc,L) :-
    Onder < Boven,
    NOnder is Onder+1,
    ispriem(NOnder,Acc),
    reverse(Acc,RAcc),
    reverse([NOnder|RAcc],NewAcc),
    alle_priem(NOnder,Boven,NewAcc,L).
alle_priem(Onder,Boven,Acc,L) :-
    Onder < Boven,
    NOnder is Onder+1,
    \+ ispriem(NOnder,Acc),
    alle_priem(NOnder,Boven,Acc,L).
ispriem(_I,[]).
ispriem(I,[H|_T]) :-
    Half is I/2,
    H>Half.
ispriem(I,[H|T]) :-
    Div is I/H,
    \+ integer(Div),
    ispriem(I,T).
