not_defined_for(Data,Function) :-
        Data = [Lang,Is_input|_],
        (Is_input ->
            true;
        writeln(Function),writeln('not defined for'),writeln(Lang)).

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
	Grammars:
			A,
	['minizinc','sympy','logtalk','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','common lisp','f#','ocaml','haskell','ml','racket','nemerle']:
			(A),
	['pseudocode','visual basic','visual basic .net','autoit','monkey x']:
			("Return",ws_,A),
	['octave','fortran','picat']:
			("retval",ws,"=",ws,A),
	['cosmos','prolog','constraint handling rules']:
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
    ['javascript','systemverilog','elixir','visual basic .net','lua','ruby','scriptol','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','coffeescript','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','gambas','octave','visual basic','bc']:
			(Name,ws,"=",ws,Value),
	['python']:
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
    ['ruby','erlang','php','haskell','prolog','constraint handling rules','logtalk','picat','octave','wolfram']:
        (Name,ws,"=",ws,Expr),
    ['python','julia']:
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
        (Container,python_ws,".",python_ws,"index",python_ws,"(",python_ws,Contained,python_ws,")")
    ]).


% https://www.rosettacode.org/wiki/Remove_duplicate_elements
remove_duplicates_(Data,[A]) -->
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
			("(",ws,"distinct",ws_,A,ws,")")
	]).

remove_duplicates_in_place(Data,[A]) -->
	langs_to_output(Data,remove_duplicates,[
		['ruby']:
			(A,ws,".",ws,"uniq!")
	]).

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

array_length_(Data,[A])-->
        langs_to_output(Data,array_length,[
        ['go']:
                ("len",ws,"(",ws,A,ws,")"),
		['prolog','constraint handling rules']:
				("(",ws,"length",ws_,"$",ws,A,ws,")",ws,")"),
        ['python','cython']:
                ("len",python_ws,"(",python_ws,A,python_ws,")"),
        ['java','picat','scala','d','coffeescript','typescript','dart','vala','javascript','haxe','cobra']:
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
                ("Length",ws,"[",ws,A,ws,"]")
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
                ("(",ws,"Length",ws_,A,ws,")")
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

reverse_list_(Data,[List]) -->
        langs_to_output(Data,reverse_list,[
			['php']:
				("array_reverse",ws,"(",ws,List,ws,")"),
			['perl']:
				("reverse",ws,"(",ws,List,ws,")"),
			['ruby']:
				(List,ws,".",ws,"reverse"),
			['cython']:
				(List,python_ws,"[::-1]";List,ws,".",ws,"reverse",ws,"(",ws,")"),
			['haskell']:
				("(",ws,"reverse",ws_,List,ws,")"),
			['javascript']:
				(List,ws,".",ws,"map",ws,"(",ws,"function",ws,"(",ws,"arr",ws,")",ws,"{",ws,"return",ws_,"arr",ws,".",ws,"slice()",ws,";",ws,"}",ws,")")
		]).

reverse_list_in_place_(Data,[List]) -->
        langs_to_output(Data,reverse_list_in_place,[
			['javascript','python']:
				(List,python_ws,".",python_ws,"reverse",python_ws,"(",python_ws,")"),
			['ruby']:
				(List,python_ws,".",python_ws,"reverse!"),
			['php']:
				set_var_(Data,[List,reverse_list_(Data,[List])])
		]).

charAt_(Data,[AString,Index]) -->
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
        ['javascript','haxe','coffeescript','groovy','java','typescript','rust','dart']:
                (Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")"),
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
    ['c','sympy','lua','cython','definite clause grammars','python','ruby','logtalk','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','vala','f#','java','ceylon','ocaml','erlang','c#','haxe','javascript','dart','bc','visual basic','php','perl']:
			(Name,python_ws,"(",python_ws,Args,python_ws,")"),
	['prolog','constraint handling rules']:
			("(",ws,Name,ws_,"$",ws,"(",Args,")",ws,")"),
	['haskell','z3','clips','clojure','common lisp','clips','racket','scheme','rebol']:
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
        ['javascript','java','php']:
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
					("private",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
			['php']:
					("private",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}")
		]).

instance_method_(Data,[Name,Type,Params,Body,Indent]) -->
		langs_to_output(Data,instance_method,[
		['hy']:
			("(",ws,"defn",ws_,Name,ws_,"[",ws,"self",ws_,Params,ws,"]",ws_,Body,ws,")"),
		['python','cython']:
				("def",python_ws_,Name,"(",python_ws,"self",python_ws,",",Params,")",":",python_ws,Body),
		['swift']:
                ("func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent;ws),"}"),
        [logtalk]:
                (Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body),
        ['ruby']:
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end"),
        ['perl']:
                ("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}"),
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
        ['javascript','pseudocode']:
                ("static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['python_temp']:
				("@staticmethod",Indent,function_(Data,[Name,Type,Params,Body,Indent])),
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
                ("function",ws_,"construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
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
        ['janus','python','visual basic','visual basic .net','nim','cython','vala','perl 6','dart','typescript','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift']:
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

array_plus_equals_(Data,[A,B]) -->
        langs_to_output(Data,array_plus_equals,[
        ['python']:
			(A,python_ws,"+=",python_ws,B),
		['perl']:
			("push",ws_,A,ws,",",ws_,B),
		['javascript']:
			(A,ws,".",ws,"push",ws,".",ws,"apply",ws,"(",ws,A,ws,",",ws,B,ws,")")
        ]).

string_plus_equals_(Data,[A,B]) -->
	langs_to_output(Data,string_plus_equals,[
        ['python','java','javascript','c#']:
			(A,python_ws,"+=",python_ws,B),
		['perl','php']:
			(A,ws,".=",ws,B),
		['ruby']:
			(A,ws,"<<",ws,B),
		['c++']:
			(A,ws,".",ws,"append",ws,"(",ws,B,ws,")"),
		['lua']:
			set_var_(Data,[A,concatenate_string_(Data,[A,B])])
    ]).

minus_equals_(Data,[A,B]) -->
    langs_to_output(Data,minus_equals,[
    ['janus','python','visual basic','visual basic .net','vala','nim','perl 6','dart','perl','typescript','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift']:
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
		['javascript','java']:
			("Math",ws,".",ws,"log",ws,"(",ws,A,ws,")"),
		['c#','ruby']:
			("Math",ws,".",ws,"Log",ws,"(",ws,A,ws,")"),
		['python','lua']:
			("math",python_ws,".",python_ws,"log",python_ws,"(",python_ws,A,python_ws,")"),
		['perl','c','sympy']:
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

println_(Data,[A]) -->
		langs_to_output(Data,println,[
		['cython','python','lua']:
                ("print",python_ws,"(",python_ws,A,python_ws,")"),
        ['cython','python','lua']:
                ("print",python_ws,"(",python_ws,A,python_ws,")";"print",python_ws_,A),
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
        [c,'java','c#','javascript',php,perl]:
                (Name,ws,"*=",ws,Expr)
        ]).

append_to_string_(Data,[Name,Expr]) -->
        langs_to_output(Data,append_to_string,[
        [c,'java','c#',javascript]:
                (Name,python_ws,"+=",python_ws,Expr),
        [php,perl]:
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
			(Name,ws,"[\"",ws,Index,ws,"\"]",ws,"=",ws,Value),
	['gnu smalltalk']:
			(Name,ws_,"at:",ws_,Index,ws_,"put:",ws_,Value),
	['prolog','constraint handling rules']:
			("member",ws,"(",ws,Name,ws,",",ws,Index,ws,"-",ws,Value,ws,")"),
	['java']:	
			(Name,ws,".",ws,"put",ws,"(",ws,Value,ws,")")
	]).

range_(Data,[A,B]) -->
	langs_to_output(Data,range,[
	['swift','perl','picat','minizinc','chapel']:
		("(",ws,A,ws,"..",ws,B,ws,")"),
	['rust']:
		("(",ws,A,ws,"...",ws,B,ws,")"),
	["python"]:
		("range",python_ws,"(",python_ws,A,python_ws,",",B,python_ws,"-",python_ws,"1",python_ws,")")
    ]).

get_user_input_(Data,[Var]) -->
        langs_to_output(Data,get_user_input,[
			['python']:
				(Var,python_ws,"=",python_ws,"input",python_ws,"(",python_ws,")"),
			['perl']:
				(Var,ws,"=",ws,"<>"),
			['ruby']:
				(Var,ws,"=",ws,"gets"),
			['php']:
				(Var,ws,"=",ws,"read_line",ws,"(",ws,")"),
			['prolog']:
				("read",ws,"(",ws,Var,ws,")")
        ]).

get_user_input_with_prompt_(Data,[Var,Prompt]) -->
        langs_to_output(Data,get_user_input_with_prompt,[
			['python']:
				(Var,python_ws,"=",python_ws,"input",python_ws,"(",python_ws,Prompt,python_ws,")"),
			['php']:
				(Var,ws,"=",ws,"read_line",ws,"(",ws,Prompt,ws,")"),
			['perl']:
				("print",ws,"(",ws,Prompt,ws,")",ws,";",ws,"=",ws,"<>")
        ]).

initializer_list_(Data,[A,Type]) -->
        langs_to_output(Data,initializer_list,[
        ['java','lua','pseudocode','picat','c#','c++','c','visual basic','visual basic .net','wolfram']:
                ("{",ws,A,ws,"}"),
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

dict_(Data,[A]) -->
		langs_to_output(Data,dict,[
		[ 'cosmos', 'ruby', 'lua', 'dart','javascript','typescript','julia','c++','engscript']:
                ("{",python_ws,A,python_ws,"}"),
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
false_(Data) -->
    langs_to_output(Data,'false',[
    ['java','constraint handling rules','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pascal','rust','minizinc','engscript','picat','clojure','nim','groovy','d','ceylon','typescript','coffeescript','octave','prolog','julia','vala','f#','swift','c++','nemerle','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol','hack']:
			("false"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
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
	['java','lua','constraint handling rules','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','pseudocode','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','erlang','c#','haxe','go','ocaml','scala','php','rebol']:
			("true"),
	['pydatalog','hy','cython','autoit','haskell','vbscript','visual basic','monkey x','wolfram','delphi']:
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
        ['c']:
                ("acos",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Acos",ws,"(",ws,Var1,ws,")")
        ]).

asin_(Data,[Var1]) -->
        langs_to_output(Data,asin,[
        ['c']:
                ("asin",ws,"(",ws,Var1,ws,")"),
        ['go']:
                ("Asin",ws,"(",ws,Var1,ws,")")
        ]).

atan_(Data,[Var1]) -->
        langs_to_output(Data,atan,[
        ['c']:
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

abs_(Data,[Var1]) -->
	langs_to_output(Data,abs,[
	['java','javascript']:
			("Math",ws,".",ws,"abs",ws,"(",ws,Var1,ws,")"),
	['F#','C#']:
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
        ['java','javascript','typescript','haxe']:
                ("Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")"),
        ['python','cython','lua']:
                ("math",python_ws,".",python_ws,"sin",python_ws,"(",python_ws,Var1,python_ws,")"),
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

cos_(Data,[Var1]) -->
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
        ['python','lua']:
                ("math",python_ws,".",python_ws,"cos",python_ws,"(",python_ws,Var1,python_ws,")"),
        ['rebol']:
                ("cosine/radians",ws_,Var1),
        ['english']:
                ("the cosine of",ws_,Var1),
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
					"(",ws,A,ws,")",ws,"=>",ws,"{",ws,B,ws,"}"
				),
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

type_conversion_(['perl'|_],[Type1,Type2,Arg]) -->
	{member(Type1,[int,string,bool,double]),member(Type2,[int,string,bool,double])},
	Arg.

type_conversion_(Data,[_,Type2,Arg]) -->
	{Data=['python'|_]},
	(type(Data,Type2),python_ws,"(",python_ws,Arg,python_ws,")").

type_conversion_(Data,[_,Type2,Arg]) -->
	{Data=['php'|_]},
	("(",ws,type(Data,Type2),ws,")",ws,"(",ws,Arg,ws,")").

type_conversion_(Data,[int,string,Arg]) -->
		langs_to_output(Data,type_conversion,[
        ['c#']:
                (Arg,ws,".",ws,"ToString",ws,"(",ws,")"),
        ['java']:
				("Integer",ws,".",ws,"toString",ws,"(",ws,Arg,ws,")";
				"String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")"),
        ['javascript','swift']:
                ("String",ws,"(",ws,Arg,ws,")"),
        ['c++']:
				("std::to_string",ws,"(",ws,Arg,ws,")"),
		['haskell']:
				("(",ws,"show",ws_,Arg,")"),
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
		langs_to_output(Data,type_conversion,[
        ['java']:
				("Boolean",ws,".",ws,"toString",ws,"(",ws,Arg,ws,")";
				"String",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")"),
		['php']:
			("var_export",ws,"(",ws,Arg,ws,",",ws,"true",ws,")")
        ]).

type_conversion_(Data,[string,bool,Arg]) -->
		langs_to_output(Data,type_conversion,[
        ['java']:
				("Boolean",ws,".",ws,"parseBoolean",ws,"(",ws,Arg,ws,")";
				"Boolean",ws,".",ws,"valueOf",ws,"(",ws,Arg,ws,")")
        ]).

type_conversion_(Data,[string,int,Arg]) -->
		langs_to_output(Data,type_conversion,[
        ['javascript']:
			("parseInt",ws,"(",ws,Arg,ws,")"),
        ['java']:
			("Integer",ws,".",ws,"parseInt",ws,"(",ws,Arg,ws,")"),
		['c#']:
			("Int32",ws,".",ws,"Parse",ws,"(",ws,Arg,ws,")"),
		['swift']:
			("Int",ws,"(",ws,Arg,ws,")"),
		['c++']:
			("atoi(",Arg,".c_str())"),
		['haskell']:
			("(",ws,"read",ws_,Arg,")"),
		['python']:
			("int",python_ws,"(",python_ws,Arg,python_ws,")")
        ]).

type_conversion_(Data,[string,double,Arg]) -->
		langs_to_output(Data,type_conversion,[
        ['java']:
			("Double",ws,".",ws,"parseDouble",ws,"(",ws,Arg,ws,")"),
		['lua']:
			("tonumber",ws,"(",ws,Arg,ws,")"),
		['ruby']:
			(Arg,ws,".",ws,"to_f")
        ]).

static_method_call_(Data,[Class_name,Function_name,Args]) -->
    langs_to_output(Data,static_method_call,[
    ['java','javascript','c#']:
		(Class_name,".",Function_name,ws,"(",ws,Args,ws,")"),
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
    ['java','perl 6','python','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','tcl','go','dart','javascript','c','c++','c#']:
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

arithmetic_(Data,[Exp1,Exp2,Symbol,Prefix_arithmetic_langs]) -->
        langs_to_output(Data,arithmetic,[
        ['java', 'vhdl', 'tcsh', 'visual basic .net', 'constraint handling rules', 'cython', 'python', 'ruby', 'lua','logtalk', 'prolog', 'cosmos','pydatalog','e','livecode','vbscript','monkey x','englishscript','gap','pop-11','dafny','janus','wolfram','chapel','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','b-prolog','agda','picat','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','erlang','gambas','hack','c++','matlab','rebol','red','go','awk','haskell','perl','javascript','c#','php','r','haxe','visual basic','vala','bc']:
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
				("for",ws_,Index,ws,",",ws,Var,ws_,"in",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end"),
			['python']:
				("for",python_ws_,Index,python_ws,",",python_ws,Var,python_ws_,"in",python_ws_,"enumerate",python_ws,"(",python_ws,Array,python_ws,"):",python_ws,Body),
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
        ['ruby']:
				(Array,ws,".",ws,"each",ws_,"do",ws,"|",ws,Var,ws,"|",ws,Body,(Indent;ws_),"end"),
        ['erlang']:
				("foreach",ws,"(",ws,"fun",ws,"(",ws,Var,ws,")",ws,"->",ws,Body,ws_,"end",ws,",",ws,Array,ws,")"),
        ['lua']:
				("for",ws_,Var,ws_,"in",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end"),
        ['seed7']:
                ("for",ws_,Var,ws_,"range",ws_,Array,ws_,"do",ws_,Body,(Indent;ws_),"end",ws_,"for;"),
        ['javascript','typescript']:
                (Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var,ws,")",ws,"{",ws,Body,(Indent;ws),"}",ws,")",ws,";"),
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
        ['perl']:
                ("for",ws_,Array,ws,"->",ws,Var,ws,"{",ws,Body,(Indent;ws),"}"),
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
				("if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}",(Indent;ws),C,(Indent;ws),D),
		['rust','go']:
				("if",ws_,A,ws,"{",ws,B,(Indent;ws),"}",(Indent;ws),C),
		['clips']:
				("(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,ws,")"),
		['z3']:
				("(",ws,"ite",ws_,A,ws_,B,ws_,C,ws_,D,ws,")"),
		['minizinc']:
				("if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,D,(Indent;ws_),"endif"),
		['cython','python']:
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
			("do",ws,"{",ws,Body,(Indent;ws),"}",ws,"while",ws,"(",ws,Condition,ws,")",ws,";"),
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
        ]).

predicate_(Data,[Name,Params,Body,_]) -->
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
                ("for",ws,"(",ws,Statement1,ws,";",ws,Condition,ws,";",ws,Statement2,ws,")",ws,"{",ws,Body,(Indent;ws),"}")
        ]).

semicolon_(Data,[A]) -->
		{grammars(Grammars)},
        langs_to_output(Data,semicolon,[
        Grammars:
				A,
        ['c','vhdl','f#','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala']:
                (A,ws,";"),
        ['pseudocode']:
                (A,("";ws,";")),
        ['visual basic .net','sympy','r','constraint handling rules','pydatalog','common lisp','gnu smalltalk','ruby','lua','hy',picolisp,logtalk,minizinc,'swift',rebol,'fortran',go,'picat','julia',prolog,haskell,'mathematical notation','erlang',z3]:
                A,
        ['python','cython']:
				(A)
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
                ("Class",ws_,Name,ws_,Body,(Indent;ws_),"End"),
        ['python']:
				("class",python_ws_,Name,python_ws,"(",python_ws,"object",python_ws,")",python_ws,":",Body)
        ]).

function_without_params_(Data,[Name,Type,Params,Body,Indent]) -->
		function_(Data,[Name,Type,Params,Body,Indent]);
		langs_to_output(Data,function_without_params,[
			['ruby']:
				("def",ws_,Name,ws_,Body,(Indent;ws_),"end")
		]).

function_(Data,[Name,Type,Params,Body,Indent]) -->
		langs_to_output(Data,function,[
		['parboiled']:
				("Rule",ws_,Name,ws,"(",ws,")",ws,"{",ws,"return",ws_,Body,ws,";",ws_,"}"),
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
				(({Params = parameters(_,[])},"sub",ws_,Name,ws,"{",ws,Body,(Indent;ws),"}");
                ("sub",ws_,Name,ws,"{",ws,"my",ws,"(",Params,")",ws,"=@_",ws,";",ws,Body,(Indent;ws),"}")),
        ['perl 6']:
                ("sub",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['pawn']:
                (Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent;ws),"}"),
        ['ruby']:
				(({Params = parameters(_,[])},"def",ws_,Name,ws_,Body,(Indent;ws_),"end");
                ("def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end")),
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
        ]),
        {writeln(Params)}.

var_name_(Data,Type,A) -->
        {Data = [Lang|_],dif(A,"end"),dif(A,"return"),dif(A,"def"),dif(A,"str")},
        ({memberchk(Lang,['python','engscript','abnf','wirth syntax notation','marpa','antlr','definite clause grammars','peg.js', 'systemverilog', 'vhdl', 'visual basic .net', 'ruby', 'lua', 'cosmos', 'englishscript','vbscript','polish notation','reverse polish notation','wolfram','pseudocode','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','clojure','haxe','coffeescript','dart','javascript','c#','haskell','c','gambas','common lisp','scheme','rebol','f#'])}->
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
        {memberchk(Lang,['nearley'])}->
            ("$",symbol(A));
        {memberchk(Lang,['parboiled'])}->
            (symbol(A),"()");
        {not_defined_for(Data,'var_name')}),
        {is_var_type(Data, A, Type)}.

else(Data,[Indent,A]) -->
        langs_to_output(Data,else,[
        ['sympy']:
				("(",ws,A,ws,",",ws,"True",ws,")"),
        ['clojure']:
                (":else",ws_,A),
        ['fortran']:
                ("ELSE",ws_,A),
        ['hack','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc']:
                ("else",ws,"{",ws,A,(Indent;ws),"}"),
        ['seed7','vhdl','ruby','lua','livecode','janus','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#']:
                ("else",ws_,A),
        ['erlang']:
                ("true",ws,"->",ws,A),
        ['wolfram','prolog']:
                (A),
        ['z3']:
                (A),
        ['cython','python']:
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
                ("else",ws,"{",ws,A,(Indent;ws),"}")),
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
        ['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure']:
                ws_,
        ['pseudocode','ruby','definite clause grammars','nearley','sympy','systemverilog','vhdl','visual basic .net','perl','constraint handling rules','lua','ruby','python','javascript','logtalk','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','typescript','dart','haxe','scala','visual basic']:
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
        ['haskell','definite clause grammars','nearley','sympy','pydatalog','python','ruby','lua','hy','perl 6','cosmos','polish notation','reverse polish notation','scheme','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','constraint handling rules','logtalk','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','r','bc']:
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
        ['lua','ruby']:
                ("require",ws_,"\"",ws,A,ws,"\""),
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
    ['javascript',d,'java','c#',c,'c++',typescript,dart,php,hack]:
			("case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default),
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
    ['javascript',d,'java','c#',c,'c++',typescript,dart,php,hack]:
            ("case",ws_,Expr,ws,":",ws,B,ws,"break",ws,";",ws,Case_or_default),
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
            ("default",ws,":",ws,A),
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
            ("else",ws_,"if",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
        ['rust','go','englishscript']:
            ("else",ws_,"if",ws_,A,ws,"{",ws,B,(Indent;ws),"}"),
        ['php','hack','perl']:
            ("elseif",ws,"(",ws,A,ws,")",ws,"{",ws,B,(Indent;ws),"}"),
        ['julia','octave']:
            ("elseif",ws_,A,ws_,B),
        ['ruby','seed7','vhdl']:
			("elsif",ws_,A,ws_,"then",ws_,B),
		['lua']:
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
        ]).

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
        ]).


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
    ['z3',cosmos,'visual basic .net','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','haxe','haskell','visual basic','monkey x']:
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

% https://rosettacode.org/wiki/Arrays
type(Data,[array,Type]) -->
    {(Type = int;Type=bool;Type=string;Type=double)},
    langs_to_output(Data,array,[
    ['java','c','c++','c#']:
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
    ['pydatalog','visual basic .net','lua','ruby','hy','pegjs','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','dafny','z3','elm','bash','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','autoit','cobra','julia','groovy','scala','ocaml','gambas','matlab','rebol','red','go','awk','haskell','r','visual basic']:
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
    ['ruby','r','constraint handling rules','lua','cython','python','visual basic .net','cosmos','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','pseudocode','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','rebol','polish notation','swift','java','picat','c#','go','c++','c','visual basic','php','scala','perl','wolfram']:
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

top_level_statement_(Data,Type,A) -->
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

include_in_each_file_(Data) -->
    langs_to_output(Data,include_in_each_file,[
    ['prolog','constraint handling rules']:
        (":- initialization(main).\n:- set_prolog_flag(double_quotes, chars).\n:- use_module(library(clpfd)).\n:- use_module(library(func))."),
    ['perl']:
        ("use strict;\nuse warnings;"),
	['haxe']:
		"using StringTools;",
	['python']:
		"",
	['sympy']:
		"from sympy import *"
    ]),"\n";"".

% reverse a string (not in-place)
% see https://www.rosettacode.org/wiki/Reverse_a_string
reverse_string_(Data,[Str]) -->
        langs_to_output(Data,reverse_string,[
        ['java']:
                ("new",ws_,"StringBuilder",ws,"(",ws,Str,ws,")",ws,".",ws,"reverse",ws,"(",ws,")",ws,".",ws,"toString",ws,"(",ws,")"),
        ['perl']:
                ("reverse",ws,"(",Str,")"),
        ['php']:
                ("strrev",ws,"(",ws,Str,ws,")"),
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

array_slice_(Data,[A,B,C]) -->
        langs_to_output(Data,array_slice,[
            ['cython']:
                (A,python_ws,"[",python_ws,B,python_ws,":",python_ws,C,python_ws,"]")
        ]).

compare_string_(Data,[A,B]) -->
    langs_to_output(Data,compare_string,[
    ['r']:
            ("identical",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['emacs lisp']:
            ("(",ws,"string=",ws_,A,ws_,B,ws,")"),
    ['clojure']:
            ("(",ws,"=",ws_,A,ws_,B,ws,")"),
    ['visual basic','delphi','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x']:
            (A,ws,"=",ws,B),
    ['pydatalog','lua','perl 6','python','cython','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','swift']:
            (A,python_ws,"==",python_ws,B),
    ['javascript','php','typescript','hack']:
            (A,ws,"===",ws,B),
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

compare_bool_(Data,[Exp1,Exp2]) -->
        langs_to_output(Data,compare_bool,[
        ['nim','z3py','pydatalog','e','ceylon','cython','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (Exp1,("=="),Exp2),
        ['javascript',php]:
                (Exp1,("===";"=="),Exp2),
        ['prolog']:
                (Exp1,"=",Exp2)
        ]).

compare_int_(Data,[Var1,Var2]) -->
        langs_to_output(Data,compare_int,[
        ['r']:
                ("identical",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")"),
        ['sympy']:
                ("Eq",ws,"(",ws,Var1,ws,",",ws,Var2,ws,")"),
        ['nim','cython','lua','python','z3py','pydatalog','e','ceylon','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
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
                (Var1,ws,("#=","=";"=:="),ws,Var2),
        ['clojure']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['reverse polish notation']:
                (Var1,ws_,Var2,ws_,"="),
        ['polish notation']:
                ("=",ws_,Var1,ws_,Var2)
        ]).

less_than_(Data,[A,B,Prefix_arithmetic_langs]) -->
        langs_to_output(Data,less_than,[
        ['pascal','sympy','vhdl','visual basic .net','lua','ruby','python','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator("<",A,B)),
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

less_than_or_equal_to_(Data,[A,B,Prefix_arithmetic_langs]) -->
        langs_to_output(Data,less_than_or_equal,[
        ['pascal','sympy','vhdl','python','elixir','visual basic .net','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                infix_operator("<=",A,B),
        ['prolog']:
            (A,ws,("#=<";"=<"),ws,B),
        Prefix_arithmetic_langs:
				("(",ws,"<=",ws_,A,ws_,B,")")
        ]).

greater_than_or_equal_to_(Data,[A,B,Prefix_arithmetic_langs]) -->
        langs_to_output(Data,'greater_than_or_equal',[
        ['pascal','sympy','vhdl','elixir','visual basic .net','python','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (A,ws,">=",ws,B),
        ['prolog']:
                (A,ws,("#>=";">="),ws,B),
        Prefix_arithmetic_langs:
				("(",ws,">=",ws_,A,ws_,B,")")
        ]).

greater_than_(Data,[A,B,Prefix_arithmetic_langs]) -->
        langs_to_output(Data,'greater_than',[
        ['pascal','sympy','vhdl','elixir','python','visual basic .net','ruby','lua','scriptol', 'z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(">",A,B)),
		Prefix_arithmetic_langs:
                ("(",ws,">",ws_,A,ws_,B,ws,")")
        ]).

int_not_equal_(Data,[A,B]) -->
        langs_to_output(Data,'int_not_equal',[
        ['javascript',php,elixir]:
                (infix_operator(("!==";"!="),A,B)),
        ['java','ruby','python',cosmos,nim,'octave',r,'picat',englishscript,'perl 6','wolfram',c,'c++',d,'c#','julia','perl','haxe','cython',minizinc,'scala','swift',go,rust,vala]:
                (infix_operator("!=",A,B)),
        [rebol,scriptol,'seed7','visual basic','visual basic .net',gap,ocaml,livecode,'monkey x',vbscript,delphi]:
                (infix_operator("<>",A,B)),
        ['prolog']:
                ("(",ws,A,ws,"#\\=",ws,B,ws,")";"dif",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['common lisp',z3]:
                ("(",ws,"not",ws,"(",ws,"=",ws_,A,ws_,B,")",ws,")")
        ]).

pow_(Data,[A,B]) -->
    langs_to_output(Data,pow,[
    ['javascript','java','typescript','haxe','actionscript']:
            ("Math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['seed7','python','cython','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran']:
            (A,python_ws,"**",python_ws,B),
    ['scala']:
            ("scala.math.pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['c#']:
            ("Math",ws,".",ws,"Pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['rebol']:
            ("power",ws_,A,ws_,B),
    ['c','c++','php','hack','swift','minizinc','dart','d']:
            ("pow",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['julia','engscript','visual basic','gambas','go','ceylon','wolfram','mathematical notation']:
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


list_comprehension_1_(Data,[Variable,Array,Result]) -->
        langs_to_output(Data,list_comprehension_1,[
        ['cython','python']:
                ("[",python_ws,Result,python_ws_,"for",python_ws_,Variable,python_ws_,"in",python_ws_,Array,python_ws,"]")
        ]).

startswith_(Data,[Str1,Str2]) -->
        langs_to_output(Data,startswith,[
        ['python']:
                (Str1,python_ws,".",python_ws,"startswith",python_ws,"(",python_ws,Str2,python_ws,")"),
        ['ruby']:
                (Str1,ws,".",ws,"start_with?",ws,"(",ws,Str2,ws,")"),
        ['java','javascript']:
                (Str1,ws,".",ws,"startsWith",ws,"(",ws,Str2,ws,")"),
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
                (Str1,ws,".",ws,"endsWith",ws,"(",ws,Str2,ws,")"),
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

trim_(Data,[Str]) -->
        langs_to_output(Data,trim,[
        ['java',javascript]:
                (Str,ws,".",ws,"trim",ws,"(",ws,")"),
        ['perl 6']:
                (Str,ws,".",ws,"trim"),
        ['php']:
            "trim",ws,"(",ws,Str,ws,")",
        [clojure]:
            "(",ws,".trim",ws_,Str,ws,")",
        ['ocaml']:
            "(",ws,"String.trim",ws_,Str,ws,")"
        ]).

lowercase_(Data,[Str]) -->
        langs_to_output(Data,lowercase,[
        ['java','javascript','haxe']:
                (Str,ws,".",ws,"toLowerCase",ws,"(",ws,")"),
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
                (Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!==",ws,"-1";
                Container,ws,".",ws,"includes",ws,"(",ws,Contained,ws,")"),
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

string_contains_(Data,[Str1,Str2]) -->
        langs_to_output(Data,string_contains,[
        ['c']:
                ("(",ws,"strstr",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"NULL",ws,")"),
        ['java']:
                (Str1,ws,".",ws,"contains",ws,"(",ws,Str2,ws,")"),
        ['c#']:
                (Str1,ws,".",ws,"Contains",ws,"(",ws,Str2,ws,")"),
        ['perl']:
                ("(",ws,"index",ws,"(",ws,Str1,ws,",",ws,Str2,ws,")",ws,"!=",ws,"-1",ws,")"),
        ['javascript']:
                ("(",ws,Str1,ws,".",ws,"indexOf",ws,"(",ws,Str2,ws,")",ws,(">";"!==";"!="),ws,"-1",ws,")")
        ]).


this_(Data,[A]) -->
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

access_dict_(Data,[Dict,Dict_,Index]) -->
        langs_to_output(Data,access_dict,[
        ['javascript','c++','haxe']:
            ((Dict,ws,"[",ws,Index,ws,"]")),
        ['javascript','c++','haxe']:
            ((Dict,ws,".",ws,"get",ws,"(",ws,Index,ws,")")),
        ['perl']:
            ("$",symbol(Dict_),ws,"{",ws,Index,ws,"}")
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
			['java']:
				(Str,ws,"replaceFirst",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,")"),
			['c#']:
				("new",ws_,"Regex",ws,"(",ws,Sub,ws,")",ws,".",ws,"Replace",ws,"(",ws,Str,ws,Replacement,ws,",",ws,"1",ws,")"),
			['python']:
				(Str,python_ws,".",python_ws,"replace",python_ws,"(",python_ws,Sub,python_ws,",",python_ws,Replacement,python_ws,",",python_ws,"1",python_ws,")"),
			['javascript']:
				(Str,ws,".",ws,"replace",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,")"),
			['ruby']:
				(Str,ws,".",ws,"sub",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,")")
		]).

%replace a string (not in-place)
global_replace_in_string_(Data,[Str,Sub,Replacement]) -->
        langs_to_output(Data,global_replace_in_string,[
            ['cython','python','java']:
                (Str,python_ws,".",python_ws,"replace",python_ws,"(",python_ws,Sub,python_ws,",",python_ws,Replacement,python_ws,")"),
            ['php']:
                ("str_replace",ws,"(",ws,Sub,ws,",",ws,Replacement,ws,",",ws,Str,ws,")"),
            ['javascript']:
                (Str,ws,".",ws,"split",ws,"(",ws,Sub,ws,")",ws,".",ws,"join",ws,"(",ws,Replacement,ws,")"),
            ['c#']:
                (Str,ws,".",ws,"Replace",ws,"(",ws,Sub,ws,")"),
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

not(Data,[A]) -->
        langs_to_output(Data,'not',[
        ['cython','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','racket','common lisp','rebol','haskell','sibilant']:
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

and_(Data,[A,B]) -->
    langs_to_output(Data,'and',[
    ['javascript','ats','ruby','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r']:
            (A,ws,"&&",ws,B),
    ['pydatalog']:
            (A,ws,"&",ws,B),
    ['seed7','vhdl','cython','python','lua','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','php']:
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
    ['z3py','pysmt']:
            ("And",python_ws,"(",python_ws,A,python_ws,",",python_ws,B,python_ws,")")
    ]).

sort_in_place_(Data,[List]) -->
        langs_to_output(Data,sort_in_place,[
			['python','javascript']:
				(List,python_ws,".",python_ws,"sort",python_ws,"(",python_ws,")"),
			['php']:
				("sort",ws,"(",ws,List,ws,")"),
			['lua']:
				("table",ws,".",ws,"sort",ws,"(",ws,List,ws,")")
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
            (Var1,ws,";",ws,Var2)
    ]).

grammar_and_(Data,[Var1,Var2]) -->
    langs_to_output(Data,grammar_and,[
	['definite clause grammars']:
            (Var1,ws,",",ws,Var2),
    ['lpeg']:
            (Var1,ws,"*",ws,Var2),
    ['nearley','abnf','peg.js','antlr','marpa','wirth syntax notation']:
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
    ['javascript','katahdin','perl 6','ruby','wolfram','chapel','elixir','frink',ooc,'picat','janus',processing,'pike',nools,pawn,matlab,hack,'gosu',rust,'autoit',autohotkey,typescript,ceylon,'groovy',d,'octave',awk,'julia','scala','f#','swift','nemerle','vala',go,'perl','java',haskell,'haxe',c,'c++','c#',dart,r]:
        (Var1,ws,"||",ws,Var2),
    [cosmos,'cython','vhdl','python','lua','seed7','pydatalog',livecode,englishscript,'cython',gap,'mathematical notation',genie,idp,'maxima',engscript,ada,newlisp,ocaml,nim,coffeescript,pascal,delphi,'erlang',rebol,php]:
        (Var1,python_ws_,"or",python_ws_,Var2),
    ['fortran']:
        (Var1,ws_,".OR.",ws_,Var2),
    [z3,clips,'clojure','common lisp','emacs lisp','clojure',racket]:
        ("(",ws,"or",ws_,Var1,ws_,Var2,ws,")"),
    ['prolog']:
        (Var1,ws,";",ws,Var2),
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
		['perl']:
			("sort",ws,"(",ws,List,ws,")"),
		['python','cython']:
			("sorted",python_ws,"(",python_ws,List,python_ws,")"),
		['prolog']:
			("(",ws,"sort",ws_,"$",ws,"(",ws,List,ws,")",ws,")"),
		['haskell']:
			("(",ws,"sort",ws_,List,ws,ws,")"),
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
	]).
