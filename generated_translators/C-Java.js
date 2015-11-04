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
    {"name": " string$8", "symbols": [{"literal":"f"}, {"literal":"l"}, {"literal":"o"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "floor", "symbols": [" string$8", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "floor" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$9", "symbols": [{"literal":"c"}, {"literal":"e"}, {"literal":"i"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "ceiling", "symbols": [" string$9", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "ceil" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$10", "symbols": [{"literal":"a"}, {"literal":"b"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "absolute_value", "symbols": [" string$10", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "abs" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$11", "symbols": [{"literal":"l"}, {"literal":"o"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "natural_logarithm", "symbols": [" string$11", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "log" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$12", "symbols": [{"literal":"a"}, {"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "asin", "symbols": [" string$12", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "asin" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$13", "symbols": [{"literal":"a"}, {"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "acos", "symbols": [" string$13", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "acos" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$14", "symbols": [{"literal":"a"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "atan", "symbols": [" string$14", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "atan" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$15", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"s"}, {"literal":"t"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$16", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$17", "symbols": [{"literal":"N"}, {"literal":"U"}, {"literal":"L"}, {"literal":"L"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "endswith", "symbols": [{"literal":"("}, "_", " string$15", "_", {"literal":"("}, "_", "expression", "_", {"literal":","}, "_", "expression", "_", {"literal":")"}, "_", " string$16", "_", " string$17", "_", {"literal":")"}], "postprocess": function(d){
	return d[6] + "" + "." + "" + "endsWith" + "" + "(" + "" + d[10] + "" + ")";
}},
    {"name": "statement_separator", "symbols": ["_"], "postprocess": function(d){
	return "";
}},
    {"name": " string$18", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$19", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "for_loop", "symbols": [" string$18", "__", "statement_without_semicolon", "_", {"literal":";"}, "_", " string$19", "_", {"literal":"("}, "_", "statement_without_semicolon", "_", {"literal":";"}, "_", "expression", "_", {"literal":";"}, "_", "statement_without_semicolon", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "for" + "" + "(" + "" + d[2] + "" + ";" + "" + d[14] + "" + ";" + "" + d[18] + "" + ")" + "" + "{" + "" + d[24] + "" + "}";
}},
    {"name": "function_call_parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$20", "symbols": [{"literal":"a"}, {"literal":"t"}, {"literal":"o"}, {"literal":"i"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string_to_int", "symbols": [" string$20", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Integer" + "" + "." + "" + "parseInt" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$21", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"a"}, {"literal":"t"}, {"literal":"i"}, {"literal":"c"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$22", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"n"}, {"literal":"s"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "declare_constant", "symbols": [" string$21", "__", " string$22", "__", "varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "final" + " " + d[undefined] + " " + d[4] + "" + "=" + "" + d[8];
}},
    {"name": "initializeArray", "symbols": ["arrayType", "__", "identifier", "_", {"literal":"="}, "_", "array_expression"], "postprocess": function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$23", "symbols": [{"literal":"]"}, {"literal":"["}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_access_separator", "symbols": [" string$23"], "postprocess": function(d){
	return "][";
}},
    {"name": "array_access_index", "symbols": ["expression"], "postprocess": function(d){
	return d[0];
}},
    {"name": "accessArray", "symbols": ["identifier", "_", {"literal":"["}, "_", "array_access_list", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "" + "[" + "" + d[4] + "" + "]";
}},
    {"name": " string$24", "symbols": [{"literal":"["}, {"literal":"]"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "arrayType", "symbols": ["type", "_", " string$24"], "postprocess": function(d){
	return d[0] + "" + "[]";
}},
    {"name": "initializerListSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": "initializerList", "symbols": [{"literal":"{"}, "_", "_initializerList", "_", {"literal":"}"}], "postprocess": function(d){
	return "{" + "" + d[2] + "" + "}";
}},
    {"name": "charAt", "symbols": ["expression", "_", {"literal":"["}, "_", "expression", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "" + "." + "" + "charAt" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$25", "symbols": [{"literal":"v"}, {"literal":"o"}, {"literal":"i"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "void", "symbols": [" string$25"], "postprocess": function(d){
	return "void";
}},
    {"name": " string$26", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sin", "symbols": [" string$26", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "sin" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$27", "symbols": [{"literal":"s"}, {"literal":"q"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sqrt", "symbols": [" string$27", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "sqrt" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$28", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "cos", "symbols": [" string$28", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "cos" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$29", "symbols": [{"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "tan", "symbols": [" string$29", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "tan" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$30", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "true", "symbols": [" string$30"], "postprocess": function(d){
	return "true";
}},
    {"name": " string$31", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "false", "symbols": [" string$31"], "postprocess": function(d){
	return "false";
}},
    {"name": " string$32", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["arithmetic_expression", "_", " string$32", "_", "arithmetic_expression"], "postprocess": function(d){
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
    {"name": " string$33", "symbols": [{"literal":"#"}, {"literal":"i"}, {"literal":"n"}, {"literal":"c"}, {"literal":"l"}, {"literal":"u"}, {"literal":"d"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$34", "symbols": [{"literal":"."}, {"literal":"h"}, {"literal":"'"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class_extends", "symbols": [" string$33", "__", {"literal":"'"}, "_", "identifier", "_", " string$34", "_", {"literal":"\n"}, "_", "class_statements"], "postprocess": function(d){
	return "public" + " " + "class" + " " + d[undefined] + " " + "extends" + " " + d[4] + "" + "{" + "" + d[10] + "" + "}";
}},
    {"name": " string$35", "symbols": [{"literal":"p"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": [" string$35", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return "Math" + "" + "." + "" + "pow" + "" + "(" + "" + d[4] + "" + "," + "" + d[8] + "" + ")";
}},
    {"name": " string$36", "symbols": [{"literal":"|"}, {"literal":"|"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_or", "symbols": ["arithmetic_expression", "_", " string$36", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "||" + "" + d[4];
}},
    {"name": "or", "symbols": ["_or"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$37", "symbols": [{"literal":"&"}, {"literal":"&"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_and", "symbols": ["boolean_expression", "_", " string$37", "_", "boolean_expression"], "postprocess": function(d){
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
    {"name": " string$38", "symbols": [{"literal":"d"}, {"literal":"o"}, {"literal":"u"}, {"literal":"b"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "double", "symbols": [" string$38"], "postprocess": function(d){
	return "double";
}},
    {"name": "initializeVar", "symbols": ["type", "__", "varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return d[0] + " " + d[2] + "" + "=" + "" + d[6];
}},
    {"name": " string$39", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$39", "__", "expression"], "postprocess": function(d){
	return "return" + " " + d[2];
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": "func", "symbols": ["type", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[0] + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}},
    {"name": " string$40", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$40", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "if" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}" + "" + d[14];
}},
    {"name": " string$41", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$42", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$41", "__", " string$42", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}, "_", "elifOrElse"], "postprocess": function(d){
	return "else" + " " + "if" + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}" + "" + d[16];
}},
    {"name": " string$43", "symbols": [{"literal":"+"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "plusEquals", "symbols": ["expression", "_", " string$43", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "+=" + "" + d[4];
}},
    {"name": " string$44", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "minusEquals", "symbols": ["expression", "_", " string$44", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "-=" + "" + d[4];
}},
    {"name": " string$45", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$45", "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "else" + "" + "{" + "" + d[4] + "" + "}";
}},
    {"name": " string$46", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "while", "symbols": [" string$46", "_", {"literal":"("}, "_", "boolean_expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "while" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + "" + "}";
}},
    {"name": " string$47", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$48", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$49", "symbols": [{"literal":"+"}, {"literal":"+"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "forInRange", "symbols": [" string$47", "__", "varName", "_", {"literal":";"}, "_", " string$48", "_", {"literal":"("}, "_", "varName", "_", {"literal":"="}, "_", "arithmetic_expression", "_", {"literal":";"}, "_", "varName", "_", {"literal":"<"}, "_", "arithmetic_expression", "_", {"literal":";"}, "_", "varName", "_", " string$49", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "for" + "" + "(" + "" + "int" + " " + d[2] + "" + "=" + "" + d[14] + "" + ";" + "" + d[2] + "" + "<" + "" + d[22] + "" + ";" + "" + d[2] + "" + "++" + "" + ")" + "" + "{" + "" + d[34] + "" + "}";
}},
    {"name": " string$50", "symbols": [{"literal":"#"}, {"literal":"i"}, {"literal":"n"}, {"literal":"c"}, {"literal":"l"}, {"literal":"u"}, {"literal":"d"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$51", "symbols": [{"literal":"."}, {"literal":"h"}, {"literal":"\""}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$50", "__", {"literal":"\""}, "_", "expression", "_", " string$51"], "postprocess": function(d){
	return "import" + " " + d[4] + "" + ";";
}},
    {"name": " string$52", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"t"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$52", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "System" + "" + "." + "" + "out" + "" + "." + "" + "println" + "" + "(" + "" + d[4] + "" + ")";
}},
    {"name": " string$53", "symbols": [{"literal":"/"}, {"literal":"/"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "comment", "symbols": [" string$53", "_", "_string"], "postprocess": function(d){
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
    {"name": " string$54", "symbols": [{"literal":"-"}, {"literal":">"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_dot_notation", "symbols": [" string$54"], "postprocess": function(d){
	return ".";
}},
    {"name": "initializeEmptyVar", "symbols": ["type", "__", "varName"], "postprocess": function(d){
	return d[0] + " " + d[2];
}},
    {"name": " string$55", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "boolean", "symbols": [" string$55"], "postprocess": function(d){
	return "boolean";
}},
    {"name": " string$56", "symbols": [{"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$56"], "postprocess": function(d){
	return "int";
}},
    {"name": " string$57", "symbols": [{"literal":"c"}, {"literal":"h"}, {"literal":"a"}, {"literal":"r"}, {"literal":"*"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$57"], "postprocess": function(d){
	return "String";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall", "_", "semicolon"], "postprocess": function(d){
	return d[0] + "" + d[2];
}},
    {"name": " string$58", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "greaterThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$58", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + ">=" + "" + d[4];
}},
    {"name": " string$59", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "lessThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$59", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "" + "<=" + "" + d[4];
}},
    {"name": " string$60", "symbols": [{"literal":"s"}, {"literal":"w"}, {"literal":"i"}, {"literal":"t"}, {"literal":"c"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "switch", "symbols": [" string$60", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "caseStatements", "__", "default", "_", {"literal":"}"}], "postprocess": function(d){
	return "switch" + "" + "(" + "" + d[4] + "" + ")" + "" + "{" + "" + d[10] + " " + d[12] + "" + "}";
}},
    {"name": " string$61", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$62", "symbols": [{"literal":"b"}, {"literal":"r"}, {"literal":"e"}, {"literal":"a"}, {"literal":"k"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "case", "symbols": [" string$61", "__", "expression", "_", {"literal":":"}, "_", "series_of_statements", "_", " string$62", "_", {"literal":";"}], "postprocess": function(d){
	return "case" + " " + d[2] + "" + ":" + "" + d[6] + "" + "break" + "" + ";";
}},
    {"name": " string$63", "symbols": [{"literal":"d"}, {"literal":"e"}, {"literal":"f"}, {"literal":"a"}, {"literal":"u"}, {"literal":"l"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "default", "symbols": [" string$63", "_", {"literal":":"}, "_", "series_of_statements"], "postprocess": function(d){
	return "default" + "" + ":" + "" + d[4];
}},
    {"name": "substring", "symbols": ["_"], "postprocess": function(d){
	return d[undefined] + "" + "." + "" + "substring" + "" + "(" + "" + d[undefined] + "" + "," + "" + d[undefined] + "" + ")";
}},
    {"name": " string$64", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"c"}, {"literal":"m"}, {"literal":"p"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$65", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": [" string$64", "_", {"literal":"("}, "_", "string_expression", "_", {"literal":","}, "_", "string_expression", "_", {"literal":")"}, "_", " string$65", "_", {"literal":"0"}], "postprocess": function(d){
	return d[4] + "" + "." + "" + "equals" + "" + "(" + "" + d[8] + "" + ")";
}},
    {"name": " string$66", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"z"}, {"literal":"e"}, {"literal":"o"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$67", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"z"}, {"literal":"e"}, {"literal":"o"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_length", "symbols": [" string$66", "_", {"literal":"("}, "_", "array_expression", "_", {"literal":")"}, "_", {"literal":"/"}, "_", " string$67", "_", {"literal":"("}, "_", "array_expression", "_", {"literal":"["}, "_", {"literal":"0"}, "_", {"literal":"]"}, "_", {"literal":")"}], "postprocess": function(d){
	return d[4] + "" + "." + "" + "length";
}},
    {"name": " string$68", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"l"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": [" string$68", "_", {"literal":"("}, "_", "string_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[4] + "" + "." + "" + "length" + "" + "(" + "" + ")";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$69", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "not_equal", "symbols": ["expression", "_", " string$69", "_", "expression"], "postprocess": function(d){
	return d[0] + "" + "!=" + "" + d[4];
}},
    {"name": "instance_method", "symbols": ["_"], "postprocess": function(d){
	return "public" + " " + d[undefined] + " " + d[undefined] + "" + "(" + "" + d[undefined] + "" + ")" + "" + "{" + "" + d[undefined] + "" + "}";
}},
    {"name": "static_method", "symbols": ["type", "__", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", {"literal":"{"}, "_", "series_of_statements", "_", {"literal":"}"}], "postprocess": function(d){
	return "public" + " " + "static" + " " + d[0] + " " + d[2] + "" + "(" + "" + d[6] + "" + ")" + "" + "{" + "" + d[12] + "" + "}";
}},
    {"name": "declare_new_object", "symbols": ["_"], "postprocess": function(d){
	return d[undefined] + " " + d[undefined] + "" + "=" + "" + "new" + " " + d[undefined] + "" + "(" + "" + d[undefined] + "" + ")";
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
