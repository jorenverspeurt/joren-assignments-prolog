% Booleaanse logica met predicaten en atomen
% ((Al de eval(_,onwaar) kunnen ook geschreven worden met \+ en de waar vorm))
eval(waar,waar).
eval(onwaar,onwaar).
eval(not(A),waar) :-
    eval(A,onwaar).
eval(not(B),onwaar) :-
    eval(B,waar).
eval(and(A,B),waar) :-
    eval(A,waar),
    eval(B,waar).
eval(and(A,B),onwaar) :-
    eval(A,onwaar)
    ;
    eval(B,onwaar).
eval(or(A,B),waar) :-
    eval(A,waar)
    ;
    eval(B,waar).
eval(or(A,B),onwaar) :-
    eval(A,onwaar),
    eval(B,onwaar).
