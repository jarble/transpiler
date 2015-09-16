//These are the input and output languages for this file.
//The grammar is defined in theGrammar.txt in the same folder as this file.
//Copy the lists of languages from polyglotcodegenerator.py to theGrammar.txt.

//Don't modify any other code in this file.


var nearley = require("nearley");
var reversibleTranslator = require("./reversibleTranslator.js");
var fs = require('fs');


var reversible = new nearley.Parser(reversibleTranslator.ParserRules, reversibleTranslator.ParserStart);

fs.readFile("theGrammar.txt", 'utf8', function(err, data) {
  if (err) throw err;
  //console.log(data);
  var theOutput = reversible.feed(data).results[0];
  lang1 = theOutput[0]
  lang2 = theOutput[1]
  //console.log(theOutput[2])
  var fileName = "generated_translators/"+lang1+"-"+lang2+".ne";
  fs.writeFile(fileName, theOutput[2], function(err) {
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
