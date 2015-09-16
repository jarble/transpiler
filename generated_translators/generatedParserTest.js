//These are the input and output languages for this file.
//The grammar is defined in theGrammar.txt in the same folder as this file.
//Copy the lists of languages from polyglotcodegenerator.py to theGrammar.txt.
//Don't modify any other code in this file.


var nearley = require("nearley");
var translator = require("./Java-Haskell.js");

var translator = new nearley.Parser(translator.ParserRules, translator.ParserStart);
var fs = require("fs");

fs.readFile("javaExample.java", 'utf8', function(err, data) {
  if (err) throw err;
  //console.log(data);
  console.log("The output of the translator is printed below.")
  var theOutput = translator.feed(data).results;
  console.log(theOutput[0])
  //console.log(theOutput[2])
  var fileName = "javaExample.hs";
  fs.writeFile(fileName, theOutput, function(err) {
    if(err) {
        return console.log(err);
    }

    console.log(fileName + " was saved!");
});
});


//console.log(theOutput[0]);

var grammarGenerator = {
	"ifStatement":[["boolean a", "seriesOfStatements b"]]
};

//console.log("\n");
//console.log(JSON.stringify(theOutput[0][1][0][0]));

//console.log("\n");
//console.log(JSON.stringify(theOutput[0][1][0][1]));

//console.log("\n");
//console.log(JSON.stringify(theOutput[0][1][0][2]));

//console.log("\n");
//console.log(JSON.stringify(theOutput[0][1][1]));

//console.log("\n");
//console.log(JSON.stringify(theOutput[0][1][2]));
//console.log(JSON.stringify(generateTranslator("Java", "Lua", arrayToTranslate)));

/*
Java,Lua
	whileLoop(boolean a, series_of_statements b) =
		Java:"while a { b }"
		Ruby,Lua:"do while a b end"
*/
//find out how to do a foreach loop in JavaScript
function generateTranslator(lang1, lang2, text){
	for(var i = 0; i < text.length; i++){
		console.log(JSON.stringify(text[i]));
		console.log("\n\n")
	}
	return text;
}

// p.results --> [ ["sum", "1", "1"] ]
