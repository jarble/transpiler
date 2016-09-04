:- use_module(prolog/transpiler).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).

main :- translate('function add($a,$b){return $a + $b;}',prolog,X),writeln(X).

