:- module(switch, []).

compile_caselist(X, [K:Clause], (X = K -> Clause)) :- !.
compile_caselist(X, [K:Clause|CaseList], ((X = K -> Clause);Translated)) :-
    compile_caselist(X, CaseList, Translated).

:- multifile user:goal_expansion/2.
user:goal_expansion(F, G) :-
    F = switch(X, CaseList),
    compile_caselist(X, CaseList, G).

