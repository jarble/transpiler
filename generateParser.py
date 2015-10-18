#Register for Physics class before working on this project
#documentation is here: https://github.com/Hardmath123/nearley
#Translate each language into EngScript, then use polyglotcodegenerator.py to translate it into other languages.
#The grammar and output is specified in test.ne.

from subprocess import call
def generateParsers(parserNames):
	for current in parserNames.split(","):
		call(["nearleyc", current+".ne", "-o", current+".js"] ,shell=True)

#generateParsers("test,englishToJavaScript,reversibleTranslator,reversePolishNotation")
generateParsers("reversibleTranslator")
