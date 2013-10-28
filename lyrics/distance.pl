% 
distance(F1,F2,Dist) :-
    combination(F1,F2,Comb),
    F1 \== F2,
    single(F1,S1),
    single(F2,S2),
    Min is min(S1,S2),
    Max is max(S1,S2),
    Dist is (Comb-Min)/Max.
% Distance defined for combinations of F's and clusters
distance(F,cluster(El1,El2),Dist) :-
    distance(F,El1,DFE1),
    distance(F,El2,DFE2),
    % Average linkage
    Dist is (DFE1+DFE2)/2.
    % Single linkage
    %Dist is min(DFE1,DFE2).
    % Complete linkage
    %Dist is max(DFE1,DFE2).
distance(cluster(El1,El2),F,Dist) :-
    distance(F,cluster(El1,El2),Dist).
distance(cluster(El1,El1),cluster(El3,El4 TODO

averagedistance(AD) :-
    findall(D,distance(_F1,_F2,D),Distances),
    sum_list(Distances,Sum),
    length(Distances,Length),
    AD is Sum/Length.

% If the number of elements in the Input accumulator is equal to
% Number (the wanted number of clusters in our hierarchical clustering
% of the inputs) then the Input is clustered so it is equal to
% the wanted FClusters structure.
clustered(FClusters,FClusters,Number) :-
    length(FClusters,Number).
% FClusters will be unified to a list consisting of elements that
% are either F's or clusters with a length equal to Number.
% The initial input should be the full list of F's.
% This Input then acts as a sort of reverse accumulator 
% (it decreases in size every step)
clustered(FClusters,Input,Number) :-
    length(Input,I),
    I>=Number,
    findall(Dist-El1-El2
    ,(member(El1,Input)
    ,member(El2,Input)
    ,F1\==El2
    ,distance(El1,El2,Dist))
    ,Dists),
    min_member(Dist-El1-El2,Dists),
    select(El1,Input,Input2),
    select(El2,Input2,Input3),
    clustered(FClusters,[cluster(El1,El2)|Input3],Number).
