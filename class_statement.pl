class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        {
                namespace(Data,Data1,Class_name,Indent),
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
                namespace(Data,Data1,Name1,Indent),
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
		namespace(Data,Data1,Name1,Indent),
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
		['visual basic','visual basic .net','openoffice basic']:
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
