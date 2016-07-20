
expr(Data,[array,string],dict_keys(A1,Type1)) -->
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
 
expr(Data,string,global_replace_in_string(Str1,To_replace1,Replacement1)) -->
        {
                Str = parentheses_expr(Data,string,Str1),
                To_replace = parentheses_expr(Data,string,To_replace1),
                Replacement = parentheses_expr(Data,string,Replacement1)
        },
        langs_to_output(Data,global_replace_in_string,[
            ['python','java']:
                (Str,python_ws,".",python_ws,"replace",python_ws,"(",python_ws,To_replace,python_ws,",",python_ws,Replacement,python_ws,")"),
            ['php']:
                ("str_replace",ws,"(",ws,To_replace,ws,",",ws,Replacement,ws,",",ws,Str,ws,")"),
            ['javascript']:
                (Str,ws,".",ws,"split",ws,"(",ws,To_replace,ws,")",ws,".",ws,"join",ws,"(",ws,Replacement,ws,")"),
            ['c#']:
                (Str,ws,".",ws,"Replace",ws,"(",ws,To_replace,ws,")"),
            ['ruby']:
                (Str,ws,".",ws,"gsub",ws,"(",ws,To_replace,ws,")"),
            ['swift']:
                (Str,ws,".",ws,"stringByReplacingOccurrencesOfString",ws,"(",ws,To_replace,ws,",",ws,"withString:",ws,Replacement,ws,")")
        ]).
 
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
 
expr(Data,int,index_of_substring(Str1_,Str2_)) -->
        {
                String = parentheses_expr(Data,string,Str1_),
                Substring = parentheses_expr(Data,string,Str2_)
        },
    langs_to_output(Data,index_of_substring,[
    [javascript,java]:
        (String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")"),
    [d]:
        (String,ws,".",ws,"indexOfAny",ws,"(",ws,Substring,ws,")"),
    ['c#']:
        (String,ws,".",ws,"IndexOf",ws,"(",ws,Substring,ws,")"),
    ['python']:
        (String,python_ws,".",python_ws,"index",python_ws,"(",python_ws,Substring,python_ws,")"),
    [go]:
        ("strings",ws,".",ws,"Index",ws,"(",ws,String,ws,",",ws,Substring,ws,")"),
    [perl]:
        ("index",ws,"(",ws,String,ws,",",ws,Substring,ws,")")
    ]).
 
expr(Data,int,index_in_array(Container_,Contained_,Type)) -->
        {
                Container = parentheses_expr(Data,[array,Type],Container_),
                Contained = parentheses_expr(Data,Type,Contained_)
        },
    index_in_array(Data,Container,Contained).
 
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
 
expr(Data,bool,not(A1)) -->
        {
                A = parentheses_expr(Data,bool,A1)
        },
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
 
expr(Data,bool,int_not_equal(A_,B_)) -->
        {A = parentheses_expr(Data,int,A_),
        B = expr(Data,int,B_)},
        langs_to_output(Data,'int_not_equal',[
        [javascript,php,elixir]:
                (infix_operator(("!==";"!="),A,B)),
        [java,'ruby',python,cosmos,nim,octave,r,picat,englishscript,'perl 6',wolfram,c,'c++',d,'c#',julia,perl,haxe,cython,minizinc,scala,swift,go,rust,vala]:
                (infix_operator("!=",A,B)),
        [rebol,scriptol,seed7,'visual basic','visual basic .net',gap,ocaml,livecode,'monkey x',vbscript,delphi]:
                (infix_operator("<>",A,B)),
        ['prolog']:
                ("(",ws,A,ws,"#\\=",ws,B,ws,")";"dif",ws,"(",ws,A,ws,",",ws,B,ws,")"),
        ['common lisp',z3]:
                ("(",ws,"not",ws,"(",ws,"=",ws_,A,ws_,B,")",ws,")")
        ]).                
expr(Data,bool,greater_than(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        langs_to_output(Data,'greater_than',[
        ['pascal','elixir','python','visual basic .net','ruby','lua','scriptol', 'z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator(">",A,B)),
		Prefix_arithmetic_langs:
                ("(",ws,">",ws_,A,ws_,B,ws,")")
        ]).
expr(Data,bool,greater_than_or_equal(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        langs_to_output(Data,'greater_than_or_equal',[
        ['pascal','elixir','visual basic .net','python','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (A,ws,">=",ws,B),
        ['prolog']:
                (A,ws,("#>=";">="),ws,B),
        Prefix_arithmetic_langs:
				("(",ws,">=",ws_,A,ws_,B,")")
        ]).                
expr(Data,bool,less_than_or_equal(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        langs_to_output(Data,less_than_or_equal,[
        ['pascal','python','elixir','visual basic .net','lua','ruby','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                infix_operator("<=",A,B),
        ['prolog']:
            (A,ws,("#=<";"=<"),ws,B),
        Prefix_arithmetic_langs:
				("(",ws,"<=",ws_,A,ws_,B,")")
        ]).                
expr(Data,bool,less_than(A_,B_)) -->
        {
            A = expr(Data,int,A_),
            B = parentheses_expr(Data,int,B_),
            prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        langs_to_output(Data,less_than,[
        ['pascal','visual basic .net','lua','ruby','python','scriptol','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','c#','nemerle','awk','java','perl','haxe','php','haskell','go','r','bc','visual basic']:
                (infix_operator("<",A,B)),
        Prefix_arithmetic_langs:
                ("(",ws,"<",ws_,A,ws_,B,ws,")")
        ]).
 
expr(Data,bool,compare(int,Var1_,Var2_)) -->
        {Var1=parentheses_expr(Data,int,Var1_),Var2=expr(Data,int,Var2_)},
        langs_to_output(Data,compare_int,[
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
                (Var1,ws,("#=","=";"=:="),ws,Var2),
        ['clojure']:
                ("(",ws,"=",ws_,Var1,ws_,Var2,ws,")"),
        ['reverse polish notation']:
                (Var1,ws_,Var2,ws_,"="),
        ['polish notation']:
                ("=",ws_,Var1,ws_,Var2)
        ]).        
         
expr(Data,bool,compare(bool,Exp1_,Exp2_)) -->
        {
            Exp1 = parentheses_expr(Data,bool,Exp1_),
            Exp2 = expr(Data,bool,Exp2_)
        },
        langs_to_output(Data,compare,[
        ['nim','z3py','pydatalog','e','ceylon','python','perl 6','englishscript','cython','mathematical notation','dafny','wolfram','d','rust','r','minizinc','frink','picat','pike','pawn','processing','c++','ceylon','coffeescript','octave','swift','awk','julia','perl','groovy','erlang','haxe','scala','java','vala','dart','c#','c','go','haskell']:
                (Exp1,("=="),Exp2),
        [javascript,php]:
                (Exp1,("===";"=="),Exp2),
        [prolog]:
                (Exp1,"=",Exp2)
        ]).
 
expr(Data,bool,compare(string,Exp1_,Exp2_)) -->
        {
                A = parentheses_expr(Data,string,Exp1_),
                B = expr(Data,string,Exp2_)
        },
    langs_to_output(Data,compare,[
    ['r']:
            ("identical",ws,"(",ws,A,ws,",",ws,B,ws,")"),
    ['emacs lisp']:
            ("(",ws,"string=",ws_,A,ws_,B,ws,")"),
    ['clojure']:
            ("(",ws,"=",ws_,A,ws_,B,ws,")"),
    ['visual basic','delphi','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x']:
            (A,ws,"=",ws,B),
    ['pydatalog','perl 6','python','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','haskell','haxe','dart','swift']:
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
 
expr(Data,string,concatenate_string(A_,B_)) -->
        {
                B = expr(Data,string,B_),
                A = parentheses_expr(Data,string,A_)
        },
        concatenate_string(Data,A,B).
 
expr(Data,int,mod(A_,B_)) -->
    {
        A = parentheses_expr(Data,int,A_),
        B = expr(Data,int,B_)
    },
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
 
expr(Data,int,arithmetic(Exp1_,Exp2_,Symbol)) -->
        {
                Exp1 = parentheses_expr(Data,int,Exp1_),
                Exp2 = expr(Data,int,Exp2_),
                member(Symbol,["+","-","*","/"]),
                prefix_arithmetic_langs(Prefix_arithmetic_langs)
        },
        langs_to_output(Data,arithmetic,[
        ['java', 'visual basic .net', 'python', 'ruby', 'lua','logtalk', 'prolog', 'cosmos','pydatalog','e','livecode','vbscript','monkey x','englishscript','gap','pop-11','dafny','janus','wolfram','chapel','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','b-prolog','agda','picat','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','erlang','gambas','hack','c++','matlab','rebol','red','go','awk','haskell','perl','javascript','c#','php','r','haxe','visual basic','vala','bc']:
                (Exp1,python_ws,Symbol,python_ws,Exp2),
		Prefix_arithmetic_langs:
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
    ['seed7','cython','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','perl','perl 6','fortran']:
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
    split(Data,AString,Separator).

expr(Data,string,reverse_list_in_place(List_,Type)) -->
        {
                Data = [Lang|_],
                List = parentheses_expr(Data,[array,Type],List_)
        },
        ({Lang='javascript'}->
			(List,".",reverse,"(",ws,List,ws,")");
		langs_to_output(Data,reverse_list_in_place,[])
        ).

expr(Data,[array,Type],concatenate_arrays(A1_,A2_)) -->
        {
                A1 = parentheses_expr(Data,[array,Type],A1_),
                A2 = parentheses_expr(Data,[array,Type],A2_)
        },
        concatenate_arrays(Data,A1,A2).
 
expr(Data,string,join(Exp1,Exp2)) -->
        {
                Array = parentheses_expr(Data,[array,string],Exp1),
                Separator = parentheses_expr(Data,string,Exp2)
        },
        join(Data,Array,Separator).
         
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
        ['python','cython']:
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
        charAt(Data,AString,Index).
 
expr(Data,string,endswith(Str1_,Str2_)) -->
        {
                Str1 = parentheses_expr(Data,string,Str1_),
                Str2 = expr(Data,string,Str2_)
        },
        langs_to_output(Data,endswith,[
        [java,javascript]:
                (Str1,ws,".",ws,"endsWith",ws,"(",ws,Str2,ws,")"),
        ['python']:
                (Str1,python_ws,".",python_ws,"endswith",python_ws,"(",python_ws,Str2,python_ws,")"),
        ['c#']:
                (Str1,ws,".",ws,"EndsWith",ws,"(",ws,Str2,ws,")")
        ]).

expr(Data,string,reverse_list(List_,Type)) -->
        {
                List = parentheses_expr(Data,[array,Type],List_)
        },
        reverse_list(Data,List).
        
 
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
        access_array(Data,Array,Index).
 
 
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
        strlen(Data,A).
 
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
        array_length(Data,A).
