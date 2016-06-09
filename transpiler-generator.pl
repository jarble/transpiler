% This is a program that translates several programming languages into several other languages.
% For example:
%    translate("int add(a){ if(g){ return a; } }",E,c,java)
% will translate a short C program into the equivalent Java syntax. Conversely, we can write
%    translate("public static int add(a){ if(g){ return a; } }",E,java,c)
% to translate a Java function into C

:- use_module(library(prolog_stack)).
:- use_module(library(error)).

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

main :- 
   get_user_input('\nEdit the source code in input.txt, type the name of the the input language, and press Enter:',Lang1),get_user_input('Type name of the the output language, then press Enter. The file will be saved in output.txt.',Lang2),File='input.txt',read_file_to_codes(File,Input_,[]),atom_codes(Input,Input_),
   writeln(Input), translate(Input,Output,Lang1,Lang2), writeln('\n'), writeln(Input), writeln('\n'), writeln(Output), writeln('\n'),
   Output_file='output.txt',
   open(Output_file,write,Stream),
   write(Stream,Output),
   close(Stream),halt.

%Use this rule to define operators for various languages

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


var_name(Data,Type,A) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['engscript', 'ruby', 'cosmos', 'englishscript','vbscript','polish notation','reverse polish notation','wolfram','pseudocode','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','visual basic .net','clojure','haxe','coffeescript','dart','javascript','c#','python','haskell','c','lua','gambas','common lisp','scheme','rebol','f#'])}->
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
    memberchk([[Name|Namespace],Type1], Var_types), Type = Type1.

%also called optional parameters
default_parameter(Data,[Type1,Name1,Default1]) -->
        {
                Data = [Lang|_],
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1),
                Value = var_name(Data,Type1,Default1)
        },
        ({memberchk(Lang,['python','autohotkey','julia','nemerle','php','javascript'])}->
                Name,python_ws,"=",python_ws,Value;
        {memberchk(Lang,['c#','d','groovy','c++'])}->
                Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['dart'])}->
                "[",ws,Type,ws_,Name,ws,"=",ws,Value,ws,"]";
        {memberchk(Lang,['ruby'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['scala','swift','python'])}->
                Name,python_ws,":",python_ws,Type,python_ws,"=",python_ws,Value;
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
        {memberchk(Lang,['haskell','hy','ruby','perl 6','cosmos','polish notation','reverse polish notation','scheme','python','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','python','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','lua','r','bc'])}->
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
        {memberchk(Lang,['python'])} ->
                "retype";    
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
        {memberchk(Lang,['hack','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','python','hy','java','c#','c','c++','vala','nemerle'])}->
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

type(Lang,boolean) --> type(Lang,bool).
type(Lang,integer) --> type(Lang,int).
type(Lang,str) --> type(Lang,string).



type(Lang,string) -->
    {memberchk(Lang,['z3',cosmos,'java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','visual basic .net','monkey x'])}->
            "String";
    {memberchk(Lang,['vala','seed7','octave','picat','mathematical notation','polish notation','reverse polish notation','prolog','d','chapel','minizinc','genie','hack','nim','algol 68','typescript','coffeescript','octave','tcl','awk','julia','c#','f#','perl','lua','javascript','go','php','c++','nemerle','erlang'])}->
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
    {memberchk(Lang,['typescript','seed7','hy','java','javascript','lua','perl'])}->
            "boolean";
    {memberchk(Lang,['c++','python','nim','octave','dafny','chapel','c','rust','minizinc','engscript','dart','d','vala','go','cobra','c#','f#','php','hack'])}->
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
    {memberchk(Lang,['pydatalog','hy','ruby','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','z3','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','lua','go','awk','haskell','r','visual basic','visual basic .net'])}->
            ws_;
    {memberchk(Lang,['java','c','pseudocode','perl 6','haxe','javascript','c++','c#','php','dart','actionscript','typescript','processing','vala','bc','ceylon','hack','perl'])}->
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
                ("\"",python_ws,A,python_ws,"\"";"'",python_ws,A,python_ws,"'"),python_ws,":",python_ws,B;
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
                A,python_ws,"=",python_ws,"(",python_ws,")";
        {not_defined_for(Data,'_enum_list')}).



statements(Data,Return_type,[A]) --> statement(Data,Return_type,A).
statements(Data,Return_type,[A|B]) --> {Data = [Lang|_]}, statement(Data,Return_type,A),statement_separator(Lang),statements(Data,Return_type,B).


% whitespace
ws --> "";((" ";"\t";"\n"),ws).
ws_ --> (" ";"    ";"\n"),ws.

python_ws --> "";((" ";"    "),ws).
python_ws_ --> (" ";"    "),ws.

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
regex_literal(Lang,S_) --> 
    {S = regex_inner(S_)},
    ({memberchk(Lang,['javascript'])} ->
        "/",S,"/";
    {memberchk(Lang,['haxe'])} ->
        "~/",S,"/";
    {memberchk(Lang,['python'])} ->
        "re",python_ws,".",python_ws,"compile",python_ws,"(\"",S,"\")";
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
digit(Let)     --> [Let], { code_type1(Let, digit) }.



not_defined_for(Data,Function) :-
        Data = [Lang,Is_input|_],
        (Is_input ->
            true;
        writeln(Function),writeln('not defined for'),writeln(Lang)).


statements_with_ws(Data,A) -->
    ws,(include_in_each_file(Data);""),ws_separated_statements(Data,A),ws.

include_in_each_file([Lang|_]) -->
    {memberchk(Lang,['prolog'])} ->
        ":- initialization(main). :- set_prolog_flag(double_quotes, chars).";
    {memberchk(Lang,['perl'])} ->
        "use strict;\nuse warnings;";
    {not_defined_for(include_in_each_file,[Lang|_])}.
	

translate(Input1,Output1,Lang1,Lang2) :-
        atom_chars(Input1, Input),
        (phrase(statements_with_ws([Lang1,true,[],Var_types,"\n"],Ls), Input),
        phrase(statements_with_ws([Lang2,false,[],Var_types,"\n"],Ls), Output)),
        atom_chars(Output1, Output),
        print_var_types(Var_types).
        
print_var_types([A]) :-
    writeln(A).
print_var_types([A|Rest]) :-
    writeln(A),print_var_types(Rest).

list_of_langs(X) :-
	X = [python,javascript,lua,perl,ruby,prolog,c,z3,'c#',java].

translate(Input,Output,Lang2) :-
    list_of_langs(X),member(Lang1,X)-> translate(Input,Output,Lang1,Lang2).



get_user_input(V1,V2) :-
	writeln(V1),read_line(V3),atom_string(V2,V3).


statement_with_semicolon(Data,_,prolog_concatenate_string(Output_,Str1_,Str2_)) --> 
{
	Data = [Lang|_],
	Output = expr(Data,string,Output_),
	Str1 = expr(Data,string,Str1_),
	Str2 = expr(Data,string,Str2_)
},
	({memberchk(Lang,['javascript'])}->
		Output,ws,"=",ws,Str1,ws,"+",ws,Str2;
	{not_defined_for(Data,'prolog_concatenate_string')}).

statement_with_semicolon(Data,Return_type,return(To_return1,Function_name)) --> 
        {
                Data = [Lang|_],
                A = expr(Data,Return_type,To_return1)
        },
    ({memberchk(Lang,['vbscript'])}->
			Function_name,ws,"=",ws,A;
	{memberchk(Lang,['pseudocode','java','seed7','xl','e','livecode','englishscript','cython','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','coffeescript','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','lua','python','rebol','ruby','tcl','awk','bc','chapel','perl 6'])}->
			"return",python_ws_,A;
	{memberchk(Lang,['minizinc','prolog','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','haskell','ml','racket','nemerle'])}->
			A;
	{memberchk(Lang,['pseudocode','visual basic','visual basic .net','autoit','monkey x'])}->
			"Return",ws_,A;
	{memberchk(Lang,['octave','fortran','picat'])}->
			"retval",ws,"=",ws,A;
	{memberchk(Lang,['cosmos'])}->
			"Return",python_ws,"=",python_ws,A;
	{memberchk(Lang,['pascal'])}->
			"Exit",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['pseudocode','r'])}->
			"return",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['wolfram'])}->
			"Return",ws,"[",ws,A,ws,"]";
	{memberchk(Lang,['pop-11'])}->
			A,ws,"->",ws,"Result";
	{memberchk(Lang,['delphi','pascal'])}->
			"Result",ws,"=",ws,A;
	{memberchk(Lang,['pseudocode','sql'])}->
			"RETURN",ws_,A;
	{not_defined_for(Data,'return')}).

statement_with_semicolon(Data,_,plus_plus(Name1)) --> 
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1)
        },
        ({memberchk(Lang,[javascript,java,c])} ->
                Name,ws,"++";
        {memberchk(Lang,[python])} ->
                Name,python_ws,"+=",python_ws,"1";
        {not_defined_for(Data,'plus_plus')}).

statement_with_semicolon(Data,_,minus_minus(Name1)) --> 
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1)
        },
        ({memberchk(Lang,[javascript,java])} ->
                Name,ws,"--";
        {not_defined_for(Data,'minus_minus')}).

statement_with_semicolon(Data,_,initialize_constant(Type1,Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Value = expr(Data,Type1,Expr1),
                Type = type(Lang,Type1),
                Name = var_name(Data,Type1,Name1)
        },
        ({memberchk(Lang,['seed7'])}->
                "const",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,Name,ws_,Value;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws_,Value,ws_,"=";
        {memberchk(Lang,['fortran'])}->
                Type,ws,",",ws,"PARAMETER",ws,"::",ws,Name,ws,"=",ws,"expression";
        {memberchk(Lang,['go'])}->
                "const",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl 6'])}->
                "constant",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['php','javascript','dart'])}->
                "const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['z3'])}->
                "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Const",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
        {memberchk(Lang,['rust','swift'])}->
                "let",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c++','c','d','c#'])}->
                "const",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
        {memberchk(Lang,['minizinc'])}->
                Type,ws,":",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['scala'])}->
                "val",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['python','ruby','haskell','erlang','julia','picat','prolog'])}->
                Name,python_ws,"=",python_ws,Value;
        {memberchk(Lang,['lua'])}->
                "local",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl'])}->
                "my",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"inline",ws_,"var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['java','dart'])}->
                "final",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c'])}->
                "static",ws_,"const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['chapel'])}->
                "var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['typescript'])}->
                "const",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {not_defined_for(Data,'declare_constant')}).



statement_with_semicolon(Data,Type, function_call(Name1,Params1)) -->
	parentheses_expr(Data,Type, function_call(Name1,Params1)).

statement_with_semicolon(Data,_,set_array_size(Name1,Size1,Type1)) -->
		{
			Data = [Lang|_],
			Name = var_name(Data,Name1,[array,Type]),
			Size = expr(Data,int,Size1),
			Type = type(Lang,Type1)
			
		},
		({memberchk(Lang,['scala'])}->
                "var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"fill",ws,"(",ws,Size,ws,")",ws,"{",ws,"0",ws,"}";
        {memberchk(Lang,['octave'])}->
                Name,ws,"=",ws,"zeros",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['minizinc'])}->
                "array",ws,"[",ws,"1",ws,"..",ws,Size,ws,"]",ws_,"of",ws_,Type,ws,":",ws,Name,ws,";";
        {memberchk(Lang,['dart'])}->
                "List",ws_,Name,ws,"=",ws,"new",ws_,"List",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['java','c#'])}->
                Type,ws,"[]",ws_,Name,ws,"",ws,"=",ws,"new",ws_,Type,ws,"[",ws,Size,ws,"]";
        {memberchk(Lang,['fortran'])}->
                Type,ws,"(",ws,"LEN",ws,"=",ws,Size,ws,")",ws,"",ws,"::",ws,Name;
        {memberchk(Lang,['go'])}->
                "var",ws_,Name,ws_,"[",ws,Size,ws,"]",ws,Type;
        {memberchk(Lang,['swift'])}->
                "var",ws_,Name,ws,"=",ws,"[",ws,Type,ws,"]",ws,"(",ws,"count:",ws,Size,ws,",",ws,"repeatedValue",ws,":",ws,"0",ws,")";
        {memberchk(Lang,['c','c++'])}->
                Type,ws_,Name,ws,"[",ws,Size,ws,"]";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,"array",ws_,Size;
        {memberchk(Lang,['visual basic .net'])}->
                "Dim",ws_,Name,ws,"(",ws,Size,ws,")",ws_,"as",ws_,Type;
        {memberchk(Lang,['php'])}->
                Name,ws,"=",ws,"array_fill",ws,"(",ws,"0",ws,",",ws,Size,ws,",",ws,"0",ws,")";
        {memberchk(Lang,['haxe'])}->
                "var",ws_,"vector",ws,"=",ws,"",ws_,"haxe",ws,".",ws,"ds",ws,".",ws,"Vector",ws,"(",ws,Size,ws,")";
        {memberchk(Lang,['javascript'])}->
                "var",ws_,Name,ws,"=",ws,"Array",ws,".",ws,"apply",ws,"(",ws,"null",ws,",",ws,"Array",ws,"(",ws,Size,ws,")",ws,")",ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,")",ws,"{",ws,"}",ws,")";
        {memberchk(Lang,['vbscript'])}->
                "Dim",ws_,Name,ws,"(",ws,Size,ws,")";
        {not_defined_for(Data,'set_array_size')}).

statement_with_semicolon(Data,_,set_dict(Name1,Index1,Expr1,Type)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,[dict,Type],Name1),
		Index = var_name(Data,string,Index1),
		Value = expr(Data,Type,Expr1)
	},
    ({memberchk(Lang,['javascript','c++','haxe','c#'])}->
			Name,"[",Index,"]",ws,"=",ws,Value;
	{memberchk(Lang,['python'])}->
			Name,"[",Index,"]",python_ws,"=",python_ws,Value;
	{memberchk(Lang,['java'])}->	
			Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")";
	{not_defined_for(Data,'set_dict')}).

statement_with_semicolon(Data,_,set_var(Name1,Expr1,Type)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,Type,Name1),
		Value = expr(Data,Type,Expr1)
	},
    ({memberchk(Lang,['javascript','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','sympy','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','coffeescript','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','lua','ruby','gambas','octave','visual basic','visual basic .net','bc'])}->
			Name,ws,"=",ws,Value;
	{memberchk(Lang,['python'])}->
			Name,python_ws,"=",python_ws,Value;
	%depends on the type of Value
	{memberchk(Lang,['prolog'])}->
			Name,ws,"=",ws,Value;
	{memberchk(Lang,['hy'])}->
        "(",ws,"setv",ws_,Name,ws_,Value,ws,")";
	{memberchk(Lang,['minizinc'])}->
			"constraint",ws_,Name,ws,"=",ws,Value;
	{memberchk(Lang,['rebol'])}->
			Name,ws,":",ws,Value;
	{memberchk(Lang,['z3'])}->
			"(",ws,"assert",ws,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
	{memberchk(Lang,['gap','seed7','delphi'])}->
			Name,ws,":=",ws,Value;
	{memberchk(Lang,['livecode'])}->
			"put",ws_,"expression",ws_,"into",ws_,Name;
	{memberchk(Lang,['vbscript'])}->
			"Set",ws_,"a",ws,"=",ws,"b";
	{not_defined_for(Data,'set_var')}).

statement_with_semicolon(Data,_,initialize_empty_var(Type1,Name1)) -->
	{
			Data = [Lang|_],
			Name = var_name(Data,Type1,Name1),
			Type = type(Lang,Type1)
	},
    ({memberchk(Lang,['swift','scala','typescript'])}->
			"var",ws_,Name,ws,":",ws,Type;
	{memberchk(Lang,['java','c#','c++','c','d','janus','fortran','dart'])}->
			Type,ws_,Name;
	{memberchk(Lang,['prolog'])}->
			Type,ws,"(",ws,Name,ws,")";
	{memberchk(Lang,['javascript','haxe'])}->
			"var",ws_,Name;
	{memberchk(Lang,['minizinc'])}->
			Type,ws,":",ws,Name;
	{memberchk(Lang,['pascal'])}->
			Name,ws,":",ws,Type;
	{memberchk(Lang,['go'])}->
			"var",ws_,Name,ws_,Type;
	{memberchk(Lang,['z3'])}->
			"(",ws,"declare-const",ws_,Name,ws_,Type,ws,")";
	{memberchk(Lang,['lua','julia'])}->
			"local",ws_,Name;
	{memberchk(Lang,['visual basic .net'])}->
			"Dim",ws_,Name,ws_,"As",ws_,Type;
	{memberchk(Lang,['perl'])}->
			"my",ws_,Name;
	{memberchk(Lang,['perl 6'])}->
			"my",ws_,Type,ws_,Name;
	{memberchk(Lang,['z3py'])}->
			Name,ws,"=",ws,Type,ws,"(",ws,"'",ws,Name,ws,"'",ws,")";
	{not_defined_for(Data,'initialize_empty_var')}).

statement_with_semicolon(Data,_,throw(Expr1)) -->
	{
			Data = [Lang|Rest],
			Data1 = [_|Rest],
			A = expr(Data,string,Expr1)
	},
	({memberchk(Lang,['python'])}->
			"raise",python_ws_,"Exception",python_ws,"(",python_ws,A,python_ws,")";
	{memberchk(Lang,['ruby','ocaml'])}->
			"raise",ws_,A;
	{memberchk(Lang,['javascript','dart','java','c++','swift','rebol','haxe','c#','picat','scala'])}->
			"throw",ws_,A;
	{memberchk(Lang,['julia','e'])}->
			"throw",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['visual basic .net'])}->
			"Throw",ws_,A;
	{memberchk(Lang,['perl','perl 6'])}->
			"die",ws_,A;
	{memberchk(Lang,['octave'])}->
			"error",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['php'])}->
			"throw",ws_,"new",ws_,"Exception",ws,"(",ws,A,ws,")";
	{memberchk(Lang,['pseudocode'])}->
			statement_with_semicolon(Data1,_,throw(Expr1));
	{not_defined_for(Data,'throw')}).

statement_with_semicolon(Data,_,initialize_var(Type1,Name1,Value1)) -->
	{
		Data = [Lang|_],
		Name = var_name(Data,Type1,Name1),
		Type = type(Lang,Type1),
		Value = expr(Data,Type1,Value1)
	},
	({memberchk(Lang,[pseudocode])}->
		("var",ws_,Name,ws,"=",ws,Value;
		Type,ws,":",ws,Name,ws,"=",ws,Value;
		"var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
		"let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
		"local",ws_,Name,ws,"=",ws,Value;
		"Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
		(Type;"var"),ws_,Name,ws,"=",ws,Value;
		Type,ws_,Name,ws,"=",ws,Value;
		"my",ws_,Type,ws_,Name,ws,"=",ws,Value;
		"local",ws_,(Type,ws_;""),Name,ws,"=",ws,Value);
	{memberchk(Lang,['polish notation'])}->
        "=",ws_,Name,ws_,Value;
    {memberchk(Lang,['hy'])}->
        "(",ws,"setv",ws_,Name,ws_,Value,ws,")";
    {memberchk(Lang,['reverse polish notation'])}->
        Name,ws_,Value,ws_,"=";
    {memberchk(Lang,['go'])}->
        "var",ws_,Name,ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['rust'])}->
        "let",ws_,"mut",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','dafny'])}->
        "var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
    {memberchk(Lang,['z3'])}->
        "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
    {memberchk(Lang,['f#'])}->
        "let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['common lisp'])}->
        "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
    {memberchk(Lang,['minizinc'])}->
        Type,ws,":",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['python','ruby','haskell','erlang','prolog','logtalk','julia','picat','octave','wolfram'])}->
        Name,ws,"=",ws,Value;
    {memberchk(Lang,['javascript','hack','swift'])}->
        "var",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','lua'])}->
        "local",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','janus'])}->
        "local",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','perl'])}->
        "my",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','perl 6'])}->
        "my",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','c','java','cosmos','c++','d','dart','englishscript','ceylon'])}->
        Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','c#','vala'])}->
        (Type;"var"),ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['rebol'])}->
        Name,ws,":",ws,Value;
    {memberchk(Lang,['pseudocode','visual basic','visual basic .net','openoffice basic'])}->
        "Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['r'])}->
        Name,ws,"<-",ws,Value;
    {memberchk(Lang,['pseudocode','fortran'])}->
        Type,ws,"::",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','chapel','haxe','scala','typescript'])}->
        "var",ws_,Name,(ws,":",Type,ws,ws;ws),"=",ws,Value;
    {memberchk(Lang,['monkey x'])}->
        "Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['vbscript'])}->
        "Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['pseudocode','seed7'])}->
        "var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
	{not_defined_for(Data,'initialize_var')}).

statement_with_semicolon(Data,_,append_to_array(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Expr = expr(Data,Type,Expr1),
                Name = var_name(Data,[array,Type],Name1)
        },
        ({memberchk(Lang,[javascript])} ->
                Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")";
        {memberchk(Lang,[python])} ->
                Name,"+=","[",Expr,"]";
        {memberchk(Lang,[php])} ->
                "array_push",ws,"(",ws,Expr,ws,")";
        {memberchk(Lang,[lua])} ->
                Name,"[#",Name,ws,"+",ws,"1",ws,"]",ws,"=",ws,Expr;
        {not_defined_for(Data,'append_to_array')}).

statement_with_semicolon(Data,_,pop(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Expr = expr(Data,Type,Expr1),
                Name = var_name(Data,[array,Type],Name1)
        },
        ({memberchk(Lang,['python'])} ->
                Name,python_ws,".",python_ws,"pop",python_ws,"(",python_ws,Expr,python_ws,")";
        {not_defined_for(Data,'pop')}).

statement_with_semicolon(Data,_,plus_equals(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                A = var_name(Data,int,Name1),
                B = expr(Data,int,Expr1)
        },
        ({memberchk(Lang,['janus','nim','vala','perl 6','dart','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift'])}->
                A,ws,"+=",ws,B;
        {memberchk(Lang,['ruby','haskell','erlang','fortran','ocaml','minizinc','octave','delphi'])}->
                A,ws,"=",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['picat'])}->
                A,ws,":=",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['rebol'])}->
                A,ws,":",ws,A,ws,"+",ws,B;
        {memberchk(Lang,['livecode'])}->
                "add",ws_,B,ws_,"to",ws_,A;
        {memberchk(Lang,['seed7'])}->
                A,ws,"+:=",ws,B;
        {not_defined_for(Data,'plus_equals')}).
        
statement_with_semicolon(Data,_,minus_equals(Name1,Expr1)) -->
	{
		Data = [Lang|_],
		A = var_name(Data,int,Name1),
		B = expr(Data,int,Expr1)
	},
    ({memberchk(Lang,['janus','vala','nim','perl 6','dart','perl','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift'])}->
			A,ws,"-=",ws,B;
	{memberchk(Lang,['ruby','haskell','erlang','fortran','ocaml','minizinc','octave','delphi'])}->
			A,ws,"=",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['picat'])}->
			A,ws,":=",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['rebol'])}->
			A,ws,":",ws,A,ws,"-",ws,B;
	{memberchk(Lang,['livecode'])}->
			"subtract",ws_,B,ws_,"from",ws_,A;
	{memberchk(Lang,['seed7'])}->
			A,ws,"-:=",ws,B;
	{not_defined_for(Data,'minus_equals')}).

statement_with_semicolon(Data,_,append_to_string(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Name = var_name(Data,string,Name1),
                Expr = expr(Data,string,Expr1)
        },
        ({memberchk(Lang,[c,java,'c#',javascript,python])} ->
                Name,ws,"+=",ws,Expr;
        {memberchk(Lang,[php,perl])} ->
                Name,ws,".=",ws,Expr;
        {memberchk(Lang,[lua])} ->
                Name,ws,"=",ws,Name,ws,"..",ws,Expr;
        {not_defined_for(Data,'append_to_string')}).

statement_with_semicolon(Data,_,times_equals(Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Name = var_name(Data,int,Name1),
                Expr = expr(Data,int,Expr1)
        },
        ({memberchk(Lang,[c,java,'c#',javascript,php,perl])} ->
                Name,ws,"*=",ws,Expr;
        {not_defined_for(Data,'*=')}).



statement_with_semicolon(Data,Type,print(Expr1)) -->
        {
                Data = [Lang|_],
                A = expr(Data,Type,Expr1)
        },
        ({memberchk(Lang,['ocaml'])}->
                "print_string",ws_,A;
        {memberchk(Lang,['minizinc'])}->
                "trace",ws,"(",ws,A,ws,",",ws,"true",ws,")";
        {memberchk(Lang,['perl 6'])}->
                "say",ws_,A;
        {memberchk(Lang,['erlang'])}->
                "io",ws,":",ws,"fwrite",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "cout",ws,"<<",ws,A;
        {memberchk(Lang,['haxe'])}->
                "trace",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['go'])}->
                "fmt",ws,".",ws,"Println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#'])}->
                "Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol','fortran','perl','php'])}->
                "print",ws_,A;
        {memberchk(Lang,['ruby'])}->
                "puts",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "System",ws,".",ws,"Console",ws,".",ws,"WriteLine",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala','julia','swift','picat'])}->
                "println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','typescript'])}->
                "console",ws,".",ws,"log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','englishscript','cython','ceylon','r','gosu','dart','vala','perl','php','hack','awk','lua'])}->
                "print",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java'])}->
                "System",ws,".",ws,"out",ws,".",ws,"println",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c'])}->
                "printf",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"putStrLn",ws_,A,ws,")";
        {memberchk(Lang,['hy','common lisp'])}->
                "(",ws,"print",ws_,A,ws,")";
        {memberchk(Lang,['rust'])}->
                "println!(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "disp",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['chapel','d','seed7','prolog'])}->
                "writeln",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['delphi'])}->
                "WriteLn",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['frink'])}->
                "print",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['wolfram'])}->
                "Print",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['z3'])}->
                "(",ws,"echo",ws_,A,ws,")";
        {memberchk(Lang,['monkey x'])}->
                "Print",ws_,A;
        {not_defined_for(Data,'print')}).

parentheses_expr(Data,Type, function_call(Name1,Params1,Params2)) -->
	{
			Data = [Lang|_],
			Name = function_name(Data,Type,Name1,Params2),
			(Args = function_call_parameters(Data,Params1,Params2))
	},
    ({memberchk(Lang,['c','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','prolog','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','ruby','vala','f#','java','ceylon','ocaml','erlang','python','c#','lua','haxe','javascript','dart','bc','visual basic','visual basic .net','php','perl'])}->
			Name,python_ws,"(",python_ws,Args,python_ws,")";
	{memberchk(Lang,['haskell','z3','clips','clojure','common lisp','clips','racket','scheme','rebol'])}->
			"(",ws,Name,ws_,Args,ws,")";
	{memberchk(Lang,['polish notation'])}->
			Name,ws_,Args;
	{memberchk(Lang,['reverse polish notation'])}->
			Args,ws_,Name;
	{memberchk(Lang,['pydatalog','nearley'])}->
			Name,ws,"[",ws,Args,ws,"]";
	{memberchk(Lang,['hy'])}->
		"(",ws,Name,ws_,Args,ws,")";
	{not_defined_for(Data,'function_call')}).

parentheses_expr(Data,Type,instance_method_call(Function_name_,Class_name_,Instance_name_,Params1)) -->
	{
			Data = [Lang,Is_input,_|Rest],
			Data1 = [Lang,Is_input,[Class_name_]|Rest],
			Instance_name = var_name(Data,Class_name_,Instance_name_),
			Function_name = function_name(Data1,Type,Function_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    ({memberchk(Lang,['java','ruby','haxe','javascript','lua','c#','c++'])}->
		Instance_name,".",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['logtalk'])}->
		Instance_name,"::",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['perl'])}->
		Instance_name,"->",Function_name,ws,"(",ws,Args,ws,")";
	{not_defined_for(Data,'instance_method_call')}).

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
    ({memberchk(Lang,['java','ruby','javascript','lua','c#'])}->
		Class_name,".",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['php','c++'])}->
		Class_name,"::",Function_name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['perl'])}->
		Class_name,"->",Function_name,ws,"(",ws,Args,ws,")";
	{not_defined_for(Data,'static_method_call')}).


parentheses_expr(Data,string,type_conversion(string,Arg1)) -->
        {
                Data = [Lang|_],
                Arg = parentheses_expr(Data,int,Arg1)
        },
        (
        {memberchk(Lang,[python])} ->
                "str",python_ws,"(",python_ws,Arg,python_ws,")";
        {memberchk(Lang,['c#'])} ->
                Arg,ws,".",ws,"ToString",ws,"(",ws,")";
        {memberchk(Lang,[javascript])} ->
                "String",ws,"(",ws,Arg,ws,")";
        {not_defined_for(Data,'type_conversion')}).

parentheses_expr(Data,Type1,anonymous_function(Type1,Params1,Body1)) -->
        {
                Data = [Lang|_],
                B = statements(Data,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data,Params1)),
                Type = type(Lang,Type1)
        },
        ({memberchk(Lang,['matlab','octave'])}->
                "(",ws,"@",ws,"(",ws,Params,ws,")",ws,B,ws,")";
        {memberchk(Lang,['picat'])}->
                "lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,B,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Function",ws,"(",ws,Params,ws,")",ws_,B,ws_,"End",ws_,"Function";
        {memberchk(Lang,['ruby'])}->
                "Proc",ws,".",ws,"new",ws,"{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}";
        {memberchk(Lang,['javascript','typescript','haxe','r','php'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")";
        {memberchk(Lang,['frink'])}->
                "{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}";
        {memberchk(Lang,['erlang'])}->
                "fun",ws,"(",ws,Params,ws,")",ws_,B,"end";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws,"(",ws,Params,ws,")",ws_,B,"end";
        {memberchk(Lang,['swift'])}->
                "{",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws_,"in",ws_,B,ws,"}";
        {memberchk(Lang,['go'])}->
                "func",ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['dart','scala'])}->
                "(",ws,"(",ws,Params,ws,")",ws,"=>",ws,B,ws,")";
        {memberchk(Lang,['c++'])}->
                "[",ws,"=",ws,"]",ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['java'])}->
                "(",ws,Params,ws,")",ws,"->",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "(",ws,"name",ws_,Params,ws,"->",ws,B,ws,")";
        {memberchk(Lang,['python'])}->
                "(",python_ws,"lambda",python_ws_,Params,ws,":",python_ws,B,python_ws,")";
        {memberchk(Lang,['delphi'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"begin",ws_,B,"end",ws,";";
        {memberchk(Lang,['d'])}->
                "(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['rebol'])}->
                "func",ws_,"[",ws,Params,ws,"]",ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['rust'])}->
                "fn",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {not_defined_for(Data,'anonymous_function')}).

parentheses_expr(Data,int,floor(Params1)) -->
        {       Data = [Lang|_],
                Params = expr(Data,int,Params1)},
        (
                {memberchk(Lang,[javascript,java])} ->
                        "Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")";
                {not_defined_for(Data,'floor')}
        ).

parentheses_expr(Data,int,ceiling(Params1)) -->
        {Data = [Lang|_], Params = expr(Data,int,Params1)},
        (
                {memberchk(Lang,[javascript,java])} ->
                        "Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")";
                {not_defined_for(Data,'ceiling')}
        ).

parentheses_expr(Data,int,cos(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        (
		{memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",python_ws,".",python_ws,"cos",python_ws,"(",python_ws,Var1,python_ws,")";
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Cos",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['rebol'])}->
                "cosine/radians",ws_,Var1;
        {memberchk(Lang,['english'])}->
                "the cosine of",ws_,Var1;
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"cos",ws_,Var1,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/cos",ws_,Var1,ws,")";
        {not_defined_for(Data,'cos')}).
        
parentheses_expr(Data,int,sin(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        ({memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",python_ws,".",python_ws,"sin",python_ws,"(",python_ws,Var1,python_ws,")";
        {memberchk(Lang,['english'])}->
                "the sine of",ws_,Var1;
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Sin",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "sine/radians",ws_,Var1;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"sin",ws_,Var1,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/sin",ws_,Var1,ws,")";
        {not_defined_for(Data,'sin')}).

parentheses_expr([Lang|_],bool,"true") -->
	{memberchk(Lang,['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','ruby','erlang','c#','haxe','go','ocaml','lua','scala','php','rebol'])}->
			"true";
	{memberchk(Lang,['python','pydatalog','hy','cython','autoit','haskell','visual basic .net','vbscript','visual basic','monkey x','wolfram','delphi'])}->
			"True";
	{memberchk(Lang,['perl','awk','tcl'])}->
			"1";
	{memberchk(Lang,['racket'])}->
			"#t";
	{memberchk(Lang,['common lisp'])}->
			"t";
	{memberchk(Lang,['fortran'])}->
			".TRUE.";
	{memberchk(Lang,['r','seed7'])}->
			"TRUE";
	{not_defined_for([Lang|_],'true_')}.

parentheses_expr([Lang|_],bool,"false") -->
    {memberchk(Lang,['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','ruby','erlang','c#','haxe','go','ocaml','lua','scala','php','rebol','hack'])}->
			"false";
	{memberchk(Lang,['python','pydatalog','hy','cython','autoit','haskell','visual basic .net','vbscript','visual basic','monkey x','wolfram','delphi'])}->
			"False";
	{memberchk(Lang,['perl','awk','tcl'])}->
			"0";
	{memberchk(Lang,['common lisp'])}->
			"nil";
	{memberchk(Lang,['racket'])}->
			"#f";
	{memberchk(Lang,['fortran'])}->
			".FALSE.";
	{memberchk(Lang,['seed7','r'])}->
			"FALSE";
	{not_defined_for([Lang|_],'false_')}.

parentheses_expr(Data,int,tan(Var1_)) -->
        {Data = [Lang|_], Var1 = expr(Data,int,Var1_)},
        ({memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",python_ws,".",python_ws,"tan",python_ws,"(",python_ws,Var1,python_ws,")";
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Tan",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "tangent/radians",ws_,Var1;
        {memberchk(Lang,['english'])}->
                "the tangent of",ws_,Var1;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"tan",ws_,"a",ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/tan",ws_,"a",ws,")";
        {not_defined_for(Data,'tan')}).

parentheses_expr(_,string,string_literal(A)) --> string_literal(A).
parentheses_expr([Lang|_],regex,regex_literal(A)) --> regex_literal(Lang,A).
parentheses_expr(_,string,string_literal1(A)) --> string_literal1(A).

parentheses_expr(Data,[array,Type],initializer_list(A_)) -->
        {
                Data = [Lang|_],
                A = initializer_list_(Data,Type,A_)
        },
        ({memberchk(Lang,['java','pseudocode','picat','c#','go','lua','c++','c','visual basic .net','visual basic','wolfram'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['python', 'cosmos', 'nim','d','frink','rebol','octave','julia','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','ruby','rebol','polish notation','swift'])}->
                "[",python_ws,A,python_ws,"]";
        {memberchk(Lang,['php'])}->
                "array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala'])}->
                "Array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','chapel'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['fortran'])}->
                "(/",ws,A,ws,"/)";
        {not_defined_for(Data,'initializer_list')}).
        
parentheses_expr(Data,[dict,Type1],dict(A_)) -->
        {
                Data = [Lang|_],
                A = dict_(Data,Type1,A_)
        },
        ({memberchk(Lang,['python', 'cosmos', 'dart','javascript','typescript','lua','ruby','julia','c++','engscript','visual basic .net'])}->
                "{",python_ws,A,python_ws,"}";
        {memberchk(Lang,['picat'])}->
                "new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")";
        {memberchk(Lang,['go'])}->
                "map",ws,"[",ws,"Input",ws,"]",ws,"Output",ws,"{",ws,A,ws,"}";
        {memberchk(Lang,['perl'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haxe','frink','swift','elixir','d','wolfram'])}->
                "[",ws,A,ws,"]";
        {memberchk(Lang,['scala'])}->
                "Map(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "struct",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "to-hash",ws,"[",ws,A,ws,"]";
        {not_defined_for(Data,'dict')}).

%should be inclusive range
parentheses_expr(Data,[array,int],range(A_,B_)) -->
	{
		Data = [Lang|_],
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
	({memberchk(Lang,['swift','perl','picat','ruby','minizinc','chapel'])}->
		"(",ws,A,ws,"..",ws,B,ws,")";
	{memberchk(Lang,['rust'])}->
		"(",ws,A,ws,"...",ws,B,ws,")";
	{memberchk(Lang,"python")} ->
		"range",python_ws,"(",python_ws,A,python_ws,",",B,python_ws,"-",python_ws,"1",python_ws,")";
	{not_defined_for(Data,'range')}).

parentheses_expr(Data,Type,var_name(A)) -->
	var_name(Data,Type,A).
parentheses_expr(_,int,a_number(A)) -->
	a_number(A).
parentheses_expr(Data,Type,parentheses(A)) -->
	"(",ws,expr(Data,Type,A),ws,")".

expr(Data,int,pi) -->
	{Data = [Lang|_]},
	({memberchk(Lang,[java,pseudocode,javascript])} ->
			"Math",ws,".",ws,"PI";
	{memberchk(Lang,[lua,pseudocode])} ->
			"math",ws,".",ws,"pi";
	{not_defined_for(Data,'pi')}).
expr(Data,grammar, grammar_or(Var1_,Var2_)) -->
	{
			Data = [Lang|_],
			Var1 = parentheses_expr(Data,grammar,Var1_),
			Var2 = expr(Data,bool,Var2_)
	},
    ({memberchk(Lang,['marpa','rebol','yapps','antlr','jison','waxeye','ometa','ebnf','nearley','parslet','yacc','perl 6','rebol','hampi','earley-parser-js'])}->
			Var1,ws,"|",ws,Var2;
	{memberchk(Lang,['lpeg'])}->
			Var1,ws,"+",ws,Var2;
	{memberchk(Lang,['peg.js','abnf','treetop'])}->
			Var1,ws,"/",ws,Var2;
	{memberchk(Lang,['prolog'])}->
			Var1,ws,";",ws,Var2;
	{memberchk(Lang,['parboiled'])}->
			"Sequence",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")";
	{not_defined_for(Data,'grammar_Or')}).

expr(Data,bool, or(Var1_,Var2_)) -->
        {
                Data = [Lang|_],
                Var1 = parentheses_expr(Data,bool,Var1_),
                Var2 = expr(Data,bool,Var2_)
        },
    ({memberchk(Lang,[javascript,katahdin,'perl 6',wolfram,chapel,elixir,frink,ooc,picat,janus,processing,pike,nools,pawn,matlab,hack,gosu,rust,autoit,autohotkey,typescript,ceylon,groovy,d,octave,awk,julia,scala,'f#',swift,nemerle,vala,go,perl,java,haskell,haxe,c,'c++','c#',dart,r])}->
        Var1,ws,"||",ws,Var2;
    {memberchk(Lang,[python,cosmos,seed7,pydatalog,livecode,englishscript,cython,gap,'mathematical notation',genie,idp,maxima,engscript,ada,newlisp,ocaml,nim,coffeescript,pascal,delphi,erlang,rebol,lua,php,ruby])}->
        Var1,ws_,"or",ws_,Var2;
    {memberchk(Lang,[fortran])}->
        Var1,ws_,".OR.",ws_,Var2;
    {memberchk(Lang,[z3,clips,clojure,'common lisp','emacs lisp',clojure,racket])}->
        "(",ws,"or",ws_,Var1,ws_,Var2,ws,")";
    {memberchk(Lang,[prolog])}->
        Var1,ws,";",ws,Var2;
    {memberchk(Lang,[minizinc])}->
        Var1,ws,"\\/",ws,Var2;
    {memberchk(Lang,['visual basic','visual basic .net','monkey x'])}->
        Var1,ws_,"Or",ws_,Var2;
    {not_defined_for(Data,'or')}).

expr(Data,int,index_of(Str1_,Str2_)) -->
        {
                Data = [Lang|_],
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
    ({memberchk(Lang,[javascript,java])}->
        String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")";
    {memberchk(Lang,[d])}->
        String,ws,".",ws,"indexOfAny",ws,"(",ws,Substring,ws,")";
    {memberchk(Lang,[ruby])}->
        String,ws,".",ws,"index",ws,"(",ws,Substring,ws,")";
    {memberchk(Lang,['c#'])}->
        String,ws,".",ws,"IndexOf",ws,"(",ws,Substring,ws,")";
    {memberchk(Lang,[python])}->
        String,python_ws,".",python_ws,"find",python_ws,"(",python_ws,Substring,python_ws,")";
    {memberchk(Lang,[go])}->
        "strings",ws,".",ws,"Index",ws,"(",ws,String,ws,",",ws,Substring,ws,")";
    {memberchk(Lang,[lua])}->
        "string",ws,".",ws,"find",ws,"(",ws,String,ws,",",ws,Substring,ws,")";
    {memberchk(Lang,[perl])}->
        "index",ws,"(",ws,String,ws,",",ws,Substring,ws,")";
    {not_defined_for(Data,'index_of')}).

expr(Data,string,substring(Str_,Index1_,Index2_)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,string,Str_),
                B = parentheses_expr(Data,int,Index1_),
                C = parentheses_expr(Data,int,Index2_)
        },
    ({memberchk(Lang,['javascript','coffeescript','typescript','java','scala','dart'])}->
                A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,")";
        {memberchk(Lang,['c++'])}->
                A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,"-",ws,B,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"Substring",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['python','cython','icon','go'])}->
                A,ws,"[",ws,B,ws,":",ws,C,ws,"]";
        {memberchk(Lang,['julia:'])}->
                A,ws,"[",ws,B,ws,"-",ws,"1",ws,":",ws,C,ws,"]";
        {memberchk(Lang,['fortran'])}->
                A,ws,"(",ws,B,ws,":",ws,C,ws,")";
        {memberchk(Lang,['c#','visual basic .net','nemerle'])}->
                A,ws,".",ws,"Substring",ws,"(",ws,B,ws,",",ws,C,ws,")";
        {memberchk(Lang,['haskell'])}->
                "take",ws,"(",ws,C,ws,"-",ws,B,ws,")",ws,".",ws,"drop",ws,B,ws,"$",ws,A;
        {memberchk(Lang,['php','awk','perl','hack'])}->
                "substr",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")";
        {memberchk(Lang,['haxe'])}->
                A,ws,".",ws,"substr",ws,"(",ws,B,ws,",",ws,C,ws,")";
        {memberchk(Lang,['rebol'])}->
                "copy/part",ws_,"skip",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['clojure'])}->
                "(",ws,"subs",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['erlang'])}->
                "string",ws,":",ws,"sub_string",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")";
        {memberchk(Lang,['pike','groovy'])}->
                A,ws,"[",ws,B,ws,"..",ws,C,ws,"]";
        {memberchk(Lang,['racket'])}->
                "(",ws,"substring",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"subseq",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['lua'])}->
                "string",ws,".",ws,"sub",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")";
        {not_defined_for(Data,'substring')}).

expr(Data,bool,not(A1)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,bool,A1)
        },
        ({memberchk(Lang,['python','cython','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','lua','racket','common lisp','rebol','haskell','sibilant'])}->
                "(",ws,"not",ws_,A,ws,")";
        {memberchk(Lang,['java','perl 6','katahdin','coffeescript','frink','d','ooc','ceylon','processing','janus','pawn','autohotkey','groovy','scala','hack','rust','octave','typescript','julia','awk','swift','scala','vala','nemerle','pike','perl','c','c++','objective-c','tcl','javascript','r','dart','java','go','php','haxe','c#','wolfram'])}->
                "!",A;
        {memberchk(Lang,['prolog'])}->
                "\\+",A;
        {memberchk(Lang,['visual basic','visual basic .net','autoit','livecode','monkey x','vbscript'])}->
                "(",ws,"Not",ws_,A,ws,")";
        {memberchk(Lang,['fortran'])}->
                ".NOT.",A;
        {memberchk(Lang,['gambas'])}->
                "NOT",ws_,A;
        {memberchk(Lang,['rexx'])}->
                "\\",A;
        {memberchk(Lang,['pl/i'])}->
                "^",A;
        {memberchk(Lang,['powershell'])}->
                "-not",ws_,A;
        {memberchk(Lang,['polish notation'])}->
                "not",ws_,A,ws_,"b";
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,"not";
        {memberchk(Lang,['z3py'])}->
                "Not",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'not')}).

expr(Data,bool, and(A_,B_)) -->
        {Data = [Lang|_],
        A = parentheses_expr(Data,bool,A_),
        B = expr(Data,bool,B_)},
    ({memberchk(Lang,['javascript','ats','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r'])}->
			A,ws,"&&",ws,B;
	{memberchk(Lang,['pydatalog'])}->
			A,ws,"&",ws,B;
	{memberchk(Lang,['python','seed7','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','lua','php','ruby'])}->
			A,ws_,"and",ws_,B;
	{memberchk(Lang,['minizinc'])}->
			A,ws,"/\\",ws,B;
	{memberchk(Lang,['fortran'])}->
			A,ws,".AND.",ws,B;
	{memberchk(Lang,['common lisp','z3','newlisp','racket','clojure','sibilant','hy','clips','emacs lisp'])}->
			"(",ws,"and",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['prolog'])}->
			A,ws,",",ws,B;
	{memberchk(Lang,['visual basic','visual basic .net','vbscript','openoffice basic','monkey x'])}->
			A,ws_,"And",ws_,B;
	{memberchk(Lang,['polish notation'])}->
			"and",ws_,A,ws_,B;
	{memberchk(Lang,['reverse polish notation'])}->
			A,ws_,B,ws_,"and";
	{memberchk(Lang,['z3py'])}->
			"And",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{not_defined_for(Data,'And')}).

expr(Data,bool,int_not_equal(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,[javascript,php])} ->
                infix_operator(Data,int,("!==";"!="),A,B);
        {memberchk(Lang,[java,cosmos,nim,octave,r,picat,englishscript,'perl 6',wolfram,c,'c++',d,'c#',julia,perl,ruby,haxe,python,cython,minizinc,scala,swift,go,rust,vala])} ->
                infix_operator(Data,int,"!=",A,B);
        {memberchk(Lang,[lua])} ->
                infix_operator(Data,int,"~=",A,B);
        {memberchk(Lang,[rebol,seed7,'visual basic .net','visual basic',gap,ocaml,livecode,'monkey x',vbscript,delphi])} ->
                infix_operator(Data,int,"<>",A,B);
        {memberchk(Lang,['common lisp',z3])} ->
                "(","not",ws,"(","=",ws_,A,ws_,B,")",")";
        {not_defined_for(Data,'not_equal')}).
                
expr(Data,bool,greater_than(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,">",A,B);
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,">",ws_,A,ws_,B,ws,")";
        {not_defined_for(Data,'>')}).

expr(Data,bool,greater_than_or_equal(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,">=",A,B);
        {not_defined_for(Data,'>=')}).
                
expr(Data,bool,less_than_or_equal(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,"<=",A,B);
        {not_defined_for(Data,'<=')}).
                
expr(Data,bool,less_than(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,"<",A,B);
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,"<",ws_,A,ws_,B,ws,")";
        {not_defined_for(Data,'<')}).

expr(Data,bool,compare(int,Var1_,Var2_)) -->
        {Data = [Lang|_],Var1=parentheses_expr(Data,int,Var1_),Var2=expr(Data,int,Var2_)},
        ({memberchk(Lang,['r'])}->
                "identical",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")";
        {memberchk(Lang,['lua','nim','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','python','c#','c','go','haskell','ruby'])}->
                Var1,ws,"==",ws,Var2;
        {memberchk(Lang,['javascript','php','typescript','hack'])}->
                Var1,ws,"===",ws,Var2;
        {memberchk(Lang,['z3','emacs lisp','common lisp','clips','racket'])}->
                "(",ws,"=",ws_,Var1,ws_,Var2,ws,")";
        {memberchk(Lang,['fortran'])}->
                Var1,ws,".eq.",ws,Var2;
        {memberchk(Lang,['maxima','seed7','monkey x','gap','rebol','f#','autoit','pascal','delphi','visual basic','visual basic .net','ocaml','livecode','vbscript'])}->
                Var1,ws,"=",ws,Var2;
        {memberchk(Lang,['prolog'])}->
                Var1,ws,"=:=",ws,Var2;
        {memberchk(Lang,['clojure'])}->
                "(",ws,"=",ws_,Var1,ws_,Var2,ws,")";
        {memberchk(Lang,['reverse polish notation'])}->
                Var1,ws_,Var2,ws_,"=";
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,Var1,ws_,Var2;
        {not_defined_for(Data,'compare_ints')}).
        
expr(Data,bool,compare(bool,Exp1,Exp2)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['lua','nim','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','python','c#','c','go','haskell','ruby'])}->
                infix_operator(Data,bool,"==",Exp1,Exp2);
        {memberchk(Lang,[javascript,php])} ->
                infix_operator(Data,bool,("===";"=="),Exp1,Exp2);
        {memberchk(Lang,[prolog])} ->
                infix_operator(Data,bool,"=",Exp1,Exp2);
        {not_defined_for(Data,'compare_bool')}).

expr(Data,bool,compare(string,Exp1_,Exp2_)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,string,Exp1_),
                B = expr(Data,string,Exp2_)
        },
    ({memberchk(Lang,['r'])}->
			"identical",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['emacs lisp'])}->
			"(",ws,"string=",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['clojure'])}->
			"(",ws,"=",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['visual basic','delphi','visual basic .net','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x'])}->
			A,ws,"=",ws,B;
	{memberchk(Lang,['python','pydatalog','perl 6','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','lua','swift'])}->
			A,ws,"==",ws,B;
	{memberchk(Lang,['javascript','php','typescript','hack'])}->
			A,ws,"===",ws,B;
	{memberchk(Lang,['c','octave'])}->
			"strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"==",ws,"0";
	{memberchk(Lang,['c++'])}->
			A,ws,".",ws,"compare",ws,"(",ws,B,ws,")";
	{memberchk(Lang,['c#'])}->
			A,ws,".",ws,"Equals",ws,"(",ws,B,ws,")";
	{memberchk(Lang,['java'])}->
			A,ws,".",ws,"equals",ws,"(",ws,B,ws,")";
	{memberchk(Lang,['common lisp'])}->
			"(",ws,"equal",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['clips'])}->
			"(",ws,"str-compare",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['hy'])}->
			"(",ws,"=",ws_,A,ws_,B,ws,")";
	{memberchk(Lang,['perl'])}->
			A,ws_,"eq",ws_,B;
	{memberchk(Lang,['erlang'])}->
			"string",ws,":",ws,"equal",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['polish notation'])}->
			"=",ws_,A,ws_,B;
	{memberchk(Lang,['reverse polish notation'])}->
			A,ws_,B,ws_,"=";
	{not_defined_for(Data,'strcmp')}).

expr(Data,string,concatenate_string(A_,B_)) -->
        {
                Data = [Lang|_],
                B = expr(Data,string,B_),
                A = parentheses_expr(Data,string,A_)
        },
    ({memberchk(Lang,['r'])}->
                "paste0",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['maxima'])}->
                "sconcat",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"concatenate",ws_,"'string",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['c','cosmos','z3py','monkey x','englishscript','mathematical notation','go','java','chapel','frink','freebasic','nemerle','d','cython','ceylon','coffeescript','typescript','dart','gosu','groovy','scala','swift','f#','python','javascript','c#','haxe','c++','vala'])}->
                A,ws,"+",ws,B;
        {memberchk(Lang,['lua','engscript'])}->
                A,ws,"..",ws,B;
        {memberchk(Lang,['fortran'])}->
                A,ws,"//",ws,B;
        {memberchk(Lang,['php','autohotkey','hack','perl'])}->
                A,ws,".",ws,B;
        {memberchk(Lang,['ocaml'])}->
                A,ws,"^",ws,B;
        {memberchk(Lang,['rebol'])}->
                "append",ws_,A,ws_,B;
        {memberchk(Lang,['haskell','minizinc','picat','elm'])}->
                A,ws,"++",ws,B;
        {memberchk(Lang,['clips'])}->
                "(",ws,"str-cat",ws,A,ws,B,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"str",ws,A,ws,B,ws,")";
        {memberchk(Lang,['erlang'])}->
                "string",ws,":",ws,"concat",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['julia'])}->
                "string",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['octave'])}->
                "strcat",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['racket'])}->
                "(",ws,"string-append",ws,A,ws,B,ws,")";
        {memberchk(Lang,['delphi'])}->
                "Concat",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['visual basic','seed7','gambas','nim','autoit','visual basic .net','openoffice basic','livecode','vbscript'])}->
                A,ws,"&",ws,B;
        {memberchk(Lang,['elixir','wolfram'])}->
                A,ws,"<>",ws,B;
        {memberchk(Lang,['perl 6'])}->
                A,ws,"~",ws,B;
        {memberchk(Lang,['z3'])}->
                "(",ws,"Concat",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['emacs lisp'])}->
                "(",ws,"concat",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['polish notation'])}->
                "+",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,"+";
        {not_defined_for(Data,'concatenate_string')}).

expr(Data,int,mod(A_,B_)) -->
	{
		Data = [Lang|_],
		A = parentheses_expr(Data,int,A_),
		B = expr(Data,int,B_)
	},
    ({memberchk(Lang,['java','perl 6','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','lua','tcl','go','dart','javascript','python','c','c++','c#','ruby'])}->
        A,ws,"%",ws,B;
    {memberchk(Lang,['rebol'])}->
        "mod",ws_,A,ws_,B;
    {memberchk(Lang,['haskell','seed7','minizinc','ocaml','delphi','pascal','picat','livecode'])}->
        A,ws_,"mod",ws_,B;
    {memberchk(Lang,['prolog','octave','matlab','autohotkey','fortran'])}->
        "mod",ws,"(",ws,A,ws,",",ws,B,ws,")";
    {memberchk(Lang,['erlang'])}->
        A,ws_,"rem",ws_,B;
    {memberchk(Lang,['clips','clojure','common lisp','z3'])}->
        "(",ws,"mod",ws_,A,ws_,B,ws,")";
    {memberchk(Lang,['visual basic','visual basic .net','monkey x'])}->
        A,ws_,"Mod",ws_,B;
    {memberchk(Lang,['wolfram'])}->
        "Mod",ws,"[",ws,A,ws,",",ws,B,ws,"]";
    {not_defined_for(Data,'mod')}).

expr(Data,int,arithmetic(Exp1_,Exp2_,Symbol)) -->
        {
                Data = [Lang|_],
                Exp1 = parentheses_expr(Data,int,Exp1_),
                Exp2 = expr(Data,int,Exp2_),
                member(Symbol,["+","-","*","/"])
        },
        ({memberchk(Lang,['java', 'ruby', 'logtalk', 'prolog', 'cosmos','pydatalog','e','livecode','vbscript','monkey x','englishscript','gap','pop-11','dafny','janus','wolfram','chapel','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','b-prolog','agda','picat','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','erlang','gambas','hack','c++','matlab','rebol','red','lua','go','awk','haskell','perl','python','javascript','c#','php','r','haxe','visual basic','visual basic .net','vala','bc'])}->
                Exp1,python_ws,Symbol,python_ws,Exp2;
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,Symbol,ws_,Exp1,ws_,Exp2,ws,")";
        {not_defined_for(Data,'arithmetic')}).

expr(Data,int,pow(Exp1_,Exp2_)) -->
	{
		Data = [Lang|_],
		A = parentheses_expr(Data,int,Exp1_),
		B = parentheses_expr(Data,int,Exp2_)
	},
    ({memberchk(Lang,['lua'])}->
			"math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['scala'])}->
			"scala.math.pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['c#','visual basic .net'])}->
			"Math",ws,".",ws,"Pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['javascript','java','typescript','haxe'])}->
			"Math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['python','seed7','cython','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran'])}->
			"(",python_ws,A,python_ws,"**",python_ws,B,python_ws,")";
	{memberchk(Lang,['rebol'])}->
			"power",ws_,A,ws_,B;
	{memberchk(Lang,['c','c++','php','hack','swift','minizinc','dart','d'])}->
			"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{memberchk(Lang,['julia','engscript','visual basic','visual basic .net','gambas','go','ceylon','wolfram','mathematical notation'])}->
			A,ws,"^",ws,B;
	{memberchk(Lang,['hy','common lisp','racket','clojure'])}->
			"(",ws,"expt",ws_,"num1",ws_,"num2",ws,")";
	{memberchk(Lang,['erlang'])}->
			"math",ws,":",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
	{not_defined_for(Data,'pow')}).


expr(Data,[array,string],split(Exp1,Exp2)) -->
	{
		Data = [Lang|_],
		AString = parentheses_expr(Data,string,Exp1),
		Separator = parentheses_expr(Data,string,Exp2)
	},
    ({memberchk(Lang,['swift'])}->
			AString,ws,".",ws,"componentsSeparatedByString",ws,"(",ws,Separator,ws,")";
	{memberchk(Lang,['octave'])}->
			"strsplit",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
	{memberchk(Lang,['go'])}->
			"strings",ws,".",ws,"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
	{memberchk(Lang,['javascript','coffeescript','java','python','dart','scala','groovy','haxe','rust','typescript','cython','vala'])}->
			AString,python_ws,".",python_ws,"split",python_ws,"(",python_ws,Separator,python_ws,")";
	{memberchk(Lang,['lua'])}->
			"string",ws,".",ws,"gmatch",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
	{memberchk(Lang,['php'])}->
			"explode",ws,"(",ws,Separator,ws,",",ws,AString,ws,")";
	{memberchk(Lang,['perl','processing'])}->
			"split",ws,"(",ws,Separator,ws,",",ws,AString,ws,")";
	{memberchk(Lang,['rebol'])}->
			"split",ws_,AString,ws_,Separator;
	{memberchk(Lang,['c#'])}->
			AString,ws,".",ws,"Split",ws,"(",ws,"new",ws,"string[]",ws,"{",ws,Separator,ws,"}",ws,",",ws,"StringSplitOptions",ws,".",ws,"None",ws,")";
	{memberchk(Lang,['picat','d','julia'])}->
			"split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
	{memberchk(Lang,['haskell'])}->
			"(",ws,"splitOn",ws_,AString,ws_,Separator,ws,")";
	{memberchk(Lang,['wolfram'])}->
			"StringSplit",ws,"[",ws,AString,ws,",",ws,Separator,ws,"]";
	{memberchk(Lang,['visual basic .net'])}->
			"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
	{not_defined_for(Data,'split')}).

expr(Data,[array,string],concatenate_arrays(A1_,A2_)) -->
        {
                Data = [Lang|_],
                A1 = parentheses_expr(Data,string,A1_),
                A2 = parentheses_expr(Data,string,A2_)
        },
        ({memberchk(Lang,[javascript])} ->
                A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")";
        {memberchk(Lang,[haskell])} ->
                A1,ws,"++",ws,A2;
        {memberchk(Lang,[python,ruby])} ->
                A1,python_ws,"+",python_ws,A2;
        {memberchk(Lang,[d])} ->
                A1,python_ws,"~",python_ws,A2;
        {memberchk(Lang,[perl])} ->
                "push",ws,"(",ws,A1,ws,",",ws,A2,ws,")";
        {memberchk(Lang,[php])} ->
                "array_merge",ws,"(",ws,A1,ws,",",ws,A2,ws,")";
        {memberchk(Lang,[hy])}->
                "(",ws,"+",ws_,A1,ws_,A2,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])} ->
                A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")",ws,".",ws,"ToArray",ws,"(",ws,")";
        {not_defined_for(Data,'concatenate_arrays')}).

expr(Data,string,join(Exp1,Exp2)) -->
        {
                Data = [Lang|_],
                Array = parentheses_expr(Data,[array,string],Exp1),
                Separator = parentheses_expr(Data,string,Exp2)
        },
        ({memberchk(Lang,['swift'])}->
                Array,ws,".",ws,"joinWithSeparator",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['c#'])}->
                "String",ws,".",ws,"Join",ws,"(",ws,Separator,ws,",",ws,Array,ws,")";
        {memberchk(Lang,['php'])}->
                "implode",ws,"(",ws,Separator,ws,",",ws,Array,ws,")";
        {memberchk(Lang,['perl'])}->
                "join",ws,"(",ws,Separator,ws,",",ws,Array,ws,")";
        {memberchk(Lang,['d','julia'])}->
                "join",ws,"(",ws,Array,ws,",",ws,Separator,ws,")";
        {memberchk(Lang,['lua'])}->
                "table",ws,".",ws,"concat",ws,"(",ws,Array,ws,",",ws,Separator,ws,")";
        {memberchk(Lang,['go'])}->
                "Strings",ws,".",ws,"join",ws,"(",ws,Array,ws,",",ws,Separator,ws,")";
        {memberchk(Lang,['javascript','haxe','coffeescript','groovy','java','typescript','rust','dart'])}->
                Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['python'])}->
                Separator,python_ws,".",python_ws,"join",python_ws,"(",python_ws,Array,python_ws,")";
        {memberchk(Lang,['scala'])}->
                Array,ws,".",ws,"mkString",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Join",ws,"(",ws,"array,",ws,Separator,ws,")";
        {not_defined_for(Data,'join')}).
        
expr(Data,int,sqrt(Exp1)) -->
        {
                Data = [Lang|_],
                X = expr(Data,int,Exp1)
        },
    ({memberchk(Lang,['livecode'])}->
                "(",ws,"the",ws_,"sqrt",ws_,"of",ws_,X,ws,")";
        {memberchk(Lang,['java','javascript','typescript','haxe'])}->
                "Math",ws,".",ws,"sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['c','seed7','julia','perl','php','perl 6','maxima','minizinc','prolog','octave','d','haskell','swift','mathematical notation','dart','picat'])}->
                "sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",python_ws,".",python_ws,"sqrt",python_ws,"(",python_ws,X,python_ws,")";
        {memberchk(Lang,['rebol'])}->
                "square-root",ws_,X;
        {memberchk(Lang,['scala'])}->
                "scala",ws,".",ws,"math",ws,".",ws,"sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['c++'])}->
                "std",ws,"::",ws,"sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['erlang'])}->
                "math",ws,":",ws,"sqrt",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Sqrt",ws,"[",ws,X,ws,"]";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"sqrt",ws_,X,ws,")";
        {memberchk(Lang,['fortran'])}->
                "SQRT",ws,"(",ws,X,ws,")";
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Sqrt",ws,"(",ws,X,ws,")";
        {not_defined_for(Data,'sqrt')}).

expr(Data,Type1,list_comprehension(Result1,Var1,Condition1,Array1)) -->
        {
                Data = [Lang|_],
                Variable = var_name(Data,Type,Var1),
                Array = expr(Data,[array,Type],Array1),
                Result = expr(Data,Type1,Result1),
                Condition = expr(Data,bool,Condition1)
        },
        ({memberchk(Lang,['python','cython'])}->
                "[",python_ws,Result,python_ws_,"for",python_ws_,Variable,python_ws_,"in",python_ws_,Array,python_ws_,"if",python_ws_,Condition,python_ws,"]";
        {memberchk(Lang,['ceylon'])}->
                "{",ws,"for",ws,"(",ws,Variable,ws_,"in",ws_,Array,ws,")",ws_,"if",ws,"(",ws,Condition,ws,")",ws_,Result,ws,"}";
        {memberchk(Lang,['javascript'])}->
                "[",ws,Result,ws_,"for",ws,"(",ws,Variable,ws_,"of",ws_,Array,ws,")",ws,"if",ws_,Condition,ws,"]";
        {memberchk(Lang,['coffeescript'])}->
                "(",ws,Result,ws_,"for",ws_,Variable,ws_,"in",ws_,Array,ws_,"when",ws_,Condition,ws,")";
        {memberchk(Lang,['minizinc'])}->
                "[",ws,Result,ws,"|",ws,Variable,ws_,"in",ws_,Array,ws_,"where",ws_,Condition,ws,"]";
        {memberchk(Lang,['haxe'])}->
                "[",ws,"for",ws,"(",ws,Variable,ws_,"in",ws_,Array,ws,")",ws,"if",ws,"(",ws,Condition,ws,")",ws,Result,ws,"]";
        {memberchk(Lang,['c#'])}->
                "(",ws,"from",ws_,Variable,ws_,"in",ws_,Array,ws_,"where",ws_,Condition,ws_,"select",ws_,Result,ws,")";
        {memberchk(Lang,['haskell'])}->
                "[",ws,Result,ws,"|",ws,Variable,ws,"<-",ws,Array,ws,",",ws,Condition,ws,"]";
        {memberchk(Lang,['erlang'])}->
                "[",ws,Result,ws,"||",ws,Variable,ws,"<-",ws,Array,ws,",",ws,Condition,ws,"]";
        {memberchk(Lang,['scala'])}->
                "(",ws,"for",ws,"(",ws,Variable,ws,"<-",ws,Array,ws_,"if",ws_,Condition,ws,")",ws,"yield",ws_,Result,ws,")";
        {memberchk(Lang,['groovy'])}->
                "array.grep",ws,"{",ws,Variable,ws,"->",ws,Condition,ws,"}.collect",ws,"{",ws,Variable,ws,"->",ws,Result,ws,"}";
        {memberchk(Lang,['dart'])}->
                Array,ws,".",ws,"where",ws,"(",ws,Variable,ws,"=>",ws,Condition,ws,")",ws,".",ws,"map",ws,"(",ws,Variable,ws,"=>",ws,Result,ws,")";
        {memberchk(Lang,['picat'])}->
                "[",ws,Result,ws,":",ws,Variable,ws_,"in",ws_,Array,ws,",",ws,Condition,ws,"]";
        {not_defined_for(Data,'list_comprehension')}).

expr(Data,string,charAt(Str_,Int_)) -->
        {
                Data = [Lang|_],
                AString = parentheses_expr(Data,string,Str_),
                Index = expr(Data,int,Int_)
        },
        ({memberchk(Lang,['java','haxe','scala','javascript','typescript'])}->
                AString,ws,".",ws,"charAt",ws,"(",ws,Index,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"CharAt",ws_,"expression",ws_,Index,ws,")";
        {memberchk(Lang,['c','php','c#','minizinc','c++','picat','haskell','dart'])}->
                AString,ws,"[",ws,Index,ws,"]";
        {memberchk(Lang,['python'])}->
                AString,python_ws,"[",python_ws,Index,python_ws,"]";
        {memberchk(Lang,['lua'])}->
                AString,ws,":",ws,"sub(",ws,Index,ws,"+",ws,"1",ws,",",ws,Index,ws,"+",ws,"1",ws,")";
        {memberchk(Lang,['octave'])}->
                AString,ws,"(",ws,Index,ws,")";
        {memberchk(Lang,['chapel'])}->
                AString,ws,".",ws,"substring",ws,"(",ws,Index,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                AString,ws,".",ws,"Chars",ws,"(",ws,Index,ws,")";
        {memberchk(Lang,['go'])}->
                "string",ws,"(",ws,"[",ws,"]",ws,"rune",ws,"(",ws,AString,ws,")",ws,"[",ws,Index,ws,"]",ws,")";
        {memberchk(Lang,['swift'])}->
                AString,ws,"[",ws,AString,ws,".",ws,"startIndex",ws,".",ws,"advancedBy",ws,"(",ws,Index,ws,")",ws,"]";
        {memberchk(Lang,['rebol'])}->
                AString,ws,"/",ws,Index;
        {memberchk(Lang,['perl'])}->
                "substr",ws,"(",ws,AString,ws,",",ws,Index,ws,"-",ws,"1",ws,",",ws,"1",ws,")";
        {not_defined_for(Data,'charAt')}).

expr(Data,string,endswith(Str1_,Str2_)) -->
        {
                Data = [Lang|_],
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = expr(Data,string,Str2_)
        },
        ({memberchk(Lang,[python])} ->
                Str1,python_ws,".",python_ws,"endswith",python_ws,"(",python_ws,Str2,python_ws,")";
        {memberchk(Lang,[java,javascript])} ->
                Str1,ws,".",ws,"endsWith",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,[java,'c#'])} ->
                Str1,ws,".",ws,"EndsWith",ws,"(",ws,Str2,ws,")";
        {not_defined_for(Data,'endswith')}).

expr(Data,string,reverse_string(Str_)) -->
        {
                Data = [Lang|_],
                Str = expr(Data,string,Str_)
        },
        ({memberchk(Lang,[java])} ->
                "new",ws_,"StringBuilder",ws,"(",ws,Str,ws,")",ws,".",ws,"reverse",ws,"(",ws,")",ws,".",ws,"toString",ws,"(",ws,")";
        {memberchk(Lang,[perl])} ->
                "reverse",ws,"(",Str,")";
        {memberchk(Lang,[php])} ->
                "strrev",ws,"(",ws,Str,ws,")";
        {memberchk(Lang,[lua])} ->
                "string",ws,".",ws,"reverse",ws,"(",ws,Str,ws,")";
        {memberchk(Lang,[javascript])} ->
                "esrever",ws,".",ws,"reverse",ws,"(",ws,Str,ws,")";
        {memberchk(Lang,[python])} ->
                Str,"[::-1]";
        {not_defined_for(Data,'reverse_string')}).

expr(Data,string,string_contains(Str1_,Str2_)) -->
        {
                Data = [Lang|_],
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = parentheses_expr(Data,string,Str2_)
        },
        ({memberchk(Lang,[c])} ->
                "(",ws,"strstr",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"NULL",ws,")";
        {memberchk(Lang,[ruby])} ->
                Str1,ws,".",ws,"include?",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,[lua])} ->
                "string",ws,".",ws,"find",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")";
        {memberchk(Lang,[java])} ->
                Str1,ws,".",ws,"contains",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,['c#'])} ->
                Str1,ws,".",ws,"Contains",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,[perl])} ->
                "(",ws,"index",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"-1",ws,")";
        {memberchk(Lang,[javascript])} ->
                "(",ws,Str1,ws,".",ws,"indexOf",ws,"(",ws,Str2,ws,")",ws,(">";"!==";"!="),ws,"-1",ws,")";
        {not_defined_for(Data,'string_contains')}).


expr(Data,string,startswith(Str1_,Str2_)) -->
        {
                Data = [Lang|_],
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = expr(Data,string,Str2_)
        },
        ({memberchk(Lang,[python])} ->
                Str1,python_ws,".",python_ws,"startswith",python_ws,"(",python_ws,Str2,python_ws,")";
        {memberchk(Lang,[java,javascript])} ->
                Str1,ws,".",ws,"startsWith",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,[swift])} ->
                Str1,ws,".",ws,"hasPrefix",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,['c#'])} ->
                Str1,ws,".",ws,"StartsWith",ws,"(",ws,Str2,ws,")";
        {memberchk(Lang,[haskell])} ->
                "(",ws,"isInfixOf",ws_,Str2,ws_,Str1,ws,")";
        {memberchk(Lang,[c])} ->
                "(",ws,"strncmp",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",ws,"strlen",ws,"(",ws,Str2,ws,")",ws,")",ws,"==",ws,"0",ws,")";
        {not_defined_for(Data,'startswith')}).

expr(Data,Type,parentheses_expr(A)) --> parentheses_expr(Data,Type,A).

expr(Data,Type,access_array(Array_,Index_)) -->
        {
                Data = [Lang|_],
                Array = parentheses_expr(Data,[array,Type],Array_),
                dif(Array,"this"),
                Index = parentheses_expr(Data,int,Index_)
        },
        ({memberchk(Lang,[java,javascript,python,'c#',c])} ->
                Array,"[",ws,Index,ws,"]";
        {memberchk(Lang,[lua])} ->
                Array,"[",ws,Index,"+",ws,"1",ws,"]";
        {memberchk(Lang,[perl])} ->
                "$",symbol(Array_),"[",Index,"]";
        {not_defined_for(Data,'access_array')}).


expr(Data,Type,this(A_)) -->
	{Data = [Lang|_], A = var_name(Data,Type,A_)},
	({memberchk(Lang,['coffeescript'])}->
			"@",A;
	{memberchk(Lang,['java','engscript','dart','groovy','typescript','javascript','c#','c++','haxe','chapel','julia'])}->
			"this",ws,".",ws,A;
	{memberchk(Lang,['python'])}->
			"self",python_ws,".",python_ws,A;
	{memberchk(Lang,['php','hack'])}->
			"$",ws,"this",ws,"->",ws,A;
	{memberchk(Lang,['swift','scala'])}->
			A;
	{memberchk(Lang,['rebol'])}->
			"self",ws,"/",ws,A;
	{memberchk(Lang,['visual basic .net'])}->
			"Me",ws,".",ws,A;
	{memberchk(Lang,['perl'])}->
			"$self",ws,"->",ws,A;
	{not_defined_for(Data,'this')}).

expr(Data,Type,access_dict(Dict_,Index_)) -->
        {
                Data = [Lang|_],
                Dict = var_name(Data,[dict,Type],Dict_),
                Index = expr(Data,int,Index_)
        },
        ({memberchk(Lang,[python])} ->
			Dict,python_ws,"[",python_ws,Index,python_ws,"]";
        {memberchk(Lang,[javascript,lua,'c++','haxe'])} ->
			(Dict,ws,"[",ws,Index,ws,"]");
		{memberchk(Lang,[javascript,lua,'c++','haxe'])} ->
			(Dict,ws,".",ws,"get",ws,"(",ws,Index,ws,")");
        {memberchk(Lang,[perl])} ->
			"$",symbol(Dict_),ws,"{",ws,Index,ws,"}";
        {not_defined_for(Data,'access_dict')}).
        
expr(Data,[array,string],command_line_args) -->
        {
                Data = [Lang|_]
        },
        ({memberchk(Lang,[lua])}->
                "arg";
        {memberchk(Lang,[ruby])}->
                "ARGV";
        {memberchk(Lang,[perl])}->
                "@ARGV";
        {memberchk(Lang,[python])}->
                "sys",python_ws,".",python_ws,"argv";
        {memberchk(Lang,[javascript])}->
                "process",ws,".",ws,"argv",ws,".",ws,"slice",ws,"(",ws,"2",ws,")";
        {not_defined_for(Data,'command_line_args')}).

expr(Data,Class_name_,call_constructor(Params1,Params2)) -->
	{
			Data = [Lang|_],
			Name = function_name(Data,Class_name_,Class_name_,Params2),
			Args = function_call_parameters(Data,Params1,Params2)
	},
    ({memberchk(Lang,['java','javascript','lua','haxe','chapel','scala','php'])}->
		"new",ws_,Name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['visual basic','visual basic .net'])}->
		"New",ws_,Name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['perl','perl 6'])}->
		Name,ws,"->",ws,"new",ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['ruby'])}->
		Name,ws,".",ws,"new",ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['python','swift','octave'])}->
		Name,python_ws,"(",python_ws,Args,python_ws,")";
	{memberchk(Lang,['c++'])}->
		Name,"::",Name,ws,"(",ws,Args,ws,")";
	{memberchk(Lang,['hy'])}->
		"(",ws,Name,ws_,Args,ws,")";
	{not_defined_for(Data,'call_constructor')}).


expr(Data,int,strlen(A1)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,string,A1)
        },
		({memberchk(Lang,['go','erlang','nim'])}->
                "len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python'])}->
                "len",python_ws,"(",python_ws,A,python_ws,")";
        {memberchk(Lang,['go','erlang','nim'])}->
                "len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['r'])}->
                "nchar",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['erlang'])}->
                "string:len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic','visual basic .net','gambas'])}->
                "Len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','typescript','scala','gosu','picat','haxe','ocaml','d','dart'])}->
                A,ws,".",ws,"length";
        {memberchk(Lang,['rebol'])}->
                "length?",ws_,A;
        {memberchk(Lang,['java','c++','kotlin'])}->
                A,ws,".",ws,"length",ws,"(",ws,")";
        {memberchk(Lang,['php','c','pawn','hack'])}->
                "strlen",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['minizinc','julia','perl','seed7','octave'])}->
                "length",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','nemerle'])}->
                A,ws,".",ws,"Length";
        {memberchk(Lang,['swift'])}->
                "countElements",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['autoit'])}->
                "StringLen",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['common lisp','haskell'])}->
                "(",ws,"length",ws_,A,ws,")";
        {memberchk(Lang,['racket','scheme'])}->
                "(",ws,"string-length",ws_,A,ws,")";
        {memberchk(Lang,['fortran'])}->
                "LEN",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['lua'])}->
                "string",ws,".",ws,"len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "StringLength",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['z3'])}->
                "(",ws,"Length",ws_,A,ws,")";
        {not_defined_for(Data,'strlen')}).


expr(Data,regex,new_regex(A1)) -->
        {
                Data = [Lang|_],
                A = expr(Data,string,A1)
        },
		({memberchk(Lang,['scala','c#'])}->
			"new",ws,"Regex",ws,"(",ws,A,ws,")";
		{memberchk(Lang,['javascript'])}->
			"new",ws,"RegExp",ws,"(",ws,A,ws,")";
		{memberchk(Lang,['python'])}->
			"re",python_ws,".",python_ws,"compile",python_ws,"(",python_ws,A,python_ws,")";
		{memberchk(Lang,['c++'])}->
			"regex",ws,"::",ws,"regex",ws,"(",ws,A,ws,")";
		{not_defined_for(Data,'new_regex')}).

expr(Data,bool,regex_matches_string(Str1,Reg1)) -->
        {
                Data = [Lang|_],
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,regex,Reg1)
        },
		({memberchk(Lang,['python'])}->
			Reg,python_ws,".",python_ws,"match",python_ws,"(",python_ws,Str,python_ws,")";
		{memberchk(Lang,['javascript'])}->
			Reg,ws,".",ws,"test",ws,"(",ws,Str,ws,")";
		{memberchk(Lang,['c#'])}->
			Reg,ws,".",ws,"IsMatch",ws,"(",ws,Str,ws,")";
		{memberchk(Lang,['haxe'])}->
			Reg,ws,".",ws,"match",ws,"(",ws,Str,ws,")";
		{not_defined_for(Data,'regex_matches_string')}).

expr(Data,bool,string_matches_string(Str1,Reg1)) -->
        {
                Data = [Lang|_],
                Str = parentheses_expr(Data,string,Str1),
                Reg = parentheses_expr(Data,string,Reg1)
        },
		({memberchk(Lang,['java'])}->
			Str,ws,".",ws,"matches",ws,"(",ws,Reg,ws,")";
		{memberchk(Lang,['php'])}->
			"preg_match",ws,"(",ws,Reg,ws,",",ws,Str,ws,")";
		{not_defined_for(Data,'string_matches_string')}).

		

expr(Data,int,array_length(A1,Type)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,[array,Type],A1)
        },
		({memberchk(Lang,['lua'])}->
                "#",A;
        {memberchk(Lang,['go'])}->
                "len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','cython'])}->
                "len",python_ws,"(",python_ws,A,python_ws,")";
        {memberchk(Lang,['java','picat','scala','d','coffeescript','typescript','dart','vala','javascript','haxe','cobra'])}->
                A,ws,".",ws,"length";
        {memberchk(Lang,['c#','visual basic','visual basic .net','powershell'])}->
                A,ws,".",ws,"Length";
        {memberchk(Lang,['minizinc','julia','r'])}->
                "length",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"list-length",ws_,A,ws,")";
        {memberchk(Lang,['php'])}->
                "count",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rust'])}->
                A,ws,".",ws,"len",ws,"(",ws,")";
        {memberchk(Lang,['emacs lisp','scheme','racket','haskell'])}->
                "(",ws,"length",ws_,A,ws,")";
        {memberchk(Lang,['c++','groovy'])}->
                A,ws,".",ws,"size",ws,"(",ws,")";
        {memberchk(Lang,['c'])}->
                "sizeof",ws,"(",ws,A,ws,")",ws,"/",ws,"sizeof",ws,"(",ws,A,ws,"[",ws,"0",ws,"]",ws,")";
        {memberchk(Lang,['perl'])}->
                "scalar",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "length?",ws_,A;
        {memberchk(Lang,['swift'])}->
                A,ws,".",ws,"count";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"count",ws_,"array",ws,")";
        {memberchk(Lang,['hy'])}->
                "(",ws,"len",ws_,A,ws,")";
        {memberchk(Lang,['octave','seed7'])}->
                "length",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['fortran','janus'])}->
                "size",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Length",ws,"[",ws,A,ws,"]";
        {not_defined_for(Data,'array_length')}).

statement(Data,grammar_statement(Name_,Body_)) -->
	{
	Data = [Lang|_],
	Name=var_name(Data,grammar,Name_),
	Body=expr(Data,grammar,Body_)
	},
	({memberchk(Lang,['pegjs'])}->
		Name,ws,"=",ws,Body;
	{not_defined_for([Lang|_],'grammar_statement')}).

statement([Lang|_],import(Module_)) -->
        {A = symbol(Module_)},
        ({memberchk(Lang,['r'])}->
                "source",ws,"(",ws,"\"",ws,A,ws,".",ws,"r\"",ws,")";
        {memberchk(Lang,['javascript'])}->
                "import",ws_,"*",ws_,"as",ws_,A,ws_,"from",ws_,"'",ws,A,ws,"'",ws,";";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"import",ws_,A,ws,")";
        {memberchk(Lang,['monkey x'])}->
                "Import",ws_,A;
        {memberchk(Lang,['fortran'])}->
                "USE",ws_,A;
        {memberchk(Lang,['visual basic .net'])}->
                "Imports",ws_,A;
        {memberchk(Lang,['rebol'])}->
                A,ws,":",ws_,"load",ws_,"%",ws,A,ws,".r";
        {memberchk(Lang,['prolog'])}->
                ":-",ws,"consult(",ws,A,ws,")";
        {memberchk(Lang,['minizinc'])}->
                "include",ws_,"'",ws,A,ws,".mzn'",ws,";";
        {memberchk(Lang,['php'])}->
                "include",ws_,"'",ws,A,ws,".php'",ws,";";
        {memberchk(Lang,['c','c++'])}->
                "#include",ws_,"\"",ws,A,ws,".h\"";
        {memberchk(Lang,['c#','vala'])}->
                "using",ws_,A,ws,";";
        {memberchk(Lang,['julia'])}->
                "using",ws_,A;
        {memberchk(Lang,['haskell','engscript','scala','go','groovy','picat','elm','swift','monkey x'])}->
                "import",ws_,A;
        {memberchk(Lang,['python'])}->
                "import",python_ws_,A;
        {memberchk(Lang,['java','d','haxe','ceylon'])}->
                "import",ws_,A,ws,";";
        {memberchk(Lang,['dart'])}->
                "import",ws_,"'",ws,A,ws,".dart'",ws,";";
        {memberchk(Lang,['ruby','lua'])}->
                "require",ws_,"'",ws,A,ws,"'";
        {memberchk(Lang,['perl','perl 6','chapel'])}->
                "\"use",ws,A,ws,";\"";
        {not_defined_for([Lang|_],'import')}).

statement(Data,enum(Name1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Namespace,Name1],Var_types,indent(Indent)],
                Name = symbol(Name1),
                Body = enum_list(Data1,Body1)
        },
        ({memberchk(Lang,['c'])}->
                "typedef",ws_,"enum",ws,"{",ws,Body,ws,"}",ws,Name,ws,";";
        {memberchk(Lang,['seed7'])}->
                "const",ws_,"type",ws,":",ws,Name,ws_,"is",ws_,"new",ws_,"enum",ws_,Body,ws_,"end",ws_,"enum",ws,";";
        {memberchk(Lang,['ada'])}->
                "type",ws_,Name,ws_,"is",ws_,"(",ws,Body,ws,")",ws,";";
        {memberchk(Lang,['perl 6'])}->
                "enum",ws_,Name,ws_,"<",ws,Body,ws,">",ws,";";
        {memberchk(Lang,['python'])}->
                "class",python_ws_,Name,python_ws,"(",python_ws,"AutoNumber",python_ws,")",python_ws,":",python_ws,"\n",python_ws,"#indent",python_ws,"\n",python_ws,"b",python_ws,"\n",python_ws,"#unindent";
        {memberchk(Lang,['java'])}->
                "public",ws_,"enum",ws_,Name,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c#','c++','typescript'])}->
                "enum",ws_,Name,ws,"{",ws,Body,ws,"}",ws,";";
        {memberchk(Lang,['haxe','rust','swift','vala'])}->
                "enum",ws_,Name,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['swift'])}->
                "enum",ws_,Name,ws,"{",ws,"case",ws_,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Enum",ws_,Name,ws_,Body,ws_,"End",ws_,"Enum";
        {memberchk(Lang,['fortran'])}->
                "ENUM",ws,"::",ws,Name,ws_,Body,ws_,"END",ws_,"ENUM";
        {memberchk(Lang,['go'])}->
                "type",ws_,Name,ws_,"int",ws_,"const",ws,"(",ws_,Body,ws_,")";
        {memberchk(Lang,['scala'])}->
                "object",ws_,Name,ws_,"extends",ws_,"Enumeration",ws,"{",ws,"val",ws_,Body,ws,"=",ws,"Value",ws,"}";
        {not_defined_for(Data,'enum')}).

statement(Data,Type1,function(Name1,Type1,Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = function_name(Data,Type1,Name1,Params1),
                Type = type(Lang,Type1),
                Body = statements(Data1,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
    (Indent;""),({memberchk(Lang,['sql'])}->
                "CREATE",ws_,"FUNCTION",ws_,"dbo",ws,".",ws,Name,ws,"(",ws,"function_parameters",ws,")",ws_,"RETURNS",ws_,Type,ws_,Body;
        {memberchk(Lang,['hy'])}->
			"(",ws,"defn",ws_,Name,ws_,"[",ws,Params,ws,"]",ws_,Body,ws,")";
        {memberchk(Lang,['seed7'])}->
                "const",ws_,"func",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws_,"is",ws_,"func",ws_,"begin",ws_,Body,(Indent;ws_),"end",ws_,"func",ws,";";
        {memberchk(Lang,['livecode'])}->
                "function",ws_,Name,ws_,Params,ws_,Body,(Indent;ws_),"end",ws_,Name;
        {memberchk(Lang,['monkey x'])}->
                "Function",ws,Name,ws,":",ws,Type,ws,"(",ws,Params,ws,")",ws,Body,ws_,"End";
        {memberchk(Lang,['emacs lisp'])}->
                "(",ws,"defun",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,Body,ws,")";
        {memberchk(Lang,['go'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['c++','vala','c','dart','ceylon','pike','d','englishscript'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['pydatalog'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"<=",ws,Body;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['javascript','php'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['wolfram'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,Body;
        {memberchk(Lang,['frink'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['pop-11'])}->
                "define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,"Result;",ws_,Body,ws_,"enddefine;";
        {memberchk(Lang,['z3'])}->
                "(",ws,"define-fun",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws_,Body,ws,")";
        {memberchk(Lang,['mathematical notation'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['chapel'])}->
                "proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['prolog',logtalk])}->
                Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body;
        {memberchk(Lang,['picat'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"retval",ws,"=>",ws,Body;
        {memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['maxima'])}->
                Name,ws,"(",ws,Params,ws,")",ws,":=",ws,Body;
        {memberchk(Lang,['rust'])}->
                "fn",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"defn",ws,Name,ws,"[",ws,Params,ws,"]",ws,Body,ws,")";
        {memberchk(Lang,['octave'])}->
                "function",ws_,"retval",ws,"=",ws,Name,ws,"(",ws,Params,ws,")",ws,Body,ws_,"endfunction";
        {memberchk(Lang,['haskell'])}->
                Name,ws_,Params,ws,"=",ws,Body;
        {memberchk(Lang,['common lisp'])}->
                "(defun",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")";
        {memberchk(Lang,['fortran'])}->
                "FUNC",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,"RESULT",ws,"(",ws,"retval",ws,")",ws_,Type,ws,"::",ws,"retval",ws_,Body,ws_,"END",ws_,"FUNCTION",ws_,Name;
        {memberchk(Lang,['scala'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"=",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['minizinc'])}->
                "function",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body;
        {memberchk(Lang,['clips'])}->
                "(",ws,"deffunction",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")";
        {memberchk(Lang,['erlang'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Body;
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['perl 6'])}->
                "sub",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['pawn'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['typescript'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['hack'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['r'])}->
                Name,ws,"<-",ws,"function",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['bc'])}->
                "define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['visual basic','visual basic .net'])}->
                "Function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['vbscript'])}->
                "Function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['racket','newlisp'])}->
                "(define",ws,"(name",ws,"params)",ws,Body,ws,")";
        {memberchk(Lang,['janus'])}->
                "procedure",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body;
        {memberchk(Lang,['python'])}->
                "def",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,")",python_ws,"->",python_ws,Type,python_ws,":",Body;
        {memberchk(Lang,['cosmos'])}->
                "rel",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,",",python_ws,"return",python_ws,")",python_ws,Body;
        {memberchk(Lang,['f#'])}->
                "let",python_ws_,Name,python_ws_,Params,python_ws,"=",Body;
        {memberchk(Lang,['polish notation'])}->
                "=",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"=";
        {memberchk(Lang,['ocaml'])}->
                "let",ws_,Name,ws_,Params,ws,"=",ws,Body;
        {memberchk(Lang,['e'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['pascal','delphi'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,";",ws,"begin",ws_,Body,(Indent;ws_),"end",ws,";";
        {not_defined_for(Data,'function')}).


%java-like class statements
statement(Data,Name1,class(Name1,Body1)) --> 
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = symbol(Name1),
                Body=class_statements(Data1,Name1,Body1)
        },
    (Indent;""),
    ({memberchk(Lang,['julia'])}->
                "type",ws_,Name,ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['c','z3','lua','prolog','haskell','minizinc','r','go','rebol','fortran'])}->
                Body;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['hy'])}->
                "(",ws,"defclass",ws_,Name,ws_,"[",ws,"object",ws,"]",ws_,Body,")";
        {memberchk(Lang,['perl'])}->
                "package",ws_,Name,";",ws,Body;
        {memberchk(Lang,['c++'])}->
                "class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}",ws,";";
         {memberchk(Lang,['logtalk'])}->
                "object",ws,"(",Name,")",ws,".",ws,Body,(Indent;ws),"end_object",ws,".";
        {memberchk(Lang,['javascript','hack','php','scala','haxe','chapel','swift','d','typescript','dart','perl 6'])}->
                "class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "class",ws_,Name,ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Class",ws_,Name,ws_,Body,ws_,"End",ws_,"Class";
        {memberchk(Lang,['vbscript'])}->
                "Public",ws_,"Class",ws_,Name,ws_,Body,ws_,"End",ws_,"Class";
        {memberchk(Lang,['python'])}->
                "class",python_ws_,Name,python_ws,":",Body;
        {memberchk(Lang,['monkey x'])}->
                "Class",ws_,Name,ws_,Body,ws_,"End";
        {not_defined_for(Data,'class')}).

statement(Data,C1,class_extends(C1_,C2_,B_)) --> 
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[C1_|Namespace],Var_types,indent(Indent)],
                C1 = symbol(C1_),
                C2 = symbol(C2_),
                B=class_statements(Data1,C1_,B_)
        },
        (Indent;""),({memberchk(Lang,['python'])}->
                "class",python_ws_,C1,python_ws,"(",python_ws,C2,python_ws,")",python_ws,":",B;
        {memberchk(Lang,['logtalk'])}->
                "object",ws,"(",C1,ws,",",ws,"extends",ws,"(",ws,C2,ws,")",ws,".",ws,Body,(Indent;ws),"end_object",ws,".";
        {memberchk(Lang,['hy'])}->
                "(",ws,"defclass",ws_,C1,ws_,"[",ws,C2,ws,"]",ws_,B,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Class",ws_,C1,ws_,"Inherits",ws_,C2,ws_,B,(Indent;ws),"End",ws_,"Class";
        {memberchk(Lang,['swift','chapel','d','swift'])}->
                "class",ws_,C1,ws,":",ws,C2,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['haxe','php','javascript','dart','typescript'])}->
                "class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['java','c#','scala'])}->
                "public",ws_,"class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['c'])}->
                "#include",ws_,"'",ws,C2,ws,".h'",ws_,B;
        {memberchk(Lang,['c++'])}->
                "class",ws_,C1,ws,":",ws,"public",ws_,C2,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "class",ws_,C1,ws_,"<",ws_,C2,ws_,B,(Indent;ws_),"end";
        {memberchk(Lang,['perl 6'])}->
                "class",ws_,C1,ws_,"is",ws_,C2,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['monkey x'])}->
                "Class",ws_,C1,ws_,"Extends",ws_,C2,ws_,B,ws_,"End";
        {not_defined_for(Data,'class_extends')}).

statement(Data,Return_type,semicolon(A)) -->
        {Data = [Lang,_,_,_,Indent]},
        (Indent;""),
        ({memberchk(Lang,['c','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala'])}->
                statement_with_semicolon(Data,Return_type,A),ws,";";
        {memberchk(Lang,['pseudocode'])}->
                statement_with_semicolon(Data,Return_type,A),("";ws,";");
        {memberchk(Lang,['visual basic .net','hy',picolisp,logtalk,cosmos,minizinc,ruby,lua,swift,rebol,fortran,python,go,picat,julia,prolog,haskell,'mathematical notation',erlang,z3])} ->
                statement_with_semicolon(Data,Return_type,A);
        {not_defined_for(Data,'semicolon')}).


statement(Data,Return_type,for(Statement1_,Expr_,Statement2_,Body1)) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                Body = statements(Data1,Return_type,Body1),
                Statement1 = statement_with_semicolon(Data,Return_type,Statement1_),
                Condition = expr(Data,bool,Expr_),
                Statement2 = statement_with_semicolon(Data,Return_type,Statement2_)
        },
        (Indent;""),
        ({memberchk(Lang,['java','d','pawn','groovy','javascript','dart','typescript','php','hack','c#','perl','c++','awk','pike'])}->
                "for",ws,"(",ws,Statement1,ws,";",ws,Condition,ws,";",ws,Statement2,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['haxe'])}->
                Statement1,ws,";",ws,"",ws,"while",ws,"(",ws,Condition,ws,")",ws,"{",ws,Body,ws,Statement2,ws,";",(Indent;ws),"}";
        {memberchk(Lang,['lua','ruby'])}->
                Statement1,ws_,"while",ws_,Condition,ws_,"do",ws_,Body,ws_,Statement2,(Indent;ws_),"end";
        {not_defined_for(Data,'for')}).

statement(Data,Return_type,foreach(Array1,Var1,Body1,Type1)) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                Array = expr(Data,[array,Type1],Array1),
                Var_name = var_name(Data,Type1,Var1),
                TypeInArray = type(Lang,Type1),
                Body = statements(Data1,Return_type,Body1)
        },
        (Indent;""),
        ({memberchk(Lang,['seed7'])}->
                "for",ws_,Var_name,ws_,"range",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end",ws_,"for;";
        {memberchk(Lang,['javascript','typescript'])}->
                Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var_name,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";";
        {memberchk(Lang,['octave'])}->
                "for",ws_,Var_name,ws,"=",ws,Array,ws_,Body,ws_,"endfor";
        {memberchk(Lang,['prolog'])}->
			"forall",ws,"(",ws,"member",ws,"(",Var_name,ws,",",ws,Array,")",ws,",",ws,Body,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"forall",ws_,"(",ws,"(",ws,Var_name,ws_,"a",ws,")",ws,")",ws_,"(",ws,"=>",ws,"select",ws_,Array,ws,")",ws,")";
        {memberchk(Lang,['gap'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,ws_,"od;";
        {memberchk(Lang,['minizinc'])}->
                "forall",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")";
        {memberchk(Lang,['php','hack'])}->
                "foreach",ws,"(",ws,Array,ws_,"as",ws_,Var_name,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['java'])}->
                "for",ws,"(",ws,TypeInArray,ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['c#','vala'])}->
                "foreach",ws,"(",ws,TypeInArray,ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['lua'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['python','cython'])}->
                "for",python_ws_,Var_name,python_ws_,"in",python_ws_,Array,python_ws,":",python_ws,Body;
        {memberchk(Lang,['julia'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['chapel','swift'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['pawn'])}->
                "foreach",ws,"(",ws,"new",ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['picat'])}->
                "foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")",ws,"end";
        {memberchk(Lang,['awk','ceylon'])}->
                "for",ws_,"(",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['go'])}->
                "for",ws_,Var_name,ws,":=",ws,"range",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['haxe','groovy'])}->
                "for",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['nemerle','powershell'])}->
                "foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['scala'])}->
                "for",ws,"(",ws,Var_name,ws,"->",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['rebol'])}->
                "foreach",ws_,Var_name,ws_,Array,ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['c++'])}->
                "for",ws,"(",ws,TypeInArray,ws_,"&",ws_,Var_name,ws,":",ws,Array,ws,"){",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['perl'])}->
                "for",ws_,Array,ws,"->",ws,Var_name,ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['d'])}->
                "foreach",ws,"(",ws,Var_name,ws,",",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['gambas'])}->
                "FOR",ws_,"EACH",ws_,Var_name,ws_,"IN",ws_,Array,ws_,Body,ws_,"NEXT";
        {memberchk(Lang,['visual basic .net'])}->
                "For",ws_,"Each",ws_,Var_name,ws_,"As",ws_,TypeInArray,ws_,"In",ws_,Array,ws_,Body,ws_,"Next";
        {memberchk(Lang,['vbscript'])}->
                "For",ws_,"Each",ws_,Var_name,ws_,"In",ws_,Array,ws_,Body,ws_,"Next";
        {memberchk(Lang,['dart'])}->
                "for",ws,"(",ws,"var",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}";
        {not_defined_for(Data,'foreach')}).

statement(Data,Return_type,iff(Expr1,Body1)) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                Body = statements(Data1,Return_type,Body1),
                Condition = expr(Data,bool,Expr1)
        },
        (Indent,""),
        ({memberchk(Lang,['z3'])}->
			"(",ws,"iff",ws_,Condition,ws_,Body,ws_,")";
        {not_defined_for(Data,'iff')}).

statement(Data,bool,predicate(Name1,Params1,Body1)) -->
	{
	Data = [Lang,Is_input,Namespace,Var_types,Indent],
	Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
	Name = function_name(Data,bool,Name1,Params1),
	Body = statements(Data1,bool,Body1),
	(Params1 = [], Params = ""; Params = parameters(Data1,Params1))
	},
	(Indent,""),
	({memberchk(Lang,['prolog'])}->
		Name,ws,"(",ws,Params,ws,")",ws,":-",ws,Body;
	{memberchk(Lang,['minizinc'])}->
        "predicate",ws_,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body;
    %this is for pydatalog
    {memberchk(Lang,['python'])}->
        Name,python_ws,"[",python_ws,Params,python_ws,"]",python_ws,"<=",python_ws,Body;
    {memberchk(Lang,['cosmos'])}->
        "rel",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,")",python_ws,Body,python_ws;
	{not_defined_for(Data,'predicate')}).

statement(Data,Return_type,while(Expr1,Body1)) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                B = statements(Data1,Return_type,Body1),
                A = expr(Data,bool,Expr1)
        },
        (Indent;""),({memberchk(Lang,['gap'])}->
                "while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"od",ws,";";
        {memberchk(Lang,['englishscript'])}->
                "while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"od",ws,";";
        {memberchk(Lang,['fortran'])}->
                "WHILE",ws_,"(",ws,A,ws,")",ws_,"DO",ws_,B,(Indent;ws_),"ENDDO";
        {memberchk(Lang,['pascal'])}->
                "while",ws_,A,ws_,"do",ws_,"begin",ws_,B,(Indent;ws_),"end;";
        {memberchk(Lang,['delphi'])}->
                "While",ws_,A,ws_,"do",ws_,"begin",ws_,B,(Indent;ws_),"end;";
        {memberchk(Lang,['rust','frink','dafny'])}->
                "while",ws_,A,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['c','perl 6','katahdin','chapel','ooc','processing','pike','kotlin','pawn','powershell','hack','gosu','autohotkey','ceylon','d','typescript','actionscript','nemerle','dart','swift','groovy','scala','java','javascript','php','c#','perl','c++','haxe','r','awk','vala'])}->
                "while",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['lua','ruby','julia'])}->
                "while",ws_,A,ws_,B,(Indent;ws_),"end";
        {memberchk(Lang,['picat'])}->
                "while",ws_,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"end";
        {memberchk(Lang,['rebol'])}->
                "while",ws,"[",ws,A,ws,"]",ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"loop",ws_,"while",ws_,A,ws_,"do",ws_,B,ws,")";
        {memberchk(Lang,['hy','newlisp','clips'])}->
                "(",ws,"while",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['python','cython'])}->
                "while",python_ws_,A,python_ws,":",python_ws,B;
        {memberchk(Lang,['visual basic','visual basic .net','vbscript'])}->
                "While",ws_,A,ws_,B,(Indent;ws_),"End",ws,"While";
        {memberchk(Lang,['octave'])}->
                "while",ws,"(",ws,A,ws,")",(Indent;ws_),"endwhile";
        {memberchk(Lang,['wolfram'])}->
                "While",ws,"[",ws,A,ws,",",ws,B,(Indent;ws),"]";
        {memberchk(Lang,['go'])}->
                "for",ws_,A,ws,"{",ws,B,(Indent;ws),"}";
        {memberchk(Lang,['vbscript'])}->
                "Do",ws_,"While",ws_,A,ws_,B,(Indent;ws_),"Loop";
        {memberchk(Lang,['seed7'])}->
                "while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end",ws_,"while",ws,";";
        {not_defined_for(Data,'while')}).

statement(Data,Return_type,if(Expr_,Statements_,Elif_or_else_)) -->
        {
                indent_data(Lang,Indent,Data,Data1),
                A = expr(Data,bool,Expr_),
                B = statements(Data1,Return_type,Statements_),
                C = elif_or_else(Data,Return_type,Elif_or_else_)
        },
        (Indent;""),
		({memberchk(Lang,['erlang'])}->
				"if",ws_,A,ws,"->",ws,B,ws_,C,(Indent;ws_),"end";
		{memberchk(Lang,['fortran'])}->
				"IF",ws_,A,ws_,"THEN",ws_,B,ws_,C,ws_,"END",ws_,"IF";
		{memberchk(Lang,['rebol'])}->
				"case",ws,"[",ws,A,ws,"[",ws,B,ws,"]",ws,C,ws,"]";
		{memberchk(Lang,['julia'])}->
				"if",ws_,A,ws_,B,ws_,C,(Indent;ws_),"end";
		{memberchk(Lang,['lua','ruby','picat'])}->
				"if",ws_,A,ws_,"then",ws_,B,ws_,C,(Indent;ws_),"end";
		{memberchk(Lang,['octave'])}->
				"if",ws_,A,ws_,B,ws_,C,ws_,"endif";
		{memberchk(Lang,['haskell','pascal','delphi','maxima','ocaml'])}->
				"if",ws_,A,ws_,"then",ws_,B,ws_,C;
		{memberchk(Lang,['livecode'])}->
				"if",ws_,A,ws_,"then",ws_,B,ws_,C,(Indent;ws_),"end",ws_,"if";
		{memberchk(Lang,['java','e','ooc','englishscript','mathematical notation','polish notation','reverse polish notation','perl 6','chapel','katahdin','pawn','powershell','d','ceylon','typescript','actionscript','hack','autohotkey','gosu','nemerle','swift','nemerle','pike','groovy','scala','dart','javascript','c#','c','c++','perl','haxe','php','r','awk','vala','bc','squirrel'])}->
				"if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}",ws,C;
		{memberchk(Lang,['rust','go'])}->
				"if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",ws,C;
		{memberchk(Lang,['visual basic','visual basic .net'])}->
				"If",ws_,A,ws_,B,ws_,C;
		{memberchk(Lang,['clips'])}->
				"(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws,")";
		{memberchk(Lang,['z3'])}->
				"(",ws,"ite",ws_,A,ws_,B,ws_,C,ws,")";
		{memberchk(Lang,['minizinc'])}->
				"if",ws_,A,ws_,"then",ws_,B,ws_,C,(Indent;ws_),"endif";
		{memberchk(Lang,['python','cython'])}->
				"if",python_ws_,A,python_ws,":",python_ws,B,python_ws,C;
		{memberchk(Lang,['prolog'])}->
				"(",ws,A,ws,"->",ws,B,ws,";",ws,C,ws,")";
		{memberchk(Lang,['visual basic'])}->
				"If",ws_,A,ws_,"Then",ws_,B,ws_,C,(Indent;ws_),"End",ws_,"If";
		{memberchk(Lang,['common lisp'])}->
				"(",ws,"cond",ws,"(",ws,A,ws_,B,ws,")",ws_,C,ws,")";
		{memberchk(Lang,['wolfram'])}->
				"If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,(Indent;ws),"]";
		{memberchk(Lang,['polish notation'])}->
				"if",ws_,A,ws_,B;
		{memberchk(Lang,['reverse polish notation'])}->
				A,ws_,B,ws_,"if";
		{memberchk(Lang,['monkey x'])}->
				"if",ws_,A,ws_,B,ws_,C,ws_,"EndIf";
		{not_defined_for(Data,'if')}).
		
	statement(Data,Return_type, switch(Expr_,Expr1_,Statements_,Case_or_default_)) -->
		{
				indent_data(Lang,Indent,Data,Data1_),
				(memberchk(Lang,[lua,python]),Data1 = Data;Data1 = Data1_),
				A = parentheses_expr(Data,int,Expr_),
				B = first_case(Data1,Return_type,Expr_,int,[Expr1_,Statements_,Case_or_default_])
		},
		(Indent;""),({memberchk(Lang,['lua'])}->
			B,(Indent;ws_),"end";
		{memberchk(Lang,['python'])}->
			B;
		{memberchk(Lang,['rust'])}->
				"match",ws_,A,ws,"{",ws,B,(Indent;ws),"}";
		{memberchk(Lang,['elixir'])}->
				"case",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end";
		{memberchk(Lang,['scala'])}->
				A,ws_,"match",ws,"{",ws,B,(Indent;ws),"}";
		{memberchk(Lang,['octave'])}->
				"switch",ws,"(",ws,A,ws,")",ws,B,ws_,"endswitch";
		{memberchk(Lang,['java','d','powershell','nemerle','d','typescript','hack','swift','groovy','dart','awk','c#','javascript','c++','php','c','go','haxe','vala'])}->
				"switch",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}";
		{memberchk(Lang,['ruby'])}->
				"case",ws_,A,ws_,B,(Indent;ws_),"end";
		{memberchk(Lang,['haskell','erlang'])}->
				"case",ws_,A,ws_,"of",ws_,B,(Indent;ws_),"end";
		{memberchk(Lang,['delphi','pascal'])}->
				"Case",ws_,A,ws_,"of",ws_,B,(Indent;ws_),"end;";
		{memberchk(Lang,['clips'])}->
				"(",ws,"switch",ws_,A,ws_,B,ws,")";
		{memberchk(Lang,['visual basic .net','visual basic'])}->
				"Select",ws_,"Case",ws_,A,ws_,B,(Indent;ws_),"End",ws_,"Select";
		{memberchk(Lang,['rebol'])}->
				"switch/default",ws,"[",ws,A,ws_,B,(Indent;ws_),"]";
		{memberchk(Lang,['fortran'])}->
				"SELECT",ws_,"CASE",ws,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"END",ws_,"SELECT";
		{memberchk(Lang,['clojure'])}->
				"(",ws,"case",ws_,A,ws_,B,ws,")";
		{memberchk(Lang,['chapel'])}->
				"select",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}";
		{not_defined_for(Data,'switch')}).


class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Global_vars,Indent],
                Data1 = [Lang,Is_input,[Class_name|Namespace],Global_vars,indent(Indent)],
                Name = function_name(Data,Class_name,Class_name,Params1),
                Body = statements(Data1,_,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
                Indent_ = (Indent;"")
        },
        %put this at the beginning of each statement without a semicolon
        Indent_,({memberchk(Lang,['rebol'])}->
                "new:",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,"make",ws_,"self",ws,"[",ws,Body,ws,"]",ws,"]";
        {memberchk(Lang,['hy'])}->
			"(",ws,"defn",ws_,"--init--",ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Sub",ws_,"New",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Sub";
        {memberchk(Lang,['python'])}->
                "def",python_ws_,"__init__",python_ws,"(",python_ws,"",python_ws,"self",python_ws,",",python_ws,Params,python_ws,")",python_ws,":",Body;
        {memberchk(Lang,['java','c#','vala'])}->
                "public",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['swift'])}->
                "init",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['javascript'])}->
                "constructor",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"initialize",ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['php'])}->
                "function",ws_,"construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,"new",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,"new",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['c++','dart'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['d'])}->
                "this",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['chapel'])}->
                "proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {not_defined_for(Data,'constructor')}).

class_statement(Data,_,static_method(Name1,Type1,Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = function_name(Data,Type1,Name1,Params1),
                Body = statements(Data1,Type1,Body1),
                Type = type(Lang,Type1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
                Indent_ = (Indent;"")
        },
        %put this at the beginning of each statement without a semicolon
        Indent_,({memberchk(Lang,['swift','pseudocode'])}->
                "class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws_,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['haxe','pseudocode'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['java','c#','pseudocode'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['c++','dart','pseudocode'])}->
                "static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['php','pseudocode'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"self",ws,".",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['c'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['javascript','pseudocode'])}->
                "static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['picat'])}->
                ws;
        {memberchk(Lang,['python'])}->
                "@staticmethod",python_ws,"\n",python_ws_,"def",python_ws_,Name,python_ws,"(",python_ws,"",python_ws,Params,python_ws,")",python_ws,":",Body;
        {not_defined_for(Data,'static_method')}).

class_statement(Data,_,instance_method(Name1,Type1,Params1,Body1)) -->
	{
		Data = [Lang,Is_input,Namespace,Var_types,Indent],
		Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
		Name = function_name(Data,Type1,Name1,Params1),
		Body = statements(Data1,Type1,Body1),
		Type = type(Lang,Type1),
		(Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
		Indent_ = (Indent;"")
	},
	%put this at the beginning of each statement without a semicolon
    Indent_,
		({memberchk(Lang,['hy'])}->
			"(",ws,"defn",ws_,Name,ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")";
		{memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,[logtalk])}->
                Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body;
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl 6'])}->
                "method",ws_,Name,ws_,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['chapel'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['c++','d','dart'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['python'])}->
                "def",python_ws_,Name,python_ws,"(",python_ws,"self,",python_ws,Params,python_ws,")",python_ws,":",Body;
        {not_defined_for(Data,'instance_method')}).

class_statement(Data,_,initialize_static_var_with_value(Type1,Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Value = expr(Data,Type1,Expr1),
                Name = var_name(Data,Type1,Name1),
                Type = type(Lang,Type1)
        },
    ({memberchk(Lang,['polish notation'])}->
        "=",ws_,Name,ws_,Value;
    {memberchk(Lang,['reverse polish notation'])}->
        Name,ws_,Value,ws_,"=";
    {memberchk(Lang,['go'])}->
        "var",ws_,Name,ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['rust'])}->
        "let",ws_,"mut",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['dafny'])}->
        "var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
    {memberchk(Lang,['z3'])}->
        "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
    {memberchk(Lang,['f#'])}->
        "let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['common lisp'])}->
        "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
    {memberchk(Lang,['minizinc'])}->
        Type,ws,":",ws,Name,ws,"=",ws,Value,ws,";";
    {memberchk(Lang,['ruby','haskell','erlang','prolog','julia','picat','octave','wolfram'])}->
        Name,ws,"=",ws,Value;
    {memberchk(Lang,['python'])}->
        Name,python_ws,"=",python_ws,Value;
    {memberchk(Lang,['javascript','hack','swift'])}->
        "var",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['lua'])}->
        "local",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['janus'])}->
        "local",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['perl'])}->
        "my",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['perl 6'])}->
        "my",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['c','java','c#','c++','d','dart','englishscript','ceylon','vala'])}->
        Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['rebol'])}->
        Name,ws,":",ws,Value;
    {memberchk(Lang,['visual basic','visual basic .net','openoffice basic'])}->
        "Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['r'])}->
        Name,ws,"<-",ws,Value;
    {memberchk(Lang,['fortran'])}->
        Type,ws,"::",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['chapel','haxe','scala','typescript'])}->
        "var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['monkey x'])}->
        "Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['vbscript'])}->
        "Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['seed7'])}->
        "var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
    {not_defined_for(Data,'initialize_static_var_with_value')}).
