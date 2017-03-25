:- module('tokenizer', [parse/2]).
:- set_prolog_flag(double_quotes,chars).
:- initialization(main).
:- include(common_grammar).


main :- Input = "console.log(doh-ah);", parse(Input,Output),writeln(Input),writeln(Output).

parse(Text,Output) :- phrase(tokenize(Output1),Text),writeln(Output1),phrase(statements(Output),Output1).
statements_(A) --> ws,statements(A),ws.
statements([A]) --> statement(A).
statements([A|B]) --> statement(A),statements(B).
statement(statement_with_semicolon(A)) --> statement_with_semicolon(A),[";"].
statement_with_semicolon(println(_,A)) --> [symbol("console")],["."],[symbol("log")],["("],expr(A),[")"].
statement_with_semicolon(set_var(_,A,B)) --> [symbol(A)],["="],expr(B).
statement_with_semicolon(initialize_var(_,A,B)) --> [symbol("var")],[symbol(A)],["="],expr(B).



expr(A) --> add_expr(A).
add_expr(add(_,A,B)) --> parentheses_expr(A),["+"],add_expr(B).
add_expr(subtract(_,A,B)) --> parentheses_expr(A),["-"],add_expr(B).
add_expr(A) --> parentheses_expr(A).
parentheses_expr(var_name(_,A)) --> [symbol(A)].
parentheses_expr(parentheses(A)) --> ["("],expr(A),[")"].


tokenize([string_literal(A)]) --> string_literal(A).
tokenize([symbol(A)]) --> symbol(A).
tokenize([";"]) --> ";".
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
  ws;"\n".
operator(">") --> ">".
