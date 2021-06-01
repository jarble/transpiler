//import this file into each peggy parser

function member(lang,list){
	return list.indexOf(lang) !== -1;
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
