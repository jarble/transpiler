statement(Data,grammar_statement(Name_,Body_)) -->
	{
	Name=var_name(Data,grammar,Name_),
	Body=expr(Data,grammar,Body_)
	},
	langs_to_output(Data,grammar_statement,[
	['pegjs']:
		(Name,ws,"=",ws,Body)
    ]).

statement(Data,_,comment(A_)) -->
	{
	A = comment_inner(A_)
	},
	langs_to_output(Data,comment,[
	['java','javascript','c','c#','c++','php','perl','swift']:
		("//",A),
	['python','perl','octave','ruby']:
		("#",A),
	['lua','haskell']:
		("--",A),
	['ocaml']:
		("(*",A,"*)"),
	['prolog','erlang','txl']:
		("%",A),
	['visual basic','visual basic .net']:
		("'",A)
    ]).

statement(Data,_,import(Module_)) -->
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
                namespace(Data,Data1,Name1,Indent),
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
                namespace(Data,Data1,Name1,Indent),
                Name = function_name(Data,Type1,Name1,Params1),
                Type = type(Data,Type1),
                Body = statements(Data1,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
		optional_indent(Data,Indent),langs_to_output(Data,function,[
		['c++','vala','c','dart','ceylon','pike','d','englishscript']:
                (Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
		['python']:
				("def",python_ws_,Name,"(",Params,")",":",python_ws,Body),
		['cobra']:
				("def",python_ws_,Name,"(",Params,")",python_ws,Body),
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
                ({Params = ""} -> (Name,ws,"(",ws,"Return",ws,")",ws_,":-",ws_,Body); (Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body)),
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
                ("(",ws,"defun",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")"),
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
                namespace(Data,Data1,Name1,Indent),
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
                namespace(Data,Data1,C1_,Indent),
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
		{Data = [_,_,_,_,Indent,_],A=statement_with_semicolon(Data,Return_type,A_),offside_rule_langs(Offside_rule_langs)},
        optional_indent(Data,Indent),
        langs_to_output(Data,semicolon,[
        ['c','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala']:
                (A,ws,";"),
        ['pseudocode']:
                (A,("";ws,";")),
        ['visual basic .net','common lisp','gnu smalltalk','ruby','lua','hy',picolisp,logtalk,minizinc,swift,rebol,fortran,go,picat,julia,prolog,haskell,'mathematical notation',erlang,z3]:
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
				("forall",ws,"(",ws,"member",ws,"(",Var_name,ws,",",ws,Array,")",ws,",",ws,"(",ws,Body,ws,")",ws,")"),
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
                parentheses_expr = expr(Data,bool,Expr1)
                Body = expr(Data,bool,Expr1)
        },
        Indent,
        langs_to_output(Data,iff,[
        ['z3']:
			("(",ws,("iff";"<=>"),ws_,Condition,ws_,Body,ws_,")"),
		['minizinc']:
			(Condition,ws,"<->",ws,Body)
        ]).

statement(Data,bool,predicate(Name1,Params1,Body1)) -->
		{
		namespace(Data,Data1,Name1,Indent),
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
                C = elif_or_else(Data,Return_type,Elif_or_else_),
                D = else(Data,Return_type,Else_)
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
		['clips']:
				("(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,ws,")"),
		['z3']:
				("(",ws,"ite",ws_,A,ws_,B,ws_,C,ws_,D,ws,")"),
		['minizinc']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"endif"),
		['python','cython']:
				("if",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B,python_ws,C,D),
		['prolog']:
				("(",ws,A,ws,"->",ws,B,ws,";",ws,C,ws,";",ws,D,ws,")"),
		['visual basic','visual basic .net']:
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
