"use strict";
//Copy the information into this file from grammar.txt.
//A demo of this script is in pegjs_test.html.
//Convert this source code to EcmaScript 5 using Babel:
//    http://babeljs.io/

//This list specifies the languages that will be parsed.,

//const list_of_languages = "Ruby,C#,PHP,C,JavaScript,Lua,Java,Haxe".split(",");
const list_of_languages = "Java,C#".split(",");

const PEG = require("pegjs");
console.log("translateLang is the most important function in this file.\n");

function acs(lang, theString){
	return (theString.split(",").indexOf(lang) !== -1);
}

function pattern_to_input(functionName, lang){
	var theString;
	for(var i in thePatterns[functionName]){
		if(acs(lang, i)){
			theString = thePatterns[functionName][i];
			break;
		}
	}
	if(theString === undefined){
		throw(functionName + " is not yet defined in " + lang + " in string_to_dict")
	}
	theString = theString.split(" ");
	var stringInput = "{return [\""+functionName+"\", {";
	for(var i = 0; i < theString.length; i++){
		if((theString[i].indexOf(":") !== -1) && theString[i][0] !== ":" && theString[i][theString[i].length-1] !== ":"){
			theString[i] = theString[i].split(":");
			stringInput += theString[i][0]+":"+theString[i][0]+",";
			theString[i] = theString[i][0]+":"+theString[i][1];
		}
		else if(theString[i] === "_" || theString[i] === "__"){
			theString[i] = " " + theString[i];
		}
		else{
			theString[i] = '"'+theString[i]+'"';
		}
	}
	
	return functionName + " = " + theString.join(" ") + " " + stringInput + "}];}";
}

function pattern_to_output(theDict, thePattern, theLang){
	var theString;
	for(var i in thePatterns[thePattern]){
		if(acs(theLang, i)){
			theString = thePatterns[thePattern][i];
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
				throw theString[i].split(":")[0] + " is not defined for " + thePattern + " in " + theLang;
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
`import,a:Identifier
	JavaScript
		import __ * __ as __ a __ from __ \' a \' ;
	crosslanguage
		(import __ a )
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
	C#
		using __ a ;
	Julia
		using __ a
	Haskell,EngScript,Python,Scala,Go,Groovy,Picat,Elm,Swift
		import __ a
	Java,D,Haxe
		import __ a ;
	Ruby,Lua
		require __ \' a \'
	Perl,Perl 6,Chapel
		\"use a ;\"
key_value_separator
	Python,C,Dart,Visual Basic .NET,D,C#,Frink,Swift,JavaScript,TypeScript,PHP,Perl,Lua,Ruby,Prolog,Julia,Haxe,C++,Scala,Octave,Elixir,Wolfram
		,
	Java
		;
	REBOL
		__
dictionary,a:key_value_list,input:type,output:type
	Python,C,Dart,JavaScript,TypeScript,Lua,Ruby,Julia,C++,EngScript,Visual Basic .NET
		{ a }
	Java
		new __ HashMap < input , output > ( ) { { a } }
	C#
		new __ Dictionary < input , output > { a }
	Perl
		( a )
	PHP
		array( a )
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
	EngScript,Wolfram,crosslanguage,Erlang,English,Mathematical notation,Pascal,Picat,Prolog,Katahdin,TypeScript,JavaScript,Frink,MiniZinc,Aldor,Flora-2,F-logic,D,Genie,ooc,Janus,Chapel,ABAP,COBOL,PicoLisp,REXX,PL/I,Falcon,IDP,Processing,Sympy,Maxima,Z3,Shen,Ceylon,nools,Pyke,Self,GNU Smalltalk,Elixir,LispyScript,Standard ML,Nimrod,Occam,ANTLR,Boo,Seed7,pyparsing,EBNF,Agda,Icon,Octave,Cobra,Kotlin,C++,Drools,Oz,Pike,Delphi,Racket,ML,Java,Pawn,Fortran,Ada,FreeBASIC,MATLAB,newLisp,Hy,OCaml,Julia,AutoIt,C#,Gosu,AutoHotKey,Groovy,Rust,R,Swift,Vala,Go,Scala,Nemerle,Visual Basic,Visual Basic .NET,Clojure,Haxe,CoffeeScript,Dart,JavaScript,C#,Python,Ruby,Haskell,C,Lua,Gambas,Common Lisp,Scheme,REBOL,F#
		name
	CLIPS
		? name
default_parameter,type:type,name:var_name,value:expression
	Python,AutoHotKey,Julia,Nemerle,PHP
		name = value
	C#,D,Groovy
		type __ name = value
	Ruby
		name : value
	Scala,Swift,Python
		name : type = value
	Haxe
		? name = value
	Visual Basic .NET
		Optional __ name __ As __ type = value
	Java,JavaScript,Lua,C
		_
_initializer_list,var1:expression,var2:initializer_list_separator,var3:_initializer_list
	Lua,Java,C++,JavaScript,C#,Perl,Fortran,C,PHP,Haskell,Haxe,Python,Ruby,TypeScript,MiniZinc
		var1 var2 var3
initialize_empty_var,type:type,name:var_name
	Java,C#,C++,C,D,Janus,Fortran
		type __ name
	JavaScript,Haxe
		var __ name
	TypeScript
		var __ name : type
	PHP
		name
	MiniZinc
		type : name
	Z3
		( declare-const __ name __ type )
	Lua
		local __ name
anonymous_function,params:function_parameters,b:series_of_statements,return_type:type
	Ruby
		Proc . new { | params | b }
	JavaScript,TypeScript,Haxe,R,PHP
		function ( params ) { b }
	Haskell
		(\\ params -> b )
	Frink
		{ | params | body }
	Erlang
		fun ( params ) __ b __ end
	Lua
		function ( params ) __ b __ end
	Swift
		{ ( params ) -> return_type __ in __ b }
	Go
		func ( params ) return_type { b }
	Dart
		( ( params ) => b )
	C++
		[ = ] ( params ) -> int { b }
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
strlen,a:parentheses_expression
	crosslanguage
		( strlen __ a __ b )
	Python
		len ( a )
	R
		nchar ( a )
	Erlang
		string:len ( a )
	Visual Basic,Visual Basic .NET,Gambas
		Len ( a )
	JavaScript,TypeScript,Ruby,Scala,Gosu,Picat,Haxe,OCaml,D
		a . length
	REBOL
		length? __ a
	Java,C++,Kotlin
		a . length ( )
	PHP,C,Pawn,Hack
		strlen ( a )
	MiniZinc,Julia
		length ( a )
	Haskell
		( length a )
	C#
		a . Length
	Swift
		countElements ( a )
	AutoIt
		StringLen ( a )
	Common Lisp
		( length __ a )
	Racket,Scheme
		( string-length __ a )
	Perl,Octave
		length ( a )
	Nemerle
		a . Length
	Fortran
		LEN ( a )
	Lua
		string . len ( a )
	Wolfram
		StringLength [ a ]
not_equal,a:Add,b:Add
	Lua
		a ~= b
	JavaScript,PHP,TypeScript
		a !== b
	Java,Wolfram,C,C++,D,C#,Julia,Perl,Ruby,Haxe,Python,MiniZinc
		a != b
	English
		a __ does __ not __ equal __ b
	Prolog
		not ( a == b )
	Mathematical notation
		a ≠ b
	Janus
		a # b
	Fortran
		a .NE. b
	Z3
		( not ( = __ a __ b ) )
key_value_list,var1:key_value,var2:key_value_separator,var3:key_value_list
	Lua,JavaScript,Java,C#,C++,C,Ruby,PHP,Python,Perl,Fortran,Haxe,TypeScript
		var1 var2 var3
Or,var1:greater_than,var2:Or
	JavaScript,Wolfram,Chapel,Elixir,Frink,ooc,Picat,Janus,Processing,Pike,nools,Pawn,MATLAB,Hack,Gosu,Rust,AutoIt,AutoHotKey,TypeScript,Ceylon,Groovy,D,Octave,AWK,Julia,Scala,F#,Swift,Nemerle,Vala,Go,Perl,Java,Haskell,Haxe,C,C++,C#,Dart,R
		var1 || var2
	Python
		var1 __ or __ var2
	Fortran
		var1 __ .OR. __ var2
	Z3
		( or __ var1 __ var2 )
And,a:Or,b:And
	Java,JavaScript,C#
		a && b
	Python
		a __ and __ b
	MiniZinc
		a /\\ b
	Fortran
		a .AND. b
	Z3
		( and __ a __ b )
this,a:Identifier
	Ruby,CoffeeScript
		@ a
	Java,EngScript,Dart,Groovy,TypeScript,JavaScript,C#,C++,Haxe,Chapel
		this . a
	Python
		self . a
	PHP,Hack
		$this -> a
	Swift,Scala
		a
	REBOL
		self / a
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
	Octave
		length ( a )
	Fortran,Janus
		size ( a )
	Wolfram
		Length [ a ]
initializer_list_separator
	Python,D,Frink,Fortran,Chapel,Octave,Julia,English,Pascal,Delphi,Prolog,MiniZinc,EngScript,Cython,Groovy,Dart,TypeScript,CoffeeScript,Nemerle,JavaScript,Haxe,Haskell,Ruby,REBOL,Polish notation,Swift,Java,Picat,C#,Go,Lua,C++,C,Visual Basic .NET,Visual Basic,PHP,Scala,Perl,Wolfram
		,
	REBOL
		__
initializer_list,a:_initializer_list
	Java,Picat,C#,Go,Lua,C++,C,Visual Basic .NET,Visual Basic,Wolfram
		{ a }
	Python,D,Frink,REBOL,Octave,Julia,Prolog,MiniZinc,EngScript,Cython,Groovy,Dart,TypeScript,CoffeeScript,Nemerle,JavaScript,Haxe,Haskell,Ruby,REBOL,Polish notation,Swift
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
	Groovy,D,Dart,JavaScript,CoffeeScript,Swift,Elixir,Swift
		a : b
	Python
		' a ' : b
	Ruby,PHP,Haxe,Perl,Julia
		a => b
	REBOL
		a __ b
	Lua
		a = b
	C++,C,C#,Visual Basic .NET
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
	crosslanguage
		( strcmp __ a __ b )
	Visual Basic,Visual Basic .NET,F#,Prolog
		a = b
	Python,Chapel,Julia,Fortran,MiniZinc,Picat,Go,Vala,AutoIt,REBOL,Ceylon,Groovy,Scala,CoffeeScript,AWK,Ruby,Haskell,Haxe,Dart,Lua,Swift
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
		string:equal ( a , b )
sqrt,x:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . sqrt ( x )
	C#,Visual Basic .NET
		Math . Sqrt ( x )
	C,Perl,PHP,Perl 6,Maxima,MiniZinc,Prolog,Octave,D,Haskell
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
		math:sqrt ( x )
	Wolfram
		Sqrt [ x ]
parentheses_expression,a:expression
	Pascal,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET
		( a )
	Racket,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript
		a
join,array:parentheses_expression,separator:parentheses_expression
	C#
		String . Join ( separator , array )
	PHP
		implode ( separator , array )
	Perl
		join ( separator , array )
	D
		join ( array , separator )
	Lua
		table . concat ( array , separator )
	Go
		Strings . join ( array , separator )
	JavaScript,Haxe,CoffeeScript,Ruby,Groovy,Java,TypeScript
		array . join ( separator )
	Python
		separator . join ( array )
plus_equals,a:(access_array/dot_notation/Identifier),b:expression
	Janus,TypeScript,Python,Lua,Java,C,C++,C#,JavaScript,Haxe,PHP,Chapel,Perl
		a += b
	Ruby,Picat
		a = a + b
minus_equals,a:(dot_notation/access_array/Identifier),b:expression
	Janus,TypeScript,Python,Lua,Java,C,C++,C#,JavaScript,PHP,Haxe,Hack,Fortran
		a -= b
	Ruby
		a = a - b
concatenate_string,a:Add,b:concatenate_string
	Common Lisp
		( concatenate __ 'string __ a __ b )
	C,Z3,Java,Chapel,Frink,FreeBASIC,Nemerle,D,Cython,Ceylon,CoffeeScript,TypeScript,Dart,Gosu,Groovy,Scala,Swift,F#,Python,JavaScript,C#,Haxe,Ruby,C++,Vala
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
		string:concat ( a , b )
	Julia
		string ( a , b )
	Octave
		strcat ( a , b )
	Racket
		( string-append a b )
	Delphi
		Concat ( a , b )
	Visual Basic,Gambas,Nimrod,AutoIt,Visual Basic .NET,OpenOffice Basic
		a & b
	Elixir,Wolfram
		a <> b
	Perl 6
		a ~ b
split,aString:parentheses_expression,separator:parentheses_expression
	JavaScript,CoffeeScript,Java,Python,Dart,Scala,Groovy,Haxe,Ruby,Rust,TypeScript
		aString . split ( separator )
	Lua
		string . gmatch ( aString , separator )
	PHP
		explode ( separator , aString )
	Perl,Processing
		split ( separator , aString )
	REBOL
		split __ aString __ separator
	C#
		aString . Split ( new string[] { separator } , StringSplitOptions . None )
	Picat,D
		split ( aString , separator )
	Haskell
		( splitOn __ aString __ separator )
	Wolfram
		StringSplit [ aString , separator ]
pow,a:expression,b:expression
	Lua
		math . pow ( a , b )
	Scala
		scala.math.pow ( a , b )
	C#,Visual Basic .NET
		Math . Pow ( a , b )
	JavaScript,Java,TypeScript,Haxe
		Math . pow ( a , b )
	Python,Chapel,Haskell,COBOL,Picat,ooc,PL/I,REXX,Maxima,AWK,R,F#,AutoHotKey,Tcl,AutoIt,Groovy,Octave,Ruby,Perl,Fortran
		( a ** b )
	REBOL
		power __ a __ b
	C,C++,PHP,Hack,Swift,MiniZinc,D
		pow ( a , b )
	Julia,EngScript,Visual Basic,Visual Basic .NET,Gambas,Go,Ceylon,Wolfram
		a ^ b
	Rust
		num::pow ( a , b )
	Hy,Common Lisp,Racket,Clojure
		( expt __ num1 __ num2 )
	Erlang
		math:pow ( a , b )
case_statements,a:case,b:case_statements
	Java,C,C#,C++,JavaScript,PHP,Haxe,Fortran,Ruby,Lua,Dart,TypeScript
		a __ b
statement_with_semicolon,var1:statement
	C,Dafny,Chapel,Katahdin,Frink,MiniZinc,Falcon,Aldor,IDP,Processing,Maxima,Seed7,Drools,EBNF,ANTLR,EngScript,OpenOffice Basic,Ada,ALGOL 68,D,Ceylon,Rust,TypeScript,Octave,AutoHotKey,Pascal,Delphi,JavaScript,Pike,Objective-C,OCaml,Java,Scala,Dart,PHP,C#,C++,Haxe,AWK,bc,Haskell,Perl,Perl 6,Go,Nemerle,Vala
		var1 ;
	Python,Z3,Swift,Wolfram,Gambas,Pascal,Delphi,AutoHotKey,REBOL,Octave,Janus,Cython,Mathematical notation,Picat,Lua,Ruby,Haskell,Erlang,Prolog,Scala,Visual Basic .NET,Fortran,Julia,R
		var1
dot_notation,var1:Identifier,var2:dot_notation
	Java,JavaScript,D,Haxe,C#,Perl 6
		var1 . var2
	PHP,C
		var1 -> var2
sin,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . sin ( var1 )
	Lua,Python
		math . sin ( var1 )
	C,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell
		sin ( var1 )
	C#,Visual Basic .NET
		Math . Sin ( var1 )
	Wolfram
		Sin [ var1 ]
cos,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . cos ( var1 )
	Lua,Python
		math . cos ( var1 )
	C,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell
		cos ( var1 )
	C#,Visual Basic .NET
		Math . Cos ( var1 )
	Wolfram
		Cos [ var1 ]
tan,var1:expression
	Java,JavaScript,TypeScript,Ruby,Haxe
		Math . tan ( var1 )
	Lua,Python
		math . tan ( var1 )
	C,D,PHP,Perl,Perl 6,Maxima,Fortran,MiniZinc,Swift,Prolog,Octave,Dart,Haskell
		tan ( var1 )
	C#,Visual Basic .NET
		Math . Tan ( var1 )
	Wolfram
		Tan [ var1 ]
instance_method,name:Identifier,type:type,params:function_parameters,body:series_of_statements
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
	C++,D
		type __ name ( params ) { body }
	Haxe
		public __ function __ name ( params ) : type { body }
	Lua
		_
	Python
		def __ name (  self, params ) : \\n #indent \\n body \\n #unindent
typeless_instance_method,name:Identifier,params:function_parameters,body:series_of_statements
	JavaScript
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
static_method,name:Identifier,return_type:type,params:function_parameters,body:series_of_statements
	Haxe
		public __ static __ function __ name ( params ) { body }
	Lua,Julia
		function __ name ( params ) __ body __ end
	Java,C#
		public __ static __ return_type __ name ( params ) { body }
	C++,Dart
		static __ return_type __ name ( params ) { body }
	PHP
		public __ static __ function __ name ( params ) { body }
	Ruby
		def __ self . name ( params ) __ body __ end
	C
		return_type __ name ( params ) { body }
	JavaScript
		static __ name ( params ) { body }
	Picat
		_
	Python
		@staticmethod \\n __ def __ name (  params ) : \n #indent \\n body \\n #unindent
declare_new_object,var_name:var_name,class_name:Identifier,params:function_call_parameters
	Java,C#,D
		class_name __ var_name = new __ class_name ( params )
	JavaScript,Haxe,Chapel
		var __ var_name = new __ class_name ( params )
	PHP
		var_name = new __ class_name ( params )
	Python
		var_name = class_name ( params )
	Ruby
		var_name = class_name . new ( params )
	Perl
		my __ var_name = class_name -> new ( params )
	C++
		class_name __ var_name ( params )
	C,Picat,MiniZinc,Prolog,Lua
		_
string_to_int,a:expression
	Python
		int ( a )
	Haxe
		Std . parseInt ( a )
	PHP
		( int ) a
	Haskell
		( read __ a )
	Perl
		a
	C#
		Int32 . Parse( a )
	Visual Basic .NET
		Convert . toInt32 ( a )
	Java
		Integer . parseInt ( a )
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
int_to_string,a:parentheses_expression
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
	C#
		Convert . ToString ( a )
	Ruby
		a . to_s
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
typeless_declare_constant,name:var_name,value:expression
	PHP,JavaScript,Dart,TypeScript
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
	C
		static __ const __ name = value
	Chapel
		var name = value
declare_constant,name:var_name,type:type,value:expression
	PHP,JavaScript
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
	Java
		final __ type __ name = value
	C
		static __ const __ name = value
	Chapel
		var name : type = value
constructor,name:Identifier,params:function_parameters,body:series_of_statements
	crosslanguage
		(constructor __ name __ params __ body)
	Python
		def __ __init__ (  self , params ) : \\n #indent \n body \\n #unindent
	Java,C#
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
function_call_named_parameter,name:Identifier,value:expression
	Python,C#,Fortran,Scala
		name = value
	Modula-3,Visual Basic .NET
		name := value
	Ruby
		name : value
	JavaScript,Lua,Java,C,PHP,Haxe,MiniZinc
		value
function_call,theName:dot_notation,args:function_call_parameters
	C,Chapel,Elixir,Janus,Perl 6,Pascal,Rust,Hack,Katahdin,MiniZinc,Pawn,Aldor,Picat,D,Genie,ooc,PL/I,Delphi,Standard ML,REXX,Falcon,IDP,Processing,Maxima,Swift,Boo,R,MATLAB,AutoIt,Pike,Gosu,AWK,AutoHotKey,Gambas,Kotlin,Nemerle,EngScript,Prolog,Groovy,Scala,CoffeeScript,Julia,TypeScript,Fortran,Octave,C++,Go,Cobra,Ruby,Vala,F#,Java,Ceylon,OCaml,Erlang,Python,C#,Lua,Haxe,JavaScript,Dart,bc,Visual Basic,Visual Basic .NET,PHP,Perl
		theName ( args )
	Haskell,Z3,CLIPS,Clojure,Common Lisp,CLIPS,Racket,Scheme,crosslanguage
		( theName args )
for,statement_1:initialize_var,condition:expression,statement_2:set_var,body:series_of_statements
	Java,D,Pawn,Groovy,JavaScript,Dart,TypeScript,PHP,Hack,C#,Perl,C++,AWK,Pike
		for ( statement_1 ; condition ; statement_2 ) { body }
	C
		init:initialize_empty_var ; for ( statement_1 ; condition ; statement_2 ) { body }
	Haxe
		statement_1 ;  while ( condition ) { body statement_2 ; }
	Lua,Ruby
		statement_1 __ while __ condition __ do __ body __ statement_2 __ end
while,a:Or,b:series_of_statements
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
		while __ a : \n #indent \n b \n #unindent
	Visual Basic,Visual Basic .NET
		While __ a __ b __ End While
	Octave
		while ( a ) __ endwhile
	Wolfram
		While [ a , b ]
function,return_type:type,params:function_parameters,name:Identifier,body:series_of_statements
	C++,Vala,C,Dart,Ceylon,Pike,D
		return_type __ name ( params ) { body }
	Java,C#
		public __ static __ return_type __ name ( params ) { body }
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
		( define-fun __ name ( params ) __ return_type __ body )
	Mathematical notation
		name ( params ) = { body }
	Chapel
		proc __ name ( params ) : return_type { body }
	Prolog
		name ( params ) __ :- __ body .
	Picat
		name ( params ) = to_return => body .
	Swift
		func __ name ( params ) -> return_type { body }
	Maxima
		name ( params ) := body
	Rust
		fn __ name ( params ) -> return_type { body }
	Clojure
		( defn name [ params ] body )
	Octave
		function __ retval = name ( params ) body __ endfunction
	Haskell
		name __ params = \\n body
	Common Lisp
		(defun __ name ( params ) body )
	Fortran
		FUNC __ name __ ( params ) __ RESULT ( retval ) __ return_type :: retval __ body __ END __ FUNCTION __ name
	Scala
		def __ name ( params ) : return_type = { body }
	MiniZinc
		function __ return_type : name ( params ) = body ;
	CLIPS
		( deffunction __ name ( params ) body )
	Erlang
		name ( params ) -> body
	Perl
		sub __ name { params __ body }
	Perl 6
		sub __ name ( params ) { body }
	Pawn
		name ( params ) { body }
	Ruby
		def __ name ( params ) __ body __ end
	TypeScript
		function __ name ( params ) : return_type { body }
	REBOL
		name : __ func [ params ] [ body ]
	Haxe
		public __ static __ function __ name ( params ) : return_type { body }
	Hack
		function __ name ( params ) : return_type { body }
	R
		name <- function ( params ) { body }
	bc
		define name ( params ) { body }
	Visual Basic,Visual Basic .NET
		Function name ( params ) As return_type body End Function
	Racket,newLisp
		(define (name params) body )
	Janus
		procedure name ( params ) body
	Python
		def __ name ( params ) -> type : \\n #indent \\n body \\n #unindent
else,a:series_of_statements
	Fortran
		ELSE __ a
	Hack,Dafny,Perl 6,Frink,Chapel,Katahdin,Pawn,PowerShell,Puppet,Ceylon,D,Rust,TypeScript,Scala,AutoHotKey,Gosu,Groovy,Java,Swift,Dart,AWK,JavaScript,Haxe,PHP,C#,Go,Perl,C++,C,Tcl,R,Vala,bc
		else { a }
	Ruby,Janus,Lua,Haskell,CLIPS,MiniZinc,Julia,Octave,Picat,Pascal,Maxima
		else \n a
	Erlang
		true -> a
	Python,Cython
		else : \n #indent \n b \n #unindent
	Prolog
		a
	Visual Basic .NET
		Else __ a
	REBOL
		true [ a ]
	Common Lisp
		( t __ a )
	English
		otherwise __ a
	Wolfram,Z3
		a
elif,condition:And,body:series_of_statements,next:elif_or_else
	D,Chapel,Pawn,Ceylon,Scala,TypeScript,AutoHotKey,AWK,R,Groovy,Gosu,Katahdin,Java,Swift,Nemerle,C,Dart,Vala,JavaScript,C#,C++,Haxe
		else __ if ( a ) { b } c
	Z3
		( ite __ a __ b __ c )
	Rust,Go
		else __ if __ a { b } c
	PHP,Hack,Perl
		elseif ( a ) { b } c
	Julia,Octave,Lua
		elseif __ a __ b __ c
	Ruby
		elsif __ a __ then __ b __ c
	Picat
		elseif __ a __ then __ b __ c
	Haskell,Pascal,Maxima
		else __ if __ a __ then __ b __ c
	Erlang
		a -> b __ c
	R,F#
		a <- b __ c
	CLIPS
		( if __ a __ then __ ( b __ c ) )
	MiniZinc
		else __ if __ a __ then __ b __ c
	Python,Cython
		elif __ a : \\n #indent \\n b \\n #unindent __ c
	Prolog
		a -> b ; __ c
	Visual Basic .NET
		ElseIf __ a __ Then __ b __ c
	Fortran
		ELSE __ IF __ a __ THEN __ b __ c
	REBOL
		a [ b ] __ c
	Common Lisp
		( a __ b ) __ c
	English
		otherwise __ if __ a __ then __ b __ c
	Wolfram
		If [ a , b , c ]
return,a:And
	Java,Kal,EngScript,Pawn,Ada,PowerShell,Rust,D,Ceylon,TypeScript,Hack,AutoHotKey,Gosu,Swift,Pike,Objective-C,C,Groovy,Scala,CoffeeScript,Julia,Dart,C#,JavaScript,Go,Haxe,PHP,C++,Perl,Vala,Lua,Python,REBOL,Ruby,Tcl,AWK,bc,Chapel,Perl 6
		return __ a
	MiniZinc,Z3,Erlang,Maxima,Standard ML,Icon,Oz,CLIPS,newLisp,Hy,Sibilant,LispyScript,ALGOL 68,Clojure,Prolog,Common Lisp,F#,OCaml,Haskell,ML,Racket,Nemerle
		a
	Visual Basic,Visual Basic .NET,AutoIt
		Return __ a
	Octave,Fortran
		retval = a
	Pascal
		Exit ( a )
	Picat
		to_return = a
	R
		return ( a )
	Wolfram
		Return [ a ]
	POP-11
		a -> Result
set_var,name:(access_array/var_name),value:expression
	Z3
		( declare_const __ name:Identifier __ value )
	JavaScript,Perl 6,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,ooc,D,Genie,Janus,Ceylon,IDP,Sympy,Prolog,Processing,Java,EBNF,Boo,Gosu,Pike,Kotlin,Icon,PowerShell,EngScript,Pawn,FreeBASIC,Hack,Nimrod,OpenOffice Basic,Groovy,TypeScript,Rust,CoffeeScript,Fortran,AWK,Go,Swift,Vala,C,Julia,Scala,Cobra,Erlang,AutoIt,Dart,Java,OCaml,Haxe,C#,MATLAB,C++,PHP,Perl,Python,Lua,Ruby,Gambas,Octave,Visual Basic,Visual Basic .NET,bc
		name = value
print,a:expression
	Erlang
		io : fwrite ( a )
	C++
		cout << a
	Haxe
		trace ( a )
	Prolog
		write ( a )
	C#
		Console . WriteLine ( a )
	REBOL,Fortran,Perl,PHP
		print __ a
	Ruby
		puts ( a )
	Visual Basic .NET
		System . Console . WriteLine ( a )
	Scala,Julia,Swift
		println ( a )
	JavaScript,TypeScript
		console . log ( a )
	Python,Cython,Ceylon,R,Gosu,Dart,Vala,Perl,PHP,Hack,AWK,Lua
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
	Chapel,D
		writeln ( a )
	Frink
		print [ a ]
	Wolfram
		Print [ a ]
series_of_statements,var1:statement,var2:series_of_statements
	Java,Dafny,Z3,Elm,Bash,Perl 6,Mathematical notation,Katahdin,Frink,MiniZinc,Aldor,COBOL,ooc,Genie,ECLiPSe,nools,Agda,PL/I,REXX,IDP,Falcon,Processing,Sympy,Maxima,Pyke,Elixir,GNU Smalltalk,Seed7,Standard ML,Occam,Boo,Drools,Icon,Mercury,EngScript,Pike,Oz,Kotlin,Pawn,FreeBASIC,Ada,PowerShell,Gosu,Nimrod,Cython,OpenOffice Basic,ALGOL 68,D,Ceylon,Rust,CoffeeScript,ActionScript,TypeScript,Fortran,Octave,ML,AutoHotKey,Delphi,Pascal,F#,Self,Swift,Nemerle,Dart,C,AutoIt,Cobra,Julia,Groovy,Scala,OCaml,Erlang,Gambas,Hack,C++,MATLAB,REBOL,Red,Lua,Go,AWK,Haskell,Perl,Python,JavaScript,C#,PHP,Ruby,R,Haxe,Visual Basic,Visual Basic .NET,Vala,bc
		var1 __ var2
	Prolog
		var1 , var2
	Wolfram
		var1 ; var2
comment,var1:[^\\n]+
	Java,Dafny,Janus,Chapel,Rust,Frink,D,Genie,Ceylon,Hack,Maxima,Kotlin,Delphi,Dart,TypeScript,Swift,Vala,C#,JavaScript,Haxe,Scala,Go,C,C++,Pike,PHP,F#,Nemerle,crosslanguage,Gosu,Groovy":
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
	Bash,Perl 6,PowerShell,Seed7,Cobra,Icon,EngScript,Nimrod,CoffeeScript,Julia,AWK,Ruby,Perl,R,Tcl,bc,Python,Cython
		# var1 \\n
	Lua,Haskell,Ada
		-- var1 \\n
initialize_var,name:var_name,type:type,value:expression
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
		type : name = value
	Python,Ruby,Haskell,Erlang,Prolog,Julia,Picat,Octave
		name = value
	JavaScript,PHP,Hack,Swift
		var __ name = value
	Lua
		local __ name = value
	Janus
		local __ type __ name = value
	Perl
		my __ name = value
	C,Java,C#,C++,D,TypeScript
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
typeless_initialize_var,name:var_name,value:expression
	C++,D
		auto __ name = value
	C#,Dafny,JavaScript,Haxe,PHP,TypeScript,Dart,Swift
		var __ name = value
	Lua
		local __ name = value
	Python,Ruby,Haskell,Erlang,Prolog,Julia,Picat,Octave,PHP
		name = value
	C
		__auto_type __ name = value
	Java
		Object __ name = value
	C#,JavaScript,Haxe,Swift
		var __ name = value
	Perl
		my __ name = value
int,t1:type
	Hack,Dafny,Janus,Chapel,MiniZinc,EngScript,Cython,ALGOL 68,D,Octave,Tcl,crosslanguage,ML,AWK,Julia,Gosu,OCaml,F#,Pike,Objective-C,Go,Cobra,Dart,Groovy,Python,Hy,Java,C#,C,C++,Vala,Nemerle,crosslanguage
		int
	PHP,Prolog,Common Lisp,Picat
		integer
	Fortran
		INTEGER
	REBOL
		integer!
	Ceylon,Gambas,OpenOffice Basic,Pascal,Erlang,Delphi,Visual Basic,Visual Basic .NET
		Integer
	Haxe,ooc,Swift,Scala,Perl 6,Z3
		Int
	JavaScript,TypeScript,CoffeeScript,Lua,Perl
		number
	Haskell
		Num
	Ruby
		fixnum
char
	Java,C
		char
string
	Java,Ceylon,Gambas,Dart,Gosu,Groovy,Scala,Pascal,Swift,Ruby,Haxe,Haskell,Visual Basic,Visual Basic .NET
		String
	Vala,D,crosslanguage,Chapel,Prolog,MiniZinc,Genie,Hack,Nimrod,ALGOL 68,TypeScript,CoffeeScript,Octave,Tcl,AWK,Julia,C#,F#,Perl,Lua,JavaScript,Go,PHP,C++,Nemerle,Erlang
		string
	C
		char*
void
	EngScript,PHP,Hy,Cython,Go,Pike,Objective-C,Java,C,C++,C#,Vala,TypeScript,D
		void
	Haxe
		Void
	Scala
		Unit
boolean
	TypeScript,Python,Hy,Java,JavaScript,Lua,Perl
		boolean
	C++,Dafny,Chapel,C,crosslanguage,Rust,MiniZinc,EngScript,Dart,D,Vala,crosslanguage,Go,Cobra,C#,F#,PHP,Hack
		bool
	Haxe,Haskell,Swift,Julia,Perl 6,Z3
		Bool
	Fortran
		LOGICAL
if,c:elif_or_else,b:series_of_statements,a:And
	Erlang
		if __ a -> b __ c __ end
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
	Haskell,Pascal,Maxima
		if __ a __ then __ b __ c
	Java,Perl 6,Chapel,Katahdin,Pawn,PowerShell,D,Ceylon,TypeScript,ActionScript,Hack,AutoHotKey,Gosu,Nemerle,Swift,Nemerle,Pike,Groovy,Scala,Dart,JavaScript,C#,C,C++,Perl,Haxe,PHP,R,AWK,Vala,bc,Squirrel
		if ( a ) { b } c
	Rust,Go
		if __ a { b } c
	Visual Basic,Visual Basic .NET
		If __ a __ b __ c
	CLIPS
		( if __ a __ then __ b __ c )
	Z3
		( ite __ a __ b __ c )
	MiniZinc
		if __ a __ then __ b __ c __ endif
	Python,Cython
		if __ a : \n #indent \n b \n #unindent \n c
	Prolog
		( a -> b ; c )
	Visual Basic
		If __ a __ Then __ b __ c __ End __ If
	Common Lisp
		( cond ( a __ b ) __ c )
	Wolfram
		If [ a , b , c ]
foreach,array:expression,var_name:var_name,typeInArray:type,body:series_of_statements
	JavaScript
		array . forEach ( function ( var_name ) { body  } ) ;
	MiniZinc
		forall ( var_name in array ) ( body ) ;
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
compare_ints,var1:Add,var2:Add
	Lua,Dafny,Wolfram,D,Rust,R,MiniZinc,Frink,Picat,Pike,Pawn,Processing,C++,Ceylon,CoffeeScript,Octave,Swift,AWK,Julia,Perl,Groovy,Erlang,Haxe,Scala,Java,Vala,Dart,Python,C#,C,Go,Haskell,Ruby
		var1 == var2
	JavaScript,PHP,TypeScript,Hack
		var1 === var2
	Z3
		( = __ var1 __ var2 )
	Fortran
		var1 .eq. var2
	Maxima,REBOL,F#,AutoIt,Pascal,Delphi,Visual Basic,Visual Basic .NET
		var1 = var2
class,name:Identifier,body:series_of_statements
	C,Z3,Lua
		body
	Java,C#
		public __ class __ name { body }
	C++
		class __ name { body } ;
	JavaScript,Hack,PHP,Scala,Haxe,Chapel,Swift,D,TypeScript,Dart,Perl 6
		class __ name { body }
	Ruby
		class __ name __ body __ end
	R
		_
function_parameter,type:type,name:var_name
	crosslanguage
		( parameter __ type __ name )
	C#,Java,Ceylon,ALGOL 68,Groovy,D,C++,Pawn,Pike,Vala,C,Janus
		type __ name
	Haxe,Dafny,Chapel,Pascal,Rust,Genie,Hack,Nimrod,TypeScript,Gosu,Delphi,Nemerle,Scala,Swift
		name : type
	Go
		name __ type
	MiniZinc
		var __ type : name
	Haskell,Scheme,Python,Mathematical notation,LispyScript,CLIPS,Clojure,F#,ML,Racket,OCaml,Tcl,Common Lisp,newLisp,Python,Cython,Frink,Picat,IDP,PowerShell,Maxima,Icon,CoffeeScript,Fortran,Octave,AutoHotKey,Julia,Prolog,AWK,Kotlin,Dart,JavaScript,Nemerle,Erlang,PHP,AutoIt,Lua,Ruby,R,bc
		name
	REBOL
		type [ name ]
	OpenOffice Basic,Gambas
		name __ As __ type
	Visual Basic,Visual Basic .NET
		name __ as __ type
	Perl
		name = push;
	Wolfram
		name \_
	Z3
		( name __ type )
switch,a:expression,b:case_statements,c:default
	crosslanguage
		( switch __ a __ b __ c )
	Rust
		match __ a { b __ c }
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
	Python,Lua
		
case,a:expression,b:series_of_statements
	Lua,Python
		_
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
	Haskell,Erlang,Elixir
		a __ -> \\n b
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
access_array,a:Identifier,b:array_access_list
	Python,Lua,C#,Julia,D,Swift,Julia,Janus,MiniZinc,Picat,Nimrod,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		a [ b ]
	Scala,Octave,Fortran,Visual Basic, Visual Basic .NET
		a ( b )
	Haskell
		( a !! b )
	Frink
		a @ b
array_access_list,var1:expression,var2:array_access_list,separator:array_access_separator
	Java,C#,Lua,C++,Python,JavaScript,C,PHP,Ruby,Scala,Haxe,Fortran,TypeScript,MiniZinc,Dart
		var1 separator var2
array_access_separator
	C#,MiniZinc,Fortran,Julia,Visual Basic,Visual Basic .NET
		,
	Python,D,Lua,Picat,Janus,Nimrod,AutoIt,Cython,CoffeeScript,Dart,TypeScript,AWK,Vala,Perl,Java,JavaScript,Ruby,Go,C++,PHP,Haxe,C
		][
	Haskell
		!!
	Scala
		)(
	Frink
		@
default,a:series_of_statements
	Python,Cython,Lua,MiniZinc,Prolog,Lua
		_
	Fortran
		CASE __ DEFAULT __ a
	crosslanguage
		( default __ a )
	JavaScript,D,C,Java,C#,C++,TypeScript,Dart,PHP,Haxe,Hack,Go,Swift
		default : a
	Ruby,Pascal,Delphi
		else __ a
	Haskell
		\_ -> \\n __ a
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
		//console.log(JSON.stringify(thePatterns[current]));
	}
}
//throw(JSON.stringify(thePatterns["function"]["Haxe"]));

function generateCode(parseTree, outputLang){
	if(typeof(parseTree) === "string"){
		return parseTree;
	}
	var d = {};
	for(var current in parseTree[1]){
		d[current] = generateCode(parseTree[1][current], outputLang);
	}
	switch(parseTree[0]){
		case 'initialize_var':
			if(acs(outputLang, "Java,C#,C++,JavaScript,TypeScript")){
				if(d.type === undefined){
					if (acs(outputLang, "Java,C#")){
						d.type = "Object";
					}
					else if(acs(outputLang, "C++")){
						d.type = "auto";
					}
					else if(acs(outputLang, "Haxe,JavaScript,TypeScript")){
						return pattern_to_output(d,"initialize_var","JavaScript");
					}
					else{
						throw("Initializing a typeless variable")
					}
				}
			}
			return pattern_to_output(d,"initialize_var",outputLang);
		break;
		case 'function_parameter':
			if(d.type === undefined){
				if(acs(outputLang, "C#,Java")){
					d.type = "Object";
				}
				else if(acs(outputLang, "D,C++")){
					d.type = "auto";
				}
			}
			
			return pattern_to_output(d,"function_parameter",outputLang);
		break;
		case "+":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"+"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(+ " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "-":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"-"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(- " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case ">":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +">"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(> " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "<":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"<"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(< " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case ">=":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +">="+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(>= " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "<=":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"<="+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(<= " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "*":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"*"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(* " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "string_literal":
			return "\"" + d.var1 + "\"";
		break;
		case "/":
			if(acs(outputLang, "Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET")){
				return "(" + d.var1 +"/"+ d.var2 + ")";
			}
			else if(acs(outputLang, "Z3")){
				return "(/ " + d.var1 +" "+ d.var2 + ")";
			}
		break;
		case "parameters":
			if(acs(outputLang,"JavaScript,Dafny,Wolfram,Gambas,D,Frink,Chapel,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET")){
				return d.var1 +","+ d.var2;
			}
			else if(acs(outputLang, "Hy,Z3,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure")){
				return d.var1 +" "+d.var2;
			}
		break;
		case 'function':
			if(d.type === undefined){
				if(acs(outputLang, "Java,C#")){
					d.type = "Object"
				}
				else if(acs(outputLang, "D,C++")){
					d.type = "auto"
				}
			}
			return pattern_to_output(d,"function",outputLang);
		break;
		case 'declare_constant':
			if(d.type === undefined){
				if(acs(outputLang, "Java")){
					d.type = "Object"
				}
				else if(acs(outputLang, "C#")){
					d.type = "var"
				}
				else if(acs(outputLang, "D,C++")){
					d.type = "auto"
				}
			}
			return pattern_to_output(d,"declare_constant",outputLang);
		break;
		case "compare_ints":
			var toReturn = pattern_to_output(d,"compare_ints",outputLang);
			if(!acs(outputLang, "Racket,Z3,CLIPS,GNU Smalltalk,newLisp,Hy,Common Lisp,Emacs Lisp,Clojure,Sibilant,LispyScript")){
				return "(" + toReturn +")";
			}
			return toReturn;
		break;
		case "function_call_parameters":
			if(acs(outputLang,"JavaScript,Dafny,Wolfram,Gambas,D,Frink,Chapel,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET")){
				return d.var1 +","+ d.var2;
			}
		break;
		default:
			return pattern_to_output(d,parseTree[0],outputLang);
	}
	if(parseTree[0] === undefined)
		throw(JSON.stringify(parseTree));
	
	var keys = [];
	for(var k in parseTree[1]) keys.push(k);
	throw parseTree[0] + " is not yet defined for " + outputLang + " with keys " + keys.join(",")
}

	var output_dict = {
		'statement':{
			"Java,JavaScript,C#,PHP,Haxe,Ruby":
				"statement = function / foreach / import / switch / if / class / while / for / statement_with_semicolon / comment / multiline_comment",
			"C,Lua,R,Julia,Perl":
				"statement = if / import / while / for / function / statement_with_semicolon / comment / multiline_comment",
			"Z3,Prolog,Haskell":
				"statement = function / import / if / statement_with_semicolon / comment",
		},
		'join':{
			'C':'join = Integer',
		},
		'foreach':{
			'C':'foreach = for',
		},
		'int_to_string':{
			'C':'int_to_string = Integer',
		},
		'split':{
			'C':'split = Integer',
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
			'Java,C#,C++,JavaScript,PHP,Haxe,Fortran':
				'case_statements = a:case _ b:case_statements {return ["case_statements", {a:a, b:b}]} / case',
			'Lua,Python,R,Julia':
				'',
		},
		'switch':{
			'Lua,Python,R,Julia':
				'',
		},
		'default':{
			'Lua,Python,R,Julia':
				'',
		},
		'series_of_statements':{
			'Java,Dafny,Z3,Elm,Bash,Perl 6,Mathematical notation,Katahdin,Frink,MiniZinc,Aldor,COBOL,ooc,Genie,ECLiPSe,nools,Agda,PL/I,REXX,IDP,Falcon,Processing,Sympy,Maxima,Pyke,Elixir,GNU Smalltalk,Seed7,Standard ML,Occam,Boo,Drools,Icon,Mercury,EngScript,Pike,Oz,Kotlin,Pawn,FreeBASIC,Ada,PowerShell,Gosu,Nimrod,Cython,OpenOffice Basic,ALGOL 68,D,Ceylon,Rust,CoffeeScript,ActionScript,TypeScript,Fortran,Octave,ML,AutoHotKey,Delphi,Pascal,F#,Self,Swift,Nemerle,Dart,C,AutoIt,Cobra,Julia,Groovy,Scala,OCaml,Erlang,Gambas,Hack,C++,MATLAB,REBOL,Red,Lua,Go,AWK,Haskell,Perl,Python,JavaScript,C#,PHP,Ruby,R,Haxe,Visual Basic,Visual Basic .NET,Vala,bc':
				pattern_to_input("series_of_statements", "Java") + " / statement",
			'Picat,Prolog':
				pattern_to_input("series_of_statements", "Prolog") +" / statement",
			'Wolfram':
				pattern_to_input("series_of_statements", "Wolfram") +" / statement",
		},
		'multiline_comment':{
			'Java,JavaScript,C,C#,PHP,C++,Haxe,TypeScript':
				'multiline_comment = "/*" var1:((!("*/" / "/*") .)+) "*/" {return ["comment", {var1:text(var1)}];}',
			'Z3,Lua,Ruby,R,Fortran':
				'multiline_comment = comment',
			'Haskell':
				'multiline_comment = "{-|" var1:((!("{-|" / "-}") .)+) "-}" {return ["comment", {var1:text(var1)}];}',
			'Perl':
				'"=begin comment\\n" var1:((!("=begin comment" / "end_comment" / "=cut") .)+) "=end comment\\n=cut\\n"',
		},
		'statement_with_semicolon':{
			'Java,C#,JavaScript,C,PHP,Haxe,Ruby':
				'statement_with_semicolon = var1:(print / set_var / plus_equals / minus_equals / declare_constant / initialize_var / typeless_initialize_var / initialize_empty_var / return / function_call ) _ ";" {return ["statement_with_semicolon", {var1:var1}]}',
			'Z3,Lua':
				'statement_with_semicolon = var1:(print / set_var / plus_equals / minus_equals / declare_constant / initialize_var / typeless_initialize_var / return / function_call ) {return ["statement_with_semicolon", {var1:var1}]}',
			'Lua':
				'statement_with_semicolon = var1:(print / set_var / initialize_empty_var / plus_equals / minus_equals / declare_constant / initialize_var / typeless_initialize_var / return / function_call ) {return ["statement_with_semicolon", {var1:var1}]}',
			'Haskell':
				'statement_with_semicolon = var1:(print / return / function_call ) {return ["statement_with_semicolon", {var1:var1}]}',
		},
		'elif_or_else':{
			'Java,JavaScript,TypeScript,C,C#,Haxe,PHP,Lua,Ruby,R,Fortran,Perl':
				"elif_or_else = elif / else",
			'Z3,CLIPS':
				'',
		},
		'function_parameters':{
			'JavaScript,Dafny,Wolfram,Gambas,D,Frink,Chapel,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET':
				'function_parameters =  var1:function_parameter _ "," _ var2:function_parameters {return ["parameters", {var1:var1, var2:var2}];} /  function_parameter',
			'Hy,Z3,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure':
				'function_parameters =  var1:function_parameter __ var2:function_parameters {return ["parameters", {var1:var1, var2:var2}];} /  function_parameter',

		},
		'class':{
			"C,Z3,Lua":
				'class = function',
		},
		'while':{
			"Z3":
				"",
			"Lua,Ruby,Julia":
				'while = "while" (_ "(" _ condition:Or _ ")" / __ condition:Or) __ body:series_of_statements __ "end" {return ["while", {condition:condition, body:body}]}',

		},
		'And':{
			"JavaScript,Wolfram,D,Chapel,Elixir,Hack,PHP,Frink,ooc,Picat,Janus,Processing,Pike,Pawn,MATLAB,Hack,Gosu,Rust,AutoIt,AutoHotKey,TypeScript,Ceylon,Groovy,Octave,Julia,Scala,F#,Swift,Nemerle,Vala,Dart,C,C++,C#,OCaml,AWK,Java,Haskell,Haxe,Bash,Haxe,Go,Perl,R":
				pattern_to_input('And', "JavaScript") + ' / Or',
			"Python,Mathematical notation,Genie,IDP,Maxima,EngScript,Ada,newLisp,OCaml,Nimrod,CoffeeScript,Pascal,Delphi,Erlang,REBOL,Lua,PHP,crosslanguage,Ruby":
				pattern_to_input('And', "Python") + ' / Or',
			"Fortran":
				pattern_to_input('And', "Fortran") + ' / Or',
			"MiniZinc":
				pattern_to_input('And', "MiniZinc") + ' / Or',
			"Z3":
				pattern_to_input('And', "Z3") + ' / Or',
		},
		'Or':{
			"JavaScript,Wolfram,Chapel,Elixir,Frink,ooc,Picat,Janus,Processing,Pike,nools,Pawn,MATLAB,Hack,Gosu,Rust,AutoIt,AutoHotKey,TypeScript,Ceylon,Groovy,D,Octave,AWK,Julia,Scala,F#,Swift,Nemerle,Vala,Go,Perl,Java,Haskell,Haxe,C,C++,C#,Dart,R":
				pattern_to_input('Or', "JavaScript") + ' / greater_than',
			"Python,Mathematical notation,Genie,IDP,Maxima,EngScript,Ada,newLisp,OCaml,Nimrod,CoffeeScript,Pascal,Delphi,Erlang,REBOL,Lua,PHP,crosslanguage,Ruby":
				pattern_to_input('Or', "Python") + ' / greater_than',				
			"PHP":
				'Or = var1:greater_than (_ "||" _ / __ "or" __) var2:Or {return ["or", {var1:var1, var2:var2}]} / greater_than',
			'Z3':
				pattern_to_input('Or', "Z3") + ' / greater_than',
			"Fortran":
				pattern_to_input('Or', "Fortran") + ' / greater_than',
			"MiniZinc":
				pattern_to_input('Or', "JavaScript") + ' / greater_than',
			
		},
		'greater_than':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'greater_than = var1:Add _ ">" _ var2:Add {return [">", {var1:var1, var2:var2}]} / less_than',
			'Z3':
				'greater_than = "(" _ ">" __ var1:Add __ var2:Add _ ")" {return [">", {var1:var1, var2:var2}]} / less_than',
		},
		'less_than':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'less_than = var1:Add _ "<" _ var2:Add {return ["<", {var1:var1, var2:var2}]} / less_than_or_equal',
			'Z3':
				'less_than = "(" _ ">=" __ var1:Add __ var2:Add _ ")" {return ["<", {var1:var1, var2:var2}]} / less_than_or_equal',
		},
		'less_than_or_equal':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'less_than_or_equal = var1:Add _ "<=" _ var2:Add {return ["<=", {var1:var1, var2:var2}]} / greater_than_or_equal',
			'Z3':
				'less_than_or_equal = "(" _ "<=" __ var1:Add __ var2:Add _ ")" {return ["<=", {var1:var1, var2:var2}]} / greater_than_or_equal',
		},
		'greater_than_or_equal':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'greater_than_or_equal = var1:Add _ ">=" _ var2:Add {return [">=", {var1:var1, var2:var2}]} / compare_ints',
			'Z3':
				'greater_than_or_equal = "(" _ ">=" __ var1:Add __ var2:Add _ ")" {return [">=", {var1:var1, var2:var2}]} / compare_ints',
		},
		'compare_ints':{
			'Lua,Dafny,Wolfram,D,Rust,R,MiniZinc,Frink,Picat,Pike,Pawn,Processing,C++,Ceylon,CoffeeScript,Octave,Swift,AWK,Julia,Perl,Groovy,Erlang,Haxe,Scala,Java,Vala,Dart,Python,C#,C,Go,Haskell,Ruby':
				'compare_ints = var1:Add _ "==" _ var2:Add {return ["compare_ints", {var1:var1, var2:var2}]} / Add',
			'JavaScript,PHP,TypeScript,Hack':
				'compare_ints = var1:Add _ "===" _ var2:Add {return ["compare_ints", {var1:var1, var2:var2}]} / Add',
			'Z3':
				'compare_ints = "(" _ "=" __ var1:Add __ var2:Add _ ")" {return ["compare_ints", {var1:var1, var2:var2}]} / Add',
		},
		'Add':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'Add = var1:Multiply _ symbol:("+"/"-") _ var2:Add {return [symbol,{var1:var1,var2:var2}];} / Multiply',
			'Z3':
				'Add = "(" _ symbol:("+"/"-") __  var1:Multiply __ var2:Add _ ")" {return [symbol,{var1:var1,var2:var2}];} / Multiply',
		},
		'Multiply':{
			"Pascal,Wolfram,Chapel,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET":
				'Multiply = var1:Factor _ symbol:("/"/"*") _ var2:Multiply {return [symbol, {var1:var1,var2:var2}];} / Factor',
			'Z3':
				'Multiply = "(" _ symbol:("/"/"*") __ var1:Factor __ var2:Multiply _ ")" {return [symbol, {var1:var1,var2:var2}];} / Factor',
		},
		'dot_notation':{
			'Java,Lua,JavaScript,D,Haxe,C#,Perl 6,Ruby,TypeScript':
				'dot_notation = var1:Identifier "." var2:dot_notation {return ["dot_notation", {var1:var1, var2:var2}];} / Identifier',
			'PHP,C':
				'dot_notation = var1:Identifier "->" var2:dot_notation {return ["dot_notation", {var1:var1, var2:var2}];} / Identifier',
			'Z3,R':
				"",
		},
		'function_call':{
			"C,Chapel,Elixir,Janus,Perl 6,Pascal,Rust,Hack,Katahdin,MiniZinc,Pawn,Aldor,Picat,D,Genie,ooc,PL/I,Delphi,Standard ML,REXX,Falcon,IDP,Processing,Maxima,Swift,Boo,R,MATLAB,AutoIt,Pike,Gosu,AWK,AutoHotKey,Gambas,Kotlin,Nemerle,EngScript,Prolog,Groovy,Scala,CoffeeScript,Julia,TypeScript,Fortran,Octave,C++,Go,Cobra,Ruby,Vala,F#,Java,Ceylon,OCaml,Erlang,Python,C#,Lua,Haxe,JavaScript,Dart,bc,Visual Basic,Visual Basic .NET,PHP,Perl":
				'function_call = theName:Identifier _ "(" _ args:( function_call_parameters / _ ) _ ")" {return ["function_call", {name:theName, args:args}]}',
			"Z3":
				'function_call = "(" theName:Identifier __ args:( function_call_parameters / _ ) _ ")" {return ["function_call", {name:theName, args:args}]}',
		},
		'parentheses_expression':{
			'Pascal,Katahdin,Frink,MiniZinc,Picat,Java,ECLiPSe,D,ooc,Genie,Janus,PL/I,IDP,Processing,Maxima,Seed7,Self,GNU Smalltalk,Drools,Standard ML,Oz,Cobra,Pike,Prolog,EngScript,Kotlin,Pawn,FreeBASIC,MATLAB,Ada,FreeBASIC,Gosu,Gambas,Nimrod,AutoIt,ALGOL 68,Ceylon,Groovy,Rust,CoffeeScript,TypeScript,Fortran,Octave,ML,Hack,AutoHotKey,Scala,Delphi,Tcl,Swift,Vala,C,F#,C++,Dart,JavaScript,REBOL,Julia,Erlang,OCaml,crosslanguage,C#,Nemerle,AWK,Java,Lua,Perl,Haxe,Python,PHP,Haskell,Go,Ruby,R,bc,Visual Basic,Visual Basic .NET':
				'parentheses_expression = string_literal / "(" var1:expression ")" {return ["parentheses_expression", {"a":var1}];} / function_call / dot_notation'
		},
		'function_call_parameters':{
			'JavaScript,Wolfram,D,Frink,Delphi,EngScript,Chapel,Perl,Swift,Perl 6,OCaml,Janus,Mathematical notation,Pascal,Rust,Picat,AutoHotKey,Maxima,Octave,Julia,R,Prolog,Fortran,Go,MiniZinc,Erlang,CoffeeScript,PHP,Hack,Java,C#,C,C++,Lua,TypeScript,Dart,Ruby,Python,Haxe,Scala,Visual Basic,Visual Basic .NET':
				'function_call_parameters = (var1:expression _ "," _ var2:function_call_parameters) {return ["function_call_parameters", {var1:var1, var2:var2}]} / expression',
			'Hy,crosslanguage,Coq,Scheme,Racket,Common Lisp,CLIPS,REBOL,Haskell,Racket,Clojure,Z3':
				'function_call_parameters = (var1:expression __ var2:function_call_parameters) {return ["function_call_parameters", {var1:var1, var2:var2}]} / expression',
		},
		'this':{
			'Lua,C':'this = Identifier'
		},
		'anonymous_function':{
			'C,C#,Fortran':'anonymous_function = set_var'
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
			"Java,Haxe,JavaScript,TypeScript,C,C++,PHP,Lua,Ruby,R,Lua":
				'Factor = anonymous_function / this / dictionary / initializer_list / access_array / string_to_int / int_to_string / strcmp / function_call / strlen / sqrt / split / string_literal / "(" expr:expression ")" { return ["parentheses_expression", {"a":expr}]; } / pow / sin / cos / tan / dot_notation / Identifier / Integer',
			"C#":
				'Factor =  string_to_int / int_to_string / strcmp / this / dictionary / initializer_list / access_array / function_call / strlen / sqrt / split / string_literal / "(" expr:expression ")" {return ["parentheses_expression", {"a":expr}]} / pow / sin / cos / tan / dot_notation / Identifier / Integer { return expr; }',
			'Z3':
				'Factor = function_call / split / Integer / Identifier / string_literal / "(" expr:expression ")" { return expr; }',
		},
		'type':{
			"Java,C,C#,Haxe":
				'type = var1:_type var2:array_type_suffix {return var1 + var2;} / var1:_type {return var1;}',
			"JavaScript,PHP,Z3,Lua,Ruby,R,Fortran":
				'type = type:_type {return type}',
			'Z3':
				'',
		},
		'_type':{
			"Java,C,C#,Haxe,Ruby,Fortran":
				'_type = char / boolean / int / string / void',
			"Ruby":
				'_type = char / int / string',
			"Z3":
				'_type = int / boolean',
			"PHP,Lua,JavaScript,TypeScript,R":
				'_type = int / string / boolean',
		},
		'boolean':{
			'Ruby':'boolean = int',
		},
		'initialize_empty_var':{
			'Ruby':'initialize_empty_var = initialize_var',
		},
		'char':{
			'Z3':
				'',
			'JavaScript,PHP,Lua,Haxe,C#,Ruby':
				'char = string',
		},
		'string':{
			"Z3":
				'',
		},
		'void':{
			"JavaScript,PHP,Z3,Lua,Ruby":
				'void = int',
		},
		'array_type_suffix':{
			"Java,C#,C++,Haxe":
				'array_type_suffix = var1:"[]" var2:array_type_suffix {return var1 + var2;} / "[]"',
			"C":
				'array_type_suffix = var1:("[]"/"*") var2:array_type_suffix {return var1 + var2;} / ("[]"/ "*")',
			"JavaScript,PHP,Z3,Lua,Ruby":
				"",
		},
		'case':{
			'Lua,Python':
				'',
		},
	}

for(current in thePatterns){
	//throw Object.keys(thePatterns);
	if((current.indexOf(",") === -1) && (current.indexOf(":") === -1) && (current.indexOf(" ") === -1) && (current.indexOf("\t") === -1) && (current !== "")){
	if(!(current in output_dict)){
		output_dict[current] = {};
	}
	for(current1 in thePatterns[current]){
			//throw JSON.stringify(current1+","+current);
			//console.log(thePatterns[current]);
			if(!(current1 in output_dict[current])){
				output_dict[current][current1] = pattern_to_input(current, current1.split(",")[0]);
			}
			//throw(JSON.stringify(output_dict[current]));
	}
}
}
//throw(JSON.stringify(output_dict["comment"]));

function getOutput(lang, statement_name){
	for(var current in output_dict[statement_name]){
		if(acs(lang, current)){
			return "\n" + output_dict[statement_name][current];
		}
	}
	throw statement_name + " is not yet defined for " + lang + " in output_dict";
}

var functions_to_implement = 0;
const list_of_statements = Object.keys(output_dict);
for(var current of list_of_languages){
	for(var current1 of list_of_statements){
		try{
			getOutput(current,current1)
		}
		catch(e){
			console.log(e);
			functions_to_implement += 1;
		}
	}
}
if(functions_to_implement > 0){
	throw "Implement all of these functions.";
}

function generateParser(lang){
	var toReturn = "Main = _ var1:series_of_statements _ {return var1;} / _"
+ "\n" + "expression =  And";

	for(let current of list_of_statements){
		toReturn += getOutput(lang, current);
	}
	toReturn += `
Identifier "identifier" = !(type / Integer / "split" / "equals" / "Console" / "System" / "break" / "while" / "if" / "else" / "ite" / "end" / "then") [a-zA-Z0-9]+ {return text();}
key_value_list = var1:key_value _ var2:key_value_separator _ var3:key_value_list {return ["key_value_list", {var1:var1,var2:var2,var3:var3}]}
/ key_value
_initializer_list = var1:expression _ var2:initializer_list_separator _ var3:_initializer_list {return ["_initializer_list", {var1:var1,var2:var2,var3:var3}];}
/ expression
array_access_list =  var1:expression _ separator:array_access_separator _ var2:array_access_list {return ["array_access_list", {var1:var1, separator:separator, var2:var2}]} / expression
Integer "integer" = [0-9]+ { return text(); }
_ "whitespace" = [ \\t\\n\\r]*
__ "whitespace2" = [ \\t\\n\\r] [ \\t\\n\\r]*  
string_literal = '"' var1:_string_literal '"' {return ["string_literal", {var1:var1}];} / "'" var1:__string_literal "'" {return ["string literal", var1];}
_string_literal = [^"]+ {return text();}
__string_literal = [^']+ {return text();}`
	console.log("\n\n\n\n\n"+toReturn);
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


var parsers = {};
for(var current of list_of_languages){
	var inputText = generateParser(current);
	parsers[current] = PEG.buildParser(inputText);
}

//const parseTree = parsers["Java"].parse(java_input_text);


function translateLang(lang1, lang2, text){
	var parseTree = parsers[lang1].parse(text);
	return generateCode(parseTree, lang2)
}

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

console.log(translateLang("Java", "C#",
`int i = i+3*4+5*3;
boolean b = (3 || 5) && (6 + 7);
System.out.println(a || 4);
System.out.println(a.equals("Hello"));
`));
//console.log(translateLang("Z3", "Lua", "(ite d b c)"));
//console.log(translateLang("C", "Haxe", "bool a = \"Hello\"; printf(3);"));
//console.log(translateLang("Java", "Z3", "public static int add(int a, int b){ if(b == 2){ return 2; } else{return a + b;}}"));
//console.log(translateLang("Java", "C", "String a = 3; System.out.println(a+2*1);"));
