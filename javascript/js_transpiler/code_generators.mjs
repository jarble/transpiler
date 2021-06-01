//import this file into each peggy parser

export function member(lang,list){
	return list.indexOf(lang) !== -1;
}

export function is_declarative_language(lang){
	return member(lang,["erlang","futhark","castor","smt-lib","mathematical notation","haskell","prolog","logtalk","minizinc","reverse polish notation",'z3py','tex']);
}

export function file_extension(lang){
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
		alert("Unknown file extension for "+lang+"!");
	}
}

export function ternary_operator(lang,a,b,c){
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
