
ternary_operator::String -> String -> String -> String -> String
ternary_operator lang a b c = 
    (if (elem ["java"] lang) then 
        "(" ++ a ++ "?" ++ b ++ ":" ++ c ++ ")")
