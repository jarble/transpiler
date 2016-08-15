%The grammar files are saved in grammars_old.pl

class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        {
                namespace(Data,Data1,Class_name,Indent),
                Name = function_name(Data,Class_name,Class_name,Params1),
                Body = statements(Data1,_,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
        constructor_(Data,[Params,Body,Indent]).

class_statement(Data,_,static_method(Name1,Type1,Params1,Body1)) -->
        {
                namespace(Data,Data1,Name1,Indent),
                Name = function_name(Data,Type1,Name1,Params1),
                Body = statements(Data1,Type1,Body1),
                Type = type(Data,Type1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
        static_method_(Data, [Name,Type,Params,Body,Indent]).

class_statement(Data,_,instance_method(Name1,Type1,Params1,Body1)) -->
	{
		namespace(Data,Data1,Name1,Indent),
		Name = function_name(Data,Type1,Name1,Params1),
		Body = statements(Data1,Type1,Body1),
		Type = type(Data,Type1),
		(Params1 = [], Params = ""; Params = parameters(Data1,Params1))
	},
	%put this at the beginning of each statement without a semicolon
    instance_method_(Data,[Name,Type,Params,Body,Indent]).

class_statement(Data,_,initialize_static_var_with_value(Type1,Name1,Expr1)) -->
        {
                Value = expr(Data,Type1,Expr1),
                Name = var_name_(Data,Type1,Name1),
                Type = type(Data,Type1)
        },
        initialize_static_var_with_value_(Data,[Type,Name,Value]).
