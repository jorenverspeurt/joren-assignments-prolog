% Oplossing van het N-Queens probleem
queens(N,List) :-
    % Genereer permutaties van [1..N]
    queenpermutation(N,List),
    % Hervorm tot paren van elementen van 1..N in volgorde 
    % en de elementen van List in volgorde
    orderedXY(List,Pairs,[],1),
    % Kijk na of er geen diagonale inconsistenties zijn
    checkDiagonals(Pairs).

% Vindt permutaties van de lijst die de rij 1..N bevat
queenpermutation(N,L) :-
    findall(Y,between(1,N,Y),L1),
    permutation(L1,L).

checkDiagonals([[_X,_Y]]).
checkDiagonals(OrderedXY) :-
    OrderedXY = [[X1,Y1]|T],
    findall(attack
        ,(member([X2,Y2],T)
        ,pairForDiagonal(X1,Y1,X2,Y2))
        ,Attacks),
    Attacks == [],
    checkDiagonals(T).

pairForDiagonal(X1,Y1,X2,Y2) :-
    C1 is Y1+X1,
    C2 is Y2+X2,
    D1 is Y1-X1,
    D2 is Y2-X2,
    (C1 =:= C2
    ;
    D1 =:= D2).

orderedXY([HIn|[]],Out,BuildOut,LastX) :-
    append(BuildOut,[[LastX,HIn]],Out).

orderedXY([HIn|TIn],Out,BuildOut,X) :-
    \+ TIn = [],
    append(BuildOut,[[X,HIn]],NextBuild),
    NextX is X+1,
    orderedXY(TIn,Out,NextBuild,NextX).
