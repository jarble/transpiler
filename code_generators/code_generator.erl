
ternary_operator(Lang,A,B,C) -> 
    if lists:member(Lang,["java"]) ->
        string:concat(string:concat(string:concat(string:concat(string:concat(string:concat("(",A),"?"),B),":"),C),")")
    end.
