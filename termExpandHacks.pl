% 
% A few hacks that implement predicates that are built-ins in
% SICStus 3 - so that we can use them in SICstus 4 and SWI

:- multifile user:term_expansion/6.
:- multifile user:term_expansion/2.

user:term_expansion((term_expansion(X,Y):-B), _, Ids, OutTerm, _, [oldTermExpand|Ids]) :- 
    nonmember(oldTermExpand, Ids),
    OutTerm = ((   user:term_expansion(X, _, Ids2, Y, _, Ids2):- 
                        call(B),
                        !)),
    !.

user:term_expansion((term_expansion(X,Y)), _, Ids, OutTerm, _, [oldTermExpand|Ids]) :- 
    nonmember(oldTermExpand, Ids),
    OutTerm = ((   user:term_expansion(X, _, Ids2, Y, _, Ids2):- 
                        !)),
    !.


find_constraint(X,_):- chr:find_chr_constraint(X).
