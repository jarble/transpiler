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
    {memberchk(Lang,[python,cosmos,seed7,pydatalog,livecode,englishscript,cython,gap,'mathematical notation',genie,idp,maxima,engscript,ada,newlisp,ocaml,nim,coffeescript,pascal,delphi,erlang,rebol,lua,php,crosslanguage,ruby])}->
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
        ({memberchk(Lang,['python','cython','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','lua','racket','common lisp','crosslanguage','rebol','haskell','sibilant'])}->
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
	{memberchk(Lang,['python','seed7','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','lua','php','crosslanguage','ruby'])}->
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
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,">",A,B);
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,">",ws_,A,ws_,B,ws,")";
        {not_defined_for(Data,'>')}).

expr(Data,bool,greater_than_or_equal(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,">=",A,B);
        {not_defined_for(Data,'>=')}).
                
expr(Data,bool,less_than_or_equal(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
                infix_operator(Data,int,"<=",A,B);
        {not_defined_for(Data,'<=')}).
                
expr(Data,bool,less_than(A,B)) -->
        {Data = [Lang|_]},
        ({memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','r','bc','visual basic','visual basic .net'])}->
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
                Exp1,ws,Symbol,ws,Exp2;
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
			"(",ws,A,ws,"**",ws,B,ws,")";
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
			AString,ws,".",ws,"split",ws,"(",ws,Separator,ws,")";
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
                Separator,ws,".",ws,"join",ws,"(",ws,Array,ws,")";
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
                "math",ws,".",ws,"sqrt",ws,"(",ws,X,ws,")";
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
                "[",ws,Result,ws_,"for",ws_,Variable,ws_,"in",ws_,Array,ws_,"if",ws_,Condition,ws,"]";
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
        {memberchk(Lang,['python','c','php','c#','minizinc','c++','picat','haskell','dart'])}->
                AString,ws,"[",ws,Index,ws,"]";
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
			"self",ws,".",ws,A;
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
	{not_defined_for(Data,'call_constructor')}).


expr(Data,int,strlen(A1)) -->
        {
                Data = [Lang|_],
                A = parentheses_expr(Data,string,A1)
        },
		({memberchk(Lang,['crosslanguage'])}->
                "(",ws,"strlen",ws_,A,ws_,"b",ws,")";
        {memberchk(Lang,['python','go','erlang','nim'])}->
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


expr(Data,regex,regex(A1)) -->
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
		{not_defined_for(Data,'regex')}).

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
		({memberchk(Lang,['crosslanguage'])}->
                "(",ws,"array_length",ws_,A,ws,")";
        {memberchk(Lang,['lua'])}->
                "#",A;
        {memberchk(Lang,['python','cython','go'])}->
                "len",ws,"(",ws,A,ws,")";
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
