//import this file into each peggy parser

function member(lang,list){
	return list.indexOf(lang) !== -1;
}

var statically_typed_languages = ["c","turing","whlsl","cuda","webassembly","aime","parasail","thrift","verilog","nemerle","phix","twelf","q#","eiffel","luck","vhdl","euphoria","ela","gambas","red","protobuf","lustre","cuneiform","simit","pony","c++","openoffice basic","delphi","vba","lean","dafny","alloy","idris","ats","castor","java","choco","z3py","isabelle/hol","c#","scala","opencl","mercury","vala","processing","pl/sql","symbolicc++","kotlin","ooc","hlsl",'ceylon',"d","modelica","object pascal","sql","ada","mysql","transact-sql","fortran","minizinc","go","swift","ada","seed7",'gnu pascal',"pascal","chapel","rust","algol 68","coq","glsl","smt-lib"];
var dynamically_typed_languages = ["squirrel","crystal","zig","cyc","zephir","hylogen","zkl","typescript","hol light","factor","unicon","mizar","purescript","futhark","epigram","systemverilog","terra","autoit","potion","brat","nesl","lush","elm","livecode","harbour","bash","pure","vdm-sl","interactive data language","egison","rascal","order","eff","lfe","erre","ioke","falcon","yacas","spad","postscript","limbo","jq","purebasic","clay","icon","spad","scala-parser-combinators","forth","apl","powershell","applescript","jump","aimms","gams","dypgen","owl","cup","rbnf","pegex","arcsecond","pike","instaparse","bennu","swrl","pseudocode","io","smalltalk","flix","rexx","sibilant","openscad","songbird","racc","reasonml","tla+","citrus","walrat","citron","shen","dms","common prolog","angstrom","agda","parse::recdescent","tatsu","pypeg","parsimonious","yapps","pyparsing","mouse","yecc","nez","parsec.el","neotoma","parser-gen","parsimmon","lemon","treetop","canopy","xbnf","clp(r)","clp(b)","clp(fd)","logpy","reazon","core.logic","minikanren","minikanren.lua","whyml","waxeye","java cup","oak","chevrotain","ileansep","ileantap","coffeequate","acl2","axiom","alt-ergo","lark","pari/gp","grammatica","ohm","gold","lpeg","tptp","peg.js","parslet","ometa","marpa","yacc","antlr","chrg","visual basic .net","regex","txl","picolisp","pawn","transpose","oz","pythological","logtalk","cobra","groovy","f#","reasoned-php","sidef","actionscript","newlisp","awk","symja","emacs lisp","matlab","mediawiki","frink","nim","asciimath","regular expression","regular expressions","syntax definition formalism","visual basic .net","cython","maple","coconut","sage","algebrite","reverse polish notation","reduce","dart","autohotkey","sage","pseudocode","coffeescript","vb .net","hack","yacas","nearley","jison","abnf","xquery","haxe","kif","pyke","drools","javascript","haskell","tex","mathematical notation","sympy","clips","picat","pddl","python","perl 6","maxima","hy","standard ml","ocaml","gap",'english',"php","ruby","lua","perl","common lisp","racket","scheme","rebol","wolfram","r","prolog","tcl","clojure","erlang","julia","elixir",'octave','wolfram'];

function is_declarative_language(lang){
	return member(lang,["erlang","futhark","castor","smt-lib","mathematical notation","haskell","prolog","logtalk","minizinc","reverse polish notation",'z3py','tex']);
}

function file_extension(lang){
	if(lang === "c++"){
		return "cpp";
	}
	else if(lang === "openscad"){
		return "scad";
	}
	else if(lang === "squirrel"){
		return "nut";
	}
	else if(lang === "metamath"){
		return "mm";
	}
	else if(lang === "genie"){
		return "gs";
	}
	else if(lang === "pure"){
		return "pure";
	}
	else if(lang === "cuda"){
		return "cu";
	}
	else if(lang === "opencl"){
		return "cl";
	}
	else if(lang === "zig"){
		return "zig";
	}
	else if(lang === "cuneiform"){
		return "cl";
	}
	else if(lang === "mizar"){
		return "miz";
	}
	else if(lang === "frege"){
		return "fr";
	}
	else if(lang === "kit"){
		return "kit";
	}
	else if(lang === "terra"){
		return "t";
	}
	else if(lang === "egison"){
		return "egi";
	}
	else if(lang === "asymptote"){
		return "asy";
	}
	else if(lang === "drools"){
		return "drl";
	}
	else if(lang === "ring"){
		return "ring";
	}
	else if(lang === "minion"){
		return "minion";
	}
	else if(lang === "maude"){
		return "maude";
	}
	else if(lang === "csh"){
		return "csh";
	}
	else if(lang === "pvs"){
		return "pvs";
	}
	else if(lang === "postscript"){
		return "ps";
	}
	else if(lang === "picolisp"){
		return "l";
	}
	else if(lang === "forth"){
		return "fs";
	}
	else if(lang === "batch file"){
		return "bat";
	}
	else if(lang === "flatzinc"){
		return "fzn";
	}
	else if(lang === "q#"){
		return "qs";
	}
	else if(lang === "futhark"){
		return "fut";
	}
	else if(lang === "clips"){
		return "clp";
	}
	else if(lang === "grammar::aycock"){
		return "tcl";
	}
	else if(lang === "felix"){
		return "flx";
	}
	else if(lang === "pegex"){
		return "pgx";
	}
	else if(lang === "cobol"){
		return "cbl";
	}
	else if(lang === "bracmat"){
		return "bra";
	}
	else if(lang === "rbnf"){
		return "rbnf";
	}
	else if(lang === "tameparse"){
		return "tp";
	}
	else if(lang === "coconut"){
		return "coco";
	}
	else if(lang === "logtalk"){
		return "lgt";
	}
	else if(lang === "gnu smalltalk"){
		return "gst";
	}
	else if(lang === "lean"){
		return "lean";
	}
	else if(lang === "songbird"){
		return "sb";
	}
	else if(lang === "yecc"){
		return "yrl";
	}
	else if(member(lang,["racc","citron"])){
		return "y";
	}
	else if(lang === "twelf"){
		return "elf";
	}
	else if(lang === "reasonml"){
		return "re";
	}
	else if(lang === "redline smalltalk"){
		return "st";
	}
	else if(lang === "nez"){
		return "nez";
	}
	else if(lang === "isabelle/hol"){
		return "thy";
	}
	else if(lang === "modelica"){
		return "mo";
	}
	else if(lang === "txl"){
		return "txl";
	}
	else if(lang === "gocc"){
		return "bnf";
	}
	else if(lang === "autohotkey"){
		return "ahk";
	}
	else if(lang === "fortran"){
		return "f90";
	}
	else if(lang === "julia"){
		return "jl";
	}
	else if(member(lang, ["coq","verilog"])){
		return "v";
	}
	else if(member(lang, ["systemverilog"])){
		return "svh";
	}
	else if(lang === "picat"){
		return "pi";
	}
	else if(lang === "php"){
		return "php";
	}
	else if(lang === "wolfram"){
		return "wl";
	}
	else if(lang === "erlang"){
		return "erl";
	}
	else if(lang === "kotlin"){
		return "kts";
	}
	else if(lang === "pddl"){
		return "pddl";
	}
	else if(lang === "standard ml"){
		return "sml";
	}
	else if(lang === "thrift"){
		return "thrift";
	}
	else if(lang === "go"){
		return "go";
	}
	else if(lang === "racket"){
		return "rkt";
	}
	else if(lang === "glsl"){
		return "clp";
	}
	else if(lang === "clojure"){
		return "clj";
	}
	else if(lang === "ada"){
		return "ada";
	}
	else if(lang === "rust"){
		return "rust";
	}
	else if(lang === "scala"){
		return "scala";
	}
	else if(lang === "c"){
		return "c";
	}
	else if(lang === "smt-lib"){
		return "smt2";
	}
	else if(member(lang,["octave","matlab","mercury"])){
		return "m";
	}
	else if(lang === "seed7"){
		return "s7i";
	}
	else if(member(lang,["rebol","r"])){
		return "r";
	}
	else if(lang === "javascript"){
		return "js";
	}
	else if(lang === "swift"){
		return "swift";
	}
	else if(lang === "common lisp"){
		return "lisp";
	}
	else if(lang === "java"){
		return "js";
	}
	else if(lang === "ruby"){
		return "rb";
	}
	else if(lang === "visual basic .net"){
		return "vb";
	}
	else if(lang === "haxe"){
		return "hx";
	}
	else if(lang === "lua"){
		return "lua";
	}
	else if(lang === "typescript"){
		return "ts";
	}
	else if(lang === "minizinc"){
		return "mzn";
	}
	else if(lang === "haskell"){
		return "hs";
	}
	else if(lang === "c#"){
		return "cs";
	}
	else if(member(lang,["perl","prolog","constraint handling rules"])){
		return "pl";
	}
	else if(member(lang,["maxima"])){
		return "mc";
	}
	else if(member(lang,["coffeescript"])){
		return "coffee";
	}
	else if(member(lang,["python","sympy"])){
		return "py";
	}
	else if(member(lang,["mysql"])){
		return "sql";
	}
	else if(member(lang,["protobuf"])){
		return "proto";
	}
	else if(member(lang,["canopy","neotoma","pegasus"])){
		return "peg";
	}
	else if(member(lang,["perl 6"])){
		return "p6";
	}
	else if(member(lang,["lark"])){
		return "lark";
	}
	else if(member(lang,["emacs lisp"])){
		return "el";
	}
	else if(member(lang,["agda"])){
		return "agda";
	}
	else{
		alert("Unknown file extension for "+lang+"!");;
	}
}

function ternary_operator(lang,a,b,c){
		return member(lang,["java","openscad","reasonml","vala","sidef","dart","tcl","autohotkey","javascript","typescript","c","c#","haxe","c++","perl","ruby","julia","awk","swift"])
			? a+"?"+b+":"+c
		: member(lang,["php","hack"])
			? "("+a+"?"+b+":"+c+")"
		: member(lang,["perl 6"])
			? "("+a+"??"+b+"!!"+c+")"
		: member(lang,["algol 68"])
			? "("+a+"|"+b+"|"+c+")"
		: member(lang,["modelica","ocaml","lustre","isabelle/hol","xquery","futhark","coffeescript","standard ml","ada","coq","chapel","haskell","ada","mercury"])
			? "(if "+a+" then "+b+" else "+c+")"
		: member(lang,["python","coconut"])
			? "("+b+" if "+a+" else "+c+")"
		: member(lang,["fermat"])
			? " if"+a+" then "+b+" else "+c+"fi "
		: member(lang,["nim"])
			? "(if "+a+": " +b+ " else: "+c+")"
		: member(lang,["rust"])
			? "(if "+a+"{"+b+"} else {"+c+"})"
		: member(lang,["lua"])
			? "(("+a+") and ("+b+") or ("+c+"))"
		: member(lang,["visual basic .net"])
			? "If("+a+","+b+","+c+")"
		: member(lang,["octave"])
			? "ifelse("+a+","+b+","+c+")"
		: member(lang,["smt-lib"])
			? "(ite "+a+" "+b+" "+c+")"
		: member(lang,["minizinc"])
			? "if "+a+" then "+b+" else "+c+" endif"
		: member(lang,["alloy"])
			? "(("+a+") implies ("+b+") else ("+c+"))"
		: member(lang,["mediawiki"])
			? "{{#ifexpr:"+a+"|"+b+"|"+c+"}}"
		: member(lang,["coffeescript","kotlin","r","scala"])
			? "(if ("+a+") "+b+" else "+c+")"
		: undefined;
}

function or_expression(a,b){
		if(member(lang,["javascript","zig","hlsl","whlsl","cuda","futhark","reasonml","jump","dafny","alloy","castor","sidef","coq","lc++","tcl","autohotkey","katahdin","perl 6","ruby","wolfram","chapel","elixir","frink","ooc","picat","janus","processing","pike","nools","pawn","matlab","hack","gosu","rust","autoit","autohotkey","typescript","ceylon","groovy","d","octave","awk","julia","scala","f#","swift","nemerle","vala","go","perl","java","haskell","elm","haxe","c","c++","c#","dart","r"])){
			return "("+a + "||" + b+")";
		}
		else if(member(lang,["cyc"])){
			return "(#$or " + a + " " + b+")";
		}
		else if(member(lang,["reverse polish notation","postscript","forth"])){
			return a + " " + b+" or";
		}
		else if(member(lang,["tex"])){
			return a + " \\lor " + b;
		}
		else if(member(lang,["asciimath"])){
			return a + " vv " + b;
		}
		else if(member(lang,["powershell"])){
			return a + " -OR " + b;
		}
		else if(member(lang,["mumps"])){
			return a + "!" + b;
		}
		else if(member(lang,["owl"])){
			return "ObjectIntersectionOf(" + a + " " + b+")";
		}
		else if(member(lang,["minikanren.lua"])){
			return "all(" + a + "," + b+")";
		}
		else if(member(lang,["logpy","minikanren.lua"])){
			return "conde(" + a + "," + b+")";
		}
		else if(member(lang,["minikanren"])){
			return "(conde " + a + " " + b+"))";
		}
		else if(member(lang,["reazon"])){
			return "(reazon-conde " + a + " " + b+"))";
		}
		else if(member(lang,["core.logic"])){
			return "(conde [" + a + " " + b+"])";
		}
		else if(member(lang,["mukanren.jl"])){
			return "@conde(" + a + "," + b+")";
		}
		else if(member(lang,["minizinc","abella","hol light","whyml","lean"])){
			return a + "\\/" + b;
		}
		else if(member(lang,["algol 68"])){
			return a + " orelse " + b;
		}
		else if(member(lang,["visual basic","vba","openoffice basic","vba","monkey x","visual basic .net","yacas"])){
			return a + " Or " + b;
		}
		else if(member(lang,["logicjs","reasoned-php","algebrite"])){
			return "or(" + a + "," + b + ")";
		}
		else if(member(lang,["mathematical notation","isabelle/hol"])){
			return a + "\u2228" + b;
		}
		else if(member(lang,["cosmos","zkl","lustre","simit","mediawiki","mizar","aimms","modelica","gams","alt-ergo","pl/sql","mysql","cython","vhdl","python","coconut","lua","seed7","livecode","englishscript","cython","gap","mathematical notation","genie","idp","maxima","engscript","ada","newlisp","ocaml","nim","coffeescript","pascal","delphi","erlang","rebol","php"])){
			return a + " or " + b;
		}
		else if(member(lang,["smt-lib","kif","hy","acl2","snark","common lisp","shen","clips","pddl","clojure","common lisp","emacs lisp","clojure","racket"])){
			return "(or "+a+" "+b+")";
		}
		else if(member(lang,["z3py","gologic","pysmt"])){
			return "Or("+a+","+b+")";
		}
		else if(member(lang,["prolog","clp(fd)","constraint handling rules","ileansep","ileantap"])){
			return a+";"+b;
		}
		else if(member(lang,["fortran"])){
			return a+" .or. "+b;
		}
		else if(member(lang,["clp(b)"])){
			return a+"+"+b;
		}
		else if(member(lang,["tptp","verilog","songbird","sympy"])){
			return a+" | "+b;
		}
}

function eager_and(a,b){
	return member(lang,["javascript","tptp","python","c++","c#","php","smalltalk","perl","ruby","java","julia","matlab","r","swift"])
			? a + "&" + b
		: member(lang,["erlang","pascal"])
			? a + " and " + b
		: member(lang,["prolog"])
			? a + ", " + b
		: member(lang,["erlang","pascal"])
			? a + " And " + b:
		undefined;
}


function eager_or(a,b){
		return member(lang,["javascript","tptp","python","c++","c#","php","smalltalk","perl","ruby","java","julia","matlab","r","swift"])
			? a + "|" + b
		: member(lang,["erlang","pascal"])
			? a + " or " + b
		: member(lang,["prolog"])
			? a + "; " + b
		: member(lang,["erlang","pascal"])
			? a + " Or " + b
		:undefined;
}
