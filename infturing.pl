% Niet echt juist... niet deterministisch.

links([A-A,R-B],[A-A,NR-B]) :-
    lpush(R-B,'#',NR-B).
links([L-A,R-B],[NL-NA,NR-B]) :-
    lpop(R-B,E,NR-B),
    rpush(L-A,E,NL-NA).
rechts([L-A,B-B],[NL-NA,B-B]) :-
    rpush(L-A,'#',NL-NA).
rechts([L-A,R-B],[NL-NA,NR-B]) :-
    rpop(L-A,E,NL-NA),
    lpush(R-B,E,NR-B).
lees([_L-_A,B-B],'#').
lees([L-A,R-B],E) :-
    schrijf([L-A,R-B],E,[L-A,R-B]).
schrijf([L-A,B-B],E,[L-A,NR-NB]) :-
    rpush(B-B,E,NR-NB).
schrijf([L-A,R-B],E,[L-A,NR-B]) :-
    lpop(R-B,_A,RA-B),
    lpush(RA-B,E,NR-B).

rpush(X-Y,A,X-Z) :- Y = [A|Z].
rpop(X-Y,A,Z-Y) :- X = [A|Z].
lpush(X-Y,A,Z-Y) :- Z = [A|X].
lpop(X-Y,A,Z-Y) :- X = [A|Z].

leeg([A-A,B-B]).
