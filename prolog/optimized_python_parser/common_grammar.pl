string_literal("") --> "\"\"".
string_literal(S) --> "\"",string_inner(S),"\"".
string_literal1("") --> "\'\'".
string_literal1(S) --> "\'",string_inner1(S),"\'","\'\''",{S=""}.
string_inner([A]) --> string_inner_(A).
string_inner([A|B]) --> string_inner_(A),string_inner(B).
string_inner_(A) --> {A="\\\""},A;{dif(A,'"'),dif(A,'\n')},[A].
string_inner1([A]) --> string_inner1_(A).
string_inner1([A|B]) --> string_inner1_(A),string_inner1(B).
string_inner1_(A) --> {A="\\'"},A;{dif(A,'\''),dif(A,'\n')},[A].

ws --> "";ws_.
ws_ --> (" ";"\n";"\r"),ws.

python_ws --> "";python_ws_.
python_ws_ --> (" ";"\t"),python_ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> csym(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.
csym(Let)     --> [Let], {code_type(Let, csym)}.

a_double([A,B]) -->
        (an_int(A), ".", an_int(B)).
a_double([A,['0']]) -->
        (an_int(A)).
an_int([L|Ls]) --> digit(L), an_int_r(Ls).
an_int_r([L|Ls]) --> digit(L), an_int_r(Ls).
an_int_r([])     --> [].
digit(Let)     --> [Let], { code_type(Let, digit) }.
