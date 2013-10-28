% 
doceert(berbers,bs).
doceert(berbers,iw).
doceert(demoen,ab).
doceert(demoen,cc).
doceert(holvoet,bvp).
doceert(moens,bvp).
doceert(de_schreye,ai).
doceert(bruynooghe,ai).
doceert(dedecker,socs).

volgt(tom,bs).
volgt(tom,bvp).
volgt(tom,socs).
volgt(maarten,socs).
volgt(maarten,bs).
volgt(pieter,bvp).

volgt_zelfde_vak_dup(X,Y) :-
    volgt(X,A),
    volgt(Y,A),
    \+ X=Y.

doceert_zelfde_vak_dup(X,Y) :-
    doceert(X,A),
    doceert(Y,A),
    \+ X=Y.

doceert_meerdere_vakken_dup(X) :-
    doceert(X,A),
    doceert(X,B),
    \+ A=B.

volgt_zelfde_vak(X,Y) :-
    findall(A-B,volgt_zelfde_vak_dup(A,B),Lijst),
    list_to_set(Lijst,Set),
    member(X-Y,Set).

doceert_zelfde_vak(X,Y) :-
    findall(A-B,doceert_zelfde_vak_dup(A,B),Lijst),
    list_to_set(Lijst,Set),
    member(X-Y,Set).

doceert_meerdere_vakken(X) :-
    findall(A,doceert_meerdere_vakken_dup(A),Lijst),
    list_to_set(Lijst,Set),
    member(X,Set).
