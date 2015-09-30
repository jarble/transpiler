// Generated automatically by nearley
// http://github.com/Hardmath123/nearley
(function () {
function id(x) {return x[0]; }

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
var grammar = {
    ParserRules: [
    {"name": "mainPattern1", "symbols": ["_", "mainPattern", "_", "multiLineString", "_"], "postprocess": function(d){
	//console.log("Calling mainPattern1");
	var toReturn = [d[1][0], d[1][1], d[3] + d[1][2]];
	return toReturn;
}},
    {"name": " string$1", "symbols": [{"literal":"'"}, {"literal":"'"}, {"literal":"'"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": " string$2", "symbols": [{"literal":"'"}, {"literal":"'"}, {"literal":"'"}], "postprocess": function joiner(d) {
        return d.join('');
    }},
    {"name": "multiLineString", "symbols": [" string$1", "_multiLineString", " string$2"], "postprocess": function(d){return d[1];}},
    {"name": "_multiLineString", "symbols": ["anyChar"], "postprocess": function(d){
	return d[0];
}},
    {"name": "anyChar", "symbols": ["_anyChar"], "postprocess": function(d){
	return d[0];}
},
    {"name": "anyChar", "symbols": ["anyChar", "_anyChar"], "postprocess":  function(d){
	return d[0] + d[1];
} },
    {"name": "_anyChar", "symbols": [" subexpression$3"], "postprocess": function(d){return d[0];}},
    {"name": "mainPattern", "symbols": ["_", "listOfLanguages", "_", {"literal":"{"}, "_", "seriesOfFunctions", "_", {"literal":"}"}, "_"], "postprocess": function(d){
	return getOutput([d[1], d[5]]);
}},
    {"name": "seriesOfFunctions", "symbols": ["func"], "postprocess": function(d){return [d[0]];}},
    {"name": "seriesOfFunctions", "symbols": ["func", "_", "seriesOfFunctions"], "postprocess": 
	function(d){
		return [d[0]].concat(d[2]);
	}
},
    {"name": "func", "symbols": ["identifier", "_", {"literal":"("}, "_", "parameterList", "_", {"literal":")"}, "_", "seriesOfRules"], "postprocess": 
	function(d){
		return [d[0], d[4], d[8]];
	}
},
    {"name": "parameterList", "symbols": ["parameter"]},
    {"name": "parameterList", "symbols": ["_parameterList"], "postprocess": function(d){return d[0];}},
    {"name": "_parameterList", "symbols": ["parameter", "_", {"literal":","}, "_", "parameterList"], "postprocess": 
	function(d){
		return [d[0]].concat(d[4]);
	}
},
    {"name": "parameter", "symbols": ["identifier", "__", "identifier"], "postprocess": 
	function(d){
		return [d[0], d[2]];
	}
},
    {"name": "seriesOfRules", "symbols": ["rule"], "postprocess": function(d){
	return [d[0]];
}},
    {"name": "seriesOfRules", "symbols": ["rule", "_", "seriesOfRules"], "postprocess": function(d){
	return [d[0]].concat(d[2]);
}},
    {"name": "rule", "symbols": ["listOfLanguages", " subexpression$4", "String"], "postprocess": function(d){
	return [d[0], d[2]];
}},
    {"name": "listOfLanguages", "symbols": ["language_name"], "postprocess": function(d){
	return [d[0]];
}},
    {"name": "listOfLanguages", "symbols": ["language_name", "_", {"literal":","}, "_", "listOfLanguages"], "postprocess": function(d){
	return [d[0]].concat(d[4]);
}},
    {"name": "language_name", "symbols": ["language_name", "__", "_language_name"], "postprocess": function(d){return (d[0] + " " + d[2]);}},
    {"name": "language_name", "symbols": ["_language_name"], "postprocess":  function(d) {return d[0]; } },
    {"name": "_language_name", "symbols": [/[\w+#*_\.\!\-\/]/], "postprocess":  id },
    {"name": "_language_name", "symbols": ["_language_name", /[\w+#*_\.\!\-\/]/], "postprocess":  function(d) {return d[0] + d[1]; } },
    {"name": "_", "symbols": []},
    {"name": "_", "symbols": ["_", /[\s]/], "postprocess":  function() {} },
    {"name": "__", "symbols": [/[\s]/]},
    {"name": "__", "symbols": ["__", /[\s]/], "postprocess":  function() {} },
    {"name": "String", "symbols": [{"literal":"\""}, "_string", {"literal":"\""}], "postprocess":  function(d) {return d[1]; } },
    {"name": "_string", "symbols": ["string_token"], "postprocess": function(d){return [d[0]];}},
    {"name": "_string", "symbols": ["string_token", "__", "_string"], "postprocess": function(d){return [d[0]].concat(d[2]);}},
    {"name": "string_token", "symbols": ["string_token", "string_char"], "postprocess": function(d){return d[0] + d[1];}},
    {"name": "string_token", "symbols": ["string_char"], "postprocess": function(d){return d[0][0];}},
    {"name": "string_char", "symbols": [/[^"\s]/]},
    {"name": "identifier", "symbols": ["_name"], "postprocess":  function(d) {return d[0] } },
    {"name": "_name", "symbols": [/[a-zA-Z_#-*+]/], "postprocess":  id },
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
    {"name": " subexpression$3", "symbols": [/[^\n]/]},
    {"name": " subexpression$3", "symbols": [/[\n]/]},
    {"name": " subexpression$4", "symbols": ["_", {"literal":":"}, "_"]},
    {"name": " subexpression$4", "symbols": ["_"]}
]
  , ParserStart: "mainPattern1"
}
if (typeof module !== 'undefined'&& typeof module.exports !== 'undefined') {
   module.exports = grammar;
} else {
   window.grammar = grammar;
}
})();
