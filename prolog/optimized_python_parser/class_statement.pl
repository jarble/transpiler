%The grammar files are saved in grammars.pl

class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        namespace(Data,Data1,Class_name,Indent),
        %put this at the beginning of each statement without a semicolon
        constructor_(Data,[
			function_name(Data,Class_name,Class_name,Params1),
			parameters(Data1,Params1),
			statements(Data1,_,Body1),
			Indent
		]).

class_statement(Data,_,static_method(Name1,Type1,Params1,Body1)) -->
        namespace(Data,Data1,Name1,Indent),
        %put this at the beginning of each statement without a semicolon
        static_method_(Data, [
			function_name(Data,Type1,Name1,Params1),
			type(Data,Type1),
			parameters(Data1,Params1),
			statements(Data1,Type1,Body1),
			Indent
		]).

class_statement(Data,_,instance_method(Name1,Type1,Params1,Body1)) -->
	namespace(Data,Data1,Name1,Indent),
	instance_method_(Data,[
			function_name(Data,Type1,Name1,Params1),
			type(Data1,Type1),
			parameters(Data1,Params1),
			statements(Data1,Type1,Body1),
			Indent
	]).

class_statement(Data,_,initialize_static_var_with_value(Type,Name,Expr)) -->
	initialize_static_var_with_value_(Data,[
		type(Data,Type),
		var_name_(Data,Type,Name),
		expr(Data,Type,Expr)
	]).

class_statement(Data,_,initialize_instance_var(Type,Name)) -->
	initialize_instance_var_(Data,[
		type(Data,Type),
		var_name_(Data,Type,Name)
	]).

class_statement(Data,_,initialize_instance_var_with_value_(Name,Expr,Type)) -->
	initialize_instance_var_with_value_(Data,[
		var_name_(Data,Type,Name),
		expr(Data,Type,Expr),
		type(Data,Type)
	]).
