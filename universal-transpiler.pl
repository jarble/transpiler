% This is a program that translates several programming languages into several other languages.

% For example:
%    translate("int add(a){ if(g){ return a; } }",E,c,java)
% will translate a short C program into the equivalent Java syntax. Conversely, we can write
%    translate("public static int add(a){ if(g){ return a; } }",E,java,c)
% to translate a Java function into C

:- use_module(library(prolog_stack)).
:- use_module(library(error)).
:- use_module(library(pio)).

user:prolog_exception_hook(Exception, Exception, Frame, _):-
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

offside_rule_langs(X) :-
	X = ['python','cython','coffeescript','cosmos'].

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

infix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        parentheses_expr(Data,Type,Exp1),python_ws,Symbol,python_ws,expr(Data,Type,Exp2).

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
        ['cython']:
                ("else",python_ws,":",python_ws,A),
        ['monkey x','vbscript']:
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
elif_or_else(Data,Return_type,[A|B]) --> elif(Data,Return_type,A),ws(Data),statement_separator(Data),ws(Data),elif_or_else(Data,Return_type,B).


indent_data(Indent,Data,Data1) :-
    Data = [Lang,Is_input,Namespace,Var_types,Indent],
    Data1 = [Lang,Is_input,Namespace,Var_types,indent(Indent)].

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
        ['monkey x']:
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
            (A,ws,"->",ws,B,ws,";"),
        ['r','f#']:
            (A,ws,"<-",ws,B),
        ['minizinc','ocaml','haskell','pascal','maxima','delphi','f#','livecode']:
            ("else",ws_,"if",ws_,A,ws_,"then",ws_,B),
        ['cython']:
            ("elif",python_ws_,A,python_ws,":",python_ws,B),
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
is_var_type([_,_,Namespace,Var_types,_], Name, Type) :-
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
        ['haskell','elixir','python','ruby','lua','hy','perl 6','cosmos','polish notation','reverse polish notation','scheme','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','r','bc']:
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

function_parameter_separator(Data) -->
        langs_to_output(Data,function_parameter_separator,[
        ['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','perl']:
                ws_,
        ['pseudocode','elixir','visual basic .net','python','ruby','lua','javascript','logtalk','cosmos','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic']:
                ",",
        [perl]:
                ws
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
        ['pseudocode','visual basic .net','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic']:
                ","
        ]).



%these parameters are used in a function's definition
optional_parameters(Data,A) --> "",parameters(Data,A).
parameters(Data,[A]) --> parameter(Data,A);default_parameter(Data,A);varargs(Data,A).
parameters(Data,[A|B]) --> parameter(Data,A),python_ws,function_parameter_separator(Data),python_ws,parameters(Data,B).

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
        [java]:
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
    ['picat','prolog','logtalk','erlang','lpeg']:
            ","
    ]).

initializer_list_separator(Data) -->
    langs_to_output(Data,initializer_list_separator,[
    ['ruby','visual basic .net','lua','python','cosmos','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','pseudocode','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift','java','picat','c#','go','c++','c','visual basic','php','scala','perl','wolfram']:
            ",",
    ['rebol']:
            ws_,
    ['pseudocode']:
            (",";";")
    ]).

key_value_separator(Data) -->
    langs_to_output(Data,key_value_separator,[
    ['cosmos','picat','go','dart','d','c#','frink','swift','javascript','typescript','php','perl','julia','haxe','c++','scala','octave','elixir','wolfram']:
            ",",
    ['java']:
            ";",
    ['pseudocode']:
            (",";";"),
    ['rebol']:
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
        ['picat']:
                (A,ws,"=",ws,B),
        ['c++','c#']:
                ("{",ws,("\"",ws,A,ws,"\""),ws,",",ws,B,ws,"}"),
        ['scala','wolfram']:
                (A,ws,"->",ws,B),
        ['octave','cosmos']:
                (A,ws,",",ws,B),
        ['frink']:
                ("[",ws,A,ws,",",ws,B,ws,"]"),
        ['java']:
                ("put",ws,"(",ws,A,ws,",",ws,B,ws,")")
        ]).


statements(Data,[A]) --> statement(Data,_,A).
statements(Data,[A|B]) --> statement(Data,_,A),statement_separator(Data),ws(Data),statements(Data,B).

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

ws_separated_statements(Data,[A]) --> top_level_statement(Data,_,A).
ws_separated_statements(Data,[A|B]) --> top_level_statement(Data,_,A),statement_separator(Data),ws_separated_statements(Data,B).

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



statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> statement(Data,Return_type,A),statement_separator(Data),statements(Data,Return_type,B).


% whitespace
ws --> "";((" ";"\t";"\n";"\r"),ws).
ws_ --> (" ";"\n";"\r"),ws.

python_ws --> "";((" "),python_ws).
python_ws_ --> (" "),python_ws.

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
    ['python']:
        ("re",python_ws,".",python_ws,"compile",python_ws,"(\"",S,"\")"),
    ['erlang']:
        ("re",ws,":",ws,"compile",ws,"(\"",S,"\")"),
    ['c++']:
        ("regex::regex",ws,"(\"",S,"\")"),
    ['scala','c#']:
        ("new",ws,"Regex",ws,"(\"",S,"\")")
    ]).

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
        (":- initialization(main). :- set_prolog_flag(double_quotes, chars)."),
    ['perl']:
        ("use strict;\nuse warnings;"),
    ['python']:
		"",
	['haxe']:
		"using StringTools;"
    ]);"".
        
print_var_types([A]) :-
    writeln(A).
print_var_types([A|Rest]) :-
    writeln(A),print_var_types(Rest).

list_of_langs(X) :-
	%X = [ruby,javascript,java,c,'c#','c++','go','haxe','php','swift','octave',lua].
	X = [python,java,'coffeescript','visual basic .net',erlang,elixir,ruby,lua,javascript,'c#','c++'].

translate(Input,Output,Lang2) :-
    list_of_langs(X),member(Lang1,X),translate(Input,Output,Lang1,Lang2).

translate_langs(Input_) :-
	atom_chars(Input_,Input),
	list_of_langs(X),
	member(Lang,X), phrase(statements_with_ws([Lang,true,[],Var_types,"\n"],Ls), Input),
	translate_langs(Var_types,Ls,X).

translate_langs(_,_,[]) :-
	true.
	
translate_langs(Var_types,Ls,[Lang|Langs]) :-
    phrase(statements_with_ws([Lang,false,[],Var_types,"\n"],Ls), Output),
    atom_chars(Output_,Output),writeln(''),writeln(Lang),writeln(''),writeln(Output_),writeln(''),
    translate_langs(Var_types,Ls,Langs).

get_user_input(V1,V2) :-
	writeln(V1),read_line(V3),atom_string(V2_,V3),downcase_atom(V2_,V2).


statement_with_semicolon(Data,_,prolog_concatenate_string(Output_,Str1_,Str2_)) --> 
{
	Output = expr(Data,string,Output_),
	Str1 = expr(Data,string,Str1_),
	Str2 = expr(Data,string,Str2_)
},
	langs_to_output(Data,prolog_concatenate_string,[
	['javascript']:
		(Output,ws,"=",ws,Str1,ws,"+",ws,Str2)
    ]).

statement_with_semicolon(Data,Return_type,return(To_return1,Function_name)) --> 
	{
			A = expr(Data,Return_type,To_return1)
	},
    (langs_to_output(Data,return,[
    ['vbscript']:
			(Function_name,ws,"=",ws,A),
	['pseudocode','python','lua','ruby','java','seed7','xl','e','livecode','englishscript','cython','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','coffeescript','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','rebol','tcl','awk','bc','chapel','perl 6']:
			("return",python_ws_,A),
	['minizinc','elixir','prolog','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','haskell','ml','racket','nemerle']:
			(A),
	['pseudocode','visual basic','visual basic .net','autoit','monkey x']:
			("Return",ws_,A),
	['octave','fortran','picat']:
			("retval",ws,"=",ws,A),
	['cosmos']:
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
	])).

statement_with_semicolon(Data,_,plus_plus(Name1)) --> 
        {
                Name = var_name(Data,int,Name1)
        },
        langs_to_output(Data,plus_plus,[
        [javascript,java,c]:
			(Name,ws,"++")
        ]).

statement_with_semicolon(Data,_,minus_minus(Name1)) --> 
        {
			Name = var_name(Data,int,Name1)
        },
        langs_to_output(Data,minus_minus,[
        [javascript,java]:
			(Name,ws,"--")
		]).

statement_with_semicolon(Data,_,initialize_constant(Type1,Name1,Expr1)) -->
        {
                Value = expr(Data,Type1,Expr1),
                Type = type(Data,Type1),
                Name = var_name(Data,Type1,Name1)
        },
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



statement_with_semicolon(Data,Type, function_call(Name1,Params1)) -->
	parentheses_expr(Data,Type, function_call(Name1,Params1)).

statement_with_semicolon(Data,_,set_array_size(Name1,Size1,Type1)) -->
		{
			Name = var_name(Data,Name1,[array,Type]),
			Size = expr(Data,int,Size1),
			Type = type(Data,Type1)
			
		},
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

statement_with_semicolon(Data,_,set_dict(Name1,Index1,Expr1,Type)) -->
	{
		Name = var_name(Data,[dict,Type],Name1),
		Index = var_name(Data,string,Index1),
		Value = expr(Data,Type,Expr1)
	},
	langs_to_output(Data,set_dict,[
    ['javascript','c++','haxe','c#']:
			(Name,ws,"[",ws,Index,ws,"]",ws,"=",ws,Value),
	['java']:	
			(Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")")
	]).

statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	{
		Name = var_name(Data,Type,Name1),
		Value = expr(Data,Type,Expr1)
	},
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
	['livecode']:
			("put",ws_,"expression",ws_,"into",ws_,Name),
	['vbscript']:
			("Set",ws_,"a",ws,"=",ws,"b")
	]).

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	{
			Name = var_name(Data,Type1,Name1),
			Type = type(Data,Type1)
	},
    langs_to_output(Data,initialize_empty_var,[
    ['swift','scala','typescript']:
			("var",ws_,Name,ws,":",ws,Type),
	['java','c#','c++','c','d','janus','fortran','dart']:
			(Type,ws_,Name),
	['prolog']:
			(Type,ws,"(",ws,Name,ws,")"),
	['javascript','haxe']:
			("var",ws_,Name),
	['minizinc']:
			(Type,ws,":",ws,Name),
	['pascal']:
			(Name,ws,":",ws,Type),
	['go']:
			("var",ws_,Name,ws_,Type),
	['z3']:
			("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")"),
	['julia']:
			("local",ws_,Name),
	['perl']:
			("my",ws_,Name),
	['perl 6']:
			("my",ws_,Type,ws_,Name),
	['z3py']:
			(Name,ws,"=",ws,Type,ws,"(",ws,"'",ws,Name,ws,"'",ws,")")
	]).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	{
			A = expr(Data,string,Expr1)
	},
	langs_to_output(Data,throw,[
	['ocaml']:
			("raise",ws_,A),
	['javascript','dart','java','c++','swift','rebol','haxe','c#','picat','scala']:
			("throw",ws_,A),
	['julia','e']:
			("throw",ws,"(",ws,A,ws,")"),
	['perl','perl 6']:
			("die",ws_,A),
	['octave']:
			("error",ws,"(",ws,A,ws,")"),
	['php']:
			("throw",ws_,"new",ws_,"Exception",ws,"(",ws,A,ws,")"),
	['pseudocode']:
			(statement_with_semicolon(Data,_,throw(Expr1)))
	]).

statement_with_semicolon(Data,_,initialize_var(Type1,Name1,Value1)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,Type1,Name1),
		Type = type(Data,Type1),
		Value = expr(Data,Type1,Value1)
	},
	(langs_to_output(Data,initialize_var,[
	['polish notation']:
        ("=",ws_,Name,ws_,Value),
    ['hy']:
        ("(",ws,"setv",ws_,Name,ws_,Value,ws,")"),
    ['reverse polish notation']:
        (Name,ws_,Value,ws_,"="),
    ['go']:
        ("var",ws_,Name,ws_,Type,ws,"=",ws,Value),
    ['rust']:
        ("let",ws_,"mut",ws_,Name,ws,"=",ws,Value),
    ['pseudocode','dafny']:
        ("var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value),
    ['z3']:
        ("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")"),
    ['f#']:
        ("let",ws_,"mutable",ws_,Name,ws,"=",ws,Value),
    ['common lisp']:
        ("(",ws,"setf",ws_,Name,ws_,Value,ws,")"),
    ['minizinc']:
        (Type,ws,":",ws,Name,ws,"=",ws,Value),
    ['ruby','php','haskell','erlang','prolog','logtalk','julia','picat','octave','wolfram']:
        (Name,python_ws,"=",python_ws,Value),
    ['javascript','hack','swift']:
        ("var",ws_,Name,ws,"=",ws,Value),
    ['pseudocode','lua']:
        ("local",ws_,Name,ws,"=",ws,Value),
    ['pseudocode','janus']:
        ("local",ws_,Type,ws_,Name,ws,"=",ws,Value),
    ['pseudocode','perl']:
        ("my",ws_,Name,ws,"=",ws,Value),
    ['pseudocode','perl 6']:
        ("my",ws_,Type,ws_,Name,ws,"=",ws,Value),
    ['pseudocode','java','scriptol','c','cosmos','c++','d','dart','englishscript','ceylon']:
        ({memberchk(Lang,['c','c++']),Type1=[array|_]}->
			{(Type1=[array,Type1_]->Type2=type(Data,Type1_))},
			Type2,ws_,Name,"[]",ws,"=",ws,Value;
        Type,ws_,Name,ws,"=",ws,Value),
    ['pseudocode','c#','vala']:
        ((Type;"var"),ws_,Name,ws,"=",ws,Value),
    ['rebol']:
        (Name,ws,":",ws,Value),
    ['r']:
        (Name,ws,"<-",ws,Value),
    ['pseudocode','fortran']:
        (Type,ws,"::",ws,Name,ws,"=",ws,Value),
    ['pseudocode','chapel','haxe','scala','typescript']:
        ("var",ws_,Name,(ws,":",Type,ws,ws;ws),"=",ws,Value),
    ['monkey x']:
        ("Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value),
    ['vbscript']:
        ("Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value),
    ['pseudocode','seed7']:
        ("var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value),
    ['python']:
		(Name,python_ws,"=",python_ws,Value)
	])).

statement_with_semicolon(Data,_,append_to_array(Name1,Expr1)) -->
        {
                Expr = expr(Data,Type,Expr1),
                Name = var_name(Data,[array,Type],Name1)
        },
        langs_to_output(Data,append_to_array,[
        ['javascript','ruby']:
                (Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")"),
        ['php']:
                ("array_push",ws,"(",ws,Name,ws,",",ws,Expr,ws,")"),
        ['perl']:
                ("push",ws,"(",ws,Name,ws,",",ws,Expr,ws,")"),
        ['python']:
				(Name,python_ws,"+=",python_ws,"[",Expr,"]")
        ]).


statement_with_semicolon(Data,_,plus_equals(Name1,Expr1)) -->
        {
                A = var_name(Data,int,Name1),
                B = expr(Data,int,Expr1)
		},
        langs_to_output(Data,plus_equals,[
        ['janus','visual basic','nim','python','vala','perl 6','dart','typescript','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift']:
                (A,python_ws,"+=",python_ws,B),
        ['haskell','ruby','lua','erlang','fortran','ocaml','minizinc','octave','delphi']:
                (A,ws,"=",ws,A,ws,"+",ws,B),
        ['picat']:
                (A,ws,":=",ws,A,ws,"+",ws,B),
        ['rebol']:
                (A,ws,":",ws,A,ws,"+",ws,B),
        ['livecode']:
                ("add",ws_,B,ws_,"to",ws_,A),
        ['seed7']:
                (A,ws,"+:=",ws,B)
        ]).
        
statement_with_semicolon(Data,_,minus_equals(Name1,Expr1)) -->
	{
		A = var_name(Data,int,Name1),
		B = expr(Data,int,Expr1)
	},
    langs_to_output(Data,minus_equals,[
    ['janus','vala','nim','perl 6','dart','perl','typescript','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift']:
			(A,python_ws,"-=",python_ws,B),
	['haskell','erlang','fortran','ocaml','minizinc','octave','delphi']:
			(A,ws,"=",ws,A,ws,"-",ws,B),
	['picat']:
			(A,ws,":=",ws,A,ws,"-",ws,B),
	['rebol']:
			(A,ws,":",ws,A,ws,"-",ws,B),
	['livecode']:
			("subtract",ws_,B,ws_,"from",ws_,A),
	['seed7']:
			(A,ws,"-:=",ws,B)
    ]).
statement_with_semicolon(Data,_,append_to_string(Name1,Expr1)) -->
        {
                Name = var_name(Data,string,Name1),
                Expr = expr(Data,string,Expr1)
        },
        langs_to_output(Data,append_to_string,[
        [c,java,'c#',javascript]:
                (Name,python_ws,"+=",python_ws,Expr),
        [php,perl]:
                (Name,ws,".=",ws,Expr)
        ]).

statement_with_semicolon(Data,_,times_equals(Name1,Expr1)) -->
        {
                Name = var_name(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        langs_to_output(Data,times_equals,[
        [c,java,'c#','python',javascript,php,perl]:
                (Name,python_ws,"*=",python_ws,Expr)
        ]).

statement_with_semicolon(Data,_,divide_equals(Name1,Expr1)) -->
        {
                Name = var_name(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        langs_to_output(Data,divide_equals,[
        ['python']:
                (Name,python_ws,"/=",python_ws,Expr)
        ]).

%print without newline
statement_with_semicolon(Data,Type,print(Expr1)) -->
        {
                A = expr(Data,Type,Expr1)
        },
        langs_to_output(Data,print,[
        ['java']:
			("System",ws,".",ws,"out",ws,".",ws,"print",ws,"(",ws,A,ws,")"),
		['java']:
			("Console",ws,".",ws,"Write",ws,"(",ws,A,ws,")"),
		['prolog']:
			("write",ws,"(",ws,A,ws,")"),
		['perl']:
			("print",ws,"(",ws,A,ws,")"),
		['lua']:
			("io",ws,".",ws,"write",ws,"(",ws,A,ws,")"),
		['php']:
			("echo",ws_,A),
		['c++']:
			("cout",ws,"<<",ws,A)
        ]).

%print with newline
statement_with_semicolon(Data,Type,println(Expr1)) -->
        {
                A = expr(Data,Type,Expr1)
        },
		langs_to_output(Data,println,[
		['ocaml']:
                ("print_string",ws_,A),
        ['minizinc']:
                ("trace",ws,"(",ws,A,ws,",",ws,"true",ws,")"),
        ['perl 6']:
                ("say",ws_,A),
        ['erlang']:
                ("io",ws,":",ws,"fwrite",ws,"(",ws,A,ws,")"),
        ['c++']:
                ("cout",ws,"<<",ws,A,"<<",ws,"endl"),
        ['haxe']:
                ("trace",ws,"(",ws,A,ws,")"),
        ['go']:
                ("fmt",ws,".",ws,"Println",ws,"(",ws,A,ws,")"),
        ['c#','visual basic .net']:
                ("Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")"),
        ['rebol','fortran','perl','php']:
                ("print",ws_,A),
        ['ruby']:                            
                ("puts",ws,"(",ws,A,ws,")"),
        ['python']:                            
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['scala','julia','swift','picat']:
                ("println",ws,"(",ws,A,ws,")"),
        ['javascript','typescript']:
                ("console",ws,".",ws,"log",ws,"(",ws,A,ws,")"),
        ['englishscript','cython','ceylon','r','gosu','dart','vala','perl','php','hack','awk']:
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['java']:
                ("System",ws,".",ws,"out",ws,".",ws,"println",ws,"(",ws,A,ws,")"),
        ['c']:
                ("printf",ws,"(",ws,A,ws,")"),
        ['haskell']:
                ("(",ws,"putStrLn",ws_,A,ws,")"),
        ['hy','common lisp']:
                ("(",ws,"print",ws_,A,ws,")"),
        ['rust']:
                ("println!(",ws,A,ws,")"),
        ['octave']:
                ("disp",ws,"(",ws,A,ws,")"),
        ['chapel','d','seed7','prolog']:
                ("writeln",ws,"(",ws,A,ws,")"),
        ['delphi']:
                ("WriteLn",ws,"(",ws,A,ws,")"),
        ['frink']:
                ("print",ws,"[",ws,A,ws,"]"),
        ['wolfram']:
                ("Print",ws,"[",ws,A,ws,"]"),
        ['z3']:
                ("(",ws,"echo",ws_,A,ws,")"),
        ['monkey x']:
                ("Print",ws_,A)
        ]).
        
parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
	{
			Name = function_name(Data,Type,Name1,Params2),
			(Args = function_call_parameters(Data,Params1,Params2))
	},
    langs_to_output(Data,function_call,[
    ['c','ruby','visual basic .net','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','prolog','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','vala','f#','java','ceylon','ocaml','erlang','c#','haxe','javascript','dart','bc','visual basic','php','perl']:
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

parentheses_expr(Data,Type,instance_method_call(Function_name_,Class_name_,Instance_name_,Params1)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Instance_name = var_name(Data,Class_name_,Instance_name_),
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    langs_to_output(Data,instance_method_call,[
    ['java','haxe','javascript','c#','c++']:
		(Instance_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['logtalk']:
		(Instance_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Instance_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).

%call_static_method
parentheses_expr(Data,Type,static_method_call(Function_name_,Class_name_,Params1,Params2)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			nonvar(Type),
			Class_name = symbol(Class_name_),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    langs_to_output(Data,static_method_call,[
    ['java','javascript','c#']:
		(Class_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['php','c++']:
		(Class_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Class_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).


parentheses_expr(Data,string,type_conversion(string,Arg1)) -->
        {
                Arg = parentheses_expr(Data,int,Arg1)
        },
        langs_to_output(Data,type_conversion,[
        ['c#']:
                (Arg,ws,".",ws,"ToString",ws,"(",ws,")"),
        [javascript]:
                ("String",ws,"(",ws,Arg,ws,")")
        ]).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Data,Type1)
        },
		langs_to_output(Data,anonymous_function,[
		['matlab','octave']:
                ("(",ws,"@",ws,"(",ws,Params,ws,")",ws,B,ws,")"),
        ['picat']:
                ("lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,B,ws,")"),
        ['javascript','typescript','haxe','r','php']:
                ("function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}"),
        ['haskell']:
                ("(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")"),
        ['frink']:
                ("{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}"),
        ['erlang']:
                ("fun",ws,"(",ws,Params,ws,")",ws_,B,"end"),
        ['julia']:
                ("function",ws,"(",ws,Params,ws,")",ws_,B,"end"),
        ['swift']:
                ("{",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws_,"in",ws_,B,ws,"}"),
        ['go']:
                ("func",ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,B,ws,"}"),
        ['dart','scala']:
                ("(",ws,"(",ws,Params,ws,")",ws,"=>",ws,B,ws,")"),
        ['c++']:
                ("[",ws,"=",ws,"]",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,B,ws,"}"),
        ['java']:
                ("(",ws,Params,ws,")",ws,"->",ws,"{",ws,B,ws,"}"),
        ['haxe']:
                ("(",ws,"name",ws_,Params,ws,"->",ws,B,ws,")"),
        ['delphi']:
                ("function",ws,"(",ws,Params,ws,")",ws,"begin",ws_,B,"end",ws,"),"),
        ['d']:
                ("(",ws,Params,ws,")",ws,"{",ws,B,ws,"}"),
        ['rebol']:
                ("func",ws_,"[",ws,Params,ws,"]",ws,"[",ws,B,ws,"]"),
        ['rust']:
                ("fn",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}")
        ]).

parentheses_expr(Data,int,floor(Params1)) -->
        {Params = expr(Data,int,Params1)},
        langs_to_output(Data,floor,[
                [javascript,java]:
                        ("Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")")
        ]).


parentheses_expr(Data,int,ceiling(Params1)) -->
        {Params = expr(Data,int,Params1)},
        langs_to_output(Data,ceiling,[
                [javascript,java]:
					("Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")")
        ]).

parentheses_expr(Data,int,cos(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        langs_to_output(Data,cos,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("cos",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Cos",ws,"[",ws,Var1,ws,"]"),
        ['go']:
                ("math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['rebol']:
                ("cosine/radians",ws_,Var1),
        ['english']:
                ("the cosine of",ws_,Var1),
        ['common lisp','racket']:
                ("(",ws,"cos",ws_,Var1,ws,")"),
        ['clojure']:
                ("(",ws,"Math/cos",ws_,Var1,ws,")")
        ]).        
        
parentheses_expr(Data,double,sin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,sin,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")"),
        ['english']:
                ("the sine of",ws_,Var1),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("sin",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Sin",ws,"[",ws,Var1,ws,"]"),
        ['rebol']:
                ("sine/radians",ws_,Var1),
        ['go']:
                ("math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")"),
        ['common lisp','racket']:
                ("(",ws,"sin",ws_,Var1,ws,")"),
        ['clojure']:
                ("(",ws,"Math/sin",ws_,Var1,ws,")")
        ]).

parentheses_expr(Data,double,abs(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,abs,[
        ['java','javascript']:
                ("Math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")")
        ]).
        
parentheses_expr(Data,double,cosh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,cosh,[
        ['c']:
                ("cosh",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Cosh",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Cosh",ws,"(",ws,Var1,ws,")")
        ]).        


parentheses_expr(Data,double,sinh(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,sinh,[
        ['c']:
                ("sinh",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Sinh",ws,"(",ws,Var1,ws,")")
        ]).

%inverse tangent or arctan
parentheses_expr(Data,double,atan(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,atan,[
        ['c']:
                ("atan",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Atan",ws,"(",ws,Var1,ws,")")
        ]).

%inverse sine or arcsine
parentheses_expr(Data,double,asin(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,asin,[
        ['c']:
                ("asin",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Asin",ws,"(",ws,Var1,ws,")")
        ]).

%inverse cosine or arccosine
parentheses_expr(Data,double,acos(Var1_)) -->
        {Var1 = expr(Data,double,Var1_)},
        langs_to_output(Data,acos,[
        ['c']:
                ("acos",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Acos",ws,"(",ws,Var1,ws,")")
        ]).

parentheses_expr(Data,bool,"true") -->
	langs_to_output(Data,'true',[
	['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol']:
			("true"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','visual basic .net','monkey x','wolfram','delphi']:
			("True"),
	['perl','awk','tcl']:
			("1"),
	['racket']:
			("#t"),
	['common lisp']:
			("t"),
	['fortran']:
			(".TRUE."),
	['r','seed7']:
			("TRUE")
    ]).
parentheses_expr(Data,bool,"false") -->
    langs_to_output(Data,'false',[
    ['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol','hack']:
			("false"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','visual basic .net','monkey x','wolfram','delphi']:
			("False"),
	['perl','awk','tcl']:
			("0"),
	['common lisp']:
			("nil"),
	['racket']:
			("#f"),
	['fortran']:
			(".FALSE."),
	['seed7','r']:
			("FALSE")
    ]).
	
parentheses_expr(Data,int,tan(Var1_)) -->
        {Var1 = expr(Data,int,Var1_)},
        langs_to_output(Data,tan,[
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("tan",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Tan",ws,"[",ws,Var1,ws,"]"),
        ['rebol']:
                ("tangent/radians",ws_,Var1),
        ['english']:
                ("the tangent of",ws_,Var1),
        ['go']:
                ("math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['common lisp','racket']:
                ("(",ws,"tan",ws_,"a",ws,")"),
        ['clojure']:
                ("(",ws,"Math/tan",ws_,"a",ws,")")
        ]).

parentheses_expr(_,string,string_literal(A)) --> string_literal(A).
parentheses_expr(Data,regex,regex_literal(A)) --> regex_literal(Data,A).
parentheses_expr(_,string,string_literal1(A)) --> string_literal1(A).

parentheses_expr(Data,[array,Type1],initializer_list(A_)) -->
        {
                A = initializer_list_(Data,Type1,A_),
                Type = type(Data,Type1)
        },
        langs_to_output(Data,initializer_list,[
        ['java','lua','pseudocode','picat','c#','c++','c','visual basic','visual basic .net','wolfram']:
                ("{",ws,A,ws,"}"),
        ['go']:
				("[]",Type,"{",ws,A,ws,"}"),
        [ 'ruby', 'cosmos', 'python', 'nim','d','frink','rebol','octave','julia','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift']:
                ("[",python_ws,A,python_ws,"]"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['scala']:
                ("Array",ws,"(",ws,A,ws,")"),
        ['perl','chapel']:
                ("(",ws,A,ws,")"),
        ['fortran']:
                ("(/",ws,A,ws,"/)")
        ]).
        
expr(Data,[array,string],dict_keys(A1)) -->
		{
			A = expr(Data,[dict,Type1],A1)
		},
		langs_to_output(Data,dict_keys,[
			['php']:
				("array_keys",ws,"(",ws,A,ws,")"),
			['perl']:
				("keys",ws,"(",ws,A,ws,")"),
			['swift']:
				("Array",ws,"(",ws,A,ws,".",ws,"keys",ws,")"),
			['swift']:
				(A,python_ws,".",python_ws,"keys",python_ws,"(",python_ws,")"),
			['ruby']:
				(A, ".", "keys"),
			['javascript']:
				("Object",ws,".",ws,"keys",ws,"(",ws,A,ws,")"),
			['c#']:
				("new",ws_,"List<string>",ws,"(",ws,"this",ws,".",ws,A,ws,".","Keys",ws,")")
		]).

parentheses_expr(Data,[dict,Type1],dict(A_)) -->
        {
                A = dict_(Data,Type1,A_)
        },
		langs_to_output(Data,dict,[
		[ 'cosmos', 'dart','javascript','typescript','julia','c++','engscript']:
                ("{",python_ws,A,python_ws,"}"),
        ['picat']:
                ("new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")"),
        ['go']:
                ("map",ws,"[",ws,"Input",ws,"]",ws,"Output",ws,"{",ws,A,ws,"}"),
        ['perl']:
                ("(",ws,A,ws,")"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['haxe','frink','swift','elixir','d','wolfram']:
                ("[",ws,A,ws,"]"),
        ['scala']:
                ("Map(",ws,A,ws,")"),
        ['octave']:
                ("struct",ws,"(",ws,A,ws,")"),
        ['rebol']:
                ("to-hash",ws,"[",ws,A,ws,"]")
        ]).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A_,B_)) -->
	{
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
	langs_to_output(Data,range,[
	['swift','perl','picat','minizinc','chapel']:
		("(",ws,A,ws,"..",ws,B,ws,")"),
	['rust']:
		("(",ws,A,ws,"...",ws,B,ws,")"),
	["python"]:
		("range",python_ws,"(",python_ws,A,python_ws,",",B,python_ws,"-",python_ws,"1",python_ws,")")
    ]).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".

expr(Data,int,pi) -->
	langs_to_output(Data,pi,[
	[java,pseudocode,javascript]:
			("Math",ws,".",ws,"PI"),
	[pseudocode]:
			("math",ws,".",ws,"pi")
    ]).
	
expr(Data,grammar, grammar_or(Var1_,Var2_)) -->
	{
			Var1 = parentheses_expr(Data,grammar,Var1_),
			Var2 = expr(Data,bool,Var2_)
	},
    langs_to_output(Data,grammar_or,[
    ['marpa','rebol','yapps','antlr','jison','waxeye','ometa','ebnf','nearley','parslet','yacc','perl 6','rebol','hampi','earley-parser-js']:
			(Var1,ws,"|",ws,Var2),
	['lpeg']:
			(Var1,ws,"+",ws,Var2),
	['peg.js','abnf','treetop']:
			(Var1,ws,"/",ws,Var2),
	['prolog']:
			(Var1,ws,";",ws,Var2),
	['parboiled']:
			("Sequence",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")")
    ]).

expr(Data,bool, or(Var1_,Var2_)) -->
        {
                Var1 = parentheses_expr(Data,bool,Var1_),
                Var2 = expr(Data,bool,Var2_)
        },
    langs_to_output(Data,'or',[
    [javascript,katahdin,'perl 6','ruby',wolfram,chapel,elixir,frink,ooc,picat,janus,processing,pike,nools,pawn,matlab,hack,gosu,rust,autoit,autohotkey,typescript,ceylon,groovy,d,octave,awk,julia,scala,'f#',swift,nemerle,vala,go,perl,java,haskell,haxe,c,'c++','c#',dart,r]:
        (Var1,ws,"||",ws,Var2),
    [cosmos,'python','lua',seed7,pydatalog,livecode,englishscript,cython,gap,'mathematical notation',genie,idp,maxima,engscript,ada,newlisp,ocaml,nim,coffeescript,pascal,delphi,erlang,rebol,php]:
        (Var1,python_ws_,"or",python_ws_,Var2),
    [fortran]:
        (Var1,ws_,".OR.",ws_,Var2),
    [z3,clips,clojure,'common lisp','emacs lisp',clojure,racket]:
        ("(",ws,"or",ws_,Var1,ws_,Var2,ws,")"),
    [prolog]:
        (Var1,ws,";",ws,Var2),
    [minizinc]:
        (Var1,ws,"\\/",ws,Var2),
    ['visual basic','monkey x','visual basic .net']:
        (Var1,ws_,"Or",ws_,Var2)
    ]).

expr(Data,int,last_index_of(Str1_,Str2_)) -->
        {
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
    langs_to_output(Data,last_index_of,[
    ['haxe','java','kotlin','haxe']:
        (String,ws,".",ws,"lastIndexOf",ws,"(",ws,Substring,ws,")"),
    ['c++']:
        (String,ws,".",ws,"find_last_of",ws,"(",ws,Substring,ws,")"),
    ['perl']:
        ("rindex",ws,"(",ws,String,ws,",",ws,Substring,ws,")"),
    ['c#']:
        (String,ws,".",ws,"LastIndexOf",ws,"(",ws,Substring,ws,")")
    ]).

expr(Data,int,index_of(Str1_,Str2_)) -->
        {
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
    langs_to_output(Data,index_of,[
    [javascript,java]:
        (String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")"),
    [d]:
        (String,ws,".",ws,"indexOfAny",ws,"(",ws,Substring,ws,")"),
    ['c#']:
        (String,ws,".",ws,"IndexOf",ws,"(",ws,Substring,ws,")"),
    [go]:
        ("strings",ws,".",ws,"Index",ws,"(",ws,String,ws,",",ws,Substring,ws,")"),
    [perl]:
        ("index",ws,"(",ws,String,ws,",",ws,Substring,ws,")")
    ]).

expr(Data,[array,Type],array_slice(Str_,Index1_,Index2_)) -->
        {
                A = parentheses_expr(Data,[array,Type],Str_),
                B = parentheses_expr(Data,int,Index1_),
                C = parentheses_expr(Data,int,Index2_)
        },
        langs_to_output(Data,array_slice,[
			['python']:
                (A,python_ws,"[",python_ws,B,python_ws,":",python_ws,C,python_ws,"]")
        ]).

expr(Data,string,substring(Str_,Index1_,Index2_)) -->
        {
                A = parentheses_expr(Data,string,Str_),
                B = parentheses_expr(Data,int,Index1_),
                C = parentheses_expr(Data,int,Index2_)
        },
		langs_to_output(Data,substring,[
		['javascript','coffeescript','typescript','java','scala','dart']:
                (A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,")"),
        ['c++']:
                (A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,"-",ws,B,ws,")"),
        ['z3']:
                ("(",ws,"Substring",ws_,A,ws_,B,ws_,C,ws,")"),
        ['cython','python','icon','go']:
                (A,python_ws,"[",python_ws,B,python_ws,":",python_ws,C,python_ws,"]"),
        ['julia:']:
                (A,ws,"[",ws,B,ws,"-",ws,"1",ws,":",ws,C,ws,"]"),
        ['fortran']:
                (A,ws,"(",ws,B,ws,":",ws,C,ws,")"),
        ['c#','nemerle']:
                (A,ws,".",ws,"Substring",ws,"(",ws,B,ws,",",ws,C,ws,")"),
        ['haskell']:
                ("take",ws,"(",ws,C,ws,"-",ws,B,ws,")",ws,".",ws,"drop",ws,B,ws,"$",ws,A),
        ['php','awk','perl','hack']:
                ("substr",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")"),
        ['haxe']:
                (A,ws,".",ws,"substr",ws,"(",ws,B,ws,",",ws,C,ws,")"),
        ['rebol']:
                ("copy/part",ws_,"skip",ws_,A,ws_,B,ws_,C),
        ['clojure']:
                ("(",ws,"subs",ws_,A,ws_,B,ws_,C,ws,")"),
        ['erlang']:
                ("string",ws,":",ws,"sub_string",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")"),
        ['pike','groovy']:
                (A,ws,"[",ws,B,ws,"..",ws,C,ws,"]"),
        ['racket']:
                ("(",ws,"substring",ws_,A,ws_,B,ws_,C,ws,")"),
        ['common lisp']:
                ("(",ws,"subseq",ws_,A,ws_,B,ws_,C,ws,")")
        ]).

expr(Data,bool,not(A1)) -->
        {
                A = parentheses_expr(Data,bool,A1)
        },
        langs_to_output(Data,'not',[
        ['cython','python','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','racket','common lisp','rebol','haskell','sibilant']:
                ("(",python_ws,"not",python_ws_,A,python_ws,")"),
        ['java','perl 6','katahdin','coffeescript','frink','d','ooc','ceylon','processing','janus','pawn','autohotkey','groovy','scala','hack','rust','octave','typescript','julia','awk','swift','scala','vala','nemerle','pike','perl','c','c++','objective-c','tcl','javascript','r','dart','java','go','php','haxe','c#','wolfram']:
                ("!",A),
        ['prolog']:
                ("\\+",A),
        ['visual basic','autoit','livecode','monkey x','vbscript']:
                ("(",ws,"Not",ws_,A,ws,")"),
        ['fortran']:
                (".NOT.",A),
        ['gambas']:
                ("NOT",ws_,A),
        ['rexx']:
                ("\\",A),
        ['pl/i']:
                ("^",A),
        ['powershell']:
                ("-not",ws_,A),
        ['polish notation']:
                ("not",ws_,A,ws_,"b"),
        ['reverse polish notation']:
                (A,ws_,"not"),
        ['z3py']:
                ("Not",ws,"(",ws,A,ws,")")
        ]).

expr(Data,bool, and(A_,B_)) -->
        {A = parentheses_expr(Data,bool,A_),
        B = expr(Data,bool,B_)},
    langs_to_output(Data,'and',[
    ['javascript','ats','ruby','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r']:
			(A,ws,"&&",ws,B),
	['pydatalog']:
			(A,ws,"&",ws,B),
	['seed7','python','lua','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php']:
			(A,python_ws_,"and",python_ws_,B),
	['minizinc']:
			(A,ws,"/\\",ws,B),
	['fortran']:
			(A,ws,".AND.",ws,B),
	['common lisp','z3','newlisp','racket','clojure','sibilant','hy','clips','emacs lisp']:
			("(",ws,"and",ws_,A,ws_,B,ws,")"),
	['prolog']:
			(A,ws,",",ws,B),
	['visual basic','vbscript','openoffice basic','monkey x','visual basic .net']:
			(A,ws_,"And",ws_,B),
	['polish notation']:
			("and",ws_,A,ws_,B),
	['reverse polish notation']:
			(A,ws_,B,ws_,"and"),
	['z3py']:
			("And",python_ws,"(",python_ws,A,python_ws,",",python_ws,B,python_ws,")")
    ]).

expr(Data,bool,int_not_equal(A,B)) -->
        langs_to_output(Data,'int_not_equal',[
        [javascript,php,elixir]:
                (infix_operator(Data,int,("!==";"!="),A,B)),
        [java,'ruby',python,cosmos,nim,octave,r,picat,englishscript,'perl 6',wolfram,c,'c++',d,'c#',julia,perl,haxe,cython,minizinc,scala,swift,go,rust,vala]:
                (infix_operator(Data,int,"!=",A,B)),
        [rebol,scriptol,seed7,'visual basic','visual basic .net',gap,ocaml,livecode,'monkey x',vbscript,delphi]:
                (infix_operator(Data,int,"<>",A,B)),
        ['common lisp',z3]:
                ("(","not",ws,"(","=",ws_,A,ws_,B,")",")")
        ]).                
                
expr(Data,bool,greater_than(A,B)) -->
        langs_to_output(Data,'greater_than',[
        ['pascal','elixir','python','visual basic .net','ruby','lua','scriptol', 'z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(Data,int,">",A,B)),
        ['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript']:
                ("(",ws,">",ws_,A,ws_,B,ws,")")
        ]).
expr(Data,bool,greater_than_or_equal(A,B)) -->
        langs_to_output(Data,'greater_than_or_equal',[
        ['pascal','elixir','visual basic .net','python','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(Data,int,">=",A,B))
        ]).                
expr(Data,bool,less_than_or_equal(A,B)) -->
        langs_to_output(Data,less_than_or_equal,[
        ['pascal','python','elixir','visual basic .net','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(Data,int,"<=",A,B))
        ]).                
expr(Data,bool,less_than(A,B)) -->
        langs_to_output(Data,less_than,[
        ['pascal','visual basic .net','lua','ruby','python','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(Data,int,"<",A,B)),
        ['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript']:
                ("(",ws,"<",ws_,A,ws_,B,ws,")")
        ]).

expr(Data,bool,compare(int,Var1_,Var2_)) -->
        {Var1=parentheses_expr(Data,int,Var1_),Var2=expr(Data,int,Var2_)},
        langs_to_output(Data,compare,[
        ['r']:
                ("identical",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")"),
        ['nim','python','lua','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (Var1,python_ws,"==",python_ws,Var2),
        ['javascript','php','typescript','hack']:
                (Var1,ws,"===",ws,Var2),
        ['z3','emacs lisp','common lisp','clips','racket']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['fortran']:
                (Var1,ws,".eq.",ws,Var2),
        ['maxima','seed7','monkey x','gap','rebol','f#','autoit','pascal','delphi','visual basic','ocaml','livecode','vbscript']:
                (Var1,ws,"=",ws,Var2),
        ['prolog']:
                (Var1,ws,"=:=",ws,Var2),
        ['clojure']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['reverse polish notation']:
                (Var1,ws_,Var2,ws_,"="),
        ['polish notation']:
                ("=",ws_,Var1,ws_,Var2)
        ]).        
        
expr(Data,bool,compare(bool,Exp1,Exp2)) -->
        langs_to_output(Data,compare,[
        ['nim','python','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (infix_operator(Data,bool,"==",Exp1,Exp2)),
        [javascript,php]:
                (infix_operator(Data,bool,("===";"=="),Exp1,Exp2)),
        [prolog]:
                (infix_operator(Data,bool,"=",Exp1,Exp2))
        ]).

expr(Data,bool,compare([array,Type],Exp1_,Exp2_)) -->
        {
                A = parentheses_expr(Data,[array,Type],Exp1_),
                B = expr(Data,[array,Type],Exp2_)
        },
        langs_to_output(Data,compare_arrays,[
			['python','ruby']:
				(A,python_ws,"==",python_ws,B),
			['c++']:
				("std::equal(std::begin(",ws,A,ws,"),std::end(",ws,A,ws,"),std::begin(",ws,B,ws,"))"),
			['php']:
				(A,ws,"===",ws,B),
			['c#']:
				(A,ws,".",ws,"SequenceEqual",ws,"(",ws,B,ws,")"),
			['java']:
				("Arrays",ws,".",ws,"deepEquals",ws,"(",ws,A,ws,",",ws,B,ws,")")
        ]).

expr(Data,bool,compare(string,Exp1_,Exp2_)) -->
        {
                A = parentheses_expr(Data,string,Exp1_),
                B = expr(Data,string,Exp2_)
        },
    langs_to_output(Data,compare_strings,[
    ['r']:
			("identical",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['emacs lisp']:
			("(",ws,"string=",ws_,A,ws_,B,ws,")"),
	['clojure']:
			("(",ws,"=",ws_,A,ws_,B,ws,")"),
	['visual basic','delphi','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x']:
			(A,ws,"=",ws,B),
	['pydatalog','python','perl 6','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','swift']:
			(A,python_ws,"==",python_ws,B),
	['javascript','php','typescript','hack']:
			(A,ws,"===",ws,B),
	['c','octave']:
			("strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"==",ws,"0"),
	['c++']:
			(A,ws,".",ws,"compare",ws,"(",ws,B,ws,")"),
	['c#']:
			(A,ws,".",ws,"Equals",ws,"(",ws,B,ws,")"),
	['java']:
			(A,ws,".",ws,"equals",ws,"(",ws,B,ws,")"),
	['common lisp']:
			("(",ws,"equal",ws_,A,ws_,B,ws,")"),
	['clips']:
			("(",ws,"str-compare",ws_,A,ws_,B,ws,")"),
	['hy']:
			("(",ws,"=",ws_,A,ws_,B,ws,")"),
	['perl']:
			(A,ws_,"eq",ws_,B),
	['erlang']:
			("string",ws,":",ws,"equal",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['polish notation']:
			("=",ws_,A,ws_,B),
	['reverse polish notation']:
			(A,ws_,B,ws_,"=")
    ]).

expr(Data,string,concatenate_string(A_,B_)) -->
        {
                Data = [Lang|_],
                B = expr(Data,string,B_),
                A = parentheses_expr(Data,string,A_)
        },
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

expr(Data,int,mod(A_,B_)) -->
	{
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
    langs_to_output(Data,mod,[
    ['java','perl 6','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','tcl','go','dart','javascript','c','c++','c#']:
        (A,python_ws,"%",python_ws,B),
    ['rebol']:
        ("mod",ws_,A,ws_,B),
    ['haskell','seed7','minizinc','ocaml','delphi','pascal','picat','livecode']:
        (A,ws_,"mod",ws_,B),
    ['prolog','octave','matlab','autohotkey','fortran']:
        ("mod",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['erlang']:
        (A,ws_,"rem",ws_,B),
    ['clips','clojure','common lisp','z3']:
        ("(",ws,"mod",ws_,A,ws_,B,ws,")"),
    ['visual basic','monkey x']:
        (A,ws_,"Mod",ws_,B),
    ['wolfram']:
        ("Mod",ws,"[",ws,A,ws,",",ws,B,ws,"]")
    ]).

expr(Data,int,arithmetic(Exp1_,Exp2_,Symbol)) -->
        {
                Exp1 = parentheses_expr(Data,int,Exp1_),
                Exp2 = expr(Data,int,Exp2_),
                member(Symbol,["+","-","*","/"])
        },
        langs_to_output(Data,arithmetic,[
        ['java', 'visual basic .net', 'python', 'ruby', 'lua','logtalk', 'prolog', 'cosmos','pydatalog','e','livecode','vbscript','monkey x','englishscript','gap','pop-11','dafny','janus','wolfram','chapel','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','b-prolog','agda','picat','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','erlang','gambas','hack','c++','matlab','rebol','red','go','awk','haskell','perl','javascript','c#','php','r','haxe','visual basic','vala','bc']:
                (Exp1,python_ws,Symbol,python_ws,Exp2),
        ['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript']:
                ("(",ws,Symbol,ws_,Exp1,ws_,Exp2,ws,")")
        ]).

expr(Data,int,pow(Exp1_,Exp2_)) -->
	{
		A = parentheses_expr(Data,int,Exp1_),
		B = parentheses_expr(Data,int,Exp2_)
	},
    langs_to_output(Data,pow,[
	['scala']:
			("scala.math.pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['c#']:
			("Math",ws,".",ws,"Pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['javascript','java','typescript','haxe']:
			("Math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['seed7','cython','python','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran']:
			("(",python_ws,A,python_ws,"**",python_ws,B,python_ws,")"),
	['rebol']:
			("power",ws_,A,ws_,B),
	['c','c++','php','hack','swift','minizinc','dart','d']:
			("pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
	['julia','engscript','visual basic','gambas','go','ceylon','wolfram','mathematical notation']:
			(A,ws,"^",ws,B),
	['hy','common lisp','racket','clojure']:
			("(",ws,"expt",ws_,"num1",ws_,"num2",ws,")"),
	['erlang']:
			("math",ws,":",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")")
    ]).


expr(Data,[array,string],split(Exp1,Exp2)) -->
	{
		AString = parentheses_expr(Data,string,Exp1),
		Separator = parentheses_expr(Data,string,Exp2)
	},
    langs_to_output(Data,split,[
    ['swift']:
			(AString,ws,".",ws,"componentsSeparatedByString",ws,"(",ws,Separator,ws,")"),
	['octave']:
			("strsplit",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
	['go']:
			("strings",ws,".",ws,"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
	['javascript','python','coffeescript','java','dart','scala','groovy','haxe','rust','typescript','cython','vala']:
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

expr(Data,[array,Type],concatenate_arrays(A1_,A2_)) -->
        {
                A1 = parentheses_expr(Data,[array,Type],A1_),
                A2 = parentheses_expr(Data,[array,Type],A2_)
        },
        langs_to_output(Data,concatenate_arrays,[
        [javascript]:
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")"),
        [haskell]:
                (A1,ws,"++",ws,A2),
        [python,ruby]:
                (A1,ws,"+",ws,A2),
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

expr(Data,string,join(Exp1,Exp2)) -->
        {
                Array = parentheses_expr(Data,[array,string],Exp1),
                Separator = parentheses_expr(Data,string,Exp2)
        },
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
        
expr(Data,int,sqrt(Exp1)) -->
        {
                X = expr(Data,int,Exp1)
        },
		langs_to_output(Data,sqrt,[
		['livecode']:
                ("(",ws,"the",ws_,"sqrt",ws_,"of",ws_,X,ws,")"),
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"sqrt",ws,"(",ws,X,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Sqrt",ws,"(",ws,X,ws,")"),
        ['c','seed7','julia','perl','php','perl 6','maxima','minizinc','prolog','octave','d','haskell','swift','mathematical notation','dart','picat']:
                ("sqrt",ws,"(",ws,X,ws,")"),
        ['rebol']:
                ("square-root",ws_,X),
        ['scala']:
                ("scala",ws,".",ws,"math",ws,".",ws,"sqrt",ws,"(",ws,X,ws,")"),
        ['c++']:
                ("std",ws,"::",ws,"sqrt",ws,"(",ws,X,ws,")"),
        ['erlang']:
                ("math",ws,":",ws,"sqrt",ws,"(",ws,X,ws,")"),
        ['wolfram']:
                ("Sqrt",ws,"[",ws,X,ws,"]"),
        ['common lisp','racket']:
                ("(",ws,"sqrt",ws_,X,ws,")"),
        ['fortran']:
                ("SQRT",ws,"(",ws,X,ws,")"),
        ['go']:
                ("math",ws,".",ws,"Sqrt",ws,"(",ws,X,ws,")")
        ]).

expr(Data,Type1,list_comprehension(Result1,Var1,Condition1,Array1)) -->
        {
                Variable = var_name(Data,Type,Var1),
                Array = expr(Data,[array,Type],Array1),
                Result = expr(Data,Type1,Result1),
                Condition = expr(Data,bool,Condition1)
        },
        langs_to_output(Data,list_comprehension,[
        ['cython','python']:
                ("[",python_ws,Result,python_ws_,"for",python_ws_,Variable,python_ws_,"in",python_ws_,Array,python_ws_,"if",python_ws_,Condition,python_ws,"]"),
        ['ceylon']:
                ("{",ws,"for",ws,"(",ws,Variable,ws_,"in",ws_,Array,ws,")",ws_,"if",ws,"(",ws,Condition,ws,")",ws_,Result,ws,"}"),
        ['javascript']:
                ("[",ws,Result,ws_,"for",ws,"(",ws,Variable,ws_,"of",ws_,Array,ws,")",ws,"if",ws_,Condition,ws,"]"),
        ['coffeescript']:
                ("(",ws,Result,ws_,"for",ws_,Variable,ws_,"in",ws_,Array,ws_,"when",ws_,Condition,ws,")"),
        ['minizinc']:
                ("[",ws,Result,ws,"|",ws,Variable,ws_,"in",ws_,Array,ws_,"where",ws_,Condition,ws,"]"),
        ['haxe']:
                ("[",ws,"for",ws,"(",ws,Variable,ws_,"in",ws_,Array,ws,")",ws,"if",ws,"(",ws,Condition,ws,")",ws,Result,ws,"]"),
        ['c#']:
                ("(",ws,"from",ws_,Variable,ws_,"in",ws_,Array,ws_,"where",ws_,Condition,ws_,"select",ws_,Result,ws,")"),
        ['haskell']:
                ("[",ws,Result,ws,"|",ws,Variable,ws,"<-",ws,Array,ws,",",ws,Condition,ws,"]"),
        ['erlang']:
                ("[",ws,Result,ws,"||",ws,Variable,ws,"<-",ws,Array,ws,",",ws,Condition,ws,"]"),
        ['scala']:
                ("(",ws,"for",ws,"(",ws,Variable,ws,"<-",ws,Array,ws_,"if",ws_,Condition,ws,")",ws,"yield",ws_,Result,ws,")"),
        ['groovy']:
                ("array.grep",ws,"{",ws,Variable,ws,"->",ws,Condition,ws,"}.collect",ws,"{",ws,Variable,ws,"->",ws,Result,ws,"}"),
        ['dart']:
                (Array,ws,".",ws,"where",ws,"(",ws,Variable,ws,"=>",ws,Condition,ws,")",ws,".",ws,"map",ws,"(",ws,Variable,ws,"=>",ws,Result,ws,")"),
        ['picat']:
                ("[",ws,Result,ws,":",ws,Variable,ws_,"in",ws_,Array,ws,",",ws,Condition,ws,"]")
        ]).

expr(Data,string,charAt(Str_,Int_)) -->
        {
                AString = parentheses_expr(Data,string,Str_),
                Index = expr(Data,int,Int_)
        },
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

expr(Data,string,endswith(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = expr(Data,string,Str2_)
        },
        langs_to_output(Data,endswith,[
        [java,javascript]:
                (Str1,ws,".",ws,"endsWith",ws,"(",ws,Str2,ws,")"),
        [java,'c#']:
                (Str1,ws,".",ws,"EndsWith",ws,"(",ws,Str2,ws,")")
        ]).

expr(Data,string,reverse_string(Str_)) -->
        {
                Str = expr(Data,string,Str_)
        },
        langs_to_output(Data,reverse_string,[
        [java]:
                ("new",ws_,"StringBuilder",ws,"(",ws,Str,ws,")",ws,".",ws,"reverse",ws,"(",ws,")",ws,".",ws,"toString",ws,"(",ws,")"),
        [perl]:
                ("reverse",ws,"(",Str,")"),
        [php]:
                ("strrev",ws,"(",ws,Str,ws,")"),
        [javascript]:
                ("esrever",ws,".",ws,"reverse",ws,"(",ws,Str,ws,")")
        ]).

%https://en.wikipedia.org/wiki/Comparison_of_programming_languages_(string_functions)#trim
expr(Data,string,trim(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        langs_to_output(Data,trim,[
        [java,javascript]:
                (Str,ws,".",ws,"trim",ws,"(",ws,")"),
        ['perl 6']:
                (Str,ws,".",ws,"trim"),
        [php]:
			"trim",ws,"(",ws,Str,ws,")",
		[clojure]:
			"(",ws,".trim",ws_,Str,ws,")",
		[ocaml]:
			"(",ws,"String.trim",ws_,Str,ws,")"
        ]).

%all characters to lowercase
expr(Data,string,lowercase(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        langs_to_output(Data,lowercase,[
        [java,javascript]:
                (Str,ws,".",ws,"toLowerCase",ws,"(",ws,")"),
        [perl]:
                ("lc",ws,"(",ws,Str,ws,")"),
        [seed7]:
                ("tolower",ws,"(",ws,Str,ws,")"),
        [mathematica]:
                ("ToLowerCase",ws,"[",ws,Str,ws,"]"),
        [erlang]:
                ("tolower",ws,"(",ws,Str,ws,")"),
        [freebasic]:
                ("lcase",ws,"(",ws,Str,ws,")"),
        [php]:
                ("strtolower",ws,"(",ws,Str,ws,")")
        ]).

%all characters to uppercase
expr(Data,string,uppercase(Str_)) -->
        {
                Str = parentheses_expr(Data,string,Str_)
        },
        langs_to_output(Data,uppercase,[
        [perl]:
                ("uc",ws,"(",ws,Str,ws,")")
        ]).

expr(Data,bool,array_contains(Str1_,Str2_)) -->
        {
                Container = parentheses_expr(Data,[array,Type],Str1_),
                Contained = parentheses_expr(Data,Type,Str2_)
        },
        langs_to_output(Data,array_contains,[
        ['julia','minizinc']:
                (Container,python_ws_,"in",python_ws_,Contained),
        ['swift']:
                ("contains",ws,"(",ws,Container,ws,",",ws,Contained,ws,")"),
        ['prolog']:
				("member",ws,"(",ws,Contained,ws,",",ws,Container,ws,")"),
        ['lua']:
                (Container,ws,"[",ws,Contained,ws,"]",ws,"~=",ws,"nil"),
        ['rebol']:
                ("not",ws_,"none?",ws_,"find",ws_,Container,ws_,Contained),
        ['javascript','coffeescript']:
                (Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!==",ws,"-1"),
        ['coffeescript']:
                (Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!=",ws,"-1"),
        ['ruby']:
                (Container,ws,".",ws,"include?",ws,"(",ws,Contained,ws,")"),
        ['haxe']:
                ("Lambda",ws,".",ws,"has",ws,"(",ws,Container,ws,",",ws,Contained,ws,")"),
        ['php']:
                ("in_array",ws,"(",ws,Container,ws,",",ws,Container,ws,")"),
        ['c#']:
                (Container,ws,".",ws,"Contains",ws,"(",ws,Contained,ws,")"),
        ['java']:
                ("Arrays",ws,".",ws,"asList",ws,"(",ws,Container,ws,")",ws,".",ws,"contains",ws,"(",ws,Contained,ws,")"),
        ['haskell']:
                ("(",ws,"elem",ws_,Contained,ws_,Container,ws,")"),
        ['c++']:
                ("(",ws,"std",ws,"::",ws,"find",ws,"(",ws,"Std",ws,"(",ws,Container,ws,")",ws,",",ws,"std",ws,"::",ws,"end",ws,"(",ws,Container,ws,")",ws,",",ws,Contained,ws,")",ws,"!=",ws,"std",ws,"::",ws,"end",ws,"(",ws,Container,ws,")",ws,")")
        ]).

expr(Data,bool,string_contains(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = parentheses_expr(Data,string,Str2_)
        },
        langs_to_output(Data,string_contains,[
        [c]:
                ("(",ws,"strstr",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"NULL",ws,")"),
        [java]:
                (Str1,ws,".",ws,"contains",ws,"(",ws,Str2,ws,")"),
        ['python']:
                (Str1,python_ws,".",python_ws,"find",python_ws,"(",python_ws,Str2,python_ws,")"),
        ['c#']:
                (Str1,ws,".",ws,"Contains",ws,"(",ws,Str2,ws,")"),
        [perl]:
                ("(",ws,"index",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"-1",ws,")"),
        [javascript]:
                ("(",ws,Str1,ws,".",ws,"indexOf",ws,"(",ws,Str2,ws,")",ws,(">";"!==";"!="),ws,"-1",ws,")")
        ]).


expr(Data,string,startswith(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = parentheses_expr(Data,string,Str2_)
        },
        langs_to_output(Data,startswith,[
        [java,javascript]:
                (Str1,ws,".",ws,"startsWith",ws,"(",ws,Str2,ws,")"),
        [swift]:
                (Str1,ws,".",ws,"hasPrefix",ws,"(",ws,Str2,ws,")"),
        ['c#']:
                (Str1,ws,".",ws,"StartsWith",ws,"(",ws,Str2,ws,")"),
        [haskell]:
                ("(",ws,"isInfixOf",ws_,Str2,ws_,Str1,ws,")"),
        [c]:
                ("(",ws,"strncmp",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",ws,"strlen",ws,"(",ws,Str2,ws,")",ws,")",ws,"==",ws,"0",ws,")")
        ]).
        
expr(Data,Type,parentheses_expr(A)) --> parentheses_expr(Data,Type,A).

expr(Data,Type,access_array(Array_,Index_)) -->
        {
                Array = parentheses_expr(Data,[array,Type],Array_),
                dif(Array,"this"),
                Index = parentheses_expr(Data,int,Index_)
        },
        langs_to_output(Data,access_array,[
        ['ruby','c#','julia','d','swift','julia','janus','minizinc','picat','nim','autoit','cython','python','coffeescript','dart','typescript','awk','vala','perl','java','javascript','go','c++','php','haxe','c']:
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


expr(Data,Type,this(A_)) -->
	{A = var_name(Data,Type,A_)},
	langs_to_output(Data,this,[
	['coffeescript']:
			("@",A),
	['java','engscript','dart','groovy','typescript','javascript','c#','c++','haxe','chapel','julia']:
			("this",ws,".",ws,A),
	['php','hack']:
			("$",ws,"this",ws,"->",ws,A),
	['swift','scala']:
			(A),
	['rebol']:
			("self",ws,"/",ws,A),
	['perl']:
			("$self",ws,"->",ws,A)
    ]).

expr(Data,Type,access_dict(Dict_,Index_)) -->
        {
                Dict = var_name(Data,[dict,Type],Dict_),
                Index = expr(Data,int,Index_)
        },
        langs_to_output(Data,access_dict,[
        [javascript,'c++','haxe']:
			((Dict,ws,"[",ws,Index,ws,"]")),
		[javascript,'c++','haxe']:
			((Dict,ws,".",ws,"get",ws,"(",ws,Index,ws,")")),
        [perl]:
			("$",symbol(Dict_),ws,"{",ws,Index,ws,"}")
        ]).     
        
expr(Data,[array,string],command_line_args) -->
        langs_to_output(Data,command_line_args,[
        [perl]:
                ("@ARGV"),
        [javascript]:
                ("process",ws,".",ws,"argv",ws,".",ws,"slice",ws,"(",ws,"2",ws,")")
        ]).

expr(Data,Class_name_,call_constructor(Params1,Params2)) -->
	{
			Name = function_name(Data,Class_name_,Class_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    langs_to_output(Data,call_constructor,[
    ['java','javascript','haxe','chapel','scala','php']:
		("new",ws_,Name,ws,"(",ws,Args,ws,")"),
	['visual basic','visual basic .net']:
		("New",ws_,Name,ws,"(",ws,Args,ws,")"),
	['perl','perl 6']:
		(Name,ws,"->",ws,"new",ws,"(",ws,Args,ws,")"),
	['swift','octave']:
		(Name,python_ws,"(",python_ws,Args,python_ws,")"),
	['c++']:
		(Name,"::",Name,ws,"(",ws,Args,ws,")"),
	['hy']:
		("(",ws,Name,ws_,Args,ws,")")
    ]).


expr(Data,int,strlen(A1)) -->
        {
                A = parentheses_expr(Data,string,A1)
        },
		langs_to_output(Data,strlen,[
		['go','erlang','nim']:
                ("len",ws,"(",ws,A,ws,")"),
        ['go','erlang','nim']:
                ("len",ws,"(",ws,A,ws,")"),
        ['r']:
                ("nchar",ws,"(",ws,A,ws,")"),
        ['erlang']:
                ("string:len",ws,"(",ws,A,ws,")"),
        ['visual basic','visual basic .net','gambas']:
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


expr(Data,regex,new_regex(A1)) -->
        {
                A = expr(Data,string,A1)
        },
		langs_to_output(Data,new_regex,[
		['scala','c#']:
			("new",ws,"Regex",ws,"(",ws,A,ws,")"),
		['javascript']:
			("new",ws,"RegExp",ws,"(",ws,A,ws,")"),
		['c++']:
			("regex",ws,"::",ws,"regex",ws,"(",ws,A,ws,")")
        ]).
expr(Data,bool,regex_matches_string(Str1,Reg1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,regex,Reg1)
        },
		langs_to_output(Data,regex_matches_string,[
		['javascript']:
			(Reg,ws,".",ws,"test",ws,"(",ws,Str,ws,")"),
		['c#']:
			(Reg,ws,".",ws,"IsMatch",ws,"(",ws,Str,ws,")"),
		['haxe']:
			(Reg,ws,".",ws,"match",ws,"(",ws,Str,ws,")")
        ]).

expr(Data,bool,string_matches_string(Str1,Reg1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,string,Reg1)
        },
		langs_to_output(Data,string_matches_string,[
		['java']:
			(Str,ws,".",ws,"matches",ws,"(",ws,Reg,ws,")"),
		['php']:
			("preg_match",ws,"(",ws,Reg,ws,",",ws,Str,ws,")")
        ]).

		

expr(Data,int,array_length(A1,Type)) -->
        {
                A = parentheses_expr(Data,[array,Type],A1)
        },
		langs_to_output(Data,array_length,[
        ['go']:
                ("len",ws,"(",ws,A,ws,")"),
        ['cython','python']:
                ("len",python_ws,"(",python_ws,A,python_ws,")"),
        ['java','picat','scala','d','coffeescript','typescript','dart','vala','javascript','haxe','cobra']:
                (A,ws,".",ws,"length"),
        ['c#','visual basic','visual basic .net','powershell']:
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

statement(Data,grammar_statement(Name_,Body_)) -->
	{
	Name=var_name(Data,grammar,Name_),
	Body=expr(Data,grammar,Body_)
	},
	langs_to_output(Data,grammar_statement,[
	['pegjs']:
		(Name,ws,"=",ws,Body)
    ]).

statement(Data,import(Module_)) -->
        {A = symbol(Module_)},
        langs_to_output(Data,import,[
        ['r']:
                ("source",ws,"(",ws,"\"",ws,A,ws,".",ws,"r\"",ws,")"),
        ['javascript']:
                ("import",ws_,"*",ws_,"as",ws_,A,ws_,"from",ws_,"'",ws,A,ws,"'",ws,";"),
        ['clojure']:
                ("(",ws,"import",ws_,A,ws,")"),
        ['monkey x']:
                ("Import",ws_,A),
        ['fortran']:
                ("USE",ws_,A),
        ['rebol']:
                (A,ws,":",ws_,"load",ws_,"%",ws,A,ws,".r"),
        ['prolog']:
                (":-",ws,"consult(",ws,A,ws,")"),
        ['minizinc']:
                ("include",ws_,"'",ws,A,ws,".mzn'",ws,";"),
        ['php']:
                ("include",ws_,"'",ws,A,ws,".php'",ws,";"),
        ['c','c++']:
                ("#include",ws_,"\"",ws,A,ws,".h\""),
        ['c#','vala']:
                ("using",ws_,A,ws,";"),
        ['julia']:
                ("using",ws_,A),
        ['haskell','purescript','engscript','scala','go','groovy','picat','elm','swift','monkey x']:
                ("import",ws_,A),
        ['java','d','haxe','ceylon']:
                ("import",ws_,A,ws,";"),
        ['dart']:
                ("import",ws_,"'",ws,A,ws,".dart'",ws,";"),
        ['perl','perl 6','chapel']:
                ("\"use",ws,A,ws,";\"")
        ]).

statement(Data,enum(Name1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Namespace,Name1],Var_types,indent(Indent)],
                Name = symbol(Name1),
                Body = enum_list(Data1,Body1)
        },
        langs_to_output(Data,enum,[
        ['c']:
                ("typedef",ws_,"enum",ws,"{",ws,Body,(Indent;ws),"}",ws,Name,ws,";"),
        ['seed7']:
                ("const",ws_,"type",ws,":",ws,Name,ws_,"is",ws_,"new",ws_,"enum",ws_,Body,(Indent;ws_),"end",ws_,"enum",ws,";"),
        ['ada']:
                ("type",ws_,Name,ws_,"is",ws_,"(",ws,Body,ws,")",ws,";"),
        ['perl 6']:
                ("enum",ws_,Name,ws_,"<",ws,Body,ws,">",ws,";"),
        ['java']:
                ("public",ws_,"enum",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
        ['c#','c++','typescript']:
                ("enum",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}",ws,";"),
        ['haxe','rust','swift','vala']:
                ("enum",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
        ['swift']:
                ("enum",ws_,Name,ws,"{",ws,"case",ws_,Body,(Indent;ws),"}"),
        ['fortran']:
                ("ENUM",ws,"::",ws,Name,ws_,Body,(Indent;ws_),"END",ws_,"ENUM"),
        ['go']:
                ("type",ws_,Name,ws_,"int",ws_,"const",ws,"(",ws_,Body,ws_,")"),
        ['scala']:
                ("object",ws_,Name,ws_,"extends",ws_,"Enumeration",ws,"{",ws,"val",ws_,Body,ws,"=",ws,"Value",ws,"}")
        ]).

statement(Data,Type1,function(Name1,Type1,Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = function_name(Data,Type1,Name1,Params1),
                Type = type(Data,Type1),
                Body = statements(Data1,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
		optional_indent(Data,Indent),langs_to_output(Data,function,[
		['c++','vala','c','dart','ceylon','pike','d','englishscript']:
                (Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
		['coffeescript']:
				(Name,python_ws,"=",python_ws,"(",python_ws,Params,python_ws,")",python_ws,"->",python_ws,Body),
		['python']:
				("def",python_ws_,Name,"(",Params,")",":",python_ws,Body),
		['sql']:
                ("CREATE",ws_,"FUNCTION",ws_,"dbo",ws,".",ws,Name,ws,"(",ws,"function_parameters",ws,")",ws_,"RETURNS",ws_,Type,ws_,Body),
        ['hy']:
				("(",ws,"defn",ws_,Name,ws_,"[",ws,Params,ws,"]",ws_,Body,ws,")"),
        ['seed7']:
                ("const",ws_,"func",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws_,"is",ws_,"func",ws_,"begin",ws_,Body,(Indent;ws_),"end",ws_,"func",ws,";"),
        ['livecode']:
                ("function",ws_,Name,ws_,Params,ws_,Body,(Indent;ws_),"end",ws_,Name),
        ['monkey x']:
                ("Function",ws,Name,ws,":",ws,Type,ws,"(",ws,Params,ws,")",ws,Body,(Indent;ws_),"End"),
        ['emacs lisp']:
                ("(",ws,"defun",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,Body,ws,")"),
        ['go']:
                ("func",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['pydatalog']:
                (Name,ws,"(",ws,Params,ws,")",ws,"<=",ws,Body),
        ['java','c#']:
                ("public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['javascript','php']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['julia','lua']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['wolfram']:
                (Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,Body),
        ['frink']:
                (Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,"{",ws,Body,(Indent;ws),"}"),
        ['pop-11']:
                ("define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,"Result;",ws_,Body,(Indent;ws_),"enddefine;"),
        ['z3']:
                ("(",ws,"define-fun",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws_,Body,ws,")"),
        ['mathematical notation']:
                (Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"{",ws,Body,(Indent;ws),"}"),
        ['chapel']:
                ("proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['prolog',logtalk]:
                (Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body),
        ['picat']:
                (Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"retval",ws,"=>",ws,Body),
        ['swift']:
                ("func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['maxima']:
                (Name,ws,"(",ws,Params,ws,")",ws,":=",ws,Body),
        ['rust']:
                ("fn",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['clojure']:
                ("(",ws,"defn",ws,Name,ws,"[",ws,Params,ws,"]",ws,Body,ws,")"),
        ['octave']:
                ("function",ws_,"retval",ws,"=",ws,Name,ws,"(",ws,Params,ws,")",ws,Body,(Indent;ws_),"endfunction"),
        ['haskell']:
                (Name,ws_,Params,ws,"=",ws,Body),
        ['common lisp']:
                ("(defun",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")"),
        ['fortran']:
                ("FUNC",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,"RESULT",ws,"(",ws,"retval",ws,")",ws_,Type,ws,"::",ws,"retval",ws_,Body,(Indent;ws_),"END",ws_,"FUNCTION",ws_,Name),
        ['scala']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"=",ws,"{",ws,Body,(Indent;ws),"}"),
        ['minizinc']:
                ("function",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body),
        ['clips']:
                ("(",ws,"deffunction",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")"),
        ['erlang']:
                (Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Body),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}"),
        ['perl 6']:
                ("sub",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['pawn']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['ruby']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['elixir']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,"do",ws_,Body,(Indent;ws_),"end"),
        ['typescript']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['rebol']:
                (Name,ws,":",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,Body,ws,"]"),
        ['haxe']:
                ("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['hack']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['r']:
                (Name,ws,"<-",ws,"function",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['bc']:
                ("define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['visual basic','visual basic .net']:
                ("Function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,"As",ws_,Type,ws_,Body,(Indent;ws_),"End",ws_,"Function"),
        ['vbscript']:
                ("Function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"End",(Indent;ws_),"Function"),
        ['racket','newlisp']:
                ("(define",ws,"(name",ws,"params)",ws,Body,ws,")"),
        ['janus']:
                ("procedure",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body),
        ['cosmos']:
                ("rel",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,",",python_ws,"return",python_ws,")",python_ws,Body),
        ['f#']:
                ("let",python_ws_,Name,python_ws_,Params,python_ws,"=",Body),
        ['polish notation']:
                ("=",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body),
        ['reverse polish notation']:
                (Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"="),
        ['ocaml']:
                ("let",ws_,Name,ws_,Params,ws,"=",ws,Body),
        ['e']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['pascal','delphi']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,";",ws,"begin",ws_,Body,(Indent;ws_),"end",ws,";")
        ]).

%java-like class statements
statement(Data,Name1,class(Name1,Body1)) --> 
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = symbol(Name1),
                Body=class_statements(Data1,Name1,Body1)
        },
    optional_indent(Data,Indent),
		langs_to_output(Data,class,[
		['julia']:
                ("type",ws_,Name,ws_,Body,(Indent;ws_),"end"),
        ['java','c#']:
                ("public",ws_,"class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
        ['hy']:
                ("(",ws,"defclass",ws_,Name,ws_,"[",ws,"object",ws,"]",ws_,Body,")"),
        ['perl']:
                ("package",ws_,Name,";",ws,Body),
        ['c++']:
                ("class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}",ws,";"),
        ['logtalk']:
                ("object",ws,"(",Name,")",ws,".",ws,Body,(Indent;ws),"end_object",ws,"."),
        ['javascript','hack','php','scala','haxe','chapel','swift','d','typescript','dart','perl 6']:
                ("class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
        ['vbscript']:
                ("Public",ws_,"Class",ws_,Name,ws_,Body,(Indent;ws_),"End",ws_,"Class"),
        ['monkey x']:
                ("Class",ws_,Name,ws_,Body,(Indent;ws_),"End")
        ]).

statement(Data,C1,class_extends(C1_,C2_,B_)) --> 
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[C1_|Namespace],Var_types,indent(Indent)],
                C1 = symbol(C1_),
                C2 = symbol(C2_),
                B=class_statements(Data1,C1_,B_)
        },
        optional_indent(Data,Indent),langs_to_output(Data,class_extends,[
        ['logtalk']:
                ("object",ws,"(",C1,ws,",",ws,"extends",ws,"(",ws,C2,ws,")",ws,".",ws,B,(Indent;ws),"end_object",ws,"."),
        ['hy']:
                ("(",ws,"defclass",ws_,C1,ws_,"[",ws,C2,ws,"]",ws_,B,")"),
        ['swift','chapel','d','swift']:
                ("class",ws_,C1,ws,":",ws,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['haxe','php','javascript','dart','typescript']:
                ("class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['java','c#','scala']:
                ("public",ws_,"class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['c']:
                ("#include",ws_,"'",ws,C2,ws,".h'",ws_,B),
        ['c++']:
                ("class",ws_,C1,ws,":",ws,"public",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['perl 6']:
                ("class",ws_,C1,ws_,"is",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['monkey x']:
                ("Class",ws_,C1,ws_,"Extends",ws_,C2,ws_,B,(Indent;ws_),"End")
        ]).

statement(Data,Return_type,semicolon(A_)) -->
        {Data = [_,_,_,_,Indent],A=statement_with_semicolon(Data,Return_type,A_),offside_rule_langs(Offside_rule_langs)},
        optional_indent(Data,Indent),
        langs_to_output(Data,semicolon,[
        ['c','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala']:
                (A,ws,";"),
        ['pseudocode']:
                (A,("";ws,";")),
        ['visual basic .net','elixir','erlang','ruby','lua','hy',picolisp,logtalk,minizinc,swift,rebol,fortran,go,picat,julia,prolog,haskell,'mathematical notation',erlang,z3]:
                A,
        Offside_rule_langs:
				(A,python_ws)
        ]).

statement(Data,Return_type,for(Statement1_,Expr_,Statement2_,Body1)) -->
        {
                indent_data(Indent,Data,Data1),
                Body = statements(Data1,Return_type,Body1),
                Statement1 = statement_with_semicolon(Data,Return_type,Statement1_),
                Condition = expr(Data,bool,Expr_),
                Statement2 = statement_with_semicolon(Data,Return_type,Statement2_)
        },
        optional_indent(Data,Indent),
		langs_to_output(Data,for,[
        ['java','d','pawn','groovy','javascript','dart','typescript','php','hack','c#','perl','c++','awk','pike']:
                ("for",ws,"(",ws,Statement1,ws,";",ws,Condition,ws,";",ws,Statement2,ws,")",ws,"{",ws,Body,(Indent;ws),"}")
        ]).

statement(Data,Return_type,lua_foreach(Array1,Var1,Body1,Type1,Index1)) -->
        {
                indent_data(Indent,Data,Data1),
                Array = expr(Data,[array,Type1],Array1),
                Key = var_name(Data,Type1,Var1),
                Value = expr(Data,int,Index1),
                TypeInArray = type(Data,Type1),
                Body = statements(Data1,Return_type,Body1)
        },
        optional_indent(Data,Indent),
        (Data,lua_foreach,[
			['lua']:
				("for",ws_,Key,ws,",",ws,Value,ws_,"in",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end")
			]).

statement(Data,Return_type,foreach(Array1,Var1,Body1,Type1)) -->
        {
                indent_data(Indent,Data,Data1),
                Array = expr(Data,[array,Type1],Array1),
                Var_name = var_name(Data,Type1,Var1),
                TypeInArray = type(Data,Type1),
                Body = statements(Data1,Return_type,Body1)
        },
        optional_indent(Data,Indent),
        langs_to_output(Data,foreach,[
        ['ruby']:
				(Array,ws,".",ws,"each",ws_,"do",ws,"|",ws,Var_name,ws,"|",ws,Body,(Indent;ws_),"end"),
        ['erlang']:
				("foreach",ws,"(",ws,"fun",ws,"(",ws,Var_name,ws,")",ws,"->",ws,Body,ws_,"end",ws,",",ws,Array,ws,")"),
        ['lua']:
				("for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end"),
        ['seed7']:
                ("for",ws_,Var_name,ws_,"range",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end",ws_,"for;"),
        ['javascript','typescript']:
                (Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var_name,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";"),
        ['octave']:
                ("for",ws_,Var_name,ws,"=",ws,Array,ws_,Body,(Indent;ws_),"endfor"),
        ['prolog']:
				("forall",ws,"(",ws,"member",ws,"(",Var_name,ws,",",ws,Array,")",ws,",",ws,Body,ws,")"),
        ['z3']:
                ("(",ws,"forall",ws_,"(",ws,"(",ws,Var_name,ws_,"a",ws,")",ws,")",ws_,"(",ws,"=>",ws,"select",ws_,Array,ws,")",ws,")"),
        ['gap']:
                ("for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,ws_,"od;"),
        ['minizinc']:
                ("forall",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")"),
        ['php','hack']:
                ("foreach",ws,"(",ws,Array,ws_,"as",ws_,Var_name,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['java']:
                ("for",ws,"(",ws,TypeInArray,ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c#','vala']:
                ("foreach",ws,"(",ws,TypeInArray,ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['cython','python']:
                ("for",python_ws_,Var_name,python_ws_,"in",python_ws_,Array,python_ws,":",python_ws,Body),
        ['julia']:
                ("for",ws_,Var_name,ws_,"in",ws_,Array,ws_,Body,(Indent;ws_),"end"),
        ['chapel','swift']:
                ("for",ws_,Var_name,ws_,"in",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}"),
        ['pawn']:
                ("foreach",ws,"(",ws,"new",ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['picat']:
                ("foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")",ws,"end"),
        ['awk','ceylon']:
                ("for",ws_,"(",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['go']:
                ("for",ws_,Var_name,ws,":=",ws,"range",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}"),
        ['haxe','groovy']:
                ("for",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['nemerle','powershell']:
                ("foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['scala']:
                ("for",ws,"(",ws,Var_name,ws,"->",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['rebol']:
                ("foreach",ws_,Var_name,ws_,Array,ws,"[",ws,Body,ws,"]"),
        ['c++']:
                ("for",ws,"(",ws,TypeInArray,ws_,"&",ws_,Var_name,ws,":",ws,Array,ws,"){",ws,Body,(Indent;ws),"}"),
        ['perl']:
                ("for",ws_,Array,ws,"->",ws,Var_name,ws,"{",ws,Body,(Indent;ws),"}"),
        ['d']:
                ("foreach",ws,"(",ws,Var_name,ws,",",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['gambas']:
                ("FOR",ws_,"EACH",ws_,Var_name,ws_,"IN",ws_,Array,ws_,Body,ws_,"NEXT"),
        ['vbscript','visual basic .net']:
                ("For",ws_,"Each",ws_,Var_name,ws_,"In",ws_,Array,ws_,Body,ws_,"Next"),
        ['dart']:
                ("for",ws,"(",ws,"var",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}")
        ]).

statement(Data,Return_type,iff(Expr1,Body1)) -->
        {
                indent_data(Indent,Data,Data1),
                Body = statements(Data1,Return_type,Body1),
                Condition = expr(Data,bool,Expr1)
        },
        Indent,
        langs_to_output(Data,iff,[
        ['z3']:
			("(",ws,"iff",ws_,Condition,ws_,Body,ws_,")")
        ]).

statement(Data,bool,predicate(Name1,Params1,Body1)) -->
		{
		Data = [Lang,Is_input,Namespace,Var_types,Indent],
		Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
		Name = function_name(Data,bool,Name1,Params1),
		Body = statements(Data1,bool,Body1),
		(Params1 = [], Params = ""; Params = parameters(Data1,Params1))
		},
		Indent,
		langs_to_output(Data,predicate,[
		['prolog']:
			(Name,ws,"(",ws,Params,ws,")",ws,":-",ws,Body),
		['minizinc']:
			("predicate",ws_,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body),
		%this is for pydatalog
		['cosmos']:
			("rel",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,")",python_ws,Body,python_ws)
		]).

statement(Data,Return_type,while(Expr1,Body1)) -->
        {
				indent_data(Indent,Data,Data1),
				B = statements(Data1,Return_type,Body1),
                A = expr(Data,bool,Expr1)
        },
        optional_indent(Data,Indent),langs_to_output(Data,while,[
        ['c','perl 6','katahdin','chapel','ooc','processing','pike','kotlin','pawn','powershell','hack','gosu','autohotkey','ceylon','d','typescript','actionscript','nemerle','dart','swift','groovy','scala','java','javascript','php','c#','perl','c++','haxe','r','awk','vala']:
                ("while",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
        ['gap']:
                ("while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"od",ws,";"),
        ['ruby','lua']:
                ("while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end"),
        ['fortran']:
                ("WHILE",ws_,"(",ws,A,ws,")",ws_,"DO",ws_,B,(Indent;ws_),"ENDDO"),
        ['pascal']:
                ("while",ws_,A,ws_,"do",ws_,"begin",ws_,B,(Indent;ws_),"end;"),
        ['delphi']:
                ("While",ws_,A,ws_,"do",ws_,"begin",ws_,B,(Indent;ws_),"end;"),
        ['rust','frink','dafny']:
                ("while",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
        ['julia']:
                ("while",ws_,A,ws_,B,(Indent;ws_),"end"),
        ['picat']:
                ("while",ws_,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"end"),
        ['rebol']:
                ("while",ws,"[",ws,A,ws,"]",ws,"[",ws,B,ws,"]"),
        ['common lisp']:
                ("(",ws,"loop",ws_,"while",ws_,A,ws_,"do",ws_,B,ws,")"),
        ['hy','newlisp','clips']:
                ("(",ws,"while",ws_,A,ws_,B,ws,")"),
        ['cython','python']:
                ("while",python_ws_,A,python_ws,":",B),
        ['coffeescript']:
                ("while",python_ws_,A,python_ws,":",B),
        ['visual basic','visual basic .net','vbscript']:
                ("While",ws_,A,ws_,B,(Indent;ws_),"End",ws_,"While"),
        ['octave']:
                ("while",ws,"(",ws,A,ws,")",(Indent;ws_),"endwhile"),
        ['wolfram']:
                ("While",ws,"[",ws,A,ws,",",ws,B,(Indent;ws),"]"),
        ['go']:
                ("for",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
        ['vbscript']:
                ("Do",ws_,"While",ws_,A,ws_,B,(Indent;ws_),"Loop"),
        ['seed7']:
                ("while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end",ws_,"while",ws,";")
        ]).

statement(Data,Return_type,if(Expr_,Statements_,Elif_or_else_,Else_)) -->
        {
                indent_data(Indent,Data,Data1),
                A = expr(Data,bool,Expr_),
                B = statements(Data1,Return_type,Statements_),
                C = elif_or_else(Data1,Return_type,Elif_or_else_),
                D = else(Data1,Return_type,Else_)
        },
        optional_indent(Data,Indent),
		langs_to_output(Data,if,[
		['erlang']:
				("if",ws_,A,ws,"->",ws,B,ws_,C,ws_,D,(Indent;ws_),"end"),
		['fortran']:
				("IF",ws_,A,ws_,"THEN",ws_,B,ws_,C,ws_,D,(Indent;ws_),"END",ws_,"IF"),
		['rebol']:
				("case",ws,"[",ws,A,ws,"[",ws,B,ws,"]",ws,C,ws,D,ws,"]"),
		['julia']:
				("if",ws_,A,ws_,B,ws_,C,ws_,D,(Indent;ws_),"end"),
		['picat','ruby','lua']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"end"),
		['octave']:
				("if",ws_,A,ws_,B,ws_,C,ws_,D,(Indent;ws_),"endif"),
		['haskell','pascal','delphi','maxima','ocaml']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D),
		['livecode']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"end",ws_,"if"),
		['java','e','ooc','englishscript','mathematical notation','polish notation','reverse polish notation','perl 6','chapel','katahdin','pawn','powershell','d','ceylon','typescript','actionscript','hack','autohotkey','gosu','nemerle','swift','nemerle','pike','groovy','scala','dart','javascript','c#','c','c++','perl','haxe','php','r','awk','vala','bc','squirrel']:
				("if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}",ws,C,ws,D),
		['rust','go']:
				("if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",ws,C),
		['visual basic']:
				("If",ws_,A,ws_,B,ws_,C,ws_,D,(Indent;ws_),"End If"),
		['clips']:
				("(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,ws,")"),
		['z3']:
				("(",ws,"ite",ws_,A,ws_,B,ws_,C,ws_,D,ws,")"),
		['minizinc']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"endif"),
		['cython']:
				("if",python_ws_,A,python_ws,":",python_ws,B,python_ws,C,D),
		['prolog']:
				("(",ws,A,ws,"->",ws,B,ws,";",ws,C,ws,";",ws,D,ws,")"),
		['visual basic']:
				("If",ws_,A,ws_,"Then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"End",ws_,"If"),
		['common lisp']:
				("(",ws,"cond",ws,"(",ws,A,ws_,B,ws,")",ws_,C,ws_,D,ws,")"),
		['wolfram']:
				("If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,(Indent;ws),"]"),
		['polish notation']:
				("if",ws_,A,ws_,B),
		['reverse polish notation']:
				(A,ws_,B,ws_,"if"),
		['monkey x']:
				("if",ws_,A,ws_,B,ws_,C,(Indent;ws_),"EndIf")
        ]).		
		
	statement(Data,Return_type, switch(Expr_,Expr1_,Statements_,Case_or_default_)) -->
		{
				Data = [Lang|_],
				indent_data(Indent,Data,Data1),
				A = parentheses_expr(Data,int,Expr_),
				B = first_case(Data1,Return_type,Expr_,int,[Expr1_,Statements_,Case_or_default_])
		},
		optional_indent(Data,Indent),langs_to_output(Data,switch,[
		['rust']:
				("match",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
		['elixir']:
				("case",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end"),
		['scala']:
				(A,ws_,"match",ws,"{",ws,B,(Indent;ws),"}"),
		['octave']:
				("switch",ws,"(",ws,A,ws,")",ws,B,(Indent;ws_),"endswitch"),
		['java','d','powershell','nemerle','d','typescript','hack','swift','groovy','dart','awk','c#','javascript','c++','php','c','go','haxe','vala']:
				("switch",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
		['haskell','erlang']:
				("case",ws_,A,ws_,"of",ws_,B,(Indent;ws_),"end"),
		['delphi','pascal']:
				("Case",ws_,A,ws_,"of",ws_,B,(Indent;ws_),"end;"),
		['clips']:
				("(",ws,"switch",ws_,A,ws_,B,ws,")"),
		['visual basic']:
				("Select",ws_,"Case",ws_,A,ws_,B,(Indent;ws_),"End",ws_,"Select"),
		['rebol']:
				("switch/default",ws,"[",ws,A,ws_,B,(Indent;ws_),"]"),
		['fortran']:
				("SELECT",ws_,"CASE",ws,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"END",ws_,"SELECT"),
		['clojure']:
				("(",ws,"case",ws_,A,ws_,B,ws,")"),
		['chapel']:
				("select",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}")
        ]).


class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Global_vars,Indent],
                Data1 = [Lang,Is_input,[Class_name|Namespace],Global_vars,indent(Indent)],
                Name = function_name(Data,Class_name,Class_name,Params1),
                Body = statements(Data1,_,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
        optional_indent(Data,Indent),langs_to_output(Data,constructor,[
        ['rebol']:
                ("new:",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,"make",ws_,"self",ws,"[",ws,Body,ws,"]",ws,"]"),
        ['hy']:
				("(",ws,"defn",ws_,"--init--",ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")"),
        ['java','c#','vala']:
                ("public",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['swift']:
                ("init",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['javascript']:
                ("constructor",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['php']:
                ("function",ws_,"construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['perl']:
                ("sub",ws_,"new",ws,"{",ws,Body,(Indent;ws),"}"),
        ['haxe']:
                ("public",ws_,"function",ws_,"new",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c++','dart']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['d']:
                ("this",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['chapel']:
                ("proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['julia']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end")
        ]).

class_statement(Data,_,static_method(Name1,Type1,Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = function_name(Data,Type1,Name1,Params1),
                Body = statements(Data1,Type1,Body1),
                Type = type(Data,Type1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
        optional_indent(Data,Indent),langs_to_output(Data,static_method,[
        ['swift','pseudocode']:
                ("class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}"),
        ['haxe','pseudocode']:
                ("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['julia']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['java','c#','pseudocode']:
                ("public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c++','dart','pseudocode']:
                ("static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['php','pseudocode']:
                ("public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c']:
                (Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['javascript','pseudocode']:
                ("static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['picat']:
                (ws)
        ]).

class_statement(Data,_,instance_method(Name1,Type1,Params1,Body1)) -->
	{
		Data = [Lang,Is_input,Namespace,Var_types,Indent],
		Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
		Name = function_name(Data,Type1,Name1,Params1),
		Body = statements(Data1,Type1,Body1),
		Type = type(Data,Type1),
		(Params1 = [], Params = ""; Params = parameters(Data1,Params1))
	},
	%put this at the beginning of each statement without a semicolon
    optional_indent(Data,Indent),
		langs_to_output(Data,instance_method,[
		['hy']:
			("(",ws,"defn",ws_,Name,ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")"),
		['swift']:
                ("func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        [logtalk]:
                (Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}"),
        ['javascript']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['perl 6']:
                ("method",ws_,Name,ws_,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['chapel']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['java','c#']:
                ("public",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['php']:
                ("public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c++','d','dart']:
                (Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['haxe']:
                ("public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}")
        ]).

class_statement(Data,_,initialize_static_var_with_value(Type1,Name1,Expr1)) -->
        {
                Value = expr(Data,Type1,Expr1),
                Name = var_name(Data,Type1,Name1),
                Type = type(Data,Type1)
        },
    	langs_to_output(Data,initialize_static_var_with_value,[
		['polish notation']:
			("=",ws_,Name,ws_,Value),
		['reverse polish notation']:
			(Name,ws_,Value,ws_,"="),
		['go']:
			("var",ws_,Name,ws_,Type,ws,"=",ws,Value),
		['rust']:
			("let",ws_,"mut",ws_,Name,ws,"=",ws,Value),
		['dafny']:
			("var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value),
		['z3']:
			("(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")"),
		['f#']:
			("let",ws_,"mutable",ws_,Name,ws,"=",ws,Value),
		['common lisp']:
			("(",ws,"setf",ws_,Name,ws_,Value,ws,")"),
		['minizinc']:
			(Type,ws,":",ws,Name,ws,"=",ws,Value,ws,";"),
		['haskell','erlang','prolog','julia','picat','octave','wolfram']:
			(Name,ws,"=",ws,Value),
		['javascript','hack','swift']:
			("var",ws_,Name,ws,"=",ws,Value),
		['janus']:
			("local",ws_,Type,ws_,Name,ws,"=",ws,Value),
		['perl']:
			("my",ws_,Name,ws,"=",ws,Value),
		['perl 6']:
			("my",ws_,Type,ws_,Name,ws,"=",ws,Value),
		['c','java','c#','c++','d','dart','englishscript','ceylon','vala']:
			(Type,ws_,Name,ws,"=",ws,Value),
		['rebol']:
			(Name,ws,":",ws,Value),
		['visual basic','openoffice basic','visual basic .net']:
			("Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value),
		['r']:
			(Name,ws,"<-",ws,Value),
		['fortran']:
			(Type,ws,"::",ws,Name,ws,"=",ws,Value),
		['chapel','haxe','scala','typescript']:
			("var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value),
		['monkey x']:
			("Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value),
		['vbscript']:
			("Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value),
		['seed7']:
			("var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value)
        ]).
