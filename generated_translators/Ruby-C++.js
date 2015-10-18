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
    {"name": "statement", "symbols": ["func"]},
    {"name": "statement", "symbols": ["functionCallStatement"]},
    {"name": "statement", "symbols": ["return"]},
    {"name": "statement", "symbols": ["if"]},
    {"name": "statement", "symbols": ["while"]},
    {"name": "statement", "symbols": ["forInRange"]},
    {"name": "class_statement", "symbols": ["constructor"]},
    {"name": "class_statement", "symbols": ["instance_method"]},
    {"name": "class_statement", "symbols": ["static_method"]},
    {"name": "class_statement", "symbols": ["comment"]},
    {"name": "class_statements", "symbols": [" ebnf$2"]},
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
    {"name": "typeless_parameters", "symbols": ["_typeless_parameters"]},
    {"name": "typeless_parameters", "symbols": []},
    {"name": "_typeless_parameters", "symbols": ["_typeless_parameters", "_", "parameter_separator", "_", "typeless_parameter"], "postprocess": function(d){return d[0]+d[2]+d[4]}},
    {"name": "_typeless_parameters", "symbols": ["typeless_parameter"]},
    {"name": "functionCallParameters", "symbols": ["functionCallParameters", "_", "function_call_parameter_separator", "_", "expression"], "postprocess":  function(d) {return d.join(""); } },
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
    {"name": " string$3", "symbols": [{"literal":"f"}, {"literal":"u"}, {"literal":"n"}, {"literal":"c"}, {"literal":"t"}, {"literal":"i"}, {"literal":"o"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$4", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "predicate", "symbols": [" string$3", "_", "__", "_", "identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", "__", "_", "series_of_statements", "_", "__", "_", " string$4"], "postprocess": function(d){
	return "public" + " " + "static" + " " + "bool" + " " + d[4] + "(" + d[8] + ")" + "{" + d[14] + "}";
}},
    {"name": "typeless_parameter", "symbols": ["identifier"], "postprocess": function(d){
	return "auto" + " " + d[0];
}},
    {"name": " string$5", "symbols": [{"literal":"d"}, {"literal":"e"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$6", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "typeless_function", "symbols": [" string$5", "_", "__", "_", "identifier", "_", {"literal":"("}, "_", "typeless_parameters", "_", {"literal":")"}, "_", "__", "_", "series_of_statements", "_", "__", "_", " string$6"], "postprocess": function(d){
	return "auto" + " " + d[4] + "(" + d[8] + ")" + "{" + d[14] + "}";
}},
    {"name": "typeless_variable_declaration", "symbols": [{"literal":"a"}, "_", {"literal":"="}, "_", "identifier", "_", {"literal":"\n"}], "postprocess": function(d){
	return "auto" + " " + "a" + "=" + d[4] + ";";
}},
    {"name": " string$7", "symbols": [{"literal":"t"}, {"literal":"o"}, {"literal":"_"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int_to_string", "symbols": ["expression", "_", {"literal":"."}, "_", " string$7"], "postprocess": function(d){
	return "std" + "::" + "to_string" + "(" + d[0] + ")";
}},
    {"name": "function_call_parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$8", "symbols": [{"literal":"I"}, {"literal":"n"}, {"literal":"t"}, {"literal":"e"}, {"literal":"g"}, {"literal":"e"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string_to_int", "symbols": [" string$8", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "atoi" + "(" + d[4] + "." + "c_str" + "(" + ")" + ")";
}},
    {"name": "accessArray", "symbols": ["identifier", "_", {"literal":"["}, "_", "arithmetic_expression", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "[" + d[4] + "]";
}},
    {"name": "initializerListSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": "initializerList", "symbols": [{"literal":"["}, "_", "_initializerList", "_", {"literal":"]"}], "postprocess": function(d){
	return "{" + d[2] + "}";
}},
    {"name": " string$9", "symbols": [{"literal":"="}, {"literal":">"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "keyValue", "symbols": ["identifier", "_", " string$9", "_", "expression"], "postprocess": function(d){
	return "{" + d[0] + "," + d[4] + "}";
}},
    {"name": "charAt", "symbols": ["expression", "_", {"literal":"["}, "_", "expression", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "[" + d[4] + "]";
}},
    {"name": "void", "symbols": ["_"], "postprocess": function(d){
	return "void";
}},
    {"name": " string$10", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$11", "symbols": [{"literal":"s"}, {"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sin", "symbols": [" string$10", "_", {"literal":"."}, "_", " string$11", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "sin" + "(" + d[8] + ")";
}},
    {"name": " string$12", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$13", "symbols": [{"literal":"s"}, {"literal":"q"}, {"literal":"r"}, {"literal":"t"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "sqrt", "symbols": [" string$12", "_", {"literal":"."}, "_", " string$13", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "sqrt" + "(" + d[8] + ")";
}},
    {"name": " string$14", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$15", "symbols": [{"literal":"c"}, {"literal":"o"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "cos", "symbols": [" string$14", "_", {"literal":"."}, "_", " string$15", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "cos" + "(" + d[8] + ")";
}},
    {"name": " string$16", "symbols": [{"literal":"M"}, {"literal":"a"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$17", "symbols": [{"literal":"t"}, {"literal":"a"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "tan", "symbols": [" string$16", "_", {"literal":"."}, "_", " string$17", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "std" + "::" + "tan" + "(" + d[8] + ")";
}},
    {"name": "dictionary", "symbols": [{"literal":"{"}, "_", "keyValueList", "_", {"literal":"}"}], "postprocess": function(d){
	return "{" + d[2] + "}";
}},
    {"name": "keyValueSeparator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$18", "symbols": [{"literal":"t"}, {"literal":"r"}, {"literal":"u"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "true", "symbols": [" string$18"], "postprocess": function(d){
	return "true";
}},
    {"name": " string$19", "symbols": [{"literal":"f"}, {"literal":"a"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "false", "symbols": [" string$19"], "postprocess": function(d){
	return "false";
}},
    {"name": " string$20", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "compareInts", "symbols": ["arithmetic_expression", "_", " string$20", "_", "arithmetic_expression"], "postprocess": function(d){
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
    {"name": " string$21", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$22", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class_extends", "symbols": [" string$21", "_", "__", "_", "identifier", "_", "__", "_", {"literal":"<"}, "_", "__", "_", "identifier", "_", "__", "_", "class_statements", "_", "__", "_", " string$22"], "postprocess": function(d){
	return "class" + " " + d[4] + ":" + "public" + " " + d[12] + "{" + d[16] + "}";
}},
    {"name": " string$23", "symbols": [{"literal":"c"}, {"literal":"l"}, {"literal":"a"}, {"literal":"s"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$24", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "class", "symbols": [" string$23", "_", "__", "_", "identifier", "_", "__", "_", "class_statements", "_", "__", "_", " string$24"], "postprocess": function(d){
	return "class" + " " + d[4] + "{" + d[8] + "}";
}},
    {"name": "this", "symbols": [{"literal":"@"}, "_", "varName"], "postprocess": function(d){
	return "this" + "." + d[2];
}},
    {"name": " string$25", "symbols": [{"literal":"*"}, {"literal":"*"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "pow", "symbols": ["arithmetic_expression", "_", " string$25", "_", "arithmetic_expression"], "postprocess": function(d){
	return "pow" + "(" + d[0] + "," + d[4] + ")";
}},
    {"name": " string$26", "symbols": [{"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_or", "symbols": ["arithmetic_expression", "_", "__", "_", " string$26", "_", "__", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "||" + d[8];
}},
    {"name": "or", "symbols": ["_or"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$27", "symbols": [{"literal":"a"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "_and", "symbols": ["boolean_expression", "_", "__", "_", " string$27", "_", "__", "_", "boolean_expression"], "postprocess": function(d){
	return d[0] + "&&" + d[8];
}},
    {"name": "and", "symbols": ["_and"], "postprocess": function(d){
	return d[0];
}},
    {"name": "not", "symbols": [{"literal":"!"}, "_", "boolean_expression"], "postprocess": function(d){
	return "!" + d[2];
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
    {"name": "concatenateString", "symbols": ["string_expression", "_", {"literal":"+"}, "_", "string_expression"], "postprocess": function(d){
	return d[0] + "+" + d[4];
}},
    {"name": " string$28", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"t"}, {"literal":"u"}, {"literal":"r"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "return", "symbols": [" string$28", "_", "__", "_", "expression", "_", {"literal":"\n"}], "postprocess": function(d){
	return "return" + " " + d[4] + ";";
}},
    {"name": "varName", "symbols": ["identifier"], "postprocess": function(d){
	return d[0];
}},
    {"name": " string$29", "symbols": [{"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$30", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$31", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "if", "symbols": [" string$29", "_", "__", "_", "boolean_expression", "_", "__", "_", " string$30", "_", "__", "_", "series_of_statements", "_", "__", "_", "elifOrElse", "_", "__", "_", " string$31"], "postprocess": function(d){
	return "if" + "(" + d[4] + ")" + "{" + d[12] + "}" + d[16];
}},
    {"name": " string$32", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"i"}, {"literal":"f"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$33", "symbols": [{"literal":"t"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "elif", "symbols": [" string$32", "_", "__", "_", "boolean_expression", "_", "__", "_", " string$33", "_", "__", "_", "series_of_statements"], "postprocess": function(d){
	return "else" + " " + "if" + "(" + d[4] + ")" + "{" + d[12] + "}";
}},
    {"name": "plusEquals", "symbols": ["expression", "_", {"literal":"="}, "_", "expression", "_", {"literal":"+"}, "_", "expression", "_", {"literal":"\n"}], "postprocess": function(d){
	return d[0] + "+=" + d[8] + ";";
}},
    {"name": " string$34", "symbols": [{"literal":"-"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "minusEquals", "symbols": ["expression", "_", " string$34", "_", "expression", "_", {"literal":"\n"}], "postprocess": function(d){
	return d[0] + "-=" + d[4] + ";";
}},
    {"name": " string$35", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "else", "symbols": [" string$35", "_", "__", "_", "series_of_statements"], "postprocess": function(d){
	return "else" + "{" + d[4] + "}";
}},
    {"name": " string$36", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"i"}, {"literal":"l"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$37", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "while", "symbols": [" string$36", "_", "__", "_", "boolean_expression", "_", "__", "_", "series_of_statements", "_", "__", "_", " string$37"], "postprocess": function(d){
	return "while" + "(" + d[4] + ")" + "{" + d[8] + "}";
}},
    {"name": " string$38", "symbols": [{"literal":"f"}, {"literal":"o"}, {"literal":"r"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$39", "symbols": [{"literal":"i"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$40", "symbols": [{"literal":"."}, {"literal":"."}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$41", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "forInRange", "symbols": [" string$38", "_", "__", "_", "varName", "_", "__", "_", " string$39", "_", "__", "_", "arithmetic_expression", "_", " string$40", "_", "arithmetic_expression", "_", "__", "_", "series_of_statements", "_", "__", "_", " string$41"], "postprocess": function(d){
	return "for" + "(" + "int" + " " + d[4] + "=" + d[12] + ";" + d[4] + "<" + d[16] + ";" + d[4] + "++" + ")" + "{" + d[20] + "}";
}},
    {"name": " string$42", "symbols": [{"literal":"r"}, {"literal":"e"}, {"literal":"q"}, {"literal":"u"}, {"literal":"i"}, {"literal":"r"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "import", "symbols": [" string$42", "_", "__", "_", {"literal":"'"}, "_", "expression", "_", {"literal":"'"}], "postprocess": function(d){
	return "#include" + " " + "'" + d[6] + ".h'";
}},
    {"name": " string$43", "symbols": [{"literal":"p"}, {"literal":"u"}, {"literal":"t"}, {"literal":"s"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "print", "symbols": [" string$43", "_", {"literal":"("}, "_", "expression", "_", {"literal":")"}], "postprocess": function(d){
	return "cout" + "<<" + d[4] + ";";
}},
    {"name": "comment", "symbols": [{"literal":"#"}, "_", "_string", "_", {"literal":"\n"}], "postprocess": function(d){
	return "//" + d[2] + "\n";
}},
    {"name": "mod", "symbols": ["arithmetic_expression", "_", {"literal":"%"}, "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "%" + d[4];
}},
    {"name": "setVar", "symbols": ["varName", "_", {"literal":"="}, "_", "expression", "_", {"literal":"\n"}], "postprocess": function(d){
	return d[0] + "=" + d[4] + ";";
}},
    {"name": " string$44", "symbols": [{"literal":"f"}, {"literal":"i"}, {"literal":"x"}, {"literal":"n"}, {"literal":"u"}, {"literal":"m"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "int", "symbols": [" string$44"], "postprocess": function(d){
	return "int";
}},
    {"name": " string$45", "symbols": [{"literal":"S"}, {"literal":"t"}, {"literal":"r"}, {"literal":"i"}, {"literal":"n"}, {"literal":"g"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "string", "symbols": [" string$45"], "postprocess": function(d){
	return "string";
}},
    {"name": "functionCallStatement", "symbols": ["functionCall"], "postprocess": function(d){
	return d[0] + ";";
}},
    {"name": " string$46", "symbols": [{"literal":">"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "greaterThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$46", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + ">=" + d[4];
}},
    {"name": " string$47", "symbols": [{"literal":"<"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "lessThanOrEqual", "symbols": ["arithmetic_expression", "_", " string$47", "_", "arithmetic_expression"], "postprocess": function(d){
	return d[0] + "<=" + d[4];
}},
    {"name": " string$48", "symbols": [{"literal":"c"}, {"literal":"a"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$49", "symbols": [{"literal":"e"}, {"literal":"n"}, {"literal":"d"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "switch", "symbols": [" string$48", "_", "__", "_", "expression", "_", "__", "_", "caseStatements", "_", "__", "_", "default", "_", "__", "_", " string$49"], "postprocess": function(d){
	return "switch" + "(" + d[4] + ")" + "{" + d[8] + " " + d[12] + "}";
}},
    {"name": " string$50", "symbols": [{"literal":"w"}, {"literal":"h"}, {"literal":"e"}, {"literal":"n"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "case", "symbols": [" string$50", "_", "__", "_", "expression", "_", "series_of_statements"], "postprocess": function(d){
	return "case" + " " + d[4] + ":" + d[6] + "break" + ";";
}},
    {"name": " string$51", "symbols": [{"literal":"e"}, {"literal":"l"}, {"literal":"s"}, {"literal":"e"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "default", "symbols": [" string$51", "_", "__", "_", "series_of_statements"], "postprocess": function(d){
	return "default" + ":" + d[4];
}},
    {"name": " string$52", "symbols": [{"literal":"."}, {"literal":"."}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "substring", "symbols": ["string_expression", "_", {"literal":"["}, "_", "arithmetic_expression", "_", " string$52", "_", "arithmetic_expression", "_", {"literal":"]"}], "postprocess": function(d){
	return d[0] + "." + "substring" + "(" + d[4] + "," + d[8] + "-" + d[4] + ")";
}},
    {"name": " string$53", "symbols": [{"literal":"="}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strcmp", "symbols": ["string_expression", "_", " string$53", "_", "string_expression"], "postprocess": function(d){
	return d[0] + "." + "compare" + "(" + d[4] + ")";
}},
    {"name": " string$54", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "array_length", "symbols": ["array_expression", "_", {"literal":"."}, "_", " string$54"], "postprocess": function(d){
	return d[0] + "." + "size" + "(" + ")";
}},
    {"name": " string$55", "symbols": [{"literal":"l"}, {"literal":"e"}, {"literal":"n"}, {"literal":"g"}, {"literal":"t"}, {"literal":"h"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "strlen", "symbols": ["string_expression", "_", {"literal":"."}, "_", " string$55"], "postprocess": function(d){
	return d[0] + "." + "length" + "(" + ")";
}},
    {"name": "parameter_separator", "symbols": [{"literal":","}], "postprocess": function(d){
	return ",";
}},
    {"name": " string$56", "symbols": [{"literal":"!"}, {"literal":"="}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "not_equal", "symbols": ["expression", "_", " string$56", "_", "expression"], "postprocess": function(d){
	return d[0] + "!=" + d[4];
}},
    {"name": " string$57", "symbols": [{"literal":"n"}, {"literal":"e"}, {"literal":"w"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "declare_new_object", "symbols": ["varName", "_", {"literal":"="}, "_", "identifier", "_", {"literal":"."}, "_", " string$57", "_", {"literal":"("}, "_", "functionCallParameters", "_", {"literal":")"}, "_", {"literal":"\n"}], "postprocess": function(d){
	return d[4] + " " + d[0] + "(" + d[12] + ")" + ";";
}},
    {"name": " subexpression$1", "symbols": ["_series_of_statements"]},
    {"name": " subexpression$1", "symbols": ["class"]},
    {"name": " subexpression$1", "symbols": ["class_extends"]},
    {"name": " ebnf$2", "symbols": ["class_statement"]},
    {"name": " ebnf$2", "symbols": ["class_statement", " ebnf$2"], "postprocess": function (d) {
                    return [d[0]].concat(d[1]);
                }}
]
  , ParserStart: "chunk"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
