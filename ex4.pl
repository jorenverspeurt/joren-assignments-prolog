% 

%weg(1,2,geel).
%weg(2,3,blauw).
%weg(1,3,geel).

weg(1,2,c).
weg(2,3,a).
weg(1,3,b).
weg(3,5,a).
weg(3,4,c).
weg(5,4,d).

% Gaat na of elke plaats een even aantal verbinindingen heeft
% en of elke plaats die X verbindingen heeft in 1 kleur ook minstens
% X verbindingen heeft in een andere kleur
check :-
    % Alle paden die ergens beginnen buiten 1
    findall(Start-Color
    ,(weg(Start,Finish,Color)
    ,Start=\=1)
    ,StartList),
    % Alle paden die ergens eindigen buiten 1
    findall(Finish-Color
    ,(weg(Start,Finish,Color)
    ,Finish=\=1)
    ,FinishList),
    append(StartList,FinishList,AllList),
    list_to_set(AllList,AllSet),
    % Vind voor alle plaatsen hoeveel paden ze van elke kleur hebben
    findall(Place-Color-Count
    ,(member(Place-Color,AllSet),count(Place-Color,AllList,0,Count))
    ,CountList),
    % Voor elke plaats elke kleur vergeleken met de som van andere kleuren
    findall(NumberC1-NumberOther
    ,(member(P-Cr1-NumberC1,CountList)
    ,findall(CtX,(member(P-CrX-CtX,CountList),CrX \== Cr1),OthersList)
    ,sum_list(OthersList,NumberOther))
    ,CompareList),
    % Als een knooppunt K, waarbij 1<K=<N, X verbindingen heeft met ...
    foreach(member(A-B,CompareList),A=<B),
    % Nakijken even aantal verbindingen (werkte niet met foreach...)
    findall(Mod
    ,(member(A-B,CompareList),C is A+B,Mod is C mod 2)
    ,ModList),
    \+ select(1,ModList,_).

% Tel het aantal voorkomens van P in de opgegeven lijst
count(_P,[],Count,Count).
count(P,[P|T],Acc,Count) :-
    NewAcc is Acc+1,
    count(P,T,NewAcc,Count).
count(P,[H|T],Acc,Count) :-
    \+ H == P,
    count(P,T,Acc,Count).

% De @<-kleinste rondrit langs alle wegen in ons wegennetwerk
tour(T) :-
    check,
    findall(weg(A,B,C),weg(A,B,C),Wegen),
    findall(Atour
    ,((weg(1,P,C);weg(P,1,C))
    ,(selectchk(weg(1,P,C),Wegen,Undriven);selectchk(weg(P,1,C),Wegen,Undriven))
    ,atour(Atour,[P-C],Undriven,P,C))
    ,Tours),
    member(T,Tours),
    selectchk(T,Tours,NTours),
    foreach(member(N,NTours),T @< N).

% Een manier om individuele Tours te genereren die achteraf getest worden
atour(T,Acc,[weg(A,B,C)],_PP,_PC) :-
    (A == 1 ; B == 1),
    append(Acc,[1-C],T).
atour(T,Acc,Undriven,PreviousPlace,PreviousColor) :-
    length(Undriven,L),
    L>=1,
    (member(weg(PreviousPlace,NextPlace,NextColor),Undriven)
    ;member(weg(NextPlace,PreviousPlace,NextColor),Undriven)),
    NextColor \== PreviousColor,
    append(Acc,[NextPlace-NextColor],NextAcc),
    (select(weg(PreviousPlace,NextPlace,NextColor),Undriven,NextUndriven)
    ;select(weg(NextPlace,PreviousPlace,NextColor),Undriven,NextUndriven)),
    atour(T,NextAcc,NextUndriven,NextPlace,NextColor).
    
