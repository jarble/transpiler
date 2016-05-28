

% This is a program that translates several programming languages into several other languages.
% For example:
%    translate("int add(a){ if(g){ return a; } }",E,c,java)
% will translate a short C program into the equivalent Java syntax. Conversely, we can write
%    translate("public static int add(a){ if(g){ return a; } }",E,java,c)
% to translate a Java function into C.

:- initialization(main), set_prolog_flag(double_quotes, chars).  % This is for SWI 7+ to revert to the prior interpretation of quoted strings.
% :- [library(dcg/basics)].
:- use_module(library(prolog_stack)).
:- use_module(library(error)).

user:prolog_exception_hook(Exception, Exception, Frame, _):-
    (   Exception = error(Term)
    ;   Exception = error(Term, _)),
    get_prolog_backtrace(Frame, 20, Trace),
    format(user_error, 'Error: ~p', [Term]), nl(user_error),
    print_prolog_backtrace(user_error, Trace), nl(user_error), fail.

:- [statement,class_statement,statement_with_semicolon,expr,parentheses_expr].

%Use this rule to define operators for various languages

infix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        parentheses_expr(Data,Type,Exp1),ws,Symbol,ws,expr(Data,Type,Exp2).

prefix_operator(Data,Type,Symbol,Exp1,Exp2) -->
        "(",Symbol,ws_,expr(Data,Type,Exp1),ws_,expr(Data,Type,Exp2),")".


% this is from http://stackoverflow.com/questions/20297765/converting-1st-letter-of-atom-in-prolog
first_char_uppercase(WordLC, WordUC) :-
    atom_chars(WordLC, [FirstChLow|LWordLC]),
    atom_chars(FirstLow, [FirstChLow]),
    upcase_atom(FirstLow, FirstUpp),
    atom_chars(FirstUpp, [FirstChUpp]),
    atom_chars(WordUC, [FirstChUpp|LWordLC]).


var_name(Data,Type,A) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['engscript', 'ruby', 'cosmos', 'englishscript','vbscript','polish notation','reverse polish notation','wolfram','crosslanguage','pseudocode','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','visual basic .net','clojure','haxe','coffeescript','dart','javascript','c#','python','haskell','c','lua','gambas','common lisp','scheme','rebol','f#'])}->
                symbol(A);
        {memberchk(Lang,['php','perl','bash','tcl','autoit','perl 6','puppet','hack','awk','powershell'])} ->
                ({Lang=perl,Type=[array,_]}->
					"@",symbol(A);
                {Lang=perl,Type=[dict,_]}->
					"%",symbol(A);
                "$",symbol(A));
        {memberchk(Lang,[prolog,erlang,picat,logtalk]),atom_string(B,A), first_char_uppercase(B, C),atom_chars(C,D)} ->
            symbol(D);
        {not_defined_for(Data,'var_name')}),
        {is_var_type(Data, A, Type)}.

function_name(Data,Type,A,Params) -->
        symbol(A),{is_var_type(Data,[A,Params], Type)}.


indent(Indent) --> (Indent,("    ";"\t")).


else(Data,Return_type,Statements_) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        (Indent;""),({memberchk(Lang,['clojure'])}->
                ":else",ws_,A;
        {memberchk(Lang,['fortran'])}->
                "ELSE",ws_,A;
        {memberchk(Lang,['hack','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc'])}->
                "else",ws,"{",ws,A,(Indent;ws),"}";
        {memberchk(Lang,['seed7','livecode','janus','lua','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#'])}->
                "else",ws_,A;
        {memberchk(Lang,['erlang'])}->
                "true",ws,"->",ws,A;
        {memberchk(Lang,['wolfram','prolog'])}->
                A;
        {memberchk(Lang,['z3'])}->
                A;
        {memberchk(Lang,['python','cython'])}->
                "else",python_ws,":",python_ws,A;
        {memberchk(Lang,['visual basic .net','monkey x','vbscript'])}->
                "Else",ws_,A;
        {memberchk(Lang,['rebol'])}->
                "true",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"t",ws_,A,ws,")";
        {memberchk(Lang,['pseudocode'])}->
                ("otherwise",ws_,A;
                "else",ws_,A;
                "else",ws,"{",ws,A,(Indent;ws),"}");
        {memberchk(Lang,['polish notation'])}->
                "else",ws_,A;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,"else";
        {not_defined_for(Data,'else')}).


first_case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
	{
			indent_data(Lang,Indent,Data,Data1),
			B=statements(Data1,Return_type,Statements_),
			Compare_expr = expr(Data,bool,compare(int,Switch_expr,Expr_)),
			Expr = expr(Data,int,Expr_),
			
			Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
	},
	(Indent;""),
	({memberchk(Lang,[julia,octave,lua])} ->
		"if",ws_,Compare_expr,ws_,"then",ws_,B,ws_,Case_or_default;
	{memberchk(Lang,[python])} ->
		"if",python_ws_,Compare_expr,python_ws,":",B,python_ws,Case_or_default;
	{memberchk(Lang,[javascript,d,java,'c#',c,'c++',typescript,dart,php,hack])}->
	"case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default;
    {memberchk(Lang,[go,haxe,swift])}->
        "case",ws_,Expr,ws,":",ws,B,ws,Case_or_default;
    {memberchk(Lang,[fortran])}->
        "CASE",ws,"(",ws,Expr,ws,")",ws_,B;
    {memberchk(Lang,[rust])}->
        Expr,ws,"=>",ws,"{",ws,B,ws,Case_or_default,(Indent;ws),"}";
    {memberchk(Lang,[ruby])}->
        "when",ws_,Expr,ws_,B,ws,Case_or_default;
    {memberchk(Lang,[haskell,erlang,elixir,ocaml])}->
        Expr,ws,"->",ws,B,ws,Case_or_default;
    {memberchk(Lang,[clips])}->
        "(",ws,"case",ws_,Expr,ws_,"then",ws_,B,ws,Case_or_default,ws,")";
    {memberchk(Lang,[scala])}->
        "case",ws_,Expr,ws,"=>",ws,B,ws,Case_or_default;
    {memberchk(Lang,['visual basic .net'])}->
        "Case",ws_,Expr,ws_,B,ws_,Case_or_default;
    {memberchk(Lang,[rebol])}->
        Expr,ws,"[",ws,B,ws,Case_or_default,"]";
    {memberchk(Lang,[octave])}->
        "case",ws_,Expr,ws_,B,ws,Case_or_default;
    {memberchk(Lang,[clojure])}->
        "(",ws,Expr,ws_,B,ws,Case_or_default,ws,")";
    {memberchk(Lang,[pascal,delphi])}->
        Expr,ws,":",ws,B,ws,Case_or_default;
    {memberchk(Lang,[chapel])}->
        "when",ws_,Expr,ws,"{",ws,B,ws,Case_or_default,(Indent;ws),"}";
    {memberchk(Lang,[wolfram])}->
        Expr,ws,",",ws,B,ws,Case_or_default;
	{not_defined_for(Data,'first_case')}).

case(Data,Return_type,Switch_expr,int,[Expr_,Statements_,Case_or_default_]) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                B=statements(Data1,Return_type,Statements_),
                A = expr(Data,bool,compare(int,Switch_expr,Expr_)),
                Expr = expr(Data,int,Expr_),
                Case_or_default = (case(Data,Return_type,Switch_expr,int,Case_or_default_);default(Data,Return_type,int,Case_or_default_))
        },
    (Indent;""),
    ({memberchk(Lang,[julia,octave,lua])} ->
		"elsif",ws_,A,ws_,"then",ws_,B,ws,Case_or_default;
    {memberchk(Lang,[python])} ->
		"elif",python_ws_,A,python_ws,":",B,python_ws,Case_or_default;
    {memberchk(Lang,[javascript,d,java,'c#',c,'c++',typescript,dart,php,hack])}->
        "case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default;
    {memberchk(Lang,[go,haxe,swift])}->
        "case",ws_,Expr,ws,":",ws,B,ws,Case_or_default;
    {memberchk(Lang,[fortran])}->
        "CASE",ws,"(",ws,Expr,ws,")",ws_,B,ws,Case_or_default;
    {memberchk(Lang,[rust])}->
        Expr,ws,"=>",ws,"{",ws,B,(Indent;ws),"}",ws,Case_or_default;
    {memberchk(Lang,[ruby])}->
        "when",ws_,Expr,ws_,B,ws,Case_or_default;
    {memberchk(Lang,[haskell,erlang,elixir,ocaml])}->
        Expr,ws,"->",ws,B,ws,Case_or_default;
    {memberchk(Lang,[clips])}->
        "(",ws,"case",ws_,Expr,ws_,"then",ws_,B,ws,")";
    {memberchk(Lang,[scala])}->
        "case",ws_,Expr,ws,"=>",ws,B;
    {memberchk(Lang,['visual basic .net'])}->
        "Case",ws_,Expr,ws_,B,ws_,Case_or_default;
    {memberchk(Lang,[rebol])}->
        Expr,ws,"[",ws,B,ws,"]",ws,Case_or_default;
    {memberchk(Lang,[octave])}->
        "case",ws_,Expr,ws_,B,ws,Case_or_default;
    {memberchk(Lang,[clojure])}->
        "(",ws,Expr,ws_,B,ws,")",ws,Case_or_default;
    {memberchk(Lang,[pascal,delphi])}->
        Expr,ws,":",ws,B,ws,Case_or_default;
    {memberchk(Lang,[chapel])}->
        "when",ws_,Expr,ws,"{",ws,B,(Indent;ws),"}",ws,Case_or_default;
    {memberchk(Lang,[wolfram])}->
        Expr,ws,",",ws,B;
    {not_defined_for(Data,'case')}).

default(Data,Return_type,int,Statements_) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                A = statements(Data1,Return_type,Statements_)
        },
        (Indent;""),(
        {memberchk(Lang,['fortran'])}->
                "CASE",ws_,"DEFAULT",ws_,A;
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"default",ws_,A,ws,")";
        {memberchk(Lang,['javascript','d','c','java','c#','c++','typescript','dart','php','haxe','hack','go','swift'])}->
                "default",ws,":",ws,A;
        {memberchk(Lang,['pascal','delphi','lua'])}->
                "else",ws_,A;
        {memberchk(Lang,['python'])}->
                "else",python_ws,":",python_ws,A;
        {memberchk(Lang,['haskell','erlang','ocaml'])}->
                ws,ws,"->",ws_,A;
        {memberchk(Lang,['rust'])}->
                ws,ws,"=>",ws,A;
        {memberchk(Lang,['clips'])}->
                "(",ws,"default",ws_,A,ws,")";
        {memberchk(Lang,['scala'])}->
                "case",ws_,ws,"=>",ws,A;
        {memberchk(Lang,['visual basic .net'])}->
                "Case",ws_,"Else",ws_,A;
        {memberchk(Lang,['rebol'])}->
                "][",A;
        {memberchk(Lang,['octave'])}->
                "otherwise",ws_,A;
        {memberchk(Lang,['chapel'])}->
                "otherwise",ws,"{",ws,A,(Indent;ws),"}";
        {memberchk(Lang,['clojure'])}->
                A;
        {memberchk(Lang,['wolfram'])}->
                ws,ws,",",ws,A;
        {not_defined_for(Data,'default')}).

elif_or_else(Data,Return_type,M) -->
        elif(Data,Return_type,M);else(Data,Return_type,M).

indent_data(Lang,Indent,Data,Data1) :-
	Data = [Lang,Is_input,Namespace,Var_types,Indent],
    Data1 = [Lang,Is_input,Namespace,Var_types,indent(Indent)].

elif(Data,Return_type,[Expr_,Statements_,Elif_or_else_]) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                C = elif_or_else(Data,Return_type,Elif_or_else_),
                B=statements(Data1,Return_type,Statements_),
                A=expr(Data,bool,Expr_)
        },
        (Indent;""),({memberchk(Lang,['d','e','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe'])}->
                "else",ws_,"if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}",ws,C;
        {memberchk(Lang,['z3'])}->
                "(",ws,"ite",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['rust','go','englishscript'])}->
                "else",ws_,"if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",ws,C;
        {memberchk(Lang,['php','hack','perl'])}->
                "elseif",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}",ws,C;
        {memberchk(Lang,['julia','octave','lua'])}->
                "elseif",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['monkey x'])}->
                "ElseIf",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['seed7'])}->
                "elsif",ws_,A,ws_,"then",ws_,B,ws_,C;
        {memberchk(Lang,['perl 6'])}->
                "elsif",ws_,A,ws_,"{",ws,B,(Indent;ws),"}",ws,C;
        {memberchk(Lang,['picat'])}->
                "elseif",ws_,A,ws_,"then",ws_,B,ws_,C;
        {memberchk(Lang,['erlang'])}->
                A,ws,"->",ws,B,ws_,C;
        {memberchk(Lang,['prolog'])}->
                "(",ws,A,ws,"->",ws,B,ws,";",ws,C,ws,")";
        {memberchk(Lang,['r','f#'])}->
                A,ws,"<-",ws,B,ws_,C;
        {memberchk(Lang,['clips'])}->
                "(",ws,"if",ws_,A,ws_,"then",ws_,"(",ws,B,ws_,C,ws,")",ws,")";
        {memberchk(Lang,['minizinc','ocaml','haskell','pascal','maxima','delphi','f#','livecode'])}->
                "else",ws_,"if",ws_,A,ws_,"then",ws_,B,ws_,C;
        {memberchk(Lang,['python','cython'])}->
                "elif",python_ws_,A,python_ws,":",python_ws,B,python_ws,C;
        {memberchk(Lang,['visual basic .net'])}->
                "ElseIf",ws_,A,ws_,"Then",ws_,B,ws_,C;
        {memberchk(Lang,['fortran'])}->
                "ELSE",ws_,"IF",ws_,A,ws_,"THEN",ws_,B,ws_,C;
        {memberchk(Lang,['rebol'])}->
                A,ws,"[",ws,B,ws,"]",ws_,C;
        {memberchk(Lang,['common lisp'])}->
                "(",ws,A,ws_,B,ws,")",ws_,C;
        {memberchk(Lang,['wolfram'])}->
                "If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,(Indent;ws),"]";
        {memberchk(Lang,['polish notation'])}->
                "elif",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,C,ws_,"elif";
        {memberchk(Lang,['clojure'])}->
                A,ws_,B,ws_,C;
        {not_defined_for(Data,'elif')}).

is_var_type([_,_,Namespace,Var_types,_], Name, Type) :-
	memberchk([[Name|Namespace],Type1], Var_types) -> Type = Type1.

%also called optional parameters
default_parameter(Data,[Type1,Name1,Default1]) -->
        {
                Data = [Lang|_],
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1),
                Value = var_name(Data,Type1,Default1)
        },
        ({memberchk(Lang,['python','autohotkey','julia','nemerle','php','javascript'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['c#','d','groovy','c++'])}->
                Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['dart'])}->
                "[",ws,Type,ws_,Name,ws,"=",ws,Value,ws,"]";
        {memberchk(Lang,['ruby'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['scala','swift','python'])}->
                Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['haxe'])}->
                "?",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['visual basic .net'])}->
                "Optional",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
        {not_defined_for(Data,'default_parameter')}).

parameter(Data,[Type1,Name1]) -->
        {
                Data = [Lang|_],
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1)
        },
        ({memberchk(Lang,['pseudocode'])}->
                ("in",ws_,Type,ws,":",ws,Name;
                Type,ws_,Name;
                Name,ws,":",ws,Type;
                Name,ws_,Type;
                "var",ws_,Type,ws,":",ws,Name;
                Name,ws,"::",ws,Type;
                Type,ws,"[",ws,Name,ws,"]";
                Name,ws_,("As";"as"),ws_,Type);
        {memberchk(Lang,['seed7'])}->
                "in",ws_,Type,ws,":",ws,Name;
        {memberchk(Lang,['c#','java','englishscript','ceylon','algol 68','groovy','d','c++','pawn','pike','vala','c','janus'])}->
                Type,ws_,Name;
        {memberchk(Lang,['haxe','dafny','chapel','pascal','rust','genie','hack','nim','typescript','gosu','delphi','nemerle','scala','swift'])}->
                Name,ws,":",ws,Type;
        {memberchk(Lang,['go','sql'])}->
                Name,ws_,Type;
        {memberchk(Lang,['minizinc'])}->
                "var",ws_,Type,ws,":",ws,Name;
        {memberchk(Lang,['haskell','ruby','perl 6','cosmos','polish notation','reverse polish notation','scheme','python','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','python','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','lua','r','bc'])}->
                Name;
        {memberchk(Lang,['julia'])}->
                Name,ws,"::",ws,Type;
        {memberchk(Lang,['rebol'])}->
                Type,ws,"[",ws,Name,ws,"]";
        {memberchk(Lang,['openoffice basic','gambas'])}->
                Name,ws_,"As",ws_,Type;
        {memberchk(Lang,['visual basic','visual basic .net'])}->
                Name,ws_,"as",ws_,Type;
        {memberchk(Lang,['perl'])}->
                "my",ws_,Name,ws,"=",ws,"push",ws,";";
        {memberchk(Lang,['wolfram'])}->
                Name,"_";
        {memberchk(Lang,['z3'])}->
                "(",ws,Name,ws_,Type,ws,")";
        {not_defined_for(Data,'parameter')}).


varargs(Data,[Type1,Name1]) -->
        {
                Data = [Lang|_],
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1)
        },
    ({memberchk(Lang,['java'])}->
        Type,ws,"...",ws_,Name;
    {memberchk(Lang,['php'])}->
        "",ws,Type,ws,"...",ws_,"$",ws,Name;
    {memberchk(Lang,['c#'])}->
        "params",ws_,Type,ws,"[",ws,"]",ws_,Name;
    {memberchk(Lang,['perl 6'])}->
        "*@",Name;
    {memberchk(Lang,['scala'])}->
        Name,ws,":",ws,Type,ws,"*";
    {memberchk(Lang,['go'])}->
        Name,ws,"...",ws,Type;
    {not_defined_for(Data,'varargs')}).

function_parameter_separator(Lang) -->
        {memberchk(Lang,['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','perl'])}->
                ws_;
        {memberchk(Lang,['pseudocode','ruby','javascript','logtalk','cosmos','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','lua','typescript','dart','python','haxe','scala','visual basic','visual basic .net'])}->
                ",";
        {memberchk(Lang,[perl])} ->
                ws;
        {not_defined_for([Lang,false|_],'function_parameter_separator')}.

enum_list_separator(Lang) -->
        (memberchk(Lang,[pseudocode]) ->
				(",";";");
        {memberchk(Lang,['java','seed7','vala','c++','c#','c','typescript','fortran','ada','scala'])}->
                ",";
        {memberchk(Lang,['haxe'])}->
                ";";
        {memberchk(Lang,['go','perl 6','swift','visual basic .net'])}->
                ws_;
        {not_defined_for([Lang,false|_],'enum_list_separator')}).

parameter_separator(Lang) -->
        {memberchk(Lang,['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','perl'])}->
                ws_;
        {memberchk(Lang,['pseudocode','ruby','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','lua','typescript','dart','python','haxe','scala','visual basic','visual basic .net'])}->
                ",";
        {not_defined_for([Lang,false|_],'parameter_separator')}.



%these parameters are used in a function's definition
optional_parameters(Data,A) --> "",parameters(Data,A).
parameters(Data,[A]) --> parameter(Data,A);default_parameter(Data,A);varargs(Data,A).
parameters(Data,[A|B]) --> {Data = [Lang|_]},parameter(Data,A),ws,function_parameter_separator(Lang),ws,parameters(Data,B).

function_call_parameters(Data,[Params1_],[[Params2_,_]]) -->
        parentheses_expr(Data,Params2_,Params1_).
function_call_parameters(Data,[Params1_|Params1__],[[Params2_,_]|Params2__]) -->
        ({
                Data = [Lang|_]
        },
        parentheses_expr(Data,Params2_,Params1_),function_call_parameter_separator(Lang),function_call_parameters(Data,Params1__,Params2__)).

function_call_parameter_separator(Lang) -->
	{Lang = 'perl'}->
		",";
	parameter_separator(Lang).

type(Lang,auto_type) -->
        {memberchk(Lang,['c++'])} ->
                "auto";
        {memberchk(Lang,[c])} ->
                "__auto_type";
        {memberchk(Lang,[java])} ->
                "Object";
        {memberchk(Lang,['c#'])} ->
                "object";
        {memberchk(Lang,['pseudocode'])} ->
				("object";"Object";"__auto_type";"auto");
        {not_defined_for([Lang,false|_],'auto_type')}.

type(Lang,regex) -->
        {memberchk(Lang,['javascript'])} ->
                "RegExp";
        {memberchk(Lang,['c#','scala'])} ->
                "Regex";
        {memberchk(Lang,['c++'])} ->
                "regex";
        {memberchk(Lang,['java'])} ->
                "Pattern";
        {memberchk(Lang,['haxe'])} ->
                "EReg";
        {memberchk(Lang,['pseudocode'])} ->
                ("EReg";"Pattern";"RegExp";"regex";"Regex");
        {not_defined_for([Lang,false|_],'regex')}.

type(Lang,[dict,Type_in_dict]) -->
        {memberchk(Lang,[python])} ->
                "dict";
        {memberchk(Lang,[javascript,java])} ->
                "Object";
        {memberchk(Lang,[c])} ->
			"__auto_type";
		{memberchk(Lang,['c++'])} ->
			"map<string,",type(Lang,Type_in_dict),">";
		{memberchk(Lang,['haxe'])} ->
			"map<String,",type(Lang,Type_in_dict),">";
		{memberchk(Lang,['pseudocode'])} ->
			("map<string,",type(Lang,Type_in_dict),">";"dict");
        {not_defined_for([Lang,false|_],'dict')}.

type(Lang,int) -->
        {memberchk(Lang,['hack','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','crosslanguage','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','python','hy','java','c#','c','c++','vala','nemerle','crosslanguage'])}->
                "int";
        {memberchk(Lang,['php','prolog','common lisp','picat'])}->
                "integer";
        {memberchk(Lang,['fortran'])}->
                "INTEGER";
        {memberchk(Lang,['rebol'])}->
                "integer!";
        {memberchk(Lang,['ceylon','cosmos','gambas','openoffice basic','pascal','erlang','delphi','visual basic','visual basic .net'])}->
                "Integer";
        {memberchk(Lang,['haxe','ooc','swift','scala','perl 6','z3','monkey x'])}->
                "Int";
        {memberchk(Lang,['javascript','typescript','coffeescript','lua','perl'])}->
                "number";
        {memberchk(Lang,['haskell'])}->
                "Num";
        {memberchk(Lang,['ruby'])}->
                "fixnum";
        {memberchk(Lang,['pseudocode'])}->
				{member(Lang1,['java','pascal','rebol','fortran','haxe','php','haskell'])}, type(Lang1,int);
        {not_defined_for([Lang,false|_],'int')}.

type(Lang,[array,Type]) -->
	{member(Type,[int,string,bool])},
	({memberchk(Lang,[java,c,'c++'])} ->
			type(Lang,Type),"[]";
	{memberchk(Lang,[python])} ->
			"list";
	{memberchk(Lang,[javascript])} ->
			"Array";
	{memberchk(Lang,[cosmos])} ->
			"Array";
	{memberchk(Lang,['pseudocode'])}->
			(type(Lang,Type),"[]";"Array";"list");
	{not_defined_for([Lang,false|_],'array_type')}).

type(Lang,string) -->
    {memberchk(Lang,['z3',cosmos,'java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','visual basic .net','monkey x'])}->
			"String";
	{memberchk(Lang,['vala','seed7','octave','picat','mathematical notation','polish notation','reverse polish notation','prolog','d','crosslanguage','chapel','minizinc','genie','hack','nim','algol 68','typescript','coffeescript','octave','tcl','awk','julia','c#','f#','perl','lua','javascript','go','php','c++','nemerle','erlang'])}->
			"string";
	{memberchk(Lang,['c'])}->
			"char*";
	{memberchk(Lang,['rebol'])}->
			"string!";
	{memberchk(Lang,['fortran'])}->
			"CHARACTER","(","LEN","=","*",")";
	{memberchk(Lang,['python','hy'])}->
			"str";
	{memberchk(Lang,['pseudocode'])}->
			("str";"string";"String";"char*";"string!");
	{not_defined_for([Lang,false|_],'string')}.

type(Lang, bool) -->
	{memberchk(Lang,['typescript','seed7','python','hy','java','javascript','lua','perl'])}->
			"boolean";
	{memberchk(Lang,['c++','nim','octave','dafny','chapel','c','crosslanguage','rust','minizinc','engscript','dart','d','vala','crosslanguage','go','cobra','c#','f#','php','hack'])}->
			"bool";
	{memberchk(Lang,['haxe','haskell','swift','julia','perl 6','z3','z3py','monkey x'])}->
			"Bool";
	{memberchk(Lang,['fortran'])}->
			"LOGICAL";
	{memberchk(Lang,['visual basic','openoffice basic','ceylon','delphi','pascal','scala','visual basic .net'])}->
			"Boolean";
	{memberchk(Lang,['rebol'])}->
			"logic!";
	{memberchk(Lang,['pseudocode'])}->
			("bool";"logic!";"Boolean";"boolean";"Bool";"LOGICAL");
	{not_defined_for([Lang,false|_],'boolean')}.

type(Lang,void) -->
    {memberchk(Lang,['engscript','seed7','php','hy','cython','go','pike','objective-c','java','c','c++','c#','vala','typescript','d','javascript','lua','dart'])}->
			"void";
	{memberchk(Lang,['haxe','swift'])}->
			"Void";
	{memberchk(Lang,['scala'])}->
			"Unit";
	{memberchk(Lang,['pseudocode'])}->
			("Void";"void";"Unit");
	{not_defined_for([Lang,false|_],'void')}.

type(Lang,double) -->
        {memberchk(Lang,['java','c','c#','c++','dart','vala'])}->
                "double";
        {memberchk(Lang,['go'])}->
                "float64";
        {memberchk(Lang,['haxe'])}->
                "Float";
        {memberchk(Lang,['javascript','lua'])}->
                "number";
        {memberchk(Lang,['minizinc','php','python'])}->
                "float";
        {memberchk(Lang,['visual basic .net','swift'])}->
                "Double";
        {memberchk(Lang,['haskell'])}->
                "Num";
        {memberchk(Lang,['rebol'])}->
                "decimal!";
        {memberchk(Lang,['fortran'])}->
                "double",ws_,"precision";
        {memberchk(Lang,['z3','z3py'])}->
                "Real";
        {memberchk(Lang,['octave'])}->
                "scalar";
        {memberchk(Lang,['pseudocode'])}->
				("double";"real";"decimal";"Num";"float";"Float";"Real";"float64";"number");
        {not_defined_for([Lang,false|_],'double')}.

type(_,X) --> symbol(X).

statement_separator(Lang) -->
	{memberchk(Lang,['pydatalog','ruby','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','z3','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','lua','go','awk','haskell','python','r','visual basic','visual basic .net'])}->
			ws_;
	{memberchk(Lang,['java','pseudocode','perl 6','haxe','javascript','c++','c#','php','dart','actionscript','typescript','processing','vala','bc','ceylon','hack','perl'])}->
			ws;
	{memberchk(Lang,['wolfram'])}->
			";";
	{memberchk(Lang,['englishscript','python','cosmos'])}->
			"\n";
	{memberchk(Lang,['picat','prolog','logtalk','erlang','lpeg'])}->
			",";
	{not_defined_for([Lang,false|_],'statement_separator')}.

initializer_list_separator(Lang) -->
	{memberchk(Lang,['python','cosmos','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','pseudocode','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift','java','picat','c#','go','lua','c++','c','visual basic .net','visual basic','php','scala','perl','wolfram'])}->
			",";
	{memberchk(Lang,['rebol'])}->
			ws_;
	{memberchk(Lang,['pseudocode'])}->
			(",";";");
	{not_defined_for([Lang,false|_],'initializer_list_separator')}.

key_value_separator(Lang) -->
	{memberchk(Lang,['python','cosmos','picat','go','dart','visual basic .net','d','c#','frink','swift','javascript','typescript','php','perl','lua','julia','haxe','c++','scala','octave','elixir','wolfram'])}->
			",";
	{memberchk(Lang,['java'])}->
			";";
	{memberchk(Lang,['pseudocode'])}->
			(",";";");
	{memberchk(Lang,['rebol'])}->
			ws_;
	{not_defined_for([Lang,false|_],'key_value_separator')}.
key_value(Data,Type,[Key_,Val_]) -->
        {
                Data = [Lang|_],
                A = symbol(Key_),
                B = expr(Data,Type,Val_)
        },
        ({memberchk(Lang,['groovy','d','dart','javascript','typescript','coffeescript','swift','elixir','swift','go'])}->
                A,ws,":",ws,B;
        {memberchk(Lang,['python'])}->
                ("\"",ws,A,ws,"\"";"'",ws,A,ws,"'"),ws,":",ws,B;
        {memberchk(Lang,['php','haxe','perl','julia'])}->
                A,ws,"=>",ws,B;
        {memberchk(Lang,['rebol'])}->
                A,ws_,B;
        {memberchk(Lang,['lua','picat'])}->
                A,ws,"=",ws,B;
        {memberchk(Lang,['c++','c#','visual basic .net'])}->
                "{",ws,("\"",ws,A,ws,"\""),ws,",",ws,B,ws,"}";
        {memberchk(Lang,['scala','wolfram'])}->
                A,ws,"->",ws,B;
        {memberchk(Lang,['octave','cosmos'])}->
                A,ws,",",ws,B;
        {memberchk(Lang,['frink'])}->
                "[",ws,A,ws,",",ws,B,ws,"]";
        {memberchk(Lang,['java'])}->
                "put",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {not_defined_for(Data,'key_value')}).


statements(Data,[A]) --> statement(Data,_,A).
statements(Data,[A|B]) --> {Data = [Lang|_]},statement(Data,_,A),ws,statement_separator(Lang),ws,statements(Data,B).

top_level_statement(Data,Type,A) -->
	{Data = [Lang|_]},
	({memberchk(Lang,['prolog','erlang','picat'])} ->
		statement(Data,Type,A),".";
	{memberchk(Lang,['minizinc'])} ->
		statement(Data,Type,A),";";
	statement(Data,Type,A)).

ws_separated_statements(Data,[A]) --> top_level_statement(Data,_,A).
ws_separated_statements(Data,[A|B]) --> top_level_statement(Data,_,A),ws_,ws_separated_statements(Data,B).

class_statements(Data,Class_name,[A]) --> class_statement(Data,Class_name,A).
class_statements(Data,Class_name,[A|B]) --> {Data = [Lang|_]}, class_statement(Data,Class_name,A),statement_separator(Lang),class_statements(Data,Class_name,B).

dict_(Data,Type,[A]) --> key_value(Data,Type,A).
dict_(Data,Type,[A|B]) --> {Data = [Lang|_]},key_value(Data,Type,A),key_value_separator(Lang),dict_(Data,Type,B).

initializer_list_(Data,Type,[A]) --> expr(Data,Type,A).
initializer_list_(Data,Type,[A|B]) --> {Data = [Lang|_]}, expr(Data,Type,A),initializer_list_separator(Lang),initializer_list_(Data,Type,B).

enum_list(Data,[A]) --> enum_list_(Data,A).
enum_list(Data,[A|B]) --> {Data = [Lang|_]}, enum_list_(Data,A),enum_list_separator(Lang),enum_list(Data,B).

enum_list_(Data,A_) -->
        {
                Data = [Lang|_],
                A = symbol(A_)
        },
        ({memberchk(Lang,['java','seed7','vala','perl 6','swift','c++','c#','visual basic .net','haxe','fortran','typescript','c','ada','scala'])}->
                A;
        {memberchk(Lang,['go'])}->
                A,ws,"=",ws,"iota";
        {memberchk(Lang,['python'])}->
                A,ws,"=",ws,"(",ws,")";
        {not_defined_for(Data,'_enum_list')}).



statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> {Data = [Lang|_]}, statement(Data,Return_type,A),statement_separator(Lang),statements(Data,Return_type,B).


% whitespace
ws --> "";((" ";"\t";"\n"),ws).
ws_ --> (" ";"	";"\n"),ws.

python_ws --> "";((" ";"	"),ws).
python_ws_ --> (" ";"	"),ws.

symbol([L|Ls]) --> letter(L), symbol_r(Ls).
symbol_r([L|Ls]) --> csym(L), symbol_r(Ls).
symbol_r([])     --> [].
letter(Let)     --> [Let], { code_type(Let, alpha) }.
csym(Let)     --> [Let], { code_type(Let, csym) }.

string_literal(S) --> "\"",string_inner(S),"\"".
string_literal1(S) --> "\'",string_inner1(S),"\'".
regex_literal(Lang,S_) --> 
	{S = regex_inner(S_)},
	({memberchk(Lang,['javascript'])} ->
		"/",S,"/";
	{memberchk(Lang,['haxe'])} ->
		"~/",S,"/";
	{memberchk(Lang,['python'])} ->
		"re",ws,".",ws,"compile",ws,"(\"",S,"\")";
	{memberchk(Lang,['java'])} ->
		"Pattern",ws,".",ws,"compile",ws,"(\"",S,"\")";
	{memberchk(Lang,['c++'])} ->
		"regex::regex",ws,"(\"",S,"\")";
	{memberchk(Lang,['scala','c#'])}->
		"new",ws,"Regex",ws,"(\"",S,"\")";
	{not_defined_for(Lang,'regex_literal')}).

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
digit(Let)     --> [Let], { code_type(Let, digit) }.



not_defined_for(Data,Function) :-
        Data = [Lang,Is_input|_],
        (Is_input ->
			true;
		writeln(Function),writeln('not defined for'),writeln(Lang)).


statements_with_ws(Data,A) -->
	ws,(include_in_each_file(Data);""),ws_separated_statements(Data,A),ws.

include_in_each_file([Lang|_]) -->
	{member(Lang,['prolog'])} ->
		":- initialization(main). :- set_prolog_flag(double_quotes, chars).";
	{member(Lang,['perl'])} ->
		"use strict;\nuse warnings;";
	{not_defined_for(include_in_each_file,[Lang|_])}.

translate(Input1,Output1,Lang1_,Lang2_) :-
        atom_chars(Input1, Input),
        downcase_atom(Lang1_,Lang1),
        downcase_atom(Lang2_,Lang2),
        (phrase(statements_with_ws([Lang1,true,[],Var_types,"\n"],Ls), Input),
        phrase(statements_with_ws([Lang2,false,[],Var_types,"\n"],Ls), Output)),
        atom_chars(Output1, Output),
        print_var_types(Var_types).
        
print_var_types([A]) :-
	writeln(A).
print_var_types([A|Rest]) :-
	writeln(A),print_var_types(Rest).

translate(Input,Output,Lang2) :-
        member(Lang1,[javascript,lua,perl,ruby,prolog,c,z3,'c#',python,java])-> translate(Input,Output,Lang1,Lang2).


%%  file_atoms(File, Atom) is nondet.
%
%   read each line as atom on backtrack
%

%read_file_to_codes('hello.c', Input, [])


%main :-  [Lang1,Lang2] = [pegjs,nearley], Input='expr = term',translate(Input,Output,Lang1,Lang2), writeln('\n'), writeln(Input), writeln(Output), writeln('\n').

main :- 
	[Lang1,Lang2]=['javascript','ruby'],
	%Input = 'def add(a,b) a=1 end',
	%Input = 'var a = 1; var theDict = {q:1,d:3}; theDict[stuff] = 1; var access_dict = theDict[q];',
	%Input = 'throw "err"; public class A{ public static int add(int a, int b){ return a + b; } }',
	Input = 'var theDict = {q:1,d:3}; theDict[stuff] = 1; var access_dict = theDict[q]; function subtract(a,b){return a - b;} function multiply(a,b){return a * b;} var aVar = multiply(3,4)+subtract(5,2); class theClass{ static divide(a,b){ return a/b; } constructor(a){ a = 1; } add(a,b){return a + b;} multiply(a,b){return a*b;}} var theInstance = new theClass(1); var m = theInstance.add(3,4); var m1 = theClass.add(5,6);',
	%Input='functionCall(1,3); z=1; function subtract(a,b){return a - b;} var q = stuff + 1; switch(i){case 1: console.log(1); break; case 2: console.log(2); break; default: console.log(i);} var theArr = [3,4]; var j = 2; class A{ add(a,b){if(a > 3){return self.a;} else if(a > 4){return b+a;} else{return 0;}}}',
	translate(Input,Output,Lang1,Lang2), writeln('\n'), writeln(Input), writeln('\n'), writeln(Output), writeln('\n').
