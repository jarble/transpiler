// Generated automatically by nearley
// http://github.com/Hardmath123/nearley
(function () {
function id(x) {return x[0]; }
var grammar = {
    ParserRules: [
    {"name": "chunk", "symbols": ["_", " subexpression$1", "_"], "postprocess": function(d){return d[1][0];}},
    {"name": "_series_of_statements", "symbols": ["series_of_statements", "_", "statement"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "_series_of_statements", "symbols": ["statement"], "postprocess": function(d){return d[0];}},
    {"name": "_series_of_statements", "symbols": []},
    {"name": "series_of_statements", "symbols": ["statement"], "postprocess": function(d){return d[0];}},
    {"name": "series_of_statements", "symbols": ["series_of_statements", "_", "statement"], "postprocess": function(d){return d[0] + "\n" + d[2];}},
    {"name": "expression", "symbols": [{"literal":"("}, "_", "expression", "_", {"literal":")"}]},
    {"name": "expression", "symbols": ["func"]},
    {"name": "expression", "symbols": ["compareInts"]},
    {"name": "expression", "symbols": ["lessThan"]},
    {"name": "expression", "symbols": ["greaterThan"]},
    {"name": "expression", "symbols": ["number"]},
    {"name": "expression", "symbols": ["String"]},
    {"name": "expression", "symbols": ["varName"]},
    {"name": "expression", "symbols": ["add"]},
    {"name": "expression", "symbols": ["subtract"]},
    {"name": "expression", "symbols": ["multiply"]},
    {"name": "expression", "symbols": ["divide"]},
    {"name": "expression", "symbols": ["mod"]},
    {"name": "expression", "symbols": ["functionCall"]},
    {"name": "statement", "symbols": ["print"]},
    {"name": "statement", "symbols": ["comment"]},
    {"name": "statement", "symbols": ["switch"]},
    {"name": "statement", "symbols": ["setVar"]},
    {"name": "statement", "symbols": ["initializeVariable"]},
    {"name": "statement", "symbols": ["func"]},
    {"name": "statement", "symbols": ["functionCallStatement"]},
    {"name": "statement", "symbols": ["return"]},
    {"name": "statement", "symbols": ["if"]},
    {"name": "statement", "symbols": ["while"]},
    {"name": "statement", "symbols": ["forLoop"]},
    {"name": "type", "symbols": ["boolean"]},
    {"name": "type", "symbols": ["int"]},
    {"name": "type", "symbols": ["string"]},
    {"name": "caseStatements", "symbols": ["caseStatements", "_", "case"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "caseStatements", "symbols": ["case"]},
    {"name": "elifStatements", "symbols": ["elifStatements", "_", "elif"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "elifStatements", "symbols": ["elif"]},
    {"name": "elifOrElse", "symbols": ["else"]},
    {"name": "elifOrElse", "symbols": ["elifStatements", "_", "else"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "parameterList", "symbols": ["_parameterList"]},
    {"name": "parameterList", "symbols": []},
    {"name": "_parameterList", "symbols": ["_parameterList", "_", "parameter_separator", "_", "parameter"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_parameterList", "symbols": ["parameter"]},
    {"name": "functionCallParameters", "symbols": ["functionCallParameters", "_", "parameter_separator", "_", "expression"]},
    {"name": "functionCallParameters", "symbols": ["expression"]},
    {"name": "functionCallParameters", "symbols": []},
    {"name": "identifier", "symbols": ["_name"], "postprocess":  function(d) {return d[0]; } },
    {"name": "_name", "symbols": [/[a-zA-Z_]/], "postprocess":  id },
    {"name": "_name", "symbols": ["_name", /[\w_]/], "postprocess":  function(d) {return d[0] + d[1]; } },
    {"name": "number", "symbols": ["_number"], "postprocess":  function(d) {return parseFloat(d[0])} },
    {"name": "_posint", "symbols": [/[0-9]/], "postprocess":  id },
    {"name": "_posint", "symbols": ["_posint", /[0-9]/], "postprocess":  function(d) {return d[0] + d[1]} },
    {"name": "_int", "symbols": [{"literal":"-"}, "_posint"], "postprocess":  function(d) {return d[0] + d[1]; }},
    {"name": "_int", "symbols": ["_posint"], "postprocess":  id },
    {"name": "_float", "symbols": ["_int"], "postprocess":  id },
    {"name": "_float", "symbols": ["_int", {"literal":"."}, "_posint"], "postprocess":  function(d) {return d[0] + d[1] + d[2]; }},
    {"name": "_number", "symbols": ["_float"], "postprocess":  id },
    {"name": "_number", "symbols": ["_float", {"literal":"e"}, "_int"], "postprocess":  function(d){return d[0] + d[1] + d[2]; } },
    {"name": "String", "symbols": [{"literal":"\""}, "_string", {"literal":"\""}], "postprocess":  function(d) {return '"' + d[1] + '"'; } },
    {"name": "_string", "symbols": [], "postprocess":  function() {return ""; } },
    {"name": "_string", "symbols": ["_string", "_stringchar"], "postprocess":  function(d) {return d[0] + d[1];} },
    {"name": "_stringchar", "symbols": [/[^\\"]/], "postprocess":  id },
    {"name": "_stringchar", "symbols": [{"literal":"\\"}, /[^]/], "postprocess":  function(d) {return JSON.parse("\"" + d[0] + d[1] + "\""); } },
    {"name": "_", "symbols": []},
    {"name": "_", "symbols": ["_", /[\s]/], "postprocess":  function() {} },
    {"name": "__", "symbols": [/[\s]/]},
    {"name": "__", "symbols": ["__", /[\s]/], "postprocess":  function() {} },
    {"name": " string$2", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["expression", "_", " string$2", "_", "expression"], "postprocess": function(d){
	return d[0] + "==" + d[4];
}},
    {"name": "greaterThan", "symbols": ["expression", "_", {"literal":">"}, "_", "expression"], "postprocess": function(d){
	return d[0] + ">" + d[4];
}},
    {"name": "lessThan", "symbols": ["expression", "_", {"literal":"<"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "<" + d[4];
}},
    {"name": " string$3", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$4", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class", "symbols": [" string$3", "_", "__", "_", " string$4", "_", "__", "_", "identifier", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "class" + " " + d[8] + "{" + d[12] + "}";
}},
    {"name": " string$5", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$6", "symbols": [{"literal":"p"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": [" string$5", "_", {"literal":"."}, "_", " string$6", "_", {"literal":"("}, "_", "expression", "_", {"literal":","}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "." + "Pow" + "(" + d[8] + "," + d[12] + ")";
}},
    {"name": " string$7", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "or", "symbols": ["expression", "_", " string$7", "_", "expression"], "postprocess": function(d){
	return d[0] + "||" + d[4];
}},
    {"name": " string$8", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "and", "symbols": ["expression", "_", " string$8", "_", "expression"], "postprocess": function(d){
	return d[0] + "&&" + d[4];
}},
    {"name": "not", "symbols": [{"literal":"!"}, "_", "expression"], "postprocess": function(d){
	return "!" + d[2];
}},
    {"name": "multiply", "symbols": ["expression", "_", {"literal":"*"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "*" + d[4];
}},
    {"name": "divide", "symbols": ["expression", "_", {"literal":"/"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "/" + d[4];
}},
    {"name": "add", "symbols": ["expression", "_", {"literal":"+"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "+" + d[4];
}},
    {"name": "subtract", "symbols": ["expression", "_", {"literal":"-"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "-" + d[4];
}},
    {"name": "functionCall", "symbols": ["identifier", "_", {"literal":"("}, "_", "functionCallParameters", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "(" + d[4] + ")";
}},
    {"name": "concatenateString", "symbols": ["expression", "_", {"literal":"+"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "+" + d[4];
}},
    {"name": "initializeVariable", "symbols": ["type", "_", "__", "_", "varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[0] + " " + d[4] + "=" + d[8] + ";";
}},
    {"name": " string$9", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$9", "_", "__", "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return "return" + " " + d[4] + ";";
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$10", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$11", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "func", "symbols": [" string$10", "_", "__", "_", " string$11", "_", "__", "_", "type", "_", "__", "_", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[8] + " " + d[12] + "(" + d[16] + ")" + "{" + d[22] + "}";
}},
    {"name": " string$12", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$12", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "if" + "(" + d[4] + ")" + "{" + d[10] + "}" + d[14];
}},
    {"name": " string$13", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$14", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$13", "_", "__", "_", " string$14", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + " " + "if" + "(" + d[8] + ")" + "{" + d[14] + "}";
}},
    {"name": " string$15", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$15", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + "{" + d[4] + "}";
}},
    {"name": " string$16", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "while", "symbols": [" string$16", "_", "expression", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "while" + d[2] + "{" + d[6] + "}";
}},
    {"name": " string$17", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "forLoop", "symbols": [" string$17", "_", {"literal":"("}, "_", "statement", "_", "statement", "_", "statement", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "for" + "(" + d[4] + d[6] + d[8] + ")" + "{" + d[14] + "}";
}},
    {"name": " string$18", "symbols": [{"literal":"i"}, {"literal":"m"}, {"literal":"p"}, {"literal":"o"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$18", "_", "__", "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return "using" + " " + d[4] + ";";
}},
    {"name": " string$19", "symbols": [{"literal":"S"}, {"literal":"y"}, {"literal":"s"}, {"literal":"t"}, {"literal":"e"}, {"literal":"m"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$20", "symbols": [{"literal":"o"}, {"literal":"u"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$21", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"t"}, {"literal":"l"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$19", "_", {"literal":"."}, "_", " string$20", "_", {"literal":"."}, "_", " string$21", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":";"}], "postprocess": function(d){
	return "Console" + "." + "WriteLine" + "(" + d[12] + ")" + ";";
}},
    {"name": " string$22", "symbols": [{"literal":"/"}, {"literal":"/"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "comment", "symbols": [" string$22", "_", "_string", "_", {"literal":"\n"}], "postprocess": function(d){
	return "//" + d[2] + "\n";
}},
    {"name": "mod", "symbols": ["expression", "_", {"literal":"%"}, "_", "expression"], "postprocess": function(d){
	return d[0] + "%" + d[4];
}},
    {"name": "setVar", "symbols": ["varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[0] + "=" + d[4] + ";";
}},
    {"name": "parameter", "symbols": ["type", "_", "__", "_", "varName"], "postprocess": function(d){
	return d[0] + " " + d[4];
}},
    {"name": " string$23", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}, {"literal":"e"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "boolean", "symbols": [" string$23"], "postprocess": function(d){
	return "bool";
}},
    {"name": " string$24", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$24"], "postprocess": function(d){
	return "int";
}},
    {"name": " string$25", "symbols": [{"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$25"], "postprocess": function(d){
	return "string";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall", "_", {"literal":";"}], "postprocess": function(d){
	return d[0] + ";";
}},
    {"name": " string$26", "symbols": [{"literal":"s"}, {"literal":"w"}, {"literal":"i"}, {"literal":"t"}, {"literal":"c"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "switch", "symbols": [" string$26", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseStatements", "_", "default", "_", {"literal":"}"}], "postprocess": function(d){
	return "switch" + "(" + d[4] + ")" + "{" + d[10] + d[12] + "}";
}},
    {"name": " string$27", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "case", "symbols": [" string$27", "_", "__", "_", "expression", "_", {"literal":":"}, "_", "series_of_statements"], "postprocess": function(d){
	return "case" + " " + d[4] + ":" + d[8];
}},
    {"name": " string$28", "symbols": [{"literal":"b"}, {"literal":"r"}, {"literal":"e"}, {"literal":"a"}, {"literal":"k"}, {"literal":";"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "break", "symbols": [" string$28"], "postprocess": function(d){
	return "break;";
}},
    {"name": " string$29", "symbols": [{"literal":"d"}, {"literal":"e"}, {"literal":"f"}, {"literal":"a"}, {"literal":"u"}, {"literal":"l"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "default", "symbols": [" string$29", "_", {"literal":":"}, "_", {"literal":"\n"}, "_", "series_of_statements"], "postprocess": function(d){
	return "default" + ":" + "\n" + d[6];
}},
    {"name": " string$30", "symbols": [{"literal":"s"}, {"literal":"u"}, {"literal":"b"}, {"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "substring", "symbols": ["expression", "_", {"literal":"."}, "_", " string$30", "_", {"literal":"("}, "_", "expression", "_", {"literal":","}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "." + "Substring" + "(" + d[8] + ")";
}},
    {"name": " string$31", "symbols": [{"literal":"e"}, {"literal":"q"}, {"literal":"u"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": ["expression", "_", {"literal":"."}, "_", " string$31", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "." + "Equals" + "(" + d[8] + ")";
}},
    {"name": " string$32", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": ["expression", "_", {"literal":"."}, "_", " string$32", "_", {"literal":"("}, "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "." + "Length";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " subexpression$1", "symbols": ["_series_of_statements"]},
    {"name": " subexpression$1", "symbols": ["class"]}
]
  , ParserStart: "chunk"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
