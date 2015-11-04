// Generated automatically by nearley
// http://github.com/Hardmath123/nearley
(function () {
function id(x) {return x[0]; }
var grammar = {
    ParserRules: [
    {"name": "chunk", "symbols": ["_", " subexpression$1", "_"], "postprocess": function(d){
	toReturn = d[1][0];
	if(Array.isArray(toReturn)){
		return d.join("");
	}
	else{
		return d[1][0];
	}
}},
    {"name": "series_of_statements", "symbols": ["statement"], "postprocess": function(d){return d[0];}},
    {"name": "series_of_statements", "symbols": ["series_of_statements", "statement_separator", "__", "statement"], "postprocess": function(d){return d[0] + d[1] + "\n" + d[3];}},
    {"name": "dot_notation", "symbols": ["dot_notation", "_dot_notation", "identifier"], "postprocess": function(d){ return d[0] + d[1] + d[2] }},
    {"name": "dot_notation", "symbols": ["identifier"]},
    {"name": "arithmetic_expression", "symbols": ["expression"]},
    {"name": "boolean_expression", "symbols": ["expression"]},
    {"name": "string_expression", "symbols": ["expression"]},
    {"name": "array_expression", "symbols": ["expression"]},
    {"name": "statement_with_semicolon", "symbols": ["statement_without_semicolon", "_", "semicolon"], "postprocess":  function(d){return d[0] + d[2]; }},
    {"name": "expression", "symbols": ["string_to_regex"]},
    {"name": "expression", "symbols": ["accessArray"]},
    {"name": "expression", "symbols": ["this"]},
    {"name": "expression", "symbols": ["functionCall"]},
    {"name": "expression", "symbols": ["varName"]},
    {"name": "expression", "symbols": ["dictionary"]},
    {"name": "expression", "symbols": ["declare_new_object"]},
    {"name": "expression", "symbols": ["parentheses_expression"]},
    {"name": "expression", "symbols": ["pi"]},
    {"name": "expression", "symbols": ["natural_logarithm"]},
    {"name": "expression", "symbols": ["absolute_value"]},
    {"name": "expression", "symbols": ["floor"]},
    {"name": "expression", "symbols": ["ceiling"]},
    {"name": "expression", "symbols": ["string_to_int"]},
    {"name": "expression", "symbols": ["add"]},
    {"name": "expression", "symbols": ["subtract"]},
    {"name": "expression", "symbols": ["multiply"]},
    {"name": "expression", "symbols": ["mod"]},
    {"name": "expression", "symbols": ["divide"]},
    {"name": "expression", "symbols": ["number"]},
    {"name": "expression", "symbols": ["pow"]},
    {"name": "expression", "symbols": ["strlen"]},
    {"name": "expression", "symbols": ["asin"]},
    {"name": "expression", "symbols": ["acos"]},
    {"name": "expression", "symbols": ["atan"]},
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
    {"name": "expression", "symbols": ["startswith"]},
    {"name": "expression", "symbols": ["endswith"]},
    {"name": "expression", "symbols": ["globalReplace"]},
    {"name": "expression", "symbols": ["initializerList"]},
    {"name": "expression", "symbols": ["range"]},
    {"name": "expression", "symbols": ["false"]},
    {"name": "expression", "symbols": ["true"]},
    {"name": "expression", "symbols": ["instanceof"]},
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
    {"name": "expression", "symbols": ["stringContains"]},
    {"name": "statement_without_semicolon", "symbols": ["typeless_variable_declaration"]},
    {"name": "statement_without_semicolon", "symbols": ["setVar"]},
    {"name": "statement_without_semicolon", "symbols": ["increment"]},
    {"name": "statement_without_semicolon", "symbols": ["decrement"]},
    {"name": "statement_without_semicolon", "symbols": ["initializeEmptyVar"]},
    {"name": "statement_without_semicolon", "symbols": ["initializeVar"]},
    {"name": "statement_without_semicolon", "symbols": ["typeless_initializeVar"]},
    {"name": "statement_without_semicolon", "symbols": ["functionCall"]},
    {"name": "statement_without_semicolon", "symbols": ["exception"]},
    {"name": "statement_without_semicolon", "symbols": ["return"]},
    {"name": "statement_without_semicolon", "symbols": ["functionCallStatement"]},
    {"name": "statement_without_semicolon", "symbols": ["plusEquals"]},
    {"name": "statement_without_semicolon", "symbols": ["minusEquals"]},
    {"name": "statement_without_semicolon", "symbols": ["declare_constant"]},
    {"name": "statement_without_semicolon", "symbols": ["initializeArray"]},
    {"name": "statement_without_semicolon", "symbols": ["print"]},
    {"name": "statement", "symbols": ["func"]},
    {"name": "statement", "symbols": ["statement_with_semicolon"]},
    {"name": "statement", "symbols": ["for_loop"]},
    {"name": "statement", "symbols": ["typeless_function"]},
    {"name": "statement", "symbols": ["comment"]},
    {"name": "statement", "symbols": ["switch"]},
    {"name": "statement", "symbols": ["if"]},
    {"name": "statement", "symbols": ["while"]},
    {"name": "statement", "symbols": ["forInRange"]},
    {"name": "class_statement_without_semicolon", "symbols": ["initialize_static_variable_with_value"]},
    {"name": "class_statement_without_semicolon", "symbols": ["initialize_instance_variable_with_value"]},
    {"name": "class_statement_without_semicolon", "symbols": ["initialize_static_variable"]},
    {"name": "class_statement_without_semicolon", "symbols": ["initialize_instance_variable"]},
    {"name": "class_statement_with_semicolon", "symbols": ["class_statement_without_semicolon", "_", "semicolon"], "postprocess":  function(d){return d[0] + d[2]; }},
    {"name": "class_statement", "symbols": ["constructor"]},
    {"name": "class_statement", "symbols": ["instance_method"]},
    {"name": "class_statement", "symbols": ["static_method"]},
    {"name": "class_statement", "symbols": ["comment"]},
    {"name": "class_statement", "symbols": ["class_statement_with_semicolon"]},
    {"name": "_class_statements", "symbols": ["class_statements", "_", "class_statement"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "_class_statements", "symbols": ["class_statement"], "postprocess": function(d){return d[0];}},
    {"name": "_class_statements", "symbols": []},
    {"name": "class_statements", "symbols": ["class_statement"], "postprocess": function(d){return d[0];}},
    {"name": "class_statements", "symbols": ["class_statements", "_", "class_statement"], "postprocess": function(d){return d[0] + "\n" + d[2];}},
    {"name": "type", "symbols": ["boolean"]},
    {"name": "type", "symbols": ["int"]},
    {"name": "type", "symbols": ["double"]},
    {"name": "type", "symbols": ["string"]},
    {"name": "type", "symbols": ["auto"]},
    {"name": "type", "symbols": ["arrayType"]},
    {"name": "type", "symbols": ["void"]},
    {"name": "type", "symbols": ["dictionary_type"]},
    {"name": "caseStatements", "symbols": ["caseStatements", "_", "case"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "caseStatements", "symbols": ["case"]},
    {"name": "elifOrElse", "symbols": ["else"]},
    {"name": "elifOrElse", "symbols": ["elif"]},
    {"name": "parameterList", "symbols": ["_parameterList"]},
    {"name": "parameterList", "symbols": []},
    {"name": "_parameterList", "symbols": ["_parameterList", "_", "parameter_separator", "_", " subexpression$2"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_parameterList", "symbols": [" subexpression$3"]},
    {"name": "typeless_parameters", "symbols": ["_typeless_parameters"]},
    {"name": "typeless_parameters", "symbols": []},
    {"name": "_typeless_parameters", "symbols": ["_typeless_parameters", "_", "parameter_separator", "_", "typeless_parameter"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_typeless_parameters", "symbols": ["typeless_parameter"]},
    {"name": "functionCallParameters", "symbols": ["functionCallParameters", "_", "function_call_parameter_separator", "_", " subexpression$4"], "postprocess":  function(d) {return d.join(""); } },
    {"name": "functionCallParameters", "symbols": [" subexpression$5"]},
    {"name": "functionCallParameters", "symbols": []},
    {"name": "keyValueList", "symbols": ["_keyValueList"]},
    {"name": "_keyValueList", "symbols": ["_keyValueList", "_", "keyValueSeparator", "_", "keyValue"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_keyValueList", "symbols": ["keyValue"]},
    {"name": "_initializerList", "symbols": ["_initializerList", "_", "initializerListSeparator", "_", "expression"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_initializerList", "symbols": ["expression"]},
    {"name": "array_access_list", "symbols": ["array_access_index"]},
    {"name": "array_access_list", "symbols": ["array_access_list", "array_access_separator", "array_access_index"], "postprocess": function(d){return d[0]+d[1]+d[2]}},
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
    {"name": " string$6", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "increment", "symbols": ["expression", "_", " string$6"], "postprocess": function(d){
	return d[0] + "" + "++";
}},
    {"name": " string$7", "symbols": [{"literal":"-"}, {"literal":"-"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "decrement", "symbols": ["expression", "_", " string$7"], "postprocess": function(d){
	return d[0] + "" + "--";
}},
    {"name": " string$8", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$9", "symbols": [{"literal":"f"}, {"literal":"l"}, {"literal":"o"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "floor", "symbols": [" string$8", "_", {"literal":"."}, "_", " string$9", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Floor" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$10", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$11", "symbols": [{"literal":"c"}, {"literal":"e"}, {"literal":"i"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "ceiling", "symbols": [" string$10", "_", {"literal":"."}, "_", " string$11", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Ceiling" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$12", "symbols": [{"literal":"O"}, {"literal":"b"}, {"literal":"j"}, {"literal":"e"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_initializeVar", "symbols": [" string$12", "__", "varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "var" + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$13", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$14", "symbols": [{"literal":"a"}, {"literal":"b"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "absolute_value", "symbols": [" string$13", "_", {"literal":"."}, "_", " string$14", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Abs" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$15", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$16", "symbols": [{"literal":"l"}, {"literal":"o"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "natural_logarithm", "symbols": [" string$15", "_", {"literal":"."}, "_", " string$16", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Log" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$17", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$18", "symbols": [{"literal":"P"}, {"literal":"I"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pi", "symbols": [" string$17", "_", {"literal":"."}, "_", " string$18"], "postprocess": function(d){
	return "Math" + "" + "." + "" + "PI";
}},
    {"name": " string$19", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$20", "symbols": [{"literal":"a"}, {"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "asin", "symbols": [" string$19", "_", {"literal":"."}, "_", " string$20", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Asin" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$21", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$22", "symbols": [{"literal":"a"}, {"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "acos", "symbols": [" string$21", "_", {"literal":"."}, "_", " string$22", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Acos" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$23", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$24", "symbols": [{"literal":"a"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "atan", "symbols": [" string$23", "_", {"literal":"."}, "_", " string$24", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Atan" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$25", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"p"}, {"literal":"l"}, {"literal":"a"}, {"literal":"c"}, {"literal":"e"}, {"literal":"A"}, {"literal":"l"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "globalReplace", "symbols": ["expression", "_", {"literal":"."}, "_", " string$25", "_", {"literal":"("}, "_", "expression", "_", {"literal":","}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Replace" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}},
    {"name": " string$26", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"t"}, {"literal":"a"}, {"literal":"i"}, {"literal":"n"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "stringContains", "symbols": ["expression", "_", {"literal":"."}, "_", " string$26", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Contains" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$27", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"s"}, {"literal":"W"}, {"literal":"i"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "endswith", "symbols": ["expression", "_", {"literal":"."}, "_", " string$27", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Contains" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$28", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"r"}, {"literal":"t"}, {"literal":"s"}, {"literal":"W"}, {"literal":"i"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$29", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"t"}, {"literal":"a"}, {"literal":"i"}, {"literal":"n"}, {"literal":"e"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "startswith", "symbols": ["expression", "_", {"literal":"."}, "_", " string$28", "_", {"literal":"("}, "_", " string$29", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "StartsWith" + "" + "(" + "" + "contained" + "" + ")";
}},
    {"name": "statement_separator", "symbols": ["_"], "postprocess": function(d){
	return "";
}},
    {"name": " string$30", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "for_loop", "symbols": [" string$30", "_", {"literal":"("}, "_", "statement_without_semicolon", "_", {"literal":";"}, "_", "expression", "_", {"literal":";"}, "_", "statement_without_semicolon", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "for" + "" + "(" + "" + d[4] + "" + ";" + "" + d[8] + "" + ";" + "" + d[12] + "" + ")" + "" + "{" + "" + d[18] + "" + "}";
}},
    {"name": " string$31", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"v"}, {"literal":"a"}, {"literal":"t"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "initialize_instance_variable", "symbols": [" string$31", "__", "type", "__", "identifier"], "postprocess": function(d){
	return "private" + " " + d[2] + " " + d[4];
}},
    {"name": " string$32", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"v"}, {"literal":"a"}, {"literal":"t"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "initialize_instance_variable_with_value", "symbols": [" string$32", "__", "type", "__", "identifier", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "private" + " " + d[2] + " " + d[4] + "" + "=" + "" + d[8];
}},
    {"name": " string$33", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$34", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "initialize_static_variable", "symbols": [" string$33", "__", " string$34", "__", "type", "__", "identifier"], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6];
}},
    {"name": " string$35", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$36", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "initialize_static_variable_with_value", "symbols": [" string$35", "__", " string$36", "__", "type", "__", "identifier", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "=" + "" + d[10];
}},
    {"name": " string$37", "symbols": [{"literal":"O"}, {"literal":"b"}, {"literal":"j"}, {"literal":"e"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_parameter", "symbols": [" string$37", "__", "identifier"], "postprocess": function(d){
	return "object" + " " + d[2];
}},
    {"name": " string$38", "symbols": [{"literal":"O"}, {"literal":"b"}, {"literal":"j"}, {"literal":"e"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_function", "symbols": [" string$38", "__", "identifier", "_", {"literal":"("}, "_", "typeless_parameters", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + "object" + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}},
    {"name": " string$39", "symbols": [{"literal":"O"}, {"literal":"b"}, {"literal":"j"}, {"literal":"e"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_variable_declaration", "symbols": [" string$39", "__", "varName", "_", {"literal":"="}, "_", "identifier"], "postprocess": function(d){
	return "var" + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$40", "symbols": [{"literal":"I"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$41", "symbols": [{"literal":"t"}, {"literal":"o"}, {"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int_to_string", "symbols": [" string$40", "_", {"literal":"."}, "_", " string$41", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Convert" + "" + "." + "" + "ToString" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$42", "symbols": [{"literal":"s"}, {"literal":"p"}, {"literal":"l"}, {"literal":"i"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "split", "symbols": ["expression", "_", {"literal":"."}, "_", " string$42", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Split" + "" + "(" + "" + "new" + "" + "string[]" + "" + "{" + "" + d[8] + "" + "}" + "" + "," + "" + "StringSplitOptions" + "" + "." + "" + "None" + "" + ")";
}},
    {"name": " string$43", "symbols": [{"literal":"a"}, {"literal":"r"}, {"literal":"r"}, {"literal":"a"}, {"literal":"y"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$44", "symbols": [{"literal":"j"}, {"literal":"o"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$45", "symbols": [{"literal":"s"}, {"literal":"e"}, {"literal":"p"}, {"literal":"a"}, {"literal":"r"}, {"literal":"a"}, {"literal":"t"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "join", "symbols": [" string$43", "_", {"literal":"."}, "_", " string$44", "_", {"literal":"("}, "_", " string$45", "_", {"literal":")"}], "postprocess": function(d){
	return "String" + "" + "." + "" + "Join" + "" + "(" + "" + "separator" + "" + "," + "" + "array" + "" + ")";
}},
    {"name": "function_call_parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$46", "symbols": [{"literal":"P"}, {"literal":"a"}, {"literal":"t"}, {"literal":"t"}, {"literal":"e"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "regex", "symbols": [" string$46"], "postprocess": function(d){
	return "Regex";
}},
    {"name": " string$47", "symbols": [{"literal":"I"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$48", "symbols": [{"literal":"p"}, {"literal":"a"}, {"literal":"r"}, {"literal":"s"}, {"literal":"e"}, {"literal":"I"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string_to_int", "symbols": [" string$47", "_", {"literal":"."}, "_", " string$48", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Int32" + "" + "." + "" + "Parse(" + "" + d[8] + "" + ")";
}},
    {"name": " string$49", "symbols": [{"literal":"f"}, {"literal":"i"}, {"literal":"n"}, {"literal":"a"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "declare_constant", "symbols": [" string$49", "__", "type", "__", "varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "const" + " " + d[2] + " " + d[4] + "" + "=" + "" + d[8];
}},
    {"name": "initializeArray", "symbols": ["arrayType", "__", "identifier", "_", {"literal":"="}, "_", "array_expression"], "postprocess": function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$50", "symbols": [{"literal":"]"}, {"literal":"["}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_access_separator", "symbols": [" string$50"], "postprocess": function(d){
	return ",";
}},
    {"name": "array_access_index", "symbols": ["expression"], "postprocess": function(d){
	return d[0];
}},
    {"name": "accessArray", "symbols": ["identifier", "_", {"literal":"["}, "_", "array_access_list", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "" + "[" + "" + d[4] + "" + "]";
}},
    {"name": " string$51", "symbols": [{"literal":"["}, {"literal":"]"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "arrayType", "symbols": ["type", "_", " string$51"], "postprocess": function(d){
	return d[0] + "" + "[]";
}},
    {"name": "initializerListSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": "initializerList", "symbols": [{"literal":"{"}, "_", "_initializerList", "_", {"literal":"}"}], "postprocess": function(d){
	return "{" + "" + d[2] + "" + "}";
}},
    {"name": " string$52", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "keyValue", "symbols": [" string$52", "_", {"literal":"("}, "_", "identifier", "_", {"literal":","}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "{" + "" + d[4] + "" + "," + "" + d[8] + "" + "}";
}},
    {"name": " string$53", "symbols": [{"literal":"c"}, {"literal":"h"}, {"literal":"a"}, {"literal":"r"}, {"literal":"A"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "charAt", "symbols": ["expression", "_", {"literal":"."}, "_", " string$53", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "[" + "" + d[8] + "" + "]";
}},
    {"name": " string$54", "symbols": [{"literal":"O"}, {"literal":"b"}, {"literal":"j"}, {"literal":"e"}, {"literal":"c"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "auto", "symbols": [" string$54"], "postprocess": function(d){
	return "object";
}},
    {"name": " string$55", "symbols": [{"literal":"v"}, {"literal":"o"}, {"literal":"i"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "void", "symbols": [" string$55"], "postprocess": function(d){
	return "void";
}},
    {"name": " string$56", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$57", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sin", "symbols": [" string$56", "_", {"literal":"."}, "_", " string$57", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Sin" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$58", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$59", "symbols": [{"literal":"s"}, {"literal":"q"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sqrt", "symbols": [" string$58", "_", {"literal":"."}, "_", " string$59", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Sqrt" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$60", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$61", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "cos", "symbols": [" string$60", "_", {"literal":"."}, "_", " string$61", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Cos" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$62", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$63", "symbols": [{"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "tan", "symbols": [" string$62", "_", {"literal":"."}, "_", " string$63", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Tan" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$64", "symbols": [{"literal":"n"}, {"literal":"e"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$65", "symbols": [{"literal":"H"}, {"literal":"a"}, {"literal":"s"}, {"literal":"h"}, {"literal":"M"}, {"literal":"a"}, {"literal":"p"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "dictionary", "symbols": [" string$64", "__", " string$65", "_", {"literal":"<"}, "_", "type", "_", {"literal":","}, "_", "type", "_", {"literal":">"}, "_", {"literal":"("}, "_", {"literal":")"}, "_", {"literal":"{"}, "_", {"literal":"{"}, "_", "keyValueList", "_", {"literal":"}"}, "_", {"literal":"}"}], "postprocess": function(d){
	return "new" + " " + "Dictionary" + "" + "<" + "" + d[6] + "" + "," + "" + d[10] + "" + ">" + "" + "{" + "" + d[22] + "" + "}";
}},
    {"name": "keyValueSeparator", "symbols": [{"literal":";"}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$66", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "true", "symbols": [" string$66"], "postprocess": function(d){
	return "true";
}},
    {"name": " string$67", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "false", "symbols": [" string$67"], "postprocess": function(d){
	return "false";
}},
    {"name": " string$68", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["arithmetic_expression", "_", " string$68", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "==" + "" + d[4];
}},
    {"name": "parentheses_expression", "symbols": [{"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "(" + "" + d[2] + "" + ")";
}},
    {"name": "greaterThan", "symbols": ["arithmetic_expression", "_", {"literal":">"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + ">" + "" + d[4];
}},
    {"name": "lessThan", "symbols": ["arithmetic_expression", "_", {"literal":"<"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "<" + "" + d[4];
}},
    {"name": " string$69", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$70", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$71", "symbols": [{"literal":"e"}, {"literal":"x"}, {"literal":"t"}, {"literal":"e"}, {"literal":"n"}, {"literal":"d"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class_extends", "symbols": [" string$69", "__", " string$70", "__", "identifier", "__", " string$71", "__", "identifier", "_", {"literal":"{"}, "_", "class_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "class" + " " + d[4] + " " + "extends" + " " + d[8] + "" + "{" + "" + d[12] + "" + "}";
}},
    {"name": " string$72", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$73", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class", "symbols": [" string$72", "__", " string$73", "__", "identifier", "_", {"literal":"{"}, "_", "class_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "class" + " " + d[4] + "" + "{" + "" + d[8] + "" + "}";
}},
    {"name": " string$74", "symbols": [{"literal":"A"}, {"literal":"r"}, {"literal":"r"}, {"literal":"a"}, {"literal":"y"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$75", "symbols": [{"literal":"a"}, {"literal":"s"}, {"literal":"L"}, {"literal":"i"}, {"literal":"s"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$76", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"t"}, {"literal":"a"}, {"literal":"i"}, {"literal":"n"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "arrayContains", "symbols": [" string$74", "_", {"literal":"."}, "_", " string$75", "_", {"literal":"("}, "_", "array_expression", "_", {"literal":")"}, "_", {"literal":"."}, "_", " string$76", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[8] + "" + "." + "" + "Contains" + "" + "(" + "" + d[18] + "" + ")";
}},
    {"name": " string$77", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"i"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "this", "symbols": [" string$77", "_", {"literal":"."}, "_", "varName"], "postprocess": function(d){
	return "this" + "" + "." + "" + d[4];
}},
    {"name": " string$78", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$79", "symbols": [{"literal":"p"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": [" string$78", "_", {"literal":"."}, "_", " string$79", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "Pow" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}},
    {"name": " string$80", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_or", "symbols": ["arithmetic_expression", "_", " string$80", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "||" + "" + d[4];
}},
    {"name": "or", "symbols": ["_or"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$81", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_and", "symbols": ["boolean_expression", "_", " string$81", "_", "boolean_expression"], "postprocess": function(d){
	return d[0] + "" + "&&" + "" + d[4];
}},
    {"name": "and", "symbols": ["_and"], "postprocess": function(d){
	return d[0];
}},
    {"name": "not", "symbols": [{"literal":"!"}, "_", "boolean_expression"], "postprocess": function(d){
	return "!" + "" + d[2];
}},
    {"name": "_multiply", "symbols": ["arithmetic_expression", "_", {"literal":"*"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "*" + "" + d[4];
}},
    {"name": "multiply", "symbols": ["_multiply"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_divide", "symbols": ["arithmetic_expression", "_", {"literal":"/"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "/" + "" + d[4];
}},
    {"name": "divide", "symbols": ["_divide"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_add", "symbols": ["arithmetic_expression", "_", {"literal":"+"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "+" + "" + d[4];
}},
    {"name": "add", "symbols": ["_add"], "postprocess": function(d){
	return d[0];
}},
    {"name": "_subtract", "symbols": ["arithmetic_expression", "_", {"literal":"-"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "-" + "" + d[4];
}},
    {"name": "subtract", "symbols": ["_subtract"], "postprocess": function(d){
	return d[0];
}},
    {"name": "functionCall", "symbols": ["dot_notation", "_", {"literal":"("}, "_", "functionCallParameters", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$82", "symbols": [{"literal":"d"}, {"literal":"o"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "double", "symbols": [" string$82"], "postprocess": function(d){
	return "double";
}},
    {"name": "concatenateString", "symbols": ["string_expression", "_", {"literal":"+"}, "_", "string_expression"], "postprocess": function(d){
	return d[0] + "" + "+" + "" + d[4];
}},
    {"name": "initializeVar", "symbols": ["type", "__", "varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$83", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$83", "__", "expression"], "postprocess": function(d){
	return "return" + " " + d[2];
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$84", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$85", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "func", "symbols": [" string$84", "__", " string$85", "__", "type", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "(" + "" + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}},
    {"name": " string$86", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$86", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "if" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}" + "" + d[14];
}},
    {"name": " string$87", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$88", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$87", "__", " string$88", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "else" + " " + "if" + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}" + "" + d[16];
}},
    {"name": " string$89", "symbols": [{"literal":"+"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "plusEquals", "symbols": ["expression", "_", " string$89", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "+=" + "" + d[4];
}},
    {"name": " string$90", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "minusEquals", "symbols": ["expression", "_", " string$90", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "-=" + "" + d[4];
}},
    {"name": " string$91", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$91", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + "" + "{" + "" + d[4] + "" + "}";
}},
    {"name": " string$92", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "while", "symbols": [" string$92", "_", {"literal":"("}, "_", "boolean_expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "while" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}";
}},
    {"name": " string$93", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$94", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$95", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "forInRange", "symbols": [" string$93", "_", {"literal":"("}, "_", " string$94", "__", "varName", "_", {"literal":"="}, "_", "arithmetic_expression", "_", {"literal":";"}, "_", "varName", "_", {"literal":"<"}, "_", "arithmetic_expression", "_", {"literal":";"}, "_", "varName", "_", " string$95", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "for" + "" + "(" + "" + "int" + " " + d[6] + "" + "=" + "" + d[10] + "" + ";" + "" + d[6] + "" + "<" + "" + d[18] + "" + ";" + "" + d[6] + "" + "++" + "" + ")" + "" + "{" + "" + d[30] + "" + "}";
}},
    {"name": " string$96", "symbols": [{"literal":"i"}, {"literal":"m"}, {"literal":"p"}, {"literal":"o"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$96", "__", "expression", "_", {"literal":";"}], "postprocess": function(d){
	return "using" + " " + d[2] + "" + ";";
}},
    {"name": " string$97", "symbols": [{"literal":"S"}, {"literal":"y"}, {"literal":"s"}, {"literal":"t"}, {"literal":"e"}, {"literal":"m"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$98", "symbols": [{"literal":"o"}, {"literal":"u"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$99", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"t"}, {"literal":"l"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$97", "_", {"literal":"."}, "_", " string$98", "_", {"literal":"."}, "_", " string$99", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Console" + "" + "." + "" + "WriteLine" + "" + "(" + "" + d[12] + "" + ")";
}},
    {"name": " string$100", "symbols": [{"literal":"/"}, {"literal":"/"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "comment", "symbols": [" string$100", "_", "_string"], "postprocess": function(d){
	return "//" + "" + d[2];
}},
    {"name": "mod", "symbols": ["arithmetic_expression", "_", {"literal":"%"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "%" + "" + d[4];
}},
    {"name": "semicolon", "symbols": [{"literal":";"}], "postprocess": function(d){
	return ";";
}},
    {"name": "setVar", "symbols": ["varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "=" + "" + d[4];
}},
    {"name": "parameter", "symbols": ["type", "__", "varName"], "postprocess": function(d){
	return d[0] + " " + d[2];
}},
    {"name": " string$101", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}, {"literal":"c"}, {"literal":"e"}, {"literal":"o"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "instanceof", "symbols": ["expression", "__", " string$101", "__", "type"], "postprocess": function(d){
	return d[0] + " " + "as" + " " + d[4];
}},
    {"name": "_dot_notation", "symbols": [{"literal":"."}], "postprocess": function(d){
	return ".";
}},
    {"name": "initializeEmptyVar", "symbols": ["type", "__", "varName"], "postprocess": function(d){
	return d[0] + " " + d[2];
}},
    {"name": " string$102", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}, {"literal":"e"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "boolean", "symbols": [" string$102"], "postprocess": function(d){
	return "bool";
}},
    {"name": " string$103", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$103"], "postprocess": function(d){
	return "int";
}},
    {"name": " string$104", "symbols": [{"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$104"], "postprocess": function(d){
	return "string";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall", "_", "semicolon"], "postprocess": function(d){
	return d[0] + "" + d[2];
}},
    {"name": " string$105", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "greaterThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$105", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + ">=" + "" + d[4];
}},
    {"name": " string$106", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "lessThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$106", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "<=" + "" + d[4];
}},
    {"name": " string$107", "symbols": [{"literal":"s"}, {"literal":"w"}, {"literal":"i"}, {"literal":"t"}, {"literal":"c"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "switch", "symbols": [" string$107", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseStatements", "__", "default", "_", {"literal":"}"}], "postprocess": function(d){
	return "switch" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + " " + d[12] + "" + "}";
}},
    {"name": " string$108", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$109", "symbols": [{"literal":"b"}, {"literal":"r"}, {"literal":"e"}, {"literal":"a"}, {"literal":"k"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "case", "symbols": [" string$108", "__", "expression", "_", {"literal":":"}, "_", "series_of_statements", "_", " string$109", "_", {"literal":";"}], "postprocess": function(d){
	return "case" + " " + d[2] + "" + ":" + "" + d[6] + "" + "break" + "" + ";";
}},
    {"name": " string$110", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "foreach", "symbols": [" string$110", "_", {"literal":"("}, "_", "type", "__", "expression", "_", {"literal":":"}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "foreach" + "" + "(" + "" + d[4] + " " + d[6] + " " + "in" + " " + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}},
    {"name": " string$111", "symbols": [{"literal":"d"}, {"literal":"e"}, {"literal":"f"}, {"literal":"a"}, {"literal":"u"}, {"literal":"l"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "default", "symbols": [" string$111", "_", {"literal":":"}, "_", "series_of_statements"], "postprocess": function(d){
	return "default" + "" + ":" + "" + d[4];
}},
    {"name": " string$112", "symbols": [{"literal":"s"}, {"literal":"u"}, {"literal":"b"}, {"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "substring", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$112", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Substring" + "" + "(" + "" + d[8] + "" + "," + "" + d[12] + "" + ")";
}},
    {"name": " string$113", "symbols": [{"literal":"e"}, {"literal":"q"}, {"literal":"u"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$113", "_", {"literal":"("}, "_", "string_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Equals" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$114", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_length", "symbols": ["array_expression", "_", {"literal":"."}, "_", " string$114"], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Length";
}},
    {"name": " string$115", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$115", "_", {"literal":"("}, "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "Length";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$116", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "not_equal", "symbols": ["expression", "_", " string$116", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "!=" + "" + d[4];
}},
    {"name": " string$117", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "instance_method", "symbols": [" string$117", "__", "type", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + d[2] + " " + d[4] + "" + "(" + "" + d[8] + "" + ")" + "" + "{" + "" + d[14] + "" + "}";
}},
    {"name": " string$118", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$119", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "static_method", "symbols": [" string$118", "__", " string$119", "__", "type", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[4] + " " + d[6] + "" + "(" + "" + d[10] + "" + ")" + "" + "{" + "" + d[16] + "" + "}";
}},
    {"name": " string$120", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "constructor", "symbols": [" string$120", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}},
    {"name": " string$121", "symbols": [{"literal":"H"}, {"literal":"a"}, {"literal":"s"}, {"literal":"h"}, {"literal":"M"}, {"literal":"a"}, {"literal":"p"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "dictionary_type", "symbols": [" string$121", "_", {"literal":"<"}, "_", "type", "_", {"literal":","}, "_", "type", "_", {"literal":">"}], "postprocess": function(d){
	return "Dictionary" + "" + "<" + "" + d[4] + "" + "," + "" + d[8] + "" + ">";
}},
    {"name": " string$122", "symbols": [{"literal":"n"}, {"literal":"e"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "declare_new_object", "symbols": ["identifier", "__", "varName", "_", {"literal":"="}, "_", " string$122", "__", "identifier", "_", {"literal":"("}, "_", "functionCallParameters", "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + "new" + " " + d[0] + "" + "(" + "" + d[12] + "" + ")";
}},
    {"name": " subexpression$1", "symbols": ["series_of_statements"]},
    {"name": " subexpression$1", "symbols": ["class"]},
    {"name": " subexpression$1", "symbols": ["class_extends"]},
    {"name": " subexpression$2", "symbols": ["parameter"]},
    {"name": " subexpression$2", "symbols": ["default_parameter"]},
    {"name": " subexpression$3", "symbols": ["parameter"]},
    {"name": " subexpression$3", "symbols": ["default_parameter"]},
    {"name": " subexpression$4", "symbols": ["expression"]},
    {"name": " subexpression$4", "symbols": ["function_call_named_parameter"]},
    {"name": " subexpression$5", "symbols": ["expression"]},
    {"name": " subexpression$5", "symbols": ["function_call_named_parameter"]}
]
  , ParserStart: "chunk"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
