%
peano_plus(nul,X,X).
peano_plus(s(X),Y,s(Z)) :-
    peano_plus(X,Y,Z).

peano_min(X,nul,X).
peano_min(s(X),s(Y),Z) :-
    peano_min(X,Y,Z).

groter_dan(s(X),Y) :-
    X=Y.
groter_dan(s(X),Y) :-
    groter_dan(X,Y).

maximum(X,Y,X) :-
    groter_dan(X,Y).

maximum(X,Y,Y) :-
    groter_dan(Y,X).

alternatieve_min(X,Y,Z) :-
    peano_plus(Z,Y,X).

maal(_X,nul,nul).
maal(X,s(Y),Z) :-
    peano_min(Z,X,A),
    maal(X,Y,A).

deel(X,Y,D,R) :-
    groter_dan(Y,R),
    peano_plus(A,R,X),
    maal(D,Y,A).
