% This is a program that translates several programming languages into several other languages.

:- use_module(library(prolog_stack)).
:- use_module(library(error)).
:- use_module(library(pio)).

user:prolog_exception_hook(Exception, Exception, Frame, _) :-
    (   Exception = error(Term)
    ;   Exception = error(Term, _)),
    get_prolog_backtrace(Frame, 20, Trace),
    format(user_error, 'Error: ~p', [Term]), nl(user_error),
    print_prolog_backtrace(user_error, Trace), nl(user_error), fail.


:- [library(dialect/sicstus)
   ].


:- initialization(main).
:- set_prolog_flag(double_quotes,chars).
% :- [library(dcg/basics)].

namespace(Data,Data1,Name1,Indent) :-
	Data = [Lang,Is_input,Namespace,Var_types,Indent,Lang2],
	Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent),Lang2].

offside_rule_langs(X) :-
	X = ['python','cython','coffeescript','cosmos','cobra'].

prefix_arithmetic_langs(X) :-
	X = ['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'].

optional_indent(Data,Indent) -->
	{Data = [Lang|_],
	offside_rule_langs(Offside_rule_langs)},
	{memberchk(Lang,Offside_rule_langs)}->
		Indent;
	(Indent;"").

main :- 
   File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
   writeln(Input),translate_langs(Input).

%Use this rule to define operators for various languages

file_extension(Data) -->
	langs_to_output(Data,file_extension,[
	['java']:
		"java",
	['python']:
		"py",
	['javascript']:
		"js",
	['c++']:
		"cpp",
	["perl","prolog"]:
		"pl"
]).

infix_operator(Symbol,Exp1,Exp2) -->
        Exp1,python_ws,Symbol,python_ws,Exp2.

prefix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        "(",Symbol,ws_,expr(Data,Type,Exp1),ws_,expr(Data,Type,Exp2),")".


% this is from http://stackoverflow.com/questions/20297765/converting-1st-letter-of-atom-in-prolog
first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    upcase_atom(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).

langs_to_output(Data,Name,[]) -->
	{not_defined_for(Data,Name),true}.

langs_to_output(Data,Name,[Langs:Output|Rest]) -->
	{
		Data = [Lang|_]
	},
	({memberchk(Lang,Langs)}->
		Output;
	langs_to_output(Data,Name,Rest)).

	
%replace memberchk with langs_to_output
var_name(Data,Type,A) -->
        {Data = [Lang|_],dif(A,"end"),dif(A,"return"),dif(A,"def")},
        ({memberchk(Lang,['engscript', 'visual basic .net', 'python', 'ruby', 'lua', 'cosmos', 'englishscript','vbscript','polish notation','reverse polish notation','wolfram','pseudocode','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','clojure','haxe','coffeescript','dart','javascript','c#','haskell','c','gambas','common lisp','scheme','rebol','f#'])}->
                symbol(A);
        {memberchk(Lang,['php','perl','bash','tcl','autoit','perl 6','puppet','hack','awk','powershell'])}->
                ({Lang=perl,Type=[array,_]}->
                    "@",symbol(A);
                {Lang=perl,Type=[dict,_]}->
                    "%",symbol(A);
                "$",symbol(A));
        {memberchk(Lang,[prolog,erlang,picat,logtalk]),atom_string(B,A), first_char_uppercase(B, C),atom_chars(C,D)}->
            symbol(D);
        {not_defined_for(Data,'var_name')}),
        {is_var_type(Data, A, Type)}.

function_name(Data,Type,A,Params) -->
        symbol(A),{is_var_type(Data,[A,Params], Type)}.


indent(Indent) --> (Indent,("\t")).


else(Data,Return_type,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        optional_indent(Data,Indent),langs_to_output(Data,else,[
        ['clojure']:
                (":else",ws_,A),
        ['fortran']:
                ("ELSE",ws_,A),
        ['hack','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc']:
                ("else",ws,"{",ws,A,(Indent;ws),"}"),
        ['seed7','ruby','lua','livecode','janus','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#']:
                ("else",ws_,A),
        ['erlang']:
                ("true",ws,"->",ws,A),
        ['wolfram','prolog']:
                (A),
        ['z3']:
                (A),
        ['python','cython']:
                ("else",python_ws,":",python_ws,A),
        ['monkey x','vbscript','visual basic .net']:
                ("Else",ws_,A),
        ['rebol']:
                ("true",ws,"[",ws,A,ws,"]"),
        ['common lisp']:
                ("(",ws,"t",ws_,A,ws,")"),
        ['pseudocode']:
                (("otherwise",ws_,A);
                ("else",ws_,A);
                ("else",ws,"{",ws,A,(Indent;ws),"}")),
        ['polish notation']:
                ("else",ws_,A),
        ['reverse polish notation']:
                (A,ws_,"else")
        ]).


first_case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
    {
            indent_data(Indent,Data,Data1),
            B=statements(Data1,Return_type,Statements_),
            Compare_expr = expr(Data,bool,compare(int,Switch_expr,Expr_)),
            Expr = expr(Data,int,Expr_),
            
            Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
    },
    optional_indent(Data,Indent),
    langs_to_output(Data,first_case,[
    [julia,octave]:
            ("if",ws_,Compare_expr,ws_,"then",ws_,B,ws_,Case_or_default),
    [javascript,d,java,'c#',c,'c++',typescript,dart,php,hack]:
			("case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default),
    [go,haxe,swift]:
            ("case",ws_,Expr,ws,":",ws,B,ws,Case_or_default),
    [fortran]:
            ("CASE",ws,"(",ws,Expr,ws,")",ws_,B),
    [rust]:
            (Expr,ws,"=>",ws,"{",ws,B,ws,Case_or_default,(Indent;ws),"}"),
    [haskell,erlang,elixir,ocaml]:
            (Expr,ws,"->",ws,B,ws,Case_or_default),
    [clips]:
            ("(",ws,"case",ws_,Expr,ws_,"then",ws_,B,ws,Case_or_default,ws,")"),
    [scala]:
            ("case",ws_,Expr,ws,"=>",ws,B,ws,Case_or_default),
    [rebol]:
            (Expr,ws,"[",ws,B,ws,Case_or_default,"]"),
    [octave]:
            ("case",ws_,Expr,ws_,B,ws,Case_or_default),
    [clojure]:
            ("(",ws,Expr,ws_,B,ws,Case_or_default,ws,")"),
    [pascal,delphi]:
            (Expr,ws,":",ws,B,ws,Case_or_default),
    [chapel]:
            ("when",ws_,Expr,ws,"{",ws,B,ws,Case_or_default,(Indent;ws),"}"),
    [wolfram]:
            (Expr,ws,",",ws,B,ws,Case_or_default)
        ]).
case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A = expr(Data,bool,compare(int,Switch_expr,Expr_)),
                Expr = expr(Data,int,Expr_),
                Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
        },
    optional_indent(Data,Indent),
    langs_to_output(Data,case,[
    [julia,octave]:
            ("elsif",ws_,A,ws_,"then",ws_,B,ws,Case_or_default),
    [javascript,d,java,'c#',c,'c++',typescript,dart,php,hack]:
            ("case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default),
    [go,haxe,swift]:
            ("case",ws_,Expr,ws,":",ws,B,ws,Case_or_default),
    [fortran]:
            ("CASE",ws,"(",ws,Expr,ws,")",ws_,B,ws,Case_or_default),
    [rust]:
            (Expr,ws,"=>",ws,"{",ws,B,(Indent;ws),"}",ws,Case_or_default),
    [haskell,erlang,elixir,ocaml]:
            (Expr,ws,"->",ws,B,ws,Case_or_default),
    [clips]:
            ("(",ws,"case",ws_,Expr,ws_,"then",ws_,B,ws,")"),
    [scala]:
            ("case",ws_,Expr,ws,"=>",ws,B),
    [rebol]:
            (Expr,ws,"[",ws,B,ws,"]",ws,Case_or_default),
    [octave]:
            ("case",ws_,Expr,ws_,B,ws,Case_or_default),
    [clojure]:
            ("(",ws,Expr,ws_,B,ws,")",ws,Case_or_default),
    [pascal,delphi]:
            (Expr,ws,":",ws,B,ws,Case_or_default),
    [chapel]:
            ("when",ws_,Expr,ws,"{",ws,B,(Indent;ws),"}",ws,Case_or_default),
    [wolfram]:
            (Expr,ws,",",ws,B)
    ]).

default(Data,Return_type,int,Statements_) -->
        {
                indent_data(Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        optional_indent(Data,Indent),
        langs_to_output(Data,default,[
        ['fortran']:
            ("CASE",ws_,"DEFAULT",ws_,A),
        ['javascript','d','c','java','c#','c++','typescript','dart','php','haxe','hack','go','swift']:
            ("default",ws,":",ws,A),
        ['pascal','delphi']:
            ("else",ws_,A),
        ['haskell','erlang','ocaml']:
            (ws,ws,"->",ws_,A),
        ['rust']:
            (ws,ws,"=>",ws,A),
        ['clips']:
            ("(",ws,"default",ws_,A,ws,")"),
        ['scala']:
            ("case",ws_,ws,"=>",ws,A),
        ['rebol']:
            ("][",A),
        ['octave']:
            ("otherwise",ws_,A),
        ['chapel']:
            ("otherwise",ws,"{",ws,A,(Indent;ws),"}"),
        ['clojure']:
            (A),
        ['wolfram']:
            (ws,ws,",",ws,A)
        ]).



elif_or_else(Data,Return_type,[A]) --> elif(Data,Return_type,A).
elif_or_else(Data,Return_type,[A|B]) --> elif(Data,Return_type,A),ws(Data),elif_separator(Data),ws(Data),elif_or_else(Data,Return_type,B).

elif_separator([Lang|_]) -->
	{Lang = 'prolog'} -> ";";statement_separator([Lang|_]).

indent_data(Indent,Data,Data1) :-
    Data = [Lang,Is_input,Namespace,Var_types,Indent,Lang2],
    Data1 = [Lang,Is_input,Namespace,Var_types,indent(Indent),Lang2].

elif(Data,Return_type,[Expr_,Statements_]) -->
        {
                indent_data(Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A=expr(Data,bool,Expr_)
        },
        optional_indent(Data,Indent),langs_to_output(Data,elif,[
        ['d','e','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe']:
            ("else",ws_,"if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
        ['rust','go','englishscript']:
            ("else",ws_,"if",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
        ['php','hack','perl']:
            ("elseif",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
        ['julia','octave']:
            ("elseif",ws_,A,ws_,B),
        ['ruby']:
			("elsif",ws_,A,ws_,"then",ws_,B),
		['lua']:
			("elseif",ws_,A,ws_,"then",ws_,B),
        ['monkey x','visual basic','visual basic .net']:
            ("ElseIf",ws_,A,ws_,B),
        ['seed7']:
            ("elsif",ws_,A,ws_,"then",ws_,B),
        ['perl 6']:
            ("elsif",ws_,A,ws_,"{",ws,B,(Indent;ws),"}"),
        ['picat']:
            ("elseif",ws_,A,ws_,"then",ws_,B),
        ['erlang']:
            (A,ws,"->",ws,B),
        ['prolog']:
            (A,ws,"->",ws,B),
        ['r','f#']:
            (A,ws,"<-",ws,B),
        ['minizinc','ocaml','haskell','pascal','maxima','delphi','f#','livecode']:
            ("else",ws_,"if",ws_,A,ws_,"then",ws_,B),
        ['python','cython']:
            ("elif",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B),
        ['fortran']:
            ("ELSE",ws_,"IF",ws_,A,ws_,"THEN",ws_,B),
        ['rebol']:
            (A,ws,"[",ws,B,ws,"]"),
        ['common lisp']:
            ("(",ws,A,ws_,B,ws,")"),
        ['wolfram']:
            ("If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,(Indent;ws),"]"),
        ['polish notation']:
            ("elif",ws_,A,ws_,B),
        ['reverse polish notation']:
            (A,ws_,B,ws_,C,ws_,"elif"),
        ['clojure']:
            (A,ws_,B,ws_,C)
        ]).
is_var_type([_,_,Namespace,Var_types,_,_], Name, Type) :-
    memberchk([[Name|Namespace],Type1], Var_types), Type = Type1.

%also called optional parameters
default_parameter(Data,[Type1,Name1,Default1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name(Data,Type1,Name1),
                Value = var_name(Data,Type1,Default1)
        },
        langs_to_output(Data,default_parameter,[
        ['autohotkey','julia','nemerle','php','javascript']:
            (Name,python_ws,"=",python_ws,Value),
        ['c#','d','groovy','c++']:
            (Type,ws_,Name,ws,"=",ws,Value),
        ['dart']:
            ("[",ws,Type,ws_,Name,ws,"=",ws,Value,ws,"]"),
        ['scala','swift']:
            (Name,python_ws,":",python_ws,Type,python_ws,"=",python_ws,Value),
        ['haxe']:
            ("?",ws,Name,ws,"=",ws,Value)
        ]).

parameter(Data,[Type1,Name1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name(Data,Type1,Name1)
        },
        langs_to_output(Data,parameter,[
        ['pseudocode']:
                (("in",ws_,Type,ws,":",ws,Name;
                Type,ws_,Name;
                Name,ws,":",ws,Type;
                Name,ws_,Type;
                "var",ws_,Type,ws,":",ws,Name;
                Name,ws,"::",ws,Type;
                Type,ws,"[",ws,Name,ws,"]";
                Name,ws_,("As";"as"),ws_,Type)),
        ['seed7']:
            ("in",ws_,Type,ws,":",ws,Name),
        ['c#','java','englishscript','ceylon','algol 68','groovy','d','c++','pawn','pike','vala','c','janus']:
            (Type,ws_,Name),
        ['haxe','dafny','chapel','pascal','rust','genie','hack','nim','typescript','gosu','delphi','nemerle','scala','swift']:
            (Name,ws,":",ws,Type),
        ['go','sql']:
            (Name,ws_,Type),
        ['minizinc']:
            ("var",ws_,Type,ws,":",ws,Name),
        ['haskell','python','ruby','lua','hy','perl 6','cosmos','polish notation','reverse polish notation','scheme','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','r','bc']:
            (Name),
        ['julia']:
            (Name,ws,"::",ws,Type),
        ['rebol']:
            (Type,ws,"[",ws,Name,ws,"]"),
        ['openoffice basic','gambas','visual basic .net']:
            (Name,ws_,"As",ws_,Type),
        ['visual basic']:
            (Name,ws_,"as",ws_,Type),
        ['perl']:
            ("my",ws_,Name,ws,"=",ws,"push",ws,";"),
        ['wolfram']:
            (Name,"_"),
        ['z3']:
            ("(",ws,Name,ws_,Type,ws,")")
        ]).


varargs(Data,[Type1,Name1]) -->
        {
                Type = type(Data,Type1),
                Name = var_name(Data,Type1,Name1)
        },
    langs_to_output(Data,varargs,[
    ['java']:
        (Type,ws,"...",ws_,Name),
    ['php']:
        ("",ws,Type,ws,"...",ws_,"$",ws,Name),
    ['c#']:
        ("params",ws_,Type,ws,"[",ws,"]",ws_,Name),
    ['perl 6']:
        ("*@",Name),
    ['scala']:
        (Name,ws,":",ws,Type,ws,"*"),
    ['go']:
        (Name,ws,"...",ws,Type)
    ]).

enum_list_separator(Data) -->
        langs_to_output(Data,enum_list_separator,[
        [pseudocode]:
                (",";";"),
        ['java','seed7','vala','c++','c#','c','typescript','fortran','ada','scala']:
                ",",
        ['haxe']:
                ";",
        ['go','perl 6','swift']:
                ws_
        ]).

parameter_separator(Data) -->
        langs_to_output(Data,parameter_separator,[
        ['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','perl']:
                ws_,
        ['pseudocode','python','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic']:
                ","
        ]).



%these parameters are used in a function's definition
optional_parameters(Data,A) --> "",parameters(Data,A).
parameters(Data,[A]) --> parameter(Data,A);default_parameter(Data,A);varargs(Data,A).
parameters(Data,[A|B]) --> parameter(Data,A),python_ws,parameter_separator(Data),python_ws,parameters(Data,B).

function_call_parameters(Data,[Params1_],[[Params2_,_]]) -->
        parentheses_expr(Data,Params2_,Params1_).
function_call_parameters(Data,[Params1_|Params1__],[[Params2_,_]|Params2__]) -->
        (parentheses_expr(Data,Params2_,Params1_),function_call_parameter_separator(Data),function_call_parameters(Data,Params1__,Params2__)).

function_call_parameter_separator([Lang|_]) -->
    {Lang = 'perl'}->
        ",";
    parameter_separator([Lang|_]).

type(Data,auto_type) -->
        langs_to_output(Data,auto_type,[
        ['c++']:
                "auto",
        [c]:
                "__auto_type",
        [java,'gnu smalltalk']:
                "Object",
        ['c#']:
                "object",
        ['pseudocode']:
                ("object";"Object";"__auto_type";"auto")
        ]).

type(Data,regex) -->
        langs_to_output(Data,regex,[
        ['javascript']:
                "RegExp",
        ['c#','scala']:
                "Regex",
        ['c++']:
                "regex",
        ['python']:
                "retype",    
        ['java']:
                "Pattern",
        ['haxe']:
                "EReg",
        ['pseudocode']:
                ("EReg";"Pattern";"RegExp";"regex";"Regex")
        ]).

type(Data,[dict,Type_in_dict]) -->
        langs_to_output(Data,dict,[
        ['python']:
                "dict",
        [javascript,java]:
                "Object",
        [c]:
            "__auto_type",
        ['c++']:
            "map<string,",type(Data,Type_in_dict),">",
        ['haxe']:
            "map<String,",type(Data,Type_in_dict),">",
        ['pseudocode']:
            ("map<string,",type(Data,Type_in_dict),">";"dict")
        ]).

type(Data,int) -->
        langs_to_output(Data,int,[
        ['hack','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','hy','java','c#','c','c++','vala','nemerle']:
                "int",
        ['php','prolog','common lisp','picat']:
                "integer",
        ['fortran']:
                "INTEGER",
        ['rebol']:
                "integer!",
        ['ceylon','cosmos','gambas','openoffice basic','pascal','erlang','delphi','visual basic','visual basic .net']:
                "Integer",
        ['haxe','ooc','swift','scala','perl 6','z3','monkey x']:
                "Int",
        ['javascript','typescript','coffeescript','perl']:
                "number",
        ['haskell']:
                "Num",
        ['ruby']:
                "fixnum",
        ['pseudocode']:
                ({member(Lang1,['java','pascal','rebol','fortran','haxe','php','haskell'])}, type([Lang1|_],int))
        ]).

type(Data,[array,Type]) -->
    {member(Type,[int,string,bool])},
    langs_to_output(Data,array,[
    ['java','c','c++','c#']:
            (type(Data,Type),"[]"),
    ['python']:
            "list",
    ['javascript','cosmos']:
            "Array",
    ['pseudocode']:
            (type(Data,Type),"[]";"Array";"list")
    ]).

type(Data,boolean) --> type(Data,bool).
type(Data,integer) --> type(Data,int).
type(Data,str) --> type(Data,string).



type(Data,string) -->
    langs_to_output(Data,string,[
    ['z3',cosmos,'visual basic .net','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','monkey x']:
            "String",
    ['vala','seed7','octave','picat','mathematical notation','polish notation','reverse polish notation','prolog','d','chapel','minizinc','genie','hack','nim','algol 68','typescript','coffeescript','octave','tcl','awk','julia','c#','f#','perl','javascript','go','php','c++','nemerle','erlang']:
            "string",
    ['c']:
            "char*",
    ['rebol']:
            "string!",
    ['fortran']:
            "CHARACTER","(","LEN","=","*",")",
    ['hy']:
            "str",
    ['pseudocode']:
            ("str";"string";"String";"char*";"string!")
    ]).

type(Data, bool) -->
    langs_to_output(Data,bool,[
    ['typescript','seed7','hy','java','javascript','perl']:
            "boolean",
    ['c++','nim','octave','dafny','chapel','c','rust','minizinc','engscript','dart','d','vala','go','cobra','c#','f#','php','hack']:
            "bool",
    ['haxe','haskell','swift','julia','perl 6','z3','z3py','monkey x']:
            "Bool",
    ['fortran']:
            "LOGICAL",
    ['visual basic','visual basic .net','openoffice basic','ceylon','delphi','pascal','scala']:
            "Boolean",
    ['rebol']:
            "logic!",
    ['pseudocode']:
            ("bool";"logic!";"Boolean";"boolean";"Bool";"LOGICAL")
    ]).

type(Data,void) -->
    langs_to_output(Data,void,[
    ['engscript','seed7','php','hy','cython','go','pike','objective-c','java','c','c++','c#','vala','typescript','d','javascript','dart']:
            "void",
    ['haxe','swift']:
            "Void",
    ['scala']:
            "Unit",
    ['pseudocode']:
            ("Void","void","Unit")
    ]).

type(Data,double) -->
        langs_to_output(Data,double,[
        ['java','c','c#','c++','dart','vala']:
                "double",
        ['go']:
                "float64",
        ['haxe']:
                "Float",
        ['javascript']:
                "number",
        ['minizinc','php']:
                "float",
        ['swift']:
                "Double",
        ['haskell']:
                "Num",
        ['rebol']:
                "decimal!",
        ['fortran']:
                ("double",ws_,"precision"),
        ['z3','z3py']:
                "Real",
        ['octave']:
                "scalar",
        ['pseudocode']:
                ("double","real","decimal","Num","float","Float","Real","float64","number")
        ]).

type(_,X) --> symbol(X).

top_level_statement_separator([Lang|_]) -->
	{memberchk(Lang,['picat','prolog','logtalk','erlang'])} -> ws;
	statement_separator([Lang|_]).

statement_separator(Data) -->
    {offside_rule_langs(Offside_rule_langs)},langs_to_output(Data,statement_separator,[
    ['pydatalog','englishscript','visual basic .net','lua','ruby','hy','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','z3','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','go','awk','haskell','r','visual basic']:
            ws_,
    ['java','c','pseudocode','perl 6','haxe','javascript','c++','c#','php','dart','actionscript','typescript','processing','vala','bc','ceylon','hack','perl']:
            ws,
    ['wolfram']:
            ";",
    Offside_rule_langs:
            (""),
    ['picat','prolog','constraint handling rules','logtalk','erlang','lpeg']:
            ",",
    ['gnu smalltalk']:
            (".",ws_)
    ]).

initializer_list_separator(Data) -->
    langs_to_output(Data,initializer_list_separator,[
    ['ruby','lua','python','visual basic .net','cosmos','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','pseudocode','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift','java','picat','c#','go','c++','c','visual basic','php','scala','perl','wolfram']:
            ",",
    ['rebol']:
            ws_,
    ['pseudocode']:
            (",";";")
    ]).

key_value_separator(Data) -->
    langs_to_output(Data,key_value_separator,[
    ['cosmos','lua','prolog','picat','go','dart','d','c#','frink','swift','javascript','typescript','php','perl','julia','haxe','c++','scala','octave','elixir','wolfram']:
            ",",
    ['java']:
            ";",
    ['pseudocode']:
            (",";";"),
    ['rebol','gnu smalltalk']:
            ws_
    ]).
key_value(Data,Type,[Key_,Val_]) -->
        {
                A = symbol(Key_),
                B = expr(Data,Type,Val_)
        },
        langs_to_output(Data,key_value,[
        ['groovy','d','dart','javascript','typescript','coffeescript','swift','elixir','swift','go']:
                (A,ws,":",ws,B),
        ['php','haxe','perl','julia']:
                (A,ws,"=>",ws,B),
        ['rebol']:
                (A,ws_,B),
        ['picat','lua']:
                (A,ws,"=",ws,B),
        ['c++','c#']:
                ("{",ws,("\"",ws,A,ws,"\""),ws,",",ws,B,ws,"}"),
        ['scala','wolfram','gnu smalltalk']:
                (A,ws,"->",ws,B),
        ['octave','cosmos']:
                (A,ws,",",ws,B),
        ['frink']:
                ("[",ws,A,ws,",",ws,B,ws,"]"),
        ['java']:
                ("put",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['prolog']:
                (A,ws,"-",ws,B)
        ]).

ws(Data) -->
	{Data = [Lang|_]},
	({Lang='python'} ->
	python_ws;
	ws).
ws_(Data) -->
	{Data = [Lang|_]},
	({Lang='python'} ->
	python_ws_;ws_).

top_level_statement(Data,Type,A) -->
    {Data = [Lang|_]},
    ({memberchk(Lang,['prolog','erlang','picat'])}->
        statement(Data,Type,A),".";
    {memberchk(Lang,['minizinc'])}->
        statement(Data,Type,A),";";
    statement(Data,Type,A)).

statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> statement(Data,Return_type,A),statement_separator(Data),statements(Data,Return_type,B).

ws_separated_statements(Data,[A]) --> top_level_statement(Data,_,A).
ws_separated_statements(Data,[A|B]) --> top_level_statement(Data,_,A),top_level_statement_separator(Data),ws_separated_statements(Data,B).

class_statements(Data,Class_name,[A]) --> class_statement(Data,Class_name,A).
class_statements(Data,Class_name,[A|B]) --> class_statement(Data,Class_name,A),statement_separator(Data),class_statements(Data,Class_name,B).

dict_(Data,Type,[A]) --> key_value(Data,Type,A).
dict_(Data,Type,[A|B]) --> key_value(Data,Type,A),key_value_separator(Data),dict_(Data,Type,B).

initializer_list_(Data,Type,[A]) --> expr(Data,Type,A).
initializer_list_(Data,Type,[A|B]) --> expr(Data,Type,A),initializer_list_separator(Data),initializer_list_(Data,Type,B).

enum_list(Data,[A]) --> enum_list_(Data,A).
enum_list(Data,[A|B]) --> enum_list_(Data,A),enum_list_separator(Data),enum_list(Data,B).

enum_list_(Data,A_) -->
			{
					A = symbol(A_)
			},
			langs_to_output(Data,enum_list_,[
			['java','seed7','vala','perl 6','swift','c++','c#','haxe','fortran','typescript','c','ada','scala']:
					(A),
			['go']:
					(A,ws,"=",ws,"iota")
			]).



% whitespace
ws --> "";((" ";"\t";"\n";"\r"),ws).
ws_ --> (" ";"\n";"\r"),ws.

python_ws --> "";((" ";"\t"),python_ws).
python_ws_ --> (" ";"\t"),python_ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> csym(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type1(Let, alpha) }.
csym(Let)     --> [Let], { code_type1(Let, csym) }.

code_type1(C,csym) :- code_type1(C,digit);code_type1(C,alpha);C='_'.
code_type1(C,digit) :- between_('0','9',C).
code_type1(C,alpha) :- between_('A','Z',C);between_('a','z',C).

between_(A,B,C) :- char_code(A,A1),char_code(B,B1),nonvar(C),char_code(C,C1),between(A1,B1,C1).

string_literal(S) --> "\"",string_inner(S),"\"".
string_literal1(S) --> "\'",string_inner1(S),"\'".
regex_literal(Data,S_) --> 
    {S = regex_inner(S_)},
    langs_to_output(Data,regex_literal,[
    ['javascript']:
        ("/",S,"/"),
    ['haxe']:
        ("~/",S,"/"),
    ['java']:
        ("Pattern",ws,".",ws,"compile",ws,"(\"",S,"\")"),
    ['c++']:
        ("regex::regex",ws,"(\"",S,"\")"),
    ['scala','c#']:
        ("new",ws,"Regex",ws,"(\"",S,"\")")
    ]).

comment_inner([A]) --> comment_inner_(A).
comment_inner([A|B]) --> comment_inner_(A),comment_inner(B).
comment_inner_(A) --> {dif(A,'\n')},[A].
string_inner([A]) --> string_inner_(A).
string_inner([A|B]) --> string_inner_(A),string_inner(B).
string_inner_(A) --> {A="\\\""},A;{dif(A,'"'),dif(A,'\n')},[A].
regex_inner([A]) --> regex_inner_(A).
regex_inner([A|B]) --> regex_inner_(A),regex_inner(B).
regex_inner_(A) --> {A="\\\"";A="\\\'"},A;{dif(A,'"'),dif(A,'\n')},[A].

string_inner1([A]) --> string_inner1_(A).
string_inner1([A|B]) --> string_inner1_(A),string_inner1(B).
string_inner1_(A) --> {A="\\'"},A;{dif(A,'\''),dif(A,'\n')},[A].

a_number([A,B]) -->
        (a__number(A), ".", a__number(B)).

a_number(A) -->
        a__number(A).

a__number([L|Ls]) --> digit(L), a__number_r(Ls).
a__number_r([L|Ls]) --> digit(L), a__number_r(Ls).
a__number_r([])     --> [].
digit(Let)     --> [Let], { code_type1(Let, digit) }.



not_defined_for(Data,Function) :-
        Data = [Lang,Is_input|_],
        (Is_input ->
            true;
        writeln(Function),writeln('not defined for'),writeln(Lang)).


statements_with_ws(Data,A) -->
    (include_in_each_file(Data);""),ws_separated_statements(Data,A),ws.

include_in_each_file(Data) -->
    langs_to_output(Data,include_in_each_file,[
    ['prolog']:
        (":- initialization(main).\n:- set_prolog_flag(double_quotes, chars).\n:- use_module(library(clpfd))."),
    ['perl']:
        ("use strict;\nuse warnings;"),
	['haxe']:
		"using StringTools;"
    ]),"\n";"".
        
print_var_types([A]) :-
    writeln(A).
print_var_types([A|Rest]) :-
    writeln(A),print_var_types(Rest).

list_of_langs(X) :-
	%X = [ruby,javascript,java,c,'c#','c++','go','haxe','php','swift','octave',lua].
	X = [javascript,python,haskell,'common lisp','scala','z3'].
	%X = [python,'visual basic .net',ruby,lua,java,javascript,'gnu smalltalk','minizinc','cobra','prolog'].


translate_langs(Input_) :-
	atom_chars(Input_,Input),
	list_of_langs(X),
	member(Lang,X), phrase(statements_with_ws([Lang,true,[],Var_types,"\n",Lang2],Ls), Input),
	translate_langs(Var_types,Ls,X,Lang2).

translate_langs(_,_,[],_) :-
	true.
	
translate_langs(Var_types,Ls,[Lang|Langs],Lang2) :-
    phrase(statements_with_ws([Lang,false,[],Var_types,"\n",Lang2],Ls), Output),
    atom_chars(Output_,Output),writeln(''),writeln(Lang),writeln(''),writeln(Output_),writeln(''),
    translate_langs(Var_types,Ls,Langs,Lang2).

get_user_input(V1,V2) :-
	writeln(V1),read_line(V3),atom_string(V2_,V3),downcase_atom(V2_,V2).

set_or_initialize_var(Data,Mode,Name,Expr,Type) -->
	({Mode = initialize_var},
		initialize_var(Data,Name,Expr,type(Data,Type));
	{Mode = return},
		return(Data,Expr);
	{Mode = set_var},
		set_var(Data,Name,Expr);
	{Mode=initialize_constant},
		initialize_constant(Data,Name,type(Data,Type),Expr)).

return(Data,A) -->
    langs_to_output(Data,return,[
	['pseudocode','python','lua','ruby','java','seed7','xl','e','livecode','englishscript','cython','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','coffeescript','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','rebol','tcl','awk','bc','chapel','perl 6']:
			("return",python_ws_,A),
	['minizinc','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','haskell','ml','racket','nemerle']:
			(A),
	['pseudocode','visual basic','visual basic .net','autoit','monkey x']:
			("Return",ws_,A),
	['octave','fortran','picat']:
			("retval",ws,"=",ws,A),
	['cosmos','prolog']:
			("Return",python_ws,"=",python_ws,A),
	['pascal']:
			("Exit",ws,"(",ws,A,ws,")"),
	['pseudocode','r']:
			("return",ws,"(",ws,A,ws,")"),
	['wolfram']:
			("Return",ws,"[",ws,A,ws,"]"),
	['pop-11']:
			(A,ws,"->",ws,"Result"),
	['delphi','pascal']:
			("Result",ws,"=",ws,A),
	['pseudocode','sql']:
			("RETURN",ws_,A)
	]).

initialize_constant(Data,Name,Type,Value) -->
        langs_to_output(Data,initialize_constant,[
        ['seed7']:
                ("const",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value),
        ['polish notation']:
                ("=",ws_,Name,ws_,Value),
        ['reverse polish notation']:
                (Name,ws_,Value,ws_,"="),
        ['fortran']:
                (Type,ws,",",ws,"PARAMETER",ws,"::",ws,Name,ws,"=",ws,"expression"),
        ['go']:
                ("const",ws_,Type,ws_,Name,ws,"=",ws,Value),
        ['perl 6']:
                ("constant",ws_,Type,ws_,Name,ws,"=",ws,Value),
        ['php','javascript','dart']:
                ("const",ws_,Name,ws,"=",ws,Value),
        ['z3']:
                ("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")"),
        ['rust','swift']:
                ("let",ws_,Name,ws,"=",ws,Value),
        ['c++','c','d','c#']:
                ("const",ws_,Type,ws_,Name,ws,"=",ws,Value),
        ['common lisp']:
                ("(",ws,"setf",ws_,Name,ws_,Value,ws,")"),
        ['minizinc']:
                (Type,ws,":",ws,Name,ws,"=",ws,Value),
        ['scala']:
                ("val",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value),
        ['haskell','erlang','julia','picat','prolog']:
                (Name,python_ws,"=",python_ws,Value),
        ['perl']:
                ("my",ws_,Name,ws,"=",ws,Value),
        ['rebol']:
                (Name,ws,":",ws,Value),
        ['haxe']:
                ("static",ws_,"inline",ws_,"var",ws_,Name,ws,"=",ws,Value),
        ['java','dart']:
                ("final",ws_,Type,ws_,Name,ws,"=",ws,Value),
        ['c']:
				("static",ws_,"const",ws_,Name,ws,"=",ws,Value),
        ['chapel']:
                ("var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value),
        ['typescript']:
                ("const",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value)
		]).

set_array_size(Data,Name,Size,Type) -->
		langs_to_output(Data,set_array_size,[
		['scala']:
                ("var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"fill",ws,"(",ws,Size,ws,")",ws,"{",ws,"0",ws,"}"),
        ['octave']:
                (Name,ws,"=",ws,"zeros",ws,"(",ws,Size,ws,")"),
        ['minizinc']:
                ("array",ws,"[",ws,"1",ws,"..",ws,Size,ws,"]",ws_,"of",ws_,Type,ws,":",ws,Name,ws,";"),
        ['dart']:
                ("List",ws_,Name,ws,"=",ws,"new",ws_,"List",ws,"(",ws,Size,ws,")"),
        ['java','c#']:
                (Type,ws,"[]",ws_,Name,ws,"",ws,"=",ws,"new",ws_,Type,ws,"[",ws,Size,ws,"]"),
        ['fortran']:
                (Type,ws,"(",ws,"LEN",ws,"=",ws,Size,ws,")",ws,"",ws,"::",ws,Name),
        ['go']:
                ("var",ws_,Name,ws_,"[",ws,Size,ws,"]",ws,Type),
        ['swift']:
                ("var",ws_,Name,ws,"=",ws,"[",ws,Type,ws,"]",ws,"(",ws,"count:",ws,Size,ws,",",ws,"repeatedValue",ws,":",ws,"0",ws,")"),
        ['c','c++']:
                (Type,ws_,Name,ws,"[",ws,Size,ws,"]"),
        ['rebol']:
                (Name,ws,":",ws,"array",ws_,Size),
        ['php']:
                (Name,ws,"=",ws,"array_fill",ws,"(",ws,"0",ws,",",ws,Size,ws,",",ws,"0",ws,")"),
        ['haxe']:
                ("var",ws_,"vector",ws,"=",ws,"",ws_,"haxe",ws,".",ws,"ds",ws,".",ws,"Vector",ws,"(",ws,Size,ws,")"),
        ['javascript']:
                ("var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"apply",ws,"(",ws,"null",ws,",",ws,"Array",ws,"(",ws,Size,ws,")",ws,")",ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,")",ws,"{",ws,"}",ws,")"),
        ['vbscript']:
                ("Dim",ws_,Name,ws,"(",ws,Size,ws,")")
        ]).
        
set_var(Data,Name,Value) -->
	langs_to_output(Data,set_var,[
    ['javascript','elixir','visual basic .net','lua','ruby','scriptol','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','sympy','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','coffeescript','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','gambas','octave','visual basic','bc']:
			(Name,ws,"=",ws,Value),
	['python']:
			(Name,python_ws,"=",python_ws,Value),
	%depends on the type of Value
	['prolog']:
			(Name,ws,"=",ws,Value),
	['hy']:
			("(",ws,"setv",ws_,Name,ws_,Value,ws,")"),
	['minizinc']:
			("constraint",ws_,Name,ws,"=",ws,Value),
	['rebol']:
			(Name,ws,":",ws,Value),
	['z3']:
			("(",ws,"assert",ws,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")"),
	['gap','seed7','delphi']:
			(Name,ws,":=",ws,Value),
	['r']:
			(Name,ws,"<-",ws,Value),
	['livecode']:
			("put",ws_,"expression",ws_,"into",ws_,Name),
	['vbscript']:
			("Set",ws_,"a",ws,"=",ws,"b")
	]).
	
initialize_var(Data,Name,Expr,Type) -->
	{Data = [Lang|_]},
	langs_to_output(Data,initialize_var,[
	['polish notation']:
        ("=",ws_,Name,ws_,Expr),
    ['visual basic','visual basic .net','openoffice basic']:
			("Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Expr),
    ['hy']:
        ("(",ws,"setv",ws_,Name,ws_,Expr,ws,")"),
    ['reverse polish notation']:
        (Name,ws_,Expr,ws_,"="),
    ['go']:
        ("var",ws_,Name,ws_,Type,ws,"=",ws,Expr),
    ['rust']:
        ("let",ws_,"mut",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','dafny']:
        ("var",ws,Name,ws,":",ws,Type,ws,":=",ws,Expr),
    ['gnu smalltalk']:
        (Name,ws_,":=",ws_,Expr),
    ['z3']:
        ("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Expr,ws,")",ws,")"),
    ['f#']:
        ("let",ws_,"mutable",ws_,Name,ws,"=",ws,Expr),
    ['common lisp']:
        ("(",ws,"setf",ws_,Name,ws_,Expr,ws,")"),
    ['minizinc']:
        (Type,ws,":",ws,Name,ws,"=",ws,Expr),
    ['ruby','php','haskell','erlang','prolog','logtalk','julia','picat','octave','wolfram']:
        (Name,python_ws,"=",python_ws,Expr),
    ['javascript','hack','swift']:
        ("var",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','lua']:
        ("local",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','janus']:
        ("local",ws_,Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','perl']:
        ("my",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','perl 6']:
        ("my",ws_,Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','java','scriptol','c','cosmos','c++','d','dart','englishscript','ceylon']:
        ({memberchk(Lang,['c','c++']),Type1=[array|_]}->
			{(Type1=[array,Type1_]->Type2=type(Data,Type1_))},
			Type2,ws_,Name,"[]",ws,"=",ws,Expr;
        Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','c#','vala']:
        ((Type;"var"),ws_,Name,ws,"=",ws,Expr),
    ['rebol']:
        (Name,ws,":",ws,Expr),
    ['r']:
        (Name,ws,"<-",ws,Expr),
    ['pseudocode','fortran']:
        (Type,ws,"::",ws,Name,ws,"=",ws,Expr),
    ['pseudocode','chapel','haxe','scala','typescript']:
        ("var",ws_,Name,(ws,":",Type,ws,ws;ws),"=",ws,Expr),
    ['monkey x']:
        ("Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Expr),
    ['vbscript']:
        ("Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','seed7']:
        ("var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Expr),
    ['python']:
		(Name,python_ws,"=",python_ws,Expr)
	]).

index_in_array(Data,Container,Contained) -->
    langs_to_output(Data,index_in_array,[
    [javascript]:
        (Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")"),
    [ruby]:
        (Container,ws,".",ws,"index",ws,"(",ws,Contained,ws,")"),
    ['perl']:
        ("firstidx",ws,"{",ws,"$_",ws_,"eq",ws_,Contained,ws,"}",ws,Container),
    ['php']:
        ("array_search",ws,"(",ws,Contained,ws,",",ws,Container,ws,")"),
    ['c#']:
        ("Array",ws,".",ws,"IndexOf",ws,"(",ws,Container,ws,",",ws,Contained,ws,")"),
    ['python']:
        (Container,python_ws,".",python_ws,"index",python_ws,"(",python_ws,Contained,python_ws,")")
    ]).

concatenate_string(Data,A,B) -->
        langs_to_output(Data,concatenate_string,[
        ['r']:
                ("paste0",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['maxima']:
                ("sconcat",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['common lisp']:
                ("(",ws,"concatenate",ws_,"'string",ws_,A,ws_,B,ws,")"),
        ['c','ruby','python','cosmos','z3py','monkey x','englishscript','mathematical notation','go','java','chapel','frink','freebasic','nemerle','d','cython','ceylon','coffeescript','typescript','dart','gosu','groovy','scala','swift','f#','javascript','c#','haxe','c++','vala']:
                (A,python_ws,"+",python_ws,B),
        ['engscript','lua']:
                (A,ws,"..",ws,B),
        ['fortran']:
                (A,ws,"//",ws,B),
        ['php','autohotkey','hack','perl']:
                (A,ws,".",ws,B),
        ['ocaml']:
                (A,ws,"^",ws,B),
        ['rebol']:
                ("append",ws_,A,ws_,B),
        ['haskell','minizinc','picat','elm']:
                (A,ws,"++",ws,B),
        ['clips']:
                ("(",ws,"str-cat",ws_,A,ws_,B,ws,")"),
        ['clojure']:
                ("(",ws,"str",ws_,A,ws_,B,ws,")"),
        ['erlang']:
                ("string",ws,":",ws,"concat",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['julia']:
                ("string",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['octave']:
                ("strcat",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['racket']:
                ("(",ws,"string-append",ws,A,ws,B,ws,")"),
        ['delphi']:
                ("Concat",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['visual basic','seed7','visual basic .net','gambas','nim','autoit','openoffice basic','livecode','vbscript']:
                (A,ws,"&",ws,B),
        ['elixir','wolfram','purescript']:
                (A,ws,"<>",ws,B),
        ['perl 6']:
                (A,ws,"~",ws,B),
        ['z3']:
                ("(",ws,"Concat",ws_,A,ws_,B,ws,")"),
        ['emacs lisp']:
                ("(",ws,"concat",ws_,A,ws_,B,ws,")"),
        ['polish notation']:
                ("+",ws_,A,ws_,B),
        ['reverse polish notation']:
                (A,ws_,B,ws_,"+")
        ]).

array_length(Data,A)-->
        langs_to_output(Data,array_length,[
        ['go']:
                ("len",ws,"(",ws,A,ws,")"),
        ['python','cython']:
                ("len",python_ws,"(",python_ws,A,python_ws,")"),
        ['java','picat','scala','d','coffeescript','typescript','dart','vala','javascript','haxe','cobra']:
                (A,ws,".",ws,"length"),
        ['c#','visual basic','powershell']:
                (A,ws,".",ws,"Length"),
        ['minizinc','julia','r']:
                ("length",ws,"(",ws,A,ws,")"),
        ['common lisp']:
                ("(",ws,"list-length",ws_,A,ws,")"),
        ['php']:
                ("count",ws,"(",ws,A,ws,")"),
        ['rust']:
                (A,ws,".",ws,"len",ws,"(",ws,")"),
        ['emacs lisp','scheme','racket','haskell']:
                ("(",ws,"length",ws_,A,ws,")"),
        ['c++','groovy']:
                (A,ws,".",ws,"size",ws,"(",ws,")"),
        ['c']:
                ("sizeof",ws,"(",ws,A,ws,")",ws,"/",ws,"sizeof",ws,"(",ws,A,ws,"[",ws,"0",ws,"]",ws,")"),
        ['perl']:
                ("scalar",ws,"(",ws,A,ws,")"),
        ['rebol']:
                ("length?",ws_,A),
        ['swift']:
                (A,ws,".",ws,"count"),
        ['clojure']:
                ("(",ws,"count",ws_,"array",ws,")"),
        ['hy']:
                ("(",ws,"len",ws_,A,ws,")"),
        ['octave','seed7']:
                ("length",ws,"(",ws,A,ws,")"),
        ['fortran','janus']:
                ("size",ws,"(",ws,A,ws,")"),
        ['wolfram']:
                ("Length",ws,"[",ws,A,ws,"]")
        ]).

strlen(Data,A) -->
        langs_to_output(Data,strlen,[
        ['go','erlang','nim']:
                ("len",ws,"(",ws,A,ws,")"),
        ['go','erlang','nim']:
                ("len",ws,"(",ws,A,ws,")"),
        ['r']:
                ("nchar",ws,"(",ws,A,ws,")"),
        ['erlang']:
                ("string:len",ws,"(",ws,A,ws,")"),
        ['visual basic','gambas']:
                ("Len",ws,"(",ws,A,ws,")"),
        ['javascript','typescript','scala','gosu','picat','haxe','ocaml','d','dart']:
                (A,ws,".",ws,"length"),
        ['rebol']:
                ("length?",ws_,A),
        ['java','c++','kotlin']:
                (A,ws,".",ws,"length",ws,"(",ws,")"),
        ['php','c','pawn','hack']:
                ("strlen",ws,"(",ws,A,ws,")"),
        ['minizinc','julia','perl','seed7','octave']:
                ("length",ws,"(",ws,A,ws,")"),
        ['c#','nemerle']:
                (A,ws,".",ws,"Length"),
        ['swift']:
                ("countElements",ws,"(",ws,A,ws,")"),
        ['autoit']:
                ("StringLen",ws,"(",ws,A,ws,")"),
        ['common lisp','haskell']:
                ("(",ws,"length",ws_,A,ws,")"),
        ['racket','scheme']:
                ("(",ws,"string-length",ws_,A,ws,")"),
        ['fortran']:
                ("LEN",ws,"(",ws,A,ws,")"),
        ['wolfram']:
                ("StringLength",ws,"[",ws,A,ws,"]"),
        ['z3']:
                ("(",ws,"Length",ws_,A,ws,")")
        ]).

access_array(Data,Array,Index) -->
        langs_to_output(Data,access_array,[
        ['ruby','c#','julia','d','swift','julia','janus','minizinc','picat','nim','autoit','python','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','go','c++','php','haxe','c']:
                (Array,python_ws,"[",python_ws,Index,python_ws,"]"),
        ['scala','octave','fortran','visual basic']:
                (Array,ws,"(",ws,Index,ws,")"),
        ['haskell']:
                ("(",ws,Array,ws,"!!",ws,Index,ws,")"),
        ['frink']:
                (Array,ws,"@",ws,Index),
        ['z3']:
                ("(",ws,"select",ws_,Array,ws_,Index,ws,")"),
        ['rebol']:
                (Array,ws,"/",ws,Index)
        ]).

reverse_list(Data,List) -->
        langs_to_output(Data,reverse_list,[
			['php']:
				("array_reverse",ws,"(",ws,List,ws,")"),
			['ruby']:
				(List,ws,".",ws,"reverse"),
			['python']:
				(List,python_ws,"[::-1]"),
			['haskell']:
				("(",ws,"reverse",ws_,List,ws,")"),
			['javascript']:
				(List,ws,".map(function(arr){return arr.slice();})")
		]).

charAt(Data,AString,Index) -->
        langs_to_output(Data,charAt,[
        ['java','haxe','scala','javascript','typescript']:
                (AString,ws,".",ws,"charAt",ws,"(",ws,Index,ws,")"),
        ['z3']:
                ("(",ws,"CharAt",ws_,"expression",ws_,Index,ws,")"),
        ['c','php','c#','minizinc','c++','picat','haskell','dart']:
                (AString,ws,"[",ws,Index,ws,"]"),
        ['octave']:
                (AString,ws,"(",ws,Index,ws,")"),
        ['chapel']:
                (AString,ws,".",ws,"substring",ws,"(",ws,Index,ws,")"),
        ['go']:
                ("string",ws,"(",ws,"[",ws,"]",ws,"rune",ws,"(",ws,AString,ws,")",ws,"[",ws,Index,ws,"]",ws,")"),
        ['swift']:
                (AString,ws,"[",ws,AString,ws,".",ws,"startIndex",ws,".",ws,"advancedBy",ws,"(",ws,Index,ws,")",ws,"]"),
        ['rebol']:
                (AString,ws,"/",ws,Index),
        ['perl']:
                ("substr",ws,"(",ws,AString,ws,",",ws,Index,ws,"-",ws,"1",ws,",",ws,"1",ws,")")
        ]).

join(Data,Array,Separator) -->
        langs_to_output(Data,join,[
        ['swift']:
                (Array,ws,".",ws,"joinWithSeparator",ws,"(",ws,Separator,ws,")"),
        ['c#']:
                ("String",ws,".",ws,"Join",ws,"(",ws,Separator,ws,",",ws,Array,ws,")"),
        ['php']:
                ("implode",ws,"(",ws,Separator,ws,",",ws,Array,ws,")"),
        ['perl']:
                ("join",ws,"(",ws,Separator,ws,",",ws,Array,ws,")"),
        ['d','julia']:
                ("join",ws,"(",ws,Array,ws,",",ws,Separator,ws,")"),
        ['go']:
                ("Strings",ws,".",ws,"join",ws,"(",ws,Array,ws,",",ws,Separator,ws,")"),
        ['javascript','haxe','coffeescript','groovy','java','typescript','rust','dart']:
                (Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")"),
        ['scala']:
                (Array,ws,".",ws,"mkString",ws,"(",ws,Separator,ws,")")
        ]).

concatenate_arrays(Data,A1,A2) -->
        langs_to_output(Data,concatenate_arrays,[
        [javascript]:
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")"),
        [haskell]:
                (A1,ws,"++",ws,A2),
        [python,ruby,swift]:
                (A1,python_ws,"+",python_ws,A2),
        [d]:
                (A1,python_ws,"~",python_ws,A2),
        [perl]:
                ("push",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        [php]:
                ("array_merge",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        [hy]:
                ("(",ws,"+",ws_,A1,ws_,A2,ws,")"),
        ['c#']:
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")",ws,".",ws,"ToArray",ws,"(",ws,")")
        ]).

split(Data,AString,Separator) -->
    langs_to_output(Data,split,[
    ['swift']:
            (AString,ws,".",ws,"componentsSeparatedByString",ws,"(",ws,Separator,ws,")"),
    ['octave']:
            ("strsplit",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
    ['go']:
            ("strings",ws,".",ws,"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
    ['javascript','coffeescript','java','dart','scala','groovy','haxe','rust','typescript','cython','python','vala']:
            (AString,python_ws,".",python_ws,"split",python_ws,"(",python_ws,Separator,python_ws,")"),
    ['php']:
            ("explode",ws,"(",ws,Separator,ws,",",ws,AString,ws,")"),
    ['perl','processing']:
            ("split",ws,"(",ws,Separator,ws,",",ws,AString,ws,")"),
    ['rebol']:
            ("split",ws_,AString,ws_,Separator),
    ['c#']:
            (AString,ws,".",ws,"Split",ws,"(",ws,"new",ws,"string[]",ws,"{",ws,Separator,ws,"}",ws,",",ws,"StringSplitOptions",ws,".",ws,"None",ws,")"),
    ['picat','d','julia']:
            ("split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
    ['haskell']:
            ("(",ws,"splitOn",ws_,AString,ws_,Separator,ws,")"),
    ['wolfram']:
            ("StringSplit",ws,"[",ws,AString,ws,",",ws,Separator,ws,"]")
    ]).

function_call(Data,Name,Args) -->
langs_to_output(Data,function_call,[
    ['c','python','ruby','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','prolog','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','vala','f#','java','ceylon','ocaml','erlang','c#','haxe','javascript','dart','bc','visual basic','php','perl']:
			(Name,python_ws,"(",python_ws,Args,python_ws,")"),
	['haskell','z3','clips','clojure','common lisp','clips','racket','scheme','rebol']:
			("(",ws,Name,ws_,Args,ws,")"),
	['polish notation']:
			(Name,ws_,Args),
	['reverse polish notation']:
			(Args,ws_,Name),
	['pydatalog','nearley']:
			(Name,ws,"[",ws,Args,ws,"]"),
	['hy']:
			("(",ws,Name,ws_,Args,ws,")")
    ]).

:- include(statement).
:- include(statement_with_semicolon).
:- include(class_statement).
:- include(expr).
:- include(parentheses_expr).
