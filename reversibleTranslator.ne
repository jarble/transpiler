@{%
function numIndex(num){
	var toAdd = 0;
	for(var i = 0; i <= num; i++){
		if(i != 0){
			toAdd += 1;
		}
	}
	return num + toAdd;
}
function getOutput(theInput) {
    var arr = theInput;
    var translateFrom = arr[0][0];
    var translateTo = arr[0][1];
    var listOfErrors = "";

    var theArrs = [];
    for (var i = 0; i < arr[1].length; i++) {
        var arr_i = arr[1][i];
        var nameList = [];
        var typeList = [];
        //console.log(JSON.stringify(arr[1][i]));
        for (var j = 0; j < arr_i.length; j++) {
            var arr_j = arr_i[j];
            var functionName;
            if (j === 0) {
                functionName = arr_j
            }
            var parameters;
            if (j === 1) {
                parameters = arr_j
            }
            if (j === 2) {
                var newArr = [];
                newArr[0] = functionName
                newArr[1] = parameters
                for (var k = 0; k < arr[1][i][j].length; k++) {
                    var arr_k = arr_j[k];
                    if (arr_k[0].indexOf(translateFrom) !== -1) {
                        newArr[2] = arr_k[1];
                    }
                    if (arr_k[0].indexOf(translateTo) !== -1) {
                        newArr[3] = arr_k[1];
                    }
                }
                //console.log(JSON.stringify(newArr));
                theArrs[theArrs.length] = newArr;
            }
            //console.log(JSON.stringify(arr_j));
        }
    }


    var resultString = "";
    for (var i = 0; i < theArrs.length; i++) {
        var parameterNames = [];
        var parameterTypes = [];
        var parameterPositions = [];
        var functionName = "";
        var arr_i = theArrs[i]
        for (var j = 0; j < arr_i.length; j++) {
			var arr_j = arr_i[j];
			if(arr_i.length < 4 || arr_j === undefined){
				listOfErrors += "    " + arr_i[0] + " is not yet defined for " + translateFrom + " and " + translateTo + "\n";
			}
            if (j === 0) {
                resultString += arr_j + " -> ";
            }
            if (j === 1) {
                for (var k = 0; k < arr_j.length; k++) {
                    var arr_k = arr_j[k];
                    parameterNames[parameterNames.length] = arr_k[1];
                    parameterTypes[parameterTypes.length] = arr_k[0];
                }
            } else if (j === 2 && (arr_j !== undefined)) {
				var arr_j1 = [];
                for (var k = 0; k < arr_j.length; k++) {
                    arr_k = arr_j[k];
                    var theIndex = parameterNames.indexOf(arr_k);
                    if(arr_k === "_" || arr_k === "__"){
						arr_j1[k] = arr_k;
                    }
                    else if (theIndex !== -1) {
                        parameterPositions[parameterNames.indexOf(arr_k)] = arr_j.indexOf(arr_k);
                        arr_j1[k] = parameterTypes[theIndex];
                    } else {
                        arr_j1[k] = "\"" + arr_j[k] + "\""
                    }
                }
                resultString += arr_j1.join(" _ ")
            } else if (j === 3 && (arr_j !== undefined)) {
                var arr_j1 = [];
                for (var k = 0; k < arr_j.length; k++) {
                    arr_k = arr_j[k];
                    var theIndex = parameterNames.indexOf(arr_k);
                    if(arr_k === "__"){
						arr_j1[k] = "\" \"";
                    }
                    else if(arr_k === "_"){
						arr_j1[k] = "\"\"";
                    }
                    else if (theIndex !== -1) {
                        arr_j1[k] = "d[" + numIndex(parameterPositions[theIndex]) + "]";
                    } else {
                        arr_j1[k] = "\"" + arr_j[k] + "\"";
                    }
                }
                resultString += "{\%function(d){\n\treturn " + arr_j1.join(" + ") + ";\n}%\}\n";
            }
        }
    }
    if(listOfErrors != ""){
		throw "There are some errors in grammar.txt\n" + listOfErrors;
    }
    return [translateFrom, translateTo, resultString];
}
%}

#Start parsing from here.
#Flatten the arrays by appending them with the instructions here:
#    http://stackoverflow.com/questions/351409/appending-to-array
mainPattern1 -> _ mainPattern _ multiLineString _ {%function(d){
	//console.log("Calling mainPattern1");
	var toReturn = [d[1][0], d[1][1], d[3] + d[1][2]];
	return toReturn;
}%}

multiLineString -> "'''" _multiLineString "'''" {%function(d){return d[1];}%}

_multiLineString -> anyChar {%function(d){
	return d[0];
}%}

anyChar -> _anyChar {%function(d){
	return d[0];}
%}
| anyChar _anyChar {% function(d){
	return d[0] + d[1];
} %}

_anyChar -> ([^\n] | [\n]) {%function(d){return d[0];}%}

mainPattern -> _ listOfLanguages _ "{" _ seriesOfFunctions _ "}" _ {%function(d){
	return getOutput([d[1], d[5]]);
}%}
seriesOfFunctions -> func {%function(d){return [d[0]];}%} | func _ seriesOfFunctions {%
	function(d){
		return [d[0]].concat(d[2]);
	}
%}
func -> identifier  _ "(" _ parameterList _ ")" _ seriesOfRules {%
	function(d){
		return [d[0], d[4], d[8]];
	}
%}
parameterList -> parameter | _parameterList {%function(d){return d[0];}%}
_parameterList -> parameter _ "," _ parameterList {%
	function(d){
		return [d[0]].concat(d[4]);
	}
%}
parameter -> identifier __ identifier {%
	function(d){
		return [d[0], d[2]];
	}
%}
seriesOfRules -> rule {%function(d){
	return [d[0]];
}%}
| rule _ seriesOfRules {%function(d){
	return [d[0]].concat(d[2]);
}%}

rule -> listOfLanguages (_ ":" _ | _) String {%function(d){
	return [d[0], d[2]];
}%}

listOfLanguages -> language_name {%function(d){
	return [d[0]];
}%}
| language_name _ "," _ listOfLanguages {%function(d){
	return [d[0]].concat(d[4]);
}%}

language_name -> language_name __ _language_name {%function(d){return (d[0] + " " + d[2]);}%} | _language_name {% function(d) {return d[0]; } %}
_language_name -> [\w+#*_\.\!\-\/] {% id %}
	| _language_name [\w+#*_\.\!\-\/] {% function(d) {return d[0] + d[1]; } %}

# Whitespace
_ -> null | _ [\s] {% function() {} %}
__ -> [\s] | __ [\s] {% function() {} %}

#string literals, valid in all languages, adapted from https://gist.github.com/Hardmath123/11024526
String -> "\"" _string "\"" {% function(d) {return d[1]; } %}
_string -> string_token {%function(d){return [d[0]];}%} | string_token __ _string {%function(d){return [d[0]].concat(d[2]);}%}
string_token -> string_token string_char {%function(d){return d[0] + d[1];}%} | string_char {%function(d){return d[0][0];}%}
string_char -> [^"\s]

#adapted from https://gist.github.com/Hardmath123/11024526
identifier -> _name {% function(d) {return d[0] } %}
_name -> [a-zA-Z_#-*+] {% id %}
	| _name [\w_] {% function(d) {return d[0] + d[1]; } %}

#Numbers
number -> _number {% function(d) {return parseFloat(d[0])} %}

_posint ->
	[0-9] {% id %}
	| _posint [0-9] {% function(d) {return d[0] + d[1]} %}

_int ->
	"-" _posint {% function(d) {return d[0] + d[1]; }%}
	| _posint {% id %}

_float ->
	_int {% id %}
	| _int "." _posint {% function(d) {return d[0] + d[1] + d[2]; }%}

_number ->
	_float {% id %}
	| _float "e" _int {% function(d){return d[0] + d[1] + d[2]; } %}
