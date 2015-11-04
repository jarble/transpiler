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
    {"name": "statement_without_semicolon", "symbols": ["_setVar"]},
    {"name": "statement_without_semicolon", "symbols": ["_initializeVar"]},
    {"name": "statement_without_semicolon", "symbols": ["_return"]},
    {"name": "statement_without_semicolon", "symbols": ["functionCall"]},
    {"name": "_series_of_statements", "symbols": ["statement"], "postprocess": function(d){return d[0];}},
    {"name": "_series_of_statements", "symbols": ["series_of_statements", "__", "statement"], "postprocess": function(d){return d[0] + "\n" + d[2];}},
    {"name": "series_of_statements", "symbols": ["statement"], "postprocess": function(d){return d[0];}},
    {"name": "series_of_statements", "symbols": ["series_of_statements", "statement_separator", "__", "statement"], "postprocess": function(d){return d[0] + d[1] + "\n" + d[3];}},
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
    {"name": "expression", "symbols": ["range"]},
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
    {"name": "statement", "symbols": ["func"]},
    {"name": "statement", "symbols": ["for_loop"]},
    {"name": "statement", "symbols": ["typeless_function"]},
    {"name": "statement", "symbols": ["typeless_variable_declaration"]},
    {"name": "statement", "symbols": ["plusEquals"]},
    {"name": "statement", "symbols": ["minusEquals"]},
    {"name": "statement", "symbols": ["declare_constant"]},
    {"name": "statement", "symbols": ["initializeArray"]},
    {"name": "statement", "symbols": ["print"]},
    {"name": "statement", "symbols": ["comment"]},
    {"name": "statement", "symbols": ["switch"]},
    {"name": "statement", "symbols": ["setVar"]},
    {"name": "statement", "symbols": ["initializeVar"]},
    {"name": "statement", "symbols": ["functionCallStatement"]},
    {"name": "statement", "symbols": ["return"]},
    {"name": "statement", "symbols": ["if"]},
    {"name": "statement", "symbols": ["while"]},
    {"name": "statement", "symbols": ["forInRange"]},
    {"name": "statement", "symbols": ["exception"]},
    {"name": "class_statement", "symbols": ["constructor"]},
    {"name": "class_statement", "symbols": ["initialize_static_variable_with_value"]},
    {"name": "class_statement", "symbols": ["initialize_instance_variable_with_value"]},
    {"name": "class_statement", "symbols": ["initialize_static_variable"]},
    {"name": "class_statement", "symbols": ["initialize_instance_variable"]},
    {"name": "class_statement", "symbols": ["instance_method"]},
    {"name": "class_statement", "symbols": ["static_method"]},
    {"name": "class_statement", "symbols": ["comment"]},
    {"name": "_class_statements", "symbols": ["class_statements", "_", "class_statement"], "postprocess": function(d){return d[0] +"\n"+ d[2];}},
    {"name": "_class_statements", "symbols": ["class_statement"], "postprocess": function(d){return d[0];}},
    {"name": "_class_statements", "symbols": []},
    {"name": "class_statements", "symbols": ["class_statement"], "postprocess": function(d){return d[0];}},
    {"name": "class_statements", "symbols": ["class_statements", "_", "class_statement"], "postprocess": function(d){return d[0] + "\n" + d[2];}},
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
    {"name": "statement_separator", "symbols": ["_"], "postprocess": function(d){
	return "";
}},
    {"name": " string$6", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$7", "symbols": [{"literal":"d"}, {"literal":"o"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$8", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "for_loop", "symbols": ["statement_without_semicolon", "_", {"literal":"\n"}, "_", " string$6", "_", "__", "_", "expression", "_", "__", "_", " string$7", "_", "__", "_", "series_of_statements", "_", "__", "_", "statement_without_semicolon", "_", "__", "_", " string$8"], "postprocess": function(d){
	return "for" + "(" + d[0] + ";" + d[8] + ";" + d[20] + ")" + "{" + d[16] + "}";
}},
    {"name": "typeless_parameter", "symbols": ["identifier"], "postprocess": function(d){
	return "auto" + " " + d[0];
}},
    {"name": " string$9", "symbols": [{"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$10", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_function", "symbols": [" string$9", "_", "__", "_", "identifier", "_", {"literal":"("}, "_", "typeless_parameters", "_", {"literal":")"}, "_", {"literal":"\n"}, "_", "series_of_statements", "_", "__", "_", " string$10"], "postprocess": function(d){
	return "auto" + " " + d[4] + "(" + d[8] + ")" + "{" + d[14] + "}";
}},
    {"name": " string$11", "symbols": [{"literal":"l"}, {"literal":"o"}, {"literal":"c"}, {"literal":"a"}, {"literal":"l"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_variable_declaration", "symbols": [" string$11", "_", "__", "_", "varName", "_", {"literal":"="}, "_", "identifier", "_", {"literal":";"}], "postprocess": function(d){
	return "auto" + " " + d[4] + "=" + d[8] + ";";
}},
    {"name": " string$12", "symbols": [{"literal":"t"}, {"literal":"o"}, {"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int_to_string", "symbols": [" string$12", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "to_string" + "(" + d[4] + ")";
}},
    {"name": "function_call_parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$13", "symbols": [{"literal":"t"}, {"literal":"o"}, {"literal":"n"}, {"literal":"u"}, {"literal":"m"}, {"literal":"b"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string_to_int", "symbols": [" string$13", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "atoi" + "(" + d[4] + "." + "c_str" + "(" + ")" + ")";
}},
    {"name": " string$14", "symbols": [{"literal":"]"}, {"literal":"["}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_access_separator", "symbols": [" string$14"], "postprocess": function(d){
	return "][";
}},
    {"name": "array_access_index", "symbols": ["expression", "_", {"literal":"+"}, "_", {"literal":"1"}], "postprocess": function(d){
	return d[0];
}},
    {"name": "accessArray", "symbols": ["identifier", "_", {"literal":"["}, "_", "array_access_list", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "[" + d[4] + "]";
}},
    {"name": "initializerListSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": "initializerList", "symbols": [{"literal":"{"}, "_", "_initializerList", "_", {"literal":"}"}], "postprocess": function(d){
	return "{" + d[2] + "}";
}},
    {"name": "keyValue", "symbols": ["identifier", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return "{" + d[0] + "," + d[4] + "}";
}},
    {"name": " string$15", "symbols": [{"literal":"s"}, {"literal":"u"}, {"literal":"b"}, {"literal":"("}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "charAt", "symbols": ["expression", "_", {"literal":":"}, "_", " string$15", "_", "expression", "_", {"literal":"+"}, "_", {"literal":"1"}, "_", {"literal":","}, "_", "expression", "_", {"literal":"+"}, "_", {"literal":"1"}, "_", {"literal":")"}], "postprocess": function(d){
	return d[0] + "[" + d[6] + "]";
}},
    {"name": " string$16", "symbols": [{"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$17", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "anonymousFunction", "symbols": [" string$16", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", "__", "_", "series_of_statements", "_", "__", "_", " string$17"], "postprocess": function(d){
	return "[" + "=" + "]" + "(" + d[4] + ")" + "->" + "int" + "{" + d[10] + "}";
}},
    {"name": "void", "symbols": ["_"], "postprocess": function(d){
	return "void";
}},
    {"name": " string$18", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$19", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sin", "symbols": [" string$18", "_", {"literal":"."}, "_", " string$19", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "sin" + "(" + d[8] + ")";
}},
    {"name": " string$20", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$21", "symbols": [{"literal":"s"}, {"literal":"q"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sqrt", "symbols": [" string$20", "_", {"literal":"."}, "_", " string$21", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "sqrt" + "(" + d[8] + ")";
}},
    {"name": " string$22", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$23", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "cos", "symbols": [" string$22", "_", {"literal":"."}, "_", " string$23", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "cos" + "(" + d[8] + ")";
}},
    {"name": " string$24", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}, {"literal":":"}, {"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "tan", "symbols": [" string$24", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "tan" + "(" + d[4] + ")";
}},
    {"name": "dictionary", "symbols": [{"literal":"{"}, "_", "keyValueList", "_", {"literal":"}"}], "postprocess": function(d){
	return "{" + d[2] + "}";
}},
    {"name": "keyValueSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$25", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "true", "symbols": [" string$25"], "postprocess": function(d){
	return "true";
}},
    {"name": " string$26", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "false", "symbols": [" string$26"], "postprocess": function(d){
	return "false";
}},
    {"name": " string$27", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["arithmetic_expression", "_", " string$27", "_", "arithmetic_expression"], "postprocess": function(d){
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
    {"name": " string$28", "symbols": [{"literal":"m"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$29", "symbols": [{"literal":"p"}, {"literal":"o"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": [" string$28", "_", {"literal":"."}, "_", " string$29", "_", {"literal":"("}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":")"}], "postprocess": function(d){
	return "pow" + "(" + d[8] + "," + d[12] + ")";
}},
    {"name": " string$30", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_or", "symbols": ["arithmetic_expression", "_", "__", "_", " string$30", "_", "__", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "||" + d[8];
}},
    {"name": "or", "symbols": ["_or"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$31", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_and", "symbols": ["boolean_expression", "_", "__", "_", " string$31", "_", "__", "_", "boolean_expression"], "postprocess": function(d){
	return d[0] + "&&" + d[8];
}},
    {"name": "and", "symbols": ["_and"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$32", "symbols": [{"literal":"n"}, {"literal":"o"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "not", "symbols": [" string$32", "_", "__", "_", "boolean_expression"], "postprocess": function(d){
	return "!" + d[4];
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
	return d[0] + "(" + d[4] + ")";
}},
    {"name": " string$33", "symbols": [{"literal":"."}, {"literal":"."}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "concatenateString", "symbols": ["string_expression", "_", " string$33", "_", "string_expression"], "postprocess": function(d){
	return d[0] + "+" + d[4];
}},
    {"name": "initializeVar", "symbols": ["_initializeVar", "_", "semicolon"], "postprocess": function(d){
	return d[0] + d[2];
}},
    {"name": " string$34", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$34", "_", "__", "_", "expression"], "postprocess": function(d){
	return "return" + " " + d[4] + ";";
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$35", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$36", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$37", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$35", "_", "__", "_", "boolean_expression", "_", "__", "_", " string$36", "_", "__", "_", "series_of_statements", "_", "__", "_", "elifOrElse", "_", "__", "_", " string$37"], "postprocess": function(d){
	return "if" + "(" + d[4] + ")" + "{" + d[12] + "}" + d[16];
}},
    {"name": " string$38", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$39", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$38", "_", "__", "_", "boolean_expression", "_", "__", "_", " string$39", "_", "__", "_", "series_of_statements"], "postprocess": function(d){
	return "else" + " " + "if" + "(" + d[4] + ")" + "{" + d[12] + "}";
}},
    {"name": " string$40", "symbols": [{"literal":"+"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "plusEquals", "symbols": ["expression", "_", " string$40", "_", "expression"], "postprocess": function(d){
	return d[0] + "+=" + d[4] + ";";
}},
    {"name": " string$41", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "minusEquals", "symbols": ["expression", "_", " string$41", "_", "expression"], "postprocess": function(d){
	return d[0] + "-=" + d[4] + ";";
}},
    {"name": " string$42", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$42", "_", "__", "_", "series_of_statements"], "postprocess": function(d){
	return "else" + "{" + d[4] + "}";
}},
    {"name": " string$43", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$44", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "while", "symbols": [" string$43", "_", "__", "_", "boolean_expression", "_", "__", "_", "series_of_statements", "_", "__", "_", " string$44"], "postprocess": function(d){
	return "while" + "(" + d[4] + ")" + "{" + d[8] + "}";
}},
    {"name": " string$45", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$46", "symbols": [{"literal":"d"}, {"literal":"o"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$47", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "forInRange", "symbols": [" string$45", "_", "__", "_", "varName", "_", {"literal":"="}, "_", "arithmetic_expression", "_", {"literal":","}, "_", "arithmetic_expression", "_", {"literal":","}, "_", {"literal":"1"}, "_", " string$46", "_", "__", "_", "series_of_statements", "_", "__", "_", " string$47"], "postprocess": function(d){
	return "for" + "(" + "int" + " " + d[4] + "=" + d[8] + ";" + d[4] + "<" + d[12] + ";" + d[4] + "++" + ")" + "{" + d[22] + "}";
}},
    {"name": " string$48", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"q"}, {"literal":"u"}, {"literal":"i"}, {"literal":"r"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$48", "_", "__", "_", {"literal":"'"}, "_", "expression", "_", {"literal":"'"}], "postprocess": function(d){
	return "#include" + " " + "'" + d[6] + ".h'";
}},
    {"name": " string$49", "symbols": [{"literal":"p"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$49", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "cout" + "<<" + d[4] + ";";
}},
    {"name": " string$50", "symbols": [{"literal":"-"}, {"literal":"-"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "comment", "symbols": [" string$50", "_", "_string"], "postprocess": function(d){
	return "//" + d[2];
}},
    {"name": "mod", "symbols": ["arithmetic_expression", "_", {"literal":"%"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "%" + d[4];
}},
    {"name": "semicolon", "symbols": ["_"], "postprocess": function(d){
	return ";";
}},
    {"name": "_setVar", "symbols": ["varName", "_", {"literal":"="}, "_", "expression"], "postprocess": function(d){
	return d[0] + "=" + d[4];
}},
    {"name": "setVar", "symbols": ["_setVar", "_", "semicolon"], "postprocess": function(d){
	return d[0] + d[2];
}},
    {"name": " string$51", "symbols": [{"literal":"b"}, {"literal":"o"}, {"literal":"o"}, {"literal":"l"}, {"literal":"e"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "boolean", "symbols": [" string$51"], "postprocess": function(d){
	return "bool";
}},
    {"name": " string$52", "symbols": [{"literal":"n"}, {"literal":"u"}, {"literal":"m"}, {"literal":"b"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$52"], "postprocess": function(d){
	return "int";
}},
    {"name": " string$53", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$53"], "postprocess": function(d){
	return "string";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall", "_", "semicolon"], "postprocess": function(d){
	return d[0] + d[2];
}},
    {"name": " string$54", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "greaterThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$54", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + ">=" + d[4];
}},
    {"name": " string$55", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "lessThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$55", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "<=" + d[4];
}},
    {"name": " string$56", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": ["string_expression", "_", " string$56", "_", "string_expression"], "postprocess": function(d){
	return d[0] + "." + "compare" + "(" + d[4] + ")";
}},
    {"name": "array_length", "symbols": [{"literal":"#"}, "_", "array_expression"], "postprocess": function(d){
	return d[2] + "." + "size" + "(" + ")";
}},
    {"name": " string$57", "symbols": [{"literal":"s"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$58", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": [" string$57", "_", {"literal":"."}, "_", " string$58", "_", {"literal":"("}, "_", "string_expression", "_", {"literal":")"}], "postprocess": function(d){
	return d[8] + "." + "length" + "(" + ")";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$59", "symbols": [{"literal":"~"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "not_equal", "symbols": ["expression", "_", " string$59", "_", "expression"], "postprocess": function(d){
	return d[0] + "!=" + d[4];
}},
    {"name": " subexpression$1", "symbols": ["_series_of_statements"]},
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
