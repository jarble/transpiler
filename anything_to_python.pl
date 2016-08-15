%Copyright 2016, Anderson Green

:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
:- compile(chrg).
:- chrg_option(show_rules, off).
:- chrg_symbols var_name/1, whitespace_token/0, ws/0, if_then/2.

%This implementation of ws is very slow. It should be improved somehow.

" " ::> whitespace_token.
"	" ::> whitespace_token.
whitespace_token,optional(ws) ::> ws.

"if",optional(ws),"(",optional(ws),var_name(X),optional(ws),")",optional(ws),"{",optional(ws),var_name(Y),optional(ws),"}" ::> if_then(java,[X,Y]),{writeln(""),writeln(X),writeln(Y)}.
[A] ::> var_name([A]).
end_of_CHRG_source.

main :- parse("if  (	A ){ B }").
