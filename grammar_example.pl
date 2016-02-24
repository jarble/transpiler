:- set_prolog_flag(double_quotes, chars).
whitespace --> [Space], { char_type(Space, space) }, whitespace.
whitespace --> [].

symbol([L|Ls]) --> letter(L), symbol_r(Ls).

symbol_r([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.

% similarly for numbers

token(tkSym(Token)) --> symbol(Token).

tokenize([Token|Tokens]) --> whitespace, token(Token), !, tokenize(Tokens).
tokenize([]) --> whiteSpace.
