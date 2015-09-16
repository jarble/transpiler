#Edit this file name to specify the parser that will be generated.

name1 = input("Type the name of the input language, then press enter:")

name2 = input("Type the name of the output language, then press enter:")

fileName = name1 + "-" + name2


print(3+7)
from subprocess import call
def generateParsers(parserNames):
	for current in parserNames.split(","):
		call(["nearleyc", current+".ne", "-o", current+".js"] ,shell=True)

#generateParsers("test,englishToJavaScript,reversibleTranslator,reversePolishNotation")
#generateParsers("Java-PHP,Java-C#,Java-JavaScript,Java-Ruby")
generateParsers(fileName)
