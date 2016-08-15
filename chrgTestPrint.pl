%% borrowed from Hyprolog

% This file defines a test print facilities that may be switched on by the user.


%%%test_print_chr_code(T):- showing_internal_rules -> chr_pp_top(T), ! ; true.

chr_pp_top((A,B)):- !,chr_pp_top(A), chr_pp_top(B).
chr_pp_top([]):- !.
chr_pp_top([A|B]):- !,chr_pp_top(A), chr_pp_top(B).

chr_pp_top(A):-
    nl,
    mk_variant(A,AV), numbervars(AV,0,_),
    chr_pp(AV),nl.

chr_pp((:- Stuff)):- !, write(:-), write(' '), write(Stuff), write('.'),nl.
chr_pp((Label @ Rule)):- !,
  writeq(Label), write(' @'),
  chr_pp(Rule).

chr_pp((H :- B)):- !,
  writeq(H), write(' :-'), nl,
  pp_chr_body(indent,4,B),write('.'),nl.


chr_pp((H==> G | B pragma P)):- !,
  writeq(H), write(' ==>'), nl,
  write_blanks(4), writeq(G), nl,
  write('  |'),nl,
  pp_chr_body(indent, 4,B),nl,
  write('  pragma '), writeq(P), write('.'),nl.

chr_pp((H==> G | B)):- !,
  writeq(H), write(' ==>'), nl,
  write_blanks(4), writeq(G), nl,
  write('  |'),nl,
  pp_chr_body(indent,4,B), write('.'),nl.

chr_pp((H==> B pragma P)):- !,
  writeq(H), write(' ==>'), nl,
  pp_chr_body(indent,4,B),nl,
  write('  pragma '), writeq(P), write('.'),nl.

chr_pp((H==> B)):- !,
  writeq(H), write(' ==>'), nl,
  pp_chr_body(indent,4,B),write('.'),nl.

chr_pp((H<=> G | B pragma P)):- !,
  writeq(H), write(' <=>'), nl,
  write_blanks(4), writeq(G), nl,
  write('  |'),nl,
  pp_chr_body(indent, 4,B),nl,
  write('  pragma '), writeq(P), write('.'),nl.

chr_pp((H<=> G | B)):- !,
  writeq(H), write(' <=>'), nl,
  write_blanks(4), writeq(G), nl,
  write('  |'),nl,
  pp_chr_body(indent,4,B), write('.'),nl.

chr_pp((H<=> B pragma P)):- !,
  writeq(H), write(' <=>'), nl,
  pp_chr_body(indent,4,B),nl,
  write('  pragma '), writeq(P), write('.'),nl.

chr_pp((H<=> B)):- !,
  writeq(H), write(' <=>'), nl,
  pp_chr_body(indent,4,B),write('.'),nl.

chr_pp((constraints C)):- !,
    writeq(constraints),nl,
    % following reuse is a hack
    pp_chr_body(indent, 4, C),write('.'),nl.
    
chr_pp(X):- writeq(X),write('.'),nl.


pp_chr_body(Cond, Blanks, (A,B)):- !,
    pp_chr_body(Cond, Blanks, A), write(','), nl, pp_chr_body(indent, Blanks, B).

pp_chr_body(Cond, Blanks, (A;B)):- !,
    write_blanks(Cond, Blanks), write('( '), Blanks2 is Blanks+2,
    pp_chr_body(noIndentFirstLine, Blanks2,A), nl,
    write_blanks(indent,Blanks), write(' ;'),nl,
    pp_chr_body(indent, Blanks2,B), write(' )').

pp_chr_body(Cond, Blanks, (A->B)):- !,
    write_blanks(Cond, Blanks),
    write('('), writeq(A), 
%%%    write('(('), writeq(A), write(')'),
    nl, write_blanks(Blanks), write('->  '), writeq(B), write(')').

pp_chr_body(Cond, Blanks, catch_fail(W,B)):- !,
    write_blanks(Cond, Blanks),
    write('catch_fail('), writeq(W), write(',('),nl,
    Blanks2 is Blanks+2,
    pp_chr_body(indent,Blanks2,B), write('))').
    
pp_chr_body(Cond, Blanks,X):- write_blanks(Cond, Blanks), writeq(X).

write_blanks(N):- write_blanks(indent,N).
write_blanks(noIndentFirstLine,_):- !.
write_blanks(_,0):- !.
write_blanks(C,N):- write(' '), N1 is N-1, write_blanks(C,N1).

