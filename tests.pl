:-style_check(-singleton).
:- use_module(prolog/transpiler).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
:- use_module(library(prolog_stack)).
:- use_module(library(error)).

user:prolog_exception_hook(Exception, Exception, Frame, _):-
    (   Exception = error(Term)
    ;   Exception = error(Term, _)),
    get_prolog_backtrace(Frame, 20, Trace),
    format(user_error, 'Error: ~p', [Term]), nl(user_error),
    print_prolog_backtrace(user_error, Trace), nl(user_error), fail.

main :-
	File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
	writeln(Input),profile(translate_langs(Input)).
