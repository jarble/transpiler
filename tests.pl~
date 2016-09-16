:- use_module(prolog/transpiler).
:- use_module(library(func)).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).

main :-
	File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
	writeln(Input),translate_langs(Input).
