:- module('tokenizer', [tokenize/2]).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
:- include(common_grammar).

tokenize(Text,Output) :- phrase(tokenize(Output),Text).
tokenize([A]) --> string_literal(A).
tokenize([A]) --> an_int(A).
tokenize([A]) --> symbol(A).
tokenize([";"]) --> ";".
tokenize(["+="]) --> "+=".
tokenize(["*="]) --> "*=".
tokenize(["+"]) --> "+".
tokenize(["-"]) --> "-".
tokenize([">"]) --> ">".
tokenize(["<"]) --> "<".
tokenize([")"]) --> ")".
tokenize(["("]) --> "(".
tokenize(["!"]) --> "!".
tokenize(["@"]) --> "@".
tokenize(["="]) --> "=".
tokenize(["*"]) --> "*".
tokenize(["/"]) --> "/".
tokenize(["|"]) --> "|".
tokenize(["&"]) --> "&".
tokenize(["."]) --> ".".
tokenize(["."]) --> "?".
tokenize(["^"]) --> "^".
tokenize(["?"]) --> "?".
tokenize(["$"]) --> "$".
tokenize(["#"]) --> "#".
tokenize(["%"]) --> "%".
tokenize([A|B]) --> tokenize([A]),skip_space,tokenize(B).
skip_space -->
  [C], {code_type(C, space)}, skip_space.
skip_space --> [].
