statement(Data,grammar_statement(Name_,Body_)) -->
	{
	Data = [Lang|_],
	Name=var_name(Data,grammar,Name_),
	Body=expr(Data,grammar,Body_)
	},
	({memberchk(Lang,['pegjs'])}->
		Name,ws,"=",ws,Body;
	{not_defined_for([Lang|_],'grammar_statement')}).

ws(Lang,Ws,Ws_) :-
	memberchk(Lang,['coffeescript','python']) ->
		Ws = python_ws,Ws_ =python_ws_;
	Ws = ws,Ws_ = ws_.

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
        {memberchk(Lang,['haskell','engscript','python','scala','go','groovy','picat','elm','swift','monkey x'])}->
                "import",ws_,A;
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
                "class",ws_,Name,ws,"(",ws,"AutoNumber",ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,"b",ws,"\n",ws,"#unindent";
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
                "def",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,")",python_ws,"->",ws,Type,python_ws,":",Body;
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
        {memberchk(Lang,['visual basic .net',picolisp,logtalk,cosmos,minizinc,ruby,lua,swift,rebol,fortran,python,go,picat,julia,prolog,haskell,'mathematical notation',erlang,z3])} ->
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
                "for",python_ws_,Var_name,python_ws_,"in",python_ws_,Array,ws,":",python_ws,Body;
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
        Name,ws,"[",ws,Params,ws,"]",ws,"<=",ws,Body;
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
