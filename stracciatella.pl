% 

% Modulo operatie zoals gespecifieerd in opgave 3
mod(X,Y,X) :-
    X<Y.
mod(X,Y,Z) :-
    X>=Y,
    NewX is X-Y,
    mod(NewX,Y,Z).

% Vanilla mini-meta-vertolker
vertolk((G1,G2)) :-
    !,
    vertolk(G1),
    vertolk(G2).
vertolk(true) :- !.
vertolk(Head) :-
    clause(Head,Body),
    vertolk(Body).

% Chocolade stukjes in de stracciatella
vertolk(is(X,Y)) :-
    X is Y.
vertolk('<'(X,Y)) :-
    X < Y.
vertolk('>='(X,Y)) :-
    X >= Y.
