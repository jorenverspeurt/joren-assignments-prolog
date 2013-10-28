% 
diepte(leeg,0).
diepte(knoop(L,_W,R),D) :-
    diepte(L,DL),
    diepte(R,DR),
    D is max(DL,DR)+1.

diepte_acc(leeg,Acc,Acc).
diepte_acc(knoop(L,_W,R),Acc,D) :-
    NewAcc is Acc+1,
    diepte_acc(L,NewAcc,DL),
    diepte_acc(R,NewAcc,DR),
    D is max(DL,DR).
