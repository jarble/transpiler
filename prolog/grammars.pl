not_defined_for(Data,Function) :-
        Data = [Lang,Is_input|_],
        (Is_input ->
            true;
        writeln(Function),writeln('not defined for'),writeln(Lang)).

optional_the(A) -->
	A;("the";"The"),ws_,A.

langs_to_output(Data,Name,[]) -->
	{not_defined_for(Data,Name),true}.

langs_to_output(Data,Name,[Langs:Output|Rest]) -->
	{
		Data = [Lang|_]
	},
	({memberchk(Lang,Langs)}->
		Output;
	langs_to_output(Data,Name,Rest)).

return_(Data,[A]) -->
	{grammars(Grammars)},
    langs_to_output(Data,return,[
	['pseudocode','systemverilog','vhdl','lua','ruby','java','seed7','xl','e','livecode','englishscript','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','rebol','tcl','awk','bc','chapel','perl 6']:
			("return",ws_,A),
	['coffeescript','python','cython','cosmos']:
			("return",python_ws_,A),
	['english']:
			("return",python_ws_,A),
	Grammars:
			A,
	['minizinc','sympy','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','ml','racket','nemerle']:
			A,
	['pseudocode','visual basic','visual basic .net','autoit','monkey x']:
			("Return",ws_,A),
	['octave','fortran','picat']:
			("retval",ws,"=",ws,A),
	['cosmos','prolog','constraint handling rules']:
			("Return",python_ws,"=",python_ws,A),
	['haskell']:
			("return",python_ws,"=",python_ws,A),
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

initialize_constant_(Data,[Name,Type,Value]) -->
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
        ['erlang','julia','picat','prolog']:
                (Name,python_ws,"=",python_ws,Value),
        ['haskell']:
                (Name,python_ws,"<-",python_ws,Value),
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

set_array_size_(Data,[Name,Size,Type]) -->
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
                (Type,ws,"[]",ws_,Name,ws,"=",ws,"new",ws_,Type,ws,"[",ws,Size,ws,"]"),
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
        
set_var_(Data,[Name,Value]) -->
	langs_to_output(Data,set_var,[
	['sympy']:
			("Eq",ws,"(",ws,Name,ws,",",ws,Value,ws,")"),
    ['javascript','systemverilog','elixir','visual basic .net','lua','ruby','scriptol','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','gambas','octave','visual basic','bc']:
			(Name,ws,"=",ws,Value),
	['python','cython','coffeescript','haskell']:
			(Name,python_ws,"=",python_ws,Value),
	['english_temp']:
			(Name,python_ws,"=",python_ws,Value),
	['csh']:
			("@",ws,Name,ws,"=",ws,Value),
	%depends on the type of Value
	['prolog','constraint handling rules']:
			(Name,ws,"=",ws,Value),
	['hy']:
			("(",ws,"setv",ws_,Name,ws_,Value,ws,")"),
	['minizinc']:
			("constraint",ws_,Name,ws,"=",ws,Value),
	['rebol']:
			(Name,ws,":",ws,Value),
	['z3']:
			("(",ws,"assert",ws,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")"),
	['gap','seed7','delphi','vhdl']:
			(Name,ws,":=",ws,Value),
	['r']:
			(Name,ws,"<-",ws,Value),
	['livecode']:
			("put",ws_,"expression",ws_,"into",ws_,Name),
	['vbscript']:
			("Set",ws_,"a",ws,"=",ws,"b")
	]).

initialize_instance_var_(Data,[Type,Name]) -->
	langs_to_output(Data,initialize_instance_var,[
		['java','c#']:
			("private",ws_,Type,ws_,Name,ws,";"),
		['php']:
			("private",ws_,Name,ws,";"),
		['javascript','perl']:
			"",
		['haxe','swift']:
			initialize_empty_var_(Data,[Name,Type])
	]).
	
initialize_instance_var_with_value_(Data,[Name,Expr,Type]) -->
	langs_to_output(Data,initialize_instance_var_with_value,[
		['java','c#']:
			("private",ws_,Type,ws_,Name,ws,"=",ws,Expr,ws,";"),
		['php']:
			("private",ws_,Name,ws,"=",ws,Expr,ws,";"),
		['javascript','perl']:
			"",
		['haxe','swift']:
			initialize_var_(Data,[Name,Expr,Type])
	]).

initialize_reference_(Data,[Name,Expr,Type]) -->	
	langs_to_output(Data,initialize_reference,[
	['c++']:
		(Type,ws_,"&",ws_,Name,ws_,"=",ws_,Expr)
]).

initialize_var_(Data,[Name,Expr,Type]) -->
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
    ['ruby','erlang','php','prolog','constraint handling rules','logtalk','picat','octave','wolfram']:
        (Name,ws,"=",ws,Expr),
    ['python','cython','haskell','julia']:
        (Name,python_ws,"=",python_ws,Expr),
    ['javascript','hack','swift']:
        ("var",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','lua','gap','bash']:
        ("local",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','janus']:
        ("local",ws_,Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','perl']:
        ("my",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','perl 6']:
        ("my",ws_,Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','systemverilog','java','scriptol','c','cosmos','c++','d','dart','englishscript','ceylon']:
		(Type,ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','c#','vala']:
        ((Type;"var"),ws_,Name,ws,"=",ws,Expr),
    ['rebol']:
        (Name,ws,":",ws,Expr),
    ['r']:
        (Name,ws,"<-",ws,Expr),
    ['pseudocode','fortran']:
        (Type,ws,"::",ws,Name,ws,"=",ws,Expr),
    ['pseudocode','chapel','haxe','scala','typescript']:
        ("var",ws_,Name,(ws,":",Type,ws;ws),"=",ws,Expr),
    ['monkey x']:
        ("Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Expr),
    ['vbscript']:
        ("Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Expr),
    ['pseudocode','seed7']:
        ("var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Expr),
    ['python']:
		(Name,python_ws,"=",python_ws,Expr)
	]).

index_in_array_(Data,[Container,Contained]) -->
    langs_to_output(Data,index_in_array,[
    ['javascript']:
        (Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")"),
    ['ruby']:
        (Container,ws,".",ws,"index",ws,"(",ws,Contained,ws,")"),
    ['perl']:
        ("firstidx",ws,"{",ws,"$_",ws_,"eq",ws_,Contained,ws,"}",ws,Container),
    ['php']:
        ("array_search",ws,"(",ws,Contained,ws,",",ws,Container,ws,")"),
    ['c#']:
        ("Array",ws,".",ws,"IndexOf",ws,"(",ws,Container,ws,",",ws,Contained,ws,")"),
    ['cython']:
        (Container,python_ws,".",python_ws,"index",python_ws,"(",python_ws,Contained,python_ws,")"),
    ['english_temp']:
		(optional_the("first"),python_ws_,("occurrence";"appearance"),python_ws_,"of",python_ws_,Contained,python_ws_,"in",python_ws_,Container)
    ]).


% https://www.rosettacode.org/wiki/Remove_duplicate_elements
remove_duplicates(Data,[A]) -->
	langs_to_output(Data,remove_duplicates,[
		['php']:
			("array_unique",ws,"(",ws,A,ws,")"),
		['python']:
			("unique_everseen",python_ws,"(",python_ws,A,python_ws,")"),
		['ruby']:
			(A,ws,".",ws,"uniq"),
		['c#']:
			(A,ws,".",ws,"Distinct",ws,"(",ws,")",ws,".",ws,"ToArray",ws,"(",ws,")"),
		['clojure']:
			("(",ws,"distinct",ws_,A,ws,")"),
		['english_temp']:
			(A,python_ws_,"without",python_ws_,"duplicates")
	]).

remove_duplicates_in_place(Data,[A]) -->
	langs_to_output(Data,remove_duplicates,[
		['ruby']:
			(A,ws,".",ws,"uniq!")
	]).

expr(Data,Type,arithmetic(Exp1,Exp2,Symbol)) -->
        {
                member(Symbol,["+","-","*","/"])
        },
        arithmetic_(Data,[
			dot_expr(Data,Type,Exp1),
			expr(Data,Type,Exp2),
			Symbol
		]),{Type=int;Type=double}.

concatenate_string_(Data,[A,B]) -->
        langs_to_output(Data,concatenate_string,[
        ['prolog','constraint handling rules']:
				("(",ws,"append",ws_,"$(",ws,A,ws,",",ws,B,ws,")",ws,")"),
        ['r']:
                ("paste0",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['maxima']:
                ("sconcat",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['common lisp']:
                ("(",ws,"concatenate",ws_,"'string",ws_,A,ws_,B,ws,")"),
        ['c','ruby','python','cosmos','z3py','monkey x','englishscript','mathematical notation','go','java','chapel','frink','freebasic','nemerle','d','cython','ceylon','coffeescript','typescript','dart','gosu','groovy','scala','swift','f#','javascript','c#','haxe','c++','vala']:
                (A,python_ws,"+",python_ws,B),
		['english']:
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

array_length(Data,[A])-->
        langs_to_output(Data,array_length,[
        ['go']:
                ("len",ws,"(",ws,A,ws,")"),
		['prolog','constraint handling rules']:
				("(",ws,"length",ws_,"$",ws,A,ws,")",ws,")"),
        ['python','cython']:
                ("len",python_ws,"(",python_ws,A,python_ws,")"),
        ['java','picat','scala','d','typescript','dart','vala','javascript','haxe','cobra','ruby']:
                (A,ws,".",ws,"length"),
		['coffeescript']:
                (A,ws,".",ws,"length"),
        ['c#','visual basic','powershell','visual basic .net']:
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
                ("Length",ws,"[",ws,A,ws,"]"),
        ['english_temp']:
				(
					optional_the("length"),python_ws_,"of",python_ws_,A;
					A,"'s",ws_,"length"
				)
        ]).

strlen_(Data,[A]) -->
        langs_to_output(Data,strlen,[
		['prolog','constraint handling rules']:
				("(",ws,"length",ws_,"$",ws,A,ws,")",ws,")"),
        ['go','erlang','nim','python']:
                ("len",python_ws,"(",python_ws,A,python_ws,")"),
        ['lua']:
                ("string",ws,".",ws,"length",ws,"(",ws,A,ws,")"),
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
        ['systemverilog']:
				(Str,ws,".",ws,"len",ws,"(",ws,")"),
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
                ("(",ws,"Length",ws_,A,ws,")"),
        ['english_temp']:
				(
					optional_the("length"),python_ws_,"of",python_ws_,A;
					A,"'s",ws_,"length"
				)
        ]).

access_array_(Data,[Array,Index]) -->
        langs_to_output(Data,access_array,[
        ['prolog','constraint handling rules']:
				("(",ws,"nth0",ws_,"$",ws,"(",ws,Array,ws,",",ws,Index,ws,")",ws,")"),
        ['ruby','c#','julia','d','swift','julia','janus','minizinc','picat','nim','autoit','python_temp','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','go','c++','php','haxe','c']:
                (Array,python_ws,"[",python_ws,Index,python_ws,"]"),
		['lua']:
				(Array,ws,"[",ws,Index,ws,"+",ws,"1",ws,"]"),
        ['scala','octave','fortran','visual basic','visual basic .net']:
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

%not reversed in place
%list backwards
reverse_list_(Data,[List]) -->
        langs_to_output(Data,reverse_list,[
			['php']:
				("array_reverse",ws,"(",ws,List,ws,")"),
			['perl']:
				("reverse",ws,"(",ws,List,ws,")"),
			['ruby']:
				(List,ws,".",ws,"reverse"),
			['python','cython']:
				(List,python_ws,"[::-1]";"reversed",ws,"(",ws,List,ws,")"),
			['english_temp']:
				(List,python_ws_,"reversed"),
			['haskell']:
				("(",ws,"reverse",ws_,List,ws,")"),
			['ocaml']:
				("(",ws,"List.rev",ws_,List,ws,")"),
			['javascript']:
				(List,ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,"arr",ws,")",ws,"{",ws,"return",ws_,"arr",ws,".",ws,"slice()",ws,";",ws,"}",ws,")")
		]).

reverse_list_in_place_(Data,[List]) -->
        langs_to_output(Data,reverse_list_in_place,[
			['javascript','python']:
				(List,python_ws,".",python_ws,"reverse",python_ws,"(",python_ws,")"),
			['ruby']:
				(List,python_ws,".",python_ws,"reverse!"),
			['english_temp']:
				("reverse",ws_,List),
			['php']:
				set_var_(Data,[List,reverse_list_(Data,[List])]),
			['java']:
				("Collections",ws,".",ws,"reverse(",ws,List,ws,")")
		]).

charAt_(Data,[AString,Index]) -->
        langs_to_output(Data,charAt,[
        ['english_temp']:
				(optional_the(Index),("st";"nd";"rd";"th"),python_ws_,"character",python_ws_,("in";"of"),python_ws_,AString),
        ['java','haxe','scala','javascript','typescript']:
                (AString,ws,".",ws,"charAt",ws,"(",ws,Index,ws,")"),
        ['z3']:
                ("(",ws,"CharAt",ws_,"expression",ws_,Index,ws,")"),
        ['c','php','c#','minizinc','c++','picat','haskell','dart']:
                (AString,ws,"[",ws,Index,ws,"]"),
        ['python','english_temp']:
                (AString,python_ws,"[",python_ws,Index,python_ws,"]"),
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

join_(Data,[Array,Separator]) -->
        langs_to_output(Data,join,[
        ['prolog','constraint handling rules']:
				("(",ws,"join",ws_,"$(",ws,Array,ws,",",ws,Separator,ws,")",")"),
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
        ['javascript','haxe','groovy','java','typescript','rust','dart','ruby']:
                (Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")"),
		['coffeescript']:
                (Array,python_ws,".",python_ws,"join",python_ws,"(",python_ws,Separator,python_ws,")"),
        ['scala']:
                (Array,ws,".",ws,"mkString",ws,"(",ws,Separator,ws,")")
        ]).

%Concatenate arrays, not in-place
concatenate_arrays_(Data,[A1,A2]) -->
        langs_to_output(Data,concatenate_arrays,[
        ['prolog','constraint handling rules']:
				("(",ws,"append",ws_,"$(",ws,A1,ws,",",ws,A2,ws,")"),
        ['javascript','typescript','haxe']:
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")"),
        ['haskell']:
                (A1,ws,"++",ws,A2),
        ['go']:
                ("append",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        ['cython','python','ruby','swift']:
                (A1,python_ws,"+",python_ws,A2),
        ['d']:
                (A1,python_ws,"~",python_ws,A2),
        ['perl']:
                ("push",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        ['r']:
                ("c",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        ['php']:
                ("array_merge",ws,"(",ws,A1,ws,",",ws,A2,ws,")"),
        [hy]:
                ("(",ws,"+",ws_,A1,ws_,A2,ws,")"),
        ['c#']:
                (A1,ws,".",ws,"concat",ws,"(",ws,A2,ws,")",ws,".",ws,"ToArray",ws,"(",ws,")")
        ]).

split_(Data,[AString,Separator]) -->
    langs_to_output(Data,split,[
    ['prolog','constraint handling rules']:
			("(",ws,"split",ws_,"$(",ws,AString,ws,",",ws,Separator,ws,")",ws,")"),
    ['swift']:
            (AString,ws,".",ws,"componentsSeparatedByString",ws,"(",ws,Separator,ws,")"),
    ['octave']:
            ("strsplit",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
    ['go']:
            ("strings",ws,".",ws,"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")"),
    ['javascript','ruby','coffeescript','java','dart','scala','groovy','haxe','rust','typescript','python','cython','vala']:
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

function_call_(Data,[Name,Args]) -->
	langs_to_output(Data,function_call,[
    ['c','english_temp','sympy','lua','cython','definite clause grammars','python','ruby','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','vala','f#','java','ceylon','erlang','c#','haxe','javascript','dart','bc','visual basic','php','perl']:
			(Name,python_ws,"(",python_ws,Args,python_ws,")"),
	['prolog','constraint handling rules']:
			("(",ws,Name,ws_,"$",ws,"(",Args,")",ws,")"),
	['haskell','ocaml','z3','clips','clojure','common lisp','clips','racket','scheme','rebol']:
			("(",ws,Name,ws_,Args,ws,")"),
	['polish notation']:
			(Name,ws_,Args),
	['reverse polish notation']:
			(Args,ws_,Name),
	['pydatalog','nearley']:
			(Name,ws,"[",ws,Args,ws,"]"),
	['hy']:
			("(",ws,Name,ws_,Args,ws,")"),
	['peg.js']:
			(Args,ws,":",ws,Name),
	['antlr','abnf','marpa','waxeye','parboiled','wirth syntax notation']:
			Name,
	['lpeg']:
			("lpeg.V\"",Name,"\"")
    ]).

minus_minus_(Data,[Name]) -->
        langs_to_output(Data,minus_minus,[
        ["javascript","php","kotlin","haxe","scala","java","c","c++","c#","perl","go"]:
			(Name,ws,"--"),
		['ruby']:
			(Name,ws,"=",ws,Name,ws,"-",ws,"1")
		]).

initialize_static_var_with_value_(Data,[Type,Name,Value]) -->
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
		['haskell','erlang','prolog','constraint handling rules','julia','picat','octave','wolfram']:
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

private_instance_method_(Data,[Name,Type,Params,Body,Indent]) -->
		langs_to_output(Data,private_instance_method,[
			['java','c#']:
					("private",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),
			['php']:
					("private",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}")
		]).

instance_method_(Data,[Name,Type,Params,Body,Indent]) -->
		langs_to_output(Data,instance_method,[
		['hy']:
			("(",ws,"defn",ws_,Name,ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")"),
		['python','cython']:
				("def",python_ws_,Name,"(",python_ws,"self",python_ws,",",Params,")",":",python_ws,Body),
		['swift']:
                ("func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",!,ws,Body,(Indent;ws),"}"),
        [logtalk]:
                (Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body),
        ['ruby']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}"),
        ['javascript']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),
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

static_method_(Data, [Name,Type,Params,Body,Indent]) -->        
        langs_to_output(Data,static_method,[
        ['swift','pseudocode']:
                ("class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}"),
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
        ['javascript','typescript','pseudocode']:
                ("static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['python_temp']:
				("@staticmethod",Indent,"def",python_ws,"(",python_ws,Params,python_ws,")",":",python_ws,Statements),
        ['picat']:
                (ws)
        ]).


constructor_(Data,[Name,Params,Body,Indent]) -->
        langs_to_output(Data,constructor,[
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
                ("function",ws_,"__construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['perl']:
                ("sub",ws_,"new",ws,"{",ws,"my($class,",Params,") = @_;my $s = {};bless $s, $class;",Body,"return $s;",(Indent;ws),"}"),
        ['haxe']:
                ("public",ws_,"function",ws_,"new",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c++','dart']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['d']:
                ("this",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['chapel']:
                ("proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['julia']:
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['ruby']:
                ("def",ws_,"initialize",ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end")
        ]).

plus_equals_(Data,[A,B]) -->
        langs_to_output(Data,plus_equals,[
        ['janus','python','coffeescript','visual basic','visual basic .net','nim','cython','vala','perl 6','dart','typescript','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift']:
                (A,python_ws,"+=",python_ws,B),
        ['english_temp']:
                (
					A,python_ws,"+=",python_ws,B;
					"add",python_ws,B,python_ws,"to",python_ws,A
				),
        ['haskell','ruby','lua','erlang','fortran','ocaml','minizinc','octave','delphi']:
                (A,ws,"=",ws,A,ws,"+",ws,B),
        ['haskell']:
                (A,python_ws,"<-",python_ws,A,python_ws,"+",python_ws,B),
        ['picat']:
                (A,ws,":=",ws,A,ws,"+",ws,B),
        ['rebol']:
                (A,ws,":",ws,A,ws,"+",ws,B),
        ['livecode']:
                ("add",ws_,B,ws_,"to",ws_,A),
        ['seed7']:
                (A,ws,"+:=",ws,B)
        ]).

array_plus_equals_(Data,[A,B]) -->
        langs_to_output(Data,array_plus_equals,[
        ['python']:
			(A,python_ws,"+=",python_ws,B),
		['english_temp']:
			plus_equals_(Data,[A,B]),
		['perl']:
			("push",ws_,A,ws,",",ws_,B),
		['lua']:
			({unique_var(V)},"for",ws_,"_",ws,",",ws,V,ws_,"in",ws_,"pairs",ws,"(",ws,B,ws,")",ws_,"do",ws_,"table",ws,".",ws,"insert",ws,"(",ws,A,ws,",",ws,V,ws,")",ws_,"end"),
		['javascript']:
			(A,ws,".",ws,"push",ws,".",ws,"apply",ws,"(",ws,A,ws,",",ws,B,ws,")")
        ]).

dict_plus_equals_(Data,[A,B]) -->
        langs_to_output(Data,dict_plus_equals,[
        ['python']:
			(A,python_ws,".",python_ws,"update",python_ws,"(",python_ws,B,")"),
		['lua']:
			("for",ws_,"k",ws,",",ws,"v",ws_,"in",ws_,"pairs",ws,"(",ws,B,ws,")",ws_,"do",ws_,A,ws,"[",ws,"k",ws,"]",ws,"=",ws,"v",ws_,"end"),
		['ruby']:
			(A,ws,"=",ws,A,ws,".",ws,"merge",ws,"(",ws,B,ws,")"),
		['php']:
			(A,ws,"=",ws,"array_merge",ws,"(",ws,A,ws,",",ws,B,ws,")"),
		['english_temp']:
			(A,python_ws,"+=",python_ws,B),
		['c#']:
			({unique_var(X)},B,ws,".",ws,"ToList",ws,"(",ws,")",ws,".",ws,"ForEach",ws,"(",ws,X,ws,"=>",ws,A,ws,".",ws,"Add",ws,"(",ws,X,ws,".",ws,"Key",ws,",",ws,X,ws,".",ws,"Value",ws,")",ws,")")
        ]).

string_plus_equals_(Data,[A,B]) -->
	langs_to_output(Data,string_plus_equals,[
        ['python','java','javascript','c#']:
			(A,python_ws,"+=",python_ws,B),
		['english_temp']:
			plus_equals_(Data,[A,B]),
		['haskell']:
			(A,python_ws,"<-",python_ws,A,python_ws,"++",python_ws,B),
		['perl','php']:
			(A,ws,".=",ws,B),
		['ruby']:
			(A,ws,"<<",ws,B),
		['c++']:
			(A,ws,".",ws,"append",ws,"(",ws,B,ws,")"),
		['lua']:
			set_var_(Data,[A,concatenate_string_(Data,[A,B])])
    ]).

divide_equals_(Data,[A,B]) -->
    langs_to_output(Data,divide_equals,[
	["javascript","java","c","c++","c#","perl","ruby","visual basic .net","php"]:
			(A,ws,"/=",ws,B),
	['python','coffeescript']:
			(A,python_ws,"/=",python_ws,B),
	['english_temp']:
			(
				A,python_ws,"/=",python_ws,B;
				"divide",python_ws_,A,python_ws_,"by",python_ws_,B
			)
    ]).

modulo_equals_(Data,[A,B]) -->
    langs_to_output(Data,modulo_equals,[
	['c','c++','php','javascript','ruby','c#','java']:
			(A,ws,"%=",ws,B),
	['python']:
			(A,python_ws,"%=",python_ws,B)
    ]).

exponent_equals_(Data,[A,B]) -->
    langs_to_output(Data,exponent_equals,[
	['perl','ruby']:
			(A,ws,"**=",ws,B),
	['python']:
			(A,python_ws,"**=",python_ws,B)
    ]).

minus_equals_(Data,[A,B]) -->
    langs_to_output(Data,minus_equals,[
    ['janus','coffeescript','python','visual basic','visual basic .net','vala','nim','perl 6','dart','perl','typescript','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift']:
			(A,python_ws,"-=",python_ws,B),
	['english_temp']:		
			(
				A,python_ws,"-=",python_ws,B;
				"subtract",python_ws_,B,python_ws_,"from",python_ws_,A
			),
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
    
assert_(Data,[A]) -->
        langs_to_output(Data,assert,[
		['javascript','scala','c','c++','lua','swift','php','ceylon']:
                ("assert",ws,"(",ws,A,ws,")"),
        ['c#','visual basic .net']:
                ("Debug",ws,".",ws,"Assert",ws,"(",ws,A,ws,")"),
        ['clojure']:
                ("(",ws,"assert",ws_,A,ws,")"),
        ['r']:
                ("stopifnot",ws,"(",ws,A,ws,")"),
		['cython']:
				("assert",python_ws_,A),
		['java','haskell']:
				("assert",ws_,A)
		]).


print_(Data,[A]) -->        
        langs_to_output(Data,print,[
        ['java']:
			("System",ws,".",ws,"out",ws,".",ws,"print",ws,"(",ws,A,ws,")"),
		['c#']:
			("Console",ws,".",ws,"Write",ws,"(",ws,A,ws,")"),
		['prolog','constraint handling rules']:
			("write",ws,"(",ws,A,ws,")"),
		['perl']:
			("print",ws,"(",ws,A,ws,")"),
		['lua']:
			("io",ws,".",ws,"write",ws,"(",ws,A,ws,")"),
		['php']:
			(
				"echo",ws_,A;
				"echo",ws,"(",ws,A,ws,")"
			),
		['c++']:
			("cout",ws,"<<",ws,A)
        ]).

%logarithm with e as the base
log_base_e_(Data,[A]) -->
	langs_to_output(Data,log_base_e,[
		['javascript','java','ruby']:
			("Math",ws,".",ws,"log",ws,"(",ws,A,ws,")",!),
		['c#']:
			("Math",ws,".",ws,"Log",ws,"(",ws,A,ws,")",!),
		['python','lua']:
			("math",python_ws,".",python_ws,"log",python_ws,"(",python_ws,A,python_ws,")",!),
		['perl','c','sympy','php']:
			("log",ws,"(",ws,A,ws,")"),
		['haskell']:
			("(",ws,"log",ws_,A,ws,")")
	]).

%logarithm with N as the base
log_base_n_(Data,[A,N]) -->
	langs_to_output(Data,log_base_n,[
		['c#']:
			("Math",ws,".",ws,"Log",ws,"(",ws,A,ws,",",ws,N,ws,")"),
		['ruby']:
			("Math",ws,".",ws,"log",ws,"(",ws,A,ws,",",ws,N,ws,")")
	]).

%logarithm with N as the base
log_base_10_(Data,[A]) -->
	langs_to_output(Data,log_base_n,[
		['java']:
			("Math",ws,".",ws,"log10",ws,"(",ws,A,ws,")"),
		['c#']:
			("Math",ws,".",ws,"Log10",ws,"(",ws,A,ws,")")
	]).

println_(Data,[A,Type]) -->
		langs_to_output(Data,println,[
		['cython','lua']:
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['python']:
                ("print",python_ws,"(",python_ws,A,python_ws,")";"print",python_ws_,A),
        ['ocaml']:
				(
					"print_int",ws_,A,{Type=int};
					"print_string",ws_,A,{Type=string}
				),
        ['english_temp']:
                (synonym("print"),python_ws,"(",python_ws,A,python_ws,")";synonym("print"),python_ws_,A),
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
        ['scala','julia','swift','picat']:
                ("println",ws,"(",ws,A,ws,")"),
        ['javascript','typescript']:
                ("console",ws,".",ws,"log",ws,"(",ws,A,ws,")"),
        ['coffeescript']:
                ("console",python_ws,".",python_ws,"log",python_ws,"(",python_ws,A,python_ws,")"),
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
        ['chapel','d','seed7','prolog','constraint handling rules']:
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

times_equals_(Data,[Name,Expr]) -->
        langs_to_output(Data,times_equals,[
        ['c','c++','java','c#','javascript','php','perl']:
                (Name,ws,"*=",ws,Expr),
        ['coffeescript','python']:
				(Name,python_ws,"*=",python_ws,Expr),
        ['english']:
                (
					Name,ws,"*=",ws,Expr;
					"multiply",python_ws_,Name,python_ws_,"by",python_ws_,Expr
				)
        
        ]).

append_to_string_(Data,[Name,Expr]) -->
        langs_to_output(Data,append_to_string,[
        [c,'java','c#',javascript]:
                (Name,python_ws,"+=",python_ws,Expr),
        [php,'perl']:
                (Name,ws,".=",ws,Expr)
        ]).

append_to_array_(Data,[Name,Expr]) -->
        langs_to_output(Data,append_to_array,[
        ['javascript']:
                (Name,ws,".",ws,"push",ws,"(",ws,Expr,ws,")"),
        ['python']:
                (Name,python_ws,".",python_ws,"append",python_ws,"(",python_ws,Expr,python_ws,")"),
        ['php']:
                ("array_push",ws,"(",ws,Expr,ws,")"),
        ['perl']:
                ("push",ws,"(",ws,Expr,ws,")")
        ]).

throw_(Data,[A]) -->
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
			(statement_with_semicolon(Data,_,throw(A)))
	]).


initialize_empty_var_(Data,[Name,Type]) -->
    langs_to_output(Data,initialize_empty_var,[
    ['swift','scala','typescript']:
			("var",ws_,Name,ws,":",ws,Type),
	['java','systemverilog','c#','c++','c','d','janus','fortran','dart']:
			(Type,ws_,Name),
	['prolog','constraint handling rules']:
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

set_dict_(Data,[Name,Index,Value]) -->
	langs_to_output(Data,set_dict,[
    ['javascript','lua','c++','haxe','c#','ruby']:
			(Name,ws,"[",ws,Index,ws,"]",ws,"=",ws,Value),
	['scala']:
			(
				%this adds to a Map
				(Name,ws,"+",ws,"=",ws,"(",ws,Index,ws,"->",ws,Value,ws,")");
				%this updates a map with the key already present
				(Name,ws,"(",ws,Key,ws,")",ws,"=",ws,Value)
			),
	['python','cython']:
			(Name,python_ws,"[",python_ws,Index,python_ws,"]",python_ws,"=",python_ws,Value),
	['english_temp']:
			(
				(
				optional_the(Index),python_ws_,"of",python_ws_,Name;
				Name,"'s",python_ws_,Index
				),python_ws_,"is",python_ws_,Value;
				Name,python_ws,"[",python_ws,Index,python_ws,"]",python_ws,"=",python_ws,Value
			),
	['gnu smalltalk']:
			(Name,ws_,"at:",ws_,Index,ws_,"put:",ws_,Value),
	['prolog','constraint handling rules']:
			("member",ws,"(",ws,Name,ws,",",ws,Index,ws,"-",ws,Value,ws,")"),
	['java']:	
			(Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")")
	]).

%from A (inclusive) to B (exclusive)
range_(Data,[A,B]) -->
	langs_to_output(Data,range,[
	['swift','perl','picat','minizinc','chapel']:
		("(",ws,A,ws,"..",ws,B,ws,")"),
	['rust']:
		("(",ws,A,ws,"...",ws,B,ws,")"),
	["python"]:
		("range",python_ws,"(",python_ws,A,python_ws,",",B,python_ws,"-",python_ws,"1",python_ws,")")
    ]).

get_user_input_(Data) -->
        langs_to_output(Data,get_user_input,[
			['python']:
				("input",python_ws,"(",python_ws,")"),
			['perl']:
				"<>",
			['ruby']:
				"gets",
			['swift']:
				("readLine",ws,"(",ws,")"),
			['php']:
				("readline",ws,"(",ws,")"),
			['OCaml']:
				("read_line",ws,"(",ws,")"),
			['perl 6']:
				("prompt",ws,"(",ws,")"),
			['prolog']:
				("read",ws,"(",ws,Var,ws,")"),
			['julia']:
				("chomp",ws,"(",ws,"readline",ws,"(",ws,")",ws,")"),
			['lua']:
				("io",ws,".",ws,"stdin:read",ws,"(",ws,")"),
			['c#']:
				("Console",ws,".",ws,"ReadLine",ws,"(",ws,")")
        ]).

get_user_input_with_prompt_(Data,[Var,Prompt]) -->
        langs_to_output(Data,get_user_input_with_prompt,[
			['python']:
				(Var,python_ws,"=",python_ws,"input",python_ws,"(",python_ws,Prompt,python_ws,")"),
			['php']:
				(Var,ws,"=",ws,"readline",ws,"(",ws,Prompt,ws,")"),
			['perl']:
				("print",ws,"(",ws,Prompt,ws,")",ws,";",ws,"=",ws,"<>"),
			['erlang']:
				(Var,ws,"=",ws,"io:get_line(",ws,Prompt,ws,")")
        ]).

initializer_list_(Data,[A,Type]) -->
        langs_to_output(Data,initializer_list,[
        %initializer lists in Java should be ArrayLists
        ['lua','pseudocode','picat','c#','c++','c','visual basic','visual basic .net','wolfram']:
                ("{",ws,A,ws,"}"),
        ['java']:
                ("new",ws_,Type,"[]",ws,"{",ws,A,ws,"}"),
		['ocaml']:
				(
					%this is for lists
					"[|",ws,A,ws,"|]";
					%this is for arrays
					"[",ws,A,ws,"]"
				),
		['english']:
                ("{",ws,A,ws,"}";"[",ws,A,ws,"]"),
        ['go']:
				("[]",Type,"{",ws,A,ws,"}"),
        [ 'ruby', 'cosmos', 'python', 'cython', 'nim','d','frink','rebol','octave','julia','prolog','constraint handling rules','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift']:
                ("[",python_ws,A,python_ws,"]"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['scala']:
                ("Array",ws,"(",ws,A,ws,")"),
        ['perl','chapel']:
                ("(",ws,A,ws,")"),
        ['fortran']:
                ("(/",ws,A,ws,"/)"),
        ['r']:
				("s(",ws,A,ws,")")
        ]).

%https://rosettacode.org/wiki/Associative_array

dict_(Data,[A,Type]) -->
		langs_to_output(Data,dict,[
		['python', 'english_temp', 'cosmos', 'ruby', 'lua', 'dart','javascript','typescript','julia','c++','engscript']:
                ("{",python_ws,A,python_ws,"}"),
        ['c#']:
				("new",ws_,"Dictionary<string",ws,",",ws,Type,ws,">{",ws,A,ws,"}"),
        ['java']:
				("new",ws_,"ArrayList<",Type,">().",ws,A),
        ['picat']:
                ("new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")"),
        ['go']:
                ("map",ws,"[",ws,"Input",ws,"]",ws,"Output",ws,"{",ws,A,ws,"}"),
        ['perl']:
                ("(",ws,A,ws,")"),
        ['php']:
                ("array",ws,"(",ws,A,ws,")"),
        ['haxe','frink','swift','elixir','d','wolfram','prolog','constraint handling rules']:
                ("[",ws,A,ws,"]"),
        ['scala']:
                ("Map",ws,"(",ws,A,ws,")"),
        ['gnu smalltalk']:
                ("Dictionary",ws,"(",ws,A,ws,")"),
        ['octave']:
                ("struct",ws,"(",ws,A,ws,")"),
        ['rebol']:
                ("to-hash",ws,"[",ws,A,ws,"]")
        ]).

struct_(Data,[Name,Values,Indent]) -->
        langs_to_output(Data,struct,[
			['c']:
				("struct",ws_,Name,ws,"{",ws,Values,(Indent;ws),"}",ws,";"),
			['go']:
				("type",ws_,Name,ws_,"struct",ws,"{",ws,Values,(Indent;ws),"}"),
			['c#']:
				("public",ws,"struct",ws_,Name,ws,"{",ws,Values,(Indent;ws),"}")
        ]).	

tan_(Data,[Var1]) -->  
        langs_to_output(Data,tan,[
        ['java','ruby','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")"),
        ['python','lua']:
                ("math",python_ws,".",python_ws,"tan",python_ws,"(",python_ws,Var1,python_ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("tan",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Tan",ws,"[",ws,Var1,ws,"]"),
        ['rebol']:
                ("tangent/radians",ws_,Var1),
        ['go']:
                ("math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")"),
        ['common lisp','racket']:
                ("(",ws,"tan",ws_,"a",ws,")"),
        ['clojure']:
                ("(",ws,"Math/tan",ws_,"a",ws,")")
        ]).
false_(Data) -->
    langs_to_output(Data,'false',[
    ['java','ruby','lua','constraint handling rules','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol','hack']:
			("false"),
	['python','pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
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

true_(Data) --> 
	langs_to_output(Data,'true',[
	['java','ruby','lua','constraint handling rules','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol']:
			("true"),
	['python','pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
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

acos_(Data,[Var1]) -->
        langs_to_output(Data,acos,[
        ['c','perl','prolog']:
                ("acos",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Acos",ws,"(",ws,Var1,ws,")")
        ]).

asin_(Data,[Var1]) -->
        langs_to_output(Data,asin,[
        ['c','perl','prolog']:
                ("asin",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Asin",ws,"(",ws,Var1,ws,")")
        ]).

atan_(Data,[Var1]) -->
        langs_to_output(Data,atan,[
        ['c','perl','prolog']:
                ("atan",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Atan",ws,"(",ws,Var1,ws,")")
        ]).

sinh_(Data,[Var1]) -->
	langs_to_output(Data,sinh,[
	['c']:
			("sinh",ws,"(",ws,Var1,ws,")"),
	['c#']:
			("Math",ws,".",ws,"Sinh",ws,"(",ws,Var1,ws,")")
	]).
cosh_(Data,[Var1]) -->
	langs_to_output(Data,cosh,[
	['c']:
			("cosh",ws,"(",ws,Var1,ws,")"),
	['go']:
			("Cosh",ws,"(",ws,Var1,ws,")"),
	['c#']:
			("Math",ws,".",ws,"Cosh",ws,"(",ws,Var1,ws,")")
	]).

% see http://rosettacode.org/wiki/Real_constants_and_functions#Haskell
abs_(Data,[Var1]) -->
	langs_to_output(Data,abs,[
	['java','javascript']:
			("Math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")"),
	['ruby']:
			(Var1,ws,".",ws,"abs"),
	['f#','c#']:
			("Math",ws,".",ws,"Abs",ws,"(",ws,Var1,ws,")"),
	['lua']:
			("math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")"),
	['c','perl','php','python','erlang','prolog']:
			("abs",python_ws,"(",python_ws,Var1,python_ws,")"),
	['wolfram']:
            ("Abs",ws,"[",ws,Var1,ws,"]")
	]).

sin_(Data,[Var1]) -->
        langs_to_output(Data,sin,[
        ['java','ruby','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")"),
        ['python','cython','lua']:
                ("math",python_ws,".",python_ws,"sin",python_ws,"(",python_ws,Var1,python_ws,")"),
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

cos_(Data,[Var1]) -->
        langs_to_output(Data,cos,[
        ['java','ruby','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")"),
        ['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala']:
                ("cos",ws,"(",ws,Var1,ws,")"),
        ['c#']:
                ("Math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['wolfram']:
                ("Cos",ws,"[",ws,Var1,ws,"]"),
        ['go']:
                ("math",ws,".",ws,"Cos",ws,"(",ws,Var1,ws,")"),
        ['python','lua']:
                ("math",python_ws,".",python_ws,"cos",python_ws,"(",python_ws,Var1,python_ws,")"),
        ['rebol']:
                ("cosine/radians",ws_,Var1),
        ['common lisp','racket']:
                ("(",ws,"cos",ws_,Var1,ws,")"),
        ['clojure']:
                ("(",ws,"Math/cos",ws_,Var1,ws,")")
        ]).

% see https://rosettacode.org/wiki/Real_constants_and_functions
ceiling_(Data,[Params]) -->
        langs_to_output(Data,ceiling,[
                ['javascript','java']:
					("Math",ws,".",ws,"ceil",ws,"(",ws,Params,ws,")"),
				['c#']:
					("Math",ws,".",ws,"Ceiling",ws,"(",ws,Params,ws,")"),
				['python','lua']:
					("math",python_ws,".",python_ws,"ceil",python_ws,"(",python_ws,Params,python_ws,")"),
				['c','perl','php','pl/i','octave']:
					("ceil",ws,"(",ws,Params,ws,")"),
				['perl 6','prolog']:
					("ceiling",ws,"(",ws,Params,ws,")"),
				['wolfram']:
					("Ceiling",ws,"[",ws,Params,ws,"]")
        ]).
        
% see https://rosettacode.org/wiki/Real_constants_and_functions
floor_(Data,[Params]) -->
        langs_to_output(Data,floor,[
                ['javascript','java','actionscript']:
                        ("Math",ws,".",ws,"floor",ws,"(",ws,Params,ws,")"),
                ['c#']:
                        ("Math",ws,".",ws,"Floor",ws,"(",ws,Params,ws,")"),
                ['python','lua']:
                        ("math",python_ws,".",python_ws,"floor",python_ws,"(",python_ws,Params,python_ws,")"),
                ['c','perl','php','pl/i','octave','prolog']:
						("floor",ws,"(",ws,Params,ws,")")
        ]).

copy_array_(A1,A2) -->
	langs_to_output(Data,copy_array,[
		['python']:
			(A2,"=","list",ws,"(",ws,A1)
	]).
	
anonymous_function_(Data,[Type,Params,B]) -->
		langs_to_output(Data,anonymous_function,[
		['matlab','octave']:
                ("(",ws,"@",ws,"(",ws,Params,ws,")",ws,B,ws,")"),
        ['picat']:
                ("lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,B,ws,")"),
        ['javascript','typescript','haxe','r','php']:
                (
					"function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
					%arrow functions
					"(",ws,Params,ws,")",ws,"=>",ws,"{",ws,B,ws,"}"
				),
        ['haskell']:
                ("(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")"),
        ['frink']:
                ("{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}"),
        ['erlang']:
                ("fun",ws,"(",ws,Params,ws,")",ws_,B,"end"),
        ['julia','lua']:
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

type_conversion_(['perl'|_],[Type1,Type2,Arg]) -->
	{member(Type1,[int,string,bool,double]),member(Type2,[int,string,bool,double])},
	Arg.

type_conversion_(Data,[_,Type2,Arg]) -->
	{Data=['python'|_]},
	(type(Data,Type2),python_ws,"(",python_ws,Arg,python_ws,")").

type_conversion_(Data,[_,Type2,Arg]) -->
	{Data=['php'|_]},
	("(",ws,type(Data,Type2),ws,")",ws,"(",ws,Arg,ws,")").

type_conversion_(Data,[string,[array,char],Arg]) -->
	langs_to_output(Data,[type_conversion,string,[array,char]],[
        ['python','cython']:
			("list",python_ws,"(",python_ws,Arg,python_ws,")"),
		['php']:
			("str_split",ws,"(",ws,Arg,ws,")"),
		['swift']:
			("Array",ws,"(",ws,Arg,ws,")"),
		['javascript']:
			("Array",ws,".",ws,"from",ws,"(",ws,Arg,ws,")"),
		['java']:
			(Arg,ws,".",ws,"toCharArray",ws,"(",ws,")"),
		['c#','visual basic .net']:
			(Arg,ws,".",ws,"ToCharArray",ws,"(",ws,")"),
		['ruby']:
			(Arg,ws,".",ws,"char"),
		['perl']:
			("(",ws,split,ws_,"//",ws_,Arr,ws,")"),
		['haskell']:
			(Arg)
	]).

type_conversion_(Data,[char,string,Arg]) -->
	langs_to_output(Data,[type_conversion,char,string],[
		['java']:
			("String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")"),
		['c#']:
			(
				Arg,ws,".",ws,"ToString",ws,"(",ws,")";
				"Char",ws,".",ws,"ToString(",ws,Arg,ws,")"
			)
	]).

type_conversion_(Data,[int,string,Arg]) -->
		langs_to_output(Data,[type_conversion,int,string],[
        ['erlang']:
			("integer_to_list",ws,"(",ws,Arg,ws,")"),
        ['c#']:
                (Arg,ws,".",ws,"ToString",ws,"(",ws,")"),
        ['ruby']:
                (Arg,ws,".",ws,"to_s"),
        ['java']:
				("Integer",ws,".",ws,"toString",ws,"(",ws,Arg,ws,")";
				"String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")"),
        ['javascript','swift']:
                ("String",ws,"(",ws,Arg,ws,")"),
        ['c++']:
				("std::to_string",ws,"(",ws,Arg,ws,")"),
		['haskell']:
				("(",ws,"show",ws_,Arg,")"),
		['ocaml']:
				("(",ws,"string_of_int",ws_,Arg,")"),
		['python']:
				("str",python_ws,"(",python_ws,Arg,python_ws,")")
        ]).

type_conversion_(['c#'|_],[_,bool,Arg]) -->
	("Convert",ws,".",ws,"toBoolean",ws,"(",ws,Arg,ws,")").

type_conversion_(['c#'|_],[_,int,Arg]) -->
	("Convert",ws,".",ws,"toInt32",ws,"(",ws,Arg,ws,")").

type_conversion_(['c#'|_],[_,double,Arg]) -->
	("Convert",ws,".",ws,"toDouble",ws,"(",ws,Arg,ws,")").

type_conversion_(Data,[bool,string,Arg]) -->
		langs_to_output(Data,[type_conversion,bool,string],[
        ['python']:
				("str",python_ws,"(",python_ws,Arg,python_ws,")"),
        ['java']:
				("Boolean",ws,".",ws,"toString",ws,"(",ws,Arg,ws,")";
				"String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")"),
		['php']:
			("var_export",ws,"(",ws,Arg,ws,",",ws,"true",ws,")")
        ]).

type_conversion_(Data,[string,bool,Arg]) -->
		langs_to_output(Data,[type_conversion,string,bool],[
        ['python']:
				("boolean",python_ws,"(",python_ws,Arg,python_ws,")"),
        ['java']:
				("Boolean",ws,".",ws,"parseBoolean",ws,"(",ws,Arg,ws,")";
				"Boolean",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")")
        ]).

type_conversion_(Data,[string,int,Arg]) -->
		langs_to_output(Data,[type_conversion,string,int],[
        ['erlang']:
			("list_to_integer",ws,"(",ws,Arg,ws,")"),
        ['javascript']:
			("parseInt",ws,"(",ws,Arg,ws,")"),
		['ocaml']:
				("(",ws,"int_of_string",ws_,Arg,")"),
		['coffeescript']:
			("parseInt",python_ws,"(",python_ws,Arg,python_ws,")"),
		['c']:
			(
				"(",ws,"int",ws,")",ws_,"strtol",ws,"(",ws,Arg,ws,",",ws,"(",ws,"char",ws_,"**",ws,")",ws,"NULL,",ws,"10",ws,")";
				"atoi",ws,"(",ws,Arg,ws,")"
			),
		['ruby']:
			(ws,Arg,".",ws,"to_i"),
        ['java']:
			("Integer",ws,".",ws,"parseInt",ws,"(",ws,Arg,ws,")"),
		['haxe']:
			("Std",ws,".",ws,"parseInt",ws,"(",ws,Arg,ws,")"),
		['c#']:
			("Int32",ws,".",ws,"Parse",ws,"(",ws,Arg,ws,")"),
		['swift']:
			("Int",ws,"(",ws,Arg,ws,")"),
		['c++']:
			("atoi",ws,"(",Arg,".",ws,"c_str",ws,"(",ws,")",ws,")"),
		['haskell']:
			("(",ws,"read",ws_,Arg,")"),
		['python']:
			("int",python_ws,"(",python_ws,Arg,python_ws,")"),
		['lua']:
			("tonumber",python_ws,"(",python_ws,Arg,python_ws,")")
        ]).

type_conversion_(Data,[string,double,Arg]) -->
		langs_to_output(Data,[type_conversion,string,double],[
        ['python']:
			("float",python_ws,"(",python_ws,Arg,python_ws,")"),
		['c']:
			(
				"strtod",ws,"(",ws,Arg,ws,")";
				"atof",ws,"(",ws,Arg,ws,")"
			),
        ['java']:
			("Double",ws,".",ws,"parseDouble",ws,"(",ws,Arg,ws,")"),
		['haxe']:
			("Double",ws,".",ws,"parseFloat",ws,"(",ws,Arg,ws,")"),
		['lua']:
			("tonumber",ws,"(",ws,Arg,ws,")"),
		['javascript']:
			("Number",ws,"(",ws,Arg,ws,")"),
		['coffeescript']:
			("Number",python_ws,"(",python_ws,Arg,python_ws,")"),
		['ruby']:
			(Arg,ws,".",ws,"to_f"),
		['perl']:
			Arg,
		['c++']:
			("std::stod",ws,"(",ws,Arg,ws,")")
        ]).

type_conversion_(Data,[double,string,Arg]) -->
		langs_to_output(Data,[type_conversion,double,string],[
        ['python']:
			("str",python_ws,"(",python_ws,Arg,python_ws,")"),
		['haskell']:
			("(",python_ws,"show",python_ws_,Arg,python_ws,")"),
		['java']:
			("String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")";
			"Double",ws,".",ws,"toString",ws,"(",Arg,")"),
		['c++']:
			("std::to_string",ws,"(",ws,Arg,ws,")"),
		['perl']:
			Arg,
		['swift']:
			("String",ws,"(",ws,Arg,ws,")"),
		['javascript']:
			("toString",ws,"(",ws,Arg,ws,")"),
		['coffeescript']:
			("toString",python_ws,"(",python_ws,Arg,python_ws,")")
        ]).

static_method_call_(Data,[Class_name,Function_name,Args]) -->
    langs_to_output(Data,static_method_call,[
    ['java','javascript','c#']:
		(Class_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['python','coffeescript']:
		(Class_name,".",Function_name,ws,"(",python_ws,Args,python_ws,")"),
	['php','c++']:
		(Class_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Class_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).
instance_method_call_(Data,[Instance_name,Function_name,Args]) -->
	langs_to_output(Data,instance_method_call,[
    ['java','haxe','javascript','c#','c++']:
		(Instance_name,".",Function_name,ws,"(",ws,Args,ws,")"),
	['logtalk']:
		(Instance_name,"::",Function_name,ws,"(",ws,Args,ws,")"),
	['perl']:
		(Instance_name,"->",Function_name,ws,"(",ws,Args,ws,")")
    ]).

plus_plus_(Data,[Name]) -->
        langs_to_output(Data,plus_plus,[
        ['javascript','java','c','php']:
			(Name,ws,"++"),
		['ruby']:
			(Name,ws,"=",ws,Name,ws,"+",ws,"1")
        ]).

set_array_index_(Data,[Name,Index,Value]) -->
	set_var_(Data,[access_array_(Data,[Name,Index]),Value]).

mod_(Data,[A,B]) -->
    langs_to_output(Data,mod,[
    ['java','lua','ruby','perl 6','python','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','tcl','go','dart','javascript','c','c++','c#']:
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

synonym("greater") --> "more".
synonym("each") --> "every";"all".
synonym("print") --> "write".
synonym("=") --> "equals";"is".

synonym("+") --> python_ws_,"plus",python_ws_.
synonym("and") --> "and";"but";"although".
synonym("-") --> python_ws_,"minus",python_ws_.
synonym("*") -->
	python_ws_,"times",python_ws_;
	python_ws_,"multiplied",python_ws_,"by",python_ws_.
synonym("/") -->
	python_ws_,"divided",python_ws_,"by",python_ws_.
synonym(A) --> A.
synonym("does not equal") -->
	"does",ws_,"not",ws_,"equal";"is",ws_,"not";"cannot",ws_,"be";"!=";"!==".

arithmetic_(Data,[Exp1,Exp2,Symbol]) -->
        {prefix_arithmetic_langs(Prefix_arithmetic_langs)},
        langs_to_output(Data,arithmetic,[
		['english']:
		(
			Exp1,ws,synonym(Symbol),ws,Exp2;
			"the",ws_,"sum",ws_,"of",ws_,Exp1,ws_,"and",ws_,Exp2,{Symbol="+"};
			"the",ws_,"product",ws_,"of",ws_,Exp1,ws_,"and",ws_,Exp2,{Symbol="*"}
		),
		Infix_arithmetic_langs:
                (Exp1,ws,Symbol,ws,Exp2),
		Prefix_arithmetic_langs:
                ("(",ws,Symbol,ws_,Exp1,ws_,Exp2,ws,")")
        ]).

string_matches_string_(Data,[Str,Reg]) -->
        langs_to_output(Data,string_matches_string,[
        ['java']:
            (Str,ws,".",ws,"matches",ws,"(",ws,Reg,ws,")"),
        ['php']:
            ("preg_match",ws,"(",ws,Reg,ws,",",ws,Str,ws,")")
        ]).

new_regex_(Data,[A]) -->
        langs_to_output(Data,new_regex,[
        ['scala','c#']:
            ("new",ws,"Regex",ws,"(",ws,A,ws,")"),
        ['javascript']:
            ("new",ws,"RegExp",ws,"(",ws,A,ws,")"),
        ['c++']:
            ("regex",ws,"::",ws,"regex",ws,"(",ws,A,ws,")")
        ]).

foreach_with_index_(Data,[Array,Var,Index,Type,Body,Indent]) -->
        langs_to_output(Data,foreach_with_index,[
			['lua']:
				("for",ws_,Index,ws,",",ws,Var,ws_,"in",ws_,"pairs",ws,"(",ws,Array,ws,")",ws_,"do",ws_,Body,(Indent;ws_),"end"),
			['python']:
				("for",python_ws_,Index,python_ws,",",python_ws,Var,python_ws_,"in",python_ws_,"enumerate",python_ws,"(",python_ws,Array,python_ws,"):",python_ws,Body),
			['english_temp']:
				(("for";"for",python_ws,synonym("each")),python_ws_,Index,python_ws,",",python_ws,Var,python_ws_,"in",python_ws_,"enumerate",python_ws,"(",python_ws,Array,python_ws,"):",python_ws,Body),
			['php']:
				("foreach",ws,"(",ws,Array,ws_,"as",ws_,Index,ws,"=>",ws,Var,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
			['javascript','typescript']:
				(Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,",",ws,Index,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";"),
			['ruby']:
				(Array,ws,".",ws,"each_with_index",ws_,"do",ws,"|",ws,Var,ws,",",ws,Index,ws,"|",ws,Body,(Indent;ws_),"end"),
			['swift']:
				("for",ws,"(",ws,Index,ws,",",ws,Var,ws,")",ws_,"in",ws_,Array,ws,".",ws,"enumerated",ws,"(",ws,")",ws,"{",ws,Body,(Indent;ws),"}")
		]).

foreach_(Data,[Array,Var,Type,Body,Indent]) -->
        langs_to_output(Data,foreach,[
        ['perl']:
                ("for",ws_,Var,ws_,"(",ws,Array,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),
        ['ruby']:
				(Array,ws,".",ws,"each",ws_,"do",ws,"|",ws,Var,ws,"|",ws,Body,(Indent;ws_),"end"),
        ['erlang']:
				("foreach",ws,"(",ws,"fun",ws,"(",ws,Var,ws,")",ws,"->",ws,Body,ws_,"end",ws,",",ws,Array,ws,")"),
		['c']:
			({unique_var(X)},Type,ws_,Var,ws,";",ws_,"int",ws_,X,ws,";",ws,"for",ws,"(",ws,"int",ws_,X,ws,"=",ws,"0",ws,";",ws,X,ws,"<",ws,array_length(Data,[Array]),ws,";",ws,X,ws,"++",ws,")",ws,"{",ws,Var,ws,"=",ws,Array,ws,"[",ws,X,ws,"]",ws,";",ws,Body,(Indent;ws),"}"),
        ['lua']:
				("for",ws_,"_",ws,",",ws,Var,ws_,"in",ws_,"pairs",ws,"(",ws,Array,ws,")",ws_,"do",ws_,Body,(Indent;ws_),"end"),
        ['seed7']:
                ("for",ws_,Var,ws_,"range",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end",ws_,"for;"),
        ['javascript','typescript']:
                (Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}",ws,")",ws,";"),
        ['octave']:
                ("for",ws_,Var,ws,"=",ws,Array,ws_,Body,(Indent;ws_),"endfor"),
        ['prolog']:
				("foreach",ws,"(",ws,"member",ws,"(",Var,ws,",",ws,Array,")",ws,",",ws,"(",ws,Body,ws,")",ws,")"),
        ['z3']:
                ("(",ws,"forall",ws_,"(",ws,"(",ws,Var,ws_,"a",ws,")",ws,")",ws_,"(",ws,"=>",ws,"select",ws_,Array,ws,")",ws,")"),
        ['gap']:
                ("for",ws_,Var,ws_,"in",ws_,Array,ws_,"do",ws_,Body,ws_,"od;"),
        ['minizinc']:
                ("forall",ws,"(",ws,Var,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")"),
        ['php','hack']:
                ("foreach",ws,"(",ws,Array,ws_,"as",ws_,Var,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['java']:
                ("for",ws,"(",ws,Type,ws_,Var,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['c#','vala']:
                ("foreach",ws,"(",ws,Type,ws_,Var,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['cython','python']:
                ("for",python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,":",python_ws,Body),
        ['coffeescript']:
                ("for",python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,Body),
        ['english_temp']:
                (("for";"for",python_ws_,synonym("each")),python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,":",python_ws,Body),
        ['julia']:
                ("for",ws_,Var,ws_,"in",ws_,Array,ws_,Body,(Indent;ws_),"end"),
        ['chapel','swift']:
                ("for",ws_,Var,ws_,"in",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}"),
        ['pawn']:
                ("foreach",ws,"(",ws,"new",ws_,Var,ws,":",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['picat']:
                ("foreach",ws,"(",ws,Var,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")",ws,"end"),
        ['awk','ceylon']:
                ("for",ws_,"(",ws_,Var,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['go']:
                ("for",ws_,Var,ws,":=",ws,"range",ws_,Array,ws,"{",ws,Body,(Indent;ws),"}"),
        ['haxe','groovy']:
                ("for",ws,"(",ws,Var,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['nemerle','powershell']:
                ("foreach",ws,"(",ws,Var,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['scala']:
                ("for",ws,"(",ws,Var,ws,"->",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['rebol']:
                ("foreach",ws_,Var,ws_,Array,ws,"[",ws,Body,ws,"]"),
        ['c++']:
                ("for",ws,"(",ws,Type,ws_,"&",ws_,Var,ws,":",ws,Array,ws,"){",ws,Body,(Indent;ws),"}"),
        ['d']:
                ("foreach",ws,"(",ws,Var,ws,",",ws,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['gambas']:
                ("FOR",ws_,"EACH",ws_,Var,ws_,"IN",ws_,Array,ws_,Body,ws_,"NEXT"),
        ['vbscript','visual basic .net']:
                ("For",ws_,"Each",ws_,Var,ws_,"In",ws_,Array,ws_,Body,ws_,"Next"),
        ['dart']:
                ("for",ws,"(",ws,"var",ws_,Var,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,(Indent;ws),"}")
        ]).

switch_(Data,[A,B,Indent]) -->
		langs_to_output(Data,switch,[
		['rust']:
				("match",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
		['csh']:
				("switch",ws,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"endsw"),
		['elixir']:
				("case",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end"),
		['scala']:
				(A,ws_,"match",ws,"{",ws,B,(Indent;ws),"}"),
		['octave']:
				("switch",ws,"(",ws,A,ws,")",ws,B,(Indent;ws_),"endswitch"),
		['java','d','powershell','nemerle','d','typescript','hack','swift','groovy','dart','awk','c#','javascript','c++','php','c','go','haxe','vala']:
				("switch",ws,"(",!,ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}"),
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

unless_(Data,[A,B,Indent]) -->
	langs_to_output(Data,unless,[
		['english']:
			("unless",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B),
		['python','javascript','java','c#','prolog','c','c++','php','lua']:
			if_without_else_(Data,[not_(Data,[A]),B,Indent]),
		['ruby']:
			("unless",ws_,A,ws_,B,(Indent;ws_),"end"),
		['perl']:
			("unless",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws_),"}")
	]).
        
if_without_else_(Data,[A,B,Indent]) -->
	langs_to_output(Data,if_without_else,[
		['cython','python']:
			("if",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B),
		['java','e','ooc','englishscript','mathematical notation','polish notation','reverse polish notation','perl 6','chapel','katahdin','pawn','powershell','d','ceylon','typescript','actionscript','hack','autohotkey','gosu','nemerle','swift','nemerle','pike','groovy','scala','dart','javascript','c#','c','c++','perl','haxe','php','r','awk','vala','bc','squirrel']:
			("if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
		['fortran']:
				("IF",ws_,A,ws_,"THEN",ws_,B,(Indent;ws_),"END",ws_,"IF"),
		['julia']:
				("if",ws_,A,ws_,B,(Indent;ws_),"end"),
		['picat','ruby','lua']:
				("if",ws_,A,ws_,"then",ws_,B,(Indent;ws_),"end"),
		['octave']:
				("if",ws_,A,ws_,B,(Indent;ws_),"endif"),
		['haskell','pascal','delphi','maxima','ocaml']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D),
		['livecode']:
				("if",ws_,A,ws_,"then",ws_,B,(Indent;ws_),"end",ws_,"if"),
		['vhdl']:
				("if",ws_,A,ws_,"then",ws_,B,(Indent;ws_),"end",ws_,"if",ws,";"),
		['rust','go']:
				("if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",(Indent;ws),C),
		['clips']:
				("(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,ws,")"),
		['z3']:
				("(",ws,"ite",ws_,A,ws_,B,ws_,C,ws_,D,ws,")"),
		['minizinc']:
				("if",ws_,A,ws_,"then",ws_,B,(Indent;ws_),"endif"),
		['english']:
				("if",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B),
		['visual basic','visual basic .net']:
				("If",ws_,A,ws_,"Then",ws_,B,(Indent;ws_),"End",ws_,"If"),
		['monkey x']:
				("if",ws_,A,ws_,B,(Indent;ws_),"EndIf")
	]).

if(Data,[A,B,C,D,Indent]) -->
		langs_to_output(Data,if,[
		['sympy']:
				("Piecewise",ws,"(",ws,"(",ws,B,ws,",",ws,A,ws,")",ws,",",ws,C,ws,",",ws,D,ws,")"),
		['erlang']:
				("if",ws_,A,ws,"->",ws,B,ws,";",(Indent;ws),C,ws,";",(Indent;ws),D,(Indent;ws_),"end"),
		['prolog','constraint handling rules','logtalk']:
				("(",ws,A,ws,"->",ws,B,ws,";",(Indent;ws),C,ws,";",(Indent;ws),D,ws,")"),
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
				("if",ws_,A,ws_,"then",ws_,B,(Indent;ws_),C,ws_,D,(Indent;ws_),"end",ws_,"if"),
		['vhdl']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"end",ws_,"if",ws,";"),
		['java','e','ooc','englishscript','mathematical notation','polish notation','reverse polish notation','perl 6','chapel','katahdin','pawn','powershell','d','ceylon','typescript','actionscript','hack','autohotkey','gosu','nemerle','swift','nemerle','pike','groovy','scala','dart','javascript','c#','c','c++','perl','haxe','php','r','awk','vala','bc','squirrel']:
				(if_without_else_(Data,[A,B,Indent]),(Indent;ws),C,(Indent;ws),D),
		['rust','go']:
				("if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",(Indent;ws),C),
		['clips']:
				("(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,ws,")"),
		['z3']:
				("(",ws,"ite",ws_,A,ws_,B,ws_,C,ws_,D,ws,")"),
		['minizinc']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"endif"),
		['cython','python']:
				(if_without_else_(Data,[A,B,Indent]),python_ws,Indent,C,D),
		['english_temp']:
				("if",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",python_ws,B,python_ws,Indent,C,D),
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

do_while_(Data,[Condition,Body,Indent]) -->
        langs_to_output(Data,do_while,[
        ['javascript','actionscript','java','c','php','d','c++','c#','perl']:
			("do",ws,"{",!,ws,Body,(Indent;ws),"}",ws,"while",ws,"(",ws,Condition,ws,")",ws,";"),
		['kotlin']:
			("do",ws,"{",ws,Body,(Indent;ws),"}",ws,"while",ws,"(",ws,Condition,ws,")"),
		['swift']:
			("repeat",ws,"{",ws,Body,(Indent;ws),"}",ws,"while",(ws_,Condition;ws,"(",ws,Condition,ws,")")),
		['visual basic .net']:
			("Do",ws_,Body,(Indent;ws_),"Loop",ws_,"While",ws,Condition),
		['ruby']:
			("begin",ws_,Body,(Indent;ws_),"end",ws_,"while",ws,Condition),
		['lua']:
			("repeat",ws_,Body,(Indent;ws_),"until",ws,"(",ws,Condition,ws,")")
]).

map_(Data,[Func,Arr]) -->
        langs_to_output(Data,map,[
			['common lisp']:
				("(",ws,"mapcar",ws_,Func,ws_,Arr,ws,")"),
			['clojure','haskell']:
				("(",ws,"map",ws_,Func,ws_,Arr,ws,")"),
			['groovy']:
				(Arr,ws,".",ws,"collect",ws,"(",ws,Func,ws,")"),
			['python']:
				("map",python_ws,"(",python_ws,Func,python_ws,",",python_ws,Arr,python_ws,")"),
			['php']:
				("array_map",ws,"(",ws,Func,ws,",",ws,Arr,ws,")")
]).

while_(Data,[A,B,Indent]) -->
        langs_to_output(Data,while,[
        ['c','perl 6','katahdin','chapel','ooc','processing','pike','kotlin','pawn','powershell','hack','gosu','autohotkey','ceylon','d','typescript','actionscript','nemerle','dart','swift','groovy','scala','java','javascript','php','c#','perl','c++','haxe','r','awk','vala']:
                ("while",ws,"(",ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}"),
        ['ocaml']:
				("while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"done"),
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
                ("while",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",B),
        ['coffeescript']:
                ("while",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,B),
        ['english']:
                ("while",(python_ws_,A;python_ws,"(",python_ws,A,python_ws,")"),python_ws,":",B),
        ['visual basic','visual basic .net','vbscript']:
                ("While",ws_,A,ws_,B,(Indent;ws_),"End",ws_,"While"),
        ['octave']:
                ("while",ws,"(",ws,A,ws,")",ws_,B,(Indent;ws_),"endwhile"),
        ['wolfram']:
                ("While",ws,"[",ws,A,ws,",",ws,B,(Indent;ws),"]"),
        ['go']:
                ("for",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
        ['vbscript']:
                ("Do",ws_,"While",ws_,A,ws_,B,(Indent;ws_),"Loop"),
        ['seed7']:
                ("while",ws_,A,ws_,"do",ws_,B,(Indent;ws_),"end",ws_,"while",ws,";"),
        ['vhdl']:
				("while",ws_,A,ws_,"loop",ws_,B,(Indent;ws_),"end",ws_,"loop",ws,";")
        ]),!.

predicate_(Data,[Name,Params,Body,_]) -->
		%add predicates for python and clips
		langs_to_output(Data,predicate,[
		['prolog']:
			(Name,ws,"(",ws,Params,ws,")",ws,":-",ws,Body),
		['minizinc']:
			("predicate",ws_,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body),
		%this is for pydatalog
		['cosmos']:
			("rel",python_ws_,Name,python_ws,"(",python_ws,Params,python_ws,")",python_ws,Body,python_ws)
		]).

iff_(Data,[Condition,Body]) -->
        langs_to_output(Data,iff,[
        ['z3']:
			("(",ws,("iff";"<=>"),ws_,Condition,ws_,Body,ws_,")"),
		['minizinc']:
			(Condition,ws,"<->",ws,Body)
        ]).

for_(Data,[Statement1,Condition,Statement2,Body,Indent]) -->
		langs_to_output(Data,for,[
        ['java','d','pawn','groovy','javascript','dart','typescript','php','hack','c#','perl','c++','awk','pike']:
                ("for",ws,"(",!,ws,Statement1,ws,";",ws,Condition,ws,";",ws,Statement2,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}")
        ]).

semicolon_(Data,[A]) -->
		{grammars(Grammars)},
        langs_to_output(Data,semicolon,[
        Grammars:
				A,
        ['c','hack','vhdl','f#','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala']:
                (A,ws,";",!),
        ['pseudocode']:
                (A,("";ws,";")),
        ['visual basic .net','clips','pddl','sympy','r','constraint handling rules','pydatalog','common lisp','gnu smalltalk','ruby','lua','hy',picolisp,logtalk,minizinc,'swift','rebol','fortran','go','picat','julia',prolog,'haskell','mathematical notation','erlang',z3]:
                A,
		['python','cython','coffeescript']:
				(A;A,";"),
		['english']:
				(A;A,";")
        ]).


class_implements_interface_(Data,[C1,C2,B,Indent]) -->
        langs_to_output(Data,class_implements_interface,[
        ['java','c#']:
                ("public",ws_,"class",ws_,C1,ws_,"implements",ws_,C2,ws,"{",ws,B,(Indent;ws),"}")
        ]).

class_extends_and_implements_(Data,[C1,C2,C3,B,Indent]) -->
        langs_to_output(Data,class_extends_and_implements,[
        ['java','c#']:
			("public",ws_,"class",ws_,C1,ws_,"extends",ws_,C2,ws_,"implements",ws_,C3,ws,"{",ws,B,(Indent;ws),"}"),
        ['php']:
			("class",ws_,C1,ws_,"extends",ws_,C2,ws_,"implements",ws_,C3,ws,"{",ws,B,(Indent;ws),"}")
        ]).

interface_extends_(Data,[C1,C2,B,Indent]) -->
        langs_to_output(Data,interface_extends,[
        ['java','c#']:
			("public",ws_,"interface",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
		['php']:
			("interface",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
		['swift']:
			("protocol",ws_,C1,ws,":",ws,C2,ws,"{",ws,B,(Indent;ws),"}")
		]).

class_extends_(Data,[C1,C2,B,Indent]) -->
        langs_to_output(Data,class_extends,[
        ['logtalk']:
                ("object",ws,"(",C1,ws,",",ws,"extends",ws,"(",ws,C2,ws,")",ws,".",ws,B,(Indent;ws),"end_object",ws,"."),
        ['hy']:
                ("(",ws,"defclass",ws_,C1,ws_,"[",ws,C2,ws,"]",ws_,B,")"),
        ['swift','chapel','d','swift']:
                ("class",ws_,C1,ws,":",ws,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['haxe','php','javascript','dart','typescript']:
                ("class",ws_,C1,ws_,"extends",!,ws_,C2,ws,"{",!,ws,B,(Indent;ws),"}"),
        ['java','c#','scala']:
                ("public",ws_,"class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['c']:
                ("#include",ws_,"'",ws,C2,ws,".h'",ws_,B),
        ['c++']:
                ("class",ws_,C1,ws,":",ws,"public",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['perl 6']:
                ("class",ws_,C1,ws_,"is",ws_,C2,ws,"{",ws,B,(Indent;ws),"}"),
        ['monkey x']:
                ("Class",ws_,C1,ws_,"Extends",ws_,C2,ws_,B,(Indent;ws_),"End"),
        ['ruby']:
				("class",ws_,C1,ws_,"<<",ws_,C2,ws_,Body,(Indent;ws_),"end")
        ]).

abstract_class_(Data,[Name,Body,Indent]) -->
		langs_to_output(Data,abstract_class,[
			['java','c#']:
                ("public",ws_,"abstract",ws_,"class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
            ['php']:
                ("abstract",ws_,"class",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}")
        ]).

interface_(Data,[Name,Body,Indent]) -->
		langs_to_output(Data,interface,[
			['java','c#']:
                ("public",ws_,"interface",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
            ['php']:
                ("interface",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
            ['swift']:
                ("protocol",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}"),
            ['go']:
                ("type",ws_,Name,ws_,"interface",ws,"{",ws,Body,(Indent;ws),"}")
        ]).

interface_method_(Data,[Name,Type,Params,Indent]) -->
	langs_to_output(Data,interface_method,[
		['java','c#']:
			(Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,";"),
		['go']:
			(Name,ws,"(",ws,Params,ws,")",ws_,Type),
		['php']:
			("public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,";"),
		['swift']:
			("func",ws_,Name,ws,"(",Params,ws,")",ws,"->",ws,Type)
	]).

class_(Data,[Name,Body,Indent]) -->
		langs_to_output(Data,class,[
		['julia']:
                ("type",ws_,Name,ws_,Body,(Indent;ws_),"end"),
        ['ruby']:
                ("class",ws_,Name,ws_,Body,(Indent;ws_),"end"),
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
                ("class",ws_,Name,ws,"{",!,ws,Body,(Indent;ws),"}"),
        ['vbscript']:
                ("Public",ws_,"Class",ws_,Name,ws_,Body,(Indent;ws_),"End",ws_,"Class"),
        ['monkey x']:
                ("Class",ws_,Name,ws_,Body,(Indent;ws_),"End"),
        ['python']:
				("class",python_ws_,Name,python_ws,"(",python_ws,"object",python_ws,")",python_ws,":",Body)
        ]).


function_(Data,[Name,Type,Params,Body,Indent]) -->
		langs_to_output(Data,function,[
		['coffeescript']:
				(
					Name,python_ws,"=",python_ws,"(",python_ws,Params,python_ws,")",python_ws,"->",python_ws,Body;
					{Params = parameters(_,[])}, Name,python_ws,"=",python_ws,"->",python_ws,Body
				),
		['parboiled']:
				("Rule",ws_,Name,ws,"(",ws,")",ws,"{",ws,"return",ws_,Body,ws,";",!,ws_,"}"),
		['antlr']:
				(Name,ws,":",ws,Body,";"),
		['peg.js','lpeg','abnf']:
				(Name,ws,"=",ws,Body),
		['wirth syntax notation']:
				(Name,ws,"=",ws,Body,ws,"."),
		['marpa']:
				(Name,ws,"::=",ws,Body),
		['waxeye']:
				(Name,ws,"<-",ws,Body),
		['nearley']:
				(Name,ws,"[",ws,Params,ws,"]",ws,"->",ws,Body),
		['definite clause grammars']:
				(Name,ws,"(",ws,Params,ws,")",ws,"-->",ws,Body,ws,"."),
		['c++','vala','c','dart','ceylon','pike','d','englishscript']:
                (Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
		['systemverilog']:
				("function",ws_,Name,ws,"(",ws,Params,ws,");",ws,Body,(Indent;ws),"endfunction"),
        ['vhdl']:
				("function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,"return",ws_,Type,ws_,"is",ws_,"begin",ws_,Body,(Indent;ws_),"end",ws_,Name,ws,";"),
		['python','cython']:
				("def",python_ws_,Name,"(",Params,")",":",python_ws,Body),
		['english']:
				(("def";"func";"function"),python_ws_,Name,"(",Params,(")",python_ws,":";")"),python_ws,Body),
		['sympy']:
				("def",python_ws_,Name,"(",Params,")",":",python_ws,"return",python_ws_,Body),
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
                (Name,ws,"[",ws,Params,ws,"]",ws,"<=",ws,Body),
        ['java','c#']:
                ("public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['javascript','php']:
                ("function",ws_,Name,ws,"(",!,ws,Params,ws,")",ws,"{",!,ws,Body,(Indent;ws),"}"),
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
                ({Params = ""} -> (Name,ws,"(",ws,"Return",ws,")",ws_,":-",ws_,Body); (Name,ws,"(",ws,"(",ws,Params,ws,")",ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body)),
		['constraint handling rules']:
                ({Params = ""} -> (":- chr_constraint",ws_,Name,"/1",ws,".",ws_,Name,ws,"(",ws,"Return",ws,")",ws,"\\",Name,ws,"(",ws,"Return",ws,")","<=>true.",ws_,Name,ws,"(",ws,"Return",ws,")",ws_,"<=>",ws_,Body); (":- chr_constraint",ws_,Name,"/2",ws,".",ws_,Name,ws,"(",ws,"A",ws,",",ws,"B",ws,")",ws,"\\",ws,Name,ws,"(",ws,"A",ws,",",ws,"B",ws,")",ws_,"<=>",ws,"true",ws,".",ws_,Name,ws,"(",ws,"(",ws,Params,ws,")",ws,",",ws,"Return",ws,")",ws_,"<=>",ws_,Body)),
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
                (Name,python_ws_,Params,python_ws,"=",python_ws,"return",python_ws_,"where",python_ws,Body),
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
				(("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",!,ws,Body,(Indent;ws),"}")),
        ['perl 6']:
                ("sub",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['pawn']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['ruby']:
				(
					"def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
					{Params = parameters(_,[])},"def",ws_,Name,ws_,Body,(Indent;ws_),"end"
				),
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
                ("function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,";",!,ws,"begin",ws_,Body,(Indent;ws_),"end",ws,";")
        ]).

reserved_words(A) :-
	forall(member(B,["end","sin","cos","tan","abs","type","writeln","indexOf","charAt","gets","sample","array","readline","array_rand","input","random","choice","randrange","list","print","print_int","print_string","String","string","int","sort","sorted","reverse","sha1","reversed","len","unique_everseen","True","Number","float","double","return","def","str","char","boolean","function","false","true","enumerate"]),dif(A,B)).

var_name_(Data,Type,A) -->
        {Data = [Lang|_],reserved_words(A)},
        ({memberchk(Lang,['python','english','engscript','abnf','wirth syntax notation','marpa','antlr','definite clause grammars','peg.js', 'systemverilog', 'vhdl', 'visual basic .net', 'ruby', 'lua', 'cosmos', 'englishscript','vbscript','polish notation','reverse polish notation','wolfram','pseudocode','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','clojure','haxe','coffeescript','dart','javascript','c#','haskell','c','gambas','common lisp','scheme','rebol','f#'])}->
                symbol(A);
        {memberchk(Lang,['php','perl','bash','tcl','autoit','perl 6','puppet','hack','awk','powershell'])}->
                ({Lang='perl',Type=[array,_]}->
                    "@",symbol(A);
                {Lang='perl',Type=[dict,_]}->
                    "%",symbol(A);
                "$",symbol(A));
        {memberchk(Lang,[prolog,'constraint handling rules','erlang','picat',logtalk,pydatalog]),atom_string(B,A), first_char_uppercase(B, C),atom_chars(C,D)}->
            symbol(D);
        {memberchk(Lang,['lpeg'])}->
			("lpeg.V\"",A,"\"");
		{memberchk(Lang,['pddl','clips'])}->
			("?",A);
        {memberchk(Lang,['nearley'])}->
            ("$",symbol(A));
        {memberchk(Lang,['parboiled'])}->
            (symbol(A),"()");
        {not_defined_for(Data,'var_name')}),
        {is_var_type(Data, A, Type)},!.

else(Data,[Indent,A]) -->
        langs_to_output(Data,else,[
        ['sympy']:
				("(",ws,A,ws,",",ws,"True",ws,")"),
        ['clojure']:
                (":else",ws_,A),
        ['fortran']:
                ("ELSE",ws_,A),
        ['hack','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc']:
                ("else",ws,"{",!,ws,A,(Indent;ws),"}"),
        ['seed7','vhdl','ruby','lua','livecode','janus','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#']:
                ("else",ws_,A),
        ['erlang']:
                ("true",ws,"->",ws,A),
        ['wolfram','prolog']:
                (A),
        ['z3']:
                (A),
        ['cython','python']:
                (Indent,"else",python_ws,":",!,python_ws,A),
        ['english_temp']:
                (Indent,"else",python_ws,":",python_ws,A),
        ['monkey x','vbscript','visual basic .net']:
                ("Else",ws_,A),
        ['rebol']:
                ("true",ws,"[",ws,A,ws,"]"),
        ['common lisp']:
                ("(",ws,"t",ws_,A,ws,")"),
        ['pseudocode']:
                (("otherwise",ws_,A);
                ("else",ws_,A);
                ("else",ws,"{",!,ws,A,(Indent;ws),"}")),
        ['polish notation']:
                ("else",ws_,A),
        ['reverse polish notation']:
                (A,ws_,"else")
        ]).

enum_list_separator(Data) -->
        langs_to_output(Data,enum_list_separator,[
        ['pseudocode']:
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
        ['hy','ocaml','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure']:
                ws_,
        ['pseudocode','english','ruby','definite clause grammars','nearley','sympy','systemverilog','vhdl','visual basic .net','perl','constraint handling rules','lua','ruby','python','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic']:
                ","
        ]).
        
same_value_separator(Data) -->
        langs_to_output(Data,same_value_separator,[
        ['java','c#','perl']:
			"=",
		['haxe']:
			","
        ]).

varargs_(Data,[Type,Name]) -->
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

reference_parameter_(Data,[Type,Name]) -->
	langs_to_output(Data,reference_parameter,[
		['php']:
            ("&",Name),
        ['c#']:
            ("ref",ws_,Type,ws_,Name),
        ['visual basic']:
			("ByRef",ws_,Name,ws_,"As",ws_,Double),
		['c++']:
            (Type,ws_,"&",Name)
	]).

parameter_(Data,[Type,Name]) -->
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
        ['c#','systemverilog','java','englishscript','ceylon','algol 68','groovy','d','c++','pawn','pike','vala','c','janus']:
            (Type,ws_,Name),
        ['haxe','vhdl','dafny','chapel','pascal','rust','genie','hack','nim','typescript','gosu','delphi','nemerle','scala','swift']:
            (Name,ws,":",ws,Type),
        ['go','sql']:
            (Name,ws_,Type),
        ['minizinc']:
            ("var",ws_,Type,ws,":",ws,Name),
        ['haskell','definite clause grammars','nearley','sympy','pydatalog','python','english','ruby','lua','hy','perl 6','cosmos','polish notation','reverse polish notation','scheme','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','constraint handling rules','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','r','bc']:
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
            (Name),
        ['wolfram']:
            (Name,"_"),
        ['z3']:
            ("(",ws,Name,ws_,Type,ws,")")
        ]).

main_method_(Data,[Body,Indent]) -->
	langs_to_output(Data,main_method,[
		['java']:
			static_method_(Data, ["main",int,("String[] args"),Body,Indent])
	]).



enum_(Data,[Name,Body,Indent]) -->
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

import_(Data,[A]) -->
        langs_to_output(Data,import,[
        ['r']:
                ("source",ws,"(",ws,"\"",ws,A,ws,".",ws,"r\"",ws,")"),
        ['javascript']:
                ("import",ws_,"*",ws_,"as",ws_,A,ws_,"from",ws_,"'",ws,A,ws,"'",ws,";",!),
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
        ['lua','ruby']:
                ("require",ws_,"\"",ws,A,ws,"\""),
        ['c#','vala']:
                ("using",ws_,A,ws,";"),
        ['julia']:
                ("using",ws_,A),
        ['haskell','purescript','engscript','scala','go','groovy','picat','elm','swift','monkey x']:
                ("import",ws_,A),
        :
                ("import",ws_,A,ws,";"),
        ['dart']:
                ("import",ws_,"'",ws,A,ws,".dart'",ws,";"),
        ['perl','perl 6','chapel']:
                ("\"use",ws,A,ws,";\"")
        ]).


comment_(Data,[A]) -->
	langs_to_output(Data,comment,[
	['java','javascript','c','c#','c++','php','perl','swift']:
		("//",A),
	['cython','perl','octave','ruby']:
		("#",A),
	['lua','haskell','vhdl']:
		("--",A),
	['ocaml']:
		("(*",A,"*)"),
	['prolog','constraint handling rules','erlang','txl']:
		("%",A),
	['visual basic','visual basic .net']:
		("'",A)
    ]).

first_case_(Data,[B,Compare_expr,Expr,Case_or_default]) -->
    langs_to_output(Data,first_case,[
    ['julia',octave]:
            ("if",ws_,Compare_expr,ws_,"then",ws_,B,ws_,Case_or_default),
    ['javascript','d','java','c#','c','c++','typescript','dart','php',hack]:
			("case",ws_,Expr,ws,":",!,ws,B,ws,"break",ws,";",!,ws,Case_or_default),
    [go,'haxe',swift]:
            ("case",ws_,Expr,ws,":",ws,B,ws,Case_or_default),
    ['fortran']:
            ("CASE",ws,"(",ws,Expr,ws,")",ws_,B),
    [rust]:
            (Expr,ws,"=>",ws,"{",ws,B,ws,Case_or_default,(Indent;ws),"}"),
    [haskell,'erlang','elixir',ocaml]:
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

case(Data,[A,B,Expr,Case_or_default,Indent]) -->
    langs_to_output(Data,case,[
    ['julia',octave]:
            ("elsif",ws_,A,ws_,"then",ws_,B,ws,Case_or_default),
    ['javascript','d','java','c#','c','c++','typescript','dart','php','hack']:
            ("case",ws_,Expr,ws,":",!,ws,B,ws,"break",ws,";",!,ws,Case_or_default),
    [go,'haxe',swift]:
            ("case",ws_,Expr,ws,":",ws,B,ws,Case_or_default),
    ['fortran']:
            ("CASE",ws,"(",ws,Expr,ws,")",ws_,B,ws,Case_or_default),
    [rust]:
            (Expr,ws,"=>",ws,"{",ws,B,(Indent;ws),"}",ws,Case_or_default),
    [haskell,'erlang','elixir',ocaml]:
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


default(Data,[A,Indent]) -->
        langs_to_output(Data,default,[
        ['fortran']:
            ("CASE",ws_,"DEFAULT",ws_,A),
        ['javascript','d','c','java','c#','c++','typescript','dart','php','haxe','hack','go','swift']:
            ("default",ws,":",!,ws,A),
        ['pascal','delphi']:
            ("else",ws_,A),
        ['haskell','erlang','ocaml']:
            ("_",ws,"->",ws_,A),
        ['rust']:
            ("_",ws,"=>",ws,A),
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
            ("_",ws,",",ws,A)
        ]).


elif(Data,[Indent,A,B]) -->
        langs_to_output(Data,elif,[
        ['sympy']:
			("(",ws,B,ws,",",ws,A,ws,")"),
        ['d','e','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe']:
            ("else",ws_,"if",ws,"(",!,ws,A,ws,")",!,ws,"{",!,ws,B,(Indent;ws),"}"),
        ['rust','go','englishscript']:
            ("else",ws_,"if",ws_,A,ws,"{",!,ws,B,(Indent;ws),"}"),
        ['php','hack','perl']:
            ("elseif",ws,"(",ws,A,ws,")",ws,"{",!,ws,B,(Indent;ws),"}"),
        ['julia','octave']:
            ("elseif",ws_,A,ws_,B),
        ['ruby','seed7','vhdl']:
			("elsif",ws_,A,ws_,"then",ws_,B),
		['lua','picat']:
			("elseif",ws_,A,ws_,"then",ws_,B),
        ['monkey x','visual basic','visual basic .net']:
            ("ElseIf",ws_,A,ws_,B),
        ['perl 6']:
            ("elsif",ws_,A,ws_,"{",ws,B,(Indent;ws),"}"),
        ['picat']:
            ("elseif",ws_,A,ws_,"then",ws_,B),
        ['prolog','logtalk','erlang','constraint handling rules']:
            (A,ws,"->",ws,B),
        ['r','f#']:
            (A,ws,"<-",ws,B),
        ['minizinc','ocaml','haskell','pascal','maxima','delphi','f#','livecode']:
            ("else",ws_,"if",ws_,A,ws_,"then",ws_,B),
        ['cython','python']:
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
        ]),!.

default_parameter_(Data,[Type,Name,Value]) -->
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
        ]),!.

%generate a random integer from Min (inclusive) to Max (exclusive)
random_int_in_range(Data,[Min,Max]) -->
	langs_to_output(Data,random_int_in_range,[
		['python']:
			("randrange",python_ws,"(",python_ws,Min,python_ws,",",python_ws,Max,python_ws,")"),
		['javascript']:
			("(",ws,"Math",ws,".",ws,"floor",ws,"(",ws,"Math",ws,".",ws,"random",ws,"(",ws,")",ws,"*",ws,"(",ws,Max,ws,"-",ws,Min,ws,"+",ws,"1",ws,")",ws,"+",ws,Min,ws,")"),
		['php']:
			("rand",ws,"(",ws,Min,ws,",",ws,Max,ws,"-",ws,"1",ws,")")
	]),!.

%generate a random integer from Min (inclusive) to Max (inclusive)
random_int_in_inclusive_range(Data,[Min,Max]) -->
	langs_to_output(Data,random_int_in_inclusive_range,[
		['php']:
			("rand",ws,"(",ws,Min,ws,",",ws,Max,ws,")")
	]).

%see https://www.rosettacode.org/wiki/Pick_random_element
random_from_list(Data,[Arr]) -->
	langs_to_output(Data,random_from_list,[
		['python']:
			("random",python_ws,".",python_ws,"choice",python_ws,"(",python_ws,Arr,python_ws,")"),
		['php']:
			("array_rand",ws,"(",ws,Arr,ws,")"),
		['julia']:
			("rand",ws,"(",ws,Arr,ws,")"),
		['wolfram']:
			("RandomChoice",ws,"[",ws,Arr,ws,"]"),
		['ruby']:
			(Arr,ws,".",ws,"sample"),
		['perl 6']:
			(Arr,ws,".",ws,"pick"),
		['javascript','coffeescript']:
			(Arr,python_ws,"[Math.floor(Math.random()*",python_ws,Arr,python_ws,".length)]"),
		['perl']:
			("$",ws,Arr,ws,"[",ws,"rand",ws,"@",ws,Arr,ws,"]"),
		['clojure']:
			("(",ws,"rand-nth",ws_,Arr,ws,")"),
		['d']:
			(Arr,ws,"[uniform(0,$)]")
	]).

random_number(Data) -->
	langs_to_output(Data,random_number,[
		['javascript','java','typescript','haxe']:
			("Math",ws,".",ws,"random",ws,"(",ws,")"),
		['python']:
			("random",python_ws,".",python_ws,"random",python_ws,"(",python_ws,")"),
		['php']:
			("lcg_value",ws,"(",ws,")"),
		['perl','ruby']:
			("rand",ws,"(",ws,")")
		
	]),!.

type(Data,auto_type) -->
        langs_to_output(Data,auto_type,[
        ['c++']:
                "auto",
        ['c']:
                "__auto_type",
        ['java','gnu smalltalk']:
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
        ['cython','python']:
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
        ['cython']:
                "dict",
        ['javascript','java']:
                "Object",
        ['c']:
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
        ['hack','python','systemverilog','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','hy','java','c#','c','c++','vala','nemerle']:
                "int",
        ['php','vhdl','prolog','constraint handling rules','common lisp','picat']:
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
                "fixnum"
        ]).

type(Data,string) -->
    langs_to_output(Data,string,[
    ['z3','ruby','cosmos','visual basic .net','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','monkey x']:
            "String",
    ['vala','systemverilog','seed7','octave','picat','mathematical notation','polish notation','reverse polish notation','prolog','constraint handling rules','d','chapel','minizinc','genie','hack','nim','algol 68','typescript','coffeescript','octave','tcl','awk','julia','c#','f#','perl','javascript','go','php','c++','nemerle','erlang']:
            "string",
    ['c']:
            "char*",
    ['rebol']:
            "string!",
    ['fortran']:
            "CHARACTER","(","LEN","=","*",")",
    ['hy','python']:
            "str",
    ['pseudocode']:
            ("str";"string";"String";"char*";"string!")
    ]).

type(Data,char) -->
    langs_to_output(Data,char,[
		['java','c','c#','c++']:
			"char",
		['javascript']:
			"String"
    ]).

type(Data, bool) -->
    langs_to_output(Data,bool,[
    ['typescript','vhdl','seed7','hy','python','java','javascript','perl']:
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
    ['engscript','thrift','seed7','php','hy','cython','go','pike','objective-c','java','c','c++','c#','vala','typescript','d','javascript','dart']:
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
        ['minizinc','php','python']:
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

% https://rosettacode.org/wiki/Arrays
type(Data,[array,Type]) -->
    {ground(Type)}, %Type contains no unknown variables
    langs_to_output(Data,array,[
    ['java','c','c++','c#','typescript']:
            (type(Data,Type),"[]"),
    ['go']:
            ("[]", type(Data,Type)),
    ['cython','python']:
            "list",
    ['haxe','swift']:
			("Array<",type(Data,Type),">"),
    ['visual basic .net']:
            (type(Data,Type),"()"),
    ['javascript','cosmos']:
            "Array"
    ]).

concatenate_string_to_int_(Data,[A,B]) -->
	langs_to_output(Data,conatenate_string_to_int,[
	['java','javascript','perl','c#','julia','lua']:
		concatenate_string_(Data,[A,B]),
	['python_temp','ruby','c++','swift','php']:
		concatenate_string_(Data,[A,type_conversion_(Data,[int,string,B])])
    ]).

concatenate_int_to_string_(Data,[A,B]) -->
	langs_to_output(Data,conatenate_int_to_string,[
	['java','javascript','perl','c#','julia','lua']:
		concatenate_string_(Data,[A,B]),
	['python_temp','ruby','c++','swift','php']:
		concatenate_string_(Data,[type_conversion_(Data,[int,string,A]),B])
    ]).

grammar_statement_(Data,[Name,Body]) -->
	langs_to_output(Data,grammar_statement,[
	['pegjs']:
		(Name,ws,"=",ws,Body)
    ]).

grammars(['marpa','abnf','waxeye','nearley','antlr','peg.js','definite clause grammars','parslet','lpeg','ometa','parboiled','wirth syntax notation']).

statement_separator(Data) -->
    {offside_rule_langs(Offside_rule_langs)},langs_to_output(Data,statement_separator,[
    ['marpa','abnf','wirth syntax notation','parboiled','waxeye','nearley','antlr','peg.js','definite clause grammars','parslet']:
			ws_,
    ['pydatalog','pddl','visual basic .net','lua','ruby','hy','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','z3','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','go','awk','haskell','r','visual basic']:
            ws_,
    Offside_rule_langs:
			"",
    ['java','vhdl','c','pseudocode','perl 6','haxe','javascript','c++','c#','php','dart','actionscript','typescript','processing','vala','bc','ceylon','hack','perl']:
            ws,
    ['wolfram']:
            ";",
    ['picat','lpeg','prolog','constraint handling rules','logtalk','erlang','lpeg']:
            ",",
    ['gnu smalltalk']:
            (".",ws_)
    ]).

initializer_list_separator(Data) -->
    langs_to_output(Data,initializer_list_separator,[
    ['ruby','r','constraint handling rules','english','lua','cython','python','visual basic .net','cosmos','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','pseudocode','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift','java','picat','c#','go','c++','c','visual basic','php','scala','perl','wolfram']:
            ",",
    ['rebol']:
            ws_,
    ['ocaml']:
			%this is the separator for arrays and lists in OCaml
            ";",
    ['pseudocode']:
            (",";";")
    ]).

key_value_separator(Data) -->
    langs_to_output(Data,key_value_separator,[
    ['python','english_temp','cosmos','lua','prolog','picat','go','dart','d','c#','frink','swift','javascript','typescript','php','perl','julia','haxe','c++','scala','octave','elixir','wolfram']:
            ",",
    ['pseudocode']:
            (",";";"),
    ['rebol','gnu smalltalk']:
            ws_
    ]).


enum_list_(Data,[A]) -->
			langs_to_output(Data,enum_list_,[
			['java','seed7','vala','perl 6','swift','c++','c#','haxe','fortran','typescript','c','ada','scala']:
					(A),
			['go']:
					(A,ws,"=",ws,"iota")
			]).

top_level_statement_(Data,A) -->
    {Data = [Lang|_]},
    ({memberchk(Lang,['prolog','erlang','picat','logtalk','constraint handling rules'])}->
        A,".";
    {memberchk(Lang,['minizinc'])}->
        A,";";
    A).
% see rosettacode.org/wiki/Regular_expressions
regex_literal_(Data,[S]) -->
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

include_in_each_file(Data) -->
    langs_to_output(Data,include_in_each_file,[
    ['c']:
		"#include<stdio.h>\n#include<math.h>",
    ['prolog','constraint handling rules']:
        (":- initialization(main).\n:- set_prolog_flag(double_quotes, chars).\n:- use_module(library(clpfd)).\n:- use_module(library(func))."),
    ['perl']:
        "use strict;\nuse warnings;",
	['haxe']:
		"using StringTools;",
	['java']:
		"import java.util.ArrayList;\nimport java.util.Collections;",
	['python']:
		"",
	['sympy']:
		"from sympy import *"
    ]),"\n";"".

% spelled backwards
% reverse a string (not in-place)
% see https://www.rosettacode.org/wiki/Reverse_a_string
reverse_string_(Data,[Str]) -->
        langs_to_output(Data,reverse_string,[
        ['java']:
                ("new",ws_,"StringBuilder",ws,"(",ws,Str,ws,")",ws,".",ws,"reverse",ws,"(",ws,")",ws,".",ws,"toString",ws,"(",ws,")"),
        %this one has been verified to work correctly
        %see http://perldoc.perl.org/functions/reverse.html
        ['perl']:
                ("(",ws,"scalar",ws_,"reverse",ws,"(",Str,")",ws,")"),
        ['php']:
                ("strrev",ws,"(",ws,Str,ws,")"),
        ['english']:
				("(",Str,python_ws_,("spelled";"written"),python_ws_,("backwards";"backward"),")"),
        ['javascript']:
                ("esrever",ws,".",ws,"reverse",ws,"(",ws,Str,ws,")"),
        ['common lisp','haskell']:
				("(",ws,"reverse",ws_,Str,ws,")"),
		%the next one still doesn't work correctly with this parser
		['python_temp']:
				(Str,"[::-1]")
        ]).

key_value_(Data,[A,B]) -->
        langs_to_output(Data,key_value,[
        ['groovy','english_temp','d','dart','javascript','typescript','coffeescript','swift','elixir','swift','go']:
                (A,ws,":",!,ws,B),
        ['python']:
                ("\"",python_ws,A,python_ws,"\"",python_ws,":",python_ws,B),
        ['php','haxe','perl','ruby','julia']:
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
        ['prolog']:
                (A,ws,"-",ws,B)
        ]).

array_slice_(Data,[A,B,C]) -->
        langs_to_output(Data,array_slice,[
            ['cython']:
                (A,python_ws,"[",python_ws,B,python_ws,":",python_ws,C,python_ws,"]")
        ]).

compare_(Data,string,[A,B]) -->
    langs_to_output(Data,compare_string,[
    ['r']:
            ("identical",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['emacs lisp']:
            ("(",ws,"string=",ws_,A,ws_,B,ws,")"),
    ['clojure']:
            ("(",ws,"=",ws_,A,ws_,B,ws,")"),
    ['visual basic','delphi','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x']:
            (A,ws,"=",ws,B),
    ['pydatalog','ruby','lua','perl 6','python','cython','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','swift']:
            (A,python_ws,"==",python_ws,B),
    ['javascript','php','typescript','hack']:
            (A,ws,"===",ws,B),
    ['english']:
            (A,ws,synonym("="),ws,B),
    ['c','octave']:
            ("strcmp",ws,"(",ws,A,ws,",",ws,B,ws,")",ws,"==",ws,"0"),
    ['c++','systemverilog']:
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

compare_(Data,bool,[Exp1,Exp2]) -->
        langs_to_output(Data,compare_bool,[
        ['nim','z3py','pydatalog','e','ceylon','cython','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (Exp1,("=="),Exp2),
        ['javascript','php']:
                (Exp1,("===";"=="),Exp2),
        ['prolog']:
                (Exp1,"=",Exp2)
        ]).

compare_(Data,int,[Var1,Var2]) -->
        langs_to_output(Data,compare_int,[
        ['r']:
                ("identical",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")"),
        ['sympy']:
                ("Eq",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")"),
        ['nim','cython','lua','python','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (Var1,python_ws,"==",python_ws,Var2),
        ['english']:
                (Var1,python_ws,synonym("="),python_ws,Var2),
        ['javascript','php','typescript','hack']:
                (Var1,ws,"===",ws,Var2),
        ['z3','emacs lisp','common lisp','clips','racket']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['fortran']:
                (Var1,ws,".eq.",ws,Var2),
        ['maxima','seed7','monkey x','gap','rebol','f#','autoit','pascal','delphi','visual basic','ocaml','livecode','vbscript']:
                (Var1,ws,"=",ws,Var2),
        ['prolog']:
                (Var1,ws,("#=","=";"=:="),ws,Var2),
        ['clojure']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['reverse polish notation']:
                (Var1,ws_,Var2,ws_,"="),
        ['polish notation']:
                ("=",ws_,Var1,ws_,Var2)
        ]).

less_than_(Data,[A,B]) -->
		{prefix_arithmetic_langs(Prefix_arithmetic_langs),infix_arithmetic_langs(Infix_arithmetic_langs)},
        langs_to_output(Data,less_than,[
		Infix_arithmetic_langs:
                (infix_operator("<",A,B)),
        ['english']:
                (
					infix_operator("<",A,B);
					A,python_ws_,"is",python_ws_,synonym("less"),python_ws_,"than",python_ws_,B
				),
        Prefix_arithmetic_langs:
                ("(",ws,"<",ws_,A,ws_,B,ws,")")
        ]).

%alphabetical string comparison
string_less_than_(Data,[A,B]) -->
        langs_to_output(Data,less_than,[
		['c++','python']:
                (infix_operator("<",A,B))
        ]).

%alphabetical string comparison
string_greater_than_(Data,[A,B]) -->
        langs_to_output(Data,less_than,[
		['c++','python']:
                (infix_operator(">",A,B))
        ]).

less_than_or_equal_to_(Data,[A,B]) -->
		{prefix_arithmetic_langs(Prefix_arithmetic_langs),infix_arithmetic_langs(Infix_arithmetic_langs)},
        langs_to_output(Data,less_than_or_equal,[
        ['pascal','sympy','vhdl','python','elixir','visual basic .net','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                infix_operator("<=",A,B),
        ['prolog']:
            (A,ws,("#=<";"=<"),ws,B),
        ['english']:
			(
				A,python_ws_,("is",python_ws_,synonym("less"),python_ws_,"than",python_ws_,"or",python_ws_,"equal",python_ws_,"to";
				"is",python_ws_,"not",python_ws_,synonym("more"),python_ws_,"than"),python_ws_,B
			),
        Prefix_arithmetic_langs:
				("(",ws,"<=",ws_,A,ws_,B,")")
        ]).

greater_than_or_equal_to_(Data,[A,B]) -->
		{prefix_arithmetic_langs(Prefix_arithmetic_langs),infix_arithmetic_langs(Infix_arithmetic_langs)},
        langs_to_output(Data,'greater_than_or_equal',[
        ['pascal','sympy','vhdl','elixir','visual basic .net','python','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (A,ws,">=",ws,B),
        ['prolog']:
                (A,ws,("#>=";">="),ws,B),
        Prefix_arithmetic_langs:
				("(",ws,">=",ws_,A,ws_,B,")")
        ]).

greater_than_(Data,[A,B]) -->
		{prefix_arithmetic_langs(Prefix_arithmetic_langs),infix_arithmetic_langs(Infix_arithmetic_langs)},
        langs_to_output(Data,'greater_than',[
		Infix_arithmetic_langs:
                (infix_operator(">",A,B)),
        ['english']:
                (
					infix_operator(">",A,B);
					A,python_ws_,"is",python_ws_,synonym("greater"),python_ws_,"than",python_ws_,B
				),
		Prefix_arithmetic_langs:
                ("(",ws,">",ws_,A,ws_,B,ws,")")
        ]).

universal_quantification_(Data,Variable,Array,Compare_each_to,[English_expr,Output_Expr]) -->
		{Data=[Lang|_],prefix_arithmetic_langs(Prefix_arithmetic_langs),infix_arithmetic_langs(Infix_arithmetic_langs)},
		({Lang='english'}->
			(Array,python_ws_,"are",python_ws_,English_expr,python_ws_,Compare_each_to);
		({unique_var(Variable)},all_true_(Data,[Variable,Array,Output_Expr]))).

coordinating_conjunction_(Data,int,[Variable,Compare_each_to,Outputs]) :-
	Outputs=[("not",python_ws_,"equal",python_ws_,"to"),
			int_not_equal_(Data,[Variable,Compare_each_to])].

coordinating_conjunction_(Data,int,[Variable,Compare_each_to,Outputs]) :-
	Outputs=[("equal",python_ws_,"to"),
			compare_int_(Data,[Variable,Compare_each_to])].

coordinating_conjunction_(Data,int,[Variable,Compare_each_to,Outputs]) :-
	Outputs=[("less",python_ws_,"than"),
			less_than_(Data,[Variable,Compare_each_to])].
	
coordinating_conjunction_(Data,int,[Variable,Compare_each_to,Outputs]) :-
	Outputs=[(synonym("greater"),python_ws_,"than"),
			greater_than_(Data,[Variable,Compare_each_to])].

coordinating_conjunction(Data,Conjunction,int,[Variable,[Compare_each_to]]) -->
	{coordinating_conjunction_(Data,int,[Variable,parentheses_expr(Data,int,Compare_each_to),[English_expr,Output_expr]])},
	({Data=['english'|_]}->
		English_expr,python_ws_,parentheses_expr(Data,int,Compare_each_to));
	greater_than_(Data,[Variable,parentheses_expr(Data,int,Compare_each_to)]).

coordinating_conjunction(Data,'or',int,[Variable,[A|B]]) -->
		coordinating_conjunction(Data,'or',int,[Variable,[A]])," or ",
		coordinating_conjunction(Data,'or',int,[Variable,B]).

coordinating_conjunction(Data,'and',int,[Variable,[A|B]]) -->
		coordinating_conjunction(Data,'and',int,[Variable,[A]])," and ",
		coordinating_conjunction(Data,'and',int,[Variable,B]).




coordinating_conjunctions(Data,Conjunction,int,[Variable,Vars]) -->
	{Data=['english'|_]} ->
	Variable,python_ws_,"is",python_ws_,coordinating_conjunction(Data,Conjunction,int,[Variable,Vars]);
	coordinating_conjunction(Data,Conjunction,int,[Variable,Vars]).

universal_quantifications_(Data,int,[Array,Compare_each_to,English_expr]) -->
	coordinating_conjunction_(Data,int,[Variable,Compare_each_to,[English_expr,Output_expr]]),
	universal_quantification_(
		Data,
		Variable,
		Array,
		Compare_each_to,
		[English_expr,Output_expr]
	),{writeln('Translated with the universal_quantifications_ predicate')}.

string_not_equal_(Data,[A,B]) -->
	langs_to_output(Data,string_not_equal,[
		['python']:
			(infix_operator("!=",A,B)),
		['javascript','php']:
			(infix_operator("!==",A,B)),
		['english']:
				(A,python_ws_,synonym("does not equal"),python_ws_,B),
		['java']:
				("!",A,ws,".",ws,"equals",ws,"(",ws,B,ws,")"),
		['perl']:
				(A,ws_,"ne",ws_,B)
	]).

int_not_equal_(Data,[A,B]) -->
        langs_to_output(Data,int_not_equal,[
        ['english']:
				(A,ws_,synonym("does not equal"),ws_,B),
        ['javascript','php',elixir]:
                (infix_operator(("!==";"!="),A,B)),
        ['java','ruby','python','cosmos','nim','octave','r','picat','englishscript','perl 6','wolfram','c','c++','d','c#','julia','perl','haxe','cython','minizinc','scala','swift','go','rust','vala']:
                (infix_operator("!=",A,B)),
        ['rebol','scriptol','seed7','visual basic','visual basic .net','gap','ocaml','livecode','monkey x',vbscript,delphi]:
                (infix_operator("<>",A,B)),
        ['prolog']:
                ("(",ws,A,ws,"#\\=",ws,B,ws,")";"dif",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['common lisp',z3]:
                ("(",ws,"not",ws,"(",ws,"=",ws_,A,ws_,B,")",ws,")")
        ]).

pow_(Data,[A,B]) -->
    langs_to_output(Data,pow,[
    ['javascript','java','typescript','haxe','actionscript']:
            ("Math",ws,".",ws,"pow",ws,"(",!,ws,A,ws,",",ws,B,ws,")"),
    ['coffeescript']:
			("Math",python_ws,".",python_ws,"pow",python_ws,"(",python_ws,A,python_ws,",",python_ws,B,python_ws,")"),
    ['seed7','ruby','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran']:
            (A,python_ws,"**",python_ws,B),
	['python','cython']:
            (
				A,python_ws,"**",python_ws,B;
				"math",python_ws,".",python_ws,"pow(",A,python_ws,",",B,python_ws,")"
			),
    ['english']:
            (
				A,python_ws,("**";"^"),python_ws,B;
				A,python_ws_,"to",python_ws_,"the",python_ws,"power",python_ws_,"of",python_ws_,B
			),
    ['scala']:
            ("scala.math.pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['c#']:
            ("Math",ws,".",ws,"Pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['rebol']:
            ("power",ws_,A,ws_,B),
    ['c','c++','php','hack','swift','minizinc','dart','d']:
            ("pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['julia','lua','engscript','visual basic','gambas','go','ceylon','wolfram','mathematical notation']:
            (A,ws,"^",ws,B),
    ['hy','common lisp','racket','clojure']:
            ("(",ws,"expt",ws_,A,ws_,B,ws,")"),
    ['erlang']:
            ("math",ws,":",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")")
    ]).

sqrt(Data,[X]) -->
        langs_to_output(Data,sqrt,[
        ['livecode']:
                ("(",ws,"the",ws_,"sqrt",ws_,"of",ws_,X,ws,")"),
        ['java','javascript','typescript','haxe','ruby']:
                ("Math",ws,".",ws,"sqrt",ws,"(",!,ws,X,ws,")"),
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
        ['english_temp']:
                ("(","square",python_ws_,"root",python_ws_,"of",python_ws_,X,")"),
        ['go']:
                ("math",ws,".",ws,"Sqrt",ws,"(",ws,X,ws,")")
        ]).

list_comprehension_(Data,[Variable,Array,Result,Condition]) -->
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

%list comprehension without condition
list_comprehension_1_(Data,[Var,Array,Result]) -->
        langs_to_output(Data,list_comprehension_1,[
        ['cython','python']:
                ("[",python_ws,Result,python_ws_,"for",python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,"]"),
        ['php']:
				("array_map",ws,"(",ws,"function",ws,"(",ws,Var,ws,")",ws,"{",ws,"return",ws,Result,ws,";",ws,"}",ws,",",ws,Array,ws,")")
        ]).

%list comprehension without condition
all_true_(Data,[Var,Array,Condition]) -->
        langs_to_output(Data,all_true,[
        ['cython','python']:
                ("all",python_ws,"(",python_ws,Condition,python_ws_,"for",python_ws_,Var,python_ws_,"in",python_ws_,Array,python_ws,")")
        ]).

startswith_(Data,[Str1,Str2]) -->
        langs_to_output(Data,startswith,[
        ['python']:
                (Str1,python_ws,".",python_ws,"startswith",python_ws,"(",python_ws,Str2,python_ws,")"),
        ['ruby']:
                (Str1,ws,".",ws,"start_with?",ws,"(",ws,Str2,ws,")"),
        ['java','javascript']:
                (Str1,ws,".",ws,"startsWith",ws,"(",!,ws,Str2,ws,")"),
        ['english_temp']:
                (Str1,ws_,("starts";"begins"),ws_,"with",ws_,Str2),
        ['swift']:
                (Str1,ws,".",ws,"hasPrefix",ws,"(",ws,Str2,ws,")"),
        ['go']:
                ("strings",ws,".",ws,"hasPrefix",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['haxe']:
                ("StringTools",ws,".",ws,"startsWith",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['c#','f#']:
                (Str1,ws,".",ws,"StartsWith",ws,"(",ws,Str2,ws,")"),
        ['julia']:
                ("startswith",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['haskell']:
                ("(",ws,"isPrefixOf",ws_,Str1,ws_,Str2,ws,")"),
        ['c']:
                ("(",ws,"strncmp",ws,"(",ws,Str1,ws,",",ws,Str2,ws,",",ws,"strlen",ws,"(",ws,Str2,ws,")",ws,")",ws,"==",ws,"0",ws,")")
        ]).

endswith_(Data,[Str1,Str2]) -->
        langs_to_output(Data,endswith,[
        ['java','javascript']:
                (Str1,ws,".",ws,"endsWith",ws,"(",!,ws,Str2,ws,")"),
        ['ruby']:
                (Str1,ws,".",ws,"end_with?",ws,"(",ws,Str2,ws,")"),
        ['swift']:
                (Str1,ws,".",ws,"hasSuffix",ws,"(",ws,Str2,ws,")"),
        ['haxe']:
                ("StringTools",ws,".",ws,"endsWith",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['go']:
                ("strings",ws,".",ws,"hasSuffix",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['julia']:
                ("endswith",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['haskell']:
                ("(",ws,"isSuffixOf",ws_,Str1,ws_,Str2,ws,")"),
        ['cython','python']:
                (Str1,python_ws,".",python_ws,"endswith",python_ws,"(",python_ws,Str2,python_ws,")"),
        ['c#','f#']:
                (Str1,ws,".",ws,"EndsWith",ws,"(",ws,Str2,ws,")")
        ]).

%remove extra whitespace at beginning and end of string
% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
trim_(Data,[Str]) -->
        langs_to_output(Data,trim,[
        ['java','javascript']:
                (Str,ws,".",ws,"trim",ws,"(",!,ws,")"),
        ['c#']:
                (Str,ws,".",ws,"Trim",ws,"(",ws,")"),
        ['python']:
                (Str,python_ws,".",python_ws,"strip",python_ws,"(",python_ws,")"),
        ['perl 6']:
                (Str,ws,".",ws,"trim"),
        ['ruby']:
                (Str,ws,".",ws,"strip"),
        ['php']:
            ("trim",ws,"(",ws,Str,ws,")"),
        ['clojure']:
            ("(",ws,".trim",ws_,Str,ws,")"),
        ['ocaml']:
            ("(",ws,"String.trim",ws_,Str,ws,")"),
        ['elixir']:
                ("String",python_ws,".",python_ws,"strip",python_ws,"(",python_ws,Str,python_ws,")"),
        ['lua']:
				(Str,ws,":match(\"^%s*(.-)%s*$\")"),
		['erlang']:
				("string:strip",ws,"(",ws,Str,",",ws,"both",ws,")"),
		['common lisp']:
				("(",ws,"string-trim",ws_,Str,ws,")")
        ]).

% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
lstrip_(Data,[Str]) -->
        langs_to_output(Data,lstrip,[
        ['python']:
                (Str,python_ws,".",python_ws,"lstrip",python_ws,"(",python_ws,")"),
        ['ruby']:
                (Str,ws,".",ws,"lstrip"),
        ['c#']:
                (Str,ws,".",ws,"TrimStart",ws,"(",ws,")"),
        ['php']:
                ("ltrim",python_ws,"(",python_ws,Str,ws,")"),
        ['elixir']:
                ("String",python_ws,".",python_ws,"lstrip",python_ws,"(",python_ws,Str,python_ws,")"),
        ['javascript']:
				(Str,ws,".replace(/^\s+/,'')"),
		['erlang']:
				("string:strip",ws,"(",ws,Str,",",ws,"left",ws,")"),
		['common lisp']:
				("(",ws,"string-left-trim",ws_,Str,ws,")")
        ]).

% see https://www.rosettacode.org/wiki/Strip_whitespace_from_a_string
rstrip_(Data,[Str]) -->
        langs_to_output(Data,rstrip,[
        ['python']:
                (Str,python_ws,".",python_ws,"rstrip",python_ws,"(",python_ws,")"),
        ['ruby']:
                (Str,ws,".",ws,"rstrip"),
        ['c#']:
                (Str,ws,".",ws,"TrimEnd",ws,"(",ws,")"),
        ['php']:
                ("rtrim",python_ws,"(",python_ws,Str,ws,")"),
        ['elixir']:
                ("String",python_ws,".",python_ws,"rstrip",python_ws,"(",python_ws,Str,python_ws,")"),
        ['javascript']:
				(Str,ws,".replace(/\s+$/,'')"),
		['erlang']:
				("string:strip",ws,"(",ws,Str,",",ws,"right",ws,")"),
		['common lisp']:
				("(",ws,"string-right-trim",ws_,Str,ws,")")
        ]).

lowercase_(Data,[Str]) -->
        langs_to_output(Data,lowercase,[
        ['java','javascript','haxe','typescript']:
                (Str,ws,".",ws,"toLowerCase",ws,"(",!,ws,")"),
        ['c#']:
                (Str,ws,".",ws,"ToLower",ws,"(",ws,")"),
        ['systemverilog']:
				(Str,ws,".",ws,"tolower",ws,"(",ws,")"),
        ['perl']:
                ("lc",ws,"(",ws,Str,ws,")"),
        ['seed7','r','erlang']:
                ("tolower",ws,"(",ws,Str,ws,")"),
        ['mathematica']:
                ("ToLowerCase",ws,"[",ws,Str,ws,"]"),
        ['freebasic']:
                ("lcase",ws,"(",ws,Str,ws,")"),
        ['php']:
                ("strtolower",ws,"(",ws,Str,ws,")"),
        ['python']:
				(Str,".",python_ws,"lower",python_ws,"(",python_ws,")"),
		['ruby']:
				(Str,ws,".",ws,"downcase"),
		['lua']:
				("string",ws,".",ws,"lower",ws,"(",ws,Str,ws,")")
        ]).

array_contains(Data,[Container,Contained]) -->
        langs_to_output(Data,array_contains,[
        ['python','julia','minizinc']:
                (Contained,python_ws_,"in",python_ws_,Container),
        ['english_temp']:
                (
					Contained,python_ws_,("in";"is",python_ws_,"in"),python_ws_,Container;
					Container,python_ws_,"contains",python_ws_,Contained
				),
        ['swift']:
                ("contains",ws,"(",ws,Container,ws,",",ws,Contained,ws,")"),
        ['prolog']:
                ("member",ws,"(",ws,Contained,ws,",",ws,Container,ws,")"),
        ['lua']:
                (Container,ws,"[",ws,Contained,ws,"]",ws,"~=",ws,"nil"),
        ['rebol']:
                ("not",ws_,"none?",ws_,"find",ws_,Container,ws_,Contained),
        ['javascript','coffeescript','typescript']:
                ("(",ws,Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!==",ws,"-1",ws,")";
                Container,ws,".",ws,"includes",ws,"(",ws,Contained,ws,")"),
        ['coffeescript']:
                (Contained,ws_,"in",ws_,Container;Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!=",ws,"-1"),
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

%Str1 contains Str2
string_contains_(Data,[Str1,Str2]) -->
        langs_to_output(Data,string_contains,[
        ['c']:
                ("(",ws,"strstr",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"NULL",ws,")"),
        ['python']:
				(Str2,python_ws_,"in",python_ws_,Str1),
        ['java']:
                (Str1,ws,".",ws,"contains",ws,"(",ws,Str2,ws,")"),
        ['lua']:
                ("str",ws,".",ws,"contains",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")"),
        ['c#']:
                (Str1,ws,".",ws,"Contains",ws,"(",ws,Str2,ws,")"),
        ['perl']:
                ("(",ws,"index",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"-1",ws,")"),
        ['javascript']:
                ("(",ws,Str1,ws,".",ws,"indexOf",ws,"(",ws,Str2,ws,")",ws,(">";"!==";"!="),ws,"-1",ws,")"),
        ['english']:
				(
					Str2,python_ws_,"is",python_ws_,"a",python_ws_,"substring",python_ws_,"of",python_ws_,Str1;
					Str1,python_ws_,"contains",python_ws_,Str2
				)
        ]).


this_(Data,[A]) -->
    langs_to_output(Data,this,[
    ['coffeescript','ruby']:
            ("@",A),
    ['java','engscript','dart','groovy','typescript','javascript','c#','c++','haxe','chapel','julia']:
            ("this",ws,".",!,ws,A),
    ['php','hack']:
            ("$",ws,"this",ws,"->",ws,A),
    ['swift','scala']:
            (A),
    ['rebol']:
            ("self",ws,"/",ws,A),
    ['python']:
            ("self",python_ws,".",python_ws,A),
    ['perl']:
            ("$self",ws,"->",ws,A)
    ]).

access_dict_(Data,[Dict,Dict_,Index]) -->
        langs_to_output(Data,access_dict,[
        ['javascript','c++','haxe']:
            ((Dict,ws,"[",ws,Index,ws,"]")),
        ['python']:
            (Dict,python_ws,"[",python_ws,Index,python_ws,"]"),
        ['java']:
            (Dict,ws,".",ws,"get",ws,"(",ws,Index,ws,")"),
        ['english_temp']:
			(
				optional_the(Index),python_ws_,"of",python_ws_,Dict;
				Dict,"'s",python_ws_,Index
			),
        ['perl']:
            ("$",symbol(Dict_),ws,"{",ws,Index,ws,"}"),
        % a dictionary in Java is a Map
        ['java']:
			(Dict,ws,".",ws,"get",ws,"(",ws,Index,ws,")")
        ]).

command_line_args_(Data) -->
        langs_to_output(Data,command_line_args,[
        ['perl']:
                ("@ARGV"),
        ['javascript']:
                ("process",ws,".",ws,"argv",ws,".",ws,"slice",ws,"(",ws,"2",ws,")")
        ]).

call_constructor_(Data,[Name,Args]) -->
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

regex_matches_string_(Data,[Reg,Str]) -->
        langs_to_output(Data,regex_matches_string,[
        ['javascript']:
            (Reg,ws,".",ws,"test",ws,"(",ws,Str,ws,")"),
        ['c#']:
            (Reg,ws,".",ws,"IsMatch",ws,"(",ws,Str,ws,")"),
        ['haxe']:
            (Reg,ws,".",ws,"match",ws,"(",ws,Str,ws,")")
        ]).

%shuffle an array in-place
shuffle_array_(Data,[A]) -->
        langs_to_output(Data,regex_matches_string,[
        ['php']:
            ("shuffle",ws,"(",ws,A,ws,")"),
        ['python']:
            ("random",python_ws,".",python_ws,"shuffle",python_ws,"(",python_ws,A,python_ws,")"),
        ['ruby']:
			(A,ws,"=",ws,A,ws,".",ws,"shuffle"),
		['perl']:
			(A,ws,"=",ws,"shuffle",ws,"(",ws,A,ws,")")
        ]).

dict_keys_(Data,[A]) -->
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
                (A,ws,".",ws,"keys"),
            ['python']:
                (A,python_ws,".",python_ws,"keys",python_ws,"(",python_ws,")"),
            ['javascript']:
                ("Object",ws,".",ws,"keys",ws,"(",ws,A,ws,")"),
            ['c#']:
                ("new",ws_,"List<string>",ws,"(",ws,"this",ws,".",ws,A,ws,".","Keys",ws,")")
        ]).

compare_arrays_(Data,[A,B]) -->
        langs_to_output(Data,compare_arrays,[
            ['cython','ruby']:
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

%replace a string (not in-place)
global_replace_in_string_(Data,[Str,Sub,Replacement]) -->
        langs_to_output(Data,global_replace_in_string,[
            ['cython','python','java']:
                (Str,python_ws,".",python_ws,"replace",python_ws,"(",python_ws,Sub,python_ws,",",python_ws,Replacement,python_ws,")"),
            ['c++']:
				(Str,ws,".",ws,"replace",ws,"(",ws,"s",ws,".",ws,"find",ws,"(",ws,Sub,ws,")",ws,",",Sub,".",ws,"length",ws,"(",ws,")",ws,",",ws,Replacement,ws,")"),
            ['php']:
                ("str_replace",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,",",ws,Str,ws,")"),
            ['javascript']:
                (Str,ws,".",ws,"split",ws,"(",ws,Sub,ws,")",ws,".",ws,"join",ws,"(",ws,Replacement,ws,")"),
            ['coffeescript']:
                (Str,python_ws,".",python_ws,"split",python_ws,"(",python_ws,Sub,python_ws,")",python_ws,".",python_ws,"join",python_ws,"(",python_ws,Replacement,python_ws,")"),
            ['c#']:
                (Str,ws,".",ws,"Replace",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,")"),
            ['ruby']:
                (Str,ws,".",ws,"gsub",ws,"(",ws,Sub,ws,")"),
            ['swift']:
                (Str,ws,".",ws,"stringByReplacingOccurrencesOfString",ws,"(",ws,Sub,ws,",",ws,"withString:",ws,Replacement,ws,")"),
            ['haxe']:
                ("StringTools",ws,".",ws,"replace",ws,"(",ws,Str,ws,",",ws,Sub,ws,Replacement,ws,")")
        ]).

%get the first index of a substring
index_of_substring_(Data,[String,Substring]) -->
    langs_to_output(Data,index_of_substring,[
    ['javascript','java']:
        (String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")"),
    ['d']:
        (String,ws,".",ws,"indexOfAny",ws,"(",ws,Substring,ws,")"),
    ['c#']:
        (String,ws,".",ws,"IndexOf",ws,"(",ws,Substring,ws,")"),
    ['cython','python']:
        (String,python_ws,".",python_ws,"index",python_ws,"(",python_ws,Substring,python_ws,")"),
    ['go']:
        ("strings",ws,".",ws,"Index",ws,"(",ws,String,ws,",",ws,Substring,ws,")"),
    ['perl']:
        ("index",ws,"(",ws,String,ws,",",ws,Substring,ws,")")
    ]).

substring_(Data,[A,B,C]) -->
        langs_to_output(Data,substring,[
        ['javascript','coffeescript','typescript','java','scala','dart']:
                (A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,")"),
        ['c++']:
                (A,ws,".",ws,"substring",ws,"(",ws,B,ws,",",ws,C,ws,"-",ws,B,ws,")"),
        ['z3']:
                ("(",ws,"Substring",ws_,A,ws_,B,ws_,C,ws,")"),
        ['cython','icon','go']:
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

not_(Data,[A]) -->
        langs_to_output(Data,'not',[
        ['python','lua','!','cython','pddl','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','racket','common lisp','rebol','haskell','sibilant']:
                ("(",python_ws,"not",python_ws_,A,python_ws,")"),
        ['java','ruby','perl 6','katahdin','coffeescript','frink','d','ooc','ceylon','processing','janus','pawn','autohotkey','groovy','scala','hack','rust','octave','typescript','julia','awk','swift','scala','vala','nemerle','pike','perl','c','c++','objective-c','tcl','javascript','r','dart','java','go','php','haxe','c#','wolfram']:
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

and_(Data,[A,B]) -->
    langs_to_output(Data,'and',[
    ['javascript','ats','ruby','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r']:
            (A,ws,"&&",ws,B),
    ['pydatalog']:
            (A,ws,"&",ws,B),
    ['seed7','vhdl','cython','python','lua','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php']:
            (A,python_ws_,"and",python_ws_,B),
    ['english']:
            (A,python_ws_,synonym("and"),python_ws_,B),
    ['minizinc']:
            (A,ws,"/\\",ws,B),
    ['fortran']:
            (A,ws,".AND.",ws,B),
    ['common lisp','pddl','z3','newlisp','racket','clojure','sibilant','hy','clips','emacs lisp']:
            ("(",ws,"and",ws_,A,ws_,B,ws,")"),
    ['prolog']:
            (A,ws,",",ws,B),
    ['visual basic','vbscript','openoffice basic','monkey x','visual basic .net']:
            (A,ws_,"And",ws_,B),
    ['polish notation']:
            ("and",ws_,A,ws_,B),
    ['reverse polish notation']:
            (A,ws_,B,ws_,"and"),
    ['z3py','pysmt']:
            ("And",python_ws,"(",python_ws,A,python_ws,",",python_ws,B,python_ws,")")
    ]).

sort_in_place_(Data,[List]) -->
        langs_to_output(Data,sort_in_place,[
			['ocaml']:
				(
					%this is for lists
					"(",ws,"List.sort",ws_,List,ws,")";
					%this is for arrays
					"(",ws,"Array.sort",ws_,List,ws,")"
				),
			['python','javascript']:
				(List,python_ws,".",python_ws,"sort",python_ws,"(",python_ws,")"),
			['ruby']:
				(List,ws,".",ws,"sort!"),
			['c++']:
				("std::sort",ws,"(",ws,"std::begin",ws,"(",ws,List,ws,")",ws,",",ws,"std::end",ws,"(",ws,List,ws,")",ws,")"),
			['php']:
				("sort",ws,"(",ws,List,ws,")"),
			['lua']:
				("table",ws,".",ws,"sort",ws,"(",ws,List,ws,")"),
			['perl']:
				(List,ws,"=",ws,"sort",ws_,List)
        ]).

reverse_sort_in_place_(Data,[List]) -->
        langs_to_output(Data,rsort_in_place,[
			['php']:
				("rsort",ws,"(",ws,List,ws,")"),
			['python']:
				(List,python_ws,".",python_ws,"sort",python_ws,"(",python_ws,"reverse",python_ws,"=",python_ws,"True",python_ws,")"),
			['javascript']:
				(List,ws,".",ws,"sort",ws,"(",ws,")",ws,".",ws,"reverse",ws,"(",ws,")")
        ]).

uppercase_(Data,[Str]) -->
        langs_to_output(Data,uppercase,[
        ['perl']:
                ("uc",ws,"(",ws,Str,ws,")"),
        ['php']:
                ("strtoupper",ws,"(",ws,Str,ws,")"),
        ['julia']:
                ("uppercase",ws,"(",ws,Str,ws,")"),
        ['java','javascript','haxe']:
                (Str,ws,".",ws,"toUpperCase",ws,"(",ws,")"),
        ['c#']:
                (Str,ws,".",ws,"UpperCase",ws,"(",ws,")"),
        ['python']:
				(Str,python_ws,".",python_ws,"upper",python_ws,"(",python_ws,")"),
		['systemverilog']:
				(Str,ws,".",ws,"toupper",ws,"(",ws,")"),
		['ruby']:
				(Str,ws,".",ws,"upcase"),
		['lua']:
				("string",ws,".",ws,"upper",ws,"(",ws,Str,ws,")"),
		['r']:
				("toupper",ws,"(",ws,Str,ws,")")
        ]).

char_to_uppercase_(Data,[Str]) -->
        langs_to_output(Data,char_to_uppercase,[
        ['java']:
                ("Character",ws,".",ws,"toUpperCase",ws,"(",Str,ws,")"),
        ['c']:
				("toupper",ws,"(",ws,Str,ws,")")
        ]).

char_to_lowercase_(Data,[Str]) -->
        langs_to_output(Data,char_to_lowercase,[
        ['java']:
                ("Character",ws,".",ws,"toLowerCase",ws,"(",Str,ws,")"),
        ['c']:
				("tolower",ws,"(",ws,Str,ws,")")
        ]).
        
% see https://rosettacode.org/wiki/Real_constants_and_functions
pi_(Data) -->
    langs_to_output(Data,pi,[
    ['java','pseudocode','javascript','c#']:
            ("Math",ws,".",ws,"PI"),
    ['pseudocode','python']:
            ("math",python_ws,".",python_ws,"pi"),
    ['php']:
			"M_PI",
	['erlang','perl 6']:
			"pi"
    ]).
     
grammar_or_(Data,[Var1,Var2]) -->
    langs_to_output(Data,grammar_or,[
    ['lpeg']:
		(Var1,ws,"+",ws,Var2),
    ['marpa','wirth syntax notation','rebol','yapps','antlr','jison','waxeye','ometa','ebnf','nearley','parslet','yacc','perl 6','rebol','hampi','earley-parser-js']:
            (Var1,ws,"|",ws,Var2),
    ['lpeg']:
            (Var1,ws,"+",ws,Var2),
    ['peg.js','abnf','treetop']:
            (Var1,ws,"/",ws,Var2),
    ['prolog','definite clause grammars']:
            (Var1,ws,";",!,ws,Var2)
    ]).

grammar_and_(Data,[Var1,Var2]) -->
    langs_to_output(Data,grammar_and,[
	['definite clause grammars','pypeg']:
            (Var1,ws,",",ws,Var2),
    ['lpeg']:
            (Var1,ws,"*",ws,Var2),
    ['nearley','abnf','coco/r','peg.js','antlr','marpa','wirth syntax notation','canopy']:
            (Var1,ws_,Var2)
    ]).

eager_and_(Data,[Var1,Var2]) -->
    langs_to_output(Data,'eager_or',[
	['javascript','python','c++','c#','php','smalltalk','perl','ruby','java','julia','matlab','r','swift']:
        (Var1,python_ws,"&",python_ws,Var2),
    ['erlang','pascal']:
		(Var1,ws_,"and",ws_,Var2),
	['visual basic','visual basic .net','VBScript']:
		(Var1,ws_,"And",ws_,Var2)
    ]).

eager_or_(Data,[Var1,Var2]) -->
    langs_to_output(Data,'eager_or',[
	['javascript','python','c++','c#','php','smalltalk','perl','ruby','java','julia','matlab','r','swift']:
        (Var1,python_ws,"|",python_ws,Var2),
    ['erlang','pascal']:
		(Var1,ws_,"or",ws_,Var2),
	['visual basic','visual basic .net','VBScript']:
		(Var1,ws_,"Or",ws_,Var2)
    ]).

or_(Data,[Var1,Var2]) -->
    langs_to_output(Data,'or',[
    ['javascript','katahdin','perl 6','ruby','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart',r]:
        (Var1,ws,"||",!,ws,Var2),
    ['cosmos','cython','vhdl','python','lua','seed7','pydatalog','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php']:
        (Var1,python_ws_,"or",python_ws_,Var2),
	['english']:	
		(Var1,python_ws_,"or",python_ws_,Var2),
    ['fortran']:
        (Var1,ws_,".OR.",ws_,Var2),
    ['z3','clips','pddl','clojure','common lisp','emacs lisp','clojure','racket']:
        ("(",ws,"or",ws_,Var1,ws_,Var2,ws,")"),
    ['prolog']:
        (Var1,ws,";",!,ws,Var2),
    ['minizinc']:
        (Var1,ws,"\\/",ws,Var2),
    ['visual basic','monkey x','visual basic .net']:
        (Var1,ws_,"Or",ws_,Var2)
    ]).

last_index_of_(Data,[String,Substring]) -->
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


optional_indent(Data,Indent) -->
	{Data = [Lang,_,_,Indent],
	offside_rule_langs(Offside_rule_langs)},
	{memberchk(Lang,Offside_rule_langs)}->
		Indent;
	(Indent;"").

%This creates variables without initializing them.
declare_vars_(Data,[Vars,Type]) -->
	langs_to_output(Data,declare_vars,[
    ['javascript']:
		("var",ws_,Vars),
	['perl']:
		("my",ws_,Vars),
	['c','c++']:
		(Type,ws_,Vars),
	['swift']:
		("var",ws_,Vars,ws,":",ws,Type)
    ]).

%This creates each variable with a value.
initialize_vars_(Data,[Vars,Type]) -->
	langs_to_output(Data,initialize_vars,[
    ['javascript']:
		("var",ws_,Vars),
	['perl']:
		("my",ws_,Vars),
	['c','c++']:
		(Type,ws_,Vars)
    ]).


set_same_value_(Data,[Vars,Expr,Type]) -->
	langs_to_output(Data,set_same_value,[
	['java']:
		(Vars,ws,"=",ws,Expr),
	['perl']:
		(Vars,ws,"=",Vars)
    ]).


%this does not initialize the variables
multiple_assignment_(Data,[Vars,Exprs,Type]) -->
	langs_to_output(Data,multiple_assignment,[
		['python_temp','lua','ruby']:
			set_var_(Data,[Vars,Exprs]),
		['perl']:
			("(",Vars,")",ws,"=",ws,Exprs),
		['prolog','swift']:
			("(",ws,Vars,ws,")",ws,"=",ws,"(",Exprs,")")
    ]).

instanceof_(Data,[Expr,Type,_]) -->
	langs_to_output(Data,instanceof,[
		['swift','c#']:
			(Expr,ws_,"is",ws_,Type),
		['java']:
			(Expr,ws_,"instanceof",ws_,Type)
	]).

instanceof_([php|_],[Expr,Type,Type2]) -->
	{Type2 = bool}->("is_bool",ws,"(",ws,Expr,ws,")"),
	{Type2 = float}->("is_float",ws,"(",ws,Expr,ws,")"),
	{Type2 = int}->("is_int",ws,"(",ws,Expr,ws,")"),
	{Type2 = string}->("is_string",ws,"(",ws,Expr,ws,")").

instanceof_([prolog|_],[Expr,Type,Type2]) -->
	{Type2 = float}->("float",ws,"(",ws,Expr,ws,")"),
	{Type2 = int}->("integer",ws,"(",ws,Expr,ws,")"),
	{Type2 = string}->("string",ws,"(",ws,Expr,ws,")").

try_catch_(Data,[Body1,Name,Body2,Indent]) -->
	langs_to_output(Data,try_catch,[
		['javascript']:
			("try",ws,"{",ws,Body1,ws,"}",ws,"catch",ws,"(",ws,Name,ws,")",ws,"{",ws,Body2,ws,"}"),
		['python_temp']:
			("try:",python_ws,Body1,Indent,"except",python_ws_,"Exception",python_ws_,"as",python_ws,Name,":",python_ws,Body2),
		['java','c#','php']:
			("try",ws,"{",ws,Body1,ws,"}",ws,"catch",ws,"(",ws,"Exception",ws_,Name,ws,")",ws,"{",ws,Body2,ws,"}")
	]).

%see https://rosettacode.org/wiki/Sort_an_integer_array#C.23
%sort a list of integers (not in-place)
sort_(Data,[List]) -->
	langs_to_output(Data,sort,[
		['lua']:
			("table",ws,".",ws,"sort",ws,"(",ws,List,ws,")"),
		['ruby']:
			(List,ws,".",ws,"sort"),
		['perl']:
			("sort",ws,"(",ws,List,ws,")"),
		['python','cython']:
			("sorted",python_ws,"(",python_ws,List,python_ws,")"),
		['prolog']:
			("(",ws,"sort",ws_,"$",ws,"(",ws,List,ws,")",ws,")"),
		%in ocaml, this function sorts an array or a list
		['ocaml']:
			(
				%this is for lists
				"(",ws,"List.sort",ws_,List,ws,")";
				%this is for arrays
				"(",ws,"Array.sort",ws_,List,ws,")"
			),
		['haskell']:
			("(",ws_,"sort",ws_,"compare",ws_,List,ws_,")"),
		['javascript']:
			(List,ws,".",ws,"sort",ws,"(",ws,")"),
		['c#']:
			(List,ws,".",ws,"Sort",ws,"(",ws,")")
	]).

%Returns the MD5 checksum as a hexadecimal string.
% see https://rosettacode.org/wiki/MD5
md5_(Data,[Str]) -->
	langs_to_output(Data,md5,[
		['php']:
			("md5",ws,"(",ws,Str,ws,")")
	]).

%Returns the SHA-1 hash as a hexadecimal string.
% see https://rosettacode.org/wiki/SHA-1#C.2B.2B
sha1_(Data,[Str]) -->
	langs_to_output(Data,sha1,[
		['php']:
			("sha1",ws,"(",ws,Str,ws,")"),
		['d']:
			(Str,ws,".",ws,"sha1Of"),
		['erlang']:
			("crypto:hash",ws,"(",ws,"sha",ws,",",ws,Str,ws,")"),
		['ruby']:
			("Digest::SHA1.hexdigest",ws,"(",ws,Str,ws,")")
	]),!.

ing(Data,[Object]) -->
	langs_to_output(Data,ing,[
		['python']:
			("type",python_ws,"(",python_ws,Object,python_ws,")",(ws_,"is",ws_;ws,"==",ws),"\"str\"";
			"\"str\"",(ws_,"is",ws_;ws,"==",ws),"type",python_ws,"(",python_ws,Object,python_ws,")"),
		['ruby']:
			(Object,ws,".instance_of?",ws_,"String"),
		['php']:
			("is_string",ws,"(",ws,Object,ws,")"),
		['java']:
			(Object,ws_,"instanceof",ws_,"String"),
		['c#']:
			(Object,ws_,"is",ws_,"String"),
		['lua']:
			("type",ws,"(",ws,Object,python_ws,")",ws,"==",ws,"\"string\"";
			"\"string\"",ws,"==",ws,"type",ws,"(",ws,Object,ws,")"),
		['javascript']:
			(Object,ws_,"instanceof",ws_,"String",ws,"||",ws,"typeof",ws_,Object,ws,"===",ws,"\"string\"")
	]),!.

type_is_bool(Data,[Object]) -->
	langs_to_output(Data,type_is_bool,[
		['python']:
			("type",python_ws,"(",python_ws,Object,python_ws,")",(ws_,"is",ws_;ws,"==",ws),"\"boolean\"";
			"\"boolean\"",(ws_,"is",ws_;ws,"==",ws),"type",python_ws,"(",python_ws,Object,python_ws,")"),
		['ruby']:
			("[",ws,"true",ws,",",ws,"false",ws,"]",ws,".",ws,"include?",ws_,Object),
		['php']:
			("is_bool",ws,"(",ws,Object,ws,")"),
		['lua']:
			("type",ws,"(",ws,Object,python_ws,")",ws,"==",ws,"\"boolean\"";
			"\"boolean\"",ws,"==",ws,"type",ws,"(",ws,Object,ws,")"),
		['javascript']:
			("typeof",ws,"(",ws,Object,python_ws,")",ws,"==",ws,"\"boolean\"";
			"\"boolean\"",ws,"==",ws,"typeof",ws,"(",ws,Object,ws,")")
	]),!.

type_is_int(Data,[Object]) -->
	langs_to_output(Data,type_is_int,[
		['python']:
			("type",python_ws,"(",python_ws,Object,python_ws,")",(ws_,"is",ws_;ws,"==",ws),"\"int\"";
			"\"int\"",(ws_,"is",ws_;ws,"==",ws),"type",python_ws,"(",python_ws,Object,python_ws,")"),
		['prolog']:
			("integer",ws,"(",ws,Object,ws,")"),
		['php']:
			("is_int",ws,"(",ws,Object,ws,")"),
		['ruby']:
			(Object,ws,".instance_of?",ws_,"Integer")
	]),!.

type_is_list(Data,[Object]) -->
	langs_to_output(Data,type_is_list,[
		['python']:
			("type",python_ws,"(",python_ws,Object,python_ws,")",(ws_,"is",ws_;ws,"==",ws),"list";
			"list",(ws_,"is",ws_;ws,"==",ws),"type",python_ws,"(",python_ws,Object,python_ws,")"),
		['lua']:
			("type",ws,"(",ws,Object,python_ws,")",ws,"==",ws,"\"table\"";
			"\"table\"",ws,"==",ws,"type",ws,"(",ws,Object,ws,")"),
		['javascript']:
			("Array",ws,".",ws,"isArray(",ws,Object,ws,")"),
		['prolog']:
			("is_list",ws_,"(",ws,Object,ws,")"),
		['ruby']:
			(Object,ws,".",ws,"instance_of?",ws_,"Array"),
		['php']:
			("is_array",ws,"(",ws,Object,ws,")"),
		['perl']:
			("ref",ws,"(",ws,Object,ws,")",ws_,"eq",ws_,"'ARRAY'")
	]),!.
