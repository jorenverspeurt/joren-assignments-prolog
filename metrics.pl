% Analyze metrics from ckjm
% metric(pktop-pkbottom-class+inner,WMC,DIT,NOC,CBO,RFC,LCOM,AC,NPM).

treeForm(Tree) :-
    findall(metric(X,W,D,N,C,R,L,A,N),metric(X,W,D,N,C,R,L,A,N),All),
    makeTree(All,[],Tree).
% Base case
makeTree([],Tree,Tree).
% Head is metric van top-level klasse, direct toevoegen
makeTree([metric(X,W,D,N,C,R,L,A,N)|T],L,Tree) :-
    \+ X = XP-XC,
    makeTree(T,[[metric(X,W,D,N,C,R,L,A,N)]|L],Tree).
% Head is metric van deel v.e. package (subpackage of klasse),
% toevoegen op laagst mogelijke punt
makeTree([metric(X,W,D,N,C,R,L,A,N)|T],L,Tree) :-
    countHierarchyDepth(X,1,Depth),
    Depth > 1,
    makeTreeInsert(metric(X,W,D,N,C,R,L,A,N),L,1,Depth,NewL),
    makeTree(T,NewL,Tree).

% Base case: dit is de max depth, lijst leeg, hier toevoegen
makeTreeInsert(M,[],D,D,[M]).
% Base case: max depth, lijst bevat elementen, 
% head is niet gegeven metric
makeTreeInsert(metric(X,W,D,N,C,R,L,A,N),[H|T],D,D,NewL) :-
    H = metric(XH,WH,DH,NH,CH,RH,LH,AH,NH),
    \+ X = XH,
    makeTreeInsert(metric(X,W,D,N,C,R,L,A,N),T,D,D,NewT),
    NewL = [H|NewT].
% Base case: max depth, lijst bevat elementen,
% head is gegeven metric (met valse info, impliciet)
makeTreeInsert(metric(X,W,D,N,C,R,L,A,N),[metric(X,_,_,_,_,_,_,_,_)|T]
    ,D,D,[metric(X,W,D,N,C,R,L,A,N)|T]).
% 
makeTreeInsert(M,[],CurD,TotD,[M|EmptyHier]) :-
    M = metric(X,W,D,N,C,R,L,A,N),
    
    
    member(M,L),
    member(

countHierarchyDepth(Name,Depth,Depth) :-
    \+ Name = N1-N2.
% Acc should be initially 1
countHierarchyDepth(Name1-Name2,Acc,Depth) :-
    \+ Name1 = N1-N2,
    NAcc is Acc+1,
    countHierarchyDepth(Name2,NAcc,Depth).

