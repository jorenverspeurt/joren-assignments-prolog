vader(anton,bart).
vader(anton,daan).
vader(anton,elisa).

moeder(celine,bart).
moeder(celine,daan).
moeder(celine,gerda).
moeder(gerda,hendrik).

sibling(X,Y):-vader(V,X),vader(V,Y),moeder(M,X),moeder(M,Y),X\==Y.
voorvader(X,Y):-
    vader(Z,Y),
    voorvader(X,Z).
voorvader(X,Y):-vader(X,Y).
