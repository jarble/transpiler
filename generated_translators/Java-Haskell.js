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
    {"name": "arithmetic_expression", "symbols": ["expression"]},
    {"name": "boolean_expression", "symbols": ["expression"]},
    {"name": "string_expression", "symbols": ["expression"]},
    {"name": "array_expression", "symbols": ["expression"]},
    {"name": "expression", "symbols": ["accessArray"]},
    {"name": "expression", "symbols": ["this"]},
    {"name": "expression", "symbols": ["functionCall"]},
    {"name": "expression", "symbols": ["varName"]},
    {"name": "expression", "symbols": ["dictionary"]},
    {"name": "expression", "symbols": ["declare_new_object"]},
    {"name": "expression", "symbols": ["parentheses_expression"]},
    {"name": "expression", "symbols": ["string_to_int"]},
    {"name": "expression", "symbols": ["add"]},
    {"name": "expression", "symbols": ["subtract"]},
    {"name": "expression", "symbols": ["multiply"]},
    {"name": "expression", "symbols": ["mod"]},
    {"name": "expression", "symbols": ["divide"]},
    {"name": "expression", "symbols": ["number"]},
    {"name": "expression", "symbols": ["pow"]},
    {"name": "expression", "symbols": ["strlen"]},
    {"name": "expression", "symbols": ["sin"]},
    {"name": "expression", "symbols": ["cos"]},
    {"name": "expression", "symbols": ["tan"]},
    {"name": "expression", "symbols": ["sqrt"]},
    {"name": "expression", "symbols": ["array_length"]},
    {"name": "expression", "symbols": ["String"]},
    {"name": "expression", "symbols": ["concatenateString"]},
    {"name": "expression", "symbols": ["substring"]},
    {"name": "expression", "symbols": ["int_to_string"]},
    {"name": "expression", "symbols": ["split"]},
    {"name": "expression", "symbols": ["join"]},
    {"name": "expression", "symbols": ["initializerList"]},
    {"name": "expression", "symbols": ["false"]},
    {"name": "expression", "symbols": ["true"]},
    {"name": "expression", "symbols": ["not_equal"]},
    {"name": "expression", "symbols": ["greaterThan"]},
    {"name": "expression", "symbols": ["compareInts"]},
    {"name": "expression", "symbols": ["strcmp"]},
    {"name": "expression", "symbols": ["lessThanOrEqual"]},
    {"name": "expression", "symbols": ["greaterThanOrEqual"]},
    {"name": "expression", "symbols": ["lessThan"]},
    {"name": "expression", "symbols": ["and"]},
    {"name": "expression", "symbols": ["or"]},
    {"name": "expression", "symbols": ["not"]},
    {"name": "expression", "symbols": ["arrayContains"]},
    {"name": "statement", "symbols": ["constructor"]},
    {"name": "statement", "symbols": ["plusEquals"]},
    {"name": "statement", "symbols": ["minusEquals"]},
    {"name": "statement", "symbols": ["declare_constant"]},
    {"name": "statement", "symbols": ["instance_method"]},
    {"name": "statement", "symbols": ["static_method"]},
    {"name": "statement", "symbols": ["initializeArray"]},
    {"name": "statement", "symbols": ["print"]},
    {"name": "statement", "symbols": ["comment"]},
    {"name": "statement", "symbols": ["switch"]},
    {"name": "statement", "symbols": ["setVar"]},
    {"name": "statement", "symbols": ["initializeVar"]},
    {"name": "statement", "symbols": ["func"]},
    {"name": "statement", "symbols": ["functionCallStatement"]},
    {"name": "statement", "symbols": ["return"]},
    {"name": "statement", "symbols": ["if"]},
    {"name": "statement", "symbols": ["while"]},
    {"name": "statement", "symbols": ["forInRange"]},
    {"name": "type", "symbols": ["boolean"]},
    {"name": "type", "symbols": ["int"]},
    {"name": "type", "symbols": ["string"]},
    {"name": "type", "symbols": ["auto"]},
    {"name": "type", "symbols": ["arrayType"]},
    {"name": "type", "symbols": ["void"]},
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
    {"name": "functionCallParameters", "symbols": ["functionCallParameters", "_", "parameter_separator", "_", "expression"], "postprocess":  function(d) {return d.join(""); } },
    {"name": "functionCallParameters", "symbols": ["expression"]},
    {"name": "functionCallParameters", "symbols": []},
    {"name": "keyValueList", "symbols": ["_keyValueList"]},
    {"name": "_keyValueList", "symbols": ["_keyValueList", "_", "keyValueSeparator", "_", "keyValue"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_keyValueList", "symbols": ["keyValue"]},
    {"name": "_initializerList", "symbols": ["_initializerList", "_", "initializerListSeparator", "_", "expression"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_initializerList", "symbols": ["expression"]},
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
    {"name": " string$2", "symbols": [{"literal":"I"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$3", "symbols": [{"literal":"t"}, {"literal":"o"}, {"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int_to_string", "symbols": [" string$2", "_", {"literal":"."}, "_", " string$3", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "show" + " " + d[8] + ")";
}},
    {"name": " string$4", "symbols": [{"literal":"s"}, {"literal":"p"}, {"literal":"l"}, {"literal":"i"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "split", "symbols": ["expression", "_", {"literal":"."}, "_", " string$4", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "splitOn" + " " + d[0] + " " + d[8] + ")";
}},
    {"name": " string$5", "symbols": [{"literal":"I"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$6", "symbols": [{"literal":"p"}, {"literal":"a"}, {"literal":"r"}, {"literal":"s"}, {"literal":"e"}, {"literal":"I"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string_to_int", "symbols": [" string$5", "_", {"literal":"."}, "_", " string$6", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "read" + " " + d[8] + ")";
}},
    {"name": " string$7", "symbols": [{"literal":"f"}, {"literal":"i"}, {"literal":"n"}, {"literal":"a"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "declare_constant", "symbols": [" string$7", "_", "__", "_", "type", "_", "__", "_", "varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[8] + "=" + d[12] + "\n";
}},
    {"name": "initializeArray", "symbols": ["arrayType", "_", "__", "_", "identifier", "_", {"literal":"="}, "_", "array_expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[4] + "=" + d[8] + "\n";
}},
    {"name": "accessArray", "symbols": ["identifier", "_", {"literal":"["}, "_", "arithmetic_expression", "_", {"literal":"]"}], "postprocess": function(d){
	return "(a" + "!!" + "b)";
}},
    {"name": "initializerListSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": "initializerList", "symbols": [{"literal":"{"}, "_", "_initializerList", "_", {"literal":"}"}], "postprocess": function(d){
	return "[" + d[2] + "]";
}},
    {"name": " string$8", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$9", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sin", "symbols": [" string$8", "_", {"literal":"."}, "_", " string$9", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "sin" + " " + d[8] + ")";
}},
    {"name": " string$10", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$11", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "cos", "symbols": [" string$10", "_", {"literal":"."}, "_", " string$11", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "cos" + " " + d[8] + ")";
}},
    {"name": " string$12", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$13", "symbols": [{"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "tan", "symbols": [" string$12", "_", {"literal":"."}, "_", " string$13", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "tan" + d[8] + ")";
}},
    {"name": " string$14", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "true", "symbols": [" string$14"], "postprocess": function(d){
	return "True";
}},
    {"name": " string$15", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "false", "symbols": [" string$15"], "postprocess": function(d){
	return "False";
}},
    {"name": " string$16", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["arithmetic_expression", "_", " string$16", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "==" + d[4];
}},
    {"name": "parentheses_expression", "symbols": [{"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + d[2] + ")";
}},
    {"name": "greaterThan", "symbols": ["arithmetic_expression", "_", {"literal":">"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + ">" + d[4];
}},
    {"name": "lessThan", "symbols": ["arithmetic_expression", "_", {"literal":"<"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "<" + d[4];
}},
    {"name": " string$17", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$18", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class", "symbols": [" string$17", "_", "__", "_", " string$18", "_", "__", "_", "identifier", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return d[12];
}},
    {"name": " string$19", "symbols": [{"literal":"A"}, {"literal":"r"}, {"literal":"r"}, {"literal":"a"}, {"literal":"y"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$20", "symbols": [{"literal":"a"}, {"literal":"s"}, {"literal":"L"}, {"literal":"i"}, {"literal":"s"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$21", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"t"}, {"literal":"a"}, {"literal":"i"}, {"literal":"n"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "arrayContains", "symbols": [" string$19", "_", {"literal":"."}, "_", " string$20", "_", {"literal":"("}, "_", "array_expression", "_", {"literal":")"}, "_", {"literal":"."}, "_", " string$21", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "elem" + " " + d[18] + " " + d[8] + ")";
}},
    {"name": " string$22", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$23", "symbols": [{"literal":"p"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": [" string$22", "_", {"literal":"."}, "_", " string$23", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[8] + "**" + d[12];
}},
    {"name": " string$24", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_or", "symbols": ["arithmetic_expression", "_", " string$24", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "||" + d[4];
}},
    {"name": "or", "symbols": ["_or"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$25", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_and", "symbols": ["boolean_expression", "_", " string$25", "_", "boolean_expression"], "postprocess": function(d){
	return d[0] + "&&" + d[4];
}},
    {"name": "and", "symbols": ["_and"], "postprocess": function(d){
	return d[0];
}},
    {"name": "not", "symbols": [{"literal":"!"}, "_", "boolean_expression"], "postprocess": function(d){
	return "not" + d[2];
}},
    {"name": "_multiply", "symbols": ["arithmetic_expression", "_", {"literal":"*"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "*" + d[4];
}},
    {"name": "multiply", "symbols": ["_multiply"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_divide", "symbols": ["arithmetic_expression", "_", {"literal":"/"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "/" + d[4];
}},
    {"name": "divide", "symbols": ["_divide"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_add", "symbols": ["arithmetic_expression", "_", {"literal":"+"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "+" + d[4];
}},
    {"name": "add", "symbols": ["_add"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_subtract", "symbols": ["arithmetic_expression", "_", {"literal":"-"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "-" + d[4];
}},
    {"name": "subtract", "symbols": ["_subtract"], "postprocess": function(d){
	return d[0];
}},
    {"name": "functionCall", "symbols": ["identifier", "_", {"literal":"("}, "_", "functionCallParameters", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + d[0] + " " + d[4] + ")";
}},
    {"name": "concatenateString", "symbols": ["string_expression", "_", {"literal":"+"}, "_", "string_expression"], "postprocess": function(d){
	return d[0] + "++" + d[4];
}},
    {"name": "initializeVar", "symbols": ["type", "_", "__", "_", "varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[4] + "=" + d[8] + "\n";
}},
    {"name": " string$26", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$26", "_", "__", "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[4];
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$27", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$28", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "func", "symbols": [" string$27", "_", "__", "_", " string$28", "_", "__", "_", "type", "_", "__", "_", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return d[12] + " " + d[16] + "=" + "\n" + d[22];
}},
    {"name": " string$29", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$29", "_", {"literal":"("}, "_", "boolean_expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "if" + " " + d[4] + " " + "then" + " " + d[10] + " " + d[14];
}},
    {"name": " string$30", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$31", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$30", "_", "__", "_", " string$31", "_", {"literal":"("}, "_", "boolean_expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + " " + "if" + " " + d[8] + " " + "then" + " " + d[14] + " " + "c";
}},
    {"name": " string$32", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$32", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + " " + d[4];
}},
    {"name": " string$33", "symbols": [{"literal":"i"}, {"literal":"m"}, {"literal":"p"}, {"literal":"o"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$33", "_", "__", "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return "import" + " " + d[4];
}},
    {"name": " string$34", "symbols": [{"literal":"S"}, {"literal":"y"}, {"literal":"s"}, {"literal":"t"}, {"literal":"e"}, {"literal":"m"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$35", "symbols": [{"literal":"o"}, {"literal":"u"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$36", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"t"}, {"literal":"l"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$34", "_", {"literal":"."}, "_", " string$35", "_", {"literal":"."}, "_", " string$36", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":";"}], "postprocess": function(d){
	return "(" + "putStrLn" + " " + d[12] + ")";
}},
    {"name": " string$37", "symbols": [{"literal":"/"}, {"literal":"/"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "comment", "symbols": [" string$37", "_", "_string", "_", {"literal":"\n"}], "postprocess": function(d){
	return "--" + d[2] + "\n";
}},
    {"name": "mod", "symbols": ["arithmetic_expression", "_", {"literal":"%"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + " " + "mod" + " " + d[4];
}},
    {"name": "setVar", "symbols": ["varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return d[0] + "=" + d[4] + "\n";
}},
    {"name": "parameter", "symbols": ["type", "_", "__", "_", "varName"], "postprocess": function(d){
	return d[4];
}},
    {"name": " string$38", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}, {"literal":"e"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "boolean", "symbols": [" string$38"], "postprocess": function(d){
	return "Bool";
}},
    {"name": " string$39", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$39"], "postprocess": function(d){
	return "Num";
}},
    {"name": " string$40", "symbols": [{"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$40"], "postprocess": function(d){
	return "String";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall", "_", {"literal":";"}], "postprocess": function(d){
	return d[0] + ";";
}},
    {"name": " string$41", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "greaterThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$41", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + ">=" + d[4];
}},
    {"name": " string$42", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "lessThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$42", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "<=" + d[4];
}},
    {"name": " string$43", "symbols": [{"literal":"s"}, {"literal":"w"}, {"literal":"i"}, {"literal":"t"}, {"literal":"c"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "switch", "symbols": [" string$43", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseStatements", "_", "__", "_", "default", "_", {"literal":"}"}], "postprocess": function(d){
	return "case" + " " + d[4] + " " + "of" + " " + d[10] + " " + d[14] + " " + "end";
}},
    {"name": " string$44", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$45", "symbols": [{"literal":"b"}, {"literal":"r"}, {"literal":"e"}, {"literal":"a"}, {"literal":"k"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "case", "symbols": [" string$44", "_", "__", "_", "expression", "_", {"literal":":"}, "_", "series_of_statements", "_", " string$45", "_", {"literal":";"}], "postprocess": function(d){
	return d[4] + " " + "->" + "\n" + d[8];
}},
    {"name": " string$46", "symbols": [{"literal":"d"}, {"literal":"e"}, {"literal":"f"}, {"literal":"a"}, {"literal":"u"}, {"literal":"l"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "default", "symbols": [" string$46", "_", {"literal":":"}, "_", "series_of_statements"], "postprocess": function(d){
	return "\_" + "->" + "\n" + " " + d[4];
}},
    {"name": " string$47", "symbols": [{"literal":"s"}, {"literal":"u"}, {"literal":"b"}, {"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "substring", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$47", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return "take" + "(" + d[12] + "-" + d[8] + ")" + "." + "drop" + d[8] + "$" + d[0];
}},
    {"name": " string$48", "symbols": [{"literal":"e"}, {"literal":"q"}, {"literal":"u"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$48", "_", {"literal":"("}, "_", "string_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "==" + d[8];
}},
    {"name": " string$49", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_length", "symbols": ["array_expression", "_", {"literal":"."}, "_", " string$49"], "postprocess": function(d){
	return "(" + "length" + " " + d[0] + ")";
}},
    {"name": " string$50", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$50", "_", {"literal":"("}, "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "length" + d[0] + ")";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return " ";
}},
    {"name": " subexpression$1", "symbols": ["_series_of_statements"]},
    {"name": " subexpression$1", "symbols": ["class"]},
    {"name": " subexpression$1", "symbols": ["class_extends"]}
]
  , ParserStart: "chunk"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
