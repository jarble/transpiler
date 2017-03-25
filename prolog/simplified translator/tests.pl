:- use_module(transpiler).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
:- use_module(library(prolog_stack)).
:- use_module(library(error)).

user:prolog_exception_hook(Exception, Exception, Frame, _) :-
    (   Exception = error(Term)
    ;   Exception = error(Term, _)),
    get_prolog_backtrace(Frame, 20, Trace),
    format(user_error, 'Error: ~p', [Term]), nl(user_error),
    print_prolog_backtrace(user_error, Trace), nl(user_error), fail.

%list_of_langs(['javascript','java','c#','php','lua','ruby','perl','python','haxe','c++','c','erlang','prolog']).
list_of_langs(['javascript','php','java','ruby']).

main :-
	read_file_to_codes('javascript_source.js',Input,[]),
    list_of_langs(Langs),
    %test_statement(Input,python,'java').
    %Statements_to_test = [Input,"b = math.acos(3)","in_arr = 3 in [1,2,3]","randomly_chosen = random.choice([1,2,3])", "str1 = str2.join([\"hi\",\"hi\"])", "str_arr = str1.split(str2)", "a_string += \"stuff\"","a_string=str1.replace(str2,str3)","bool_var = (3 != 4)","string_var = (\"3\" != \"4\")","a+=1","a*=1","a-=1","a*=1"],
    %Statements_to_test = [Input,"b = (3)**(2)","z=math.sqrt(1)","a=math.asin(3)","a=math.acos(3)","a=math.atan(3)"],
    Statements_to_test = [Input],
    profile(test_statements_in_langs(Statements_to_test,'javascript',Langs)).

write_to_file(Text,File_name) :-
	open(File_name,write,Stream),
	write(Stream,Text),
	close(Stream).

test_statements_in_langs(Statements,Lang1,[A]) :-
	test_statements(Statements,Lang1,A).

test_statements_in_langs(Statements,Lang1,[A|B]) :-
	test_statements(Statements,Lang1,A),!,test_statements_in_langs(Statements,Lang1,B).

test_statements([A],Lang1,Lang2) :-
	test_statement(A,Lang1,Lang2).
test_statements([A|B],Lang1,Lang2) :-
	test_statement(A,Lang1,Lang2),!,test_statements(B,Lang1,Lang2).
    
test_statement(Input,Lang1,Lang2) :-
	writeln('\n'),
	writeln([translate,Lang1,to,Lang2]),
    atom_codes(Input1,Input),
    atom_chars(Input1,Input2),
    transpiler:translate(Lang1,Lang2,Input2,Output),!,atom_chars(Output1,Output),writeln(Output1),write_output_to_file(Lang2,Output1).

write_output_to_file(perl,Text) :-
	write_to_file(Text,'perl_source.pl').
write_output_to_file(java,Text) :-
	write_to_file(Text,'java_source.java').
write_output_to_file(javascript,Text) :-
	write_to_file(Text,'javascript_source.js').
write_output_to_file(php,Text) :-
	write_to_file(Text,'php_source.php').
write_output_to_file(lua,Text) :-
	write_to_file(Text,'lua_source.lua').
write_output_to_file('c++',Text) :-
	write_to_file(Text,'cpp_source.cpp').
write_output_to_file('scala',Text) :-
	write_to_file(Text,'scala_source.txt').
write_output_to_file('erlang',Text) :-
	write_to_file(Text,'erlang_source.txt').
write_output_to_file('c',Text) :-
	write_to_file(Text,'c_source.c').
write_output_to_file('ruby',Text) :-
	write_to_file(Text,'ruby_source.rb').
