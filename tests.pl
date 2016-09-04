:- use_module(prolog/transpiler).
:- use_module(library(func)).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).

main :-
	File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
	writeln(Input),translate_langs(Input),
	
	writeln('\n\nTranslated from PHP and JavaScript:\n\n'),
	writeln(translate $('function add($a,$b){return $a + $b;}',prolog)),
	writeln(translate $('class example{constructor(a,b){this.a = a + 1; this.b = b + 1;}}','perl')).
