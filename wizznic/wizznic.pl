% 
rune(y).
rune(n).
rune(s).
rune(o).

stack(X,Ylist,0) :-
    stack_i(X,Ylist).
stack(X,Ylist,T) :-
    Tm is T-1,
    stack(X,Ylist,Tm),
    \+ move(X,Ylist,_,_,Tm),
    \+ move(_,_,X,Ylist,Tm).


move(X1,Ylist1,X2,Ylist2,T) :-
    .

solved(I_Field,Steps,E_Field) :-
    foreach(member(E,E_Field),(foreach(member(EBlock,E),EBlock=empty))).
