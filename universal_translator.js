/*
translateLang is the most important function in this file.

Use TurboTop to keep the output window visible.
key_value_separator(
        {memberchk(Lang,['python','picat','go','dart','visual basic .net','d','c#','frink','swift','javascript','typescript','php','perl','lua','ruby','julia','haxe','c++','scala','octave','elixir','wolfram'])}->
                ",";
        {memberchk(Lang,['java'])}->
                ";";
        {memberchk(Lang,['rebol'])}->
                ws_;
        {not_defined_for(Data,'key_value_separator')}).
initializer_list_separator(
        {memberchk(Lang,['python','erlang','nim','seed7','vala','polish notation','reverse polish notation','d','frink','fortran','chapel','octave','julia','english','pascal','delphi','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','ruby','rebol','polish notation','swift','java','picat','c#','go','lua','c++','c','visual basic .net','visual basic','php','scala','perl','wolfram'])}->
                ",";
        {memberchk(Lang,['rebol'])}->
                ws_;
        {not_defined_for(Data,'initializer_list_separator')}).
true(
        {memberchk(Lang,['java','livecode','gap','dafny','z3','perl 6','chapel','c','frink','elixir','english','pascal','minizinc','engscript','picat','rust','clojure','nim','hack','ceylon','d','groovy','coffeescript','typescript','octave','prolog','julia','f#','swift','nemerle','vala','c++','dart','javascript','ruby','erlang','c#','haxe','go','ocaml','lua','scala','php','rebol'])}->
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
        {not_defined_for(Data,'true')}).
false(
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
        {not_defined_for(Data,'false')}).
char(
        {memberchk(Lang,['java','c','c++','seed7','c#'])}->
                "char";
        {memberchk(Lang,['visual basic .net','haskell'])}->
                "Char";
        {memberchk(Lang,['swift'])}->
                "Character";
        {memberchk(Lang,['rebol'])}->
                "char!";
        {memberchk(Lang,['fortran'])}->
                "CHARACTER";
        {memberchk(Lang,['go'])}->
                "rune";
        {not_defined_for(Data,'char')}).
string(
        {memberchk(Lang,['z3','java','ceylon','gambas','dart','gosu','groovy','scala','pascal','swift','ruby','haxe','haskell','visual basic','visual basic .net','monkey x'])}->
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
        {not_defined_for(Data,'string')}).
void(
        {memberchk(Lang,['engscript','seed7','php','hy','cython','go','pike','objective-c','java','c','c++','c#','vala','typescript','d','javascript','lua','dart'])}->
                "void";
        {memberchk(Lang,['haxe','swift'])}->
                "Void";
        {memberchk(Lang,['scala'])}->
                "Unit";
        {not_defined_for(Data,'void')}).
boolean(
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
        {not_defined_for(Data,'boolean')}).
double(
        {memberchk(Lang,['java','c','c#','c++','dart','vala'])}->
                "double";
        {memberchk(Lang,['go'])}->
                "float64";
        {memberchk(Lang,['haxe'])}->
                "Float";
        {memberchk(Lang,['javascript','lua'])}->
                "number";
        {memberchk(Lang,['ruby','minizinc','php','python'])}->
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
        {not_defined_for(Data,'double')}).
array_access_separator(
        {memberchk(Lang,['c#','minizinc','fortran','julia','visual basic','visual basic .net','octave'])}->
                ",";
        {memberchk(Lang,['python','pydatalog','d','lua','picat','janus','nim','autoit','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','ruby','go','c++','php','haxe','c','swift'])}->
                "][";
        {memberchk(Lang,['haskell'])}->
                "!!";
        {memberchk(Lang,['scala'])}->
                ")(";
        {memberchk(Lang,['frink'])}->
                "@";
        {memberchk(Lang,['rebol'])}->
                "/";
        {memberchk(Lang,['perl 6'])}->
                ";";
        {not_defined_for(Data,'array_access_separator')}).
(
        {not_defined_for(Data,'')}).
grammar_output(
        {memberchk(Lang,['peg.js'])}->
                Name,ws,"=",ws,Value,ws,"{",ws,"return",ws_,Output,ws,";",ws,"}";
        {memberchk(Lang,['nearley'])}->
                Name,ws,"->",ws,Value,ws,"{%",ws,"function",ws,"(",ws,"data",ws,")",ws,"{",ws,"return",ws_,Output,ws,";",ws,"}",ws,"%}";
        {not_defined_for(Data,'grammar_output')}).
grammar_statement(
        {memberchk(Lang,['waxeye'])}->
                Name,ws,"<-",ws,Value;
        {memberchk(Lang,['nearley'])}->
                Name,ws,"->",ws,Value;
        {memberchk(Lang,['earley-parser-js'])}->
                "\"",ws,Name,ws,"->",ws,Value,ws,"\"";
        {memberchk(Lang,['parslet'])}->
                "rule",ws,"(",ws,":",ws,Name,ws,")",ws,"{",ws,Value,ws,"}";
        {memberchk(Lang,['marpa'])}->
                Name,ws,"::=",ws,Value;
        {memberchk(Lang,['ebnf'])}->
                Name,ws,"=",ws,Value,ws,";";
        {memberchk(Lang,['yacc','jison','antlr'])}->
                Name,ws,":",ws,Value,ws,";";
        {memberchk(Lang,['peg.js','lpeg','abnf','ometa'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['wirth syntax notation'])}->
                Name,ws,"=",ws,Value,ws,".";
        {memberchk(Lang,['perl 6'])}->
                "token",ws_,Name,ws,"{",ws,Value,ws,"}";
        {memberchk(Lang,['prolog'])}->
                Name,ws,"-->",ws,Value,ws,".";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws_,Value;
        {memberchk(Lang,['treetop'])}->
                "rule",ws_,Name,ws_,Value,ws_,"end";
        {memberchk(Lang,['hampi'])}->
                "cfg",ws_,Name,ws,":=",ws,Value,ws,";";
        {memberchk(Lang,['parboiled'])}->
                "public",ws_,"Rule",ws_,Name,ws,"(",ws,")",ws,"{",ws,"return",ws_,Value,ws,";",ws,"}";
        {memberchk(Lang,['yapps'])}->
                "rule",ws_,Name,ws,":",ws_,Value;
        {not_defined_for(Data,'grammar_statement')}).
statement(
        {memberchk(Lang,['lua'])}->
                A;
        {memberchk(Lang,['octave'])}->
                A;
        {memberchk(Lang,['minizinc'])}->
                A;
        {memberchk(Lang,['englishscript','seed7','vbscript','java','nim','scala','python','dart','javascript','typescript','c#','php','haxe','ruby','c++','visual basic .net','go','swift','rebol','fortran'])}->
                A;
        {memberchk(Lang,['c','r','julia','perl'])}->
                A;
        {memberchk(Lang,['picat'])}->
                A;
        {memberchk(Lang,['z3','prolog','haskell','erlang','common lisp','emacs lisp','minizinc'])}->
                A;
        {memberchk(Lang,['mathematical notation','polish notation','reverse polish notation'])}->
                A;
        {not_defined_for(Data,'statement')}).
statement_with_semicolon(
        {memberchk(Lang,['c','php','dafny','chapel','katahdin','frink','falcon','aldor','idp','processing','maxima','seed7','drools','engscript','openoffice basic','ada','algol 68','d','ceylon','rust','typescript','octave','autohotkey','pascal','delphi','javascript','pike','objective-c','ocaml','java','scala','dart','php','c#','c++','haxe','awk','bc','perl','perl 6','nemerle','vala'])}->
                Var1,";";
        {memberchk(Lang,['minizinc'])}->
                Var1;
        {memberchk(Lang,['visual basic .net','lua','swift','rebol','fortran','python','go','picat','julia'])}->
                Var1;
        {memberchk(Lang,['prolog'])}->
                Var1;
        {memberchk(Lang,['mathematical notation','polish notation','reverse polish notation'])}->
                Var1;
        {memberchk(Lang,['z3'])}->
                Var1;
        {memberchk(Lang,['ruby'])}->
                Var1;
        {memberchk(Lang,['haskell','erlang','common lisp'])}->
                Var1;
        {not_defined_for(Data,'statement_with_semicolon')}).
macro(
        {memberchk(Lang,['racket'])}->
                "(",ws,"define-syntax-rule",ws_,"(",ws,Name,ws_,Params,ws,")",ws_,"body",ws,")";
        {memberchk(Lang,['c'])}->
                "#define",ws_,Name,ws,"(",ws,Params,ws,")",ws_,"body";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"defmacro",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,"body",ws,")";
        {memberchk(Lang,['rust'])}->
                "macro_rules!",ws_,Name,ws,"{",ws,"(",ws,Params,ws,")",ws,"=>",ws,"{",ws,"body",ws,"}",ws,";",ws,"}";
        {memberchk(Lang,['z3'])}->
                "(",ws,"define-fun",ws_,Name,ws,"(",ws,Params,ws,")",ws_,"type",ws_,"body",ws,")";
        {memberchk(Lang,['nearley'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,"->",ws,"body";
        {not_defined_for(Data,'macro')}).
one_or_more(
        {memberchk(Lang,['marpa','peg.js','perl 6','antlr'])}->
                "(",ws,A,ws,")",ws,"+";
        {memberchk(Lang,['rebol'])}->
                "[",ws,"some",ws,"[",ws,A,ws,"]",ws,"]";
        {memberchk(Lang,['abnf'])}->
                "1",ws,"*",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['parslet'])}->
                "(",ws,A,ws,")",ws,".",ws,"repeat",ws,"(",ws,"1",ws,")";
        {memberchk(Lang,['lpeg'])}->
                "(",ws,A,ws,"^",ws,"1",ws,")";
        {memberchk(Lang,['parboiled'])}->
                "OneOrMore",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'one_or_more')}).
zero_or_more(
        {memberchk(Lang,['lpeg'])}->
                "(",ws,A,ws,"^",ws,"0",ws,")";
        {memberchk(Lang,['pypeg'])}->
                "optional",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['waxeye'])}->
                "?",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ebnf'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['marpa','peg.js','perl 6','antlr'])}->
                "(",ws,A,ws,")",ws,"*";
        {memberchk(Lang,['abnf'])}->
                "*",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "[",ws,"any",ws,"[",ws,A,ws,"]",ws,"]";
        {memberchk(Lang,['parslet'])}->
                "(",ws,A,ws,")",ws,".",ws,"repeat",ws,"(",ws,"0",ws,")";
        {not_defined_for(Data,'zero_or_more')}).
grammar_parameter(
        {memberchk(Lang,['peg.js'])}->
                Name,ws,":",ws,Type;
        {memberchk(Lang,['lpeg'])}->
                "lpeg.V"",ws,Type,ws,""";
        {memberchk(Lang,['parslet'])}->
                Type,ws,".",ws,"as",ws,"(",ws,Name,ws,")";
        {memberchk(Lang,['marpa','yacc','ebnf','rebol','prolog','abnf','treetop'])}->
                Type;
        {memberchk(Lang,['perl 6'])}->
                "<",ws,Type,ws,">";
        {memberchk(Lang,['hampi'])}->
                Type;
        {not_defined_for(Data,'grammar_parameter')}).
grammar(
        {memberchk(Lang,['peg.js','ebnf','nearley','marpa','rebol'])}->
                Var1;
        {memberchk(Lang,['antlr'])}->
                "grammar",ws_,Name,ws,";",ws,Var1;
        {memberchk(Lang,['ometa'])}->
                "ometa",ws_,Name,ws,"{",ws,Var1,ws,"}";
        {memberchk(Lang,['perl 6'])}->
                "grammar",ws_,Name,ws,"{",ws,Var1,ws,"}";
        {memberchk(Lang,['lpeg'])}->
                Name,ws,"=",ws,"lpeg",ws,".",ws,"P",ws,"{",ws,Var1,ws,"}";
        {memberchk(Lang,['parslet'])}->
                "class",ws_,Name,ws,">",ws,Parslet,ws_,Var1,ws_,"end";
        {memberchk(Lang,['treetop'])}->
                "grammar",ws_,Name,ws_,Var1,ws_,"end";
        {memberchk(Lang,['earley-parser-js'])}->
                "var",ws_,"grammar",ws,"=",ws,"new",ws_,"tinynlp",ws,".",ws,"Grammar",ws,"(",ws,"[",ws,Var1,ws,"]",ws,")",ws,";";
        {memberchk(Lang,['parboiled'])}->
                "class",ws_,"CalculatorParser",ws_,"extends",ws_,"BaseParser<Object>",ws,"{",ws,Var1,ws,"}";
        {not_defined_for(Data,'grammar')}).
nameless_grammar_parameter(
        {memberchk(Lang,['peg.js','yapps','hampi','antlr','parslet','nearley','marpa','yacc','ebnf','rebol','prolog','abnf','treetop'])}->
                Type;
        {memberchk(Lang,['lpeg'])}->
                "lpeg.V"",ws,Type,ws,""";
        {memberchk(Lang,['perl 6'])}->
                "<",ws,Type,ws,">";
        {memberchk(Lang,['parboiled'])}->
                Type,ws,"(",ws,")";
        {not_defined_for(Data,'nameless_grammar_parameter')}).
grammar_string_literal(
        {memberchk(Lang,['peg.js','parboiled','earley-parser-js','antlr','lpeg','marpa','yacc','ebnf','rebol','abnf','ometa','treetop'])}->
                The_str;
        {memberchk(Lang,['parslet'])}->
                "str",ws,"(",ws,The_str,ws,")";
        {not_defined_for(Data,'grammar_string_literal')}).
initialize_instance_variable(
        {memberchk(Lang,['java','c#'])}->
                "private",ws_,Type,ws_,Name;
        {memberchk(Lang,['php'])}->
                "private",ws_,Name;
        {memberchk(Lang,['c++','d'])}->
                Type,ws_,Name;
        {memberchk(Lang,['haxe','swift'])}->
                "var",ws_,Name,ws,":",ws,Type;
        {memberchk(Lang,['visual basic .net'])}->
                "Private",ws_,Name,ws_,"As",ws_,Type;
        {memberchk(Lang,['vbscript'])}->
                "Private",ws_,Name;
        {not_defined_for(Data,'initialize_instance_variable')}).
initialize_instance_variable_with_value(
        {memberchk(Lang,['java','c#'])}->
                "private",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['php'])}->
                "private",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c++'])}->
                Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['python'])}->
                "self",ws,".",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['haxe','swift'])}->
                "var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['ruby'])}->
                "@",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['visual basic .net'])}->
                "Private",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
        {not_defined_for(Data,'initialize_instance_variable_with_value')}).
enum(
        {memberchk(Lang,['c'])}->
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
_enum_list(
        {memberchk(Lang,['java','seed7','vala','perl 6','swift','c++','c#','visual basic .net','haxe','fortran','typescript','c','ada','scala'])}->
                A;
        {memberchk(Lang,['go'])}->
                A,ws,"=",ws,"iota";
        {memberchk(Lang,['python'])}->
                A,ws,"=",ws,"(",ws,")";
        {not_defined_for(Data,'_enum_list')}).
enum_list(
        {memberchk(Lang,['java','seed7','vala','c++','c#','c','typescript','fortran','ada','scala'])}->
                A,ws,",",ws,B;
        {memberchk(Lang,['haxe'])}->
                A,ws,";",ws,B;
        {memberchk(Lang,['go','perl 6','swift','visual basic .net'])}->
                A,ws_,B;
        {not_defined_for(Data,'enum_list')}).
list_comprehension(
        {memberchk(Lang,['python','cython'])}->
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
        {memberchk(Lang,['ruby'])}->
                Array,ws,".",ws,"select",ws,"{",ws,"|",ws,Variable,ws,"|",ws,Condition,ws,"}",ws,".",ws,"collect",ws,"{",ws,"|",ws,Variable,ws,"|",ws,Result,ws,"}";
        {memberchk(Lang,['scala'])}->
                "(",ws,"for",ws,"(",ws,Variable,ws,"<-",ws,Array,ws_,"if",ws_,Condition,ws,")",ws,"yield",ws_,Result,ws,")";
        {memberchk(Lang,['groovy'])}->
                "array.grep",ws,"{",ws,Variable,ws,"->",ws,Condition,ws,"}.collect",ws,"{",ws,Variable,ws,"->",ws,Result,ws,"}";
        {memberchk(Lang,['dart'])}->
                Array,ws,".",ws,"where",ws,"(",ws,Variable,ws,"=>",ws,Condition,ws,")",ws,".",ws,"map",ws,"(",ws,Variable,ws,"=>",ws,Result,ws,")";
        {memberchk(Lang,['picat'])}->
                "[",ws,Result,ws,":",ws,Variable,ws_,"in",ws_,Array,ws,",",ws,Condition,ws,"]";
        {not_defined_for(Data,'list_comprehension')}).
list_comprehension_2(
        {memberchk(Lang,['python','julia'])}->
                "[",ws,Result,ws_,"for",ws_,Variable,ws_,"in",ws_,Array,ws,"]";
        {memberchk(Lang,['haskell'])}->
                "[",ws,Result,ws,"|",ws,Variable,ws,"<-",ws,Array,ws,"]";
        {not_defined_for(Data,'list_comprehension_2')}).
array_type(
        {memberchk(Lang,['java','c','c#','haxe','c++'])}->
                Var1,Var2;
        {memberchk(Lang,['minizinc'])}->
                "array",ws,"[",ws,Var1,ws,"]",ws_,"of",ws_,Var1;
        {memberchk(Lang,['go'])}->
                Var2,Var1;
        {memberchk(Lang,['seed7'])}->
                Var2,ws_,Var1;
        {memberchk(Lang,['dart'])}->
                "array_type",ws,"=",ws,"List<",ws,Var1,ws,">";
        {memberchk(Lang,['swift'])}->
                "[",ws,Var1,ws,"]";
        {memberchk(Lang,['z3'])}->
                "(",ws,"Array",ws_,Var1,ws_,Var1,ws,")";
        {memberchk(Lang,['python','picat'])}->
                Var1;
        {memberchk(Lang,['lua'])}->
                Var1;
        {memberchk(Lang,['javascript','ruby'])}->
                Var1;
        {memberchk(Lang,['php'])}->
                Var1;
        {memberchk(Lang,['rebol'])}->
                Var1;
        {memberchk(Lang,['octave'])}->
                Var1;
        {memberchk(Lang,['erlang'])}->
                Var1;
        {not_defined_for(Data,'array_type')}).
constructor(
        {memberchk(Lang,['rebol'])}->
                "new:",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,"make",ws_,"self",ws,"[",ws,Body,ws,"]",ws,"]";
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"constructor",ws_,Name,ws_,Params,ws_,Body,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Sub",ws_,"New",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Sub";
        {memberchk(Lang,['python'])}->
                "def",ws_,"__init__",ws,"(",ws,"",ws,"self",ws,",",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['java','c#','vala'])}->
                "public",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['swift'])}->
                "init",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['javascript'])}->
                "constructor",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"initialize",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['php'])}->
                "function",ws_,"construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,"new",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,"new",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++','dart'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['d'])}->
                "this",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['chapel'])}->
                "proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {not_defined_for(Data,'constructor')}).
set_array_size(
        {memberchk(Lang,['scala'])}->
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
typeless_parameter(
        {memberchk(Lang,['haskell','livecode','typescript','visual basic .net','rebol','prolog','haxe','scheme','python','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','python','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','julia','prolog','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','lua','ruby','r','bc'])}->
                Name;
        {memberchk(Lang,['java','c#'])}->
                "Object",ws_,Name;
        {memberchk(Lang,['c++'])}->
                "auto",ws_,Name;
        {memberchk(Lang,['perl'])}->
                Name,ws,"=",ws,"push",ws,";";
        {not_defined_for(Data,'typeless_parameter')}).
asin(
        {memberchk(Lang,['java','javascript','ruby','haxe','typescript'])}->
                "Math",ws,".",ws,"asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','lua'])}->
                "math",ws,".",ws,"asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','seed7','c','fortran','d','php','hack','dart','scala'])}->
                "asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic','visual basic .net'])}->
                "Math",ws,".",ws,"Asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['gambas'])}->
                "Asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['erlang'])}->
                "math",ws,":",ws,"asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "std",ws,"::",ws,"asin",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "ArcSin",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"asin",ws_,A,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/asin",ws_,A,ws,")";
        {not_defined_for(Data,'asin')}).
typeless_function(
        {memberchk(Lang,['visual basic .net','vbscript'])}->
                "Function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript','php','typescript'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['python'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['englishscript'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,"\n",ws,Body,ws,"\n",ws,"end";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['c#'])}->
                "public",ws_,"static",ws_,"object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++','d'])}->
                "auto",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['java'])}->
                "public",ws_,"static",ws_,"Object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,ws,"}";
        {memberchk(Lang,['lua'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['octave'])}->
                "function",ws_,"retval",ws,"=",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"endfunction";
        {memberchk(Lang,['prolog'])}->
                Name,ws,"(",ws,Params,ws,")",ws_,":-",ws_,Body,ws,".";
        {memberchk(Lang,['picat'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"retval",ws,"=>",ws,Body,ws,".";
        {memberchk(Lang,['erlang'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Body,ws,".";
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['wolfram'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['dart'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haskell'])}->
                Name,ws_,Params,ws,"=",ws,Body;
        {memberchk(Lang,['pydatalog'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,"=",ws,Body;
        {memberchk(Lang,['emacs lisp'])}->
                "(",ws,"defun",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,Body,ws,")";
        {not_defined_for(Data,'typeless_function')}).
acos(
        {memberchk(Lang,['java','javascript','ruby','haxe','typescript'])}->
                "Math",ws,".",ws,"acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic','visual basic .net'])}->
                "Math",ws,".",ws,"Acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','lua'])}->
                "math",ws,".",ws,"acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','seed7','c','fortran','d','php','scala'])}->
                "acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['gambas'])}->
                "Acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "std",ws,"::",ws,"acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['erlang'])}->
                "math",ws,":",ws,"acos",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "ArcCos",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"acos",ws_,A,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/acos",ws_,A,ws,")";
        {not_defined_for(Data,'acos')}).
atan(
        {memberchk(Lang,['java','javascript','ruby','haxe','typescript'])}->
                "Math",ws,".",ws,"atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','lua'])}->
                "math",ws,".",ws,"atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['erlang'])}->
                "math",ws,":",ws,"atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','seed7','c','fortran','d','php','scala'])}->
                "atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic','visual basic .net'])}->
                "Math",ws,".",ws,"Atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['gambas'])}->
                "Atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "std",ws,"::",ws,"atan",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "ArcTan",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"atan",ws_,A,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/atan",ws_,A,ws,")";
        {not_defined_for(Data,'atan')}).
less_than(
        {memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','elixir','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','ruby','r','bc','visual basic','visual basic .net'])}->
                A,ws,"<",ws,B;
        {memberchk(Lang,['prolog'])}->
                A,ws,"#<",ws,B;
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,"<",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['english'])}->
                A,ws_,"is",ws_,"less",ws_,"than",ws_,B;
        {memberchk(Lang,['polish notation'])}->
                "<",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,"<";
        {not_defined_for(Data,'less_than')}).
less_than_or_equal(
        {memberchk(Lang,['c','z3py','ats','seed7','pydatalog','vbscript','livecode','monkey x','englishscript','gap','dafny','janus','perl 6','wolfram','chapel','fortran','elixir','frink','mathematical notation','minizinc','picat','ooc','genie','pl/i','idp','processing','engscript','maxima','gnu smalltalk','pyke','self','boo','cobra','standard ml','prolog','kotlin','pawn','freebasic','ada','matlab','algol 68','gambas','nim','gosu','autoit','ceylon','d','groovy','rust','coffeescript','typescript','octave','hack','autohotkey','julia','scala','pascal','delphi','swift','visual basic','f#','objective-c','pike','python','cython','oz','ml','vala','dart','c++','java','ocaml','rebol','c#','nemerle','ruby','php','lua','visual basic .net','haskell','haxe','perl','javascript','r','awk','crosslanguage','go'])}->
                A,ws,"<=",ws,B;
        {memberchk(Lang,['erlang'])}->
                A,ws,"=<",ws,B;
        {memberchk(Lang,['racket','z3','clips','newlisp','hy','sibilant','lispyscript','scheme','clojure','common lisp','emacs lisp','crosslanguage'])}->
                "(",ws,"<=",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['english'])}->
                A,ws_,"is",ws_,"less",ws_,"than",ws_,"or",ws_,"equal",ws_,"to",ws_,B;
        {memberchk(Lang,['polish notation'])}->
                "<=",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,"<=";
        {not_defined_for(Data,'less_than_or_equal')}).
Multiply(
        {memberchk(Lang,['c','pydatalog','e','livecode','vbscript','monkey x','perl 6','englishscript','cython','agda','gap','pop-11','dafny','wolfram','chapel','katahdin','mathematical notation','frink','minizinc','cobol','ooc','genie','b-prolog','eclipse','elixir','nools','pyke','picat','pl/i','rexx','idp','falcon','processing','maxima','sympy','mercury','self','gnu smalltalk','boo','drools','seed7','occam','standard ml','engscript','pike','oz','kotlin','pawn','matlab','ada','powershell','gosu','awk','gambas','nim','autohotkey','julia','openoffice basic','algol 68','d','groovy','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','haxe','pascal','delphi','swift','nemerle','vala','r','red','c++','erlang','scala','autoit','cobra','f#','perl','php','go','ruby','lua','haskell','hack','java','ocaml','rebol','python','javascript','c#','visual basic','visual basic .net','dart'])}->
                A,ws,Symbol,ws,B;
        {memberchk(Lang,['racket','z3','crosslanguage','common lisp','clips','newlisp','hy','scheme','clojure','common lisp','emacs lisp','sibilant','lispyscript'])}->
                "(",ws,Symbol,ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['prolog'])}->
                A,ws,Symbol,ws,B;
        {memberchk(Lang,['polish notation'])}->
                Symbol,ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,Symbol;
        {not_defined_for(Data,'Multiply')}).
Add(
        {memberchk(Lang,['java','pydatalog','e','livecode','vbscript','monkey x','englishscript','gap','pop-11','dafny','janus','wolfram','chapel','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','b-prolog','agda','picat','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','erlang','gambas','hack','c++','matlab','rebol','red','lua','go','awk','haskell','perl','python','javascript','c#','php','ruby','r','haxe','visual basic','visual basic .net','vala','bc'])}->
                A,ws,Symbol,ws,B;
        {memberchk(Lang,['prolog'])}->
                A,ws,Symbol,ws,B;
        {memberchk(Lang,['racket','z3','crosslanguage','common lisp','clips','newlisp','hy','scheme','clojure','common lisp','emacs lisp','sibilant','lispyscript'])}->
                "(",ws,Symbol,ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['polish notation'])}->
                Symbol,ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,Symbol;
        {not_defined_for(Data,'Add')}).
greater_than_or_equal(
        {memberchk(Lang,['c','z3py','ats','seed7','pydatalog','vbscript','livecode','monkey x','englishscript','gap','dafny','perl 6','wolfram','chapel','frink','mathematical notation','minizinc','picat','ooc','genie','pl/i','idp','processing','engscript','maxima','gnu smalltalk','pyke','self','boo','cobra','standard ml','prolog','kotlin','pawn','freebasic','ada','matlab','algol 68','gambas','nim','gosu','autoit','ceylon','d','groovy','rust','coffeescript','typescript','octave','hack','autohotkey','julia','scala','pascal','delphi','swift','visual basic','f#','objective-c','pike','python','cython','oz','ml','vala','dart','c++','java','ocaml','rebol','erlang','c#','nemerle','ruby','php','lua','visual basic .net','haskell','haxe','perl','javascript','r','awk','crosslanguage','go','janus'])}->
                A,ws,">=",ws,B;
        {memberchk(Lang,['fortran'])}->
                A,ws_,".GE.",ws_,B;
        {memberchk(Lang,['racket','z3','crosslanguage','common lisp','clips','newlisp','hy','scheme','clojure','common lisp','emacs lisp','sibilant','lispyscript'])}->
                "(",ws,">=",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['polish notation'])}->
                ">=",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,">=";
        {not_defined_for(Data,'greater_than_or_equal')}).
function_call_parameters(
        {memberchk(Lang,['javascript','nim','seed7','vala','wolfram','d','frink','delphi','engscript','chapel','perl','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','lua','typescript','dart','ruby','python','haxe','scala','visual basic','visual basic .net'])}->
                Var1,ws,",",ws,Var2;
        {memberchk(Lang,['hy','crosslanguage','coq','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','z3'])}->
                "function_call_parameters",ws,"=",ws,Var1,ws_,Var2;
        {not_defined_for(Data,'function_call_parameters')}).
greater_than(
        {memberchk(Lang,['pascal','z3py','ats','pydatalog','e','vbscript','livecode','monkey x','perl 6','englishscript','cython','gap','mathematical notation','wolfram','chapel','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','ruby','r','bc','visual basic','visual basic .net'])}->
                A,ws,">",ws,B;
        {memberchk(Lang,['racket','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                "(",ws,">",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['polish notation'])}->
                ">",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,">";
        {not_defined_for(Data,'greater_than')}).
typeof(
        {memberchk(Lang,['python','lua'])}->
                "type",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['javascript'])}->
                "typeof",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "(",ws,"TypeOf",ws,TheObject,ws,")";
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"typeof",ws_,TheObject,ws,")";
        {memberchk(Lang,['go'])}->
                "reflect",ws,".",ws,"TypeOf",ws,"(",ws,TheObject,ws,")",ws,".",ws,"Name",ws,"(",ws,")";
        {memberchk(Lang,['java'])}->
                TheObject,ws,".",ws,"getClass",ws,"(",ws,")",ws,".",ws,"getName",ws,"(",ws,")";
        {memberchk(Lang,['haxe'])}->
                "Type",ws,".",ws,"typeof",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['ruby'])}->
                "class",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['c#'])}->
                TheObject,ws,".",ws,"getType",ws,"(",ws,")";
        {memberchk(Lang,['perl'])}->
                "ref",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['php'])}->
                "getType",ws,"(",ws,TheObject,ws,")";
        {memberchk(Lang,['c++'])}->
                "typeid",ws,"(",ws,TheObject,ws,")",ws,".",ws,"name",ws,"(",ws,")";
        {not_defined_for(Data,'typeof')}).
absolute_value(
        {memberchk(Lang,['lua'])}->
                "math",ws,".",ws,"abs",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c','seed7','octave','picat','c++','swift','python','fortran','php','hack','perl','perl 6','dart','julia','scala','livecode'])}->
                "abs",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic','visual basic .net'])}->
                "Math",ws,".",ws,"Abs",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ruby'])}->
                A,ws,".",ws,"abs";
        {memberchk(Lang,['java','javascript','haxe','typescript'])}->
                "Math",ws,".",ws,"abs",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Abs",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "absolute",ws_,A;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Abs",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"ite",ws_,"(",ws,">=",ws_,A,ws_,"0",ws,")",ws_,A,ws_,"(",ws,"-",ws_,A,ws,")",ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"abs",ws_,A,ws,")";
        {not_defined_for(Data,'absolute_value')}).
natural_logarithm(
        {memberchk(Lang,['python','lua'])}->
                "math",ws,".",ws,"log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','java','ruby','haxe','typescript'])}->
                "Math",ws,".",ws,"log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic','visual basic .net'])}->
                "Math",ws,".",ws,"Log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c','fortran','perl','php','c++'])}->
                "log",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['mathematical notation'])}->
                "ln",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'natural_logarithm')}).
charAt(
        {memberchk(Lang,['java','haxe','scala','javascript','typescript'])}->
                AString,ws,".",ws,"charAt",ws,"(",ws,Index,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"CharAt",ws_,"expression",ws_,Index,ws,")";
        {memberchk(Lang,['python','c','php','c#','minizinc','c++','ruby','picat','haskell','dart'])}->
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
import(
        {memberchk(Lang,['r'])}->
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
                ":-",ws,"consult(",ws,A,ws,")",ws,".";
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
        {not_defined_for(Data,'import')}).
regex_matches_string(
        {memberchk(Lang,['python'])}->
                "re",ws,".",ws,"compile",ws,"(",ws,"regex",ws,")",ws,".",ws,"match",ws,"(",ws,"aString",ws,")";
        {memberchk(Lang,['java','scala'])}->
                "aString",ws,".",ws,"matches",ws,"(",ws,"regex",ws,")";
        {memberchk(Lang,['c#'])}->
                "regex",ws,".",ws,"isMatch",ws,"(",ws,"aString",ws,")";
        {memberchk(Lang,['javascript','coffeescript','nools'])}->
                "$regex",ws,".",ws,"test",ws,"(",ws,"aString",ws,")";
        {memberchk(Lang,['haxe'])}->
                "regex",ws,".",ws,"match",ws,"(",ws,"aString",ws,")";
        {memberchk(Lang,['php'])}->
                "(",ws,"preg_match",ws,"(",ws,"regex",ws,",",ws,"aString",ws,")",ws,">",ws,"0",ws,")";
        {memberchk(Lang,['ruby'])}->
                "(",ws,"aString",ws,"=~",ws,"regex",ws,")";
        {not_defined_for(Data,'regex_matches_string')}).
array_contains(
        {memberchk(Lang,['python','julia','minizinc'])}->
                Container,ws_,"in",ws_,Contained;
        {memberchk(Lang,['swift'])}->
                "contains",ws,"(",ws,Container,ws,",",ws,Contained,ws,")";
        {memberchk(Lang,['lua'])}->
                Container,ws,"[",ws,Contained,ws,"]",ws,"~=",ws,"nil";
        {memberchk(Lang,['rebol'])}->
                "not",ws_,"none?",ws_,"find",ws_,Container,ws_,Contained;
        {memberchk(Lang,['javascript','coffeescript'])}->
                Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!==",ws,"-1";
        {memberchk(Lang,['coffeescript'])}->
                Container,ws,".",ws,"indexOf",ws,"(",ws,Contained,ws,")",ws,"!=",ws,"-1";
        {memberchk(Lang,['ruby'])}->
                Container,ws,".",ws,"include?",ws,"(",ws,Contained,ws,")";
        {memberchk(Lang,['haxe'])}->
                "Lambda",ws,".",ws,"has",ws,"(",ws,Container,ws,",",ws,Contained,ws,")";
        {memberchk(Lang,['php'])}->
                "in_array",ws,"(",ws,Container,ws,",",ws,Container,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                Container,ws,".",ws,"Contains",ws,"(",ws,Contained,ws,")";
        {memberchk(Lang,['java'])}->
                "Arrays",ws,".",ws,"asList",ws,"(",ws,Container,ws,")",ws,".",ws,"contains",ws,"(",ws,Contained,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"elem",ws_,Contained,ws_,Container,ws,")";
        {memberchk(Lang,['c++'])}->
                "(",ws,"std",ws,"::",ws,"find",ws,"(",ws,Std,ws,"(",ws,Container,ws,")",ws,",",ws,"std",ws,"::",ws,"end",ws,"(",ws,Container,ws,")",ws,",",ws,Contained,ws,")",ws,"!=",ws,"std",ws,"::",ws,"end",ws,"(",ws,Container,ws,")",ws,")";
        {not_defined_for(Data,'array_contains')}).
dictionary(
        {memberchk(Lang,['python','dart','javascript','typescript','lua','ruby','julia','c++','engscript','visual basic .net'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['picat'])}->
                "new_map",ws,"(",ws,"[",ws,A,ws,"]",ws,")";
        {memberchk(Lang,['go'])}->
                "map",ws,"[",ws,Input,ws,"]",ws,Output,ws,"{",ws,A,ws,"}";
        {memberchk(Lang,['java'])}->
                "new",ws_,"HashMap",ws,"<",ws,Input,ws,",",ws,Output,ws,">",ws,"(",ws,")",ws,"{",ws,"{",ws,A,ws,"}",ws,"}";
        {memberchk(Lang,['c#'])}->
                "new",ws_,"Dictionary",ws,"<",ws,Input,ws,",",ws,Output,ws,">",ws,"{",ws,A,ws,"}";
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
        {not_defined_for(Data,'dictionary')}).
var_name(
        {memberchk(Lang,['php','perl','bash','tcl','autoit','perl 6','puppet','hack','awk','powershell'])}->
                "$",Name;
        {memberchk(Lang,['engscript','englishscript','vbscript','polish notation','reverse polish notation','wolfram','crosslanguage','english','mathematical notation','pascal','katahdin','typescript','javascript','frink','minizinc','aldor','flora-2','f-logic','d','genie','ooc','janus','chapel','abap','cobol','picolisp','rexx','pl/i','falcon','idp','processing','sympy','maxima','z3','shen','ceylon','nools','pyke','self','gnu smalltalk','elixir','lispyscript','standard ml','nim','occam','boo','seed7','pyparsing','agda','icon','octave','cobra','kotlin','c++','drools','oz','pike','delphi','racket','ml','java','pawn','fortran','ada','freebasic','matlab','newlisp','hy','ocaml','julia','autoit','c#','gosu','autohotkey','groovy','rust','r','swift','vala','go','scala','nemerle','visual basic','visual basic .net','clojure','haxe','coffeescript','dart','javascript','c#','python','ruby','haskell','c','lua','gambas','common lisp','scheme','rebol','f#'])}->
                Name;
        {memberchk(Lang,['clips'])}->
                "?",Name;
        {not_defined_for(Data,'var_name')}).
default_parameter(
        {memberchk(Lang,['python','autohotkey','julia','nemerle','php','javascript'])}->
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
_initializer_list(
        {memberchk(Lang,['lua','nim','seed7','erlang','vala','perl 6','octave','picat','julia','polish notation','reverse polish notation','visual basic .net','dart','java','go','c++','javascript','c#','perl','fortran','c','php','haskell','haxe','python','ruby','typescript','minizinc','prolog','rebol','swift'])}->
                Var1,ws,Var2,ws,Var3;
        {not_defined_for(Data,'_initializer_list')}).
initialize_empty_var(
        {memberchk(Lang,['swift','scala','typescript'])}->
                "var",ws_,Name,ws,":",ws,Type;
        {memberchk(Lang,['java','c#','c++','c','d','janus','fortran','dart'])}->
                Type,ws_,Name;
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
initialize_empty_vars(
        {memberchk(Lang,['c++','java','c#'])}->
                Type,ws_,Vars;
        {not_defined_for(Data,'initialize_empty_vars')}).
anonymous_function(
        {memberchk(Lang,['matlab','octave'])}->
                "(",ws,"@",ws,"(",ws,Params,ws,")",ws,"body",ws,")";
        {memberchk(Lang,['picat'])}->
                "lambda",ws,"(",ws,"[",ws,Params,ws,"]",ws,",",ws,"body",ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Function",ws,"(",ws,Params,ws,")",ws_,"body",ws_,"End",ws_,"Function";
        {memberchk(Lang,['ruby'])}->
                "Proc",ws,".",ws,"new",ws,"{",ws,"|",ws,Params,ws,"|",ws,B,ws,"}";
        {memberchk(Lang,['javascript','typescript','haxe','r','php'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"\\",ws,Params,ws,"->",ws,B,ws,")";
        {memberchk(Lang,['frink'])}->
                "{",ws,"|",ws,Params,ws,"|",ws,"body",ws,"}";
        {memberchk(Lang,['erlang'])}->
                "fun",ws,"(",ws,Params,ws,")",ws_,B,ws_,"end";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws,"(",ws,Params,ws,")",ws_,B,ws_,"end";
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
                "(",ws,"lambda",ws_,Params,ws,":",ws,B,ws,")";
        {memberchk(Lang,['delphi'])}->
                "function",ws,"(",ws,Params,ws,")",ws,"begin",ws_,B,ws_,"end",ws,";";
        {memberchk(Lang,['d'])}->
                "(",ws,Params,ws,")",ws,"{",ws,"body",ws,"}";
        {memberchk(Lang,['rebol'])}->
                "func",ws_,"[",ws,Params,ws,"]",ws,"[",ws,"body",ws,"]";
        {memberchk(Lang,['rust'])}->
                "fn",ws,"(",ws,Params,ws,")",ws,"{",ws,B,ws,"}";
        {not_defined_for(Data,'anonymous_function')}).
function_parameters(
        {memberchk(Lang,['hy','f#','polish notation','reverse polish notation','z3','scheme','racket','common lisp','clips','rebol','haskell','racket','clojure','perl'])}->
                A,ws_,B;
        {memberchk(Lang,['javascript','nim','seed7','pydatalog','e','vbscript','monkey x','livecode','ceylon','delphi','englishscript','cython','vala','dafny','wolfram','gambas','d','frink','chapel','swift','perl 6','ocaml','janus','mathematical notation','pascal','rust','picat','autohotkey','maxima','octave','julia','r','prolog','fortran','go','minizinc','erlang','coffeescript','php','hack','java','c#','c','c++','lua','typescript','dart','ruby','python','haxe','scala','visual basic','visual basic .net'])}->
                A,ws,",",ws,B;
        {not_defined_for(Data,'function_parameters')}).
strlen(
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"strlen",ws_,A,ws_,"b",ws,")";
        {memberchk(Lang,['python','go','erlang','nim'])}->
                "len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['r'])}->
                "nchar",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['erlang'])}->
                String,ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic','visual basic .net','gambas'])}->
                "Len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','typescript','ruby','scala','gosu','picat','haxe','ocaml','d','dart'])}->
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
not_equal(
        {memberchk(Lang,['clojure'])}->
                "(",ws,"not=",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['maxima'])}->
                A,ws_,"not",ws_,"=",ws_,B;
        {memberchk(Lang,['lua'])}->
                A,ws,"~=",ws,B;
        {memberchk(Lang,['javascript','php','typescript'])}->
                A,ws,"!==",ws,B;
        {memberchk(Lang,['java','nim','octave','r','picat','englishscript','perl 6','wolfram','c','c++','d','c#','julia','perl','ruby','haxe','python','cython','minizinc','scala','swift','go','rust','vala'])}->
                A,ws,"!=",ws,B;
        {memberchk(Lang,['english'])}->
                A,ws_,"does",ws_,"not",ws_,"equal",ws_,B;
        {memberchk(Lang,['prolog'])}->
                "not",ws,"(",ws,A,ws,"==",ws,B,ws,")";
        {memberchk(Lang,['common lisp','z3'])}->
                "(",ws,"not",ws,"(",ws,"=",ws_,A,ws_,B,ws,")",ws,")";
        {memberchk(Lang,['mathematical notation'])}->
                A,ws,"!=",ws,"",ws,B;
        {memberchk(Lang,['janus'])}->
                A,ws,"#",ws,B;
        {memberchk(Lang,['fortran'])}->
                A,ws,".NE.",ws,B;
        {memberchk(Lang,['rebol','seed7','visual basic .net','visual basic','gap','ocaml','livecode','monkey x','vbscript','delphi'])}->
                A,ws,"<>",ws,B;
        {memberchk(Lang,['erlang','haskell'])}->
                A,ws,"/=",ws,B;
        {not_defined_for(Data,'not_equal')}).
not(
        {memberchk(Lang,['python','cython','mathematical notation','emacs lisp','minizinc','picat','genie','seed7','z3','idp','maxima','clips','engscript','hy','ocaml','clojure','erlang','pascal','delphi','f#','ml','lua','racket','common lisp','crosslanguage','rebol','haskell','sibilant'])}->
                "(",ws,"not",ws_,A,ws,")";
        {memberchk(Lang,['java','perl 6','katahdin','coffeescript','frink','d','ooc','ceylon','processing','janus','pawn','autohotkey','groovy','scala','hack','rust','octave','typescript','julia','awk','swift','scala','vala','nemerle','pike','perl','c','c++','objective-c','tcl','javascript','r','dart','java','go','ruby','php','haxe','c#','wolfram'])}->
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
async_function(
        {memberchk(Lang,['c#'])}->
                "async",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['javascript','hack'])}->
                "async",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Async",ws_,"Function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"As",ws_,"return_type";
        {not_defined_for(Data,'async_function')}).
varargs(
        {memberchk(Lang,['java'])}->
                Type,ws,"...",ws_,Name;
        {memberchk(Lang,['php'])}->
                "",ws,Type,ws,"...",ws_,"$",ws,Name;
        {memberchk(Lang,['c#'])}->
                "params",ws_,Type,ws_,Name;
        {memberchk(Lang,['perl 6'])}->
                "*@",Name;
        {memberchk(Lang,['ruby'])}->
                "*",Name;
        {memberchk(Lang,['scala'])}->
                Name,ws,":",ws,Type,ws,"*";
        {memberchk(Lang,['go'])}->
                Name,ws,"...",ws,Type;
        {not_defined_for(Data,'varargs')}).
key_value_list(
        {memberchk(Lang,['lua','octave','picat','julia','javascript','dart','java','c#','c++','ruby','php','python','perl','haxe','typescript','visual basic .net','scala','swift','rebol','go'])}->
                Var1,ws,Var2,ws,Var3;
        {not_defined_for(Data,'key_value_list')}).
grammar_Or(
        {memberchk(Lang,['marpa','rebol','yapps','antlr','jison','waxeye','ometa','ebnf','nearley','parslet','yacc','perl 6','rebol','hampi','earley-parser-js'])}->
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
Or(
        {memberchk(Lang,['javascript','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r'])}->
                Var1,ws,"||",ws,Var2;
        {memberchk(Lang,['python','seed7','pydatalog','livecode','englishscript','cython','gap','mathematical notation','genie','idp','maxima','engscript','ada','newlisp','ocaml','nim','coffeescript','pascal','delphi','erlang','rebol','lua','php','crosslanguage','ruby'])}->
                Var1,ws_,"or",ws_,Var2;
        {memberchk(Lang,['fortran'])}->
                Var1,ws_,".OR.",ws_,Var2;
        {memberchk(Lang,['z3','clips','clojure','common lisp','emacs lisp','clojure','racket'])}->
                "(",ws,"or",ws_,Var1,ws_,Var2,ws,")";
        {memberchk(Lang,['prolog'])}->
                Var1,ws,";",ws,Var2;
        {memberchk(Lang,['minizinc'])}->
                Var1,ws,"\\/",ws,Var2;
        {memberchk(Lang,['visual basic','visual basic .net','monkey x'])}->
                Var1,ws_,"Or",ws_,Var2;
        {memberchk(Lang,['polish notation'])}->
                "or",ws_,"a",ws_,"b";
        {memberchk(Lang,['reverse polish notation'])}->
                "a",ws_,"b",ws_,"or";
        {memberchk(Lang,['or'])}->
                "Or",ws,"(",ws,"a",ws,",",ws,"b",ws,")";
        {not_defined_for(Data,'Or')}).
And(
        {memberchk(Lang,['javascript','ats','katahdin','perl 6','wolfram','chapel','elixir','frink','ooc','picat','janus','processing','pike','nools','pawn','matlab','hack','gosu','rust','autoit','autohotkey','typescript','ceylon','groovy','d','octave','awk','julia','scala','f#','swift','nemerle','vala','go','perl','java','haskell','haxe','c','c++','c#','dart','r'])}->
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
this(
        {memberchk(Lang,['ruby','coffeescript'])}->
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
array_length(
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"array_length",ws_,A,ws,")";
        {memberchk(Lang,['lua'])}->
                "#",A;
        {memberchk(Lang,['python','cython','go'])}->
                "len",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java','picat','scala','d','coffeescript','typescript','dart','vala','javascript','ruby','haxe','cobra'])}->
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
initializer_list(
        {memberchk(Lang,['java','picat','c#','go','lua','c++','c','visual basic .net','visual basic','wolfram'])}->
                "{",ws,A,ws,"}";
        {memberchk(Lang,['python','nim','d','frink','rebol','octave','julia','prolog','minizinc','engscript','cython','groovy','dart','typescript','coffeescript','nemerle','javascript','haxe','haskell','ruby','rebol','polish notation','swift'])}->
                "[",ws,A,ws,"]";
        {memberchk(Lang,['php'])}->
                "array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala'])}->
                "Array",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['perl','chapel'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['fortran'])}->
                "(/",ws,A,ws,"/)";
        {not_defined_for(Data,'initializer_list')}).
key_value(
        {memberchk(Lang,['groovy','d','dart','javascript','typescript','coffeescript','swift','elixir','swift','go'])}->
                A,ws,":",ws,B;
        {memberchk(Lang,['python'])}->
                "'",ws,A,ws,"'",ws,":",ws,B;
        {memberchk(Lang,['ruby','php','haxe','perl','julia'])}->
                A,ws,"=>",ws,B;
        {memberchk(Lang,['rebol'])}->
                A,ws_,B;
        {memberchk(Lang,['lua','picat'])}->
                A,ws,"=",ws,B;
        {memberchk(Lang,['c++','c#','visual basic .net'])}->
                "{",ws,A,ws,",",ws,B,ws,"}";
        {memberchk(Lang,['scala','wolfram'])}->
                A,ws,"->",ws,B;
        {memberchk(Lang,['octave'])}->
                A,ws,",",ws,B;
        {memberchk(Lang,['frink'])}->
                "[",ws,A,ws,",",ws,B,ws,"]";
        {memberchk(Lang,['java'])}->
                "put",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {not_defined_for(Data,'key_value')}).
strcmp(
        {memberchk(Lang,['r'])}->
                "identical",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['emacs lisp'])}->
                "(",ws,"string=",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"=",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['visual basic','delphi','visual basic .net','vbscript','f#','prolog','mathematical notation','ocaml','livecode','monkey x'])}->
                A,ws,"=",ws,B;
        {memberchk(Lang,['python','pydatalog','perl 6','englishscript','chapel','julia','fortran','minizinc','picat','go','vala','autoit','rebol','ceylon','groovy','scala','coffeescript','awk','ruby','haskell','haxe','dart','lua','swift'])}->
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
sqrt(
        {memberchk(Lang,['livecode'])}->
                "(",ws,"the",ws_,"sqrt",ws_,"of",ws_,X,ws,")";
        {memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
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
grammar_parentheses_expression(
        {memberchk(Lang,['marpa','earley-parser-js','antlr','treetop','waxeye','ometa','wirth syntax notation','yacc','lpeg','parslet','peg.js','ebnf','nearley','prolog','perl 6','abnf'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "[",ws,A,ws,"]";
        {memberchk(Lang,['parboiled'])}->
                "Sequence",ws,"(",ws,""("",ws,",",ws,A,ws,",",ws,"")"",ws,")";
        {not_defined_for(Data,'grammar_parentheses_expression')}).
parentheses_expression(
        {memberchk(Lang,['pydatalog','pascal','vbscript','monkey x','livecode','perl 6','englishscript','wolfram','cython','mathematical notation','katahdin','frink','minizinc','picat','java','eclipse','d','ooc','genie','janus','pl/i','idp','processing','maxima','seed7','self','gnu smalltalk','drools','standard ml','oz','cobra','pike','prolog','engscript','kotlin','pawn','freebasic','matlab','ada','freebasic','gosu','gambas','nim','autoit','algol 68','ceylon','groovy','rust','coffeescript','typescript','fortran','octave','ml','hack','autohotkey','scala','delphi','tcl','swift','vala','c','f#','c++','dart','javascript','rebol','julia','erlang','ocaml','crosslanguage','c#','nemerle','awk','java','lua','perl','haxe','python','php','haskell','go','ruby','r','bc','visual basic','visual basic .net'])}->
                "(",ws,A,ws,")";
        {memberchk(Lang,['racket','polish notation','reverse polish notation','z3','clips','gnu smalltalk','newlisp','hy','common lisp','emacs lisp','clojure','sibilant','lispyscript'])}->
                A;
        {not_defined_for(Data,'parentheses_expression')}).
join(
        {memberchk(Lang,['swift'])}->
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
        {memberchk(Lang,['javascript','haxe','coffeescript','ruby','groovy','java','typescript','rust','dart'])}->
                Array,ws,".",ws,"join",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['python'])}->
                Separator,ws,".",ws,"join",ws,"(",ws,Array,ws,")";
        {memberchk(Lang,['scala'])}->
                Array,ws,".",ws,"mkString",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Join",ws,"(",ws,"array,",ws,Separator,ws,")";
        {not_defined_for(Data,'join')}).
plus_equals(
        {memberchk(Lang,['janus','nim','vala','perl 6','dart','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','haxe','php','chapel','perl','julia','scala','rust','go','swift'])}->
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
minus_equals(
        {memberchk(Lang,['janus','vala','nim','perl 6','dart','perl','visual basic .net','typescript','python','lua','java','c','c++','c#','javascript','php','haxe','hack','julia','scala','rust','go','swift'])}->
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
grammar_concatenate_string(
        {memberchk(Lang,['ebnf','prolog'])}->
                A,ws,",",ws,B;
        {memberchk(Lang,['lpeg'])}->
                A,ws,"*",ws,B;
        {memberchk(Lang,['peg.js','yapps','earley-parser-js','hampi','antlr','jison','treetop','waxeye','ometa','marpa','nearley','yacc','wirth syntax notation','perl 6','rebol','abnf'])}->
                A,ws_,B;
        {memberchk(Lang,['parslet'])}->
                A,ws,">>",ws,B;
        {memberchk(Lang,['parboiled'])}->
                "Sequence",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {not_defined_for(Data,'grammar_concatenate_string')}).
concatenate_string(
        {memberchk(Lang,['r'])}->
                "paste0",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['maxima'])}->
                "sconcat",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"concatenate",ws_,"'string",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['c','z3py','monkey x','englishscript','mathematical notation','go','java','chapel','frink','freebasic','nemerle','d','cython','ceylon','coffeescript','typescript','dart','gosu','groovy','scala','swift','f#','python','javascript','c#','haxe','ruby','c++','vala'])}->
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
range(
        {memberchk(Lang,['swift','perl','picat','ruby','minizinc','chapel'])}->
                A,ws,"..",ws,B;
        {memberchk(Lang,['python'])}->
                "range",ws,"(",ws,A,ws,",",ws,B,ws,"-",ws,"1",ws,")";
        {memberchk(Lang,['octave','julia','r'])}->
                A,ws,":",ws,B;
        {memberchk(Lang,['haxe'])}->
                A,ws,"...",ws,"(",ws,B,ws,"-",ws,"1",ws,")";
        {not_defined_for(Data,'range')}).
split(
        {memberchk(Lang,['swift'])}->
                AString,ws,".",ws,"componentsSeparatedByString",ws,"(",ws,Separator,ws,")";
        {memberchk(Lang,['octave'])}->
                "strsplit",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
        {memberchk(Lang,['go'])}->
                "strings",ws,".",ws,"Split",ws,"(",ws,AString,ws,",",ws,Separator,ws,")";
        {memberchk(Lang,['javascript','coffeescript','java','python','dart','scala','groovy','haxe','ruby','rust','typescript','cython','vala'])}->
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
pow(
        {memberchk(Lang,['lua'])}->
                "math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['scala'])}->
                "scala.math.pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['javascript','java','typescript','haxe'])}->
                "Math",ws,".",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['python','seed7','cython','chapel','haskell','cobol','picat','ooc','pl/i','rexx','maxima','awk','r','f#','autohotkey','tcl','autoit','groovy','octave','ruby','perl','perl 6','fortran'])}->
                "(",ws,A,ws,"**",ws,B,ws,")";
        {memberchk(Lang,['rebol'])}->
                "power",ws_,A,ws_,B;
        {memberchk(Lang,['c','c++','php','hack','swift','minizinc','dart','d'])}->
                "pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['julia','engscript','visual basic','visual basic .net','gambas','go','ceylon','wolfram','mathematical notation'])}->
                A,ws,"^",ws,B;
        {memberchk(Lang,['rust'])}->
                Num,ws,"(",ws,A,ws,",",ws,B,ws,")";
        {memberchk(Lang,['hy','common lisp','racket','clojure'])}->
                "(",ws,"expt",ws_,"num1",ws_,"num2",ws,")";
        {memberchk(Lang,['erlang'])}->
                "math",ws,":",ws,"pow",ws,"(",ws,A,ws,",",ws,B,ws,")";
        {not_defined_for(Data,'pow')}).
case_statements(
        {memberchk(Lang,['java','vala','octave','ocaml','c','c#','c++','javascript','php','haxe','fortran','ruby','dart','typescript','scala','haskell','visual basic .net','swift','rebol'])}->
                A,ws_,B;
        {memberchk(Lang,['erlang'])}->
                A,ws,";",ws,B;
        {not_defined_for(Data,'case_statements')}).
substring(
        {memberchk(Lang,['javascript','coffeescript','typescript','java','scala','dart'])}->
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
        {memberchk(Lang,['ruby','pike','groovy'])}->
                A,ws,"[",ws,B,ws,"..",ws,C,ws,"]";
        {memberchk(Lang,['racket'])}->
                "(",ws,"substring",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"subseq",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['lua'])}->
                "string",ws,".",ws,"sub",ws,"(",ws,A,ws,",",ws,B,ws,",",ws,C,ws,")";
        {not_defined_for(Data,'substring')}).
mod(
        {memberchk(Lang,['java','perl 6','cython','rust','typescript','frink','ooc','genie','pike','ceylon','pawn','powershell','coffeescript','gosu','groovy','engscript','awk','julia','scala','f#','swift','r','perl','nemerle','haxe','php','hack','vala','lua','tcl','go','dart','javascript','python','c','c++','c#','ruby'])}->
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
dot_notation(
        {memberchk(Lang,['java','octave','scala','julia','python','javascript','typescript','dart','d','haxe','c#','perl 6','lua','c++','visual basic .net','ruby','go','swift'])}->
                "var1",ws,".",ws,"var2";
        {memberchk(Lang,['php','c','perl'])}->
                "var1",ws,"->",ws,"var2";
        {memberchk(Lang,['rebol'])}->
                "var1",ws,"/",ws,"var2";
        {memberchk(Lang,['fortran'])}->
                "var1",ws,"%",ws,"var2";
        {not_defined_for(Data,'dot_notation')}).
sin(
        {memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"sin",ws,"(",ws,Var1,ws,")";
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
                "(",ws,"sin",ws_,"a",ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/sin",ws_,"a",ws,")";
        {not_defined_for(Data,'sin')}).
cos(
        {memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"cos",ws,"(",ws,Var1,ws,")";
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
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"cos",ws_,"a",ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/cos",ws_,"a",ws,")";
        {not_defined_for(Data,'cos')}).
tan(
        {memberchk(Lang,['java','javascript','typescript','ruby','haxe'])}->
                "Math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['lua','python'])}->
                "math",ws,".",ws,"tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c','seed7','erlang','picat','mathematical notation','julia','d','php','perl','perl 6','maxima','fortran','minizinc','swift','prolog','octave','dart','haskell','c++','scala'])}->
                "tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Tan",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['rebol'])}->
                "tangent/radians",ws_,Var1;
        {memberchk(Lang,['go'])}->
                "math",ws,".",ws,"Tan",ws,"(",ws,Var1,ws,")";
        {memberchk(Lang,['common lisp','racket'])}->
                "(",ws,"tan",ws_,"a",ws,")";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"Math/tan",ws_,"a",ws,")";
        {not_defined_for(Data,'tan')}).
instance_method(
        {memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['perl 6'])}->
                "method",ws_,Name,ws_,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['chapel'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['c++','d','dart'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua'])}->
                ws;
        {memberchk(Lang,['python'])}->
                "def",ws_,Name,ws,"(",ws,"self,",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {not_defined_for(Data,'instance_method')}).
typeless_instance_method(
        {memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript','dart'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['chapel'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['java'])}->
                "public",ws_,"Object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c#'])}->
                "public",ws_,"object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['c++','d'])}->
                "auto",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua'])}->
                ws;
        {memberchk(Lang,['python'])}->
                "def",ws_,Name,ws,"(",ws,"self,",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {not_defined_for(Data,'typeless_instance_method')}).
typeless_static_method(
        {memberchk(Lang,['swift'])}->
                "class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript'])}->
                "static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['java'])}->
                "public",ws_,"static",ws_,"Object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c#'])}->
                "public",ws_,"static",ws_,"object",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['dart'])}->
                "static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++'])}->
                "static",ws_,"auto",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"self",ws,".",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['python'])}->
                "@staticmethod",ws,"\n",ws_,"def",ws_,Name,ws,"(",ws,"",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {not_defined_for(Data,'typeless_static_method')}).
static_method(
        {memberchk(Lang,['swift'])}->
                "class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws_,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++','dart'])}->
                "static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"self",ws,".",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['c'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['javascript'])}->
                "static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['picat'])}->
                ws;
        {memberchk(Lang,['python'])}->
                "@staticmethod",ws,"\n",ws_,"def",ws_,Name,ws,"(",ws,"",ws,Params,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {not_defined_for(Data,'static_method')}).
declare_new_object(
        {memberchk(Lang,['visual basic .net'])}->
                "Private",ws_,Var_name,ws_,"As",ws_,"New",ws_,Class_name,ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['java','c#','d','dart'])}->
                Class_name,ws_,Var_name,ws,"=",ws,"new",ws_,Class_name,ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['javascript','haxe','chapel','scala'])}->
                "var",ws_,Var_name,ws,"=",ws,"new",ws_,Class_name,ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['php'])}->
                Var_name,ws,"=",ws,"new",ws_,Class_name,ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['python','swift','octave'])}->
                Var_name,ws,"=",ws,Class_name,ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['ruby'])}->
                Var_name,ws,"=",ws,Class_name,ws,".",ws,"new",ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['perl'])}->
                "my",ws_,Var_name,ws,"=",ws,Class_name,ws,"->",ws,"new",ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['perl 6'])}->
                "my",ws_,Var_name,ws,"=",ws,Class_name,ws,"->",ws,"new",ws,"(",ws,Params,ws,")";
        {memberchk(Lang,['c++'])}->
                Class_name,ws_,Var_name,ws,"(",ws,Params,ws,")";
        {not_defined_for(Data,'declare_new_object')}).
string_to_int(
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"parse-integer",ws_,A,ws,")";
        {memberchk(Lang,['rust'])}->
                A,ws,".",ws,"parse",ws,"::",ws,"<int>",ws,"(",ws,")";
        {memberchk(Lang,['perl 6'])}->
                "+",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['go'])}->
                "strconv",ws,".",ws,"Atoi",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python','julia'])}->
                "int",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haxe'])}->
                "Std",ws,".",ws,"parseInt",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "(",ws,"int",ws,")",ws,A;
        {memberchk(Lang,['haskell'])}->
                "(",ws,"read",ws_,A,ws,")";
        {memberchk(Lang,['c#'])}->
                "Int32",ws,".",ws,"Parse(",ws,A,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Convert",ws,".",ws,"toInt32",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java'])}->
                "Integer",ws,".",ws,"parseInt",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ceylon'])}->
                "parseInteger",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c'])}->
                "atoi",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['scala'])}->
                A,ws,".",ws,"toInt";
        {memberchk(Lang,['d'])}->
                "std",ws,".",ws,"conv",ws,".",ws,"to!int",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ruby'])}->
                "Integer",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['rebol'])}->
                "to",ws_,"integer!",ws_,A;
        {memberchk(Lang,['lua'])}->
                "tonumber",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['javascript','typescript'])}->
                "parseInt",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c++'])}->
                "atoi",ws,"(",ws,A,ws,".",ws,"c_str",ws,"(",ws,")",ws,")";
        {memberchk(Lang,['dart'])}->
                "int",ws,".",ws,"parse",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['swift'])}->
                "Int",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "str2double",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'string_to_int')}).
int_to_string(
        {memberchk(Lang,['perl 6'])}->
                "~",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['go'])}->
                "strconv",ws,".",ws,"Itoa",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python'])}->
                "str",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "ToString",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['swift','javascript','typescript'])}->
                "String",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java'])}->
                "Integer",ws,".",ws,"toString",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"show",ws_,A,ws,")";
        {memberchk(Lang,['perl'])}->
                A;
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Convert",ws,".",ws,"ToString",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ruby'])}->
                A,ws,".",ws,"to_s";
        {memberchk(Lang,['rebol'])}->
                "to",ws_,"string!",ws_,A;
        {memberchk(Lang,['c++'])}->
                "std",ws,"::",ws,"to_string",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['lua'])}->
                "tostring",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haxe'])}->
                "Std",ws,".",ws,"toString",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['d'])}->
                "std",ws,".",ws,"conv",ws,".",ws,"to!string",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "(",ws,"string",ws,")",ws,A;
        {memberchk(Lang,['dart'])}->
                A,ws,".",ws,"toString",ws,"(",ws,")";
        {memberchk(Lang,['scala'])}->
                A,ws,".",ws,"toString";
        {memberchk(Lang,['rust'])}->
                A,ws,".",ws,"to_string",ws,"(",ws,")";
        {memberchk(Lang,['julia'])}->
                "string",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['octave'])}->
                "num2str",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'int_to_string')}).
typeless_declare_constant(
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,Name,ws_,Value;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws_,Value,ws_,"=";
        {memberchk(Lang,['go'])}->
                "const",ws_,"type",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['php','javascript','typescript','nim'])}->
                "const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rust','swift'])}->
                "let",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c'])}->
                "static",ws_,"const",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c#'])}->
                "const",ws_,"object",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['d','c++'])}->
                "const",ws_,"auto",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
        {memberchk(Lang,['scala'])}->
                "val",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['python','ruby','haskell','erlang','julia','picat','prolog'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['lua'])}->
                "local",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl'])}->
                "my",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"inline",ws_,"var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['java'])}->
                "final",ws_,"Object",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['dart'])}->
                "final",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['chapel'])}->
                "var",ws,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl 6'])}->
                "constant",ws_,Name,ws,"=",ws,Value;
        {not_defined_for(Data,'typeless_declare_constant')}).
assert(
        {memberchk(Lang,['c','c++','lua','python','swift','php','ceylon'])}->
                "assert",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['c#','visual basic .net'])}->
                "Debug",ws,".",ws,"Assert",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['java','englishscript','f#'])}->
                "assert",A;
        {memberchk(Lang,['clojure'])}->
                "(",ws,"assert",ws_,A,ws,")";
        {memberchk(Lang,['r'])}->
                "stopifnot",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'assert')}).
declare_constant(
        {memberchk(Lang,['seed7'])}->
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
                Name,ws,"=",ws,Value;
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
index_of(
        {memberchk(Lang,['javascript','java'])}->
                String,ws,".",ws,"indexOf",ws,"(",ws,Substring,ws,")";
        {memberchk(Lang,['d'])}->
                String,ws,".",ws,"indexOfAny",ws,"(",ws,Substring,ws,")";
        {memberchk(Lang,['ruby'])}->
                String,ws,".",ws,"index",ws,"(",ws,Substring,ws,")";
        {memberchk(Lang,['c#'])}->
                String,ws,".",ws,"IndexOf",ws,"(",ws,Substring,ws,")";
        {memberchk(Lang,['python'])}->
                String,ws,".",ws,"find",ws,"(",ws,Substring,ws,")";
        {memberchk(Lang,['go'])}->
                "strings",ws,".",ws,"Index",ws,"(",ws,String,ws,",",ws,Substring,ws,")";
        {not_defined_for(Data,'index_of')}).
function_call_named_parameter(
        {memberchk(Lang,['python','c#','fortran','scala'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['modula-3','visual basic .net'])}->
                Name,ws,":=",ws,Value;
        {memberchk(Lang,['ruby','swift','dart'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['javascript','erlang','octave','picat','julia','mathematical notation','lua','java','c','php','haxe','minizinc','c++','prolog','z3','rebol','haskell','go','polish notation','reverse polish notation'])}->
                Value;
        {memberchk(Lang,['perl'])}->
                "",ws,Name,ws,"=>",ws,Value;
        {not_defined_for(Data,'function_call_named_parameter')}).
function_call(
        {memberchk(Lang,['c','nim','seed7','gap','mathematical notation','chapel','elixir','janus','perl 6','pascal','rust','hack','katahdin','minizinc','pawn','aldor','picat','d','genie','ooc','pl/i','delphi','standard ml','rexx','falcon','idp','processing','maxima','swift','boo','r','matlab','autoit','pike','gosu','awk','autohotkey','gambas','kotlin','nemerle','engscript','prolog','groovy','scala','coffeescript','julia','typescript','fortran','octave','c++','go','cobra','ruby','vala','f#','java','ceylon','ocaml','erlang','python','c#','lua','haxe','javascript','dart','bc','visual basic','visual basic .net','php','perl'])}->
                TheName,ws,"(",ws,Args,ws,")";
        {memberchk(Lang,['haskell','z3','clips','clojure','common lisp','clips','racket','scheme','crosslanguage','rebol'])}->
                "(",ws,TheName,ws_,Args,ws,")";
        {memberchk(Lang,['polish notation'])}->
                TheName,ws_,Args;
        {memberchk(Lang,['reverse polish notation'])}->
                Args,ws_,TheName;
        {memberchk(Lang,['pydatalog','nearley'])}->
                TheName,ws,"[",ws,Args,ws,"]";
        {not_defined_for(Data,'function_call')}).
reverse_string(
        {memberchk(Lang,['python'])}->
                A,ws,"",ws,"[",ws,"::",ws,"-1",ws,"]";
        {memberchk(Lang,['ruby'])}->
                A,ws,".",ws,"reverse!";
        {memberchk(Lang,['java'])}->
                "new",ws_,"StringBuilder",ws,"(",ws,"theString",ws,")",ws,".",ws,"reverse",ws,"(",ws,")",ws,".",ws,"toString",ws,"(",ws,")";
        {memberchk(Lang,['javascript'])}->
                A,ws,".",ws,"reverse",ws,"(",ws,")";
        {memberchk(Lang,['php'])}->
                "strrev",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "StrReverse",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,"reverse",ws_,A,ws,")";
        {memberchk(Lang,['perl'])}->
                "reverse",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'reverse_string')}).
remove_dictionary_key(
        {memberchk(Lang,['javascript'])}->
                "delete",ws_,Dictionary,ws,"[",ws,Key,ws,"]";
        {memberchk(Lang,['perl'])}->
                "delete",ws_,Dictionary,ws,"{",ws,Key,ws,"}";
        {memberchk(Lang,['python'])}->
                Dictionary,ws,".",ws,"pop",ws,"(",ws,Key,ws,",",ws,"None",ws,")";
        {memberchk(Lang,['ruby'])}->
                Dictionary,ws,".",ws,"delete",ws,"(",ws,Key,ws,")";
        {not_defined_for(Data,'remove_dictionary_key')}).
dictionary_keys(
        {memberchk(Lang,['javascript'])}->
                "Object",ws,".",ws,"keys",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['python'])}->
                A,ws,".",ws,"keys",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "array_keys",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['ruby'])}->
                A,ws,".",ws,"keys";
        {memberchk(Lang,['perl'])}->
                "keys",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'dictionary_keys')}).
reverse_array(
        {memberchk(Lang,['haskell'])}->
                "(",ws,"reverse",ws_,A,ws,")";
        {memberchk(Lang,['ruby'])}->
                A,ws,".",ws,"reverse";
        {memberchk(Lang,['javascript','haxe'])}->
                A,ws,".",ws,"reverse",ws,"(",ws,")";
        {memberchk(Lang,['python'])}->
                A,ws,"[",ws,"::",ws,"-1",ws,"]";
        {memberchk(Lang,['perl'])}->
                "reverse",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['php'])}->
                "array_reverse",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['visual basic .net','c#'])}->
                "Array",ws,".",ws,"Reverse",ws,"(",ws,A,ws,")";
        {not_defined_for(Data,'reverse_array')}).
for(
        {memberchk(Lang,['java','d','pawn','groovy','javascript','dart','typescript','php','hack','c#','perl','c++','awk','pike'])}->
                "for",ws,"(",ws,Statement_1,ws,";",ws,Condition,ws,";",ws,Statement_2,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c'])}->
                Init,ws,";",ws,"for",ws,"(",ws,Statement_1,ws,";",ws,Condition,ws,";",ws,Statement_2,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe'])}->
                Statement_1,ws,";",ws,"",ws,"while",ws,"(",ws,Condition,ws,")",ws,"{",ws,Body,ws,Statement_2,ws,";",ws,"}";
        {memberchk(Lang,['lua','ruby'])}->
                Statement_1,ws_,"while",ws_,Condition,ws_,"do",ws_,Body,ws_,Statement_2,ws_,"end";
        {not_defined_for(Data,'for')}).
while(
        {memberchk(Lang,['gap'])}->
                "while",ws_,A,ws_,"do",ws_,B,ws_,"od",ws,";";
        {memberchk(Lang,['englishscript'])}->
                "while",ws_,A,ws_,"do",ws_,B,ws_,"od",ws,";";
        {memberchk(Lang,['fortran'])}->
                "WHILE",ws_,"(",ws,A,ws,")",ws_,"DO",ws_,B,ws_,"ENDDO";
        {memberchk(Lang,['pascal'])}->
                "while",ws_,A,ws_,"do",ws_,"begin",ws_,B,ws_,"end;";
        {memberchk(Lang,['delphi'])}->
                "While",ws_,A,ws_,"do",ws_,"begin",ws_,B,ws_,"end;";
        {memberchk(Lang,['rust','frink','dafny'])}->
                "while",ws_,A,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['c','perl 6','katahdin','chapel','ooc','processing','pike','kotlin','pawn','powershell','hack','gosu','autohotkey','ceylon','d','typescript','actionscript','nemerle','dart','swift','groovy','scala','java','javascript','php','c#','perl','c++','haxe','r','awk','vala'])}->
                "while",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['lua','ruby','julia'])}->
                "while",ws_,A,ws_,B,ws_,"end";
        {memberchk(Lang,['picat'])}->
                "while",ws_,"(",ws,A,ws,")",ws_,B,ws_,"end";
        {memberchk(Lang,['rebol'])}->
                "while",ws,"[",ws,A,ws,"]",ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"loop",ws_,"while",ws_,A,ws_,"do",ws_,B,ws,")";
        {memberchk(Lang,['hy','newlisp','clips'])}->
                "(",ws,"while",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['python','cython'])}->
                "while",ws_,A,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,B,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['visual basic','visual basic .net','vbscript'])}->
                "While",ws_,A,ws_,B,ws_,"End",ws,"While";
        {memberchk(Lang,['octave'])}->
                "while",ws,"(",ws,A,ws,")",ws_,"endwhile";
        {memberchk(Lang,['wolfram'])}->
                "While",ws,"[",ws,A,ws,",",ws,B,ws,"]";
        {memberchk(Lang,['go'])}->
                "for",ws_,A,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['vbscript'])}->
                "Do",ws_,"While",ws_,A,ws_,B,ws_,"Loop";
        {memberchk(Lang,['seed7'])}->
                "while",ws_,A,ws_,"do",ws_,B,ws_,"end",ws_,"while",ws,";";
        {not_defined_for(Data,'while')}).
exception(
        {memberchk(Lang,['python'])}->
                "raise",ws_,"Exception",ws,"(",ws,A,ws,")";
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
        {not_defined_for(Data,'exception')}).
function(
        {memberchk(Lang,['sql'])}->
                "CREATE",ws_,"FUNCTION",ws_,"dbo",ws,".",ws,Name,ws,"(",ws,"function_parameters",ws,")",ws_,"RETURNS",ws_,Type,ws_,Body;
        {memberchk(Lang,['seed7'])}->
                "const",ws_,"func",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws_,"is",ws_,"func",ws_,"begin",ws_,Body,ws_,"end",ws_,"func",ws,";";
        {memberchk(Lang,['livecode'])}->
                "function",ws_,Name,ws_,Params,ws_,Body,ws_,"end",ws_,Name;
        {memberchk(Lang,['monkey x'])}->
                "Function",ws,Name,ws,":",ws,Type,ws,"(",ws,Params,ws,")",ws,Body,ws_,"End";
        {memberchk(Lang,['emacs lisp'])}->
                "(",ws,"defun",ws_,Name,ws_,"(",ws,Params,ws,")",ws_,Body,ws,")";
        {memberchk(Lang,['go'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++','vala','c','dart','ceylon','pike','d','englishscript'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['pydatalog'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"<=",ws,Body;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['javascript','php'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['wolfram'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,Body;
        {memberchk(Lang,['frink'])}->
                Name,ws,"[",ws,Params,ws,"]",ws,":=",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['pop-11'])}->
                "define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,"Result;",ws_,Body,ws_,"enddefine;";
        {memberchk(Lang,['z3'])}->
                "(",ws,"define-fun",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Type,ws_,Body,ws,")";
        {memberchk(Lang,['mathematical notation'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['chapel'])}->
                "proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['prolog'])}->
                Name,ws,"(",ws,Params,ws,")",ws_,":-",ws_,Body,ws,".";
        {memberchk(Lang,['picat'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"=",ws,"retval",ws,"=>",ws,Body,ws,".";
        {memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['maxima'])}->
                Name,ws,"(",ws,Params,ws,")",ws,":=",ws,Body;
        {memberchk(Lang,['rust'])}->
                "fn",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,ws,"}";
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
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"=",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['minizinc'])}->
                "function",ws_,Type,ws,":",ws,Name,ws,"(",ws,Params,ws,")",ws,"=",ws,Body,ws,";";
        {memberchk(Lang,['clips'])}->
                "(",ws,"deffunction",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body,ws,")";
        {memberchk(Lang,['erlang'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Body;
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,ws,"}";
        {memberchk(Lang,['perl 6'])}->
                "sub",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['pawn'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"end";
        {memberchk(Lang,['typescript'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['hack'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['r'])}->
                Name,ws,"<-",ws,"function",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['bc'])}->
                "define",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['visual basic','visual basic .net'])}->
                "Function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['vbscript'])}->
                "Function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['racket','newlisp'])}->
                "(define",ws,"(name",ws,"params)",ws,Body,ws,")";
        {memberchk(Lang,['janus'])}->
                "procedure",ws_,Name,ws,"(",ws,Params,ws,")",ws,Body;
        {memberchk(Lang,['python'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['f#'])}->
                "let",ws_,Name,ws_,Params,ws,"=",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['polish notation'])}->
                "=",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws,"(",ws,Params,ws,")",ws_,Body,ws_,"=";
        {memberchk(Lang,['ocaml'])}->
                "let",ws_,Name,ws_,Params,ws,"=",ws,Body;
        {memberchk(Lang,['e'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,Type,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['pascal','delphi'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,";",ws,"begin",ws_,Body,ws_,"end",ws,";";
        {not_defined_for(Data,'function')}).
else(
        {memberchk(Lang,['clojure'])}->
                ":else",ws_,A;
        {memberchk(Lang,['fortran'])}->
                "ELSE",ws_,A;
        {memberchk(Lang,['hack','e','ooc','englishscript','mathematical notation','dafny','perl 6','frink','chapel','katahdin','pawn','powershell','puppet','ceylon','d','rust','typescript','scala','autohotkey','gosu','groovy','java','swift','dart','awk','javascript','haxe','php','c#','go','perl','c++','c','tcl','r','vala','bc'])}->
                "else",ws,"{",ws,A,ws,"}";
        {memberchk(Lang,['ruby','seed7','livecode','janus','lua','haskell','clips','minizinc','julia','octave','picat','pascal','delphi','maxima','ocaml','f#'])}->
                "else",ws_,A;
        {memberchk(Lang,['erlang'])}->
                "true",ws,"->",ws,A;
        {memberchk(Lang,['wolfram','prolog'])}->
                A;
        {memberchk(Lang,['z3'])}->
                A;
        {memberchk(Lang,['python','cython'])}->
                "else",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,"b",ws,"\n",ws,"#unindent";
        {memberchk(Lang,['visual basic .net','monkey x','vbscript'])}->
                "Else",ws_,A;
        {memberchk(Lang,['rebol'])}->
                "true",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"t",ws_,A,ws,")";
        {memberchk(Lang,['english'])}->
                "otherwise",ws_,A;
        {memberchk(Lang,['polish notation'])}->
                "else",ws_,A;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,"else";
        {not_defined_for(Data,'else')}).
elif_or_else(
        {memberchk(Lang,['java','seed7','common lisp','octave','picat','minizinc','vala','clojure','monkey x','ooc','ceylon','f#','delphi','perl 6','englishscript','wolfram','julia','ocaml','maxima','python','cython','erlang','mathematical notation','rebol','scheme','dart','javascript','typescript','c','c#','haxe','php','lua','ruby','r','fortran','perl','c++','visual basic .net','vbscript','prolog','scala','rust','go','swift','haskell','z3'])}->
                A;
        {memberchk(Lang,['z3'])}->
                A;
        {not_defined_for(Data,'elif_or_else')}).
elif(
        {memberchk(Lang,['d','e','mathematical notation','chapel','pawn','ceylon','scala','typescript','autohotkey','awk','r','groovy','gosu','katahdin','java','swift','nemerle','c','dart','vala','javascript','c#','c++','haxe'])}->
                "else",ws_,"if",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws,"}",ws,C;
        {memberchk(Lang,['z3'])}->
                "(",ws,"ite",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['rust','go','englishscript'])}->
                "else",ws_,"if",ws_,A,ws,"{",ws,B,ws,"}",ws,C;
        {memberchk(Lang,['php','hack','perl'])}->
                "elseif",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws,"}",ws,C;
        {memberchk(Lang,['julia','octave','lua'])}->
                "elseif",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['monkey x'])}->
                "ElseIf",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['ruby','seed7'])}->
                "elsif",ws_,A,ws_,"then",ws_,B,ws_,C;
        {memberchk(Lang,['perl 6'])}->
                "elsif",ws_,A,ws_,"{",ws,B,ws,"}",ws,C;
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
                "elif",ws_,A,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,B,ws,"\n",ws,"#unindent",ws_,C;
        {memberchk(Lang,['visual basic .net'])}->
                "ElseIf",ws_,A,ws_,"Then",ws_,B,ws_,C;
        {memberchk(Lang,['fortran'])}->
                "ELSE",ws_,"IF",ws_,A,ws_,"THEN",ws_,B,ws_,C;
        {memberchk(Lang,['rebol'])}->
                A,ws,"[",ws,B,ws,"]",ws_,C;
        {memberchk(Lang,['common lisp'])}->
                "(",ws,A,ws_,B,ws,")",ws_,C;
        {memberchk(Lang,['wolfram'])}->
                "If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,ws,"]";
        {memberchk(Lang,['polish notation'])}->
                "elif",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,C,ws_,"elif";
        {memberchk(Lang,['clojure'])}->
                A,ws_,B,ws_,C;
        {not_defined_for(Data,'elif')}).
return(
        {memberchk(Lang,['vbscript'])}->
                Function_name,ws,"=",ws,A;
        {memberchk(Lang,['java','seed7','xl','e','livecode','englishscript','cython','gap','kal','engscript','pawn','ada','powershell','rust','d','ceylon','typescript','hack','autohotkey','gosu','swift','pike','objective-c','c','groovy','scala','coffeescript','julia','dart','c#','javascript','go','haxe','php','c++','perl','vala','lua','python','rebol','ruby','tcl','awk','bc','chapel','perl 6'])}->
                "return",ws_,A;
        {memberchk(Lang,['minizinc','pydatalog','polish notation','reverse polish notation','mathematical notation','emacs lisp','z3','erlang','maxima','standard ml','icon','oz','clips','newlisp','hy','sibilant','lispyscript','algol 68','clojure','prolog','common lisp','f#','ocaml','haskell','ml','racket','nemerle'])}->
                A;
        {memberchk(Lang,['visual basic','visual basic .net','autoit','monkey x'])}->
                "Return",ws_,A;
        {memberchk(Lang,['octave','fortran','picat'])}->
                "retval",ws,"=",ws,A;
        {memberchk(Lang,['pascal'])}->
                "Exit",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['r'])}->
                "return",ws,"(",ws,A,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "Return",ws,"[",ws,A,ws,"]";
        {memberchk(Lang,['pop-11'])}->
                A,ws,"->",ws,"Result";
        {memberchk(Lang,['delphi','pascal'])}->
                "Result",ws,"=",ws,A;
        {memberchk(Lang,['sql'])}->
                "RETURN",ws_,A;
        {not_defined_for(Data,'return')}).
constraint(
        {memberchk(Lang,['minizinc'])}->
                "constraint",ws_,Value;
        {memberchk(Lang,['z3','prolog'])}->
                Value;
        {memberchk(Lang,['z3py'])}->
                "solver",ws,".",ws,"add",ws,"(",ws,Value,ws,")";
        {memberchk(Lang,['hampi'])}->
                "assert",ws_,Value;
        {not_defined_for(Data,'constraint')}).
set_var(
        {memberchk(Lang,['javascript','mathematical notation','perl 6','wolfram','chapel','katahdin','frink','picat','ooc','d','genie','janus','ceylon','idp','sympy','prolog','processing','java','boo','gosu','pike','kotlin','icon','powershell','engscript','pawn','freebasic','hack','nim','openoffice basic','groovy','typescript','rust','coffeescript','fortran','awk','go','swift','vala','c','julia','scala','cobra','erlang','autoit','dart','java','ocaml','haxe','c#','matlab','c++','php','perl','python','lua','ruby','gambas','octave','visual basic','visual basic .net','bc'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['minizinc'])}->
                "constraint",ws_,Name,ws,"=",ws,Value,ws,";";
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
print(
        {memberchk(Lang,['ocaml'])}->
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
        {memberchk(Lang,['hy','common lisp','crosslanguage'])}->
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
grammar_series_of_statements(
        {memberchk(Lang,['peg.js','yapps','parboiled','waxeye','treetop','ometa','wirth syntax notation','yacc','pyparsing','ebnf','nearley','antlr','marpa','parslet','perl 6','prolog','rebol','abnf'])}->
                Var1,ws_,Var2;
        {memberchk(Lang,['earley-parser-js','lpeg'])}->
                Var1,ws,",",ws,Var2;
        {not_defined_for(Data,'grammar_series_of_statements')}).
series_of_statements(
        {memberchk(Lang,['pydatalog','java','racket','vbscript','monkey x','livecode','polish notation','reverse polish notation','clojure','clips','common lisp','emacs lisp','scheme','prolog','dafny','z3','elm','bash','perl 6','mathematical notation','katahdin','frink','minizinc','aldor','cobol','ooc','genie','eclipse','nools','agda','pl/i','rexx','idp','falcon','processing','sympy','maxima','pyke','elixir','gnu smalltalk','seed7','standard ml','occam','boo','drools','icon','mercury','engscript','pike','oz','kotlin','pawn','freebasic','ada','powershell','gosu','nim','cython','openoffice basic','algol 68','d','ceylon','rust','coffeescript','actionscript','typescript','fortran','octave','ml','autohotkey','delphi','pascal','f#','self','swift','nemerle','dart','c','autoit','cobra','julia','groovy','scala','ocaml','gambas','hack','c++','matlab','rebol','red','lua','go','awk','haskell','perl','python','javascript','c#','php','ruby','r','haxe','visual basic','visual basic .net','vala','bc'])}->
                Var1,ws_,Var2;
        {memberchk(Lang,['wolfram'])}->
                Var1,ws,";",ws,Var2;
        {memberchk(Lang,['englishscript','python'])}->
                Var1,ws,"\n",ws,Var2;
        {memberchk(Lang,['picat','prolog','erlang','lpeg'])}->
                Var1,ws,",",ws,Var2;
        {not_defined_for(Data,'series_of_statements')}).
class_statements(
        {memberchk(Lang,['java','perl 6','scala','julia','python','dart','c#','ruby','c++','javascript','typescript','visual basic .net','php','haxe','visual basic .net','swift'])}->
                Var1,ws_,Var2;
        {not_defined_for(Data,'class_statements')}).
class_statement(
        {memberchk(Lang,['java','julia','c#','visual basic .net','ruby','php','c++','haxe','swift','dart','python'])}->
                A;
        {memberchk(Lang,['javascript','typescript'])}->
                A;
        {not_defined_for(Data,'class_statement')}).
comment(
        {memberchk(Lang,['java','dafny','janus','chapel','rust','frink','d','genie','ceylon','hack','maxima','kotlin','delphi','dart','typescript','swift','vala','c#','javascript','haxe','scala','go','c','c++','pike','php','f#','nemerle','crosslanguage','gosu','groovy'])}->
                "//",ws,Var1,ws,"\n";
        {memberchk(Lang,['ocaml','standard ml','ml'])}->
                "(*{",ws,Var1,ws,"}*)";
        {memberchk(Lang,['matlab','minizinc','octave','erlang','prolog','picat'])}->
                "%",ws,Var1,ws,"\n";
        {memberchk(Lang,['rebol'])}->
                "comment",ws,"[",ws,Var1,ws,"]";
        {memberchk(Lang,['wolfram'])}->
                "(*",ws,Var1,ws,"*)";
        {memberchk(Lang,['pascal'])}->
                "{",ws,Var1,ws,"}";
        {memberchk(Lang,['fortran'])}->
                "!",ws,Var1,ws,"\n";
        {memberchk(Lang,['z3'])}->
                ";",ws,Var1,ws,"\n";
        {memberchk(Lang,['bash','perl 6','powershell','seed7','cobra','icon','engscript','nim','coffeescript','julia','awk','ruby','perl','r','tcl','bc','python','cython'])}->
                "#",ws,Var1,ws,"\n";
        {memberchk(Lang,['lua','haskell','ada','transact-sql','sql'])}->
                "--",ws,Var1,ws,"\n";
        {memberchk(Lang,['gambas','visual basic','visual basic .net','monkey x','vbscript'])}->
                "'",ws,Var1,ws,"\n";
        {not_defined_for(Data,'comment')}).
initialize_var(
        {memberchk(Lang,['polish notation'])}->
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
        {memberchk(Lang,['python','ruby','haskell','erlang','prolog','julia','picat','octave','wolfram'])}->
                Name,ws,"=",ws,Value;
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
        {not_defined_for(Data,'initialize_var')}).
typeless_initialize_var(
        {memberchk(Lang,['monkey x'])}->
                "Local",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rust'])}->
                "let",ws_,"mut",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['r'])}->
                Name,ws,"<-",ws,Value;
        {memberchk(Lang,['c++','d'])}->
                "auto",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c#','dafny','javascript','haxe','php','typescript','dart','swift','scala','go','vala'])}->
                "var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['lua'])}->
                "local",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['python','ruby','haskell','erlang','prolog','julia','picat','octave','php','wolfram'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['c'])}->
                "__auto_type",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['java'])}->
                "Object",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c#','javascript','haxe','swift'])}->
                "var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['perl','perl 6'])}->
                "my",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['rebol'])}->
                Name,ws,":",ws,Value;
        {memberchk(Lang,['visual basic .net'])}->
                "Dim",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['vbscript'])}->
                "Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,Name,ws_,Value;
        {memberchk(Lang,['reverse polish notation'])}->
                Name,ws_,Value,ws_,"=";
        {not_defined_for(Data,'typeless_initialize_var')}).
int(
        {memberchk(Lang,['hack','transact-sql','dafny','janus','chapel','minizinc','engscript','cython','algol 68','d','octave','tcl','crosslanguage','ml','awk','julia','gosu','ocaml','f#','pike','objective-c','go','cobra','dart','groovy','python','hy','java','c#','c','c++','vala','nemerle','crosslanguage'])}->
                "int";
        {memberchk(Lang,['php','common lisp','picat'])}->
                "integer";
        {memberchk(Lang,['fortran'])}->
                "INTEGER";
        {memberchk(Lang,['rebol'])}->
                "integer!";
        {memberchk(Lang,['ceylon','gambas','openoffice basic','pascal','erlang','delphi','visual basic','visual basic .net'])}->
                "Integer";
        {memberchk(Lang,['haxe','ooc','swift','scala','perl 6','z3','monkey x'])}->
                "Int";
        {memberchk(Lang,['javascript','typescript','coffeescript','lua','perl'])}->
                "number";
        {memberchk(Lang,['haskell'])}->
                "Num";
        {memberchk(Lang,['ruby'])}->
                "fixnum";
        {not_defined_for(Data,'int')}).
if(
        {memberchk(Lang,['erlang'])}->
                "if",ws_,A,ws,"->",ws,B,ws_,C,ws_,"end";
        {memberchk(Lang,['fortran'])}->
                "IF",ws_,A,ws_,"THEN",ws_,B,ws_,C,ws_,"END",ws_,"IF";
        {memberchk(Lang,['rebol'])}->
                "case",ws,"[",ws,A,ws,"[",ws,B,ws,"]",ws,C,ws,"]";
        {memberchk(Lang,['julia'])}->
                "if",ws_,A,ws_,B,ws_,C,ws_,"end";
        {memberchk(Lang,['lua','ruby','picat'])}->
                "if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,"end";
        {memberchk(Lang,['octave'])}->
                "if",ws_,A,ws_,B,ws_,C,ws_,"endif";
        {memberchk(Lang,['haskell','pascal','delphi','maxima','ocaml'])}->
                "if",ws_,A,ws_,"then",ws_,B,ws_,C;
        {memberchk(Lang,['livecode'])}->
                "if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,"end",ws_,"if";
        {memberchk(Lang,['java','e','ooc','englishscript','mathematical notation','polish notation','reverse polish notation','perl 6','chapel','katahdin','pawn','powershell','d','ceylon','typescript','actionscript','hack','autohotkey','gosu','nemerle','swift','nemerle','pike','groovy','scala','dart','javascript','c#','c','c++','perl','haxe','php','r','awk','vala','bc','squirrel'])}->
                "if",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws,"}",ws,C;
        {memberchk(Lang,['rust','go'])}->
                "if",ws_,A,ws,"{",ws,B,ws,"}",ws,C;
        {memberchk(Lang,['visual basic','visual basic .net'])}->
                "If",ws_,A,ws_,B,ws_,C;
        {memberchk(Lang,['clips'])}->
                "(",ws,"if",ws_,A,ws_,"then",ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['z3'])}->
                "(",ws,"ite",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['minizinc'])}->
                "if",ws_,A,ws_,"then",ws_,B,ws_,C,ws_,"endif";
        {memberchk(Lang,['python','cython'])}->
                "if",ws_,A,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,B,ws,"\n",ws,"#unindent",ws,"\n",ws,C;
        {memberchk(Lang,['prolog'])}->
                "(",ws,A,ws,"->",ws,B,ws,";",ws,C,ws,")";
        {memberchk(Lang,['visual basic'])}->
                "If",ws_,A,ws_,"Then",ws_,B,ws_,C,ws_,"End",ws_,"If";
        {memberchk(Lang,['common lisp'])}->
                "(",ws,"cond",ws,"(",ws,A,ws_,B,ws,")",ws_,C,ws,")";
        {memberchk(Lang,['wolfram'])}->
                "If",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,ws,"]";
        {memberchk(Lang,['polish notation'])}->
                "if",ws_,A,ws_,B;
        {memberchk(Lang,['reverse polish notation'])}->
                A,ws_,B,ws_,"if";
        {memberchk(Lang,['monkey x'])}->
                "if",ws_,A,ws_,B,ws_,C,ws_,"EndIf";
        {not_defined_for(Data,'if')}).
foreach(
        {memberchk(Lang,['seed7'])}->
                "for",ws_,Var_name,ws_,"range",ws_,Array,ws_,"do",ws_,Body,ws_,"end",ws_,"for;";
        {memberchk(Lang,['javascript','typescript'])}->
                Array,ws,".",ws,"forEach",ws,"(",ws,"function",ws,"(",ws,Var_name,ws,")",ws,"{",ws,Body,ws,"",ws,"}",ws,")",ws,";";
        {memberchk(Lang,['octave'])}->
                "for",ws_,Var_name,ws,"=",ws,Array,ws_,Body,ws_,"endfor";
        {memberchk(Lang,['z3'])}->
                "(",ws,"forall",ws_,"(",ws,"(",ws,Var_name,ws_,"a",ws,")",ws,")",ws_,"(",ws,"=>",ws,"select",ws_,Array,ws,")",ws,")";
        {memberchk(Lang,['gap'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,ws_,"od;";
        {memberchk(Lang,['minizinc'])}->
                "forall",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")";
        {memberchk(Lang,['php','hack'])}->
                "foreach",ws,"(",ws,Array,ws_,"as",ws_,Var_name,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['java'])}->
                "for",ws,"(",ws,TypeInArray,ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c#','vala'])}->
                "foreach",ws,"(",ws,TypeInArray,ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['lua'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,"do",ws_,Body,ws_,"end";
        {memberchk(Lang,['python','cython'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['julia'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws_,Body,ws_,"end";
        {memberchk(Lang,['chapel','swift'])}->
                "for",ws_,Var_name,ws_,"in",ws_,Array,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['pawn'])}->
                "foreach",ws,"(",ws,"new",ws_,Var_name,ws,":",ws,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['picat'])}->
                "foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"(",ws,Body,ws,")",ws,"end";
        {memberchk(Lang,['awk','ceylon'])}->
                "for",ws_,"(",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['go'])}->
                "for",ws_,Var_name,ws,":=",ws,"range",ws_,Array,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['haxe','groovy'])}->
                "for",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                Array,ws,".",ws,"each",ws_,"do",ws,"|",ws,Var_name,ws,"|",ws_,Body,ws_,"end";
        {memberchk(Lang,['nemerle','powershell'])}->
                "foreach",ws,"(",ws,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['scala'])}->
                "for",ws,"(",ws,Var_name,ws,"->",ws,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['rebol'])}->
                "foreach",ws_,Var_name,ws_,Array,ws,"[",ws,Body,ws,"]";
        {memberchk(Lang,['c++'])}->
                "for",ws,"(",ws,TypeInArray,ws_,"&",ws_,Var_name,ws,":",ws,Array,ws,"){",ws,Body,ws,"}";
        {memberchk(Lang,['perl'])}->
                "for",ws_,Array,ws,"->",ws,Var_name,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['d'])}->
                "foreach",ws,"(",ws,Var_name,ws,",",ws,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['gambas'])}->
                "FOR",ws_,"EACH",ws_,Var_name,ws_,"IN",ws_,Array,ws_,Body,ws_,"NEXT";
        {memberchk(Lang,['visual basic .net'])}->
                "For",ws_,"Each",ws_,Var_name,ws_,"As",ws_,TypeInArray,ws_,"In",ws_,Array,ws_,Body,ws_,"Next";
        {memberchk(Lang,['vbscript'])}->
                "For",ws_,"Each",ws_,Var_name,ws_,"In",ws_,Array,ws_,Body,ws_,"Next";
        {memberchk(Lang,['dart'])}->
                "for",ws,"(",ws,"var",ws_,Var_name,ws_,"in",ws_,Array,ws,")",ws,"{",ws,Body,ws,"}";
        {not_defined_for(Data,'foreach')}).
compare_ints(
        {memberchk(Lang,['r'])}->
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
                "(",ws,"=",ws_,"a",ws_,"b",ws,")";
        {memberchk(Lang,['reverse polish notation'])}->
                "a",ws_,"b",ws_,"=";
        {memberchk(Lang,['polish notation'])}->
                "=",ws_,"a",ws_,"b";
        {not_defined_for(Data,'compare_ints')}).
class(
        {memberchk(Lang,['julia'])}->
                "type",ws_,Name,ws_,Body,ws_,"end";
        {memberchk(Lang,['c','z3','lua','prolog','haskell','minizinc','r','go','rebol','fortran'])}->
                Body;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"class",ws_,Name,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['c++'])}->
                "class",ws_,Name,ws,"{",ws,Body,ws,"}",ws,";";
        {memberchk(Lang,['javascript','hack','php','scala','haxe','chapel','swift','d','typescript','dart','perl 6'])}->
                "class",ws_,Name,ws,"{",ws,Body,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "class",ws_,Name,ws_,Body,ws_,"end";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Class",ws_,Name,ws_,Body,ws_,"End",ws_,"Class";
        {memberchk(Lang,['vbscript'])}->
                "Public",ws_,"Class",ws_,Name,ws_,Body,ws_,"End",ws_,"Class";
        {memberchk(Lang,['python'])}->
                "class",ws_,Name,ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,Body,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['monkey x'])}->
                "Class",ws_,Name,ws_,Body,ws_,"End";
        {not_defined_for(Data,'class')}).
class_extends(
        {memberchk(Lang,['python'])}->
                "class",ws_,C1,ws,"(",ws,C2,ws,")",ws,":",ws,"\n",ws,"#indent",ws,"\n",ws,B,ws,"\n",ws,"#unindent";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Class",ws_,C1,ws_,"Inherits",ws_,C2,ws_,B,ws_,"End",ws_,"Class";
        {memberchk(Lang,['swift','chapel','d','swift'])}->
                "class",ws_,C1,ws,":",ws,C2,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['haxe','php','javascript','dart','typescript'])}->
                "class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['java','c#','scala'])}->
                "public",ws_,"class",ws_,C1,ws_,"extends",ws_,C2,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['c'])}->
                "#include",ws_,"'",ws,C2,ws,".h'",ws_,B;
        {memberchk(Lang,['c++'])}->
                "class",ws_,C1,ws,":",ws,"public",ws_,C2,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "class",ws_,C1,ws_,"<",ws_,C2,ws_,B,ws_,"end";
        {memberchk(Lang,['perl 6'])}->
                "class",ws_,C1,ws_,"is",ws_,C2,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['monkey x'])}->
                "Class",ws_,C1,ws_,"Extends",ws_,C2,ws_,B,ws_,"End";
        {not_defined_for(Data,'class_extends')}).
function_parameter(
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
        {memberchk(Lang,['haskell','polish notation','reverse polish notation','scheme','python','mathematical notation','lispyscript','clips','clojure','f#','ml','racket','ocaml','tcl','common lisp','newlisp','python','cython','frink','picat','idp','powershell','maxima','icon','coffeescript','fortran','octave','autohotkey','prolog','awk','kotlin','dart','javascript','nemerle','erlang','php','autoit','lua','ruby','r','bc'])}->
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
                Name,ws,"=",ws,"push",ws,";";
        {memberchk(Lang,['wolfram'])}->
                Name,ws;
        {memberchk(Lang,['z3'])}->
                "(",ws,Name,ws_,Type,ws,")";
        {not_defined_for(Data,'function_parameter')}).
switch(
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"switch",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['rust'])}->
                "match",ws_,A,ws,"{",ws,B,ws_,C,ws,"}";
        {memberchk(Lang,['ocaml'])}->
                "match",ws_,A,ws_,"with";
        {memberchk(Lang,['elixir'])}->
                "case",ws_,A,ws_,"do",ws_,B,ws_,C,ws_,"end";
        {memberchk(Lang,['scala'])}->
                A,ws_,"match",ws,"{",ws,B,ws_,C,ws,"}";
        {memberchk(Lang,['octave'])}->
                "switch",ws,"(",ws,A,ws,")",ws,B,ws_,"endswitch";
        {memberchk(Lang,['java','d','powershell','nemerle','d','typescript','hack','swift','groovy','dart','awk','c#','javascript','c++','php','c','go','haxe','vala'])}->
                "switch",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws_,C,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "case",ws_,A,ws_,B,ws_,C,ws_,"end";
        {memberchk(Lang,['haskell','erlang'])}->
                "case",ws_,A,ws_,"of",ws_,B,ws_,C,ws_,"end";
        {memberchk(Lang,['delphi','pascal'])}->
                "Case",ws_,A,ws_,"of",ws_,B,ws_,C,ws_,"end;";
        {memberchk(Lang,['clips'])}->
                "(",ws,"switch",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['visual basic .net','visual basic'])}->
                "Select",ws_,"Case",ws_,A,ws_,B,ws_,C,ws_,"End",ws_,"Select";
        {memberchk(Lang,['rebol'])}->
                "switch/default",ws,"[",ws,A,ws_,B,ws,"]";
        {memberchk(Lang,['fortran'])}->
                "SELECT",ws_,"CASE",ws,"(",ws,A,ws,")",ws_,B,ws_,C,ws_,"END",ws_,"SELECT";
        {memberchk(Lang,['clojure'])}->
                "(",ws,"case",ws_,A,ws_,B,ws_,C,ws,")";
        {memberchk(Lang,['chapel'])}->
                "select",ws,"(",ws,A,ws,")",ws,"{",ws,B,ws,C,ws,"}";
        {memberchk(Lang,['wolfram'])}->
                "Switch",ws,"[",ws,A,ws,",",ws,B,ws,",",ws,C,ws,"]";
        {not_defined_for(Data,'switch')}).
case(
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"case",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['javascript','d','java','c#','c','c++','typescript','dart','php','hack'])}->
                "case",ws_,A,ws,":",ws,B,ws,"break",ws,";";
        {memberchk(Lang,['go','haxe','swift'])}->
                "case",ws_,A,ws,":",ws,B;
        {memberchk(Lang,['fortran'])}->
                "CASE",ws,"(",ws,A,ws,")",ws_,B;
        {memberchk(Lang,['rust'])}->
                A,ws,"=>",ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['ruby'])}->
                "when",ws_,A,ws_,B;
        {memberchk(Lang,['haskell','erlang','elixir','ocaml'])}->
                A,ws,"->",ws,B;
        {memberchk(Lang,['clips'])}->
                "(",ws,"case",ws_,A,ws_,"then",ws_,B,ws,")";
        {memberchk(Lang,['scala'])}->
                "case",ws_,A,ws,"=>",ws,B;
        {memberchk(Lang,['visual basic .net'])}->
                "Case",ws_,A,ws_,B;
        {memberchk(Lang,['rebol'])}->
                A,ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['octave'])}->
                "case",ws_,A,ws_,B;
        {memberchk(Lang,['clojure'])}->
                "(",ws,A,ws_,B,ws,")";
        {memberchk(Lang,['pascal','delphi:'])}->
                A,ws,":",ws,B;
        {memberchk(Lang,['chapel'])}->
                "when",ws_,A,ws,"{",ws,B,ws,"}";
        {memberchk(Lang,['wolfram'])}->
                A,ws,",",ws,B;
        {not_defined_for(Data,'case')}).
access_array(
        {memberchk(Lang,['python','lua','c#','julia','d','swift','julia','janus','minizinc','picat','nim','autoit','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','ruby','go','c++','php','haxe','c'])}->
                A,ws,"[",ws,B,ws,"]";
        {memberchk(Lang,['scala','octave','fortran','visual basic','visual basic .net'])}->
                A,ws,"(",ws,B,ws,")";
        {memberchk(Lang,['haskell'])}->
                "(",ws,A,ws,"!!",ws,B,ws,")";
        {memberchk(Lang,['frink'])}->
                A,ws,"@",ws,B;
        {memberchk(Lang,['z3'])}->
                "(",ws,"select",ws_,A,ws_,B,ws,")";
        {memberchk(Lang,['rebol'])}->
                A,ws,"/",ws,B;
        {not_defined_for(Data,'access_array')}).
array_access_list(
        {memberchk(Lang,['java','perl 6','octave','picat','julia','go','c#','lua','c++','python','javascript','c','php','ruby','scala','haxe','fortran','typescript','minizinc','dart','visual basic .net','perl','swift','haskell','rebol'])}->
                Var1,ws,Separator,ws,Var2;
        {not_defined_for(Data,'array_access_list')}).
array_access_index(
        {memberchk(Lang,['lua','minizinc','rebol'])}->
                A;
        {memberchk(Lang,['haskell','perl 6','d','frink','c#','visual basic','janus','visual basic .net','scala','octave','fortran','python','swift','julia','picat','nim','autoit','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','ruby','go','c++','php','haxe','c'])}->
                A;
        {not_defined_for(Data,'array_access_index')}).
array_access_index_1(
        {memberchk(Lang,['lua','minizinc','rebol'])}->
                A,ws,"+",ws,"1";
        {memberchk(Lang,['haskell','perl 6','d','frink','c#','visual basic','janus','visual basic .net','scala','octave','fortran','python','swift','julia','picat','nim','autoit','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','ruby','go','c++','php','haxe','c'])}->
                A;
        {not_defined_for(Data,'array_access_index_1')}).
array_access_index_2(
        {memberchk(Lang,['lua','minizinc','rebol'])}->
                A;
        {memberchk(Lang,['haskell','perl 6','d','frink','c#','visual basic','janus','visual basic .net','scala','octave','fortran','python','swift','julia','picat','nim','autoit','cython','coffeescript','dart','typescript','awk','vala','perl','java','javascript','ruby','go','c++','php','haxe','c'])}->
                A,ws,"-",ws,"1";
        {not_defined_for(Data,'array_access_index_2')}).
initialize_static_variable(
        {memberchk(Lang,['swift'])}->
                "static",ws_,"var",ws_,Name;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"static",ws_,Type,ws_,Name;
        {memberchk(Lang,['php'])}->
                "public",ws_,"static",ws_,Name;
        {memberchk(Lang,['c++','dart'])}->
                "static",ws_,Type,ws_,Name;
        {memberchk(Lang,['python'])}->
                ws;
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"var",ws_,Name,ws,":",ws,Type;
        {memberchk(Lang,['ruby'])}->
                ws_;
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,Name,ws_,"As",ws_,Type;
        {not_defined_for(Data,'initialize_static_variable')}).
initialize_static_variable_with_value(
        {memberchk(Lang,['swift'])}->
                "static",ws_,"var",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['php'])}->
                "public",ws_,"static",ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['c++','dart'])}->
                "static",ws_,Type,ws_,Name,ws,"=",ws,Value;
        {memberchk(Lang,['python'])}->
                Name,ws,"=",ws,Value;
        {memberchk(Lang,['ruby'])}->
                "@@",ws,Name,ws,"=",ws,Type;
        {memberchk(Lang,['haxe'])}->
                "static",ws_,"var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
        {not_defined_for(Data,'initialize_static_variable_with_value')}).
default(
        {memberchk(Lang,['fortran'])}->
                "CASE",ws_,"DEFAULT",ws_,A;
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"default",ws_,A,ws,")";
        {memberchk(Lang,['javascript','d','c','java','c#','c++','typescript','dart','php','haxe','hack','go','swift'])}->
                "default",ws,":",ws,A;
        {memberchk(Lang,['ruby','pascal','delphi'])}->
                "else",ws_,A;
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
                "otherwise",ws,"{",ws,A,ws,"}";
        {memberchk(Lang,['clojure'])}->
                A;
        {memberchk(Lang,['wolfram'])}->
                ws,ws,",",ws,A;
        {not_defined_for(Data,'default')}).
C:\Users\andy\Dropbox\All source code goes here - don't put this folder inside any other folder\translator_generator\universal_translator.js:3056
        return toReturn;
               ^

ReferenceError: toReturn is not defined
    at pattern_to_input (C:\Users\andy\Dropbox\All source code goes here - don't put this folder inside any other folder\translator_generator\universal_translator.js:3056:9)
    at Object.<anonymous> (C:\Users\andy\Dropbox\All source code goes here - don't put this folder inside any other folder\translator_generator\universal_translator.js:6015:1)
    at Module._compile (module.js:435:26)
    at Object.Module._extensions..js (module.js:442:10)
    at Module.load (module.js:356:32)
    at Function.Module._load (module.js:313:12)
    at Function.Module.runMain (module.js:467:10)
    at startup (node.js:136:18)
    at node.js:963:3
 Press any key to continue . . .
*/
"use strict";
var fs = require('fs');
var nearley = require('nearley');
var child_process = require("child_process");
//Copy the information into this file from grammar.txt.
//A demo of this script is in pegjs_test.html.
//Convert this source code to EcmaScript 5 using Babel:__
//    http://babeljs.io/

//This list specifies the languages that will be parsed.,n

//const list_of_languages = "Vala,R,Clojure,Monkey X,Delphi,LiveCode,Ceylon,F#,ooc,Perl 6,EnglishScript,Julia,Maxima,Wolfram,OCaml,Common Lisp,Scala,REBOL,Go,Scala,Rust,Visual Basic .NET,Common Lisp,Cython,C++,Scala,Prolog,Z3,C#,PHP,C,JavaScript,Lua,Java,Haxe".split(',');

//const list_of_languages = "Erlang,Octave,Picat,MiniZinc,Perl,Go,Swift,C,Fortran,Z3,Python,REBOL,Haskell,Visual Basic .NET,PHP,Ruby,Lua,C++,Haxe,Java,JavaScript,C#".toLowerCase().split(",");

const list_of_languages = "javascript".toLowerCase().split(",");


const list_of_grammar_notations = "Parboiled,Yapps,Rley,Jison,Bison,SmaCC,Ragel,Treetop,Waxeye,OMeta,syntax definition formalism,ABNF,Wirth syntax notation,Coco/R,Yacc,pypeg,Parslet,PEG.js,Pyparsing,EBNF,Nearley,ANTLR,Marpa,earley-parser-js,LPeg".toLowerCase().split(',');

//const list_of_languages = "Parslet,EBNF,Nearley,Marpa,PEG.js".toLowerCase().split(',');
//const list_of_languages = 'Wirth syntax notation,Pydatalog,EBNF,Yacc,Parslet,Marpa,LPEG,PEG.js'.toLowerCase().split(",");
//const list_of_languages = "EBNF,ABNF,Parslet,Nearley".toLowerCase().split(",");

var PEG=function(undefined){"use strict";var modules={define:function(u,e){function A(u){for(var e=t+u,A=/[^\/]+\/\.\.\/|\.\//;A.test(e);)e=e.replace(A,"");return modules[e]}var t=u.replace(/(^|\/)[^/]+$/,"$1"),r={exports:{}};e(r,A),this[u]=r.exports}};return modules.define("utils/arrays",function(u,e){var A={range:function(u,e){var A,t,r=e-u,n=new Array(r);for(A=0,t=u;r>A;A++,t++)n[A]=t;return n},find:function(u,e){var A,t=u.length;if("function"==typeof e){for(A=0;t>A;A++)if(e(u[A]))return u[A]}else for(A=0;t>A;A++)if(u[A]===e)return u[A]},indexOf:function(u,e){var A,t=u.length;if("function"==typeof e){for(A=0;t>A;A++)if(e(u[A]))return A}else for(A=0;t>A;A++)if(u[A]===e)return A;return-1},contains:function(u,e){return-1!==A.indexOf(u,e)},each:function(u,e){var A,t=u.length;for(A=0;t>A;A++)e(u[A],A)},map:function(u,e){var A,t=u.length,r=new Array(t);for(A=0;t>A;A++)r[A]=e(u[A],A);return r},pluck:function(u,e){return A.map(u,function(u){return u[e]})},every:function(u,e){var A,t=u.length;for(A=0;t>A;A++)if(!e(u[A]))return!1;return!0},some:function(u,e){var A,t=u.length;for(A=0;t>A;A++)if(e(u[A]))return!0;return!1}};u.exports=A}),modules.define("utils/objects",function(u,e){var A={keys:function(u){var e,A=[];for(e in u)u.hasOwnProperty(e)&&A.push(e);return A},values:function(u){var e,A=[];for(e in u)u.hasOwnProperty(e)&&A.push(u[e]);return A},clone:function(u){var e,A={};for(e in u)u.hasOwnProperty(e)&&(A[e]=u[e]);return A},defaults:function(u,e){var A;for(A in e)e.hasOwnProperty(A)&&(A in u||(u[A]=e[A]))}};u.exports=A}),modules.define("utils/classes",function(u,e){var A={subclass:function(u,e){function A(){this.constructor=u}A.prototype=e.prototype,u.prototype=new A}};u.exports=A}),modules.define("grammar-error",function(u,e){function A(u,e){this.name="GrammarError",this.message=u,this.location=e,"function"==typeof Error.captureStackTrace&&Error.captureStackTrace(this,A)}var t=e("./utils/classes");t.subclass(A,Error),u.exports=A}),modules.define("parser",function(u,e){u.exports=function(){function u(u,e){function A(){this.constructor=u}A.prototype=e.prototype,u.prototype=new A}function e(u,A,t,r){this.message=u,this.expected=A,this.found=t,this.location=r,this.name="SyntaxError","function"==typeof Error.captureStackTrace&&Error.captureStackTrace(this,e)}function A(u){function A(){return u.substring(Un,jn)}function t(){return E(Un,jn)}function r(e){throw s(e,null,u.substring(Un,jn),E(Un,jn))}function n(e){var A,t,r=Hn[e];if(r)return r;for(A=e-1;!Hn[A];)A--;for(r=Hn[A],r={line:r.line,column:r.column,seenCR:r.seenCR};e>A;)t=u.charAt(A),"\n"===t?(r.seenCR||r.line++,r.column=1,r.seenCR=!1):"\r"===t||"\u2028"===t||"\u2029"===t?(r.line++,r.column=1,r.seenCR=!0):(r.column++,r.seenCR=!1),A++;return Hn[e]=r,r}function E(u,e){var A=n(u),t=n(e);return{start:{offset:u,line:A.line,column:A.column},end:{offset:e,line:t.line,column:t.column}}}function C(u){zn>jn||(jn>zn&&(zn=jn,Mn=[]),Mn.push(u))}function s(u,A,t,r){function n(u){var e=1;for(u.sort(function(u,e){return u.description<e.description?-1:u.description>e.description?1:0});e<u.length;)u[e-1]===u[e]?u.splice(e,1):e++}function E(u,e){function A(u){function e(u){return u.charCodeAt(0).toString(16).toUpperCase()}return u.replace(/\\/g,"\\\\").replace(/"/g,'\\"').replace(/\x08/g,"\\b").replace(/\t/g,"\\t").replace(/\n/g,"\\n").replace(/\f/g,"\\f").replace(/\r/g,"\\r").replace(/[\x00-\x07\x0B\x0E\x0F]/g,function(u){return"\\x0"+e(u)}).replace(/[\x10-\x1F\x80-\xFF]/g,function(u){return"\\x"+e(u)}).replace(/[\u0100-\u0FFF]/g,function(u){return"\\u0"+e(u)}).replace(/[\u1000-\uFFFF]/g,function(u){return"\\u"+e(u)})}var t,r,n,E=new Array(u.length);for(n=0;n<u.length;n++)E[n]=u[n].description;return t=u.length>1?E.slice(0,-1).join(", ")+" or "+E[u.length-1]:E[0],r=e?'"'+A(e)+'"':"end of input","Expected "+t+" but "+r+" found."}return null!==A&&n(A),new e(null!==u?u:E(A,t),A,t,r)}function i(){var u,e,A,t,r,n,E;if(u=jn,e=ee(),e!==Fe)if(A=jn,t=a(),t!==Fe?(r=ee(),r!==Fe?(t=[t,r],A=t):(jn=A,A=Fe)):(jn=A,A=Fe),A===Fe&&(A=null),A!==Fe){if(t=[],r=jn,n=F(),n!==Fe?(E=ee(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe),r!==Fe)for(;r!==Fe;)t.push(r),r=jn,n=F(),n!==Fe?(E=ee(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);else t=Fe;t!==Fe?(Un=u,e=pe(A,t),u=e):(jn=u,u=Fe)}else jn=u,u=Fe;else jn=u,u=Fe;return u}function a(){var u,e,A;return u=jn,e=Eu(),e!==Fe?(A=te(),A!==Fe?(Un=u,e=Be(e),u=e):(jn=u,u=Fe)):(jn=u,u=Fe),u}function F(){var e,A,t,r,n,E,s,i;return e=jn,A=I(),A!==Fe?(t=ee(),t!==Fe?(r=jn,n=M(),n!==Fe?(E=ee(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe),r===Fe&&(r=null),r!==Fe?(61===u.charCodeAt(jn)?(n=De,jn++):(n=Fe,0===Gn&&C(le)),n!==Fe?(E=ee(),E!==Fe?(s=o(),s!==Fe?(i=te(),i!==Fe?(Un=e,A=de(A,r,s),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe),e}function o(){var e,A,t,r,n,E,s,i;if(e=jn,A=c(),A!==Fe){for(t=[],r=jn,n=ee(),n!==Fe?(47===u.charCodeAt(jn)?(E=fe,jn++):(E=Fe,0===Gn&&C(he)),E!==Fe?(s=ee(),s!==Fe?(i=c(),i!==Fe?(n=[n,E,s,i],r=n):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe);r!==Fe;)t.push(r),r=jn,n=ee(),n!==Fe?(47===u.charCodeAt(jn)?(E=fe,jn++):(E=Fe,0===Gn&&C(he)),E!==Fe?(s=ee(),s!==Fe?(i=c(),i!==Fe?(n=[n,E,s,i],r=n):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe);t!==Fe?(Un=e,A=ve(A,t),e=A):(jn=e,e=Fe)}else jn=e,e=Fe;return e}function c(){var u,e,A,t,r;return u=jn,e=p(),e!==Fe?(A=jn,t=ee(),t!==Fe?(r=Eu(),r!==Fe?(t=[t,r],A=t):(jn=A,A=Fe)):(jn=A,A=Fe),A===Fe&&(A=null),A!==Fe?(Un=u,e=ge(e,A),u=e):(jn=u,u=Fe)):(jn=u,u=Fe),u}function p(){var u,e,A,t,r,n;if(u=jn,e=B(),e!==Fe){for(A=[],t=jn,r=ee(),r!==Fe?(n=B(),n!==Fe?(r=[r,n],t=r):(jn=t,t=Fe)):(jn=t,t=Fe);t!==Fe;)A.push(t),t=jn,r=ee(),r!==Fe?(n=B(),n!==Fe?(r=[r,n],t=r):(jn=t,t=Fe)):(jn=t,t=Fe);A!==Fe?(Un=u,e=me(e,A),u=e):(jn=u,u=Fe)}else jn=u,u=Fe;return u}function B(){var e,A,t,r,n,E;return e=jn,A=S(),A!==Fe?(t=ee(),t!==Fe?(58===u.charCodeAt(jn)?(r=ye,jn++):(r=Fe,0===Gn&&C(Pe)),r!==Fe?(n=ee(),n!==Fe?(E=D(),E!==Fe?(Un=e,A=be(A,E),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=D()),e}function D(){var u,e,A,t;return u=jn,e=l(),e!==Fe?(A=ee(),A!==Fe?(t=d(),t!==Fe?(Un=u,e=xe(e,t),u=e):(jn=u,u=Fe)):(jn=u,u=Fe)):(jn=u,u=Fe),u===Fe&&(u=d()),u}function l(){var e;return 36===u.charCodeAt(jn)?(e=_e,jn++):(e=Fe,0===Gn&&C($e)),e===Fe&&(38===u.charCodeAt(jn)?(e=Re,jn++):(e=Fe,0===Gn&&C(ke)),e===Fe&&(33===u.charCodeAt(jn)?(e=Se,jn++):(e=Fe,0===Gn&&C(Ie)))),e}function d(){var u,e,A,t;return u=jn,e=h(),e!==Fe?(A=ee(),A!==Fe?(t=f(),t!==Fe?(Un=u,e=Oe(e,t),u=e):(jn=u,u=Fe)):(jn=u,u=Fe)):(jn=u,u=Fe),u===Fe&&(u=h()),u}function f(){var e;return 63===u.charCodeAt(jn)?(e=Le,jn++):(e=Fe,0===Gn&&C(Te)),e===Fe&&(42===u.charCodeAt(jn)?(e=we,jn++):(e=Fe,0===Gn&&C(Ne)),e===Fe&&(43===u.charCodeAt(jn)?(e=je,jn++):(e=Fe,0===Gn&&C(Ue)))),e}function h(){var e,A,t,r,n,E;return e=z(),e===Fe&&(e=Y(),e===Fe&&(e=nu(),e===Fe&&(e=v(),e===Fe&&(e=g(),e===Fe&&(e=jn,40===u.charCodeAt(jn)?(A=He,jn++):(A=Fe,0===Gn&&C(ze)),A!==Fe?(t=ee(),t!==Fe?(r=o(),r!==Fe?(n=ee(),n!==Fe?(41===u.charCodeAt(jn)?(E=Me,jn++):(E=Fe,0===Gn&&C(Ge)),E!==Fe?(Un=e,A=qe(r),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)))))),e}function v(){var e,A,t,r,n,E,s,i;return e=jn,A=I(),A!==Fe?(t=jn,Gn++,r=jn,n=ee(),n!==Fe?(E=jn,s=M(),s!==Fe?(i=ee(),i!==Fe?(s=[s,i],E=s):(jn=E,E=Fe)):(jn=E,E=Fe),E===Fe&&(E=null),E!==Fe?(61===u.charCodeAt(jn)?(s=De,jn++):(s=Fe,0===Gn&&C(le)),s!==Fe?(n=[n,E,s],r=n):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(Un=e,A=Ye(A),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function g(){var u,e,A,t;return u=jn,e=m(),e!==Fe?(A=ee(),A!==Fe?(t=Eu(),t!==Fe?(Un=u,e=Ve(e,t),u=e):(jn=u,u=Fe)):(jn=u,u=Fe)):(jn=u,u=Fe),u}function m(){var e;return 38===u.charCodeAt(jn)?(e=Re,jn++):(e=Fe,0===Gn&&C(ke)),e===Fe&&(33===u.charCodeAt(jn)?(e=Se,jn++):(e=Fe,0===Gn&&C(Ie))),e}function y(){var e;return u.length>jn?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(We)),e}function P(){var e,A;return Gn++,9===u.charCodeAt(jn)?(e=Je,jn++):(e=Fe,0===Gn&&C(Ze)),e===Fe&&(11===u.charCodeAt(jn)?(e=Ke,jn++):(e=Fe,0===Gn&&C(Qe)),e===Fe&&(12===u.charCodeAt(jn)?(e=uA,jn++):(e=Fe,0===Gn&&C(eA)),e===Fe&&(32===u.charCodeAt(jn)?(e=AA,jn++):(e=Fe,0===Gn&&C(tA)),e===Fe&&(160===u.charCodeAt(jn)?(e=rA,jn++):(e=Fe,0===Gn&&C(nA)),e===Fe&&(65279===u.charCodeAt(jn)?(e=EA,jn++):(e=Fe,0===Gn&&C(CA)),e===Fe&&(e=du())))))),Gn--,e===Fe&&(A=Fe,0===Gn&&C(Xe)),e}function b(){var e;return sA.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(iA)),e}function x(){var e,A;return Gn++,10===u.charCodeAt(jn)?(e=FA,jn++):(e=Fe,0===Gn&&C(oA)),e===Fe&&(u.substr(jn,2)===cA?(e=cA,jn+=2):(e=Fe,0===Gn&&C(pA)),e===Fe&&(13===u.charCodeAt(jn)?(e=BA,jn++):(e=Fe,0===Gn&&C(DA)),e===Fe&&(8232===u.charCodeAt(jn)?(e=lA,jn++):(e=Fe,0===Gn&&C(dA)),e===Fe&&(8233===u.charCodeAt(jn)?(e=fA,jn++):(e=Fe,0===Gn&&C(hA)))))),Gn--,e===Fe&&(A=Fe,0===Gn&&C(aA)),e}function _(){var u,e;return Gn++,u=$(),u===Fe&&(u=k()),Gn--,u===Fe&&(e=Fe,0===Gn&&C(vA)),u}function $(){var e,A,t,r,n,E;if(e=jn,u.substr(jn,2)===gA?(A=gA,jn+=2):(A=Fe,0===Gn&&C(mA)),A!==Fe){for(t=[],r=jn,n=jn,Gn++,u.substr(jn,2)===yA?(E=yA,jn+=2):(E=Fe,0===Gn&&C(PA)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);r!==Fe;)t.push(r),r=jn,n=jn,Gn++,u.substr(jn,2)===yA?(E=yA,jn+=2):(E=Fe,0===Gn&&C(PA)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);t!==Fe?(u.substr(jn,2)===yA?(r=yA,jn+=2):(r=Fe,0===Gn&&C(PA)),r!==Fe?(A=[A,t,r],e=A):(jn=e,e=Fe)):(jn=e,e=Fe)}else jn=e,e=Fe;return e}function R(){var e,A,t,r,n,E;if(e=jn,u.substr(jn,2)===gA?(A=gA,jn+=2):(A=Fe,0===Gn&&C(mA)),A!==Fe){for(t=[],r=jn,n=jn,Gn++,u.substr(jn,2)===yA?(E=yA,jn+=2):(E=Fe,0===Gn&&C(PA)),E===Fe&&(E=b()),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);r!==Fe;)t.push(r),r=jn,n=jn,Gn++,u.substr(jn,2)===yA?(E=yA,jn+=2):(E=Fe,0===Gn&&C(PA)),E===Fe&&(E=b()),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);t!==Fe?(u.substr(jn,2)===yA?(r=yA,jn+=2):(r=Fe,0===Gn&&C(PA)),r!==Fe?(A=[A,t,r],e=A):(jn=e,e=Fe)):(jn=e,e=Fe)}else jn=e,e=Fe;return e}function k(){var e,A,t,r,n,E;if(e=jn,u.substr(jn,2)===bA?(A=bA,jn+=2):(A=Fe,0===Gn&&C(xA)),A!==Fe){for(t=[],r=jn,n=jn,Gn++,E=b(),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);r!==Fe;)t.push(r),r=jn,n=jn,Gn++,E=b(),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)}else jn=e,e=Fe;return e}function S(){var u,e,A;return u=jn,e=jn,Gn++,A=N(),Gn--,A===Fe?e=void 0:(jn=e,e=Fe),e!==Fe?(A=I(),A!==Fe?(Un=u,e=_A(A),u=e):(jn=u,u=Fe)):(jn=u,u=Fe),u}function I(){var u,e,A,t;if(Gn++,u=jn,e=O(),e!==Fe){for(A=[],t=L();t!==Fe;)A.push(t),t=L();A!==Fe?(Un=u,e=RA(e,A),u=e):(jn=u,u=Fe)}else jn=u,u=Fe;return Gn--,u===Fe&&(e=Fe,0===Gn&&C($A)),u}function O(){var e,A,t;return e=T(),e===Fe&&(36===u.charCodeAt(jn)?(e=_e,jn++):(e=Fe,0===Gn&&C($e)),e===Fe&&(95===u.charCodeAt(jn)?(e=kA,jn++):(e=Fe,0===Gn&&C(SA)),e===Fe&&(e=jn,92===u.charCodeAt(jn)?(A=IA,jn++):(A=Fe,0===Gn&&C(OA)),A!==Fe?(t=Au(),t!==Fe?(Un=e,A=LA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)))),e}function L(){var e;return e=O(),e===Fe&&(e=w(),e===Fe&&(e=Bu(),e===Fe&&(e=lu(),e===Fe&&(8204===u.charCodeAt(jn)?(e=TA,jn++):(e=Fe,0===Gn&&C(wA)),e===Fe&&(8205===u.charCodeAt(jn)?(e=NA,jn++):(e=Fe,0===Gn&&C(jA))))))),e}function T(){var u;return u=ou(),u===Fe&&(u=su(),u===Fe&&(u=Fu(),u===Fe&&(u=iu(),u===Fe&&(u=au(),u===Fe&&(u=Du()))))),u}function w(){var u;return u=pu(),u===Fe&&(u=cu()),u}function N(){var u;return u=j(),u===Fe&&(u=U(),u===Fe&&(u=zu(),u===Fe&&(u=H()))),u}function j(){var u;return u=fu(),u===Fe&&(u=hu(),u===Fe&&(u=vu(),u===Fe&&(u=yu(),u===Fe&&(u=Pu(),u===Fe&&(u=bu(),u===Fe&&(u=xu(),u===Fe&&(u=_u(),u===Fe&&(u=$u(),u===Fe&&(u=Ou(),u===Fe&&(u=Lu(),u===Fe&&(u=Tu(),u===Fe&&(u=wu(),u===Fe&&(u=ju(),u===Fe&&(u=Uu(),u===Fe&&(u=Hu(),u===Fe&&(u=Mu(),u===Fe&&(u=qu(),u===Fe&&(u=Yu(),u===Fe&&(u=Vu(),u===Fe&&(u=Xu(),u===Fe&&(u=Ju(),u===Fe&&(u=Zu(),u===Fe&&(u=Ku(),u===Fe&&(u=Qu(),u===Fe&&(u=ue()))))))))))))))))))))))))),u}function U(){var u;return u=gu(),u===Fe&&(u=mu(),u===Fe&&(u=Ru(),u===Fe&&(u=ku(),u===Fe&&(u=Su(),u===Fe&&(u=Nu(),u===Fe&&(u=Gu())))))),u}function H(){var u;return u=Wu(),u===Fe&&(u=Iu()),u}function z(){var e,A,t;return Gn++,e=jn,A=M(),A!==Fe?(105===u.charCodeAt(jn)?(t=HA,jn++):(t=Fe,0===Gn&&C(zA)),t===Fe&&(t=null),t!==Fe?(Un=e,A=MA(A,t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),Gn--,e===Fe&&(A=Fe,0===Gn&&C(UA)),e}function M(){var e,A,t,r;if(Gn++,e=jn,34===u.charCodeAt(jn)?(A=qA,jn++):(A=Fe,0===Gn&&C(YA)),A!==Fe){for(t=[],r=G();r!==Fe;)t.push(r),r=G();t!==Fe?(34===u.charCodeAt(jn)?(r=qA,jn++):(r=Fe,0===Gn&&C(YA)),r!==Fe?(Un=e,A=VA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)}else jn=e,e=Fe;if(e===Fe)if(e=jn,39===u.charCodeAt(jn)?(A=WA,jn++):(A=Fe,0===Gn&&C(XA)),A!==Fe){for(t=[],r=q();r!==Fe;)t.push(r),r=q();t!==Fe?(39===u.charCodeAt(jn)?(r=WA,jn++):(r=Fe,0===Gn&&C(XA)),r!==Fe?(Un=e,A=VA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)}else jn=e,e=Fe;return Gn--,e===Fe&&(A=Fe,0===Gn&&C(GA)),e}function G(){var e,A,t;return e=jn,A=jn,Gn++,34===u.charCodeAt(jn)?(t=qA,jn++):(t=Fe,0===Gn&&C(YA)),t===Fe&&(92===u.charCodeAt(jn)?(t=IA,jn++):(t=Fe,0===Gn&&C(OA)),t===Fe&&(t=b())),Gn--,t===Fe?A=void 0:(jn=A,A=Fe),A!==Fe?(t=y(),t!==Fe?(Un=e,A=JA(),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=jn,92===u.charCodeAt(jn)?(A=IA,jn++):(A=Fe,0===Gn&&C(OA)),A!==Fe?(t=J(),t!==Fe?(Un=e,A=LA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=X())),e}function q(){var e,A,t;return e=jn,A=jn,Gn++,39===u.charCodeAt(jn)?(t=WA,jn++):(t=Fe,0===Gn&&C(XA)),t===Fe&&(92===u.charCodeAt(jn)?(t=IA,jn++):(t=Fe,0===Gn&&C(OA)),t===Fe&&(t=b())),Gn--,t===Fe?A=void 0:(jn=A,A=Fe),A!==Fe?(t=y(),t!==Fe?(Un=e,A=JA(),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=jn,92===u.charCodeAt(jn)?(A=IA,jn++):(A=Fe,0===Gn&&C(OA)),A!==Fe?(t=J(),t!==Fe?(Un=e,A=LA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=X())),e}function Y(){var e,A,t,r,n,E;if(Gn++,e=jn,91===u.charCodeAt(jn)?(A=KA,jn++):(A=Fe,0===Gn&&C(QA)),A!==Fe)if(94===u.charCodeAt(jn)?(t=ut,jn++):(t=Fe,0===Gn&&C(et)),t===Fe&&(t=null),t!==Fe){for(r=[],n=V(),n===Fe&&(n=W());n!==Fe;)r.push(n),n=V(),n===Fe&&(n=W());r!==Fe?(93===u.charCodeAt(jn)?(n=At,jn++):(n=Fe,0===Gn&&C(tt)),n!==Fe?(105===u.charCodeAt(jn)?(E=HA,jn++):(E=Fe,0===Gn&&C(zA)),E===Fe&&(E=null),E!==Fe?(Un=e,A=rt(t,r,E),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe)}else jn=e,e=Fe;else jn=e,e=Fe;return Gn--,e===Fe&&(A=Fe,0===Gn&&C(ZA)),e}function V(){var e,A,t,r;return e=jn,A=W(),A!==Fe?(45===u.charCodeAt(jn)?(t=nt,jn++):(t=Fe,0===Gn&&C(Et)),t!==Fe?(r=W(),r!==Fe?(Un=e,A=Ct(A,r),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe),e}function W(){var e,A,t;return e=jn,A=jn,Gn++,93===u.charCodeAt(jn)?(t=At,jn++):(t=Fe,0===Gn&&C(tt)),t===Fe&&(92===u.charCodeAt(jn)?(t=IA,jn++):(t=Fe,0===Gn&&C(OA)),t===Fe&&(t=b())),Gn--,t===Fe?A=void 0:(jn=A,A=Fe),A!==Fe?(t=y(),t!==Fe?(Un=e,A=JA(),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=jn,92===u.charCodeAt(jn)?(A=IA,jn++):(A=Fe,0===Gn&&C(OA)),A!==Fe?(t=J(),t!==Fe?(Un=e,A=LA(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=X())),e}function X(){var e,A,t;return e=jn,92===u.charCodeAt(jn)?(A=IA,jn++):(A=Fe,0===Gn&&C(OA)),A!==Fe?(t=x(),t!==Fe?(Un=e,A=st(),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function J(){var e,A,t,r;return e=Z(),e===Fe&&(e=jn,48===u.charCodeAt(jn)?(A=it,jn++):(A=Fe,0===Gn&&C(at)),A!==Fe?(t=jn,Gn++,r=tu(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(Un=e,A=Ft(),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=eu(),e===Fe&&(e=Au()))),e}function Z(){var u;return u=K(),u===Fe&&(u=Q()),u}function K(){var e,A;return 39===u.charCodeAt(jn)?(e=WA,jn++):(e=Fe,0===Gn&&C(XA)),e===Fe&&(34===u.charCodeAt(jn)?(e=qA,jn++):(e=Fe,0===Gn&&C(YA)),e===Fe&&(92===u.charCodeAt(jn)?(e=IA,jn++):(e=Fe,0===Gn&&C(OA)),e===Fe&&(e=jn,98===u.charCodeAt(jn)?(A=ot,jn++):(A=Fe,0===Gn&&C(ct)),A!==Fe&&(Un=e,A=pt()),e=A,e===Fe&&(e=jn,102===u.charCodeAt(jn)?(A=Bt,jn++):(A=Fe,0===Gn&&C(Dt)),A!==Fe&&(Un=e,A=lt()),e=A,e===Fe&&(e=jn,110===u.charCodeAt(jn)?(A=dt,jn++):(A=Fe,0===Gn&&C(ft)),A!==Fe&&(Un=e,A=ht()),e=A,e===Fe&&(e=jn,114===u.charCodeAt(jn)?(A=vt,jn++):(A=Fe,0===Gn&&C(gt)),A!==Fe&&(Un=e,A=mt()),e=A,e===Fe&&(e=jn,116===u.charCodeAt(jn)?(A=yt,jn++):(A=Fe,0===Gn&&C(Pt)),A!==Fe&&(Un=e,A=bt()),e=A,e===Fe&&(e=jn,118===u.charCodeAt(jn)?(A=xt,jn++):(A=Fe,0===Gn&&C(_t)),A!==Fe&&(Un=e,A=$t()),e=A)))))))),e}function Q(){var u,e,A;return u=jn,e=jn,Gn++,A=uu(),A===Fe&&(A=b()),Gn--,A===Fe?e=void 0:(jn=e,e=Fe),e!==Fe?(A=y(),A!==Fe?(Un=u,e=JA(),u=e):(jn=u,u=Fe)):(jn=u,u=Fe),u}function uu(){var e;return e=K(),e===Fe&&(e=tu(),e===Fe&&(120===u.charCodeAt(jn)?(e=Rt,jn++):(e=Fe,0===Gn&&C(kt)),e===Fe&&(117===u.charCodeAt(jn)?(e=St,jn++):(e=Fe,0===Gn&&C(It))))),e}function eu(){var e,A,t,r,n,E;return e=jn,120===u.charCodeAt(jn)?(A=Rt,jn++):(A=Fe,0===Gn&&C(kt)),A!==Fe?(t=jn,r=jn,n=ru(),n!==Fe?(E=ru(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe),t=r!==Fe?u.substring(t,jn):r,t!==Fe?(Un=e,A=Ot(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Au(){var e,A,t,r,n,E,s,i;return e=jn,117===u.charCodeAt(jn)?(A=St,jn++):(A=Fe,0===Gn&&C(It)),A!==Fe?(t=jn,r=jn,n=ru(),n!==Fe?(E=ru(),E!==Fe?(s=ru(),s!==Fe?(i=ru(),i!==Fe?(n=[n,E,s,i],r=n):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe)):(jn=r,r=Fe),t=r!==Fe?u.substring(t,jn):r,t!==Fe?(Un=e,A=Ot(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function tu(){var e;return Lt.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Tt)),e}function ru(){var e;return wt.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Nt)),e}function nu(){var e,A;return e=jn,46===u.charCodeAt(jn)?(A=jt,jn++):(A=Fe,0===Gn&&C(Ut)),A!==Fe&&(Un=e,A=Ht()),e=A}function Eu(){var e,A,t,r;return Gn++,e=jn,123===u.charCodeAt(jn)?(A=Mt,jn++):(A=Fe,0===Gn&&C(Gt)),A!==Fe?(t=Cu(),t!==Fe?(125===u.charCodeAt(jn)?(r=qt,jn++):(r=Fe,0===Gn&&C(Yt)),r!==Fe?(Un=e,A=Vt(t),e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe),Gn--,e===Fe&&(A=Fe,0===Gn&&C(zt)),e}function Cu(){var e,A,t,r,n,E;if(e=jn,A=[],t=[],r=jn,n=jn,Gn++,Wt.test(u.charAt(jn))?(E=u.charAt(jn),jn++):(E=Fe,0===Gn&&C(Xt)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe),r!==Fe)for(;r!==Fe;)t.push(r),r=jn,n=jn,Gn++,Wt.test(u.charAt(jn))?(E=u.charAt(jn),jn++):(E=Fe,0===Gn&&C(Xt)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);else t=Fe;for(t===Fe&&(t=jn,123===u.charCodeAt(jn)?(r=Mt,jn++):(r=Fe,0===Gn&&C(Gt)),r!==Fe?(n=Cu(),n!==Fe?(125===u.charCodeAt(jn)?(E=qt,jn++):(E=Fe,0===Gn&&C(Yt)),E!==Fe?(r=[r,n,E],t=r):(jn=t,t=Fe)):(jn=t,t=Fe)):(jn=t,t=Fe));t!==Fe;){if(A.push(t),t=[],r=jn,n=jn,Gn++,Wt.test(u.charAt(jn))?(E=u.charAt(jn),jn++):(E=Fe,0===Gn&&C(Xt)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe),r!==Fe)for(;r!==Fe;)t.push(r),r=jn,n=jn,Gn++,Wt.test(u.charAt(jn))?(E=u.charAt(jn),jn++):(E=Fe,0===Gn&&C(Xt)),Gn--,E===Fe?n=void 0:(jn=n,n=Fe),n!==Fe?(E=y(),E!==Fe?(n=[n,E],r=n):(jn=r,r=Fe)):(jn=r,r=Fe);else t=Fe;t===Fe&&(t=jn,123===u.charCodeAt(jn)?(r=Mt,jn++):(r=Fe,0===Gn&&C(Gt)),r!==Fe?(n=Cu(),n!==Fe?(125===u.charCodeAt(jn)?(E=qt,jn++):(E=Fe,0===Gn&&C(Yt)),E!==Fe?(r=[r,n,E],t=r):(jn=t,t=Fe)):(jn=t,t=Fe)):(jn=t,t=Fe))}return e=A!==Fe?u.substring(e,jn):A}function su(){var e;return Jt.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Zt)),e}function iu(){var e;return Kt.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Qt)),e}function au(){var e;return ur.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(er)),e}function Fu(){var e;return Ar.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(tr)),e}function ou(){var e;return rr.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(nr)),e}function cu(){var e;return Er.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Cr)),e}function pu(){var e;return sr.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(ir)),e}function Bu(){var e;return ar.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Fr)),e}function Du(){var e;return or.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(cr)),e}function lu(){var e;return pr.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(Br)),e}function du(){var e;return Dr.test(u.charAt(jn))?(e=u.charAt(jn),jn++):(e=Fe,0===Gn&&C(lr)),e}function fu(){var e,A,t,r;return e=jn,u.substr(jn,5)===dr?(A=dr,jn+=5):(A=Fe,0===Gn&&C(fr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function hu(){var e,A,t,r;return e=jn,u.substr(jn,4)===hr?(A=hr,jn+=4):(A=Fe,0===Gn&&C(vr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function vu(){var e,A,t,r;return e=jn,u.substr(jn,5)===gr?(A=gr,jn+=5):(A=Fe,0===Gn&&C(mr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function gu(){var e,A,t,r;return e=jn,u.substr(jn,5)===yr?(A=yr,jn+=5):(A=Fe,0===Gn&&C(Pr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function mu(){var e,A,t,r;return e=jn,u.substr(jn,5)===br?(A=br,jn+=5):(A=Fe,0===Gn&&C(xr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function yu(){var e,A,t,r;return e=jn,u.substr(jn,8)===_r?(A=_r,jn+=8):(A=Fe,0===Gn&&C($r)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Pu(){var e,A,t,r;return e=jn,u.substr(jn,8)===Rr?(A=Rr,jn+=8):(A=Fe,0===Gn&&C(kr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function bu(){var e,A,t,r;return e=jn,u.substr(jn,7)===Sr?(A=Sr,jn+=7):(A=Fe,0===Gn&&C(Ir)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function xu(){var e,A,t,r;return e=jn,u.substr(jn,6)===Or?(A=Or,jn+=6):(A=Fe,0===Gn&&C(Lr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function _u(){var e,A,t,r;return e=jn,u.substr(jn,2)===Tr?(A=Tr,jn+=2):(A=Fe,0===Gn&&C(wr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function $u(){var e,A,t,r;return e=jn,u.substr(jn,4)===Nr?(A=Nr,jn+=4):(A=Fe,0===Gn&&C(jr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Ru(){var e,A,t,r;return e=jn,u.substr(jn,4)===Ur?(A=Ur,jn+=4):(A=Fe,0===Gn&&C(Hr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function ku(){var e,A,t,r;return e=jn,u.substr(jn,6)===zr?(A=zr,jn+=6):(A=Fe,0===Gn&&C(Mr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Su(){var e,A,t,r;return e=jn,u.substr(jn,7)===Gr?(A=Gr,jn+=7):(A=Fe,0===Gn&&C(qr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Iu(){var e,A,t,r;return e=jn,u.substr(jn,5)===Yr?(A=Yr,jn+=5):(A=Fe,0===Gn&&C(Vr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Ou(){var e,A,t,r;return e=jn,u.substr(jn,7)===Wr?(A=Wr,jn+=7):(A=Fe,0===Gn&&C(Xr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Lu(){var e,A,t,r;return e=jn,u.substr(jn,3)===Jr?(A=Jr,jn+=3):(A=Fe,0===Gn&&C(Zr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Tu(){var e,A,t,r;return e=jn,u.substr(jn,8)===Kr?(A=Kr,jn+=8):(A=Fe,0===Gn&&C(Qr)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function wu(){var e,A,t,r;return e=jn,u.substr(jn,2)===un?(A=un,jn+=2):(A=Fe,0===Gn&&C(en)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Nu(){var e,A,t,r;return e=jn,u.substr(jn,6)===An?(A=An,jn+=6):(A=Fe,0===Gn&&C(tn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function ju(){var e,A,t,r;return e=jn,u.substr(jn,10)===rn?(A=rn,jn+=10):(A=Fe,0===Gn&&C(nn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Uu(){var e,A,t,r;return e=jn,u.substr(jn,2)===En?(A=En,jn+=2):(A=Fe,0===Gn&&C(Cn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Hu(){var e,A,t,r;return e=jn,u.substr(jn,3)===sn?(A=sn,jn+=3):(A=Fe,0===Gn&&C(an)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function zu(){var e,A,t,r;return e=jn,u.substr(jn,4)===Fn?(A=Fn,jn+=4):(A=Fe,0===Gn&&C(on)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Mu(){var e,A,t,r;return e=jn,u.substr(jn,6)===cn?(A=cn,jn+=6):(A=Fe,0===Gn&&C(pn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Gu(){var e,A,t,r;return e=jn,u.substr(jn,5)===Bn?(A=Bn,jn+=5):(A=Fe,0===Gn&&C(Dn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function qu(){var e,A,t,r;return e=jn,u.substr(jn,6)===ln?(A=ln,jn+=6):(A=Fe,0===Gn&&C(dn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Yu(){var e,A,t,r;return e=jn,u.substr(jn,4)===fn?(A=fn,jn+=4):(A=Fe,0===Gn&&C(hn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Vu(){var e,A,t,r;return e=jn,u.substr(jn,5)===vn?(A=vn,jn+=5):(A=Fe,0===Gn&&C(gn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Wu(){var e,A,t,r;return e=jn,u.substr(jn,4)===mn?(A=mn,jn+=4):(A=Fe,0===Gn&&C(yn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Xu(){var e,A,t,r;return e=jn,u.substr(jn,3)===Pn?(A=Pn,jn+=3):(A=Fe,0===Gn&&C(bn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Ju(){var e,A,t,r;return e=jn,u.substr(jn,6)===xn?(A=xn,jn+=6):(A=Fe,0===Gn&&C(_n)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Zu(){var e,A,t,r;return e=jn,u.substr(jn,3)===$n?(A=$n,jn+=3):(A=Fe,0===Gn&&C(Rn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Ku(){var e,A,t,r;return e=jn,u.substr(jn,4)===kn?(A=kn,jn+=4):(A=Fe,0===Gn&&C(Sn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function Qu(){var e,A,t,r;return e=jn,u.substr(jn,5)===In?(A=In,jn+=5):(A=Fe,0===Gn&&C(On)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function ue(){var e,A,t,r;return e=jn,u.substr(jn,4)===Ln?(A=Ln,jn+=4):(A=Fe,0===Gn&&C(Tn)),A!==Fe?(t=jn,Gn++,r=L(),Gn--,r===Fe?t=void 0:(jn=t,t=Fe),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e}function ee(){var u,e;for(u=[],e=P(),e===Fe&&(e=x(),e===Fe&&(e=_()));e!==Fe;)u.push(e),e=P(),e===Fe&&(e=x(),e===Fe&&(e=_()));return u}function Ae(){var u,e;for(u=[],e=P(),e===Fe&&(e=R());e!==Fe;)u.push(e),e=P(),e===Fe&&(e=R());return u}function te(){var e,A,t,r;return e=jn,A=ee(),A!==Fe?(59===u.charCodeAt(jn)?(t=wn,jn++):(t=Fe,0===Gn&&C(Nn)),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=jn,A=Ae(),A!==Fe?(t=k(),t===Fe&&(t=null),t!==Fe?(r=x(),r!==Fe?(A=[A,t,r],e=A):(jn=e,e=Fe)):(jn=e,e=Fe)):(jn=e,e=Fe),e===Fe&&(e=jn,A=ee(),A!==Fe?(t=re(),t!==Fe?(A=[A,t],e=A):(jn=e,e=Fe)):(jn=e,e=Fe))),e}function re(){var e,A;return e=jn,Gn++,u.length>jn?(A=u.charAt(jn),jn++):(A=Fe,0===Gn&&C(We)),Gn--,A===Fe?e=void 0:(jn=e,e=Fe),e}function ne(u){var e,A=[];for(e=0;e<u.length;e++)""!==u[e]&&A.push(u[e]);return A}function Ee(u,e){return u?u[e]:null}function Ce(u,e){var A,t=new Array(u.length);for(A=0;A<u.length;A++)t[A]=u[A][e];return t}function se(u,e,A){return[u].concat(Ce(e,A))}var ie,ae=arguments.length>1?arguments[1]:{},Fe={},oe={Grammar:i},ce=i,pe=function(u,e){return{type:"grammar",initializer:Ee(u,0),rules:Ce(e,0),location:t()}},Be=function(u){return{type:"initializer",code:u,location:t()}},De="=",le={type:"literal",value:"=",description:'"="'},de=function(u,e,A){return{type:"rule",name:u,expression:null!==e?{type:"named",name:e[0],expression:A,location:t()}:A,location:t()}},fe="/",he={type:"literal",value:"/",description:'"/"'},ve=function(u,e){return e.length>0?{type:"choice",alternatives:se(u,e,3),location:t()}:u},ge=function(u,e){return null!==e?{type:"action",expression:u,code:e[1],location:t()}:u},me=function(u,e){return e.length>0?{type:"sequence",elements:se(u,e,1),location:t()}:u},ye=":",Pe={type:"literal",value:":",description:'":"'},be=function(u,e){return{type:"labeled",label:u,expression:e,location:t()}},xe=function(u,e){return{type:qn[u],expression:e,location:t()}},_e="$",$e={type:"literal",value:"$",description:'"$"'},Re="&",ke={type:"literal",value:"&",description:'"&"'},Se="!",Ie={type:"literal",value:"!",description:'"!"'},Oe=function(u,e){return{type:Yn[e],expression:u,location:t()}},Le="?",Te={type:"literal",value:"?",description:'"?"'},we="*",Ne={type:"literal",value:"*",description:'"*"'},je="+",Ue={type:"literal",value:"+",description:'"+"'},He="(",ze={type:"literal",value:"(",description:'"("'},Me=")",Ge={type:"literal",value:")",description:'")"'},qe=function(u){return u},Ye=function(u){return{type:"rule_ref",name:u,location:t()}},Ve=function(u,e){return{type:Vn[u],code:e,location:t()}},We={type:"any",description:"any character"},Xe={type:"other",description:"whitespace"},Je="	",Ze={type:"literal",value:"	",description:'"\\t"'},Ke="",Qe={type:"literal",value:"",description:'"\\x0B"'},uA="\f",eA={type:"literal",value:"\f",description:'"\\f"'},AA=" ",tA={type:"literal",value:" ",description:'" "'},rA=" ",nA={type:"literal",value:" ",description:'"\\xA0"'},EA="\ufeff",CA={type:"literal",value:"\ufeff",description:'"\\uFEFF"'},sA=/^[\n\r\u2028\u2029]/,iA={type:"class",value:"[\\n\\r\\u2028\\u2029]",description:"[\\n\\r\\u2028\\u2029]"},aA={type:"other",description:"end of line"},FA="\n",oA={type:"literal",value:"\n",description:'"\\n"'},cA="\r\n",pA={type:"literal",value:"\r\n",description:'"\\r\\n"'},BA="\r",DA={type:"literal",value:"\r",description:'"\\r"'},lA="\u2028",dA={type:"literal",value:"\u2028",description:'"\\u2028"'},fA="\u2029",hA={type:"literal",value:"\u2029",description:'"\\u2029"'},vA={type:"other",description:"comment"},gA="/*",mA={type:"literal",value:"/*",description:'"/*"'},yA="*/",PA={type:"literal",value:"*/",description:'"*/"'},bA="//",xA={type:"literal",value:"//",description:'"//"'},_A=function(u){return u},$A={type:"other",description:"identifier"},RA=function(u,e){return u+e.join("")},kA="_",SA={type:"literal",value:"_",description:'"_"'},IA="\\",OA={type:"literal",value:"\\",description:'"\\\\"'},LA=function(u){return u},TA="â€Œ",wA={type:"literal",value:"â€Œ",description:'"\\u200C"'},NA="â€",jA={type:"literal",value:"â€",description:'"\\u200D"'},UA={type:"other",description:"literal"},HA="i",zA={type:"literal",value:"i",description:'"i"'},MA=function(u,e){return{type:"literal",value:u,ignoreCase:null!==e,location:t()}},GA={type:"other",description:"string"},qA='"',YA={type:"literal",value:'"',description:'"\\""'},VA=function(u){return u.join("")},WA="'",XA={type:"literal",value:"'",description:'"\'"'},JA=function(){return A()},ZA={type:"other",description:"character class"},KA="[",QA={type:"literal",value:"[",description:'"["'},ut="^",et={type:"literal",value:"^",description:'"^"'},At="]",tt={type:"literal",
value:"]",description:'"]"'},rt=function(u,e,r){return{type:"class",parts:ne(e),inverted:null!==u,ignoreCase:null!==r,rawText:A(),location:t()}},nt="-",Et={type:"literal",value:"-",description:'"-"'},Ct=function(u,e){return u.charCodeAt(0)>e.charCodeAt(0)&&r("Invalid character range: "+A()+"."),[u,e]},st=function(){return""},it="0",at={type:"literal",value:"0",description:'"0"'},Ft=function(){return"\x00"},ot="b",ct={type:"literal",value:"b",description:'"b"'},pt=function(){return"\b"},Bt="f",Dt={type:"literal",value:"f",description:'"f"'},lt=function(){return"\f"},dt="n",ft={type:"literal",value:"n",description:'"n"'},ht=function(){return"\n"},vt="r",gt={type:"literal",value:"r",description:'"r"'},mt=function(){return"\r"},yt="t",Pt={type:"literal",value:"t",description:'"t"'},bt=function(){return"	"},xt="v",_t={type:"literal",value:"v",description:'"v"'},$t=function(){return""},Rt="x",kt={type:"literal",value:"x",description:'"x"'},St="u",It={type:"literal",value:"u",description:'"u"'},Ot=function(u){return String.fromCharCode(parseInt(u,16))},Lt=/^[0-9]/,Tt={type:"class",value:"[0-9]",description:"[0-9]"},wt=/^[0-9a-f]/i,Nt={type:"class",value:"[0-9a-f]i",description:"[0-9a-f]i"},jt=".",Ut={type:"literal",value:".",description:'"."'},Ht=function(){return{type:"any",location:t()}},zt={type:"other",description:"code block"},Mt="{",Gt={type:"literal",value:"{",description:'"{"'},qt="}",Yt={type:"literal",value:"}",description:'"}"'},Vt=function(u){return u},Wt=/^[{}]/,Xt={type:"class",value:"[{}]",description:"[{}]"},Jt=/^[a-z\xB5\xDF-\xF6\xF8-\xFF\u0101\u0103\u0105\u0107\u0109\u010B\u010D\u010F\u0111\u0113\u0115\u0117\u0119\u011B\u011D\u011F\u0121\u0123\u0125\u0127\u0129\u012B\u012D\u012F\u0131\u0133\u0135\u0137-\u0138\u013A\u013C\u013E\u0140\u0142\u0144\u0146\u0148-\u0149\u014B\u014D\u014F\u0151\u0153\u0155\u0157\u0159\u015B\u015D\u015F\u0161\u0163\u0165\u0167\u0169\u016B\u016D\u016F\u0171\u0173\u0175\u0177\u017A\u017C\u017E-\u0180\u0183\u0185\u0188\u018C-\u018D\u0192\u0195\u0199-\u019B\u019E\u01A1\u01A3\u01A5\u01A8\u01AA-\u01AB\u01AD\u01B0\u01B4\u01B6\u01B9-\u01BA\u01BD-\u01BF\u01C6\u01C9\u01CC\u01CE\u01D0\u01D2\u01D4\u01D6\u01D8\u01DA\u01DC-\u01DD\u01DF\u01E1\u01E3\u01E5\u01E7\u01E9\u01EB\u01ED\u01EF-\u01F0\u01F3\u01F5\u01F9\u01FB\u01FD\u01FF\u0201\u0203\u0205\u0207\u0209\u020B\u020D\u020F\u0211\u0213\u0215\u0217\u0219\u021B\u021D\u021F\u0221\u0223\u0225\u0227\u0229\u022B\u022D\u022F\u0231\u0233-\u0239\u023C\u023F-\u0240\u0242\u0247\u0249\u024B\u024D\u024F-\u0293\u0295-\u02AF\u0371\u0373\u0377\u037B-\u037D\u0390\u03AC-\u03CE\u03D0-\u03D1\u03D5-\u03D7\u03D9\u03DB\u03DD\u03DF\u03E1\u03E3\u03E5\u03E7\u03E9\u03EB\u03ED\u03EF-\u03F3\u03F5\u03F8\u03FB-\u03FC\u0430-\u045F\u0461\u0463\u0465\u0467\u0469\u046B\u046D\u046F\u0471\u0473\u0475\u0477\u0479\u047B\u047D\u047F\u0481\u048B\u048D\u048F\u0491\u0493\u0495\u0497\u0499\u049B\u049D\u049F\u04A1\u04A3\u04A5\u04A7\u04A9\u04AB\u04AD\u04AF\u04B1\u04B3\u04B5\u04B7\u04B9\u04BB\u04BD\u04BF\u04C2\u04C4\u04C6\u04C8\u04CA\u04CC\u04CE-\u04CF\u04D1\u04D3\u04D5\u04D7\u04D9\u04DB\u04DD\u04DF\u04E1\u04E3\u04E5\u04E7\u04E9\u04EB\u04ED\u04EF\u04F1\u04F3\u04F5\u04F7\u04F9\u04FB\u04FD\u04FF\u0501\u0503\u0505\u0507\u0509\u050B\u050D\u050F\u0511\u0513\u0515\u0517\u0519\u051B\u051D\u051F\u0521\u0523\u0525\u0527\u0529\u052B\u052D\u052F\u0561-\u0587\u13F8-\u13FD\u1D00-\u1D2B\u1D6B-\u1D77\u1D79-\u1D9A\u1E01\u1E03\u1E05\u1E07\u1E09\u1E0B\u1E0D\u1E0F\u1E11\u1E13\u1E15\u1E17\u1E19\u1E1B\u1E1D\u1E1F\u1E21\u1E23\u1E25\u1E27\u1E29\u1E2B\u1E2D\u1E2F\u1E31\u1E33\u1E35\u1E37\u1E39\u1E3B\u1E3D\u1E3F\u1E41\u1E43\u1E45\u1E47\u1E49\u1E4B\u1E4D\u1E4F\u1E51\u1E53\u1E55\u1E57\u1E59\u1E5B\u1E5D\u1E5F\u1E61\u1E63\u1E65\u1E67\u1E69\u1E6B\u1E6D\u1E6F\u1E71\u1E73\u1E75\u1E77\u1E79\u1E7B\u1E7D\u1E7F\u1E81\u1E83\u1E85\u1E87\u1E89\u1E8B\u1E8D\u1E8F\u1E91\u1E93\u1E95-\u1E9D\u1E9F\u1EA1\u1EA3\u1EA5\u1EA7\u1EA9\u1EAB\u1EAD\u1EAF\u1EB1\u1EB3\u1EB5\u1EB7\u1EB9\u1EBB\u1EBD\u1EBF\u1EC1\u1EC3\u1EC5\u1EC7\u1EC9\u1ECB\u1ECD\u1ECF\u1ED1\u1ED3\u1ED5\u1ED7\u1ED9\u1EDB\u1EDD\u1EDF\u1EE1\u1EE3\u1EE5\u1EE7\u1EE9\u1EEB\u1EED\u1EEF\u1EF1\u1EF3\u1EF5\u1EF7\u1EF9\u1EFB\u1EFD\u1EFF-\u1F07\u1F10-\u1F15\u1F20-\u1F27\u1F30-\u1F37\u1F40-\u1F45\u1F50-\u1F57\u1F60-\u1F67\u1F70-\u1F7D\u1F80-\u1F87\u1F90-\u1F97\u1FA0-\u1FA7\u1FB0-\u1FB4\u1FB6-\u1FB7\u1FBE\u1FC2-\u1FC4\u1FC6-\u1FC7\u1FD0-\u1FD3\u1FD6-\u1FD7\u1FE0-\u1FE7\u1FF2-\u1FF4\u1FF6-\u1FF7\u210A\u210E-\u210F\u2113\u212F\u2134\u2139\u213C-\u213D\u2146-\u2149\u214E\u2184\u2C30-\u2C5E\u2C61\u2C65-\u2C66\u2C68\u2C6A\u2C6C\u2C71\u2C73-\u2C74\u2C76-\u2C7B\u2C81\u2C83\u2C85\u2C87\u2C89\u2C8B\u2C8D\u2C8F\u2C91\u2C93\u2C95\u2C97\u2C99\u2C9B\u2C9D\u2C9F\u2CA1\u2CA3\u2CA5\u2CA7\u2CA9\u2CAB\u2CAD\u2CAF\u2CB1\u2CB3\u2CB5\u2CB7\u2CB9\u2CBB\u2CBD\u2CBF\u2CC1\u2CC3\u2CC5\u2CC7\u2CC9\u2CCB\u2CCD\u2CCF\u2CD1\u2CD3\u2CD5\u2CD7\u2CD9\u2CDB\u2CDD\u2CDF\u2CE1\u2CE3-\u2CE4\u2CEC\u2CEE\u2CF3\u2D00-\u2D25\u2D27\u2D2D\uA641\uA643\uA645\uA647\uA649\uA64B\uA64D\uA64F\uA651\uA653\uA655\uA657\uA659\uA65B\uA65D\uA65F\uA661\uA663\uA665\uA667\uA669\uA66B\uA66D\uA681\uA683\uA685\uA687\uA689\uA68B\uA68D\uA68F\uA691\uA693\uA695\uA697\uA699\uA69B\uA723\uA725\uA727\uA729\uA72B\uA72D\uA72F-\uA731\uA733\uA735\uA737\uA739\uA73B\uA73D\uA73F\uA741\uA743\uA745\uA747\uA749\uA74B\uA74D\uA74F\uA751\uA753\uA755\uA757\uA759\uA75B\uA75D\uA75F\uA761\uA763\uA765\uA767\uA769\uA76B\uA76D\uA76F\uA771-\uA778\uA77A\uA77C\uA77F\uA781\uA783\uA785\uA787\uA78C\uA78E\uA791\uA793-\uA795\uA797\uA799\uA79B\uA79D\uA79F\uA7A1\uA7A3\uA7A5\uA7A7\uA7A9\uA7B5\uA7B7\uA7FA\uAB30-\uAB5A\uAB60-\uAB65\uAB70-\uABBF\uFB00-\uFB06\uFB13-\uFB17\uFF41-\uFF5A]/,Zt={type:"class",value:"[\\u0061-\\u007A\\u00B5\\u00DF-\\u00F6\\u00F8-\\u00FF\\u0101\\u0103\\u0105\\u0107\\u0109\\u010B\\u010D\\u010F\\u0111\\u0113\\u0115\\u0117\\u0119\\u011B\\u011D\\u011F\\u0121\\u0123\\u0125\\u0127\\u0129\\u012B\\u012D\\u012F\\u0131\\u0133\\u0135\\u0137-\\u0138\\u013A\\u013C\\u013E\\u0140\\u0142\\u0144\\u0146\\u0148-\\u0149\\u014B\\u014D\\u014F\\u0151\\u0153\\u0155\\u0157\\u0159\\u015B\\u015D\\u015F\\u0161\\u0163\\u0165\\u0167\\u0169\\u016B\\u016D\\u016F\\u0171\\u0173\\u0175\\u0177\\u017A\\u017C\\u017E-\\u0180\\u0183\\u0185\\u0188\\u018C-\\u018D\\u0192\\u0195\\u0199-\\u019B\\u019E\\u01A1\\u01A3\\u01A5\\u01A8\\u01AA-\\u01AB\\u01AD\\u01B0\\u01B4\\u01B6\\u01B9-\\u01BA\\u01BD-\\u01BF\\u01C6\\u01C9\\u01CC\\u01CE\\u01D0\\u01D2\\u01D4\\u01D6\\u01D8\\u01DA\\u01DC-\\u01DD\\u01DF\\u01E1\\u01E3\\u01E5\\u01E7\\u01E9\\u01EB\\u01ED\\u01EF-\\u01F0\\u01F3\\u01F5\\u01F9\\u01FB\\u01FD\\u01FF\\u0201\\u0203\\u0205\\u0207\\u0209\\u020B\\u020D\\u020F\\u0211\\u0213\\u0215\\u0217\\u0219\\u021B\\u021D\\u021F\\u0221\\u0223\\u0225\\u0227\\u0229\\u022B\\u022D\\u022F\\u0231\\u0233-\\u0239\\u023C\\u023F-\\u0240\\u0242\\u0247\\u0249\\u024B\\u024D\\u024F-\\u0293\\u0295-\\u02AF\\u0371\\u0373\\u0377\\u037B-\\u037D\\u0390\\u03AC-\\u03CE\\u03D0-\\u03D1\\u03D5-\\u03D7\\u03D9\\u03DB\\u03DD\\u03DF\\u03E1\\u03E3\\u03E5\\u03E7\\u03E9\\u03EB\\u03ED\\u03EF-\\u03F3\\u03F5\\u03F8\\u03FB-\\u03FC\\u0430-\\u045F\\u0461\\u0463\\u0465\\u0467\\u0469\\u046B\\u046D\\u046F\\u0471\\u0473\\u0475\\u0477\\u0479\\u047B\\u047D\\u047F\\u0481\\u048B\\u048D\\u048F\\u0491\\u0493\\u0495\\u0497\\u0499\\u049B\\u049D\\u049F\\u04A1\\u04A3\\u04A5\\u04A7\\u04A9\\u04AB\\u04AD\\u04AF\\u04B1\\u04B3\\u04B5\\u04B7\\u04B9\\u04BB\\u04BD\\u04BF\\u04C2\\u04C4\\u04C6\\u04C8\\u04CA\\u04CC\\u04CE-\\u04CF\\u04D1\\u04D3\\u04D5\\u04D7\\u04D9\\u04DB\\u04DD\\u04DF\\u04E1\\u04E3\\u04E5\\u04E7\\u04E9\\u04EB\\u04ED\\u04EF\\u04F1\\u04F3\\u04F5\\u04F7\\u04F9\\u04FB\\u04FD\\u04FF\\u0501\\u0503\\u0505\\u0507\\u0509\\u050B\\u050D\\u050F\\u0511\\u0513\\u0515\\u0517\\u0519\\u051B\\u051D\\u051F\\u0521\\u0523\\u0525\\u0527\\u0529\\u052B\\u052D\\u052F\\u0561-\\u0587\\u13F8-\\u13FD\\u1D00-\\u1D2B\\u1D6B-\\u1D77\\u1D79-\\u1D9A\\u1E01\\u1E03\\u1E05\\u1E07\\u1E09\\u1E0B\\u1E0D\\u1E0F\\u1E11\\u1E13\\u1E15\\u1E17\\u1E19\\u1E1B\\u1E1D\\u1E1F\\u1E21\\u1E23\\u1E25\\u1E27\\u1E29\\u1E2B\\u1E2D\\u1E2F\\u1E31\\u1E33\\u1E35\\u1E37\\u1E39\\u1E3B\\u1E3D\\u1E3F\\u1E41\\u1E43\\u1E45\\u1E47\\u1E49\\u1E4B\\u1E4D\\u1E4F\\u1E51\\u1E53\\u1E55\\u1E57\\u1E59\\u1E5B\\u1E5D\\u1E5F\\u1E61\\u1E63\\u1E65\\u1E67\\u1E69\\u1E6B\\u1E6D\\u1E6F\\u1E71\\u1E73\\u1E75\\u1E77\\u1E79\\u1E7B\\u1E7D\\u1E7F\\u1E81\\u1E83\\u1E85\\u1E87\\u1E89\\u1E8B\\u1E8D\\u1E8F\\u1E91\\u1E93\\u1E95-\\u1E9D\\u1E9F\\u1EA1\\u1EA3\\u1EA5\\u1EA7\\u1EA9\\u1EAB\\u1EAD\\u1EAF\\u1EB1\\u1EB3\\u1EB5\\u1EB7\\u1EB9\\u1EBB\\u1EBD\\u1EBF\\u1EC1\\u1EC3\\u1EC5\\u1EC7\\u1EC9\\u1ECB\\u1ECD\\u1ECF\\u1ED1\\u1ED3\\u1ED5\\u1ED7\\u1ED9\\u1EDB\\u1EDD\\u1EDF\\u1EE1\\u1EE3\\u1EE5\\u1EE7\\u1EE9\\u1EEB\\u1EED\\u1EEF\\u1EF1\\u1EF3\\u1EF5\\u1EF7\\u1EF9\\u1EFB\\u1EFD\\u1EFF-\\u1F07\\u1F10-\\u1F15\\u1F20-\\u1F27\\u1F30-\\u1F37\\u1F40-\\u1F45\\u1F50-\\u1F57\\u1F60-\\u1F67\\u1F70-\\u1F7D\\u1F80-\\u1F87\\u1F90-\\u1F97\\u1FA0-\\u1FA7\\u1FB0-\\u1FB4\\u1FB6-\\u1FB7\\u1FBE\\u1FC2-\\u1FC4\\u1FC6-\\u1FC7\\u1FD0-\\u1FD3\\u1FD6-\\u1FD7\\u1FE0-\\u1FE7\\u1FF2-\\u1FF4\\u1FF6-\\u1FF7\\u210A\\u210E-\\u210F\\u2113\\u212F\\u2134\\u2139\\u213C-\\u213D\\u2146-\\u2149\\u214E\\u2184\\u2C30-\\u2C5E\\u2C61\\u2C65-\\u2C66\\u2C68\\u2C6A\\u2C6C\\u2C71\\u2C73-\\u2C74\\u2C76-\\u2C7B\\u2C81\\u2C83\\u2C85\\u2C87\\u2C89\\u2C8B\\u2C8D\\u2C8F\\u2C91\\u2C93\\u2C95\\u2C97\\u2C99\\u2C9B\\u2C9D\\u2C9F\\u2CA1\\u2CA3\\u2CA5\\u2CA7\\u2CA9\\u2CAB\\u2CAD\\u2CAF\\u2CB1\\u2CB3\\u2CB5\\u2CB7\\u2CB9\\u2CBB\\u2CBD\\u2CBF\\u2CC1\\u2CC3\\u2CC5\\u2CC7\\u2CC9\\u2CCB\\u2CCD\\u2CCF\\u2CD1\\u2CD3\\u2CD5\\u2CD7\\u2CD9\\u2CDB\\u2CDD\\u2CDF\\u2CE1\\u2CE3-\\u2CE4\\u2CEC\\u2CEE\\u2CF3\\u2D00-\\u2D25\\u2D27\\u2D2D\\uA641\\uA643\\uA645\\uA647\\uA649\\uA64B\\uA64D\\uA64F\\uA651\\uA653\\uA655\\uA657\\uA659\\uA65B\\uA65D\\uA65F\\uA661\\uA663\\uA665\\uA667\\uA669\\uA66B\\uA66D\\uA681\\uA683\\uA685\\uA687\\uA689\\uA68B\\uA68D\\uA68F\\uA691\\uA693\\uA695\\uA697\\uA699\\uA69B\\uA723\\uA725\\uA727\\uA729\\uA72B\\uA72D\\uA72F-\\uA731\\uA733\\uA735\\uA737\\uA739\\uA73B\\uA73D\\uA73F\\uA741\\uA743\\uA745\\uA747\\uA749\\uA74B\\uA74D\\uA74F\\uA751\\uA753\\uA755\\uA757\\uA759\\uA75B\\uA75D\\uA75F\\uA761\\uA763\\uA765\\uA767\\uA769\\uA76B\\uA76D\\uA76F\\uA771-\\uA778\\uA77A\\uA77C\\uA77F\\uA781\\uA783\\uA785\\uA787\\uA78C\\uA78E\\uA791\\uA793-\\uA795\\uA797\\uA799\\uA79B\\uA79D\\uA79F\\uA7A1\\uA7A3\\uA7A5\\uA7A7\\uA7A9\\uA7B5\\uA7B7\\uA7FA\\uAB30-\\uAB5A\\uAB60-\\uAB65\\uAB70-\\uABBF\\uFB00-\\uFB06\\uFB13-\\uFB17\\uFF41-\\uFF5A]",description:"[\\u0061-\\u007A\\u00B5\\u00DF-\\u00F6\\u00F8-\\u00FF\\u0101\\u0103\\u0105\\u0107\\u0109\\u010B\\u010D\\u010F\\u0111\\u0113\\u0115\\u0117\\u0119\\u011B\\u011D\\u011F\\u0121\\u0123\\u0125\\u0127\\u0129\\u012B\\u012D\\u012F\\u0131\\u0133\\u0135\\u0137-\\u0138\\u013A\\u013C\\u013E\\u0140\\u0142\\u0144\\u0146\\u0148-\\u0149\\u014B\\u014D\\u014F\\u0151\\u0153\\u0155\\u0157\\u0159\\u015B\\u015D\\u015F\\u0161\\u0163\\u0165\\u0167\\u0169\\u016B\\u016D\\u016F\\u0171\\u0173\\u0175\\u0177\\u017A\\u017C\\u017E-\\u0180\\u0183\\u0185\\u0188\\u018C-\\u018D\\u0192\\u0195\\u0199-\\u019B\\u019E\\u01A1\\u01A3\\u01A5\\u01A8\\u01AA-\\u01AB\\u01AD\\u01B0\\u01B4\\u01B6\\u01B9-\\u01BA\\u01BD-\\u01BF\\u01C6\\u01C9\\u01CC\\u01CE\\u01D0\\u01D2\\u01D4\\u01D6\\u01D8\\u01DA\\u01DC-\\u01DD\\u01DF\\u01E1\\u01E3\\u01E5\\u01E7\\u01E9\\u01EB\\u01ED\\u01EF-\\u01F0\\u01F3\\u01F5\\u01F9\\u01FB\\u01FD\\u01FF\\u0201\\u0203\\u0205\\u0207\\u0209\\u020B\\u020D\\u020F\\u0211\\u0213\\u0215\\u0217\\u0219\\u021B\\u021D\\u021F\\u0221\\u0223\\u0225\\u0227\\u0229\\u022B\\u022D\\u022F\\u0231\\u0233-\\u0239\\u023C\\u023F-\\u0240\\u0242\\u0247\\u0249\\u024B\\u024D\\u024F-\\u0293\\u0295-\\u02AF\\u0371\\u0373\\u0377\\u037B-\\u037D\\u0390\\u03AC-\\u03CE\\u03D0-\\u03D1\\u03D5-\\u03D7\\u03D9\\u03DB\\u03DD\\u03DF\\u03E1\\u03E3\\u03E5\\u03E7\\u03E9\\u03EB\\u03ED\\u03EF-\\u03F3\\u03F5\\u03F8\\u03FB-\\u03FC\\u0430-\\u045F\\u0461\\u0463\\u0465\\u0467\\u0469\\u046B\\u046D\\u046F\\u0471\\u0473\\u0475\\u0477\\u0479\\u047B\\u047D\\u047F\\u0481\\u048B\\u048D\\u048F\\u0491\\u0493\\u0495\\u0497\\u0499\\u049B\\u049D\\u049F\\u04A1\\u04A3\\u04A5\\u04A7\\u04A9\\u04AB\\u04AD\\u04AF\\u04B1\\u04B3\\u04B5\\u04B7\\u04B9\\u04BB\\u04BD\\u04BF\\u04C2\\u04C4\\u04C6\\u04C8\\u04CA\\u04CC\\u04CE-\\u04CF\\u04D1\\u04D3\\u04D5\\u04D7\\u04D9\\u04DB\\u04DD\\u04DF\\u04E1\\u04E3\\u04E5\\u04E7\\u04E9\\u04EB\\u04ED\\u04EF\\u04F1\\u04F3\\u04F5\\u04F7\\u04F9\\u04FB\\u04FD\\u04FF\\u0501\\u0503\\u0505\\u0507\\u0509\\u050B\\u050D\\u050F\\u0511\\u0513\\u0515\\u0517\\u0519\\u051B\\u051D\\u051F\\u0521\\u0523\\u0525\\u0527\\u0529\\u052B\\u052D\\u052F\\u0561-\\u0587\\u13F8-\\u13FD\\u1D00-\\u1D2B\\u1D6B-\\u1D77\\u1D79-\\u1D9A\\u1E01\\u1E03\\u1E05\\u1E07\\u1E09\\u1E0B\\u1E0D\\u1E0F\\u1E11\\u1E13\\u1E15\\u1E17\\u1E19\\u1E1B\\u1E1D\\u1E1F\\u1E21\\u1E23\\u1E25\\u1E27\\u1E29\\u1E2B\\u1E2D\\u1E2F\\u1E31\\u1E33\\u1E35\\u1E37\\u1E39\\u1E3B\\u1E3D\\u1E3F\\u1E41\\u1E43\\u1E45\\u1E47\\u1E49\\u1E4B\\u1E4D\\u1E4F\\u1E51\\u1E53\\u1E55\\u1E57\\u1E59\\u1E5B\\u1E5D\\u1E5F\\u1E61\\u1E63\\u1E65\\u1E67\\u1E69\\u1E6B\\u1E6D\\u1E6F\\u1E71\\u1E73\\u1E75\\u1E77\\u1E79\\u1E7B\\u1E7D\\u1E7F\\u1E81\\u1E83\\u1E85\\u1E87\\u1E89\\u1E8B\\u1E8D\\u1E8F\\u1E91\\u1E93\\u1E95-\\u1E9D\\u1E9F\\u1EA1\\u1EA3\\u1EA5\\u1EA7\\u1EA9\\u1EAB\\u1EAD\\u1EAF\\u1EB1\\u1EB3\\u1EB5\\u1EB7\\u1EB9\\u1EBB\\u1EBD\\u1EBF\\u1EC1\\u1EC3\\u1EC5\\u1EC7\\u1EC9\\u1ECB\\u1ECD\\u1ECF\\u1ED1\\u1ED3\\u1ED5\\u1ED7\\u1ED9\\u1EDB\\u1EDD\\u1EDF\\u1EE1\\u1EE3\\u1EE5\\u1EE7\\u1EE9\\u1EEB\\u1EED\\u1EEF\\u1EF1\\u1EF3\\u1EF5\\u1EF7\\u1EF9\\u1EFB\\u1EFD\\u1EFF-\\u1F07\\u1F10-\\u1F15\\u1F20-\\u1F27\\u1F30-\\u1F37\\u1F40-\\u1F45\\u1F50-\\u1F57\\u1F60-\\u1F67\\u1F70-\\u1F7D\\u1F80-\\u1F87\\u1F90-\\u1F97\\u1FA0-\\u1FA7\\u1FB0-\\u1FB4\\u1FB6-\\u1FB7\\u1FBE\\u1FC2-\\u1FC4\\u1FC6-\\u1FC7\\u1FD0-\\u1FD3\\u1FD6-\\u1FD7\\u1FE0-\\u1FE7\\u1FF2-\\u1FF4\\u1FF6-\\u1FF7\\u210A\\u210E-\\u210F\\u2113\\u212F\\u2134\\u2139\\u213C-\\u213D\\u2146-\\u2149\\u214E\\u2184\\u2C30-\\u2C5E\\u2C61\\u2C65-\\u2C66\\u2C68\\u2C6A\\u2C6C\\u2C71\\u2C73-\\u2C74\\u2C76-\\u2C7B\\u2C81\\u2C83\\u2C85\\u2C87\\u2C89\\u2C8B\\u2C8D\\u2C8F\\u2C91\\u2C93\\u2C95\\u2C97\\u2C99\\u2C9B\\u2C9D\\u2C9F\\u2CA1\\u2CA3\\u2CA5\\u2CA7\\u2CA9\\u2CAB\\u2CAD\\u2CAF\\u2CB1\\u2CB3\\u2CB5\\u2CB7\\u2CB9\\u2CBB\\u2CBD\\u2CBF\\u2CC1\\u2CC3\\u2CC5\\u2CC7\\u2CC9\\u2CCB\\u2CCD\\u2CCF\\u2CD1\\u2CD3\\u2CD5\\u2CD7\\u2CD9\\u2CDB\\u2CDD\\u2CDF\\u2CE1\\u2CE3-\\u2CE4\\u2CEC\\u2CEE\\u2CF3\\u2D00-\\u2D25\\u2D27\\u2D2D\\uA641\\uA643\\uA645\\uA647\\uA649\\uA64B\\uA64D\\uA64F\\uA651\\uA653\\uA655\\uA657\\uA659\\uA65B\\uA65D\\uA65F\\uA661\\uA663\\uA665\\uA667\\uA669\\uA66B\\uA66D\\uA681\\uA683\\uA685\\uA687\\uA689\\uA68B\\uA68D\\uA68F\\uA691\\uA693\\uA695\\uA697\\uA699\\uA69B\\uA723\\uA725\\uA727\\uA729\\uA72B\\uA72D\\uA72F-\\uA731\\uA733\\uA735\\uA737\\uA739\\uA73B\\uA73D\\uA73F\\uA741\\uA743\\uA745\\uA747\\uA749\\uA74B\\uA74D\\uA74F\\uA751\\uA753\\uA755\\uA757\\uA759\\uA75B\\uA75D\\uA75F\\uA761\\uA763\\uA765\\uA767\\uA769\\uA76B\\uA76D\\uA76F\\uA771-\\uA778\\uA77A\\uA77C\\uA77F\\uA781\\uA783\\uA785\\uA787\\uA78C\\uA78E\\uA791\\uA793-\\uA795\\uA797\\uA799\\uA79B\\uA79D\\uA79F\\uA7A1\\uA7A3\\uA7A5\\uA7A7\\uA7A9\\uA7B5\\uA7B7\\uA7FA\\uAB30-\\uAB5A\\uAB60-\\uAB65\\uAB70-\\uABBF\\uFB00-\\uFB06\\uFB13-\\uFB17\\uFF41-\\uFF5A]"},Kt=/^[\u02B0-\u02C1\u02C6-\u02D1\u02E0-\u02E4\u02EC\u02EE\u0374\u037A\u0559\u0640\u06E5-\u06E6\u07F4-\u07F5\u07FA\u081A\u0824\u0828\u0971\u0E46\u0EC6\u10FC\u17D7\u1843\u1AA7\u1C78-\u1C7D\u1D2C-\u1D6A\u1D78\u1D9B-\u1DBF\u2071\u207F\u2090-\u209C\u2C7C-\u2C7D\u2D6F\u2E2F\u3005\u3031-\u3035\u303B\u309D-\u309E\u30FC-\u30FE\uA015\uA4F8-\uA4FD\uA60C\uA67F\uA69C-\uA69D\uA717-\uA71F\uA770\uA788\uA7F8-\uA7F9\uA9CF\uA9E6\uAA70\uAADD\uAAF3-\uAAF4\uAB5C-\uAB5F\uFF70\uFF9E-\uFF9F]/,Qt={type:"class",value:"[\\u02B0-\\u02C1\\u02C6-\\u02D1\\u02E0-\\u02E4\\u02EC\\u02EE\\u0374\\u037A\\u0559\\u0640\\u06E5-\\u06E6\\u07F4-\\u07F5\\u07FA\\u081A\\u0824\\u0828\\u0971\\u0E46\\u0EC6\\u10FC\\u17D7\\u1843\\u1AA7\\u1C78-\\u1C7D\\u1D2C-\\u1D6A\\u1D78\\u1D9B-\\u1DBF\\u2071\\u207F\\u2090-\\u209C\\u2C7C-\\u2C7D\\u2D6F\\u2E2F\\u3005\\u3031-\\u3035\\u303B\\u309D-\\u309E\\u30FC-\\u30FE\\uA015\\uA4F8-\\uA4FD\\uA60C\\uA67F\\uA69C-\\uA69D\\uA717-\\uA71F\\uA770\\uA788\\uA7F8-\\uA7F9\\uA9CF\\uA9E6\\uAA70\\uAADD\\uAAF3-\\uAAF4\\uAB5C-\\uAB5F\\uFF70\\uFF9E-\\uFF9F]",description:"[\\u02B0-\\u02C1\\u02C6-\\u02D1\\u02E0-\\u02E4\\u02EC\\u02EE\\u0374\\u037A\\u0559\\u0640\\u06E5-\\u06E6\\u07F4-\\u07F5\\u07FA\\u081A\\u0824\\u0828\\u0971\\u0E46\\u0EC6\\u10FC\\u17D7\\u1843\\u1AA7\\u1C78-\\u1C7D\\u1D2C-\\u1D6A\\u1D78\\u1D9B-\\u1DBF\\u2071\\u207F\\u2090-\\u209C\\u2C7C-\\u2C7D\\u2D6F\\u2E2F\\u3005\\u3031-\\u3035\\u303B\\u309D-\\u309E\\u30FC-\\u30FE\\uA015\\uA4F8-\\uA4FD\\uA60C\\uA67F\\uA69C-\\uA69D\\uA717-\\uA71F\\uA770\\uA788\\uA7F8-\\uA7F9\\uA9CF\\uA9E6\\uAA70\\uAADD\\uAAF3-\\uAAF4\\uAB5C-\\uAB5F\\uFF70\\uFF9E-\\uFF9F]"},ur=/^[\xAA\xBA\u01BB\u01C0-\u01C3\u0294\u05D0-\u05EA\u05F0-\u05F2\u0620-\u063F\u0641-\u064A\u066E-\u066F\u0671-\u06D3\u06D5\u06EE-\u06EF\u06FA-\u06FC\u06FF\u0710\u0712-\u072F\u074D-\u07A5\u07B1\u07CA-\u07EA\u0800-\u0815\u0840-\u0858\u08A0-\u08B4\u0904-\u0939\u093D\u0950\u0958-\u0961\u0972-\u0980\u0985-\u098C\u098F-\u0990\u0993-\u09A8\u09AA-\u09B0\u09B2\u09B6-\u09B9\u09BD\u09CE\u09DC-\u09DD\u09DF-\u09E1\u09F0-\u09F1\u0A05-\u0A0A\u0A0F-\u0A10\u0A13-\u0A28\u0A2A-\u0A30\u0A32-\u0A33\u0A35-\u0A36\u0A38-\u0A39\u0A59-\u0A5C\u0A5E\u0A72-\u0A74\u0A85-\u0A8D\u0A8F-\u0A91\u0A93-\u0AA8\u0AAA-\u0AB0\u0AB2-\u0AB3\u0AB5-\u0AB9\u0ABD\u0AD0\u0AE0-\u0AE1\u0AF9\u0B05-\u0B0C\u0B0F-\u0B10\u0B13-\u0B28\u0B2A-\u0B30\u0B32-\u0B33\u0B35-\u0B39\u0B3D\u0B5C-\u0B5D\u0B5F-\u0B61\u0B71\u0B83\u0B85-\u0B8A\u0B8E-\u0B90\u0B92-\u0B95\u0B99-\u0B9A\u0B9C\u0B9E-\u0B9F\u0BA3-\u0BA4\u0BA8-\u0BAA\u0BAE-\u0BB9\u0BD0\u0C05-\u0C0C\u0C0E-\u0C10\u0C12-\u0C28\u0C2A-\u0C39\u0C3D\u0C58-\u0C5A\u0C60-\u0C61\u0C85-\u0C8C\u0C8E-\u0C90\u0C92-\u0CA8\u0CAA-\u0CB3\u0CB5-\u0CB9\u0CBD\u0CDE\u0CE0-\u0CE1\u0CF1-\u0CF2\u0D05-\u0D0C\u0D0E-\u0D10\u0D12-\u0D3A\u0D3D\u0D4E\u0D5F-\u0D61\u0D7A-\u0D7F\u0D85-\u0D96\u0D9A-\u0DB1\u0DB3-\u0DBB\u0DBD\u0DC0-\u0DC6\u0E01-\u0E30\u0E32-\u0E33\u0E40-\u0E45\u0E81-\u0E82\u0E84\u0E87-\u0E88\u0E8A\u0E8D\u0E94-\u0E97\u0E99-\u0E9F\u0EA1-\u0EA3\u0EA5\u0EA7\u0EAA-\u0EAB\u0EAD-\u0EB0\u0EB2-\u0EB3\u0EBD\u0EC0-\u0EC4\u0EDC-\u0EDF\u0F00\u0F40-\u0F47\u0F49-\u0F6C\u0F88-\u0F8C\u1000-\u102A\u103F\u1050-\u1055\u105A-\u105D\u1061\u1065-\u1066\u106E-\u1070\u1075-\u1081\u108E\u10D0-\u10FA\u10FD-\u1248\u124A-\u124D\u1250-\u1256\u1258\u125A-\u125D\u1260-\u1288\u128A-\u128D\u1290-\u12B0\u12B2-\u12B5\u12B8-\u12BE\u12C0\u12C2-\u12C5\u12C8-\u12D6\u12D8-\u1310\u1312-\u1315\u1318-\u135A\u1380-\u138F\u1401-\u166C\u166F-\u167F\u1681-\u169A\u16A0-\u16EA\u16F1-\u16F8\u1700-\u170C\u170E-\u1711\u1720-\u1731\u1740-\u1751\u1760-\u176C\u176E-\u1770\u1780-\u17B3\u17DC\u1820-\u1842\u1844-\u1877\u1880-\u18A8\u18AA\u18B0-\u18F5\u1900-\u191E\u1950-\u196D\u1970-\u1974\u1980-\u19AB\u19B0-\u19C9\u1A00-\u1A16\u1A20-\u1A54\u1B05-\u1B33\u1B45-\u1B4B\u1B83-\u1BA0\u1BAE-\u1BAF\u1BBA-\u1BE5\u1C00-\u1C23\u1C4D-\u1C4F\u1C5A-\u1C77\u1CE9-\u1CEC\u1CEE-\u1CF1\u1CF5-\u1CF6\u2135-\u2138\u2D30-\u2D67\u2D80-\u2D96\u2DA0-\u2DA6\u2DA8-\u2DAE\u2DB0-\u2DB6\u2DB8-\u2DBE\u2DC0-\u2DC6\u2DC8-\u2DCE\u2DD0-\u2DD6\u2DD8-\u2DDE\u3006\u303C\u3041-\u3096\u309F\u30A1-\u30FA\u30FF\u3105-\u312D\u3131-\u318E\u31A0-\u31BA\u31F0-\u31FF\u3400-\u4DB5\u4E00-\u9FD5\uA000-\uA014\uA016-\uA48C\uA4D0-\uA4F7\uA500-\uA60B\uA610-\uA61F\uA62A-\uA62B\uA66E\uA6A0-\uA6E5\uA78F\uA7F7\uA7FB-\uA801\uA803-\uA805\uA807-\uA80A\uA80C-\uA822\uA840-\uA873\uA882-\uA8B3\uA8F2-\uA8F7\uA8FB\uA8FD\uA90A-\uA925\uA930-\uA946\uA960-\uA97C\uA984-\uA9B2\uA9E0-\uA9E4\uA9E7-\uA9EF\uA9FA-\uA9FE\uAA00-\uAA28\uAA40-\uAA42\uAA44-\uAA4B\uAA60-\uAA6F\uAA71-\uAA76\uAA7A\uAA7E-\uAAAF\uAAB1\uAAB5-\uAAB6\uAAB9-\uAABD\uAAC0\uAAC2\uAADB-\uAADC\uAAE0-\uAAEA\uAAF2\uAB01-\uAB06\uAB09-\uAB0E\uAB11-\uAB16\uAB20-\uAB26\uAB28-\uAB2E\uABC0-\uABE2\uAC00-\uD7A3\uD7B0-\uD7C6\uD7CB-\uD7FB\uF900-\uFA6D\uFA70-\uFAD9\uFB1D\uFB1F-\uFB28\uFB2A-\uFB36\uFB38-\uFB3C\uFB3E\uFB40-\uFB41\uFB43-\uFB44\uFB46-\uFBB1\uFBD3-\uFD3D\uFD50-\uFD8F\uFD92-\uFDC7\uFDF0-\uFDFB\uFE70-\uFE74\uFE76-\uFEFC\uFF66-\uFF6F\uFF71-\uFF9D\uFFA0-\uFFBE\uFFC2-\uFFC7\uFFCA-\uFFCF\uFFD2-\uFFD7\uFFDA-\uFFDC]/,er={type:"class",value:"[\\u00AA\\u00BA\\u01BB\\u01C0-\\u01C3\\u0294\\u05D0-\\u05EA\\u05F0-\\u05F2\\u0620-\\u063F\\u0641-\\u064A\\u066E-\\u066F\\u0671-\\u06D3\\u06D5\\u06EE-\\u06EF\\u06FA-\\u06FC\\u06FF\\u0710\\u0712-\\u072F\\u074D-\\u07A5\\u07B1\\u07CA-\\u07EA\\u0800-\\u0815\\u0840-\\u0858\\u08A0-\\u08B4\\u0904-\\u0939\\u093D\\u0950\\u0958-\\u0961\\u0972-\\u0980\\u0985-\\u098C\\u098F-\\u0990\\u0993-\\u09A8\\u09AA-\\u09B0\\u09B2\\u09B6-\\u09B9\\u09BD\\u09CE\\u09DC-\\u09DD\\u09DF-\\u09E1\\u09F0-\\u09F1\\u0A05-\\u0A0A\\u0A0F-\\u0A10\\u0A13-\\u0A28\\u0A2A-\\u0A30\\u0A32-\\u0A33\\u0A35-\\u0A36\\u0A38-\\u0A39\\u0A59-\\u0A5C\\u0A5E\\u0A72-\\u0A74\\u0A85-\\u0A8D\\u0A8F-\\u0A91\\u0A93-\\u0AA8\\u0AAA-\\u0AB0\\u0AB2-\\u0AB3\\u0AB5-\\u0AB9\\u0ABD\\u0AD0\\u0AE0-\\u0AE1\\u0AF9\\u0B05-\\u0B0C\\u0B0F-\\u0B10\\u0B13-\\u0B28\\u0B2A-\\u0B30\\u0B32-\\u0B33\\u0B35-\\u0B39\\u0B3D\\u0B5C-\\u0B5D\\u0B5F-\\u0B61\\u0B71\\u0B83\\u0B85-\\u0B8A\\u0B8E-\\u0B90\\u0B92-\\u0B95\\u0B99-\\u0B9A\\u0B9C\\u0B9E-\\u0B9F\\u0BA3-\\u0BA4\\u0BA8-\\u0BAA\\u0BAE-\\u0BB9\\u0BD0\\u0C05-\\u0C0C\\u0C0E-\\u0C10\\u0C12-\\u0C28\\u0C2A-\\u0C39\\u0C3D\\u0C58-\\u0C5A\\u0C60-\\u0C61\\u0C85-\\u0C8C\\u0C8E-\\u0C90\\u0C92-\\u0CA8\\u0CAA-\\u0CB3\\u0CB5-\\u0CB9\\u0CBD\\u0CDE\\u0CE0-\\u0CE1\\u0CF1-\\u0CF2\\u0D05-\\u0D0C\\u0D0E-\\u0D10\\u0D12-\\u0D3A\\u0D3D\\u0D4E\\u0D5F-\\u0D61\\u0D7A-\\u0D7F\\u0D85-\\u0D96\\u0D9A-\\u0DB1\\u0DB3-\\u0DBB\\u0DBD\\u0DC0-\\u0DC6\\u0E01-\\u0E30\\u0E32-\\u0E33\\u0E40-\\u0E45\\u0E81-\\u0E82\\u0E84\\u0E87-\\u0E88\\u0E8A\\u0E8D\\u0E94-\\u0E97\\u0E99-\\u0E9F\\u0EA1-\\u0EA3\\u0EA5\\u0EA7\\u0EAA-\\u0EAB\\u0EAD-\\u0EB0\\u0EB2-\\u0EB3\\u0EBD\\u0EC0-\\u0EC4\\u0EDC-\\u0EDF\\u0F00\\u0F40-\\u0F47\\u0F49-\\u0F6C\\u0F88-\\u0F8C\\u1000-\\u102A\\u103F\\u1050-\\u1055\\u105A-\\u105D\\u1061\\u1065-\\u1066\\u106E-\\u1070\\u1075-\\u1081\\u108E\\u10D0-\\u10FA\\u10FD-\\u1248\\u124A-\\u124D\\u1250-\\u1256\\u1258\\u125A-\\u125D\\u1260-\\u1288\\u128A-\\u128D\\u1290-\\u12B0\\u12B2-\\u12B5\\u12B8-\\u12BE\\u12C0\\u12C2-\\u12C5\\u12C8-\\u12D6\\u12D8-\\u1310\\u1312-\\u1315\\u1318-\\u135A\\u1380-\\u138F\\u1401-\\u166C\\u166F-\\u167F\\u1681-\\u169A\\u16A0-\\u16EA\\u16F1-\\u16F8\\u1700-\\u170C\\u170E-\\u1711\\u1720-\\u1731\\u1740-\\u1751\\u1760-\\u176C\\u176E-\\u1770\\u1780-\\u17B3\\u17DC\\u1820-\\u1842\\u1844-\\u1877\\u1880-\\u18A8\\u18AA\\u18B0-\\u18F5\\u1900-\\u191E\\u1950-\\u196D\\u1970-\\u1974\\u1980-\\u19AB\\u19B0-\\u19C9\\u1A00-\\u1A16\\u1A20-\\u1A54\\u1B05-\\u1B33\\u1B45-\\u1B4B\\u1B83-\\u1BA0\\u1BAE-\\u1BAF\\u1BBA-\\u1BE5\\u1C00-\\u1C23\\u1C4D-\\u1C4F\\u1C5A-\\u1C77\\u1CE9-\\u1CEC\\u1CEE-\\u1CF1\\u1CF5-\\u1CF6\\u2135-\\u2138\\u2D30-\\u2D67\\u2D80-\\u2D96\\u2DA0-\\u2DA6\\u2DA8-\\u2DAE\\u2DB0-\\u2DB6\\u2DB8-\\u2DBE\\u2DC0-\\u2DC6\\u2DC8-\\u2DCE\\u2DD0-\\u2DD6\\u2DD8-\\u2DDE\\u3006\\u303C\\u3041-\\u3096\\u309F\\u30A1-\\u30FA\\u30FF\\u3105-\\u312D\\u3131-\\u318E\\u31A0-\\u31BA\\u31F0-\\u31FF\\u3400-\\u4DB5\\u4E00-\\u9FD5\\uA000-\\uA014\\uA016-\\uA48C\\uA4D0-\\uA4F7\\uA500-\\uA60B\\uA610-\\uA61F\\uA62A-\\uA62B\\uA66E\\uA6A0-\\uA6E5\\uA78F\\uA7F7\\uA7FB-\\uA801\\uA803-\\uA805\\uA807-\\uA80A\\uA80C-\\uA822\\uA840-\\uA873\\uA882-\\uA8B3\\uA8F2-\\uA8F7\\uA8FB\\uA8FD\\uA90A-\\uA925\\uA930-\\uA946\\uA960-\\uA97C\\uA984-\\uA9B2\\uA9E0-\\uA9E4\\uA9E7-\\uA9EF\\uA9FA-\\uA9FE\\uAA00-\\uAA28\\uAA40-\\uAA42\\uAA44-\\uAA4B\\uAA60-\\uAA6F\\uAA71-\\uAA76\\uAA7A\\uAA7E-\\uAAAF\\uAAB1\\uAAB5-\\uAAB6\\uAAB9-\\uAABD\\uAAC0\\uAAC2\\uAADB-\\uAADC\\uAAE0-\\uAAEA\\uAAF2\\uAB01-\\uAB06\\uAB09-\\uAB0E\\uAB11-\\uAB16\\uAB20-\\uAB26\\uAB28-\\uAB2E\\uABC0-\\uABE2\\uAC00-\\uD7A3\\uD7B0-\\uD7C6\\uD7CB-\\uD7FB\\uF900-\\uFA6D\\uFA70-\\uFAD9\\uFB1D\\uFB1F-\\uFB28\\uFB2A-\\uFB36\\uFB38-\\uFB3C\\uFB3E\\uFB40-\\uFB41\\uFB43-\\uFB44\\uFB46-\\uFBB1\\uFBD3-\\uFD3D\\uFD50-\\uFD8F\\uFD92-\\uFDC7\\uFDF0-\\uFDFB\\uFE70-\\uFE74\\uFE76-\\uFEFC\\uFF66-\\uFF6F\\uFF71-\\uFF9D\\uFFA0-\\uFFBE\\uFFC2-\\uFFC7\\uFFCA-\\uFFCF\\uFFD2-\\uFFD7\\uFFDA-\\uFFDC]",description:"[\\u00AA\\u00BA\\u01BB\\u01C0-\\u01C3\\u0294\\u05D0-\\u05EA\\u05F0-\\u05F2\\u0620-\\u063F\\u0641-\\u064A\\u066E-\\u066F\\u0671-\\u06D3\\u06D5\\u06EE-\\u06EF\\u06FA-\\u06FC\\u06FF\\u0710\\u0712-\\u072F\\u074D-\\u07A5\\u07B1\\u07CA-\\u07EA\\u0800-\\u0815\\u0840-\\u0858\\u08A0-\\u08B4\\u0904-\\u0939\\u093D\\u0950\\u0958-\\u0961\\u0972-\\u0980\\u0985-\\u098C\\u098F-\\u0990\\u0993-\\u09A8\\u09AA-\\u09B0\\u09B2\\u09B6-\\u09B9\\u09BD\\u09CE\\u09DC-\\u09DD\\u09DF-\\u09E1\\u09F0-\\u09F1\\u0A05-\\u0A0A\\u0A0F-\\u0A10\\u0A13-\\u0A28\\u0A2A-\\u0A30\\u0A32-\\u0A33\\u0A35-\\u0A36\\u0A38-\\u0A39\\u0A59-\\u0A5C\\u0A5E\\u0A72-\\u0A74\\u0A85-\\u0A8D\\u0A8F-\\u0A91\\u0A93-\\u0AA8\\u0AAA-\\u0AB0\\u0AB2-\\u0AB3\\u0AB5-\\u0AB9\\u0ABD\\u0AD0\\u0AE0-\\u0AE1\\u0AF9\\u0B05-\\u0B0C\\u0B0F-\\u0B10\\u0B13-\\u0B28\\u0B2A-\\u0B30\\u0B32-\\u0B33\\u0B35-\\u0B39\\u0B3D\\u0B5C-\\u0B5D\\u0B5F-\\u0B61\\u0B71\\u0B83\\u0B85-\\u0B8A\\u0B8E-\\u0B90\\u0B92-\\u0B95\\u0B99-\\u0B9A\\u0B9C\\u0B9E-\\u0B9F\\u0BA3-\\u0BA4\\u0BA8-\\u0BAA\\u0BAE-\\u0BB9\\u0BD0\\u0C05-\\u0C0C\\u0C0E-\\u0C10\\u0C12-\\u0C28\\u0C2A-\\u0C39\\u0C3D\\u0C58-\\u0C5A\\u0C60-\\u0C61\\u0C85-\\u0C8C\\u0C8E-\\u0C90\\u0C92-\\u0CA8\\u0CAA-\\u0CB3\\u0CB5-\\u0CB9\\u0CBD\\u0CDE\\u0CE0-\\u0CE1\\u0CF1-\\u0CF2\\u0D05-\\u0D0C\\u0D0E-\\u0D10\\u0D12-\\u0D3A\\u0D3D\\u0D4E\\u0D5F-\\u0D61\\u0D7A-\\u0D7F\\u0D85-\\u0D96\\u0D9A-\\u0DB1\\u0DB3-\\u0DBB\\u0DBD\\u0DC0-\\u0DC6\\u0E01-\\u0E30\\u0E32-\\u0E33\\u0E40-\\u0E45\\u0E81-\\u0E82\\u0E84\\u0E87-\\u0E88\\u0E8A\\u0E8D\\u0E94-\\u0E97\\u0E99-\\u0E9F\\u0EA1-\\u0EA3\\u0EA5\\u0EA7\\u0EAA-\\u0EAB\\u0EAD-\\u0EB0\\u0EB2-\\u0EB3\\u0EBD\\u0EC0-\\u0EC4\\u0EDC-\\u0EDF\\u0F00\\u0F40-\\u0F47\\u0F49-\\u0F6C\\u0F88-\\u0F8C\\u1000-\\u102A\\u103F\\u1050-\\u1055\\u105A-\\u105D\\u1061\\u1065-\\u1066\\u106E-\\u1070\\u1075-\\u1081\\u108E\\u10D0-\\u10FA\\u10FD-\\u1248\\u124A-\\u124D\\u1250-\\u1256\\u1258\\u125A-\\u125D\\u1260-\\u1288\\u128A-\\u128D\\u1290-\\u12B0\\u12B2-\\u12B5\\u12B8-\\u12BE\\u12C0\\u12C2-\\u12C5\\u12C8-\\u12D6\\u12D8-\\u1310\\u1312-\\u1315\\u1318-\\u135A\\u1380-\\u138F\\u1401-\\u166C\\u166F-\\u167F\\u1681-\\u169A\\u16A0-\\u16EA\\u16F1-\\u16F8\\u1700-\\u170C\\u170E-\\u1711\\u1720-\\u1731\\u1740-\\u1751\\u1760-\\u176C\\u176E-\\u1770\\u1780-\\u17B3\\u17DC\\u1820-\\u1842\\u1844-\\u1877\\u1880-\\u18A8\\u18AA\\u18B0-\\u18F5\\u1900-\\u191E\\u1950-\\u196D\\u1970-\\u1974\\u1980-\\u19AB\\u19B0-\\u19C9\\u1A00-\\u1A16\\u1A20-\\u1A54\\u1B05-\\u1B33\\u1B45-\\u1B4B\\u1B83-\\u1BA0\\u1BAE-\\u1BAF\\u1BBA-\\u1BE5\\u1C00-\\u1C23\\u1C4D-\\u1C4F\\u1C5A-\\u1C77\\u1CE9-\\u1CEC\\u1CEE-\\u1CF1\\u1CF5-\\u1CF6\\u2135-\\u2138\\u2D30-\\u2D67\\u2D80-\\u2D96\\u2DA0-\\u2DA6\\u2DA8-\\u2DAE\\u2DB0-\\u2DB6\\u2DB8-\\u2DBE\\u2DC0-\\u2DC6\\u2DC8-\\u2DCE\\u2DD0-\\u2DD6\\u2DD8-\\u2DDE\\u3006\\u303C\\u3041-\\u3096\\u309F\\u30A1-\\u30FA\\u30FF\\u3105-\\u312D\\u3131-\\u318E\\u31A0-\\u31BA\\u31F0-\\u31FF\\u3400-\\u4DB5\\u4E00-\\u9FD5\\uA000-\\uA014\\uA016-\\uA48C\\uA4D0-\\uA4F7\\uA500-\\uA60B\\uA610-\\uA61F\\uA62A-\\uA62B\\uA66E\\uA6A0-\\uA6E5\\uA78F\\uA7F7\\uA7FB-\\uA801\\uA803-\\uA805\\uA807-\\uA80A\\uA80C-\\uA822\\uA840-\\uA873\\uA882-\\uA8B3\\uA8F2-\\uA8F7\\uA8FB\\uA8FD\\uA90A-\\uA925\\uA930-\\uA946\\uA960-\\uA97C\\uA984-\\uA9B2\\uA9E0-\\uA9E4\\uA9E7-\\uA9EF\\uA9FA-\\uA9FE\\uAA00-\\uAA28\\uAA40-\\uAA42\\uAA44-\\uAA4B\\uAA60-\\uAA6F\\uAA71-\\uAA76\\uAA7A\\uAA7E-\\uAAAF\\uAAB1\\uAAB5-\\uAAB6\\uAAB9-\\uAABD\\uAAC0\\uAAC2\\uAADB-\\uAADC\\uAAE0-\\uAAEA\\uAAF2\\uAB01-\\uAB06\\uAB09-\\uAB0E\\uAB11-\\uAB16\\uAB20-\\uAB26\\uAB28-\\uAB2E\\uABC0-\\uABE2\\uAC00-\\uD7A3\\uD7B0-\\uD7C6\\uD7CB-\\uD7FB\\uF900-\\uFA6D\\uFA70-\\uFAD9\\uFB1D\\uFB1F-\\uFB28\\uFB2A-\\uFB36\\uFB38-\\uFB3C\\uFB3E\\uFB40-\\uFB41\\uFB43-\\uFB44\\uFB46-\\uFBB1\\uFBD3-\\uFD3D\\uFD50-\\uFD8F\\uFD92-\\uFDC7\\uFDF0-\\uFDFB\\uFE70-\\uFE74\\uFE76-\\uFEFC\\uFF66-\\uFF6F\\uFF71-\\uFF9D\\uFFA0-\\uFFBE\\uFFC2-\\uFFC7\\uFFCA-\\uFFCF\\uFFD2-\\uFFD7\\uFFDA-\\uFFDC]"},Ar=/^[\u01C5\u01C8\u01CB\u01F2\u1F88-\u1F8F\u1F98-\u1F9F\u1FA8-\u1FAF\u1FBC\u1FCC\u1FFC]/,tr={type:"class",value:"[\\u01C5\\u01C8\\u01CB\\u01F2\\u1F88-\\u1F8F\\u1F98-\\u1F9F\\u1FA8-\\u1FAF\\u1FBC\\u1FCC\\u1FFC]",description:"[\\u01C5\\u01C8\\u01CB\\u01F2\\u1F88-\\u1F8F\\u1F98-\\u1F9F\\u1FA8-\\u1FAF\\u1FBC\\u1FCC\\u1FFC]"},rr=/^[A-Z\xC0-\xD6\xD8-\xDE\u0100\u0102\u0104\u0106\u0108\u010A\u010C\u010E\u0110\u0112\u0114\u0116\u0118\u011A\u011C\u011E\u0120\u0122\u0124\u0126\u0128\u012A\u012C\u012E\u0130\u0132\u0134\u0136\u0139\u013B\u013D\u013F\u0141\u0143\u0145\u0147\u014A\u014C\u014E\u0150\u0152\u0154\u0156\u0158\u015A\u015C\u015E\u0160\u0162\u0164\u0166\u0168\u016A\u016C\u016E\u0170\u0172\u0174\u0176\u0178-\u0179\u017B\u017D\u0181-\u0182\u0184\u0186-\u0187\u0189-\u018B\u018E-\u0191\u0193-\u0194\u0196-\u0198\u019C-\u019D\u019F-\u01A0\u01A2\u01A4\u01A6-\u01A7\u01A9\u01AC\u01AE-\u01AF\u01B1-\u01B3\u01B5\u01B7-\u01B8\u01BC\u01C4\u01C7\u01CA\u01CD\u01CF\u01D1\u01D3\u01D5\u01D7\u01D9\u01DB\u01DE\u01E0\u01E2\u01E4\u01E6\u01E8\u01EA\u01EC\u01EE\u01F1\u01F4\u01F6-\u01F8\u01FA\u01FC\u01FE\u0200\u0202\u0204\u0206\u0208\u020A\u020C\u020E\u0210\u0212\u0214\u0216\u0218\u021A\u021C\u021E\u0220\u0222\u0224\u0226\u0228\u022A\u022C\u022E\u0230\u0232\u023A-\u023B\u023D-\u023E\u0241\u0243-\u0246\u0248\u024A\u024C\u024E\u0370\u0372\u0376\u037F\u0386\u0388-\u038A\u038C\u038E-\u038F\u0391-\u03A1\u03A3-\u03AB\u03CF\u03D2-\u03D4\u03D8\u03DA\u03DC\u03DE\u03E0\u03E2\u03E4\u03E6\u03E8\u03EA\u03EC\u03EE\u03F4\u03F7\u03F9-\u03FA\u03FD-\u042F\u0460\u0462\u0464\u0466\u0468\u046A\u046C\u046E\u0470\u0472\u0474\u0476\u0478\u047A\u047C\u047E\u0480\u048A\u048C\u048E\u0490\u0492\u0494\u0496\u0498\u049A\u049C\u049E\u04A0\u04A2\u04A4\u04A6\u04A8\u04AA\u04AC\u04AE\u04B0\u04B2\u04B4\u04B6\u04B8\u04BA\u04BC\u04BE\u04C0-\u04C1\u04C3\u04C5\u04C7\u04C9\u04CB\u04CD\u04D0\u04D2\u04D4\u04D6\u04D8\u04DA\u04DC\u04DE\u04E0\u04E2\u04E4\u04E6\u04E8\u04EA\u04EC\u04EE\u04F0\u04F2\u04F4\u04F6\u04F8\u04FA\u04FC\u04FE\u0500\u0502\u0504\u0506\u0508\u050A\u050C\u050E\u0510\u0512\u0514\u0516\u0518\u051A\u051C\u051E\u0520\u0522\u0524\u0526\u0528\u052A\u052C\u052E\u0531-\u0556\u10A0-\u10C5\u10C7\u10CD\u13A0-\u13F5\u1E00\u1E02\u1E04\u1E06\u1E08\u1E0A\u1E0C\u1E0E\u1E10\u1E12\u1E14\u1E16\u1E18\u1E1A\u1E1C\u1E1E\u1E20\u1E22\u1E24\u1E26\u1E28\u1E2A\u1E2C\u1E2E\u1E30\u1E32\u1E34\u1E36\u1E38\u1E3A\u1E3C\u1E3E\u1E40\u1E42\u1E44\u1E46\u1E48\u1E4A\u1E4C\u1E4E\u1E50\u1E52\u1E54\u1E56\u1E58\u1E5A\u1E5C\u1E5E\u1E60\u1E62\u1E64\u1E66\u1E68\u1E6A\u1E6C\u1E6E\u1E70\u1E72\u1E74\u1E76\u1E78\u1E7A\u1E7C\u1E7E\u1E80\u1E82\u1E84\u1E86\u1E88\u1E8A\u1E8C\u1E8E\u1E90\u1E92\u1E94\u1E9E\u1EA0\u1EA2\u1EA4\u1EA6\u1EA8\u1EAA\u1EAC\u1EAE\u1EB0\u1EB2\u1EB4\u1EB6\u1EB8\u1EBA\u1EBC\u1EBE\u1EC0\u1EC2\u1EC4\u1EC6\u1EC8\u1ECA\u1ECC\u1ECE\u1ED0\u1ED2\u1ED4\u1ED6\u1ED8\u1EDA\u1EDC\u1EDE\u1EE0\u1EE2\u1EE4\u1EE6\u1EE8\u1EEA\u1EEC\u1EEE\u1EF0\u1EF2\u1EF4\u1EF6\u1EF8\u1EFA\u1EFC\u1EFE\u1F08-\u1F0F\u1F18-\u1F1D\u1F28-\u1F2F\u1F38-\u1F3F\u1F48-\u1F4D\u1F59\u1F5B\u1F5D\u1F5F\u1F68-\u1F6F\u1FB8-\u1FBB\u1FC8-\u1FCB\u1FD8-\u1FDB\u1FE8-\u1FEC\u1FF8-\u1FFB\u2102\u2107\u210B-\u210D\u2110-\u2112\u2115\u2119-\u211D\u2124\u2126\u2128\u212A-\u212D\u2130-\u2133\u213E-\u213F\u2145\u2183\u2C00-\u2C2E\u2C60\u2C62-\u2C64\u2C67\u2C69\u2C6B\u2C6D-\u2C70\u2C72\u2C75\u2C7E-\u2C80\u2C82\u2C84\u2C86\u2C88\u2C8A\u2C8C\u2C8E\u2C90\u2C92\u2C94\u2C96\u2C98\u2C9A\u2C9C\u2C9E\u2CA0\u2CA2\u2CA4\u2CA6\u2CA8\u2CAA\u2CAC\u2CAE\u2CB0\u2CB2\u2CB4\u2CB6\u2CB8\u2CBA\u2CBC\u2CBE\u2CC0\u2CC2\u2CC4\u2CC6\u2CC8\u2CCA\u2CCC\u2CCE\u2CD0\u2CD2\u2CD4\u2CD6\u2CD8\u2CDA\u2CDC\u2CDE\u2CE0\u2CE2\u2CEB\u2CED\u2CF2\uA640\uA642\uA644\uA646\uA648\uA64A\uA64C\uA64E\uA650\uA652\uA654\uA656\uA658\uA65A\uA65C\uA65E\uA660\uA662\uA664\uA666\uA668\uA66A\uA66C\uA680\uA682\uA684\uA686\uA688\uA68A\uA68C\uA68E\uA690\uA692\uA694\uA696\uA698\uA69A\uA722\uA724\uA726\uA728\uA72A\uA72C\uA72E\uA732\uA734\uA736\uA738\uA73A\uA73C\uA73E\uA740\uA742\uA744\uA746\uA748\uA74A\uA74C\uA74E\uA750\uA752\uA754\uA756\uA758\uA75A\uA75C\uA75E\uA760\uA762\uA764\uA766\uA768\uA76A\uA76C\uA76E\uA779\uA77B\uA77D-\uA77E\uA780\uA782\uA784\uA786\uA78B\uA78D\uA790\uA792\uA796\uA798\uA79A\uA79C\uA79E\uA7A0\uA7A2\uA7A4\uA7A6\uA7A8\uA7AA-\uA7AD\uA7B0-\uA7B4\uA7B6\uFF21-\uFF3A]/,nr={
type:"class",value:"[\\u0041-\\u005A\\u00C0-\\u00D6\\u00D8-\\u00DE\\u0100\\u0102\\u0104\\u0106\\u0108\\u010A\\u010C\\u010E\\u0110\\u0112\\u0114\\u0116\\u0118\\u011A\\u011C\\u011E\\u0120\\u0122\\u0124\\u0126\\u0128\\u012A\\u012C\\u012E\\u0130\\u0132\\u0134\\u0136\\u0139\\u013B\\u013D\\u013F\\u0141\\u0143\\u0145\\u0147\\u014A\\u014C\\u014E\\u0150\\u0152\\u0154\\u0156\\u0158\\u015A\\u015C\\u015E\\u0160\\u0162\\u0164\\u0166\\u0168\\u016A\\u016C\\u016E\\u0170\\u0172\\u0174\\u0176\\u0178-\\u0179\\u017B\\u017D\\u0181-\\u0182\\u0184\\u0186-\\u0187\\u0189-\\u018B\\u018E-\\u0191\\u0193-\\u0194\\u0196-\\u0198\\u019C-\\u019D\\u019F-\\u01A0\\u01A2\\u01A4\\u01A6-\\u01A7\\u01A9\\u01AC\\u01AE-\\u01AF\\u01B1-\\u01B3\\u01B5\\u01B7-\\u01B8\\u01BC\\u01C4\\u01C7\\u01CA\\u01CD\\u01CF\\u01D1\\u01D3\\u01D5\\u01D7\\u01D9\\u01DB\\u01DE\\u01E0\\u01E2\\u01E4\\u01E6\\u01E8\\u01EA\\u01EC\\u01EE\\u01F1\\u01F4\\u01F6-\\u01F8\\u01FA\\u01FC\\u01FE\\u0200\\u0202\\u0204\\u0206\\u0208\\u020A\\u020C\\u020E\\u0210\\u0212\\u0214\\u0216\\u0218\\u021A\\u021C\\u021E\\u0220\\u0222\\u0224\\u0226\\u0228\\u022A\\u022C\\u022E\\u0230\\u0232\\u023A-\\u023B\\u023D-\\u023E\\u0241\\u0243-\\u0246\\u0248\\u024A\\u024C\\u024E\\u0370\\u0372\\u0376\\u037F\\u0386\\u0388-\\u038A\\u038C\\u038E-\\u038F\\u0391-\\u03A1\\u03A3-\\u03AB\\u03CF\\u03D2-\\u03D4\\u03D8\\u03DA\\u03DC\\u03DE\\u03E0\\u03E2\\u03E4\\u03E6\\u03E8\\u03EA\\u03EC\\u03EE\\u03F4\\u03F7\\u03F9-\\u03FA\\u03FD-\\u042F\\u0460\\u0462\\u0464\\u0466\\u0468\\u046A\\u046C\\u046E\\u0470\\u0472\\u0474\\u0476\\u0478\\u047A\\u047C\\u047E\\u0480\\u048A\\u048C\\u048E\\u0490\\u0492\\u0494\\u0496\\u0498\\u049A\\u049C\\u049E\\u04A0\\u04A2\\u04A4\\u04A6\\u04A8\\u04AA\\u04AC\\u04AE\\u04B0\\u04B2\\u04B4\\u04B6\\u04B8\\u04BA\\u04BC\\u04BE\\u04C0-\\u04C1\\u04C3\\u04C5\\u04C7\\u04C9\\u04CB\\u04CD\\u04D0\\u04D2\\u04D4\\u04D6\\u04D8\\u04DA\\u04DC\\u04DE\\u04E0\\u04E2\\u04E4\\u04E6\\u04E8\\u04EA\\u04EC\\u04EE\\u04F0\\u04F2\\u04F4\\u04F6\\u04F8\\u04FA\\u04FC\\u04FE\\u0500\\u0502\\u0504\\u0506\\u0508\\u050A\\u050C\\u050E\\u0510\\u0512\\u0514\\u0516\\u0518\\u051A\\u051C\\u051E\\u0520\\u0522\\u0524\\u0526\\u0528\\u052A\\u052C\\u052E\\u0531-\\u0556\\u10A0-\\u10C5\\u10C7\\u10CD\\u13A0-\\u13F5\\u1E00\\u1E02\\u1E04\\u1E06\\u1E08\\u1E0A\\u1E0C\\u1E0E\\u1E10\\u1E12\\u1E14\\u1E16\\u1E18\\u1E1A\\u1E1C\\u1E1E\\u1E20\\u1E22\\u1E24\\u1E26\\u1E28\\u1E2A\\u1E2C\\u1E2E\\u1E30\\u1E32\\u1E34\\u1E36\\u1E38\\u1E3A\\u1E3C\\u1E3E\\u1E40\\u1E42\\u1E44\\u1E46\\u1E48\\u1E4A\\u1E4C\\u1E4E\\u1E50\\u1E52\\u1E54\\u1E56\\u1E58\\u1E5A\\u1E5C\\u1E5E\\u1E60\\u1E62\\u1E64\\u1E66\\u1E68\\u1E6A\\u1E6C\\u1E6E\\u1E70\\u1E72\\u1E74\\u1E76\\u1E78\\u1E7A\\u1E7C\\u1E7E\\u1E80\\u1E82\\u1E84\\u1E86\\u1E88\\u1E8A\\u1E8C\\u1E8E\\u1E90\\u1E92\\u1E94\\u1E9E\\u1EA0\\u1EA2\\u1EA4\\u1EA6\\u1EA8\\u1EAA\\u1EAC\\u1EAE\\u1EB0\\u1EB2\\u1EB4\\u1EB6\\u1EB8\\u1EBA\\u1EBC\\u1EBE\\u1EC0\\u1EC2\\u1EC4\\u1EC6\\u1EC8\\u1ECA\\u1ECC\\u1ECE\\u1ED0\\u1ED2\\u1ED4\\u1ED6\\u1ED8\\u1EDA\\u1EDC\\u1EDE\\u1EE0\\u1EE2\\u1EE4\\u1EE6\\u1EE8\\u1EEA\\u1EEC\\u1EEE\\u1EF0\\u1EF2\\u1EF4\\u1EF6\\u1EF8\\u1EFA\\u1EFC\\u1EFE\\u1F08-\\u1F0F\\u1F18-\\u1F1D\\u1F28-\\u1F2F\\u1F38-\\u1F3F\\u1F48-\\u1F4D\\u1F59\\u1F5B\\u1F5D\\u1F5F\\u1F68-\\u1F6F\\u1FB8-\\u1FBB\\u1FC8-\\u1FCB\\u1FD8-\\u1FDB\\u1FE8-\\u1FEC\\u1FF8-\\u1FFB\\u2102\\u2107\\u210B-\\u210D\\u2110-\\u2112\\u2115\\u2119-\\u211D\\u2124\\u2126\\u2128\\u212A-\\u212D\\u2130-\\u2133\\u213E-\\u213F\\u2145\\u2183\\u2C00-\\u2C2E\\u2C60\\u2C62-\\u2C64\\u2C67\\u2C69\\u2C6B\\u2C6D-\\u2C70\\u2C72\\u2C75\\u2C7E-\\u2C80\\u2C82\\u2C84\\u2C86\\u2C88\\u2C8A\\u2C8C\\u2C8E\\u2C90\\u2C92\\u2C94\\u2C96\\u2C98\\u2C9A\\u2C9C\\u2C9E\\u2CA0\\u2CA2\\u2CA4\\u2CA6\\u2CA8\\u2CAA\\u2CAC\\u2CAE\\u2CB0\\u2CB2\\u2CB4\\u2CB6\\u2CB8\\u2CBA\\u2CBC\\u2CBE\\u2CC0\\u2CC2\\u2CC4\\u2CC6\\u2CC8\\u2CCA\\u2CCC\\u2CCE\\u2CD0\\u2CD2\\u2CD4\\u2CD6\\u2CD8\\u2CDA\\u2CDC\\u2CDE\\u2CE0\\u2CE2\\u2CEB\\u2CED\\u2CF2\\uA640\\uA642\\uA644\\uA646\\uA648\\uA64A\\uA64C\\uA64E\\uA650\\uA652\\uA654\\uA656\\uA658\\uA65A\\uA65C\\uA65E\\uA660\\uA662\\uA664\\uA666\\uA668\\uA66A\\uA66C\\uA680\\uA682\\uA684\\uA686\\uA688\\uA68A\\uA68C\\uA68E\\uA690\\uA692\\uA694\\uA696\\uA698\\uA69A\\uA722\\uA724\\uA726\\uA728\\uA72A\\uA72C\\uA72E\\uA732\\uA734\\uA736\\uA738\\uA73A\\uA73C\\uA73E\\uA740\\uA742\\uA744\\uA746\\uA748\\uA74A\\uA74C\\uA74E\\uA750\\uA752\\uA754\\uA756\\uA758\\uA75A\\uA75C\\uA75E\\uA760\\uA762\\uA764\\uA766\\uA768\\uA76A\\uA76C\\uA76E\\uA779\\uA77B\\uA77D-\\uA77E\\uA780\\uA782\\uA784\\uA786\\uA78B\\uA78D\\uA790\\uA792\\uA796\\uA798\\uA79A\\uA79C\\uA79E\\uA7A0\\uA7A2\\uA7A4\\uA7A6\\uA7A8\\uA7AA-\\uA7AD\\uA7B0-\\uA7B4\\uA7B6\\uFF21-\\uFF3A]",description:"[\\u0041-\\u005A\\u00C0-\\u00D6\\u00D8-\\u00DE\\u0100\\u0102\\u0104\\u0106\\u0108\\u010A\\u010C\\u010E\\u0110\\u0112\\u0114\\u0116\\u0118\\u011A\\u011C\\u011E\\u0120\\u0122\\u0124\\u0126\\u0128\\u012A\\u012C\\u012E\\u0130\\u0132\\u0134\\u0136\\u0139\\u013B\\u013D\\u013F\\u0141\\u0143\\u0145\\u0147\\u014A\\u014C\\u014E\\u0150\\u0152\\u0154\\u0156\\u0158\\u015A\\u015C\\u015E\\u0160\\u0162\\u0164\\u0166\\u0168\\u016A\\u016C\\u016E\\u0170\\u0172\\u0174\\u0176\\u0178-\\u0179\\u017B\\u017D\\u0181-\\u0182\\u0184\\u0186-\\u0187\\u0189-\\u018B\\u018E-\\u0191\\u0193-\\u0194\\u0196-\\u0198\\u019C-\\u019D\\u019F-\\u01A0\\u01A2\\u01A4\\u01A6-\\u01A7\\u01A9\\u01AC\\u01AE-\\u01AF\\u01B1-\\u01B3\\u01B5\\u01B7-\\u01B8\\u01BC\\u01C4\\u01C7\\u01CA\\u01CD\\u01CF\\u01D1\\u01D3\\u01D5\\u01D7\\u01D9\\u01DB\\u01DE\\u01E0\\u01E2\\u01E4\\u01E6\\u01E8\\u01EA\\u01EC\\u01EE\\u01F1\\u01F4\\u01F6-\\u01F8\\u01FA\\u01FC\\u01FE\\u0200\\u0202\\u0204\\u0206\\u0208\\u020A\\u020C\\u020E\\u0210\\u0212\\u0214\\u0216\\u0218\\u021A\\u021C\\u021E\\u0220\\u0222\\u0224\\u0226\\u0228\\u022A\\u022C\\u022E\\u0230\\u0232\\u023A-\\u023B\\u023D-\\u023E\\u0241\\u0243-\\u0246\\u0248\\u024A\\u024C\\u024E\\u0370\\u0372\\u0376\\u037F\\u0386\\u0388-\\u038A\\u038C\\u038E-\\u038F\\u0391-\\u03A1\\u03A3-\\u03AB\\u03CF\\u03D2-\\u03D4\\u03D8\\u03DA\\u03DC\\u03DE\\u03E0\\u03E2\\u03E4\\u03E6\\u03E8\\u03EA\\u03EC\\u03EE\\u03F4\\u03F7\\u03F9-\\u03FA\\u03FD-\\u042F\\u0460\\u0462\\u0464\\u0466\\u0468\\u046A\\u046C\\u046E\\u0470\\u0472\\u0474\\u0476\\u0478\\u047A\\u047C\\u047E\\u0480\\u048A\\u048C\\u048E\\u0490\\u0492\\u0494\\u0496\\u0498\\u049A\\u049C\\u049E\\u04A0\\u04A2\\u04A4\\u04A6\\u04A8\\u04AA\\u04AC\\u04AE\\u04B0\\u04B2\\u04B4\\u04B6\\u04B8\\u04BA\\u04BC\\u04BE\\u04C0-\\u04C1\\u04C3\\u04C5\\u04C7\\u04C9\\u04CB\\u04CD\\u04D0\\u04D2\\u04D4\\u04D6\\u04D8\\u04DA\\u04DC\\u04DE\\u04E0\\u04E2\\u04E4\\u04E6\\u04E8\\u04EA\\u04EC\\u04EE\\u04F0\\u04F2\\u04F4\\u04F6\\u04F8\\u04FA\\u04FC\\u04FE\\u0500\\u0502\\u0504\\u0506\\u0508\\u050A\\u050C\\u050E\\u0510\\u0512\\u0514\\u0516\\u0518\\u051A\\u051C\\u051E\\u0520\\u0522\\u0524\\u0526\\u0528\\u052A\\u052C\\u052E\\u0531-\\u0556\\u10A0-\\u10C5\\u10C7\\u10CD\\u13A0-\\u13F5\\u1E00\\u1E02\\u1E04\\u1E06\\u1E08\\u1E0A\\u1E0C\\u1E0E\\u1E10\\u1E12\\u1E14\\u1E16\\u1E18\\u1E1A\\u1E1C\\u1E1E\\u1E20\\u1E22\\u1E24\\u1E26\\u1E28\\u1E2A\\u1E2C\\u1E2E\\u1E30\\u1E32\\u1E34\\u1E36\\u1E38\\u1E3A\\u1E3C\\u1E3E\\u1E40\\u1E42\\u1E44\\u1E46\\u1E48\\u1E4A\\u1E4C\\u1E4E\\u1E50\\u1E52\\u1E54\\u1E56\\u1E58\\u1E5A\\u1E5C\\u1E5E\\u1E60\\u1E62\\u1E64\\u1E66\\u1E68\\u1E6A\\u1E6C\\u1E6E\\u1E70\\u1E72\\u1E74\\u1E76\\u1E78\\u1E7A\\u1E7C\\u1E7E\\u1E80\\u1E82\\u1E84\\u1E86\\u1E88\\u1E8A\\u1E8C\\u1E8E\\u1E90\\u1E92\\u1E94\\u1E9E\\u1EA0\\u1EA2\\u1EA4\\u1EA6\\u1EA8\\u1EAA\\u1EAC\\u1EAE\\u1EB0\\u1EB2\\u1EB4\\u1EB6\\u1EB8\\u1EBA\\u1EBC\\u1EBE\\u1EC0\\u1EC2\\u1EC4\\u1EC6\\u1EC8\\u1ECA\\u1ECC\\u1ECE\\u1ED0\\u1ED2\\u1ED4\\u1ED6\\u1ED8\\u1EDA\\u1EDC\\u1EDE\\u1EE0\\u1EE2\\u1EE4\\u1EE6\\u1EE8\\u1EEA\\u1EEC\\u1EEE\\u1EF0\\u1EF2\\u1EF4\\u1EF6\\u1EF8\\u1EFA\\u1EFC\\u1EFE\\u1F08-\\u1F0F\\u1F18-\\u1F1D\\u1F28-\\u1F2F\\u1F38-\\u1F3F\\u1F48-\\u1F4D\\u1F59\\u1F5B\\u1F5D\\u1F5F\\u1F68-\\u1F6F\\u1FB8-\\u1FBB\\u1FC8-\\u1FCB\\u1FD8-\\u1FDB\\u1FE8-\\u1FEC\\u1FF8-\\u1FFB\\u2102\\u2107\\u210B-\\u210D\\u2110-\\u2112\\u2115\\u2119-\\u211D\\u2124\\u2126\\u2128\\u212A-\\u212D\\u2130-\\u2133\\u213E-\\u213F\\u2145\\u2183\\u2C00-\\u2C2E\\u2C60\\u2C62-\\u2C64\\u2C67\\u2C69\\u2C6B\\u2C6D-\\u2C70\\u2C72\\u2C75\\u2C7E-\\u2C80\\u2C82\\u2C84\\u2C86\\u2C88\\u2C8A\\u2C8C\\u2C8E\\u2C90\\u2C92\\u2C94\\u2C96\\u2C98\\u2C9A\\u2C9C\\u2C9E\\u2CA0\\u2CA2\\u2CA4\\u2CA6\\u2CA8\\u2CAA\\u2CAC\\u2CAE\\u2CB0\\u2CB2\\u2CB4\\u2CB6\\u2CB8\\u2CBA\\u2CBC\\u2CBE\\u2CC0\\u2CC2\\u2CC4\\u2CC6\\u2CC8\\u2CCA\\u2CCC\\u2CCE\\u2CD0\\u2CD2\\u2CD4\\u2CD6\\u2CD8\\u2CDA\\u2CDC\\u2CDE\\u2CE0\\u2CE2\\u2CEB\\u2CED\\u2CF2\\uA640\\uA642\\uA644\\uA646\\uA648\\uA64A\\uA64C\\uA64E\\uA650\\uA652\\uA654\\uA656\\uA658\\uA65A\\uA65C\\uA65E\\uA660\\uA662\\uA664\\uA666\\uA668\\uA66A\\uA66C\\uA680\\uA682\\uA684\\uA686\\uA688\\uA68A\\uA68C\\uA68E\\uA690\\uA692\\uA694\\uA696\\uA698\\uA69A\\uA722\\uA724\\uA726\\uA728\\uA72A\\uA72C\\uA72E\\uA732\\uA734\\uA736\\uA738\\uA73A\\uA73C\\uA73E\\uA740\\uA742\\uA744\\uA746\\uA748\\uA74A\\uA74C\\uA74E\\uA750\\uA752\\uA754\\uA756\\uA758\\uA75A\\uA75C\\uA75E\\uA760\\uA762\\uA764\\uA766\\uA768\\uA76A\\uA76C\\uA76E\\uA779\\uA77B\\uA77D-\\uA77E\\uA780\\uA782\\uA784\\uA786\\uA78B\\uA78D\\uA790\\uA792\\uA796\\uA798\\uA79A\\uA79C\\uA79E\\uA7A0\\uA7A2\\uA7A4\\uA7A6\\uA7A8\\uA7AA-\\uA7AD\\uA7B0-\\uA7B4\\uA7B6\\uFF21-\\uFF3A]"},Er=/^[\u0903\u093B\u093E-\u0940\u0949-\u094C\u094E-\u094F\u0982-\u0983\u09BE-\u09C0\u09C7-\u09C8\u09CB-\u09CC\u09D7\u0A03\u0A3E-\u0A40\u0A83\u0ABE-\u0AC0\u0AC9\u0ACB-\u0ACC\u0B02-\u0B03\u0B3E\u0B40\u0B47-\u0B48\u0B4B-\u0B4C\u0B57\u0BBE-\u0BBF\u0BC1-\u0BC2\u0BC6-\u0BC8\u0BCA-\u0BCC\u0BD7\u0C01-\u0C03\u0C41-\u0C44\u0C82-\u0C83\u0CBE\u0CC0-\u0CC4\u0CC7-\u0CC8\u0CCA-\u0CCB\u0CD5-\u0CD6\u0D02-\u0D03\u0D3E-\u0D40\u0D46-\u0D48\u0D4A-\u0D4C\u0D57\u0D82-\u0D83\u0DCF-\u0DD1\u0DD8-\u0DDF\u0DF2-\u0DF3\u0F3E-\u0F3F\u0F7F\u102B-\u102C\u1031\u1038\u103B-\u103C\u1056-\u1057\u1062-\u1064\u1067-\u106D\u1083-\u1084\u1087-\u108C\u108F\u109A-\u109C\u17B6\u17BE-\u17C5\u17C7-\u17C8\u1923-\u1926\u1929-\u192B\u1930-\u1931\u1933-\u1938\u1A19-\u1A1A\u1A55\u1A57\u1A61\u1A63-\u1A64\u1A6D-\u1A72\u1B04\u1B35\u1B3B\u1B3D-\u1B41\u1B43-\u1B44\u1B82\u1BA1\u1BA6-\u1BA7\u1BAA\u1BE7\u1BEA-\u1BEC\u1BEE\u1BF2-\u1BF3\u1C24-\u1C2B\u1C34-\u1C35\u1CE1\u1CF2-\u1CF3\u302E-\u302F\uA823-\uA824\uA827\uA880-\uA881\uA8B4-\uA8C3\uA952-\uA953\uA983\uA9B4-\uA9B5\uA9BA-\uA9BB\uA9BD-\uA9C0\uAA2F-\uAA30\uAA33-\uAA34\uAA4D\uAA7B\uAA7D\uAAEB\uAAEE-\uAAEF\uAAF5\uABE3-\uABE4\uABE6-\uABE7\uABE9-\uABEA\uABEC]/,Cr={type:"class",value:"[\\u0903\\u093B\\u093E-\\u0940\\u0949-\\u094C\\u094E-\\u094F\\u0982-\\u0983\\u09BE-\\u09C0\\u09C7-\\u09C8\\u09CB-\\u09CC\\u09D7\\u0A03\\u0A3E-\\u0A40\\u0A83\\u0ABE-\\u0AC0\\u0AC9\\u0ACB-\\u0ACC\\u0B02-\\u0B03\\u0B3E\\u0B40\\u0B47-\\u0B48\\u0B4B-\\u0B4C\\u0B57\\u0BBE-\\u0BBF\\u0BC1-\\u0BC2\\u0BC6-\\u0BC8\\u0BCA-\\u0BCC\\u0BD7\\u0C01-\\u0C03\\u0C41-\\u0C44\\u0C82-\\u0C83\\u0CBE\\u0CC0-\\u0CC4\\u0CC7-\\u0CC8\\u0CCA-\\u0CCB\\u0CD5-\\u0CD6\\u0D02-\\u0D03\\u0D3E-\\u0D40\\u0D46-\\u0D48\\u0D4A-\\u0D4C\\u0D57\\u0D82-\\u0D83\\u0DCF-\\u0DD1\\u0DD8-\\u0DDF\\u0DF2-\\u0DF3\\u0F3E-\\u0F3F\\u0F7F\\u102B-\\u102C\\u1031\\u1038\\u103B-\\u103C\\u1056-\\u1057\\u1062-\\u1064\\u1067-\\u106D\\u1083-\\u1084\\u1087-\\u108C\\u108F\\u109A-\\u109C\\u17B6\\u17BE-\\u17C5\\u17C7-\\u17C8\\u1923-\\u1926\\u1929-\\u192B\\u1930-\\u1931\\u1933-\\u1938\\u1A19-\\u1A1A\\u1A55\\u1A57\\u1A61\\u1A63-\\u1A64\\u1A6D-\\u1A72\\u1B04\\u1B35\\u1B3B\\u1B3D-\\u1B41\\u1B43-\\u1B44\\u1B82\\u1BA1\\u1BA6-\\u1BA7\\u1BAA\\u1BE7\\u1BEA-\\u1BEC\\u1BEE\\u1BF2-\\u1BF3\\u1C24-\\u1C2B\\u1C34-\\u1C35\\u1CE1\\u1CF2-\\u1CF3\\u302E-\\u302F\\uA823-\\uA824\\uA827\\uA880-\\uA881\\uA8B4-\\uA8C3\\uA952-\\uA953\\uA983\\uA9B4-\\uA9B5\\uA9BA-\\uA9BB\\uA9BD-\\uA9C0\\uAA2F-\\uAA30\\uAA33-\\uAA34\\uAA4D\\uAA7B\\uAA7D\\uAAEB\\uAAEE-\\uAAEF\\uAAF5\\uABE3-\\uABE4\\uABE6-\\uABE7\\uABE9-\\uABEA\\uABEC]",description:"[\\u0903\\u093B\\u093E-\\u0940\\u0949-\\u094C\\u094E-\\u094F\\u0982-\\u0983\\u09BE-\\u09C0\\u09C7-\\u09C8\\u09CB-\\u09CC\\u09D7\\u0A03\\u0A3E-\\u0A40\\u0A83\\u0ABE-\\u0AC0\\u0AC9\\u0ACB-\\u0ACC\\u0B02-\\u0B03\\u0B3E\\u0B40\\u0B47-\\u0B48\\u0B4B-\\u0B4C\\u0B57\\u0BBE-\\u0BBF\\u0BC1-\\u0BC2\\u0BC6-\\u0BC8\\u0BCA-\\u0BCC\\u0BD7\\u0C01-\\u0C03\\u0C41-\\u0C44\\u0C82-\\u0C83\\u0CBE\\u0CC0-\\u0CC4\\u0CC7-\\u0CC8\\u0CCA-\\u0CCB\\u0CD5-\\u0CD6\\u0D02-\\u0D03\\u0D3E-\\u0D40\\u0D46-\\u0D48\\u0D4A-\\u0D4C\\u0D57\\u0D82-\\u0D83\\u0DCF-\\u0DD1\\u0DD8-\\u0DDF\\u0DF2-\\u0DF3\\u0F3E-\\u0F3F\\u0F7F\\u102B-\\u102C\\u1031\\u1038\\u103B-\\u103C\\u1056-\\u1057\\u1062-\\u1064\\u1067-\\u106D\\u1083-\\u1084\\u1087-\\u108C\\u108F\\u109A-\\u109C\\u17B6\\u17BE-\\u17C5\\u17C7-\\u17C8\\u1923-\\u1926\\u1929-\\u192B\\u1930-\\u1931\\u1933-\\u1938\\u1A19-\\u1A1A\\u1A55\\u1A57\\u1A61\\u1A63-\\u1A64\\u1A6D-\\u1A72\\u1B04\\u1B35\\u1B3B\\u1B3D-\\u1B41\\u1B43-\\u1B44\\u1B82\\u1BA1\\u1BA6-\\u1BA7\\u1BAA\\u1BE7\\u1BEA-\\u1BEC\\u1BEE\\u1BF2-\\u1BF3\\u1C24-\\u1C2B\\u1C34-\\u1C35\\u1CE1\\u1CF2-\\u1CF3\\u302E-\\u302F\\uA823-\\uA824\\uA827\\uA880-\\uA881\\uA8B4-\\uA8C3\\uA952-\\uA953\\uA983\\uA9B4-\\uA9B5\\uA9BA-\\uA9BB\\uA9BD-\\uA9C0\\uAA2F-\\uAA30\\uAA33-\\uAA34\\uAA4D\\uAA7B\\uAA7D\\uAAEB\\uAAEE-\\uAAEF\\uAAF5\\uABE3-\\uABE4\\uABE6-\\uABE7\\uABE9-\\uABEA\\uABEC]"},sr=/^[\u0300-\u036F\u0483-\u0487\u0591-\u05BD\u05BF\u05C1-\u05C2\u05C4-\u05C5\u05C7\u0610-\u061A\u064B-\u065F\u0670\u06D6-\u06DC\u06DF-\u06E4\u06E7-\u06E8\u06EA-\u06ED\u0711\u0730-\u074A\u07A6-\u07B0\u07EB-\u07F3\u0816-\u0819\u081B-\u0823\u0825-\u0827\u0829-\u082D\u0859-\u085B\u08E3-\u0902\u093A\u093C\u0941-\u0948\u094D\u0951-\u0957\u0962-\u0963\u0981\u09BC\u09C1-\u09C4\u09CD\u09E2-\u09E3\u0A01-\u0A02\u0A3C\u0A41-\u0A42\u0A47-\u0A48\u0A4B-\u0A4D\u0A51\u0A70-\u0A71\u0A75\u0A81-\u0A82\u0ABC\u0AC1-\u0AC5\u0AC7-\u0AC8\u0ACD\u0AE2-\u0AE3\u0B01\u0B3C\u0B3F\u0B41-\u0B44\u0B4D\u0B56\u0B62-\u0B63\u0B82\u0BC0\u0BCD\u0C00\u0C3E-\u0C40\u0C46-\u0C48\u0C4A-\u0C4D\u0C55-\u0C56\u0C62-\u0C63\u0C81\u0CBC\u0CBF\u0CC6\u0CCC-\u0CCD\u0CE2-\u0CE3\u0D01\u0D41-\u0D44\u0D4D\u0D62-\u0D63\u0DCA\u0DD2-\u0DD4\u0DD6\u0E31\u0E34-\u0E3A\u0E47-\u0E4E\u0EB1\u0EB4-\u0EB9\u0EBB-\u0EBC\u0EC8-\u0ECD\u0F18-\u0F19\u0F35\u0F37\u0F39\u0F71-\u0F7E\u0F80-\u0F84\u0F86-\u0F87\u0F8D-\u0F97\u0F99-\u0FBC\u0FC6\u102D-\u1030\u1032-\u1037\u1039-\u103A\u103D-\u103E\u1058-\u1059\u105E-\u1060\u1071-\u1074\u1082\u1085-\u1086\u108D\u109D\u135D-\u135F\u1712-\u1714\u1732-\u1734\u1752-\u1753\u1772-\u1773\u17B4-\u17B5\u17B7-\u17BD\u17C6\u17C9-\u17D3\u17DD\u180B-\u180D\u18A9\u1920-\u1922\u1927-\u1928\u1932\u1939-\u193B\u1A17-\u1A18\u1A1B\u1A56\u1A58-\u1A5E\u1A60\u1A62\u1A65-\u1A6C\u1A73-\u1A7C\u1A7F\u1AB0-\u1ABD\u1B00-\u1B03\u1B34\u1B36-\u1B3A\u1B3C\u1B42\u1B6B-\u1B73\u1B80-\u1B81\u1BA2-\u1BA5\u1BA8-\u1BA9\u1BAB-\u1BAD\u1BE6\u1BE8-\u1BE9\u1BED\u1BEF-\u1BF1\u1C2C-\u1C33\u1C36-\u1C37\u1CD0-\u1CD2\u1CD4-\u1CE0\u1CE2-\u1CE8\u1CED\u1CF4\u1CF8-\u1CF9\u1DC0-\u1DF5\u1DFC-\u1DFF\u20D0-\u20DC\u20E1\u20E5-\u20F0\u2CEF-\u2CF1\u2D7F\u2DE0-\u2DFF\u302A-\u302D\u3099-\u309A\uA66F\uA674-\uA67D\uA69E-\uA69F\uA6F0-\uA6F1\uA802\uA806\uA80B\uA825-\uA826\uA8C4\uA8E0-\uA8F1\uA926-\uA92D\uA947-\uA951\uA980-\uA982\uA9B3\uA9B6-\uA9B9\uA9BC\uA9E5\uAA29-\uAA2E\uAA31-\uAA32\uAA35-\uAA36\uAA43\uAA4C\uAA7C\uAAB0\uAAB2-\uAAB4\uAAB7-\uAAB8\uAABE-\uAABF\uAAC1\uAAEC-\uAAED\uAAF6\uABE5\uABE8\uABED\uFB1E\uFE00-\uFE0F\uFE20-\uFE2F]/,ir={type:"class",value:"[\\u0300-\\u036F\\u0483-\\u0487\\u0591-\\u05BD\\u05BF\\u05C1-\\u05C2\\u05C4-\\u05C5\\u05C7\\u0610-\\u061A\\u064B-\\u065F\\u0670\\u06D6-\\u06DC\\u06DF-\\u06E4\\u06E7-\\u06E8\\u06EA-\\u06ED\\u0711\\u0730-\\u074A\\u07A6-\\u07B0\\u07EB-\\u07F3\\u0816-\\u0819\\u081B-\\u0823\\u0825-\\u0827\\u0829-\\u082D\\u0859-\\u085B\\u08E3-\\u0902\\u093A\\u093C\\u0941-\\u0948\\u094D\\u0951-\\u0957\\u0962-\\u0963\\u0981\\u09BC\\u09C1-\\u09C4\\u09CD\\u09E2-\\u09E3\\u0A01-\\u0A02\\u0A3C\\u0A41-\\u0A42\\u0A47-\\u0A48\\u0A4B-\\u0A4D\\u0A51\\u0A70-\\u0A71\\u0A75\\u0A81-\\u0A82\\u0ABC\\u0AC1-\\u0AC5\\u0AC7-\\u0AC8\\u0ACD\\u0AE2-\\u0AE3\\u0B01\\u0B3C\\u0B3F\\u0B41-\\u0B44\\u0B4D\\u0B56\\u0B62-\\u0B63\\u0B82\\u0BC0\\u0BCD\\u0C00\\u0C3E-\\u0C40\\u0C46-\\u0C48\\u0C4A-\\u0C4D\\u0C55-\\u0C56\\u0C62-\\u0C63\\u0C81\\u0CBC\\u0CBF\\u0CC6\\u0CCC-\\u0CCD\\u0CE2-\\u0CE3\\u0D01\\u0D41-\\u0D44\\u0D4D\\u0D62-\\u0D63\\u0DCA\\u0DD2-\\u0DD4\\u0DD6\\u0E31\\u0E34-\\u0E3A\\u0E47-\\u0E4E\\u0EB1\\u0EB4-\\u0EB9\\u0EBB-\\u0EBC\\u0EC8-\\u0ECD\\u0F18-\\u0F19\\u0F35\\u0F37\\u0F39\\u0F71-\\u0F7E\\u0F80-\\u0F84\\u0F86-\\u0F87\\u0F8D-\\u0F97\\u0F99-\\u0FBC\\u0FC6\\u102D-\\u1030\\u1032-\\u1037\\u1039-\\u103A\\u103D-\\u103E\\u1058-\\u1059\\u105E-\\u1060\\u1071-\\u1074\\u1082\\u1085-\\u1086\\u108D\\u109D\\u135D-\\u135F\\u1712-\\u1714\\u1732-\\u1734\\u1752-\\u1753\\u1772-\\u1773\\u17B4-\\u17B5\\u17B7-\\u17BD\\u17C6\\u17C9-\\u17D3\\u17DD\\u180B-\\u180D\\u18A9\\u1920-\\u1922\\u1927-\\u1928\\u1932\\u1939-\\u193B\\u1A17-\\u1A18\\u1A1B\\u1A56\\u1A58-\\u1A5E\\u1A60\\u1A62\\u1A65-\\u1A6C\\u1A73-\\u1A7C\\u1A7F\\u1AB0-\\u1ABD\\u1B00-\\u1B03\\u1B34\\u1B36-\\u1B3A\\u1B3C\\u1B42\\u1B6B-\\u1B73\\u1B80-\\u1B81\\u1BA2-\\u1BA5\\u1BA8-\\u1BA9\\u1BAB-\\u1BAD\\u1BE6\\u1BE8-\\u1BE9\\u1BED\\u1BEF-\\u1BF1\\u1C2C-\\u1C33\\u1C36-\\u1C37\\u1CD0-\\u1CD2\\u1CD4-\\u1CE0\\u1CE2-\\u1CE8\\u1CED\\u1CF4\\u1CF8-\\u1CF9\\u1DC0-\\u1DF5\\u1DFC-\\u1DFF\\u20D0-\\u20DC\\u20E1\\u20E5-\\u20F0\\u2CEF-\\u2CF1\\u2D7F\\u2DE0-\\u2DFF\\u302A-\\u302D\\u3099-\\u309A\\uA66F\\uA674-\\uA67D\\uA69E-\\uA69F\\uA6F0-\\uA6F1\\uA802\\uA806\\uA80B\\uA825-\\uA826\\uA8C4\\uA8E0-\\uA8F1\\uA926-\\uA92D\\uA947-\\uA951\\uA980-\\uA982\\uA9B3\\uA9B6-\\uA9B9\\uA9BC\\uA9E5\\uAA29-\\uAA2E\\uAA31-\\uAA32\\uAA35-\\uAA36\\uAA43\\uAA4C\\uAA7C\\uAAB0\\uAAB2-\\uAAB4\\uAAB7-\\uAAB8\\uAABE-\\uAABF\\uAAC1\\uAAEC-\\uAAED\\uAAF6\\uABE5\\uABE8\\uABED\\uFB1E\\uFE00-\\uFE0F\\uFE20-\\uFE2F]",description:"[\\u0300-\\u036F\\u0483-\\u0487\\u0591-\\u05BD\\u05BF\\u05C1-\\u05C2\\u05C4-\\u05C5\\u05C7\\u0610-\\u061A\\u064B-\\u065F\\u0670\\u06D6-\\u06DC\\u06DF-\\u06E4\\u06E7-\\u06E8\\u06EA-\\u06ED\\u0711\\u0730-\\u074A\\u07A6-\\u07B0\\u07EB-\\u07F3\\u0816-\\u0819\\u081B-\\u0823\\u0825-\\u0827\\u0829-\\u082D\\u0859-\\u085B\\u08E3-\\u0902\\u093A\\u093C\\u0941-\\u0948\\u094D\\u0951-\\u0957\\u0962-\\u0963\\u0981\\u09BC\\u09C1-\\u09C4\\u09CD\\u09E2-\\u09E3\\u0A01-\\u0A02\\u0A3C\\u0A41-\\u0A42\\u0A47-\\u0A48\\u0A4B-\\u0A4D\\u0A51\\u0A70-\\u0A71\\u0A75\\u0A81-\\u0A82\\u0ABC\\u0AC1-\\u0AC5\\u0AC7-\\u0AC8\\u0ACD\\u0AE2-\\u0AE3\\u0B01\\u0B3C\\u0B3F\\u0B41-\\u0B44\\u0B4D\\u0B56\\u0B62-\\u0B63\\u0B82\\u0BC0\\u0BCD\\u0C00\\u0C3E-\\u0C40\\u0C46-\\u0C48\\u0C4A-\\u0C4D\\u0C55-\\u0C56\\u0C62-\\u0C63\\u0C81\\u0CBC\\u0CBF\\u0CC6\\u0CCC-\\u0CCD\\u0CE2-\\u0CE3\\u0D01\\u0D41-\\u0D44\\u0D4D\\u0D62-\\u0D63\\u0DCA\\u0DD2-\\u0DD4\\u0DD6\\u0E31\\u0E34-\\u0E3A\\u0E47-\\u0E4E\\u0EB1\\u0EB4-\\u0EB9\\u0EBB-\\u0EBC\\u0EC8-\\u0ECD\\u0F18-\\u0F19\\u0F35\\u0F37\\u0F39\\u0F71-\\u0F7E\\u0F80-\\u0F84\\u0F86-\\u0F87\\u0F8D-\\u0F97\\u0F99-\\u0FBC\\u0FC6\\u102D-\\u1030\\u1032-\\u1037\\u1039-\\u103A\\u103D-\\u103E\\u1058-\\u1059\\u105E-\\u1060\\u1071-\\u1074\\u1082\\u1085-\\u1086\\u108D\\u109D\\u135D-\\u135F\\u1712-\\u1714\\u1732-\\u1734\\u1752-\\u1753\\u1772-\\u1773\\u17B4-\\u17B5\\u17B7-\\u17BD\\u17C6\\u17C9-\\u17D3\\u17DD\\u180B-\\u180D\\u18A9\\u1920-\\u1922\\u1927-\\u1928\\u1932\\u1939-\\u193B\\u1A17-\\u1A18\\u1A1B\\u1A56\\u1A58-\\u1A5E\\u1A60\\u1A62\\u1A65-\\u1A6C\\u1A73-\\u1A7C\\u1A7F\\u1AB0-\\u1ABD\\u1B00-\\u1B03\\u1B34\\u1B36-\\u1B3A\\u1B3C\\u1B42\\u1B6B-\\u1B73\\u1B80-\\u1B81\\u1BA2-\\u1BA5\\u1BA8-\\u1BA9\\u1BAB-\\u1BAD\\u1BE6\\u1BE8-\\u1BE9\\u1BED\\u1BEF-\\u1BF1\\u1C2C-\\u1C33\\u1C36-\\u1C37\\u1CD0-\\u1CD2\\u1CD4-\\u1CE0\\u1CE2-\\u1CE8\\u1CED\\u1CF4\\u1CF8-\\u1CF9\\u1DC0-\\u1DF5\\u1DFC-\\u1DFF\\u20D0-\\u20DC\\u20E1\\u20E5-\\u20F0\\u2CEF-\\u2CF1\\u2D7F\\u2DE0-\\u2DFF\\u302A-\\u302D\\u3099-\\u309A\\uA66F\\uA674-\\uA67D\\uA69E-\\uA69F\\uA6F0-\\uA6F1\\uA802\\uA806\\uA80B\\uA825-\\uA826\\uA8C4\\uA8E0-\\uA8F1\\uA926-\\uA92D\\uA947-\\uA951\\uA980-\\uA982\\uA9B3\\uA9B6-\\uA9B9\\uA9BC\\uA9E5\\uAA29-\\uAA2E\\uAA31-\\uAA32\\uAA35-\\uAA36\\uAA43\\uAA4C\\uAA7C\\uAAB0\\uAAB2-\\uAAB4\\uAAB7-\\uAAB8\\uAABE-\\uAABF\\uAAC1\\uAAEC-\\uAAED\\uAAF6\\uABE5\\uABE8\\uABED\\uFB1E\\uFE00-\\uFE0F\\uFE20-\\uFE2F]"},ar=/^[0-9\u0660-\u0669\u06F0-\u06F9\u07C0-\u07C9\u0966-\u096F\u09E6-\u09EF\u0A66-\u0A6F\u0AE6-\u0AEF\u0B66-\u0B6F\u0BE6-\u0BEF\u0C66-\u0C6F\u0CE6-\u0CEF\u0D66-\u0D6F\u0DE6-\u0DEF\u0E50-\u0E59\u0ED0-\u0ED9\u0F20-\u0F29\u1040-\u1049\u1090-\u1099\u17E0-\u17E9\u1810-\u1819\u1946-\u194F\u19D0-\u19D9\u1A80-\u1A89\u1A90-\u1A99\u1B50-\u1B59\u1BB0-\u1BB9\u1C40-\u1C49\u1C50-\u1C59\uA620-\uA629\uA8D0-\uA8D9\uA900-\uA909\uA9D0-\uA9D9\uA9F0-\uA9F9\uAA50-\uAA59\uABF0-\uABF9\uFF10-\uFF19]/,Fr={type:"class",value:"[\\u0030-\\u0039\\u0660-\\u0669\\u06F0-\\u06F9\\u07C0-\\u07C9\\u0966-\\u096F\\u09E6-\\u09EF\\u0A66-\\u0A6F\\u0AE6-\\u0AEF\\u0B66-\\u0B6F\\u0BE6-\\u0BEF\\u0C66-\\u0C6F\\u0CE6-\\u0CEF\\u0D66-\\u0D6F\\u0DE6-\\u0DEF\\u0E50-\\u0E59\\u0ED0-\\u0ED9\\u0F20-\\u0F29\\u1040-\\u1049\\u1090-\\u1099\\u17E0-\\u17E9\\u1810-\\u1819\\u1946-\\u194F\\u19D0-\\u19D9\\u1A80-\\u1A89\\u1A90-\\u1A99\\u1B50-\\u1B59\\u1BB0-\\u1BB9\\u1C40-\\u1C49\\u1C50-\\u1C59\\uA620-\\uA629\\uA8D0-\\uA8D9\\uA900-\\uA909\\uA9D0-\\uA9D9\\uA9F0-\\uA9F9\\uAA50-\\uAA59\\uABF0-\\uABF9\\uFF10-\\uFF19]",description:"[\\u0030-\\u0039\\u0660-\\u0669\\u06F0-\\u06F9\\u07C0-\\u07C9\\u0966-\\u096F\\u09E6-\\u09EF\\u0A66-\\u0A6F\\u0AE6-\\u0AEF\\u0B66-\\u0B6F\\u0BE6-\\u0BEF\\u0C66-\\u0C6F\\u0CE6-\\u0CEF\\u0D66-\\u0D6F\\u0DE6-\\u0DEF\\u0E50-\\u0E59\\u0ED0-\\u0ED9\\u0F20-\\u0F29\\u1040-\\u1049\\u1090-\\u1099\\u17E0-\\u17E9\\u1810-\\u1819\\u1946-\\u194F\\u19D0-\\u19D9\\u1A80-\\u1A89\\u1A90-\\u1A99\\u1B50-\\u1B59\\u1BB0-\\u1BB9\\u1C40-\\u1C49\\u1C50-\\u1C59\\uA620-\\uA629\\uA8D0-\\uA8D9\\uA900-\\uA909\\uA9D0-\\uA9D9\\uA9F0-\\uA9F9\\uAA50-\\uAA59\\uABF0-\\uABF9\\uFF10-\\uFF19]"},or=/^[\u16EE-\u16F0\u2160-\u2182\u2185-\u2188\u3007\u3021-\u3029\u3038-\u303A\uA6E6-\uA6EF]/,cr={type:"class",value:"[\\u16EE-\\u16F0\\u2160-\\u2182\\u2185-\\u2188\\u3007\\u3021-\\u3029\\u3038-\\u303A\\uA6E6-\\uA6EF]",description:"[\\u16EE-\\u16F0\\u2160-\\u2182\\u2185-\\u2188\\u3007\\u3021-\\u3029\\u3038-\\u303A\\uA6E6-\\uA6EF]"},pr=/^[_\u203F-\u2040\u2054\uFE33-\uFE34\uFE4D-\uFE4F\uFF3F]/,Br={type:"class",value:"[\\u005F\\u203F-\\u2040\\u2054\\uFE33-\\uFE34\\uFE4D-\\uFE4F\\uFF3F]",description:"[\\u005F\\u203F-\\u2040\\u2054\\uFE33-\\uFE34\\uFE4D-\\uFE4F\\uFF3F]"},Dr=/^[ \xA0\u1680\u2000-\u200A\u202F\u205F\u3000]/,lr={type:"class",value:"[\\u0020\\u00A0\\u1680\\u2000-\\u200A\\u202F\\u205F\\u3000]",description:"[\\u0020\\u00A0\\u1680\\u2000-\\u200A\\u202F\\u205F\\u3000]"},dr="break",fr={type:"literal",value:"break",description:'"break"'},hr="case",vr={type:"literal",value:"case",description:'"case"'},gr="catch",mr={type:"literal",value:"catch",description:'"catch"'},yr="class",Pr={type:"literal",value:"class",description:'"class"'},br="const",xr={type:"literal",value:"const",description:'"const"'},_r="continue",$r={type:"literal",value:"continue",description:'"continue"'},Rr="debugger",kr={type:"literal",value:"debugger",description:'"debugger"'},Sr="default",Ir={type:"literal",value:"default",description:'"default"'},Or="delete",Lr={type:"literal",value:"delete",description:'"delete"'},Tr="do",wr={type:"literal",value:"do",description:'"do"'},Nr="else",jr={type:"literal",value:"else",description:'"else"'},Ur="enum",Hr={type:"literal",value:"enum",description:'"enum"'},zr="export",Mr={type:"literal",value:"export",description:'"export"'},Gr="extends",qr={type:"literal",value:"extends",description:'"extends"'},Yr="false",Vr={type:"literal",value:"false",description:'"false"'},Wr="finally",Xr={type:"literal",value:"finally",description:'"finally"'},Jr="for",Zr={type:"literal",value:"for",description:'"for"'},Kr="function",Qr={type:"literal",value:"function",description:'"function"'},un="if",en={type:"literal",value:"if",description:'"if"'},An="import",tn={type:"literal",value:"import",description:'"import"'},rn="instanceof",nn={type:"literal",value:"instanceof",description:'"instanceof"'},En="in",Cn={type:"literal",value:"in",description:'"in"'},sn="new",an={type:"literal",value:"new",description:'"new"'},Fn="null",on={type:"literal",value:"null",description:'"null"'},cn="return",pn={type:"literal",value:"return",description:'"return"'},Bn="super",Dn={type:"literal",value:"super",description:'"super"'},ln="switch",dn={type:"literal",value:"switch",description:'"switch"'},fn="this",hn={type:"literal",value:"this",description:'"this"'},vn="throw",gn={type:"literal",value:"throw",description:'"throw"'},mn="true",yn={type:"literal",value:"true",description:'"true"'},Pn="try",bn={type:"literal",value:"try",description:'"try"'},xn="typeof",_n={type:"literal",value:"typeof",description:'"typeof"'},$n="var",Rn={type:"literal",value:"var",description:'"var"'},kn="void",Sn={type:"literal",value:"void",description:'"void"'},In="while",On={type:"literal",value:"while",description:'"while"'},Ln="with",Tn={type:"literal",value:"with",description:'"with"'},wn=";",Nn={type:"literal",value:";",description:'";"'},jn=0,Un=0,Hn=[{line:1,column:1,seenCR:!1}],zn=0,Mn=[],Gn=0;if("startRule"in ae){if(!(ae.startRule in oe))throw new Error("Can't start parsing from rule \""+ae.startRule+'".');ce=oe[ae.startRule]}var qn={$:"text","&":"simple_and","!":"simple_not"},Yn={"?":"optional","*":"zero_or_more","+":"one_or_more"},Vn={"&":"semantic_and","!":"semantic_not"};if(ie=ce(),ie!==Fe&&jn===u.length)return ie;throw ie!==Fe&&jn<u.length&&C({type:"end",description:"end of input"}),s(null,Mn,zn<u.length?u.charAt(zn):null,zn<u.length?E(zn,zn+1):E(zn,zn))}return u(e,Error),{SyntaxError:e,parse:A}}()}),modules.define("compiler/visitor",function(u,e){var A=e("../utils/objects"),t=e("../utils/arrays"),r={build:function(u){function e(e){return u[e.type].apply(null,arguments)}function r(){}function n(u){var A=Array.prototype.slice.call(arguments,1);e.apply(null,[u.expression].concat(A))}function E(u){return function(A){var r=Array.prototype.slice.call(arguments,1);t.each(A[u],function(u){e.apply(null,[u].concat(r))})}}var C={grammar:function(u){var A=Array.prototype.slice.call(arguments,1);u.initializer&&e.apply(null,[u.initializer].concat(A)),t.each(u.rules,function(u){e.apply(null,[u].concat(A))})},initializer:r,rule:n,named:n,choice:E("alternatives"),action:n,sequence:E("elements"),labeled:n,text:n,simple_and:n,simple_not:n,optional:n,zero_or_more:n,one_or_more:n,semantic_and:r,semantic_not:r,rule_ref:r,literal:r,"class":r,any:r};return A.defaults(u,C),e}};u.exports=r}),modules.define("compiler/asts",function(u,e){var A=e("../utils/arrays"),t=e("./visitor"),r={findRule:function(u,e){return A.find(u.rules,function(u){return u.name===e})},indexOfRule:function(u,e){return A.indexOf(u.rules,function(u){return u.name===e})},alwaysAdvancesOnSuccess:function(u,e){function n(){return!0}function E(){return!1}function C(u){return s(u.expression)}var s=t.build({rule:C,named:C,choice:function(u){return A.every(u.alternatives,s)},action:C,sequence:function(u){return A.some(u.elements,s)},labeled:C,text:C,simple_and:E,simple_not:E,optional:E,zero_or_more:E,one_or_more:C,semantic_and:E,semantic_not:E,rule_ref:function(e){return s(r.findRule(u,e.name))},literal:function(u){return""!==u.value},"class":n,any:n});return s(e)}};u.exports=r}),modules.define("compiler/opcodes",function(u,e){var A={PUSH:0,PUSH_UNDEFINED:1,PUSH_NULL:2,PUSH_FAILED:3,PUSH_EMPTY_ARRAY:4,PUSH_CURR_POS:5,POP:6,POP_CURR_POS:7,POP_N:8,NIP:9,APPEND:10,WRAP:11,TEXT:12,IF:13,IF_ERROR:14,IF_NOT_ERROR:15,WHILE_NOT_ERROR:16,MATCH_ANY:17,MATCH_STRING:18,MATCH_STRING_IC:19,MATCH_REGEXP:20,ACCEPT_N:21,ACCEPT_STRING:22,FAIL:23,LOAD_SAVED_POS:24,UPDATE_SAVED_POS:25,CALL:26,RULE:27,SILENT_FAILS_ON:28,SILENT_FAILS_OFF:29};u.exports=A}),modules.define("compiler/javascript",function(u,e){function A(u){return u.charCodeAt(0).toString(16).toUpperCase()}var t={stringEscape:function(u){return u.replace(/\\/g,"\\\\").replace(/"/g,'\\"').replace(/\x08/g,"\\b").replace(/\t/g,"\\t").replace(/\n/g,"\\n").replace(/\f/g,"\\f").replace(/\r/g,"\\r").replace(/[\x00-\x07\x0B\x0E\x0F]/g,function(u){return"\\x0"+A(u)}).replace(/[\x10-\x1F\x80-\xFF]/g,function(u){return"\\x"+A(u)}).replace(/[\u0100-\u0FFF]/g,function(u){return"\\u0"+A(u)}).replace(/[\u1000-\uFFFF]/g,function(u){return"\\u"+A(u)})},regexpClassEscape:function(u){return u.replace(/\\/g,"\\\\").replace(/\//g,"\\/").replace(/\]/g,"\\]").replace(/\^/g,"\\^").replace(/-/g,"\\-").replace(/\0/g,"\\0").replace(/\t/g,"\\t").replace(/\n/g,"\\n").replace(/\v/g,"\\x0B").replace(/\f/g,"\\f").replace(/\r/g,"\\r").replace(/[\x00-\x08\x0E\x0F]/g,function(u){return"\\x0"+A(u)}).replace(/[\x10-\x1F\x80-\xFF]/g,function(u){return"\\x"+A(u)}).replace(/[\u0100-\u0FFF]/g,function(u){return"\\u0"+A(u)}).replace(/[\u1000-\uFFFF]/g,function(u){return"\\u"+A(u)})}};u.exports=t}),modules.define("compiler/passes/generate-bytecode",function(u,e){function A(u){function e(u){var e=t.indexOf(D,u);return-1===e?D.push(u)-1:e}function A(u,A){return e("function("+u.join(", ")+") {"+A+"}")}function i(){return Array.prototype.concat.apply([],arguments)}function a(u,e,A){return u.concat([e.length,A.length],e,A)}function F(u,e){return u.concat([e.length],e)}function o(u,e,A,n){var E=t.map(r.values(A),function(u){return n-u});return[C.CALL,u,e,E.length].concat(E)}function c(u,e,A){return i([C.PUSH_CURR_POS],[C.SILENT_FAILS_ON],l(u,{sp:A.sp+1,env:r.clone(A.env),action:null}),[C.SILENT_FAILS_OFF],a([e?C.IF_ERROR:C.IF_NOT_ERROR],i([C.POP],[e?C.POP:C.POP_CURR_POS],[C.PUSH_UNDEFINED]),i([C.POP],[e?C.POP_CURR_POS:C.POP],[C.PUSH_FAILED])))}function p(u,e,t){var n=A(r.keys(t.env),u);return i([C.UPDATE_SAVED_POS],o(n,0,t.env,t.sp),a([C.IF],i([C.POP],e?[C.PUSH_FAILED]:[C.PUSH_UNDEFINED]),i([C.POP],e?[C.PUSH_UNDEFINED]:[C.PUSH_FAILED])))}function B(u){return F([C.WHILE_NOT_ERROR],i([C.APPEND],u))}var D=[],l=E.build({grammar:function(u){t.each(u.rules,l),u.consts=D},rule:function(u){u.bytecode=l(u.expression,{sp:-1,env:{},action:null})},named:function(u,A){var t=e('{ type: "other", description: "'+s.stringEscape(u.name)+'" }');return i([C.SILENT_FAILS_ON],l(u.expression,A),[C.SILENT_FAILS_OFF],a([C.IF_ERROR],[C.FAIL,t],[]))},choice:function(u,e){function A(u,e){return i(l(u[0],{sp:e.sp,env:r.clone(e.env),action:null}),u.length>1?a([C.IF_ERROR],i([C.POP],A(u.slice(1),e)),[]):[])}return A(u.alternatives,e)},action:function(u,e){var t=r.clone(e.env),n="sequence"!==u.expression.type||0===u.expression.elements.length,E=l(u.expression,{sp:e.sp+(n?1:0),env:t,action:u}),s=A(r.keys(t),u.code);return n?i([C.PUSH_CURR_POS],E,a([C.IF_NOT_ERROR],i([C.LOAD_SAVED_POS,1],o(s,1,t,e.sp+2)),[]),[C.NIP]):E},sequence:function(u,e){function t(e,n){var E,s;return e.length>0?(E=u.elements.length-e.slice(1).length,i(l(e[0],{sp:n.sp,env:n.env,action:null}),a([C.IF_NOT_ERROR],t(e.slice(1),{sp:n.sp+1,env:n.env,action:n.action}),i(E>1?[C.POP_N,E]:[C.POP],[C.POP_CURR_POS],[C.PUSH_FAILED])))):n.action?(s=A(r.keys(n.env),n.action.code),i([C.LOAD_SAVED_POS,u.elements.length],o(s,u.elements.length,n.env,n.sp),[C.NIP])):i([C.WRAP,u.elements.length],[C.NIP])}return i([C.PUSH_CURR_POS],t(u.elements,{sp:e.sp+1,env:e.env,action:e.action}))},labeled:function(u,e){var A=r.clone(e.env);return e.env[u.label]=e.sp+1,l(u.expression,{sp:e.sp,env:A,action:null})},text:function(u,e){return i([C.PUSH_CURR_POS],l(u.expression,{sp:e.sp+1,env:r.clone(e.env),action:null}),a([C.IF_NOT_ERROR],i([C.POP],[C.TEXT]),[C.NIP]))},simple_and:function(u,e){return c(u.expression,!1,e)},simple_not:function(u,e){return c(u.expression,!0,e)},optional:function(u,e){return i(l(u.expression,{sp:e.sp,env:r.clone(e.env),action:null}),a([C.IF_ERROR],i([C.POP],[C.PUSH_NULL]),[]))},zero_or_more:function(u,e){var A=l(u.expression,{sp:e.sp+1,env:r.clone(e.env),action:null});return i([C.PUSH_EMPTY_ARRAY],A,B(A),[C.POP])},one_or_more:function(u,e){var A=l(u.expression,{sp:e.sp+1,env:r.clone(e.env),action:null});return i([C.PUSH_EMPTY_ARRAY],A,a([C.IF_NOT_ERROR],i(B(A),[C.POP]),i([C.POP],[C.POP],[C.PUSH_FAILED])))},semantic_and:function(u,e){return p(u.code,!1,e)},semantic_not:function(u,e){return p(u.code,!0,e)},rule_ref:function(e){return[C.RULE,n.indexOfRule(u,e.name)];
},literal:function(u){var A,t;return u.value.length>0?(A=e('"'+s.stringEscape(u.ignoreCase?u.value.toLowerCase():u.value)+'"'),t=e(["{",'type: "literal",','value: "'+s.stringEscape(u.value)+'",','description: "'+s.stringEscape('"'+s.stringEscape(u.value)+'"')+'"',"}"].join(" ")),a(u.ignoreCase?[C.MATCH_STRING_IC,A]:[C.MATCH_STRING,A],u.ignoreCase?[C.ACCEPT_N,u.value.length]:[C.ACCEPT_STRING,A],[C.FAIL,t])):(A=e('""'),[C.PUSH,A])},"class":function(u){var A,r,n;return A=u.parts.length>0?"/^["+(u.inverted?"^":"")+t.map(u.parts,function(u){return u instanceof Array?s.regexpClassEscape(u[0])+"-"+s.regexpClassEscape(u[1]):s.regexpClassEscape(u)}).join("")+"]/"+(u.ignoreCase?"i":""):u.inverted?"/^[\\S\\s]/":"/^(?!)/",r=e(A),n=e(["{",'type: "class",','value: "'+s.stringEscape(u.rawText)+'",','description: "'+s.stringEscape(u.rawText)+'"',"}"].join(" ")),a([C.MATCH_REGEXP,r],[C.ACCEPT_N,1],[C.FAIL,n])},any:function(){var u=e('{ type: "any", description: "any character" }');return a([C.MATCH_ANY],[C.ACCEPT_N,1],[C.FAIL,u])}});l(u)}var t=e("../../utils/arrays"),r=e("../../utils/objects"),n=e("../asts"),E=e("../visitor"),C=e("../opcodes"),s=e("../javascript");u.exports=A}),modules.define("compiler/passes/generate-javascript",function(module,require){function generateJavascript(ast,options){function indent2(u){return u.replace(/^(.+)$/gm,"  $1")}function indent4(u){return u.replace(/^(.+)$/gm,"    $1")}function indent8(u){return u.replace(/^(.+)$/gm,"        $1")}function indent10(u){return u.replace(/^(.+)$/gm,"          $1")}function generateTables(){return"size"===options.optimize?["peg$consts = [",indent2(ast.consts.join(",\n")),"],","","peg$bytecode = [",indent2(arrays.map(ast.rules,function(u){return'peg$decode("'+js.stringEscape(arrays.map(u.bytecode,function(u){return String.fromCharCode(u+32)}).join(""))+'")'}).join(",\n")),"],"].join("\n"):arrays.map(ast.consts,function(u,e){return"peg$c"+e+" = "+u+","}).join("\n")}function generateRuleHeader(u,e){var A=[];return A.push(""),options.trace&&A.push(["peg$tracer.trace({",'  type:     "rule.enter",',"  rule:     "+u+",","  location: peg$computeLocation(startPos, startPos)","});",""].join("\n")),options.cache&&(A.push(["var key    = peg$currPos * "+ast.rules.length+" + "+e+",","    cached = peg$resultsCache[key];","","if (cached) {","  peg$currPos = cached.nextPos;",""].join("\n")),options.trace&&A.push(["if (cached.result !== peg$FAILED) {","  peg$tracer.trace({",'    type:   "rule.match",',"    rule:   "+u+",","    result: cached.result,","    location: peg$computeLocation(startPos, peg$currPos)","  });","} else {","  peg$tracer.trace({",'    type: "rule.fail",',"    rule: "+u+",","    location: peg$computeLocation(startPos, startPos)","  });","}",""].join("\n")),A.push(["  return cached.result;","}",""].join("\n"))),A.join("\n")}function generateRuleFooter(u,e){var A=[];return options.cache&&A.push(["","peg$resultsCache[key] = { nextPos: peg$currPos, result: "+e+" };"].join("\n")),options.trace&&A.push(["","if ("+e+" !== peg$FAILED) {","  peg$tracer.trace({",'    type:   "rule.match",',"    rule:   "+u+",","    result: "+e+",","    location: peg$computeLocation(startPos, peg$currPos)","  });","} else {","  peg$tracer.trace({",'    type: "rule.fail",',"    rule: "+u+",","    location: peg$computeLocation(startPos, startPos)","  });","}"].join("\n")),A.push(["","return "+e+";"].join("\n")),A.join("\n")}function generateInterpreter(){function u(u,e){var A=e+3,t="bc[ip + "+(A-2)+"]",r="bc[ip + "+(A-1)+"]";return["ends.push(end);","ips.push(ip + "+A+" + "+t+" + "+r+");","","if ("+u+") {","  end = ip + "+A+" + "+t+";","  ip += "+A+";","} else {","  end = ip + "+A+" + "+t+" + "+r+";","  ip += "+A+" + "+t+";","}","","break;"].join("\n")}function e(u){var e=2,A="bc[ip + "+(e-1)+"]";return["if ("+u+") {","  ends.push(end);","  ips.push(ip);","","  end = ip + "+e+" + "+A+";","  ip += "+e+";","} else {","  ip += "+e+" + "+A+";","}","","break;"].join("\n")}function A(){var u=4,e="bc[ip + "+(u-1)+"]";return["params = bc.slice(ip + "+u+", ip + "+u+" + "+e+");","for (i = 0; i < "+e+"; i++) {","  params[i] = stack[stack.length - 1 - params[i]];","}","","stack.splice(","  stack.length - bc[ip + 2],","  bc[ip + 2],","  peg$consts[bc[ip + 1]].apply(null, params)",");","","ip += "+u+" + "+e+";","break;"].join("\n")}var t=[];return t.push(["function peg$decode(s) {","  var bc = new Array(s.length), i;","","  for (i = 0; i < s.length; i++) {","    bc[i] = s.charCodeAt(i) - 32;","  }","","  return bc;","}","","function peg$parseRule(index) {"].join("\n")),options.trace?t.push(["  var bc       = peg$bytecode[index],","      ip       = 0,","      ips      = [],","      end      = bc.length,","      ends     = [],","      stack    = [],","      startPos = peg$currPos,","      params, i;"].join("\n")):t.push(["  var bc    = peg$bytecode[index],","      ip    = 0,","      ips   = [],","      end   = bc.length,","      ends  = [],","      stack = [],","      params, i;"].join("\n")),t.push(indent2(generateRuleHeader("peg$ruleNames[index]","index"))),t.push(["  while (true) {","    while (ip < end) {","      switch (bc[ip]) {","        case "+op.PUSH+":","          stack.push(peg$consts[bc[ip + 1]]);","          ip += 2;","          break;","","        case "+op.PUSH_UNDEFINED+":","          stack.push(void 0);","          ip++;","          break;","","        case "+op.PUSH_NULL+":","          stack.push(null);","          ip++;","          break;","","        case "+op.PUSH_FAILED+":","          stack.push(peg$FAILED);","          ip++;","          break;","","        case "+op.PUSH_EMPTY_ARRAY+":","          stack.push([]);","          ip++;","          break;","","        case "+op.PUSH_CURR_POS+":","          stack.push(peg$currPos);","          ip++;","          break;","","        case "+op.POP+":","          stack.pop();","          ip++;","          break;","","        case "+op.POP_CURR_POS+":","          peg$currPos = stack.pop();","          ip++;","          break;","","        case "+op.POP_N+":","          stack.length -= bc[ip + 1];","          ip += 2;","          break;","","        case "+op.NIP+":","          stack.splice(-2, 1);","          ip++;","          break;","","        case "+op.APPEND+":","          stack[stack.length - 2].push(stack.pop());","          ip++;","          break;","","        case "+op.WRAP+":","          stack.push(stack.splice(stack.length - bc[ip + 1], bc[ip + 1]));","          ip += 2;","          break;","","        case "+op.TEXT+":","          stack.push(input.substring(stack.pop(), peg$currPos));","          ip++;","          break;","","        case "+op.IF+":",indent10(u("stack[stack.length - 1]",0)),"","        case "+op.IF_ERROR+":",indent10(u("stack[stack.length - 1] === peg$FAILED",0)),"","        case "+op.IF_NOT_ERROR+":",indent10(u("stack[stack.length - 1] !== peg$FAILED",0)),"","        case "+op.WHILE_NOT_ERROR+":",indent10(e("stack[stack.length - 1] !== peg$FAILED")),"","        case "+op.MATCH_ANY+":",indent10(u("input.length > peg$currPos",0)),"","        case "+op.MATCH_STRING+":",indent10(u("input.substr(peg$currPos, peg$consts[bc[ip + 1]].length) === peg$consts[bc[ip + 1]]",1)),"","        case "+op.MATCH_STRING_IC+":",indent10(u("input.substr(peg$currPos, peg$consts[bc[ip + 1]].length).toLowerCase() === peg$consts[bc[ip + 1]]",1)),"","        case "+op.MATCH_REGEXP+":",indent10(u("peg$consts[bc[ip + 1]].test(input.charAt(peg$currPos))",1)),"","        case "+op.ACCEPT_N+":","          stack.push(input.substr(peg$currPos, bc[ip + 1]));","          peg$currPos += bc[ip + 1];","          ip += 2;","          break;","","        case "+op.ACCEPT_STRING+":","          stack.push(peg$consts[bc[ip + 1]]);","          peg$currPos += peg$consts[bc[ip + 1]].length;","          ip += 2;","          break;","","        case "+op.FAIL+":","          stack.push(peg$FAILED);","          if (peg$silentFails === 0) {","            peg$fail(peg$consts[bc[ip + 1]]);","          }","          ip += 2;","          break;","","        case "+op.LOAD_SAVED_POS+":","          peg$savedPos = stack[stack.length - 1 - bc[ip + 1]];","          ip += 2;","          break;","","        case "+op.UPDATE_SAVED_POS+":","          peg$savedPos = peg$currPos;","          ip++;","          break;","","        case "+op.CALL+":",indent10(A()),"","        case "+op.RULE+":","          stack.push(peg$parseRule(bc[ip + 1]));","          ip += 2;","          break;","","        case "+op.SILENT_FAILS_ON+":","          peg$silentFails++;","          ip++;","          break;","","        case "+op.SILENT_FAILS_OFF+":","          peg$silentFails--;","          ip++;","          break;","","        default:",'          throw new Error("Invalid opcode: " + bc[ip] + ".");',"      }","    }","","    if (ends.length > 0) {","      end = ends.pop();","      ip = ips.pop();","    } else {","      break;","    }","  }"].join("\n")),t.push(indent2(generateRuleFooter("peg$ruleNames[index]","stack[0]"))),t.push("}"),t.join("\n")}function generateRuleFunction(rule){function c(u){return"peg$c"+u}function s(u){return"s"+u}function compile(bc){function compileCondition(u,e){var A,t,r,n,E=e+3,C=bc[ip+E-2],s=bc[ip+E-1],i=stack.sp;if(ip+=E,A=compile(bc.slice(ip,ip+C)),r=stack.sp,ip+=C,s>0&&(stack.sp=i,t=compile(bc.slice(ip,ip+s)),n=stack.sp,ip+=s,r!==n))throw new Error("Branches of a condition must move the stack pointer in the same way.");parts.push("if ("+u+") {"),parts.push(indent2(A)),s>0&&(parts.push("} else {"),parts.push(indent2(t))),parts.push("}")}function compileLoop(u){var e,A,t=2,r=bc[ip+t-1],n=stack.sp;if(ip+=t,e=compile(bc.slice(ip,ip+r)),A=stack.sp,ip+=r,A!==n)throw new Error("Body of a loop can't move the stack pointer.");parts.push("while ("+u+") {"),parts.push(indent2(e)),parts.push("}")}function compileCall(){var u=4,e=bc[ip+u-1],A=c(bc[ip+1])+"("+arrays.map(bc.slice(ip+u,ip+u+e),function(u){return stack.index(u)}).join(", ")+")";stack.pop(bc[ip+2]),parts.push(stack.push(A)),ip+=u+e}for(var ip=0,end=bc.length,parts=[],value;end>ip;)switch(bc[ip]){case op.PUSH:parts.push(stack.push(c(bc[ip+1]))),ip+=2;break;case op.PUSH_CURR_POS:parts.push(stack.push("peg$currPos")),ip++;break;case op.PUSH_UNDEFINED:parts.push(stack.push("void 0")),ip++;break;case op.PUSH_NULL:parts.push(stack.push("null")),ip++;break;case op.PUSH_FAILED:parts.push(stack.push("peg$FAILED")),ip++;break;case op.PUSH_EMPTY_ARRAY:parts.push(stack.push("[]")),ip++;break;case op.POP:stack.pop(),ip++;break;case op.POP_CURR_POS:parts.push("peg$currPos = "+stack.pop()+";"),ip++;break;case op.POP_N:stack.pop(bc[ip+1]),ip+=2;break;case op.NIP:value=stack.pop(),stack.pop(),parts.push(stack.push(value)),ip++;break;case op.APPEND:value=stack.pop(),parts.push(stack.top()+".push("+value+");"),ip++;break;case op.WRAP:parts.push(stack.push("["+stack.pop(bc[ip+1]).join(", ")+"]")),ip+=2;break;case op.TEXT:parts.push(stack.push("input.substring("+stack.pop()+", peg$currPos)")),ip++;break;case op.IF:compileCondition(stack.top(),0);break;case op.IF_ERROR:compileCondition(stack.top()+" === peg$FAILED",0);break;case op.IF_NOT_ERROR:compileCondition(stack.top()+" !== peg$FAILED",0);break;case op.WHILE_NOT_ERROR:compileLoop(stack.top()+" !== peg$FAILED",0);break;case op.MATCH_ANY:compileCondition("input.length > peg$currPos",0);break;case op.MATCH_STRING:compileCondition(eval(ast.consts[bc[ip+1]]).length>1?"input.substr(peg$currPos, "+eval(ast.consts[bc[ip+1]]).length+") === "+c(bc[ip+1]):"input.charCodeAt(peg$currPos) === "+eval(ast.consts[bc[ip+1]]).charCodeAt(0),1);break;case op.MATCH_STRING_IC:compileCondition("input.substr(peg$currPos, "+eval(ast.consts[bc[ip+1]]).length+").toLowerCase() === "+c(bc[ip+1]),1);break;case op.MATCH_REGEXP:compileCondition(c(bc[ip+1])+".test(input.charAt(peg$currPos))",1);break;case op.ACCEPT_N:parts.push(stack.push(bc[ip+1]>1?"input.substr(peg$currPos, "+bc[ip+1]+")":"input.charAt(peg$currPos)")),parts.push(bc[ip+1]>1?"peg$currPos += "+bc[ip+1]+";":"peg$currPos++;"),ip+=2;break;case op.ACCEPT_STRING:parts.push(stack.push(c(bc[ip+1]))),parts.push(eval(ast.consts[bc[ip+1]]).length>1?"peg$currPos += "+eval(ast.consts[bc[ip+1]]).length+";":"peg$currPos++;"),ip+=2;break;case op.FAIL:parts.push(stack.push("peg$FAILED")),parts.push("if (peg$silentFails === 0) { peg$fail("+c(bc[ip+1])+"); }"),ip+=2;break;case op.LOAD_SAVED_POS:parts.push("peg$savedPos = "+stack.index(bc[ip+1])+";"),ip+=2;break;case op.UPDATE_SAVED_POS:parts.push("peg$savedPos = peg$currPos;"),ip++;break;case op.CALL:compileCall();break;case op.RULE:parts.push(stack.push("peg$parse"+ast.rules[bc[ip+1]].name+"()")),ip+=2;break;case op.SILENT_FAILS_ON:parts.push("peg$silentFails++;"),ip++;break;case op.SILENT_FAILS_OFF:parts.push("peg$silentFails--;"),ip++;break;default:throw new Error("Invalid opcode: "+bc[ip]+".")}return parts.join("\n")}var parts=[],code,stack={sp:-1,maxSp:-1,push:function(u){var e=s(++this.sp)+" = "+u+";";return this.sp>this.maxSp&&(this.maxSp=this.sp),e},pop:function(){var u,e;return 0===arguments.length?s(this.sp--):(u=arguments[0],e=arrays.map(arrays.range(this.sp-u+1,this.sp+1),s),this.sp-=u,e)},top:function(){return s(this.sp)},index:function(u){return s(this.sp-u)}};return code=compile(rule.bytecode),parts.push("function peg$parse"+rule.name+"() {"),options.trace?parts.push(["  var "+arrays.map(arrays.range(0,stack.maxSp+1),s).join(", ")+",","      startPos = peg$currPos;"].join("\n")):parts.push("  var "+arrays.map(arrays.range(0,stack.maxSp+1),s).join(", ")+";"),parts.push(indent2(generateRuleHeader('"'+js.stringEscape(rule.name)+'"',asts.indexOfRule(ast,rule.name)))),parts.push(indent2(code)),parts.push(indent2(generateRuleFooter('"'+js.stringEscape(rule.name)+'"',s(0)))),parts.push("}"),parts.join("\n")}var parts=[],startRuleIndices,startRuleIndex,startRuleFunctions,startRuleFunction,ruleNames;parts.push(["(function() {",'  "use strict";',"","  /*","   * Generated by PEG.js 0.9.0.","   *","   * http://pegjs.org/","   */","","  function peg$subclass(child, parent) {","    function ctor() { this.constructor = child; }","    ctor.prototype = parent.prototype;","    child.prototype = new ctor();","  }","","  function peg$SyntaxError(message, expected, found, location) {","    this.message  = message;","    this.expected = expected;","    this.found    = found;","    this.location = location;",'    this.name     = "SyntaxError";',"",'    if (typeof Error.captureStackTrace === "function") {',"      Error.captureStackTrace(this, peg$SyntaxError);","    }","  }","","  peg$subclass(peg$SyntaxError, Error);",""].join("\n")),options.trace&&parts.push(["  function peg$DefaultTracer() {","    this.indentLevel = 0;","  }","","  peg$DefaultTracer.prototype.trace = function(event) {","    var that = this;","","    function log(event) {","      function repeat(string, n) {",'         var result = "", i;',"","         for (i = 0; i < n; i++) {","           result += string;","         }","","         return result;","      }","","      function pad(string, length) {",'        return string + repeat(" ", length - string.length);',"      }","",'      if (typeof console === "object") {',"        console.log(",'          event.location.start.line + ":" + event.location.start.column + "-"','            + event.location.end.line + ":" + event.location.end.column + " "','            + pad(event.type, 10) + " "','            + repeat("  ", that.indentLevel) + event.rule',"        );","      }","    }","","    switch (event.type) {",'      case "rule.enter":',"        log(event);","        this.indentLevel++;","        break;","",'      case "rule.match":',"        this.indentLevel--;","        log(event);","        break;","",'      case "rule.fail":',"        this.indentLevel--;","        log(event);","        break;","","      default:",'        throw new Error("Invalid event type: " + event.type + ".");',"    }","  };",""].join("\n")),parts.push(["  function peg$parse(input) {","    var options = arguments.length > 1 ? arguments[1] : {},","        parser  = this,","","        peg$FAILED = {},",""].join("\n")),"size"===options.optimize?(startRuleIndices="{ "+arrays.map(options.allowedStartRules,function(u){return u+": "+asts.indexOfRule(ast,u)}).join(", ")+" }",startRuleIndex=asts.indexOfRule(ast,options.allowedStartRules[0]),parts.push(["        peg$startRuleIndices = "+startRuleIndices+",","        peg$startRuleIndex   = "+startRuleIndex+","].join("\n"))):(startRuleFunctions="{ "+arrays.map(options.allowedStartRules,function(u){return u+": peg$parse"+u}).join(", ")+" }",startRuleFunction="peg$parse"+options.allowedStartRules[0],parts.push(["        peg$startRuleFunctions = "+startRuleFunctions+",","        peg$startRuleFunction  = "+startRuleFunction+","].join("\n"))),parts.push(""),parts.push(indent8(generateTables())),parts.push(["","        peg$currPos          = 0,","        peg$savedPos         = 0,","        peg$posDetailsCache  = [{ line: 1, column: 1, seenCR: false }],","        peg$maxFailPos       = 0,","        peg$maxFailExpected  = [],","        peg$silentFails      = 0,",""].join("\n")),options.cache&&parts.push(["        peg$resultsCache = {},",""].join("\n")),options.trace&&("size"===options.optimize&&(ruleNames="["+arrays.map(ast.rules,function(u){return'"'+js.stringEscape(u.name)+'"'}).join(", ")+"]",parts.push(["        peg$ruleNames = "+ruleNames+",",""].join("\n"))),parts.push(['        peg$tracer = "tracer" in options ? options.tracer : new peg$DefaultTracer(),',""].join("\n"))),parts.push(["        peg$result;",""].join("\n")),"size"===options.optimize?parts.push(['    if ("startRule" in options) {',"      if (!(options.startRule in peg$startRuleIndices)) {",'        throw new Error("Can\'t start parsing from rule \\"" + options.startRule + "\\".");',"      }","","      peg$startRuleIndex = peg$startRuleIndices[options.startRule];","    }"].join("\n")):parts.push(['    if ("startRule" in options) {',"      if (!(options.startRule in peg$startRuleFunctions)) {",'        throw new Error("Can\'t start parsing from rule \\"" + options.startRule + "\\".");',"      }","","      peg$startRuleFunction = peg$startRuleFunctions[options.startRule];","    }"].join("\n")),parts.push(["","    function text() {","      return input.substring(peg$savedPos, peg$currPos);","    }","","    function location() {","      return peg$computeLocation(peg$savedPos, peg$currPos);","    }","","    function expected(description) {","      throw peg$buildException(","        null,",'        [{ type: "other", description: description }],',"        input.substring(peg$savedPos, peg$currPos),","        peg$computeLocation(peg$savedPos, peg$currPos)","      );","    }","","    function error(message) {","      throw peg$buildException(","        message,","        null,","        input.substring(peg$savedPos, peg$currPos),","        peg$computeLocation(peg$savedPos, peg$currPos)","      );","    }","","    function peg$computePosDetails(pos) {","      var details = peg$posDetailsCache[pos],","          p, ch;","","      if (details) {","        return details;","      } else {","        p = pos - 1;","        while (!peg$posDetailsCache[p]) {","          p--;","        }","","        details = peg$posDetailsCache[p];","        details = {","          line:   details.line,","          column: details.column,","          seenCR: details.seenCR","        };","","        while (p < pos) {","          ch = input.charAt(p);",'          if (ch === "\\n") {',"            if (!details.seenCR) { details.line++; }","            details.column = 1;","            details.seenCR = false;",'          } else if (ch === "\\r" || ch === "\\u2028" || ch === "\\u2029") {',"            details.line++;","            details.column = 1;","            details.seenCR = true;","          } else {","            details.column++;","            details.seenCR = false;","          }","","          p++;","        }","","        peg$posDetailsCache[pos] = details;","        return details;","      }","    }","","    function peg$computeLocation(startPos, endPos) {","      var startPosDetails = peg$computePosDetails(startPos),","          endPosDetails   = peg$computePosDetails(endPos);","","      return {","        start: {","          offset: startPos,","          line:   startPosDetails.line,","          column: startPosDetails.column","        },","        end: {","          offset: endPos,","          line:   endPosDetails.line,","          column: endPosDetails.column","        }","      };","    }","","    function peg$fail(expected) {","      if (peg$currPos < peg$maxFailPos) { return; }","","      if (peg$currPos > peg$maxFailPos) {","        peg$maxFailPos = peg$currPos;","        peg$maxFailExpected = [];","      }","","      peg$maxFailExpected.push(expected);","    }","","    function peg$buildException(message, expected, found, location) {","      function cleanupExpected(expected) {","        var i = 1;","","        expected.sort(function(a, b) {","          if (a.description < b.description) {","            return -1;","          } else if (a.description > b.description) {","            return 1;","          } else {","            return 0;","          }","        });","","        while (i < expected.length) {","          if (expected[i - 1] === expected[i]) {","            expected.splice(i, 1);","          } else {","            i++;","          }","        }","      }","","      function buildMessage(expected, found) {","        function stringEscape(s) {","          function hex(ch) { return ch.charCodeAt(0).toString(16).toUpperCase(); }","","          return s","            .replace(/\\\\/g,   '\\\\\\\\')","            .replace(/\"/g,    '\\\\\"')","            .replace(/\\x08/g, '\\\\b')","            .replace(/\\t/g,   '\\\\t')","            .replace(/\\n/g,   '\\\\n')","            .replace(/\\f/g,   '\\\\f')","            .replace(/\\r/g,   '\\\\r')","            .replace(/[\\x00-\\x07\\x0B\\x0E\\x0F]/g, function(ch) { return '\\\\x0' + hex(ch); })","            .replace(/[\\x10-\\x1F\\x80-\\xFF]/g,    function(ch) { return '\\\\x'  + hex(ch); })","            .replace(/[\\u0100-\\u0FFF]/g,         function(ch) { return '\\\\u0' + hex(ch); })","            .replace(/[\\u1000-\\uFFFF]/g,         function(ch) { return '\\\\u'  + hex(ch); });","        }","","        var expectedDescs = new Array(expected.length),","            expectedDesc, foundDesc, i;","","        for (i = 0; i < expected.length; i++) {","          expectedDescs[i] = expected[i].description;","        }","","        expectedDesc = expected.length > 1",'          ? expectedDescs.slice(0, -1).join(", ")','              + " or "',"              + expectedDescs[expected.length - 1]","          : expectedDescs[0];","",'        foundDesc = found ? "\\"" + stringEscape(found) + "\\"" : "end of input";',"",'        return "Expected " + expectedDesc + " but " + foundDesc + " found.";',"      }","","      if (expected !== null) {","        cleanupExpected(expected);","      }","","      return new peg$SyntaxError(","        message !== null ? message : buildMessage(expected, found),","        expected,","        found,","        location","      );","    }",""].join("\n")),"size"===options.optimize?(parts.push(indent4(generateInterpreter())),parts.push("")):arrays.each(ast.rules,function(u){parts.push(indent4(generateRuleFunction(u))),parts.push("")}),ast.initializer&&(parts.push(indent4(ast.initializer.code)),parts.push("")),"size"===options.optimize?parts.push("    peg$result = peg$parseRule(peg$startRuleIndex);"):parts.push("    peg$result = peg$startRuleFunction();"),parts.push(["","    if (peg$result !== peg$FAILED && peg$currPos === input.length) {","      return peg$result;","    } else {","      if (peg$result !== peg$FAILED && peg$currPos < input.length) {",'        peg$fail({ type: "end", description: "end of input" });',"      }","","      throw peg$buildException(","        null,","        peg$maxFailExpected,","        peg$maxFailPos < input.length ? input.charAt(peg$maxFailPos) : null,","        peg$maxFailPos < input.length","          ? peg$computeLocation(peg$maxFailPos, peg$maxFailPos + 1)","          : peg$computeLocation(peg$maxFailPos, peg$maxFailPos)","      );","    }","  }","","  return {"].join("\n")),options.trace?parts.push(["    SyntaxError:   peg$SyntaxError,","    DefaultTracer: peg$DefaultTracer,","    parse:         peg$parse"].join("\n")):parts.push(["    SyntaxError: peg$SyntaxError,","    parse:       peg$parse"].join("\n")),parts.push(["  };","})()"].join("\n")),ast.code=parts.join("\n")}var arrays=require("../../utils/arrays"),asts=require("../asts"),op=require("../opcodes"),js=require("../javascript");module.exports=generateJavascript}),modules.define("compiler/passes/remove-proxy-rules",function(u,e){function A(u,e){function A(u){return"rule"===u.type&&"rule_ref"===u.expression.type}function n(u,e,A){var t=r.build({rule_ref:function(u){u.name===e&&(u.name=A)}});t(u)}var E=[];t.each(u.rules,function(r,C){A(r)&&(n(u,r.name,r.expression.name),t.contains(e.allowedStartRules,r.name)||E.push(C))}),E.reverse(),t.each(E,function(e){u.rules.splice(e,1)})}var t=e("../../utils/arrays"),r=e("../visitor");u.exports=A}),modules.define("compiler/passes/report-left-recursion",function(u,e){function A(u){var e=[],A=E.build({rule:function(u){e.push(u.name),A(u.expression),e.pop(u.name)},sequence:function(e){t.every(e.elements,function(e){return A(e),!n.alwaysAdvancesOnSuccess(u,e)})},rule_ref:function(E){if(t.contains(e,E.name))throw new r('Left recursion detected for rule "'+E.name+'".',E.location);A(n.findRule(u,E.name))}});A(u)}var t=e("../../utils/arrays"),r=e("../../grammar-error"),n=e("../asts"),E=e("../visitor");u.exports=A}),modules.define("compiler/passes/report-infinite-loops",function(u,e){function A(u){var e=n.build({zero_or_more:function(e){if(!r.alwaysAdvancesOnSuccess(u,e.expression))throw new t("Infinite loop detected.",e.location)},one_or_more:function(e){if(!r.alwaysAdvancesOnSuccess(u,e.expression))throw new t("Infinite loop detected.",e.location)}});e(u)}var t=e("../../grammar-error"),r=e("../asts"),n=e("../visitor");u.exports=A}),modules.define("compiler/passes/report-missing-rules",function(u,e){function A(u){var e=n.build({rule_ref:function(e){if(!r.findRule(u,e.name))throw new t('Referenced rule "'+e.name+'" does not exist.',e.location)}});e(u)}var t=e("../../grammar-error"),r=e("../asts"),n=e("../visitor");u.exports=A}),modules.define("compiler",function(module,require){var arrays=require("./utils/arrays"),objects=require("./utils/objects"),compiler={passes:{check:{reportMissingRules:require("./compiler/passes/report-missing-rules"),reportLeftRecursion:require("./compiler/passes/report-left-recursion"),reportInfiniteLoops:require("./compiler/passes/report-infinite-loops")},transform:{removeProxyRules:require("./compiler/passes/remove-proxy-rules")},generate:{generateBytecode:require("./compiler/passes/generate-bytecode"),generateJavascript:require("./compiler/passes/generate-javascript")}},compile:function(ast,passes){var options=arguments.length>2?objects.clone(arguments[2]):{},stage;objects.defaults(options,{allowedStartRules:["Main"],cache:true,trace:!1,optimize:"speed",output:"source"});for(stage in passes)passes.hasOwnProperty(stage)&&arrays.each(passes[stage],function(u){u(ast,options)});switch(options.output){case"parser":return eval(ast.code);case"source":return ast.code}}};module.exports=compiler}),modules.define("peg",function(u,e){var A=e("./utils/arrays"),t=e("./utils/objects"),r={VERSION:"0.9.0",GrammarError:e("./grammar-error"),parser:e("./parser"),compiler:e("./compiler"),buildParser:function(u){function e(u){var e,A={};for(e in u)u.hasOwnProperty(e)&&(A[e]=t.values(u[e]));return A}var r=arguments.length>1?t.clone(arguments[1]):{},n="plugins"in r?r.plugins:[],E={parser:this.parser,passes:e(this.compiler.passes)};return A.each(n,function(u){u.use(E,r)}),this.compiler.compile(E.parser.parse(u),E.passes,r)}};u.exports=r}),modules.peg}();

console.log("translateLang is the most important function in this file.\n");
console.log("Use TurboTop to keep the output window visible.")

function acs(lang, theString){
	return (theString.toLowerCase().split(",").indexOf(lang.toLowerCase()) !== -1);
}

function capitalizeFirstLetter(string) {
    return string.charAt(0).toUpperCase() + string.slice(1);
}

function pattern_to_input(){
	for(var functionName in thePatterns){
		console.log(functionName +"(");
	for(var current_language_list in thePatterns[functionName]){
		var theString;
	var theString = thePatterns[functionName][current_language_list].split(" ");
	var stringInput = "{return [\""+functionName+"\", {";
	for(var i = 0; i < theString.length; i++){
		if((theString[i].indexOf(":") !== -1) && theString[i][0] !== ":" && /^[a-z0-9]+$/i.test(theString[i][0]) && theString[i][theString[i].length-1] !== ":"){
			theString[i] = capitalizeFirstLetter(theString[i].split(":")[0]);
		}
		else if(theString[i] === "__"){
			theString[i] = "ws_";
		}
		else if(theString[i] === "_"){
			theString[i] = "ws";
		}
		else{
			theString[i] = '"'+theString[i]+'"';
		}
	}
	console.log("\t{memberchk(Lang,['"+current_language_list.split(",").join("','").toLowerCase()+"'])}->\n\t\t"+theString.join(",")+";");
	}
	console.log("\t{not_defined_for(Data,'"+functionName+"')}).");
	}
	return toReturn;
}

function pattern_to_output(theDict, thePattern, theLang){
	var theString;
	
	if((thePattern === 'static_method') && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_static_method', theLang);
	}
	else if((thePattern === 'function') && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_function', theLang);
	}
	else if((thePattern === 'grammar_parameter') && theDict.name === undefined){
		return pattern_to_output(theDict, 'nameless_grammar_parameter', theLang);
	}
	else if(thePattern === 'instance_method' && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_instance_method', theLang);
	}
	else if(thePattern === 'initialize_var' && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_initialize_var', theLang);
	}
	else if(thePattern === 'declare_constant' && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_declare_constant', theLang);
	}
	else if(thePattern === 'function_parameter' && theDict.type === undefined){
		return pattern_to_output(theDict, 'typeless_parameter', theLang);
	}
	
	for(var i in thePatterns[thePattern]){
		if(acs(theLang, i)){
			theString = thePatterns[thePattern][i].replace('\\\\', '\\');
			break;
		}
	}
	if(theString === undefined){
		throw("\nnot yet defined in string_to_dict: " + JSON.stringify(thePattern) + " in " + theLang);
	}
	theString = theString.split(" ");
	for(var i = 0; i < theString.length; i++){
		if(theString[i][0] === ":" || theString[i][theString[i].length-1] === ":"){
			theString[i] = theString[i];
		}
		else if(theString[i].indexOf(":") !== -1){
			var currentKey = theDict[theString[i].split(":")[0]];
			if(currentKey === undefined){
				throw theString[i].split(":")[0] + " is not defined for " + thePattern + " in " + theLang+"\n"+JSON.stringify(theDict);
			}
			theString[i] = currentKey;
		}
		else if(theString[i] === "__"){
			theString[i] = " ";
		}
		else if(theString[i] === "_"){
			theString[i] = '';
		}
	}
	return theString.join("");
}

//Define the patterns in output_dict before defining them here.
const thePatterns = {
	
};
var string_to_dict =
`grammar_output,name:Identifier,value:grammar_Or,output:grammar_Or
	PEG.js
		name = value { return __ output ; }
	nearley
		name -> value {% function ( data ) { return __ output ; } %}
grammar_statement,name:Identifier,value:grammar_Or
	Waxeye
		name <- value
	Nearley
		name -> value
	earley-parser-js
		\\" name -> value \\"
	Parslet
		rule ( : name ) { value }
	Marpa
		name ::= value
	EBNF
		name = value ;
	Yacc,Jison,ANTLR
		name : value ;
	PEG.js,LPeg,ABNF,OMeta
		name = value
	Wirth syntax notation
		name = value .
	Perl 6
		token __ name { value }
	Prolog
		name --> value .
	REBOL
		name : __ value
	Treetop
		rule __ name __ value __ end
	Hampi
		cfg __ name := value ;
	Parboiled
		public __ Rule __ name ( ) { return __ value ; }
	Yapps
		rule __ name : __ value
statement,a:statement
	Lua
		a:(if/import/while/for/function/statement_with_semicolon/comment/multiline_comment)
	Octave
		a:(if/import/while/foreach/function/statement_with_semicolon/comment/multiline_comment)
	MiniZinc
		a:(if/function/foreach/statement_with_semicolon/comment)
	EnglishScript,Seed7,VBScript,Java,Nim,Scala,Python,Dart,JavaScript,TypeScript,C#,PHP,Haxe,Ruby,C++,Visual Basic .NET,Go,Swift,REBOL,Fortran
		a:(function/foreach/import/switch/if/class/class_extends/enum/while/for/statement_with_semicolon/comment/multiline_comment)
	C,R,Julia,Perl
		a:(if/import/while/for/function/statement_with_semicolon/comment/multiline_comment)
	Picat
		a:(if/import/while/for/statement_with_semicolon/comment/multiline_comment)
	Z3,Prolog,Haskell,Erlang,Common Lisp,Emacs Lisp,MiniZinc
		a:(function/import/if/statement_with_semicolon/comment/multiline_comment)
	Mathematical notation,Polish notation,Reverse Polish notation
		a:(function/if/statement_with_semicolon)
statement_with_semicolon,var1:(print/set_var/plus_equals/minus_equals/exception/declare_constant/initialize_var/declare_new_object/typeless_initialize_var/set_array_size/initialize_empty_var/return/function_call)
	C,PHP,Dafny,Chapel,Katahdin,Frink,Falcon,Aldor,IDP,Processing,Maxima,Seed7,Drools,EngScript,OpenOffice Basic,Ada,ALGOL 68,D,Ceylon,Rust,TypeScript,Octave,AutoHotKey,Pascal,Delphi,JavaScript,Pike,Objective-C,OCaml,Java,Scala,Dart,PHP,C#,C++,Haxe,AWK,bc,Perl,Perl 6,Nemerle,Vala
		var1 ;
	MiniZinc
		var1:(return/initialize_var/initialize_empty_var/declare_constant/set_var/import/set_array_size)
	Visual Basic .NET,Lua,Swift,REBOL,Fortran,Python,Go,Picat,Julia
		var1
	Prolog
		var1:(print/declare_constant/initialize_var/typeless_initialize_var/return/function_call)
	Mathematical notation,Polish notation,Reverse Polish notation
		var1:(function_call)
	Z3
		var1:(print/declare_constant/initialize_empty_var/set_var/return)
	Ruby
		var1:(print/set_var/initialize_empty_var/plus_equals/minus_equals/declare_constant/initialize_var/typeless_initialize_var/return/function_call)
	Haskell,Erlang,Common Lisp
		var1:(print/function_call/return)
macro,name:Identifier,params:function_parameters,c:series_of_statements
	Racket
		( define-syntax-rule __ ( name __ params ) __ body )
	C
		#define __ name ( params ) __ body
	Common Lisp
		( defmacro __ name __ ( params ) __ body )
	Rust
		macro_rules! __ name { ( params ) => { body } ; }
	Z3
		( define-fun __ name ( params ) __ type __ body )
	Nearley
		name [ params ] -> body
one_or_more,a:grammar_Or
	Marpa,PEG.js,Perl 6,ANTLR
		( a ) +
	REBOL
		[ some [ a ] ]
	ABNF
		1 * ( a )
	Parslet
		( a ) . repeat ( 1 )
	LPEG
		( a ^ 1 )
	Parboiled
		OneOrMore ( a )
zero_or_more,a:grammar_Or
	LPEG
		( a ^ 0 )
	pypeg
		optional ( a )
	Waxeye
		? ( a )
	EBNF
		{ a }
	Marpa,PEG.js,Perl 6,ANTLR
		( a ) *
	ABNF
		* ( a )
	REBOL
		[ any [ a ] ]
	Parslet
		( a ) . repeat ( 0 )
grammar_parameter,name:Identifier,type:Identifier
	PEG.js
		name : type
	LPeg
		lpeg.V" type "
	Parslet
		type . as ( name )
	Marpa,Yacc,EBNF,REBOL,Prolog,ABNF,Treetop
		type
	Perl 6
		< type >
	Hampi
		type
grammar,name:Identifier,var1:grammar_series_of_statements
	PEG.js,EBNF,nearley,Marpa,REBOL
		var1
	Antlr
		grammar __ name ; var1
	OMeta
		ometa __ name { var1 }
	Perl 6
		grammar __ name { var1 }
	LPEG
		name = lpeg . P { var1 }
	Parslet
		class __ name > Parslet::Parser __ var1 __ end
	Treetop
		grammar __ name __ var1 __ end
	Earley-parser-js
		var __ grammar = new __ tinynlp . Grammar ( [ var1 ] ) ;
	Parboiled
		class __ CalculatorParser __ extends __ BaseParser<Object> { var1 }
nameless_grammar_parameter,type:Identifier
	PEG.js,Yapps,Hampi,ANTLR,Parslet,nearley,Marpa,Yacc,EBNF,REBOL,Prolog,ABNF,Treetop
		type
	LPeg
		lpeg.V" type "
	Perl 6
		< type >
	Parboiled
		type ( )
grammar_string_literal,the_str:string_literal
	PEG.js,Parboiled,earley-parser-js,Antlr,LPeg,Marpa,Yacc,EBNF,REBOL,ABNF,OMeta,Treetop
		the_str
	Parslet
		str ( the_str )
initialize_instance_variable,type:type,name:var_name
	Java,C#
		private __ type __ name
	PHP
		private __ name
	C++,D
		type __ name
	Haxe,Swift
		var __ name : type
	Visual Basic .NET
		Private __ name __ As __ type
	VBScript
		Private __ name
initialize_instance_variable_with_value,type:type,name:var_name,value:expression
	Java,C#
		private __ type __ name = value
	PHP
		private __ name = value
	C++
		type __ name = value
	Python
		self . name = value
	Haxe,Swift
		var __ name : type = value
	Ruby
		@ name = value
	Visual Basic .NET
		Private __ name __ As __ type = value
enum,name:Identifier,body:enum_list
	C
		typedef __ enum { body } name ;
	Seed7
		const __ type : name __ is __ new __ enum __ body __ end __ enum ;
	Ada
		type __ name __ is __ ( body ) ;
	Perl 6
		enum __ name __ < body > ;
	Python
		class __ name ( AutoNumber ) : \\n #indent \\n b \\n #unindent
	Java
		public __ enum __ name { body }
	C#,C++,TypeScript
		enum __ name { body } ;
	Haxe,Rust,Swift,Vala
		enum __ name { body }
	Swift
		enum __ name { case __ body }
	Visual Basic .NET
		Enum __ name __ body __ End __ Enum
	Fortran
		ENUM :: name __ body __ END __ ENUM
	Go
		type __ name __ int __ const ( __ body __ )
	Scala
		object __ name __ extends __ Enumeration { val __ body = Value }
_enum_list,a:Identifier
	Java,Seed7,Vala,Perl 6,Swift,C++,C#,Visual Basic .NET,Haxe,Fortran,TypeScript,C,Ada,Scala
		a
	Go
		a = iota
	Python
		a = ( )
enum_list,a:_enum_list,b:enum_list
	Java,Seed7,Vala,C++,C#,C,TypeScript,Fortran,Ada,Scala
		a , b
	Haxe
		a ; b
	Go,Perl 6,Swift,Visual Basic .NET
		a __ b
list_comprehension,result:expression,variable:var_name,array:expression,condition:expression
	Python,Cython
		[ result __ for __ variable __ in __ array __ if __ condition ]
	Ceylon
		{ for ( variable __ in __ array ) __ if ( condition ) __ result }
	JavaScript
		[ result __ for ( variable __ of __ array ) if __ condition ]
	CoffeeScript
		( result __ for __ variable __ in __ array __ when __ condition )
	MiniZinc
		[ result | variable __ in __ array __ where __ condition ]
	Haxe
		[ for ( variable __ in __ array ) if ( condition ) result ]
	C#
		( from __ variable __ in __ array __ where __ condition __ select __ result )
	Haskell
		[ result | variable <- array , condition ]
	Erlang
		[ result || variable <- array , condition ]
	Ruby
		array . select { | variable | condition } . collect { | variable | result }
	Scala
		( for ( variable <- array __ if __ condition ) yield __ result )
	Groovy
		array.grep { variable -> condition }.collect { variable -> result }
	Dart
		array . where ( variable => condition ) . map ( variable => result )
	Picat
		[ result : variable __ in __ array , condition ]
list_comprehension_2,result:expression,variable:var_name,array:expression
	Python,Julia
		[ result __ for __ variable __ in __ array ]
	Haskell
		[ result | variable <- array ]
array_type,var1:_type,var2:"[]"
	Java,C,C#,Haxe,C++
		var1:_type var2:array_type_suffix
	MiniZinc
		array [ var1 ] __ of __ var1
	Go
		var2:array_type_suffix var1:_type
	Seed7
		var2:array_type_suffix __ var1:_type
	Dart
		array_type = List< var1:_type >
	Swift
		[ var1:_type ]
	Z3
		( _ Array __ var1:_type __ var1:_type )
	Python,Picat
		var1:"list"
	Lua
		var1:"table"
	JavaScript,Ruby
		var1:"Array"
	PHP
		var1:"array"
	REBOL
		var1:"block!"
	Octave
		var1:"matrix"
	Erlang
		var1:"List"
constructor,name:Identifier,params:function_parameters,body:series_of_statements
	REBOL
		new: __ func [ params ] [ make __ self [ body ] ]
	crosslanguage
		( constructor __ name __ params __ body )
	Visual Basic .NET
		Sub __ New ( params ) __ body __ End __ Sub
	Python
		def __ __init__ (  self , params ) : \\n #indent \\n body \\n #unindent
	Java,C#,Vala
		public __ name ( params ) { body }
	Swift
		init ( params ) { body }
	JavaScript
		constructor ( params ) { body }
	Ruby
		def __ initialize ( params ) __ body __ end
	PHP
		function __ construct ( params ) { body }
	Perl
		sub __ new { body }
	Haxe
		public __ function __ new ( params ) { body }
	C++,Dart
		name ( params ) { body }
	D
		this ( params ) { body }
	Chapel
		proc __ name ( params ) { body }
	Julia
		function __ name ( params ) __ body __ end
set_array_size,name:var_name,type:_type,size:expression
	Scala
		var __ name = Array . fill ( size ) { 0 }
	Octave
		name = zeros ( size )
	MiniZinc
		array [ 1 .. size ] __ of __ type : name ;
	Dart
		List __ name = new __ List ( size )
	Java,C#
		type [] __ name  = new __ type [ size ]
	Fortran
		type ( LEN = size )  :: name
	Go
		var __ name __ [ size ] type
	Swift
		var __ name = [ type ] ( count: size , repeatedValue : 0 )
	C,C++
		type __ name [ size ]
	REBOL
		name : array __ size
	Visual Basic .NET
		Dim __ name ( size ) __ as __ type
	PHP
		name = array_fill ( 0 , size , 0 )
	Haxe
		var __ vector =  __ haxe . ds . Vector ( size )
	JavaScript
		var __ name = Array . apply ( null , Array ( size ) ) . map ( function ( ) { } )
	VBScript
		Dim __ name ( size )
typeless_parameter,name:var_name
	Haskell,LiveCode,TypeScript,Visual Basic .NET,REBOL,Prolog,Haxe,Scheme,Python,Mathematical notation,LispyScript,CLIPS,Clojure,F#,ML,Racket,OCaml,Tcl,Common Lisp,newLisp,Python,Cython,Frink,Picat,IDP,PowerShell,Maxima,Icon,CoffeeScript,Fortran,Octave,AutoHotKey,Julia,Prolog,AWK,Kotlin,Dart,JavaScript,Nemerle,Erlang,PHP,AutoIt,Lua,Ruby,R,bc
		name
	Java,C#
		Object __ name
	C++
		auto __ name
	Perl
		name = push ;
asin,a:expression
	Java,JavaScript,Ruby,Haxe,TypeScript
		Math . asin ( a )
	Python,Lua
		math . asin ( a )
	Perl,Seed7,C,Fortran,D,PHP,Hack,Dart,Scala
		asin ( a )
	C#,Visual Basic,Visual Basic .NET
		Math . Asin ( a )
	Gambas
		Asin ( a )
	Erlang
		math : asin ( a )
	C++
		std :: asin ( a )
	Wolfram
		ArcSin [ a ]
	Common Lisp,Racket
		( asin __ a )
	Clojure
		( Math/asin __ a )
typeless_function,name:Identifier,params:function_parameters,body:series_of_statements
	Visual Basic .NET,VBScript
		Function __ name ( params ) __ body __ End __ Function
	JavaScript,PHP,TypeScript
		function __ name ( params ) { body }
	Python
		def __ name ( params ) : \\n #indent \\n body \\n #unindent
	EnglishScript
		def __ name ( params ) : \\n body \\n end
	REBOL
		name : __ func [ params ] [ body ]
	C#
		public __ static __ object __ name ( params ) { body }
	C++,D
		auto __ name ( params ) { body }
	Java
		public __ static __ Object __ name ( params ) { body }
	Ruby
		def __ name ( params ) __ body __ end
	Perl
		sub __ name { params body }
	Lua
		function __ name ( params ) __ body __ end
	Octave
		function __ retval = name ( params ) __ body __ endfunction
	Prolog
		name ( params ) __ :- __ body .
	Picat
		name ( params ) = retval => body .
	Erlang
		name ( params ) -> body .
	Haxe
		static __ function __ name ( params ) { body }
	Wolfram
		name [ params ] := [ body ]
	Dart
		name ( params ) { body }
	Haskell
		name __ params = body:statement
	Pydatalog
		name [ params ] = body
	Emacs Lisp
		( defun __ name __ ( params ) __ body )
acos,a:expression
	Java,JavaScript,Ruby,Haxe,TypeScript
		Math . acos ( a )
	C#,Visual Basic,Visual Basic .NET
		Math . Acos ( a )
	Python,Lua
		math . acos ( a )
	Perl,Seed7,C,Fortran,D,PHP,Scala
		acos ( a )
	Gambas
		Acos ( a )
	C++
		std :: acos ( a )
	Erlang
		math : acos ( a )
	Wolfram
		ArcCos [ a ]
	Common Lisp,Racket
		( acos __ a )
	Clojure
		( Math/acos __ a )
atan,a:expression
	Java,JavaScript,Ruby,Haxe,TypeScript
		Math . atan ( a )
	Python,Lua
		math . atan ( a )
	Erlang
		math : atan ( a )
	Perl,Seed7,C,Fortran,D,PHP,Scala
		atan ( a )
	C#,Visual Basic,Visual Basic .NET
		Math . Atan ( a )
	Gambas
		Atan ( a )
	C++
		std :: atan ( a )
	Wolfram
		ArcTan [ a ]
	Common Lisp,Racket
		( atan __ a )
	Clojure
		( Math/atan __ a )
less_than,a:Add,b:Add
	Pascal,Z3Py,ATS,Pydatalog,E,VBScript,LiveCode,Monkey X,Perl 6,EnglishScript,Cython,GAP,Mathematical notation,Wolfram,Chapel,Elixir,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nim,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET
		a < b
	Prolog
		a #< b
	Racket,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript
		( < __ a:Factor __ b:Factor )
	English
		a __ is __ less __ than __ b
	Polish notation
		< __ a __ b
	Reverse Polish notation
		a __ b __ <
less_than_or_equal,a:Add,b:Add
	C,Z3Py,ATS,Seed7,Pydatalog,VBScript,LiveCode,Monkey X,EnglishScript,GAP,Dafny,Janus,Perl 6,Wolfram,Chapel,Fortran,Elixir,Frink,Mathematical notation,MiniZinc,Picat,ooc,Genie,PL/I,IDP,Processing,EngScript,Maxima,GNU Smalltalk,Pyke,Self,Boo,Cobra,Standard ML,Prolog,Kotlin,Pawn,FreeBASIC,Ada,MATLAB,ALGOL 68,Gambas,Nim,Gosu,AutoIt,Ceylon,D,Groovy,Rust,CoffeeScript,TypeScript,Octave,Hack,AutoHotKey,Julia,Scala,Pascal,Delphi,Swift,Visual Basic,F#,Objective-C,Pike,Python,Cython,Oz,ML,Vala,Dart,C++,Java,OCaml,REBOL,C#,Nemerle,Ruby,PHP,Lua,Visual Basic .NET,Haskell,Haxe,Perl,JavaScript,R,AWK,crosslanguage,Go
		a <= b
	Erlang
		a =< b
	Racket,Z3,CLIPS,newLisp,Hy,Sibilant,LispyScript,Scheme,Clojure,Common Lisp,Emacs Lisp,crosslanguage
		( <= __ a:Factor __ b:Factor )
	English
		a __ is __ less __ than __ or __ equal __ to __ b
	Polish notation
		<= __ a __ b
	Reverse Polish notation
		a __ b __ <=
Multiply,a:Factor,b:Multiply,symbol:("*"/"/")
	C,Pydatalog,E,LiveCode,VBScript,Monkey X,Perl 6,EnglishScript,Cython,Agda,GAP,POP-11,Dafny,Wolfram,Chapel,Katahdin,Mathematical notation,Frink,MiniZinc,COBOL,ooc,Genie,B-Prolog,ECLiPSe,Elixir,nools,Pyke,Picat,PL/I,REXX,IDP,Falcon,Processing,Maxima,Sympy,Mercury,Self,GNU Smalltalk,Boo,Drools,Seed7,Occam,Standard ML,EngScript,Pike,Oz,Kotlin,Pawn,MATLAB,Ada,PowerShell,Gosu,AWK,Gambas,Nim,AutoHotKey,Julia,OpenOffice Basic,ALGOL 68,D,Groovy,Ceylon,Rust,CoffeeScript,ActionScript,TypeScript,Fortran,Octave,ML,Haxe,Pascal,Delphi,Swift,Nemerle,Vala,R,Red,C++,Erlang,Scala,AutoIt,Cobra,F#,Perl,PHP,Go,Ruby,Lua,Haskell,Hack,Java,OCaml,REBOL,Python,JavaScript,C#,Visual Basic,Visual Basic .NET,Dart
		a symbol b
	Racket,Z3,crosslanguage,Common Lisp,CLIPS,newLisp,Hy,Scheme,Clojure,Common Lisp,Emacs Lisp,Sibilant,LispyScript
		( symbol __ a:Factor __ b:Factor )
	Prolog
		a symbol:"#*"/"#/" b
	Polish notation
		symbol __ a __ b
	Reverse Polish notation
		a __ b __ symbol
Add,a:Multiply,b:Add,symbol:("+"/"-")
	Java,Pydatalog,E,LiveCode,VBScript,Monkey X,EnglishScript,GAP,POP-11,Dafny,Janus,Wolfram,Chapel,Bash,Perl 6,Mathematical notation,Katahdin,Frink,MiniZinc,Aldor,COBOL,ooc,Genie,ECLiPSe,nools,B-Prolog,Agda,Picat,PL/I,REXX,IDP,Falcon,Processing,Sympy,Maxima,Pyke,Elixir,GNU Smalltalk,Seed7,Standard ML,Occam,Boo,Drools,Icon,Mercury,EngScript,Pike,Oz,Kotlin,Pawn,FreeBASIC,Ada,PowerShell,Gosu,Nim,Cython,OpenOffice Basic,ALGOL 68,D,Ceylon,Rust,CoffeeScript,ActionScript,TypeScript,Fortran,Octave,ML,AutoHotKey,Delphi,Pascal,F#,Self,Swift,Nemerle,Dart,C,AutoIt,Cobra,Julia,Groovy,Scala,OCaml,Erlang,Gambas,Hack,C++,MATLAB,REBOL,Red,Lua,Go,AWK,Haskell,Perl,Python,JavaScript,C#,PHP,Ruby,R,Haxe,Visual Basic,Visual Basic .NET,Vala,bc
		a symbol b
	Prolog
		a symbol:"#+"/"#-" b
	Racket,Z3,crosslanguage,Common Lisp,CLIPS,newLisp,Hy,Scheme,Clojure,Common Lisp,Emacs Lisp,Sibilant,LispyScript
		( symbol __ a:Factor __ b:Factor )
	Polish notation
		symbol __ a __ b
	Reverse Polish notation
		a __ b __ symbol
greater_than_or_equal,a:Add,b:Add
	C,Z3Py,ATS,Seed7,Pydatalog,VBScript,LiveCode,Monkey X,EnglishScript,GAP,Dafny,Perl 6,Wolfram,Chapel,Frink,Mathematical notation,MiniZinc,Picat,ooc,Genie,PL/I,IDP,Processing,EngScript,Maxima,GNU Smalltalk,Pyke,Self,Boo,Cobra,Standard ML,Prolog,Kotlin,Pawn,FreeBASIC,Ada,MATLAB,ALGOL 68,Gambas,Nim,Gosu,AutoIt,Ceylon,D,Groovy,Rust,CoffeeScript,TypeScript,Octave,Hack,AutoHotKey,Julia,Scala,Pascal,Delphi,Swift,Visual Basic,F#,Objective-C,Pike,Python,Cython,Oz,ML,Vala,Dart,C++,Java,OCaml,REBOL,Erlang,C#,Nemerle,Ruby,PHP,Lua,Visual Basic .NET,Haskell,Haxe,Perl,JavaScript,R,AWK,crosslanguage,Go,Janus
		a >= b
	Fortran
		a __ .GE. __ b
	Racket,Z3,crosslanguage,Common Lisp,CLIPS,newLisp,Hy,Scheme,Clojure,Common Lisp,Emacs Lisp,Sibilant,LispyScript
		( >= __ a:Factor __ b:Factor )
	Polish notation
		>= __ a __ b
	Reverse Polish notation
		a __ b __ >=
function_call_parameters,var1:(function_call_named_parameter/expression),var2:function_call_parameters
	JavaScript,Nim,Seed7,Vala,Wolfram,D,Frink,Delphi,EngScript,Chapel,Perl,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET
		var1 , var2
	Hy,crosslanguage,Coq,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure,Z3
		function_call_parameters = var1 __ var2
greater_than,a:Add,b:Add
	pascal,z3py,ats,pydatalog,e,vbscript,livecode,monkey x,perl 6,englishscript,cython,gap,mathematical notation,wolfram,chapel,katahdin,frink,minizinc,picat,java,eclipse,d,ooc,genie,janus,pl/i,idp,processing,maxima,seed7,self,gnu smalltalk,drools,standard ml,oz,cobra,pike,prolog,engscript,kotlin,pawn,freebasic,matlab,ada,freebasic,gosu,gambas,nim,autoit,algol 68,ceylon,groovy,rust,coffeescript,typescript,fortran,octave,ml,hack,autohotkey,scala,delphi,tcl,swift,vala,c,f#,c++,dart,javascript,rebol,julia,erlang,ocaml,crosslanguage,c#,nemerle,awk,java,lua,perl,haxe,python,php,haskell,go,ruby,r,bc,visual basic,visual basic .net
		a > b
	Racket,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript
		( > __ a:Factor __ b:Factor )
	Polish notation
		> __ a __ b
	Reverse Polish notation
		a __ b __ >
typeof,theObject:parentheses_expression
	Python,Lua
		type ( theObject )
	JavaScript
		typeof ( theObject )
	Visual Basic .NET
		( TypeOf theObject )
	crosslanguage
		( typeof __ theObject )
	Go
		reflect . TypeOf ( theObject ) . Name ( )
	Java
		theObject . getClass ( ) . getName ( )
	Haxe
		Type . typeof ( theObject )
	Ruby
		class ( theObject )
	C#
		theObject . getType ( )
	Perl
		ref ( theObject )
	PHP
		getType ( theObject )
	C++
		typeid ( theObject ) . name ( )
absolute_value,a:expression
	Lua
		math . abs ( a )
	C,Seed7,Octave,Picat,C++,Swift,Python,Fortran,PHP,Hack,Perl,Perl 6,Dart,Julia,Scala,LiveCode
		abs ( a )
	C#,Visual Basic,Visual Basic .NET
		Math . Abs ( a )
	Ruby
		a:parentheses_expression . abs
	Java,JavaScript,Haxe,TypeScript
		Math . abs ( a )
	Wolfram
		Abs [ a ]
	REBOL
		absolute __ a
	Go
		math . Abs ( a )
	Z3
		( ite __ ( >= __ a __ 0 ) __ a __ ( - __ a ) )
	Common Lisp,Racket
		( abs __ a )
natural_logarithm,a:expression
	Python,Lua
		math . log ( a )
	JavaScript,Java,Ruby,Haxe,TypeScript
		Math . log ( a )
	C#,Visual Basic,Visual Basic .NET
		Math . Log ( a )
	C,Fortran,Perl,PHP,C++
		log ( a )
	Mathematical notation
		ln ( a )
charAt,aString:expression,index:expression
	Java,Haxe,Scala,JavaScript,TypeScript
		aString:parentheses_expression . charAt ( index )
	Z3
		( CharAt __ expression __ index )
	Python,C,PHP,C#,MiniZinc,C++,Ruby,Picat,Haskell,Dart
		aString:parentheses_expression [ index ]
	Lua
		aString:parentheses_expression : sub( index:parentheses_expression + 1 , index:parentheses_expression + 1 )
	Octave
		aString:parentheses_expression ( index )
	Chapel
		aString:parentheses_expression . substring ( index )
	Visual Basic .NET
		aString:parentheses_expression . Chars ( index )
	Go
		string ( [ ] rune ( aString ) [ index ] )
	Swift
		aString:parentheses_expression [ aString:parentheses_expression . startIndex . advancedBy ( index ) ]
	REBOL
		aString:parentheses_expression / index:Identifier
	Perl
		substr ( aString:expression , index:expression - 1 , 1 )
import,a:Identifier
	R
		source ( \\" a . r\\" )
	JavaScript
		import __ * __ as __ a __ from __ \' a \' ;
	Clojure
		( import __ a )
	Monkey X
		Import __ a
	Fortran
		USE __ a
	Visual Basic .NET
		Imports __ a
	REBOL
		a : __ load __ % a .r
	Prolog
		:- consult( a ) .
	MiniZinc
		include __ \' a .mzn\' ;
	PHP
		include __ \' a .php\' ;
	C,C++
		#include __ \\" a .h\\"
	C#,Vala
		using __ a ;
	Julia
		using __ a
	Haskell,EngScript,Python,Scala,Go,Groovy,Picat,Elm,Swift,Monkey X
		import __ a
	Java,D,Haxe,Ceylon
		import __ a ;
	Dart
		import __ ' a .dart' ;
	Ruby,Lua
		require __ \' a \'
	Perl,Perl 6,Chapel
		\\"use a ;\\"
regex_matches_string,string:expression:aString,string:expression:regex
	Python
		re . compile ( regex ) . match ( aString )
	Java,Scala
		aString . matches ( regex )
	C#
		regex . isMatch ( aString )
	JavaScript,CoffeeScript,nools
		$regex . test ( aString )
	Haxe
		regex . match ( aString )
	PHP
		( preg_match ( regex , aString ) > 0 )
	Ruby
		( aString =~ regex )
array_contains,container:parentheses_expression,contained:parentheses_expression
	Python,Julia,MiniZinc
		container __ in __ contained
	Swift
		contains ( container:expression , contained:expression )
	Lua
		container [ contained:expression ] ~= nil
	REBOL
		not __ none? __ find __ container __ contained
	JavaScript,CoffeeScript
		container . indexOf ( contained:expression ) !== -1
	CoffeeScript
		container . indexOf ( contained:expression ) != -1
	Ruby
		container . include? ( contained:expression )
	Haxe
		Lambda . has ( container:expression , contained:expression )
	PHP
		in_array ( container:expression , container:expression )
	C#,Visual Basic .NET
		container . Contains ( contained:expression )
	Java
		Arrays . asList ( container:expression ) . contains ( contained:expression )
	Haskell
		( elem __ contained __ container )
	C++
		( std :: find ( std::begin ( container ) , std :: end ( container ) , contained ) != std :: end ( container ) )
key_value_separator
	Python,Picat,Go,Dart,Visual Basic .NET,D,C#,Frink,Swift,JavaScript,TypeScript,PHP,Perl,Lua,Ruby,Julia,Haxe,C++,Scala,Octave,Elixir,Wolfram
		,
	Java
		;
	REBOL
		__
dictionary,a:(key_value_list/key_value),input:type,output:type
	Python,Dart,JavaScript,TypeScript,Lua,Ruby,Julia,C++,EngScript,Visual Basic .NET
		{ a }
	Picat
		new_map ( [ a ] )
	Go
		map [ input ] output { a }
	Java
		new __ HashMap < input , output > ( ) { { a } }
	C#
		new __ Dictionary < input , output > { a }
	Perl
		( a )
	PHP
		array ( a )
	Haxe,Frink,Swift,Elixir,D,Wolfram
		[ a ]
	Scala
		Map( a )
	Octave
		struct ( a )
	REBOL
		to-hash [ a ]
var_name,name:Identifier
	PHP,Perl,Bash,Tcl,AutoIt,Perl 6,Puppet,Hack,AWK,PowerShell
		$ name
	EngScript,EnglishScript,VBScript,Polish notation,Reverse Polish notation,Wolfram,crosslanguage,English,Mathematical notation,Pascal,Katahdin,TypeScript,JavaScript,Frink,MiniZinc,Aldor,Flora-2,F-logic,D,Genie,ooc,Janus,Chapel,ABAP,COBOL,PicoLisp,REXX,PL/I,Falcon,IDP,Processing,Sympy,Maxima,Z3,Shen,Ceylon,nools,Pyke,Self,GNU Smalltalk,Elixir,LispyScript,Standard ML,Nim,Occam,Boo,Seed7,pyparsing,Agda,Icon,Octave,Cobra,Kotlin,C++,Drools,Oz,Pike,Delphi,Racket,ML,Java,Pawn,Fortran,Ada,FreeBASIC,MATLAB,newLisp,Hy,OCaml,Julia,AutoIt,C#,Gosu,AutoHotKey,Groovy,Rust,R,Swift,Vala,Go,Scala,Nemerle,Visual Basic,Visual Basic .NET,Clojure,Haxe,CoffeeScript,Dart,JavaScript,C#,Python,Ruby,Haskell,C,Lua,Gambas,Common Lisp,Scheme,REBOL,F#
		name
	CLIPS
		? name
default_parameter,type:type,name:var_name,value:expression
	Python,AutoHotKey,Julia,Nemerle,PHP,JavaScript
		name = value
	C#,D,Groovy,C++
		type __ name = value
	Dart
		[ type __ name = value ]
	Ruby
		name : value
	Scala,Swift,Python
		name : type = value
	Haxe
		? name = value
	Visual Basic .NET
		Optional __ name __ As __ type = value
_initializer_list,var1:expression,var2:initializer_list_separator,var3:(_initializer_list/expression)
	Lua,Nim,Seed7,Erlang,Vala,Perl 6,Octave,Picat,Julia,Polish notation,Reverse Polish notation,Visual Basic .NET,Dart,Java,Go,C++,JavaScript,C#,Perl,Fortran,C,PHP,Haskell,Haxe,Python,Ruby,TypeScript,MiniZinc,Prolog,REBOL,Swift
		var1 var2 var3
initialize_empty_var,type:type,name:var_name
	Swift,Scala,TypeScript
		var __ name : type
	Java,C#,C++,C,D,Janus,Fortran,Dart
		type __ name
	JavaScript,Haxe
		var __ name
	MiniZinc
		type : name
	Pascal
		name : type
	Go
		var __ name __ type
	Z3
		( declare-const __ name __ type )
	Lua,Julia
		local __ name
	Visual Basic .NET
		Dim __ name __ As __ type
	Perl
		my __ name
	Perl 6
		my __ type __ name
	Z3Py
		name = type ( ' name ' )
initialize_empty_vars,type:type,vars:initialize_empty_vars_1
	C++,Java,C#
		type __ vars
anonymous_function,params:function_parameters,b:series_of_statements,type:type
	Matlab,Octave
		( @ ( params ) body )
	Picat
		lambda ( [ params ] , body )
	Visual Basic .NET
		Function ( params ) __ body __ End __ Function
	Ruby
		Proc . new { | params | b }
	JavaScript,TypeScript,Haxe,R,PHP
		function ( params ) { b }
	Haskell
		( \\\\ params -> b )
	Frink
		{ | params | body }
	Erlang
		fun ( params ) __ b __ end
	Lua,Julia
		function ( params ) __ b __ end
	Swift
		{ ( params ) -> type __ in __ b }
	Go
		func ( params ) type { b }
	Dart,Scala
		( ( params ) => b )
	C++
		[ = ] ( params ) -> type { b }
	Java
		( params ) -> { b }
	Haxe
		( name __ params -> b )
	Python
		( lambda __ params : b )
	Delphi
		function ( params ) begin __ b __ end ;
	D
		( params ) { body }
	REBOL
		func __ [ params ] [ body ]
	Rust
		fn ( params ) { b }
function_parameters,a:function_parameter,b:function_parameter
	Hy,F#,Polish notation,Reverse Polish notation,Z3,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure,Perl
		a __ b
	JavaScript,Nim,Seed7,Pydatalog,E,VBScript,Monkey X,LiveCode,Ceylon,Delphi,EnglishScript,Cython,Vala,Dafny,Wolfram,Gambas,D,Frink,Chapel,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET
		a , b
strlen,a:parentheses_expression
	crosslanguage
		( strlen __ a __ b )
	Python,Go,Erlang,Nim
		len ( a )
	R
		nchar ( a )
	Erlang
		string:len ( a )
	Visual Basic,Visual Basic .NET,Gambas
		Len ( a )
	JavaScript,TypeScript,Ruby,Scala,Gosu,Picat,Haxe,OCaml,D,Dart
		a . length
	REBOL
		length? __ a
	Java,C++,Kotlin
		a . length ( )
	PHP,C,Pawn,Hack
		strlen ( a )
	MiniZinc,Julia,Perl,Seed7,Octave
		length ( a )
	C#,Nemerle
		a . Length
	Swift
		countElements ( a )
	AutoIt
		StringLen ( a )
	Common Lisp,Haskell
		( length __ a )
	Racket,Scheme
		( string-length __ a )
	Fortran
		LEN ( a )
	Lua
		string . len ( a )
	Wolfram
		StringLength [ a ]
	Z3
		( Length __ a )
not_equal,a:parentheses_expression,b:parentheses_expression
	Clojure
		( not= __ a __ b )
	Maxima
		a __ not __ = __ b
	Lua
		a ~= b
	JavaScript,PHP,TypeScript
		a !== b
	Java,Nim,Octave,R,Picat,EnglishScript,Perl 6,Wolfram,C,C++,D,C#,Julia,Perl,Ruby,Haxe,Python,Cython,MiniZinc,Scala,Swift,Go,Rust,Vala
		a != b
	English
		a __ does __ not __ equal __ b
	Prolog
		not ( a == b )
	Common Lisp,Z3
		( not ( = __ a __ b ) )
	Mathematical notation
		a !=  b
	Janus
		a # b
	Fortran
		a .NE. b
	REBOL,Seed7,Visual Basic .NET,Visual Basic,GAP,OCaml,LiveCode,Monkey X,VBScript,Delphi
		a <> b
	Erlang,Haskell
		a /= b
not,a:parentheses_expression
	Python,Cython,Mathematical notation,Emacs Lisp,MiniZinc,Picat,Genie,Seed7,Z3,IDP,Maxima,CLIPS,EngScript,Hy,OCaml,Clojure,Erlang,Pascal,Delphi,F#,ML,Lua,Racket,Common Lisp,crosslanguage,REBOL,Haskell,Sibilant
		( not __ a:expression )
	Java,Perl 6,Katahdin,CoffeeScript,Frink,D,ooc,Ceylon,Processing,Janus,Pawn,AutoHotKey,Groovy,Scala,Hack,Rust,Octave,TypeScript,Julia,AWK,Swift,Scala,Vala,Nemerle,Pike,Perl,C,C++,Objective-C,Tcl,JavaScript,R,Dart,Java,Go,Ruby,PHP,Haxe,C#,Wolfram
		! a
	Prolog
		\\\\+ a
	Visual Basic,Visual Basic .NET,AutoIt,LiveCode,Monkey X,VBScript
		( Not __ a )
	Fortran
		.NOT. a
	Gambas
		NOT __ a
	Rexx
		\\\\ a
	PL/I
		^ a
	PowerShell
		-not __ a
	Polish notation
		not __ a __ b
	Reverse Polish notation
		a __ not
	Z3Py
		Not ( a )
async_function,name:var_name,params:function_parameters,type:type,body:series_of_statements
	C#
		async __ type __ name ( params ) { body }
	JavaScript,Hack
		async __ function __ name ( params ) { body }
	Visual Basic .NET
		Async __ Function __ name ( params ) As __ return_type
varargs,name:Identifier,type:type
	Java
		type ... __ name
	PHP
		 type ... __ $ name
	C#
		params __ type __ name
	Perl 6
		*@ name
	Ruby
		* name
	Scala
		name : type *
	Go
		name ... type
key_value_list,var1:key_value,var2:key_value_separator,var3:(key_value_list/key_value)
	Lua,Octave,Picat,Julia,JavaScript,Dart,Java,C#,C++,Ruby,PHP,Python,Perl,Haxe,TypeScript,Visual Basic .NET,Scala,Swift,REBOL,Go
		var1 var2 var3
grammar_Or,var1:grammar_concatenate_string,var2:grammar_Or
	Marpa,REBOL,Yapps,ANTLR,Jison,Waxeye,OMeta,EBNF,Nearley,Parslet,Yacc,Perl 6,REBOL,Hampi,earley-parser-js
		var1 | var2
	LPEG
		var1 + var2
	PEG.js,ABNF,Treetop
		var1 / var2
	Prolog
		var1 ; var2
	Parboiled
		Sequence ( var1 , var2 )
Or,var1:greater_than,var2:Or
	JavaScript,Katahdin,Perl 6,Wolfram,Chapel,Elixir,Frink,ooc,Picat,Janus,Processing,Pike,nools,Pawn,MATLAB,Hack,Gosu,Rust,AutoIt,AutoHotKey,TypeScript,Ceylon,Groovy,D,Octave,AWK,Julia,Scala,F#,Swift,Nemerle,Vala,Go,Perl,Java,Haskell,Haxe,C,C++,C#,Dart,R
		var1 || var2
	Python,Seed7,Pydatalog,LiveCode,EnglishScript,Cython,GAP,Mathematical notation,Genie,IDP,Maxima,EngScript,Ada,newLisp,OCaml,Nim,CoffeeScript,Pascal,Delphi,Erlang,REBOL,Lua,PHP,crosslanguage,Ruby
		var1 __ or __ var2
	Fortran
		var1 __ .OR. __ var2
	Z3,CLIPS,CLojure,Common Lisp,Emacs Lisp,Clojure,Racket
		( or __ var1:Factor __ var2:Factor )
	Prolog
		var1 ; var2
	MiniZinc
		var1 \\\\/ var2
	Visual Basic,Visual Basic .NET,Monkey X
		var1 __ Or __ var2
	Polish notation
		or __ a __ b
	Reverse Polish notation
		a __ b __ or
	Or
		Or ( a , b )
And,a:Or,b:And
	JavaScript,ATS,Katahdin,Perl 6,Wolfram,Chapel,Elixir,Frink,ooc,Picat,Janus,Processing,Pike,nools,Pawn,MATLAB,Hack,Gosu,Rust,AutoIt,AutoHotKey,TypeScript,Ceylon,Groovy,D,Octave,AWK,Julia,Scala,F#,Swift,Nemerle,Vala,Go,Perl,Java,Haskell,Haxe,C,C++,C#,Dart,R
		a && b
	Pydatalog
		a & b
	Python,Seed7,LiveCode,EnglishScript,Cython,GAP,Mathematical notation,Genie,IDP,Maxima,EngScript,Ada,newLisp,OCaml,Nim,CoffeeScript,Pascal,Delphi,Erlang,REBOL,Lua,PHP,crosslanguage,Ruby
		a __ and __ b
	MiniZinc
		a /\\\\ b
	Fortran
		a .AND. b
	Common Lisp,Z3,newLisp,Racket,Clojure,Sibilant,Hy,CLIPS,Emacs Lisp
		( and __ a:Factor __ b:Factor )
	Prolog
		a , b
	Visual Basic,Visual Basic .NET,VBScript,OpenOffice Basic,Monkey X
		a __ And __ b
	Polish notation
		and __ a __ b
	Reverse Polish notation
		a __ b __ and
	Z3Py
		And ( a , b )
this,a:Identifier
	Ruby,CoffeeScript
		@ a
	Java,EngScript,Dart,Groovy,TypeScript,JavaScript,C#,C++,Haxe,Chapel,Julia
		this . a
	Python
		self . a
	PHP,Hack
		$ this -> a
	Swift,Scala
		a
	REBOL
		self / a
	Visual Basic .NET
		Me . a
	Perl
		$self -> a
array_length,a:parentheses_expression
	crosslanguage
		( array_length __ a )
	Lua
		# a
	Python,Cython,Go
		len ( a )
	Java,Picat,Scala,D,CoffeeScript,TypeScript,Dart,Vala,JavaScript,Ruby,Haxe,Cobra
		a . length
	C#,Visual Basic,Visual Basic .NET,PowerShell
		a . Length
	MiniZinc,Julia,R
		length ( a )
	Common Lisp
		( list-length __ a )
	PHP
		count ( a )
	Rust
		a . len ( )
	Emacs Lisp,Scheme,Racket,Haskell
		( length __ a )
	C++,Groovy
		a . size ( )
	C
		sizeof ( a ) / sizeof ( a [ 0 ] )
	Perl
		scalar ( a )
	REBOL
		length? __ a
	Swift
		a . count
	Clojure
		( count __ array )
	Hy
		( len __ a )
	Octave,Seed7
		length ( a )
	Fortran,Janus
		size ( a )
	Wolfram
		Length [ a ]
initializer_list_separator
	Python,Erlang,Nim,Seed7,Vala,Polish notation,Reverse Polish notation,D,Frink,Fortran,Chapel,Octave,Julia,English,Pascal,Delphi,Prolog,MiniZinc,EngScript,Cython,Groovy,Dart,TypeScript,CoffeeScript,Nemerle,JavaScript,Haxe,Haskell,Ruby,REBOL,Polish notation,Swift,Java,Picat,C#,Go,Lua,C++,C,Visual Basic .NET,Visual Basic,PHP,Scala,Perl,Wolfram
		,
	REBOL
		__
initializer_list,a:(_initializer_list/expression)
	Java,Picat,C#,Go,Lua,C++,C,Visual Basic .NET,Visual Basic,Wolfram
		{ a }
	Python,Nim,D,Frink,REBOL,Octave,Julia,Prolog,MiniZinc,EngScript,Cython,Groovy,Dart,TypeScript,CoffeeScript,Nemerle,JavaScript,Haxe,Haskell,Ruby,REBOL,Polish notation,Swift
		[ a ]
	PHP
		array ( a )
	Scala
		Array ( a )
	Perl,Chapel
		( a )
	Fortran
		(/ a /)
key_value,a:Identifier,b:expression
	Groovy,D,Dart,JavaScript,TypeScript,CoffeeScript,Swift,Elixir,Swift,Go
		a : b
	Python
		' a ' : b
	Ruby,PHP,Haxe,Perl,Julia
		a => b
	REBOL
		a __ b
	Lua,Picat
		a = b
	C++,C#,Visual Basic .NET
		{ a , b }
	Scala,Wolfram
		a -> b
	Octave
		a , b
	Frink
		[ a , b ]
	Java
		put ( a , b )
strcmp,a:parentheses_expression,b:parentheses_expression
	R
		identical ( a , b )
	Emacs Lisp
		( string= __ a __ b )
	Clojure
		( = __ a __ b )
	Visual Basic,Delphi,Visual Basic .NET,VBScript,F#,Prolog,Mathematical notation,OCaml,LiveCode,Monkey X
		a = b
	Python,Pydatalog,Perl 6,EnglishScript,Chapel,Julia,Fortran,MiniZinc,Picat,Go,Vala,AutoIt,REBOL,Ceylon,Groovy,Scala,CoffeeScript,AWK,Ruby,Haskell,Haxe,Dart,Lua,Swift
		a == b
	JavaScript,PHP,TypeScript,Hack
		a === b
	C,Octave
		strcmp ( a , b ) == 0
	C++
		a . compare ( b )
	C#
		a . Equals ( b )
	Java
		a . equals ( b )
	Common Lisp
		( equal __ a __ b )
	CLIPS
		( str-compare __ a __ b )
	Hy
		( = __ a __ b )
	Perl
		a __ eq __ b
	Erlang
		string : equal ( a , b )
	Polish notation
		= __ a __ b
	Reverse Polish notation
		a __ b __ =
sqrt,x:expression
	LiveCode
		( the __ sqrt __ of __ x )
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . sqrt ( x )
	C#,Visual Basic .NET
		Math . Sqrt ( x )
	C,Seed7,Julia,Perl,PHP,Perl 6,Maxima,MiniZinc,Prolog,Octave,D,Haskell,Swift,Mathematical notation,Dart,Picat
		sqrt ( x )
	Lua,Python
		math . sqrt ( x )
	REBOL
		square-root __ x
	Scala
		scala . math . sqrt ( x )
	C++
		std :: sqrt ( x )
	Erlang
		math : sqrt ( x )
	Wolfram
		Sqrt [ x ]
	Common Lisp,Racket
		( sqrt __ x )
	Fortran
		SQRT ( x )
	Go
		math . Sqrt ( x )
grammar_parentheses_expression,a:grammar_Or
	Marpa,earley-parser-js,Antlr,Treetop,Waxeye,OMeta,Wirth syntax notation,Yacc,LPeg,Parslet,PEG.js,EBNF,Nearley,Prolog,Perl 6,ABNF
		( a )
	REBOL
		[ a ]
	Parboiled
		Sequence ( "(" , a , ")" )
parentheses_expression,a:expression
	Pydatalog,Pascal,VBScript,Monkey X,LiveCode,Perl 6,EnglishScript,Wolfram,Cython,Mathematical notation,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nim,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET
		( a )
	Racket,Polish notation,Reverse Polish notation,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript
		a
join,array:parentheses_expression,separator:parentheses_expression
	Swift
		array . joinWithSeparator ( separator )
	C#
		String . Join ( separator , array )
	PHP
		implode ( separator , array )
	Perl
		join ( separator , array )
	D,Julia
		join ( array , separator )
	Lua
		table . concat ( array , separator )
	Go
		Strings . join ( array , separator )
	JavaScript,Haxe,CoffeeScript,Ruby,Groovy,Java,TypeScript,Rust,Dart
		array . join ( separator )
	Python
		separator . join ( array )
	Scala
		array . mkString ( separator )
	Visual Basic .NET
		Join ( array, separator )
plus_equals,a:(access_array/dot_notation/Identifier),b:expression
	Janus,Nim,Vala,Perl 6,Dart,Visual Basic .NET,TypeScript,Python,Lua,Java,C,C++,C#,JavaScript,Haxe,PHP,Chapel,Perl,Julia,Scala,Rust,Go,Swift
		a += b
	Ruby,Haskell,Erlang,Fortran,OCaml,MiniZinc,Octave,Delphi
		a = a + b
	Picat
		a := a + b
	REBOL
		a : a + b
	LiveCode
		add __ b __ to __ a
	Seed7
		a +:= b
minus_equals,a:(dot_notation/access_array/Identifier),b:expression
	Janus,Vala,Nim,Perl 6,Dart,Perl,Visual Basic .NET,TypeScript,Python,Lua,Java,C,C++,C#,JavaScript,PHP,Haxe,Hack,Julia,Scala,Rust,Go,Swift
		a -= b
	Ruby,Haskell,Erlang,Fortran,OCaml,MiniZinc,Octave,Delphi
		a = a - b
	Picat
		a := a - b
	REBOL
		a : a - b
	LiveCode
		subtract __ b __ from __ a
	Seed7
		a -:= b
grammar_concatenate_string,a:Factor,b:grammar_concatenate_string
	EBNF,Prolog
		a , b
	LPEG
		a * b
	PEG.js,Yapps,earley-parser-js,Hampi,ANTLR,Jison,Treetop,Waxeye,OMeta,Marpa,nearley,Yacc,Wirth syntax notation,Perl 6,REBOL,ABNF
		a __ b
	Parslet
		a >> b
	Parboiled
		Sequence ( a , b )
concatenate_string,a:Multiply,b:concatenate_string
	R
		paste0 ( a , b )
	Maxima
		sconcat ( a , b )
	Common Lisp
		( concatenate __ 'string __ a __ b )
	C,Z3Py,Monkey X,EnglishScript,Mathematical notation,Go,Java,Chapel,Frink,FreeBASIC,Nemerle,D,Cython,Ceylon,CoffeeScript,TypeScript,Dart,Gosu,Groovy,Scala,Swift,F#,Python,JavaScript,C#,Haxe,Ruby,C++,Vala
		a + b
	Lua,EngScript
		a .. b
	Fortran
		a // b
	PHP,AutoHotKey,Hack,Perl
		a . b
	OCaml
		a ^ b
	REBOL
		append __ a __ b
	Haskell,MiniZinc,Picat,Elm
		a ++ b
	CLIPS
		( str-cat a b )
	Clojure
		( str a b )
	Erlang
		string : concat ( a , b )
	Julia
		string ( a , b )
	Octave
		strcat ( a , b )
	Racket
		( string-append a b )
	Delphi
		Concat ( a , b )
	Visual Basic,Seed7,Gambas,Nim,AutoIt,Visual Basic .NET,OpenOffice Basic,LiveCode,VBScript
		a & b
	Elixir,Wolfram
		a <> b
	Perl 6
		a ~ b
	Z3
		( Concat __ a __ b )
	Emacs Lisp
		( concat __ a __ b )
	Polish notation
		+ __ a __ b
	Reverse Polish notation
		a __ b __ +
range,a:expression,b:expression
	Swift,Perl,Picat,Ruby,MiniZinc,Chapel
		a .. b
	Python
		range ( a , b - 1 )
	Octave,Julia,R
		a : b
	Haxe
		a ... ( b - 1 )
split,aString:parentheses_expression,separator:parentheses_expression
	Swift
		aString . componentsSeparatedByString ( separator:expression )
	Octave
		strsplit ( aString:expression , separator:expression )
	Go
		strings . Split ( aString:expression , separator:expression )
	JavaScript,CoffeeScript,Java,Python,Dart,Scala,Groovy,Haxe,Ruby,Rust,TypeScript,Cython,Vala
		aString . split ( separator:expression )
	Lua
		string . gmatch ( aString:expression , separator:expression )
	PHP
		explode ( separator:expression , aString:expression )
	Perl,Processing
		split ( separator:expression , aString:expression )
	REBOL
		split __ aString __ separator
	C#
		aString . Split ( new string[] { separator:expression } , StringSplitOptions . None )
	Picat,D,Julia
		split ( aString:expression , separator:expression )
	Haskell
		( splitOn __ aString __ separator )
	Wolfram
		StringSplit [ aString:expression , separator:expression ]
	Visual Basic .NET
		Split ( aString:expression , separator:expression )
pow,a:expression,b:expression
	Lua
		math . pow ( a , b )
	Scala
		scala.math.pow ( a , b )
	C#,Visual Basic .NET
		Math . Pow ( a , b )
	JavaScript,Java,TypeScript,Haxe
		Math . pow ( a , b )
	Python,Seed7,Cython,Chapel,Haskell,COBOL,Picat,ooc,PL/I,REXX,Maxima,AWK,R,F#,AutoHotKey,Tcl,AutoIt,Groovy,Octave,Ruby,Perl,Perl 6,Fortran
		( a ** b )
	REBOL
		power __ a __ b
	C,C++,PHP,Hack,Swift,MiniZinc,Dart,D
		pow ( a , b )
	Julia,EngScript,Visual Basic,Visual Basic .NET,Gambas,Go,Ceylon,Wolfram,Mathematical notation
		a:parentheses_expression ^ b:parentheses_expression
	Rust
		num::pow ( a , b )
	Hy,Common Lisp,Racket,Clojure
		( expt __ num1 __ num2 )
	Erlang
		math : pow ( a , b )
case_statements,a:case,b:case_statements
	Java,Vala,Octave,OCaml,C,C#,C++,JavaScript,PHP,Haxe,Fortran,Ruby,Dart,TypeScript,Scala,Haskell,Visual Basic .NET,Swift,REBOL
		a __ b
	Erlang
		a ; b
substring,a:parentheses_expression,b:expression,c:expression
	JavaScript,CoffeeScript,TypeScript,Java,Scala,Dart
		a . substring ( b , c )
	C++
		a . substring ( b , c - b )
	Z3
		( Substring __ a __ b __ c )
	Python,Cython,Icon,Go
		a [ b : c ]
	Julia:
		a [ b - 1 : c ]
	Fortran
		a ( b : c )
	C#,Visual Basic .NET,Nemerle
		a . Substring ( b , c )
	Haskell
		take ( c - b ) . drop b $ a
	PHP,AWK,Perl,Hack
		substr ( a , b , c )
	Haxe
		a . substr ( b , c )
	REBOL
		copy/part __ skip __ a __ b __ c
	Clojure
		( subs __ a __ b __ c )
	Erlang
		string : sub_string ( a , b , c )
	Ruby,Pike,Groovy
		a [ b .. c ]
	Racket
		( substring __ a __ b __ c )
	Common Lisp
		( subseq __ a __ b __ c )
	Lua
		string . sub ( a , b , c )
mod,a:parentheses_expression,b:parentheses_expression
	Java,Perl 6,Cython,Rust,TypeScript,Frink,ooc,Genie,Pike,Ceylon,Pawn,PowerShell,CoffeeScript,Gosu,Groovy,EngScript,AWK,Julia,Scala,F#,Swift,R,Perl,Nemerle,Haxe,PHP,Hack,Vala,Lua,Tcl,Go,Dart,JavaScript,Python,C,C++,C#,Ruby
		a % b
	REBOL
		mod __ a __ b
	Haskell,Seed7,MiniZinc,OCaml,Delphi,Pascal,Picat,LiveCode
		a __ mod __ b
	Prolog,Octave,MATLAB,AutoHotKey,Fortran
		mod ( a:expression , b:expression )
	Erlang
		a __ rem __ b
	CLIPS,Clojure,Common Lisp,Z3
		( mod __ a __ b )
	Visual Basic,Visual Basic .NET,Monkey X
		a __ Mod __ b
	Wolfram
		Mod [ a , b ]
dot_notation,var_name:Identifier,var_name:dot_notation
	Java,Octave,Scala,Julia,Python,JavaScript,TypeScript,Dart,D,Haxe,C#,Perl 6,Lua,C++,Visual Basic .NET,Ruby,Go,Swift
		var1 . var2
	PHP,C,Perl
		var1 -> var2
	REBOL
		var1 / var2
	Fortran
		var1 % var2
sin,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . sin ( var1 )
	Lua,Python
		math . sin ( var1 )
	C,Seed7,Erlang,Picat,Mathematical notation,Julia,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell,C++,Scala
		sin ( var1 )
	C#,Visual Basic .NET
		Math . Sin ( var1 )
	Wolfram
		Sin [ var1 ]
	REBOL
		sine/radians __ var1
	Go
		math . Sin ( var1 )
	Common Lisp,Racket
		( sin __ a )
	Clojure
		( Math/sin __ a )
cos,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . cos ( var1 )
	Lua,Python
		math . cos ( var1 )
	C,Seed7,Erlang,Picat,Mathematical notation,Julia,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell,C++,Scala
		cos ( var1 )
	C#,Visual Basic .NET
		Math . Cos ( var1 )
	Wolfram
		Cos [ var1 ]
	Go
		math . Cos ( var1 )
	REBOL
		cosine/radians __ var1
	Common Lisp,Racket
		( cos __ a )
	Clojure
		( Math/cos __ a )
tan,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . tan ( var1 )
	Lua,Python
		math . tan ( var1 )
	C,Seed7,Erlang,Picat,Mathematical notation,Julia,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell,C++,Scala
		tan ( var1 )
	C#,Visual Basic .NET
		Math . Tan ( var1 )
	Wolfram
		Tan [ var1 ]
	REBOL
		tangent/radians __ var1
	Go
		math . Tan ( var1 )
	Common Lisp,Racket
		( tan __ a )
	Clojure
		( Math/tan __ a )
instance_method,name:Identifier,type:type,params:function_parameters,body:series_of_statements
	Swift
		func __ name ( params ) -> type { body }
	Visual Basic .NET
		Public __ Function __ InstanceMethod ( params ) As __ type __ body __ End __ Function
	JavaScript
		name ( params ) { body }
	Perl 6
		method __ name __ ( params ) { body }
	Chapel
		def __ name ( params ) : type { body }
	Java,C#
		public __ type __ name ( params ) { body }
	PHP
		public __ function __ name ( params ) { body }
	Ruby
		def __ name ( params ) __ body __ end
	C++,D,Dart
		type __ name ( params ) { body }
	Haxe
		public __ function __ name ( params ) : type { body }
	Lua
		_
	Python
		def __ name ( self, params ) : \\n #indent \\n body \\n #unindent
typeless_instance_method,name:Identifier,params:function_parameters,body:series_of_statements
	Swift
		func __ name ( params ) { body }
	Visual Basic .NET
		Public __ Function __ InstanceMethod ( params ) __ body __ End __ Function
	JavaScript,Dart
		name ( params ) { body }
	Chapel
		def __ name ( params ) { body }
	Java
		public __ Object __ name ( params ) { body }
	C#
		public __ object __ name ( params ) { body }
	PHP
		public __ function __ name ( params ) { body }
	Ruby
		def __ name ( params ) __ body __ end
	C++,D
		auto __ name ( params ) { body }
	Haxe
		public __ function __ name ( params ) { body }
	Lua
		_
	Python
		def __ name ( self, params ) : \\n #indent \\n body \\n #unindent
typeless_static_method,name:Identifier,params:function_parameters,body:series_of_statements
	Swift
		class __ func __ name ( params ) { body }
	Visual Basic .NET
		Public __ Shared __ Function __ InstanceMethod ( params ) __ body __ End __ Function
	JavaScript
		static __ name ( params ) { body }
	Haxe
		public __ static __ function __ name ( params ) { body }
	Lua,Julia
		function __ name ( params ) __ body __ end
	Java
		public __ static __ Object __ name ( params ) { body }
	C#
		public __ static __ object __ name ( params ) { body }
	Dart
		static __ name ( params ) { body }
	C++
		static __ auto __ name ( params ) { body }
	PHP
		public __ static __ function __ name ( params ) { body }
	Ruby
		def __ self . name ( params ) __ body __ end
	Python
		@staticmethod \\n __ def __ name (  params ) : \\n #indent \\n body \\n #unindent
static_method,name:Identifier,type:type,params:function_parameters,body:series_of_statements
	Swift
		class __ func __ name ( params ) -> type { body }
	Visual Basic .NET
		Public __ Shared __ Function __ InstanceMethod ( params ) __ As __ type __ body __ End __ Function
	Haxe
		public __ static __ function __ name ( params ) { body }
	Lua,Julia
		function __ name ( params ) __ body __ end
	Java,C#
		public __ static __ type __ name ( params ) { body }
	C++,Dart
		static __ type __ name ( params ) { body }
	PHP
		public __ static __ function __ name ( params ) { body }
	Ruby
		def __ self . name ( params ) __ body __ end
	C
		type __ name ( params ) { body }
	JavaScript
		static __ name ( params ) { body }
	Picat
		_
	Python
		@staticmethod \\n __ def __ name (  params ) : \\n #indent \\n body \\n #unindent
declare_new_object,var_name:var_name,class_name:Identifier,params:function_call_parameters
	Visual Basic .NET
		Private __ var_name __ As __ New __ class_name ( params )
	Java,C#,D,Dart
		class_name __ var_name = new __ class_name ( params )
	JavaScript,Haxe,Chapel,Scala
		var __ var_name = new __ class_name ( params )
	PHP
		var_name = new __ class_name ( params )
	Python,Swift,Octave
		var_name = class_name ( params )
	Ruby
		var_name = class_name . new ( params )
	Perl
		my __ var_name = class_name -> new ( params )
	Perl 6
		my __ var_name = class_name -> new ( params )
	C++
		class_name __ var_name ( params )
string_to_int,a:expression
	Common Lisp
		( parse-integer __ a )
	Rust
		a:parentheses_expression . parse :: <int> ( )
	Perl 6
		+ ( a )
	Go
		strconv . Atoi ( a )
	Python,Julia
		int ( a )
	Haxe
		Std . parseInt ( a )
	PHP
		( int ) a
	Haskell
		( read __ a )
	C#
		Int32 . Parse( a )
	Visual Basic .NET
		Convert . toInt32 ( a )
	Java
		Integer . parseInt ( a )
	Ceylon
		parseInteger ( a )
	C
		atoi ( a )
	Scala
		a . toInt
	D
		std . conv . to!int ( a )
	Ruby
		Integer ( a )
	REBOL
		to __ integer! __ a
	Lua
		tonumber ( a )
	JavaScript,TypeScript
		parseInt ( a )
	C++
		atoi ( a . c_str ( ) )
	Dart
		int . parse ( a )
	Swift
		Int ( a )
	Octave
		str2double ( a )
int_to_string,a:parentheses_expression
	Perl 6
		~ ( a )
	Go
		strconv . Itoa ( a )
	Python
		str ( a )
	Wolfram
		ToString [ a ]
	Swift,JavaScript,TypeScript
		String ( a )
	Java
		Integer . toString ( a )
	Haskell
		( show __ a )
	Perl
		a
	C#,Visual Basic .NET
		Convert . ToString ( a )
	Ruby
		a . to_s
	REBOL
		to __ string! __ a
	C++
		std :: to_string ( a )
	Lua
		tostring ( a )
	Haxe
		Std . toString ( a )
	D
		std . conv . to!string ( a )
	PHP
		( string ) a
	Dart
		a . toString ( )
	Scala
		a . toString
	Rust
		a . to_string ( )
	Julia
		string ( a )
	Octave
		num2str ( a )
typeless_declare_constant,name:var_name,value:expression
	Polish notation
		= __ name __ value
	Reverse Polish notation
		name __ value __ =
	Go
		const __ type __ name = value
	PHP,JavaScript,TypeScript,Nim
		const __ name = value
	Visual Basic .NET
		Public __ Const __ name = value
	Rust,Swift
		let __ name = value
	C
		const __ __auto_type __ name = value
	C#
		const __ object __ name = value
	D,C++
		const __ auto __ name = value
	Common Lisp
		( setf __ name __ value )
	Scala
		val __ name = value
	Python,Ruby,Haskell,Erlang,Julia,Picat,Prolog
		name = value
	Lua
		local __ name = value
	Perl
		my __ name = value
	REBOL
		name : value
	Haxe
		static __ inline __ var __ name = value
	Java
		final __ Object __ name = value
	Dart
		final __ name = value
	C
		static __ const __ name = value
	Chapel
		var name = value
	Perl 6
		constant __ name = value
assert,a:expression
	C,C++,Lua,Python,Swift,PHP,Ceylon
		assert ( a )
	C#,Visual Basic .NET
		Debug . Assert ( a )
	Java,EnglishScript,F#
		assert a
	Clojure
		( assert __ a )
	R
		stopifnot ( a )
declare_constant,name:var_name,type:type,value:expression
	Seed7
		const __ type : name __ is __ value
	Polish notation
		= __ name __ value
	Reverse Polish notation
		name __ value __ =
	Fortran
		type , PARAMETER :: name = expression
	Go
		const __ type __ name = value
	Perl 6
		constant __ type __ name = value
	PHP,JavaScript,Dart
		const __ name = value
	Z3
		( declare-const __ name __ type ) ( assert __ ( = __ name __ value ) )
	Visual Basic .NET
		Public __ Const __ name __ As __ type = value
	Rust,Swift
		let __ name = value
	C++,C,D,C#
		const __ type __ name = value
	Common Lisp
		( setf __ name __ value )
	MiniZinc
		type : name = value
	Scala
		val __ name : type = value
	Python,Ruby,Haskell,Erlang,Julia,Picat,Prolog
		name = value
	Lua
		local __ name = value
	Perl
		my __ name = value
	REBOL
		name : value
	Haxe
		static __ inline __ var __ name = value
	Java,Dart
		final __ type __ name = value
	C
		static __ const __ name = value
	Chapel
		var __ name : type = value
	TypeScript
		const __ name : type = value
index_of,string:parentheses_expression,substring:parentheses_expression
	JavaScript,Java
		string . indexOf ( substring:expression )
	D
		string . indexOfAny ( substring:expression )
	Ruby
		string . index ( substring:expression )
	C#
		string . IndexOf ( substring:expression )
	Python
		string . find ( substring:expression )
	Go
		strings . Index ( string:expression , substring:expression )
function_call_named_parameter,name:Identifier,value:expression
	Python,C#,Fortran,Scala
		name = value
	Modula-3,Visual Basic .NET
		name := value
	Ruby,Swift,Dart
		name : value
	JavaScript,Erlang,Octave,Picat,Julia,Mathematical notation,Lua,Java,C,PHP,Haxe,MiniZinc,C++,Prolog,Z3,REBOL,Haskell,Go,Polish notation,Reverse Polish notation
		value
	Perl
		 name => value
function_call,theName:dot_notation,args:(function_call_parameters/_)
	C,Nim,Seed7,GAP,Mathematical notation,Chapel,Elixir,Janus,Perl 6,Pascal,Rust,Hack,Katahdin,MiniZinc,Pawn,Aldor,Picat,D,Genie,ooc,PL/I,Delphi,Standard ML,REXX,Falcon,IDP,Processing,Maxima,Swift,Boo,R,MATLAB,AutoIt,Pike,Gosu,AWK,AutoHotKey,Gambas,Kotlin,Nemerle,EngScript,Prolog,Groovy,Scala,CoffeeScript,Julia,TypeScript,Fortran,Octave,C++,Go,Cobra,Ruby,Vala,F#,Java,Ceylon,OCaml,Erlang,Python,C#,Lua,Haxe,JavaScript,Dart,bc,Visual Basic,Visual Basic .NET,PHP,Perl
		theName ( args )
	Haskell,Z3,CLIPS,Clojure,Common Lisp,CLIPS,Racket,Scheme,crosslanguage,REBOL
		( theName __ args )
	Polish notation
		theName __ args
	Reverse Polish notation
		args __ theName
	Pydatalog,Nearley
		theName [ args ]
reverse_string,a:expression
	Python
		a  [ :: -1 ]
	Ruby
		a . reverse!
	Java
		new __ StringBuilder ( theString ) . reverse ( ) . toString ( )
	JavaScript
		a . reverse ( )
	PHP
		strrev ( a )
	Visual Basic .NET
		StrReverse ( a )
	Haskell
		( reverse __ a )
	Perl
		reverse ( a )
remove_dictionary_key,dictionary:expression,key:expression
	JavaScript
		delete __ dictionary [ key ]
	Perl
		delete __ dictionary { key }
	Python
		dictionary . pop ( key , None )
	Ruby
		dictionary . delete ( key )
dictionary_keys,a:expression
	JavaScript
		Object . keys ( a )
	Python
		a:parentheses_expression . keys ( a )
	PHP
		array_keys ( a )
	Ruby
		a:parentheses_expression . keys
	Perl
		keys ( a )
reverse_array,a:expression
	Haskell
		( reverse __ a )
	Ruby
		a . reverse
	JavaScript,Haxe
		a . reverse ( )
	Python
		a [ :: -1 ]
	Perl
		reverse ( a )
	PHP
		array_reverse ( a )
	Visual Basic .NET,C#
		Array . Reverse ( a )
for,statement_1:initialize_var,condition:expression,statement_2:set_var,body:series_of_statements
	Java,D,Pawn,Groovy,JavaScript,Dart,TypeScript,PHP,Hack,C#,Perl,C++,AWK,Pike
		for ( statement_1 ; condition ; statement_2 ) { body }
	C
		init:initialize_empty_var ; for ( statement_1 ; condition ; statement_2 ) { body }
	Haxe
		statement_1 ;  while ( condition ) { body statement_2 ; }
	Lua,Ruby
		statement_1 __ while __ condition __ do __ body __ statement_2 __ end
while,a:expression,b:series_of_statements
	GAP
		while __ a __ do __ b __ od ;
	EnglishScript
		while __ a __ do __ b __ od ;
	Fortran
		WHILE __ ( a ) __ DO __ b __ ENDDO
	Pascal
		while __ a __ do __ begin __ b __ end;
	Delphi
		While __ a __ do __ begin __ b __ end;
	Rust,Frink,Dafny
		while __ a { b }
	C,Perl 6,Katahdin,Chapel,ooc,Processing,Pike,Kotlin,Pawn,PowerShell,Hack,Gosu,AutoHotKey,Ceylon,D,TypeScript,ActionScript,Nemerle,Dart,Swift,Groovy,Scala,Java,JavaScript,PHP,C#,Perl,C++,Haxe,R,AWK,Vala
		while ( a ) { b }
	Lua,Ruby,Julia
		while __ a __ b __ end
	Picat
		while __ ( a ) __ b __ end
	REBOL
		while [ a ] [ b ]
	Common Lisp
		( loop __ while __ a __ do __ b )
	Hy,newLisp,CLIPS
		( while __ a __ b )
	Python,Cython
		while __ a : \\n #indent \\n b \\n #unindent
	Visual Basic,Visual Basic .NET,VBScript
		While __ a __ b __ End While
	Octave
		while ( a ) __ endwhile
	Wolfram
		While [ a , b ]
	Go
		for __ a { b }
	VBScript
		Do __ While __ a __ b __ Loop
	Seed7
		while __ a __ do __ b __ end __ while ;
exception,a:expression
	Python
		raise __ Exception ( a )
	Ruby,OCaml
		raise __ a
	JavaScript,Dart,Java,C++,Swift,REBOL,Haxe,C#,Picat,Scala
		throw __ a
	Julia,E
		throw ( a )
	Visual Basic .NET
		Throw __ a
	Perl,Perl 6
		die __ a
	Octave
		error ( a )
	PHP
		throw __ new __ Exception ( a )
function,type:type,params:function_parameters,name:Identifier,body:series_of_statements
	SQL
		CREATE __ FUNCTION __ dbo . name ( function_parameters ) __ RETURNS __ type __ body
	Seed7
		const __ func __ type : name ( params ) __ is __ func __ begin __ body __ end __ func ;
	LiveCode
		function __ name __ params __ body __ end __ name
	Monkey X
		Function name : type ( params ) body __ End
	Emacs Lisp
		( defun __ name __ ( params ) __ body )
	Go
		func __ name ( params ) __ type { body }
	C++,Vala,C,Dart,Ceylon,Pike,D,EnglishScript
		type __ name ( params ) { body }
	Pydatalog
		name ( params ) <= body
	Java,C#
		public __ static __ type __ name ( params ) { body }
	JavaScript,PHP
		function __ name ( params ) { body }
	Lua,Julia
		function __ name ( params ) __ body __ end
	Wolfram
		name [ params ] := body
	Frink
		name [ params ] := { body }
	POP-11
		define __ name ( params ) -> Result; __ body __ enddefine;
	Z3
		( define-fun __ name ( params ) __ type __ body )
	Mathematical notation
		name ( params ) = { body }
	Chapel
		proc __ name ( params ) : type { body }
	Prolog
		name ( params ) __ :- __ body:statement .
	Picat
		name ( params ) = retval => body .
	Swift
		func __ name ( params ) -> type { body }
	Maxima
		name ( params ) := body
	Rust
		fn __ name ( params ) -> type { body }
	Clojure
		( defn name [ params ] body )
	Octave
		function __ retval = name ( params ) body __ endfunction
	Haskell
		name __ params = body:statement
	Common Lisp
		(defun __ name ( params ) body )
	Fortran
		FUNC __ name __ ( params ) __ RESULT ( retval ) __ type :: retval __ body __ END __ FUNCTION __ name
	Scala
		def __ name ( params ) : type = { body }
	MiniZinc
		function __ type : name ( params ) = body ;
	CLIPS
		( deffunction __ name ( params ) body )
	Erlang
		name ( params ) -> body
	Perl
		sub __ name { params body }
	Perl 6
		sub __ name ( params ) { body }
	Pawn
		name ( params ) { body }
	Ruby
		def __ name ( params ) __ body __ end
	TypeScript
		function __ name ( params ) : type { body }
	REBOL
		name : __ func [ params ] [ body ]
	Haxe
		public __ static __ function __ name ( params ) : type { body }
	Hack
		function __ name ( params ) : type { body }
	R
		name <- function ( params ) { body }
	bc
		define __ name ( params ) { body }
	Visual Basic,Visual Basic .NET
		Function __ name ( params ) As __ type __ body __ End __ Function
	VBScript
		Function __ name ( params ) __ body __ End __ Function
	Racket,newLisp
		(define (name params) body )
	Janus
		procedure __ name ( params ) body
	Python
		def __ name ( params ) -> type : \\n #indent \\n body \\n #unindent
	F#
		let __ name __ params = \\n #indent \\n body \\n #unindent
	Polish notation
		= name ( params ) __ body
	Reverse Polish notation
		name ( params ) __ body __ =
	OCaml
		let __ name __ params = body
	E
		def __ name ( params ) type { body }
	Pascal,Delphi
		function __ name ( params ) : type ; begin __ body __ end ;
else,a:series_of_statements
	Clojure
		:else __ a
	Fortran
		ELSE __ a
	Hack,E,ooc,EnglishScript,Mathematical notation,Dafny,Perl 6,Frink,Chapel,Katahdin,Pawn,PowerShell,Puppet,Ceylon,D,Rust,TypeScript,Scala,AutoHotKey,Gosu,Groovy,Java,Swift,Dart,AWK,JavaScript,Haxe,PHP,C#,Go,Perl,C++,C,Tcl,R,Vala,bc
		else { a }
	Ruby,Seed7,LiveCode,Janus,Lua,Haskell,CLIPS,MiniZinc,Julia,Octave,Picat,Pascal,Delphi,Maxima,OCaml,F#
		else __ a
	Erlang
		true -> a
	Wolfram,Prolog
		a
	Z3
		a:statement
	Python,Cython
		else : \\n #indent \\n b \\n #unindent
	Visual Basic .NET,Monkey X,VBScript
		Else __ a
	REBOL
		true [ a ]
	Common Lisp
		( t __ a )
	English
		otherwise __ a
	Polish notation
		else __ a
	Reverse Polish notation
		a __ else
true
	Java,LiveCode,GAP,Dafny,Z3,Perl 6,Chapel,C,Frink,Elixir,English,Pascal,MiniZinc,EngScript,Picat,Rust,Clojure,Nim,Hack,Ceylon,D,Groovy,CoffeeScript,TypeScript,Octave,Prolog,Julia,F#,Swift,Nemerle,Vala,C++,Dart,JavaScript,Ruby,Erlang,C#,Haxe,Go,OCaml,Lua,Scala,PHP,REBOL
		true
	Python,Pydatalog,Hy,Cython,AutoIt,Haskell,Visual Basic .NET,VBScript,Visual Basic,Monkey X,Wolfram,Delphi
		True
	Perl,AWK,Tcl
		1
	Racket
		#t
	Common Lisp
		t
	Fortran
		.TRUE.
	R,Seed7
		TRUE
false
	Java,LiveCode,GAP,Dafny,Z3,Perl 6,Chapel,C,Frink,Elixir,Pascal,Rust,MiniZinc,EngScript,Picat,Clojure,Nim,Groovy,D,Ceylon,TypeScript,CoffeeScript,Octave,Prolog,Julia,Vala,F#,Swift,C++,Nemerle,Dart,JavaScript,Ruby,Erlang,C#,Haxe,Go,OCaml,Lua,Scala,PHP,REBOL,Hack
		false
	Python,Pydatalog,Hy,Cython,AutoIt,Haskell,Visual Basic .NET,VBScript,Visual Basic,Monkey X,Wolfram,Delphi
		False
	Perl,AWK,Tcl
		0
	Common Lisp
		nil
	Racket
		#f
	Fortran
		.FALSE.
	Seed7,R
		FALSE
elif_or_else,a:statement
	Java,Seed7,Common Lisp,Octave,Picat,MiniZinc,Vala,Clojure,Monkey X,ooc,Ceylon,F#,Delphi,Perl 6,EnglishScript,Wolfram,Julia,OCaml,Maxima,Python,Cython,Erlang,Mathematical notation,REBOL,Scheme,Dart,JavaScript,TypeScript,C,C#,Haxe,PHP,Lua,Ruby,R,Fortran,Perl,C++,Visual Basic .NET,VBScript,Prolog,Scala,Rust,Go,Swift,Haskell,Z3
		a:(elif/else)
	Z3
		a:statement
elif,a:And,b:series_of_statements,c:elif_or_else
	D,E,Mathematical notation,Chapel,Pawn,Ceylon,Scala,TypeScript,AutoHotKey,AWK,R,Groovy,Gosu,Katahdin,Java,Swift,Nemerle,C,Dart,Vala,JavaScript,C#,C++,Haxe
		else __ if ( a ) { b } c
	Z3
		( ite __ a:Factor __ b:statement __ c )
	Rust,Go,EnglishScript
		else __ if __ a { b } c
	PHP,Hack,Perl
		elseif ( a ) { b } c
	Julia,Octave,Lua
		elseif __ a __ b __ c
	Monkey X
		ElseIf __ a __ b __ c
	Ruby,Seed7
		elsif __ a __ then __ b __ c
	Perl 6
		elsif __ a __ { b } c
	Picat
		elseif __ a __ then __ b __ c
	Erlang
		a -> b __ c
	Prolog
		a -> b ; __ c:statement
	R,F#
		a <- b __ c
	CLIPS
		( if __ a __ then __ ( b __ c ) )
	MiniZinc,OCaml,Haskell,Pascal,Maxima,Delphi,F#,LiveCode
		else __ if __ a __ then __ b __ c
	Prolog
		( a -> b ; c )
	Python,Cython
		elif __ a : \\n #indent \\n b \\n #unindent __ c
	Visual Basic .NET
		ElseIf __ a __ Then __ b __ c
	Fortran
		ELSE __ IF __ a __ THEN __ b __ c
	REBOL
		a [ b ] __ c
	Common Lisp
		( a __ b ) __ c
	Wolfram
		If [ a , b , c ]
	Polish notation
		elif __ a __ b __ c
	Reverse Polish notation
		a __ b __ c __ elif
	Clojure
		a:expression __ b:statement __ c:elif_or_else
return,a:expression,function_name:Identifier
	VBScript
		function_name = a
	Java,Seed7,XL,E,LiveCode,EnglishScript,Cython,GAP,Kal,EngScript,Pawn,Ada,PowerShell,Rust,D,Ceylon,TypeScript,Hack,AutoHotKey,Gosu,Swift,Pike,Objective-C,C,Groovy,Scala,CoffeeScript,Julia,Dart,C#,JavaScript,Go,Haxe,PHP,C++,Perl,Vala,Lua,Python,REBOL,Ruby,Tcl,AWK,bc,Chapel,Perl 6
		return __ a
	MiniZinc,Pydatalog,Polish notation,Reverse Polish notation,Mathematical notation,Emacs Lisp,Z3,Erlang,Maxima,Standard ML,Icon,Oz,CLIPS,newLisp,Hy,Sibilant,LispyScript,ALGOL 68,Clojure,Prolog,Common Lisp,F#,OCaml,Haskell,ML,Racket,Nemerle
		a
	Visual Basic,Visual Basic .NET,AutoIt,Monkey X
		Return __ a
	Octave,Fortran,Picat
		retval = a
	Pascal
		Exit ( a )
	R
		return ( a )
	Wolfram
		Return [ a ]
	POP-11
		a -> Result
	Delphi,Pascal
		Result = a
	SQL
		RETURN __ a
constraint,value:expression
	MiniZinc
		constraint __ value
	Z3,Prolog
		value
	Z3py
		solver . add ( value )
	Hampi
		assert __ value
set_var,name:(access_array/var_name),value:expression
	JavaScript,Mathematical notation,Perl 6,Wolfram,Chapel,Katahdin,Frink,Picat,ooc,D,Genie,Janus,Ceylon,IDP,Sympy,Prolog,Processing,Java,Boo,Gosu,Pike,Kotlin,Icon,PowerShell,EngScript,Pawn,FreeBASIC,Hack,Nim,OpenOffice Basic,Groovy,TypeScript,Rust,CoffeeScript,Fortran,AWK,Go,Swift,Vala,C,Julia,Scala,Cobra,Erlang,AutoIt,Dart,Java,OCaml,Haxe,C#,MATLAB,C++,PHP,Perl,Python,Lua,Ruby,Gambas,Octave,Visual Basic,Visual Basic .NET,bc
		name = value
	MiniZinc
		constraint __ name = value ;
	REBOL
		name : value
	Z3
		( assert ( = __ name __ value ) )
	GAP,Seed7,Delphi
		name := value
	LiveCode
		put __ expression __ into __ name
	VBScript
		Set __ a = b
print,a:expression
	OCaml
		print_string __ a
	MiniZinc
		trace ( a , true )
	Perl 6
		say __ a
	Erlang
		io : fwrite ( a )
	C++
		cout << a
	Haxe
		trace ( a )
	Go
		fmt . Println ( a )
	C#
		Console . WriteLine ( a )
	REBOL,Fortran,Perl,PHP
		print __ a
	Ruby
		puts ( a )
	Visual Basic .NET
		System . Console . WriteLine ( a )
	Scala,Julia,Swift,Picat
		println ( a )
	JavaScript,TypeScript
		console . log ( a )
	Python,EnglishScript,Cython,Ceylon,R,Gosu,Dart,Vala,Perl,PHP,Hack,AWK,Lua
		print ( a )
	Java
		System . out . println ( a )
	C
		printf ( a )
	Haskell
		( putStrLn __ a )
	Hy,Common Lisp,crosslanguage
		( print __ a )
	Rust
		println!( a )
	Octave
		disp ( a )
	Chapel,D,Seed7,prolog
		writeln ( a )
	Delphi
		WriteLn ( a )
	Frink
		print [ a ]
	Wolfram
		Print [ a ]
	Z3
		( echo __ a )
	Monkey X
		Print __ a
grammar_series_of_statements,var1:grammar_statement,var2:grammar_series_of_statements
	PEG.js,Yapps,Parboiled,Waxeye,Treetop,OMeta,Wirth syntax notation,Yacc,Pyparsing,EBNF,Nearley,ANTLR,Marpa,Parslet,Perl 6,Prolog,REBOL,ABNF
		var1 __ var2
	earley-parser-js,LPeg
		var1 , var2
series_of_statements,var1:statement,var2:(series_of_statements/statement)
	Pydatalog,Java,Racket,VBScript,Monkey X,LiveCode,Polish notation,Reverse Polish notation,Clojure,CLIPS,Common Lisp,Emacs Lisp,Scheme,Prolog,Dafny,Z3,Elm,Bash,Perl 6,Mathematical notation,Katahdin,Frink,MiniZinc,Aldor,COBOL,ooc,Genie,ECLiPSe,nools,Agda,PL/I,REXX,IDP,Falcon,Processing,Sympy,Maxima,Pyke,Elixir,GNU Smalltalk,Seed7,Standard ML,Occam,Boo,Drools,Icon,Mercury,EngScript,Pike,Oz,Kotlin,Pawn,FreeBASIC,Ada,PowerShell,Gosu,Nim,Cython,OpenOffice Basic,ALGOL 68,D,Ceylon,Rust,CoffeeScript,ActionScript,TypeScript,Fortran,Octave,ML,AutoHotKey,Delphi,Pascal,F#,Self,Swift,Nemerle,Dart,C,AutoIt,Cobra,Julia,Groovy,Scala,OCaml,Gambas,Hack,C++,MATLAB,REBOL,Red,Lua,Go,AWK,Haskell,Perl,Python,JavaScript,C#,PHP,Ruby,R,Haxe,Visual Basic,Visual Basic .NET,Vala,bc
		var1 __ var2
	Wolfram
		var1 ; var2
	EnglishScript,Python
		var1 \\n var2
	Picat,Prolog,Erlang,LPeg
		var1 , var2
class_statements,var1:class_statement,var2:class_statements
	Java,Perl 6,Scala,Julia,Python,Dart,C#,Ruby,C++,JavaScript,TypeScript,Visual Basic .NET,PHP,Haxe,Visual Basic .NET,Swift
		var1 __ var2
class_statement,a:(constructor/static_method/instance_method)
	Java,Julia,C#,Visual Basic .NET,Ruby,PHP,C++,Haxe,Swift,Dart,Python
		a:(constructor/static_method/instance_method/initialize_static_variable/initialize_instance_variable/initialize_instance_variable_with_value/initialize_static_variable_with_value)
	JavaScript,TypeScript
		a
comment,var1:[^\\n]+
	Java,Dafny,Janus,Chapel,Rust,Frink,D,Genie,Ceylon,Hack,Maxima,Kotlin,Delphi,Dart,TypeScript,Swift,Vala,C#,JavaScript,Haxe,Scala,Go,C,C++,Pike,PHP,F#,Nemerle,crosslanguage,Gosu,Groovy
		// var1 \\n
	OCaml,Standard ML,ML
		(*{ var1 _ }*)
	MATLAB,MiniZinc,Octave,Erlang,Prolog,Picat
		% var1 \\n
	REBOL
		comment [ var1 ]
	Wolfram
		(* var1 _ *)
	Pascal
		{ var1 _ }
	Fortran
		! var1 \\n
	Z3
		; var1 \\n
	Bash,Perl 6,PowerShell,Seed7,Cobra,Icon,EngScript,Nim,CoffeeScript,Julia,AWK,Ruby,Perl,R,Tcl,bc,Python,Cython
		# var1 \\n
	Lua,Haskell,Ada,Transact-SQL,SQL
		-- var1 \\n
	Gambas,Visual Basic,Visual Basic .NET,Monkey X,VBScript
		' var1 \\n
initialize_var,name:var_name,type:type,value:expression
	Polish notation
		= __ name __ value
	Reverse Polish notation
		name __ value __ =
	Go
		var __ name __ type = value
	Rust
		let __ mut __ name = value
	Dafny
		var name : type := value
	Z3
		( declare-const __ name __ type ) ( assert __ ( = __ name __ value ) )
	F#
		let __ mutable __ name = value
	Common Lisp
		( setf __ name __ value )
	MiniZinc
		type : name = value ;
	Python,Ruby,Haskell,Erlang,Prolog,Julia,Picat,Octave,Wolfram
		name = value
	JavaScript,Hack,Swift
		var __ name = value
	Lua
		local __ name = value
	Janus
		local __ type __ name = value
	Perl
		my __ name = value
	Perl 6
		my __ type __ name = value
	C,Java,C#,C++,D,Dart,EnglishScript,Ceylon,Vala
		type __ name = value
	REBOL
		name : value
	Visual Basic,Visual Basic .NET,OpenOffice Basic
		Dim __ name __ As __ type = value
	R
		name <- value
	Fortran
		type :: name = value
	Chapel,Haxe,Scala,TypeScript
		var __ name : type = value
	Monkey X
		Local __ name : type = value
	VBScript
		Dim __ name __ Set __ name = value
	Seed7
		var __ type : name __ is __ value
typeless_initialize_var,name:var_name,value:expression
	Monkey X
		Local __ name = value
	Rust
		let __ mut __ name = value
	R
		name <- value
	C++,D
		auto __ name = value
	C#,Dafny,JavaScript,Haxe,PHP,TypeScript,Dart,Swift,Scala,Go,Vala
		var __ name = value
	Lua
		local __ name = value
	Python,Ruby,Haskell,Erlang,Prolog,Julia,Picat,Octave,PHP,Wolfram
		name = value
	C
		__auto_type __ name = value
	Java
		Object __ name = value
	C#,JavaScript,Haxe,Swift
		var __ name = value
	Perl,Perl 6
		my __ name = value
	REBOL
		name : value
	Visual Basic .NET
		Dim __ name = value
	VBScript
		Dim __ name __ Set __ name = value
	Polish notation
		= __ name __ value
	Reverse Polish notation
		name __ value __ =
int,t1:type
	Hack,Transact-SQL,Dafny,Janus,Chapel,MiniZinc,EngScript,Cython,ALGOL 68,D,Octave,Tcl,crosslanguage,ML,AWK,Julia,Gosu,OCaml,F#,Pike,Objective-C,Go,Cobra,Dart,Groovy,Python,Hy,Java,C#,C,C++,Vala,Nemerle,crosslanguage
		int
	PHP,Common Lisp,Picat
		integer
	Fortran
		INTEGER
	REBOL
		integer!
	Ceylon,Gambas,OpenOffice Basic,Pascal,Erlang,Delphi,Visual Basic,Visual Basic .NET
		Integer
	Haxe,ooc,Swift,Scala,Perl 6,Z3,Monkey X
		Int
	JavaScript,TypeScript,CoffeeScript,Lua,Perl
		number
	Haskell
		Num
	Ruby
		fixnum
char
	Java,C,C++,Seed7,C#
		char
	Visual Basic .NET,Haskell
		Char
	Swift
		Character
	REBOL
		char!
	Fortran
		CHARACTER
	Go
		rune
string
	Z3,Java,Ceylon,Gambas,Dart,Gosu,Groovy,Scala,Pascal,Swift,Ruby,Haxe,Haskell,Visual Basic,Visual Basic .NET,Monkey X
		String
	Vala,Seed7,Octave,Picat,Mathematical notation,Polish notation,Reverse Polish notation,Prolog,D,crosslanguage,Chapel,MiniZinc,Genie,Hack,Nim,ALGOL 68,TypeScript,CoffeeScript,Octave,Tcl,AWK,Julia,C#,F#,Perl,Lua,JavaScript,Go,PHP,C++,Nemerle,Erlang
		string
	C
		char*
	REBOL
		string!
	Fortran
		CHARACTER ( LEN = * )
	Python,Hy
		str
void
	EngScript,Seed7,PHP,Hy,Cython,Go,Pike,Objective-C,Java,C,C++,C#,Vala,TypeScript,D,JavaScript,Lua,Dart
		void
	Haxe,Swift
		Void
	Scala
		Unit
boolean
	TypeScript,Seed7,Python,Hy,Java,JavaScript,Lua,Perl
		boolean
	C++,Nim,Octave,Dafny,Chapel,C,crosslanguage,Rust,MiniZinc,EngScript,Dart,D,Vala,crosslanguage,Go,Cobra,C#,F#,PHP,Hack
		bool
	Haxe,Haskell,Swift,Julia,Perl 6,Z3,Z3py,Monkey X
		Bool
	Fortran
		LOGICAL
	Visual Basic,OpenOffice Basic,Ceylon,Delphi,Pascal,Scala,Visual Basic .NET
		Boolean
	REBOL
		logic!
double
	Java,C,C#,C++,Dart,Vala
		double
	Go
		float64
	Haxe
		Float
	JavaScript,Lua
		number
	Ruby,MiniZinc,PHP,Python
		float
	Visual Basic .NET,Swift
		Double
	Haskell
		Num
	REBOL
		decimal!
	Fortran
		double __ precision
	Z3,Z3py
		Real
	Octave
		scalar
if,c:elif_or_else,b:series_of_statements,a:expression
	Erlang
		if __ a -> b:statement __ c __ end
	Fortran
		IF __ a __ THEN __ b __ c __ END __ IF
	REBOL
		case [ a [ b ] c ]
	Julia
		if __ a __ b __ c __ end
	Lua,Ruby,Picat
		if __ a __ then __ b __ c __ end
	Octave
		if __ a __ b __ c __ endif
	Haskell,Pascal,Delphi,Maxima,OCaml
		if __ a __ then __ b __ c
	LiveCode
		if __ a __ then __ b __ c __ end __ if
	Java,E,ooc,EnglishScript,Mathematical notation,Polish notation,Reverse Polish notation,Perl 6,Chapel,Katahdin,Pawn,PowerShell,D,Ceylon,TypeScript,ActionScript,Hack,AutoHotKey,Gosu,Nemerle,Swift,Nemerle,Pike,Groovy,Scala,Dart,JavaScript,C#,C,C++,Perl,Haxe,PHP,R,AWK,Vala,bc,Squirrel
		if ( a ) { b } c
	Rust,Go
		if __ a { b } c
	Visual Basic,Visual Basic .NET
		If __ a __ b __ c
	CLIPS
		( if __ a __ then __ b __ c )
	Z3
		( ite __ a __ b:statement __ c )
	MiniZinc
		if __ a __ then __ b __ c __ endif
	Python,Cython
		if __ a : \\n #indent \\n b \\n #unindent \\n c
	Prolog
		( a -> b ; c )
	Visual Basic
		If __ a __ Then __ b __ c __ End __ If
	Common Lisp
		( cond ( a __ b ) __ c )
	Wolfram
		If [ a , b , c ]
	Polish notation
		if __ a __ b
	Reverse Polish notation
		a __ b __ if
	Monkey X
		if __ a __ b __ c __ EndIf
foreach,array:expression,var_name:var_name,typeInArray:type,body:series_of_statements
	Seed7
		for __ var_name __ range __ array __ do __ body __ end __ for;
	JavaScript,TypeScript
		array . forEach ( function ( var_name ) { body  } ) ;
	Octave
		for __ var_name = array __ body __ endfor
	Z3
		( forall __ ( ( var_name __ a ) ) __ ( => select __ array ) )
	GAP
		for __ var_name __ in __ array __ do __ body __ od;
	MiniZinc
		forall ( var_name __ in __ array ) ( body )
	PHP,Hack
		foreach ( array __ as __ var_name ) { body }
	Java
		for ( typeInArray __ var_name : array ) { body }
	C#,Vala
		foreach ( typeInArray __ var_name __ in __ array ) { body }
	Lua
		for __ var_name __ in __ array __ do __ body __ end
	Python,Cython
		for __ var_name __ in __ array : \\n #indent \\n body \\n #unindent
	Julia
		for __ var_name __ in __ array __ body __ end
	Chapel,Swift
		for __ var_name __ in __ array { body }
	Pawn
		foreach ( new __ var_name : array ) { body }
	Picat
		foreach ( var_name __ in __ array ) __ body __ end
	Picat
		foreach ( var_name __ in __ array ) ( body ) end
	AWK,Ceylon
		for __ ( __ var_name __ in __ array ) { body }
	Go
		for __ var_name := range __ array { body }
	Haxe,Groovy
		for ( var_name __ in __ array ) { body }
	Ruby
		array . each __ do | var_name | __ body __ end
	Nemerle,PowerShell
		foreach ( var_name __ in __ array ) { body }
	Scala
		for ( var_name -> array ) { body }
	REBOL
		foreach __ var_name __ array [ body ]
	C++
		for ( typeInArray __ & __ var_name : array ){ body }
	Perl
		foreach __ var_name ( array ) { body }
	D
		foreach ( var_name , array ) { body }
	Gambas
		FOR __ EACH __ var_name __ IN __ array __ body __ NEXT
	Visual Basic .NET
		For __ Each __ var_name __ As __ typeInArray __ In __ array __ body __ Next
	VBScript
		For __ Each __ var_name __ In __ array __ body __ Next
	Dart
		for ( var __ var_name __ in __ array ) { body }
	Perl
		for __ array -> var_name { body }
compare_ints,var1:Add,var2:Add
	R
		identical ( var1 , var2 )
	Lua,Nim,Z3Py,Pydatalog,E,Ceylon,Perl 6,EnglishScript,Cython,Mathematical notation,Dafny,Wolfram,D,Rust,R,MiniZinc,Frink,Picat,Pike,Pawn,Processing,C++,Ceylon,CoffeeScript,Octave,Swift,AWK,Julia,Perl,Groovy,Erlang,Haxe,Scala,Java,Vala,Dart,Python,C#,C,Go,Haskell,Ruby
		var1 == var2
	JavaScript,PHP,TypeScript,Hack
		var1 === var2
	Z3,Emacs Lisp,Common Lisp,CLIPS,Racket
		( = __ var1:Factor __ var2:Factor )
	Fortran
		var1 .eq. var2
	Maxima,Seed7,Monkey X,GAP,REBOL,F#,AutoIt,Pascal,Delphi,Visual Basic,Visual Basic .NET,OCaml,LiveCode,VBScript
		var1 = var2
	Prolog
		var1 =:= var2
	Clojure
		( = __ a __ b )
	Reverse Polish notation
		a __ b __ =
	Polish notation
		= __ a __ b
class,name:Identifier,body:class_statements
	Julia
		type __ name __ body __ end
	C,Z3,Lua,Prolog,Haskell,MiniZinc,R,Go,REBOL,Fortran
		body:function
	Java,C#
		public __ class __ name { body }
	C++
		class __ name { body } ;
	JavaScript,Hack,PHP,Scala,Haxe,Chapel,Swift,D,TypeScript,Dart,Perl 6
		class __ name { body }
	Ruby
		class __ name __ body __ end
	Visual Basic .NET
		Public __ Class __ name __ body __ End __ Class
	VBScript
		Public __ Class __ name __ body __ End __ Class
	Python
		class __ name : \\n #indent \\n body \\n #unindent
	Monkey X
		Class __ name __ body __ End
class_extends,c1:Identifier,c2:Identifier,b:class_statements
	Python
		class __ c1 ( c2 ) : \\n #indent \\n b \\n #unindent
	Visual Basic .NET
		Public __ Class __ c1 __ Inherits __ c2 __ b __ End __ Class
	Swift,Chapel,D,Swift
		class __ c1 : c2 { b }
	Haxe,PHP,JavaScript,Dart,TypeScript
		class __ c1 __ extends __ c2 { b }
	Java,C#,Scala
		public __ class __ c1 __ extends __ c2 { b }
	C
		#include __ ' c2 .h' __ b
	C++
		class __ c1 : public __ c2 { b }
	Ruby
		class __ c1 __ < __ c2 __ b __ end
	Perl 6
		class __ c1 __ is __ c2 { b }
	Monkey X
		Class __ c1 __ Extends __ c2 __ b __ End
function_parameter,type:type,name:var_name
	Seed7
		in __ type : name
	C#,Java,EnglishScript,Ceylon,ALGOL 68,Groovy,D,C++,Pawn,Pike,Vala,C,Janus
		type __ name
	Haxe,Dafny,Chapel,Pascal,Rust,Genie,Hack,Nim,TypeScript,Gosu,Delphi,Nemerle,Scala,Swift
		name : type
	Go,SQL
		name __ type
	MiniZinc
		var __ type : name
	Haskell,Polish notation,Reverse Polish notation,Scheme,Python,Mathematical notation,LispyScript,CLIPS,Clojure,F#,ML,Racket,OCaml,Tcl,Common Lisp,newLisp,Python,Cython,Frink,Picat,IDP,PowerShell,Maxima,Icon,CoffeeScript,Fortran,Octave,AutoHotKey,Prolog,AWK,Kotlin,Dart,JavaScript,Nemerle,Erlang,PHP,AutoIt,Lua,Ruby,R,bc
		name
	Julia
		name :: type
	REBOL
		type [ name ]
	OpenOffice Basic,Gambas
		name __ As __ type
	Visual Basic,Visual Basic .NET
		name __ as __ type
	Perl
		name = push ;
	Wolfram
		name \_
	Z3
		( name __ type )
switch,a:expression,b:case_statements,c:default
	crosslanguage
		( switch __ a __ b __ c )
	Rust
		match __ a { b __ c }
	OCaml
		match __ a __ with
	Elixir
		case __ a __ do __ b __ c __ end
	Scala
		a __ match { b __ c }
	Octave
		switch ( a ) b __ endswitch
	Java,D,PowerShell,Nemerle,D,TypeScript,Hack,Swift,Groovy,Dart,AWK,C#,JavaScript,C++,PHP,C,Go,Haxe,Vala
		switch ( a ) { b __ c }
	Ruby
		case __ a __ b __ c __ end
	Haskell,Erlang
		case __ a __ of __ b __ c __ end
	Delphi,Pascal
		Case __ a __ of __ b __ c __ end;
	CLIPS
		( switch __ a __ b __ c )
	Visual Basic .NET,Visual Basic
		Select __ Case __ a __ b __ c __ End __ Select
	REBOL
		switch/default [ a __ b ]
	Fortran
		SELECT __ CASE ( a ) __ b __ c __ END __ SELECT
	Clojure
		( case __ a __ b __ c )
	Chapel
		select ( a ) { b c }
	Wolfram
		Switch [ a , b , c ]
case,a:expression,b:series_of_statements
	crosslanguage
		( case __ a __ b )
	JavaScript,D,Java,C#,C,C++,TypeScript,Dart,PHP,Hack
		case __ a : b break ;
	Go,Haxe,Swift
		case __ a : b
	Fortran
		CASE ( a ) __ b
	Rust
		a => { b }
	Ruby
		when __ a __ b
	Haskell,Erlang,Elixir,OCaml
		a -> b
	CLIPS
		( case __ a __ then __ b )
	Scala
		case __ a => b
	Visual Basic .NET
		Case __ a __ b
	REBOL
		a [ b ]
	Octave
		case __ a __ b
	Clojure
		( a __ b )
	Pascal,Delphi:
		a : b
	Chapel
		when __ a { b }
	Wolfram
		a , b
access_array,a:Identifier,b:(array_access_index/array_access_list)
	Python,Lua,C#,Julia,D,Swift,Julia,Janus,MiniZinc,Picat,Nim,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		a [ b ]
	Scala,Octave,Fortran,Visual Basic,Visual Basic .NET
		a ( b )
	Haskell
		( a !! b )
	Frink
		a @ b
	Z3
		( select __ a __ b:expression )
	REBOL
		a / b
array_access_list,var1:array_access_index,var2:array_access_list,separator:array_access_separator
	Java,Perl 6,Octave,Picat,Julia,Go,C#,Lua,C++,Python,JavaScript,C,PHP,Ruby,Scala,Haxe,Fortran,TypeScript,MiniZinc,Dart,Visual Basic .NET,Perl,Swift,Haskell,REBOL
		var1 separator var2
array_access_separator
	C#,MiniZinc,Fortran,Julia,Visual Basic,Visual Basic .NET,Octave
		,
	Python,Pydatalog,D,Lua,Picat,Janus,Nim,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C,Swift
		][
	Haskell
		!!
	Scala
		)(
	Frink
		@
	REBOL
		/
	Perl 6
		;
array_access_index,a:expression
	Lua,MiniZinc,REBOL
		a:array_access_index_2
	Haskell,Perl 6,D,Frink,C#,Visual Basic,Janus,Visual Basic .NET,Scala,Octave,Fortran,Python,Swift,Julia,Picat,Nim,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		a:array_access_index_1
array_access_index_1,a:expression
	Lua,MiniZinc,REBOL
		a + 1
	Haskell,Perl 6,D,Frink,C#,Visual Basic,Janus,Visual Basic .NET,Scala,Octave,Fortran,Python,Swift,Julia,Picat,Nim,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		a
array_access_index_2,a:expression
	Lua,MiniZinc,REBOL
		a
	Haskell,Perl 6,D,Frink,C#,Visual Basic,Janus,Visual Basic .NET,Scala,Octave,Fortran,Python,Swift,Julia,Picat,Nim,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		a - 1
initialize_static_variable,type:type,name:var_name
	Swift
		static __ var __ name
	Java,C#
		public __ static __ type __ name
	PHP
		public __ static __ name
	C++,Dart
		static __ type __ name
	Python
		_
	Haxe
		static __ var __ name : type
	Ruby
		__
	Visual Basic .NET
		Public __ Shared __ name __ As __ type
initialize_static_variable_with_value,type:type,name:var_name,value:expression
	Swift
		static __ var __ name = value
	Java,C#
		public __ static __ type __ name = value
	PHP
		public __ static __ name = value
	C++,Dart
		static __ type __ name = value
	Python
		name = value
	Ruby
		@@ name = type
	Haxe
		static __ var __ name : type = value
	Visual Basic .NET
		Public __ Shared __ name __ As __ type = value
default,a:series_of_statements
	Fortran
		CASE __ DEFAULT __ a
	crosslanguage
		( default __ a )
	JavaScript,D,C,Java,C#,C++,TypeScript,Dart,PHP,Haxe,Hack,Go,Swift
		default : a
	Ruby,Pascal,Delphi
		else __ a
	Haskell,Erlang,OCaml
		\_ -> __ a
	Rust
		\_ => a
	CLIPS
		( default __ a )
	Scala
		case __ \_ => a
	Visual Basic .NET
		Case __ Else __ a
	REBOL
		][ a
	Octave
		otherwise __ a
	Chapel
		otherwise { a }
	Clojure
		a
	Wolfram
		\_ , a
`.split("\n");
var current_function;
var current_language_list;
for(var i = 0; i < string_to_dict.length; i++){
	if(string_to_dict[i].lastIndexOf("		", 0) === 0){
		string_to_dict[i] = string_to_dict[i].substring(2);
		thePatterns[current_function][current_language_list] = string_to_dict[i];
	}
	else if(string_to_dict[i].lastIndexOf("	", 0) === 0){
		string_to_dict[i] = string_to_dict[i].substring(1);
		current_language_list = string_to_dict[i];
		thePatterns[current_function][string_to_dict[i]] = {};
	}
	else{
		thePatterns[string_to_dict[i]] = {};
		current_function = string_to_dict[i];
	}
}


for(var current in thePatterns){
	if(current.indexOf(",") !== -1){
		var current1 = current.split(",");
		var listOfVariables = [];
		for(var i = 0; i < current1.length; i++){
			if(current1[i].indexOf(":") !== -1){
				listOfVariables.push(current1[i].split(":")[0]);
			}
		}
		for(var i in thePatterns[current]){
			thePatterns[current][i] = thePatterns[current][i].split(" ");
			var stringToReturn;
			for(var j = 0; j < thePatterns[current][i].length; j++){
				var theIndex = listOfVariables.indexOf(thePatterns[current][i][j]);
				//console.log(theIndex)
				if(theIndex !== -1){
					thePatterns[current][i][j] = current1[theIndex+1];
				}
				if(j === 0){
					stringToReturn = thePatterns[current][i][0];
					if(thePatterns[current][i].length > 2 && thePatterns[current][i][1] !== "_" && thePatterns[current][i][1] !== "__"){
						stringToReturn += " _"
					}
				}
				else{
					stringToReturn += " " + thePatterns[current][i][j]
					if(j < thePatterns[current][i].length-1){
						if(thePatterns[current][i][j+1] !== "__" && thePatterns[current][i][j+1] !== "_" && thePatterns[current][i][j] !== "__" && thePatterns[current][i][j] !== "_"){
							stringToReturn += " _"
						}
					}
				}
			}
			thePatterns[current][i] = stringToReturn;
		}
		thePatterns[current1[0]] = thePatterns[current];
		delete thePatterns[current];
		//console.log(JSON.stringify(thePatterns[current]));
	}
}
//throw(JSON.stringify(thePatterns));
pattern_to_input();
throw("done");

function getOtherLangs(pattern, lang){
	for(current in thePatterns){
		for(current1 in thePatterns[current]){
			if(current.split(",")[0] === pattern){
				if(acs(lang, current1)){
					return current1;
				}
			}
		}
	}
}

function typeInference(parseTree){
	console.log(JSON.stringify(parseTree));
	return parseTree;
}

function generateCode(parseTree, outputLang){
	if(typeof(parseTree) === "string"){
		return parseTree;
	}
	var d = {};
	for(var current in parseTree[1]){
		d[current] = generateCode(parseTree[1][current], outputLang);
	}
	switch(parseTree[0]){
		case "string_literal":
			return "\"" + d.var1 + "\"";
		break;
		case "parameters":
			if(acs(outputLang,"JavaScript,Dafny,Wolfram,Gambas,D,Frink,Chapel,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET")){
				return d.var1 +","+ d.var2;
			}
			else if(acs(outputLang, "Hy,Z3,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure")){
				return d.var1 +" "+d.var2;
			}
			else{
				alert("Something's wrong with the parameters!");
			}
		break;
		case "compare_ints":
			var toReturn = pattern_to_output(d,"compare_ints",outputLang);
			if(!acs(outputLang, "Racket,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript")){
				return "(" + toReturn +")";
			}
			return toReturn;
		break;
		case "type":
			if(d.var2 === undefined){
				return d.var1;
			}
			else
				return d.var1 + d.var2;
		case "array_type_suffix":
			if(d.var2 === undefined){
				return d.var1;
			}
			else
				return d.var1 + d.var2;
		case undefined:
			throw JSON.stringify(parseTree);
		default:
			return pattern_to_output(d,parseTree[0],outputLang);
	}
	
	var keys = [];
	for(var k in parseTree[1]) keys.push(k);
	throw parseTree[0] + " is not yet defined for " + outputLang + " with keys " + keys.join(",")
}

	function get_dictionary(name){
		var toReturn = {};
		for(var current of list_of_languages){
		if(list_of_grammar_notations.indexOf(current) === -1){
			if(name === "less_than_or_equal"){
				toReturn[current] = pattern_to_input('less_than_or_equal', current) + ' / greater_than_or_equal';
			}
			else if(name === "And"){
				toReturn[current] = pattern_to_input('And', current) + ' / Or';
			}
			else if(name === "greater_than_or_equal"){
				toReturn[current] = pattern_to_input('greater_than_or_equal', current) + ' / compare_ints';
			}
			else if(name === 'greater_than'){
				toReturn[current] = pattern_to_input('greater_than', current) + ' / less_than';
			}
			else if(name === 'compare_ints'){
				toReturn[current] = pattern_to_input('compare_ints', current) + ' / Add';
			}
			else if(name === 'less_than'){
				toReturn[current] = pattern_to_input('less_than', current) + ' / less_than_or_equal';
			}
			else if(name === 'concatenate_string'){
				toReturn[current] = pattern_to_input('concatenate_string', current) + ' / Multiply';
			}
		}
		else{ //it is a grammar notation
			if(name === 'grammar_concatenate_string'){
				toReturn[current] = pattern_to_input('grammar_concatenate_string', current) + ' / Factor';
			}
			else if(name === 'concatenate_string'){
				toReturn[current] = 'concatenate_string = grammar_concatenate_string';
			}
			else if(name === 'statement'){
				toReturn[current] = 'statement = grammar_statement';
			}
			else if(name === 'grammar_Or'){
				toReturn[current] = pattern_to_input('grammar_Or', current) + ' / grammar_concatenate_string';
			}
			else if(name === 'grammar_series_of_statements'){
				toReturn[current] = pattern_to_input('grammar_series_of_statements', current) + ' / grammar_statement';
			}
		}
		}
		//console.log(JSON.stringify(toReturn));
		return toReturn;
	}
	
	var output_dict = {
		'Main':{
			[getOtherLangs('series_of_statements', 'Java')]:
				'Main = _ var1:series_of_statements _ {return var1;} / _',
			[list_of_grammar_notations.join(',')]:
				'Main = _ var1:grammar _ {return var1;} / _',
			[getOtherLangs('series_of_statements', 'Picat')]:
				'Main = _ var1:series_of_functions _ {return var1;} / _',
		},
		'exception':{
			'C,Go,Fortran,Lua,MiniZinc':'exception = initialize_var',
		},
		'class_extends':{
			'Go,C,Fortran,REBOL,Lua':'class_extends = function',
		},
		'dictionary':{
			'C,Fortran':'dictionary = Identifier'
		},
		'join':{
			'C':'join = Integer',
		},
		'statement_with_semicolon':{
			
		},
		'statement':
			get_dictionary('statement'),
		'grammar_concatenate_string':
			get_dictionary('grammar_concatenate_string'),
		'foreach':{
			'C':'foreach = for',
		},
		'int_to_string':{
			'C,Fortran,Picat':'int_to_string = Integer',
		},
		'initialize_empty_vars_1':{
			'C,Java,C#,C++,Swift':'initialize_empty_vars_1 = var_name / var_name _ "," _ initialize_empty_vars_1',
		},
		'split':{
			'C,C++,Prolog,Erlang,Fortran,Z3,MiniZinc':'split = Integer',
		},
		'instance_method':{
			'C':'instance_method = function',
		},
		'typeless_instance_method':{
			'C':'typeless_instance_method = function',
		},
		'typeless_static_method':{
			'C':'typeless_static_method = function',
		},
		'case_statements':{
			'Java,C,C#,C++,JavaScript,PHP,Haxe,Fortran,Go':
				'case_statements = a:case _ b:case_statements {return ["case_statements", {a:a, b:b}]} / case',
		},
		'switch':{
			'Lua,Python,R,Julia,Python':
				'switch = if',
		},
		'default':{
			'Lua,Python,R,Julia':
				'',
		},
		'foreach':{
			'Fortran':
				'foreach = while',
		},
		'series_of_statements':{
			[getOtherLangs("series_of_statements", 'Java')]:
				pattern_to_input("series_of_statements", "Java") + " / statement",
			[getOtherLangs("series_of_statements", "Picat")]:
				pattern_to_input("series_of_statements", "Picat") +" / statement",
			'Wolfram':
				pattern_to_input("series_of_statements", "Wolfram") +" / statement",
		},
		'multiline_comment':{
			'Java,Scala,JavaScript,C,C#,PHP,C++,Haxe,TypeScript,Dart,Swift,Go,Picat':
				'multiline_comment = "/*" var1:((!("*/" / "/*") .)+) "*/" {return ["comment", {var1:text(var1)}];}',
			'Octave':
				'multiline_comment = "\\n" _ "#{" _ "\\n" var1:((!("#{" / "#}") .)+) "\\n" _ "#}" _ "\\n" {return ["comment", {var1:text(var1)}];}',
			'Z3,Lua,Ruby,R,Fortran,Visual Basic .NET,REBOL,Perl,Erlang':
				'multiline_comment = comment',
			'Haskell':
				'multiline_comment = "{-|" var1:((!("{-|" / "-}") .)+) "-}" {return ["comment", {var1:text(var1)}];}',
			'Julia':
				'multiline_comment = "#=" var1:((!("{#=" / "=#") .)+) "=#" {return ["comment", {var1:text(var1)}];}',
			'Perl':
				'multiline_comment = "=begin comment\\n" var1:((!("=begin comment" / "end_comment" / "=cut") .)+) "=end comment\\n=cut\\n"',
			'Python':
				"multiline_comment = \"'''\" var1:((!(\"'''\") .)+) \"'''\"",
		},
		'function_parameters':{
			[getOtherLangs('function_parameters', 'Java')]:
				pattern_to_input('function_parameters', 'Java') + ' / function_parameter / _ {return "";}',
			[getOtherLangs('function_parameters', 'Haskell')]:
				pattern_to_input('function_parameters', 'Haskell') + ' / function_parameter / _ {return "";}',
		},
		'while':{
			"Z3":
				"",
			"Lua,Ruby,Julia":
				'while = "while" (_ "(" _ condition:Or _ ")" / __ condition:Or) __ body:series_of_statements __ "end" {return ["while", {condition:condition, body:body}]}',

		},
		'expression':{
			'Picat,Erlang,Octave,MiniZinc,VBScript,Perl 6,Scala,Julia,OCaml,Mathematical notation,Polish notation,Reverse Polish notation,REBOL,Haskell,Visual Basic .NET,PHP,Ruby,Lua,C++,Haxe,Java,JavaScript,C#,Dart,Perl,Go,Swift,C,Fortran,Python':
				'expression = And',
			'Z3,CLIPS,Emacs Lisp,Common Lisp,Clojure,Scheme,Racket,newLisp':
				'expression = Factor',
		},
		'And':
			get_dictionary('And'),
		'Or':{
			[getOtherLangs('Or', 'JavaScript')]:
				pattern_to_input('Or', "JavaScript") + ' / greater_than',
			[getOtherLangs('Or', 'Python')]:
				pattern_to_input('Or', "Python") + ' / greater_than',				
			"PHP":
				'Or = var1:greater_than (_ "||" _ / __ "or" __) var2:Or {return ["Or", {var1:var1, var2:var2}]} / greater_than',
			[getOtherLangs('Or', 'Z3')]:
				pattern_to_input('Or', "Z3") + ' / greater_than',
			[getOtherLangs('Or', 'Fortran')]:
				pattern_to_input('Or', "Fortran") + ' / greater_than',
			[getOtherLangs('Or', 'MiniZinc')]:
				pattern_to_input('Or', "MiniZinc") + ' / greater_than',
			[getOtherLangs('Or', 'Visual Basic .NET')]:
				pattern_to_input('Or', "Visual Basic .NET") + ' / greater_than',
		},
		'greater_than':
			get_dictionary('greater_than'),
		'less_than':
			get_dictionary('less_than'),
		'less_than_or_equal':
			get_dictionary('less_than_or_equal'),
		'greater_than_or_equal':
			get_dictionary('greater_than_or_equal'),
		'compare_ints':
			get_dictionary('compare_ints'),
		'Add':{
			[getOtherLangs('Add', 'Java')]:
				pattern_to_input('Add', 'Java') + ' / concatenate_string',
			[getOtherLangs('Add', 'Z3')]:
				pattern_to_input('Add', 'Z3') + ' / concatenate_string',
		},
		'concatenate_string':
			get_dictionary('concatenate_string'),
		'Multiply':{
			[getOtherLangs('Multiply', 'Java')]:
				pattern_to_input('Multiply', 'Java') + ' / Factor',
			[getOtherLangs('multiply', 'Z3')]:
				pattern_to_input('Multiply', 'Z3') + ' / Factor',
		},
		'dot_notation':{
			[getOtherLangs('dot_notation', 'Java')]:
				'dot_notation = var1:Identifier "." var2:dot_notation {return ["dot_notation", {var1:var1, var2:var2}];} / Identifier',
			[getOtherLangs('dot_notation', 'PHP')]:
				'dot_notation = var1:Identifier "->" var2:dot_notation {return ["dot_notation", {var1:var1, var2:var2}];} / Identifier',
			'Z3,Erlang,R,Prolog,Haskell,Picat,Polish notation,Reverse Polish notation,MiniZinc':
				"dot_notation = Identifier",
		},
		'function_call':{
			[getOtherLangs('function_call', 'C')]:
				'function_call = theName:Identifier _ "(" _ args:( function_call_parameters / _ ) _ ")" {return ["function_call", {theName:theName, args:args}]}',
			[getOtherLangs('function_call', 'Z3')]:
				'function_call = "(" theName:Identifier __ args:( function_call_parameters / _ ) _ ")" {return ["function_call", {theName:theName, args:args}]}',
		},
		'parentheses_expression':{
			'Pascal,Perl 6,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nim,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET':
				'parentheses_expression = string_literal / "(" var1:expression ")" {return ["parentheses_expression", {"a":var1}];} / function_call / dot_notation'
		},
		'function_call_parameters':{
			'JavaScript,Wolfram,D,Frink,Delphi,EngScript,Chapel,Perl,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET':
				'function_call_parameters = (var1:(function_call_named_parameter/expression) _ "," _ var2:function_call_parameters) {return ["function_call_parameters", {var1:var1, var2:var2}]} / (function_call_named_parameter/expression)',
			'Hy,Polish notation,Reverse Polish notation,crosslanguage,Coq,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure,Z3':
				'function_call_parameters = (var1:(function_call_named_parameter/expression) __ var2:function_call_parameters) {return ["function_call_parameters", {var1:var1, var2:var2}]} / (function_call_named_parameter/expression)',
		},
		'this':{
			'Lua,C,Fortran,Picat,Go,Octave':'this = Identifier'
		},
		'anonymous_function':{
			'C,C#,Fortran,Perl':'anonymous_function = set_var'
		},
		'initialize_static_variable':{
			'JavaScript':'',
		},
		'initialize_static_variable_with_value':{
			'JavaScript':'',
		},
		'sin':{
			'Z3':'sin = Integer'
		},
		'cos':{
			'Z3':'cos = Integer'
		},
		'tan':{
			'Z3':'tan = Integer'
		},
		'Factor':{
			"Java,Octave,Scala,Julia,Python,Picat,Haxe,JavaScript,TypeScript,Dart,C,C++,PHP,Lua,Ruby,R,Lua,Visual Basic .NET,Perl,Rust,Go,Swift,REBOL,Fortran":
				'Factor = anonymous_function / this / not / dictionary / initializer_list / access_array / string_to_int / int_to_string / strcmp / not_equal / function_call / charAt / strlen / sqrt / split / string_literal / "(" expr:expression ")" { return ["parentheses_expression", {"a":expr}]; } / pow / sin / cos / tan / absolute_value / dot_notation / var_name / Integer / true / false',
			"C#":
				'Factor =  string_to_int / int_to_string / strcmp / not_equal / this  / not / dictionary / initializer_list / access_array / function_call / charAt / strlen / sqrt / split / string_literal / "(" expr:expression ")" {return ["parentheses_expression", {"a":expr}]} / pow / sin / cos / tan / absolute_value / dot_notation / Identifier / Integer / true / false',
			'Prolog,Haskell,Erlang,MiniZinc':
				'Factor = function_call / charAt / split / not / Integer / Identifier / string_literal / "(" expr:expression ")" { return expr; } / true / false',
			[list_of_grammar_notations.join(',')]:
				'Factor = grammar_string_literal / grammar_parentheses_expression / one_or_more / zero_or_more / grammar_parameter / nameless_grammar_parameter',
			'Z3':
				'Factor = function_call / And / concatenate_string / charAt / access_array / not / string_literal / Identifier / Integer',
			'Polish notation,Reverse Polish notation,Mathematical notation':
				'Factor = function_call / And / concatenate_string / not / string_literal / Identifier / Integer',

		},
		'grammar_Or':get_dictionary('grammar_Or'),
		'grammar_concatenate_string':get_dictionary('grammar_concatenate_string'),
		'grammar_series_of_statements':get_dictionary('grammar_series_of_statements'),
		'string_to_int':{
			'Fortran,Perl,Picat':'string_to_int = Identifier',
		},
		'access_array':{
			'Prolog,Erlang,Mathematical notation':'access_array = Identifier',
		},
		'charAt':{
			'Fortran,Julia':'charAt = access_array',
			'Prolog,Erlang':'charAt = Integer'
		},
		'set_var':{
		},
		'type':{
			"Lua,Erlang,Picat,Scala,PHP,JavaScript,Python,Java,C,C#,Haxe,C++,Swift,Go,Dart,Z3,REBOL,MiniZinc,Octave":
				'type = array_type / var1:_type {return var1;}',
			"Perl,Z3,Ruby,R,Fortran,Prolog,Visual Basic .NET,Haskell,Polish notation,Reverse Polish notation,Mathematical notation":
				'type = var1:_type {return ["type", {var1:var1}]}',
			[list_of_grammar_notations.join(',')]:
				'type = Integer',
		},
		'_type':{
			"Java,C,C#,Haxe,Ruby,C++,Swift,Dart":
				'_type = char / boolean / int / string / void / double',
			"Visual Basic .NET,Haskell,REBOL,Fortran,Go,Python":
				'_type = char / boolean / int / string / double',
			"Ruby":
				'_type = char / int / string',
			"Erlang":
				'_type = int / string',
			'Prolog,Perl,Polish notation,Reverse Polish notation,Mathematical notation,Picat':
				'_type = string',
			"Z3,MiniZinc,Octave":
				'_type = int / boolean / double / string',
			"PHP,Lua,JavaScript,TypeScript,R":
				'_type = int / string / boolean',
		},
		'boolean':{
			'Ruby':'boolean = int',
		},
		'initialize_empty_var':{
			'Ruby,PHP,Haskell,REBOL,Picat,Python,Octave':'initialize_empty_var = initialize_var',
		},
		'char':{
			'Z3':
				'',
			'JavaScript,PHP,Lua,Haxe,C#,Ruby,Dart,Python':
				'char = string',
		},
		'range':{
			"Java,JavaScript,C#":
				'',
		},
		'varargs':{
			"Java,JavaScript,Haxe":
				'varargs = function_parameter',
		},
		'async_function':{
			"Java":
				'',
		},
		'default_parameter':{
			"Java,JavaScript,Lua":
				'default_parameter = function_parameter',
		},
		'void':{
			"JavaScript,PHP,Z3,Lua,Ruby":
				'void = int',
		},
		'constructor':{
			
		},
		'class_statements':{
			[getOtherLangs('class_statements', 'Java')]:
				pattern_to_input('class_statements', 'Java')+' / class_statement'
		},
		'array_type_suffix':{
			"Java,C#,C++,Haxe,Go":
				'array_type_suffix = var1:"[]" var2:array_type_suffix {return ["array_type_suffix", {var1:var1, var2:var2}];} / "[]"',
			"Seed7":
				'array_type_suffix = var1:"array" __ var2:array_type_suffix {return ["array_type_suffix", {var1:var1, var2:var2}];} / "array"',
			"C":
				'array_type_suffix = var1:("[]"/"*") var2:array_type_suffix {return ["array_type_suffix", {var1:var1, var2:var2}];} / ("[]"/ "*")',
		},
		'for':{
			'Visual Basic .NET,Scala,Swift,Go,REBOL,Fortran,Picat,Python,Julia':'for = while',
		},
		'typeless_initialize_var':{
			'Fortran,Z3,MiniZinc':'typeless_initialize_var = initialize_var',
		},
		'case':{
			'Lua,Python':
				'',
		},
		'set_array_size':{
			'Perl,Picat,Python,Julia,Lua':'set_array_size = initialize_empty_var',
		},
		'import':{
			'Z3,Erlang,Mathematical notation,Octave':'import = function'
		},
		'else':{
			'Z3':'else = statement'
		},
		'initialize_instance_variable':{
			'Python,Ruby':
				'initialize_instance_variable = instance_method'
		},
		'declare_new_object':{
			'REBOL,C,Fortran,Go,Lua,Julia,MiniZinc,Picat':'declare_new_object = set_var',
		},
		'series_of_functions':{
			'Erlang,Prolog,Picat':
				'series_of_functions = a:function __ b:series_of_functions {return ["series_of_statements", {var1:a,var2:b}]} / function'
		},
		'enum_list':{
			[getOtherLangs('enum_list', 'Java')]:
				pattern_to_input('enum_list', 'Java') + ' / _enum_list',
			[getOtherLangs('enum_list', 'Haxe')]:
				pattern_to_input('enum_list', 'Haxe') + ' / _enum_list',
			[getOtherLangs('enum_list', 'Go')]:
				pattern_to_input('enum_list', 'Go') + ' / _enum_list',
		},
		'enum':{
			'REBOL,PHP,Ruby,Lua,JavaScript':
				'enum = function',
		},
		'declare_constant':{
			'Octave':'declare_constant = initialize_var',
		}
	}
for(current in thePatterns){
	//throw Object.keys(thePatterns);
	if(!(current in output_dict)){
		output_dict[current] = {};
	}
	for(current1 in thePatterns[current]){
			//throw JSON.stringify(current1+","+current);
			//console.log(thePatterns[current]);
			if(!(current1 in output_dict[current])){
				output_dict[current][current1] = pattern_to_input(current, current1.split(",")[0]);
				//console.log(JSON.stringify(output_dict[current][current1]));
			}
			//throw(JSON.stringify(output_dict[current]));
	}
}
//throw(JSON.stringify(output_dict["constructor"]["Ruby"]));
for(var current of list_of_languages){
if(list_of_grammar_notations.indexOf(current) === -1){
for(var current1 of Object.keys(thePatterns)){
	try{
		pattern_to_input(current1, current);
	}
	catch(e){
		console.log("Error for " + current + ": " + e);
	}
	//console.log(parsers[current]);
}
}
else{ //This is for the metasyntax languages
for(var current1 of "grammar,grammar_concatenate_string,grammar_Or,one_or_more,zero_or_more,grammar_statement,grammar_output,grammar_series_of_statements,grammar_parentheses_expression,grammar_parameter,nameless_grammar_parameter,grammar_string_literal".split(",")){
	try{
		pattern_to_input(current1, current);
	}
	catch(e){
		console.log("Error for " + current + ": " + e);
	}
	//console.log(parsers[current]);
}
}
}

function getOutput(lang, statement_name){
	for(var current in output_dict[statement_name]){
		var theOutput = output_dict[statement_name][current];
		if(acs(lang, current)){
			if(theOutput === ""){
				return "";
			}
			else{
				return "\n" + theOutput;
			}
		}
	}
	//console.log(statement_name + " is not yet defined for " + lang + " in output_dict");
	return "";
}

const list_of_statements = Object.keys(output_dict);
console.log('\nGenerating parsers, please wait...')

function generateParser(lang){
	var toReturn = ""

	for(let current of list_of_statements){
		toReturn += getOutput(lang, current);
	}
	toReturn += `

//In Z3, the - character should be allowed
Identifier "identifier" = !(type / Integer / "local" / "As" / "Concat" / "CharAt" / "retval" / "function" / "return" / "Return" / "Function" / "End" / "false" / "true" / "False" / "true" / "split" / "join" / "equals" / "Console" / "System" / "break" / "while" / "if" / "else" / "ite" / "end" / "then" / "and" / "or") [a-zA-Z0-9\_]+ {return text();}

Integer = "-" a:_Integer {return "-" + a;} / _Integer
_Integer = a:__Integer "." b:__Integer {return a + "." + b;} / __Integer
__Integer "integer" = [0-9]+ { return text(); }
_ "whitespace" = [ \\t\\n\\r]*
__ "whitespace2" = [ \\t\\n\\r] [ \\t\\n\\r]*  
string_literal = '"' var1:_string_literal '"' {return ["string_literal", {var1:var1}];} / "'" var1:__string_literal "'" {return ["string literal", var1];}
_string_literal = [^"]+ {return text();}
__string_literal = [^']+ {return text();}`
	//console.log("\n\n\n\n\n"+toReturn);
	console.log("Generated parser for " + lang);
	return toReturn;
}

const java_input_text = `
public static int main(int a, int b){
	while(a == b){
		System.out.println(a);
	}
	if(a){print(a);}
	else if(a){print(a);}
	else{print(a,b);}
	return a+b;
}
`


var add_to_string = "";

for(var current of list_of_languages){
	try{
		PEG.buildParser(generateParser(current));
	}
	catch(e){
		console.log("Error for " + current + ": " + e);
	}
	//console.log(parsers[current]);
}

for(var current of list_of_languages){
	add_to_string += "'"+current+"':"+PEG.buildParser(generateParser(current))+",";
	//console.log(parsers[current]);
}

function translateLang(lang1, lang2, text){
	var parseTree = TypeInference(parsers[lang1.toLowerCase()].parse(text));
	//alert(JSON.stringify(parseTree));
	return generateCode(parseTree, lang2.toLowerCase())
}

var theString = acs.toString()+"\n"+pattern_to_output.toString() +'\nconst list_of_languages = '+JSON.stringify(list_of_languages)+";\nvar thePatterns = "+JSON.stringify(thePatterns)+";\nvar parsers = {"+ add_to_string +"};"+typeInference.toString()+"\n"+generateCode.toString()+"\n"+translateLang.toString()+"\n";


fs.writeFile('optimized_translator.js', theString, function (err) {
	if (err) throw err;
	console.log('Generated optimized_translator.js for '+list_of_languages.join(", "));
});


//const parseTree = parsers["Java"].parse(java_input_text);



function translateLangs(lang, text){
	var parseTree = parsers[lang].parse(text);
	//console.log(JSON.stringify(parseTree));
	for(var current of list_of_languages){
		console.log(generateCode(parseTree, current));
	}
}

/*
console.log(translateLang("JavaScript", "Lua",
`function add(a,b){ var g = 1; var a = [3,4,5]; console.log(a !== b); return a + b; }
var a;
var b = 2;
const a = 3;
return d*2 + 3;
var a = {Hello:1, wow:3};
return function(a,b){console.log(a+b);};
`)); */

/* console.log(translateLang("Java", "C#",
`int i = i+3*4+5*3;
boolean b = (3 || 5) && (6 + 7);
System.out.println(a || 4);
System.out.println(a.equals("Hello"));
`));
*/

//console.log(translateLang("Z3", "Lua", "(ite d b c)"));
//console.log(translateLang("C", "Haxe", "bool a = \"Hello\"; printf(3);"));
//console.log(translateLang("Java", "MiniZinc", "public static int add(int a, int b){ if(b == 2){ return 2; } else{return a + b;}}"));
//console.log(translateLang("Java", "C", "String a = 3; System.out.println(a+2*1);"));
