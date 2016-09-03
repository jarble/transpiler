statement(Data,enum(Name1,Body1)) -->
        {
                namespace(Data,Data1,Name1,Indent),
                Name = symbol(Name1),
                Body = enum_list(Data1,Body1)
        },
        enum_(Data,[Name,Body,Indent]).

statement(Data,Type1,function(Name1,Type1,Params1,Body1)) -->
        {
                namespace(Data,Data1,Name1,Indent),
                Name = function_name(Data,Type1,Name1,Params1),
                Type = type(Data,Type1),
                Body = statements(Data1,Type1,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
		optional_indent(Data,Indent),
		function_(Data,[Name,Type,Params,Body,Indent]).

%java-like class statements
statement(Data,Name1,class(Name1,Body1)) -->
        {
                namespace(Data,Data1,Name1,Indent),
                Name = symbol(Name1),
                Body=class_statements(Data1,Name1,Body1)
        },
		optional_indent(Data,Indent),
		class_(Data,[Name,Body,Indent]).

statement(Data,C1,class_extends(C1_,C2_,B_)) -->
        {
                namespace(Data,Data1,C1_,Indent),
                C1 = symbol(C1_),
                C2 = symbol(C2_),
                B=class_statements(Data1,C1_,B_)
        },
        optional_indent(Data,Indent),
        class_extends_(Data,[C1,C2,B,Indent]).

statement(Data,Return_type,semicolon(A_)) -->
		{Data = [_,_,_,_,Indent,_],A=statement_with_semicolon(Data,Return_type,A_),offside_rule_langs(Offside_rule_langs)},
        optional_indent(Data,Indent),
        semicolon_(Data,[A]).

statement(Data,Return_type,for(Statement1_,Expr_,Statement2_,Body1)) -->
        {
                indent_data(Indent,Data,Data1),
                Body = statements(Data1,Return_type,Body1),
                Statement1 = statement_with_semicolon(Data,Return_type,Statement1_),
                Condition = expr(Data,bool,Expr_),
                Statement2 = statement_with_semicolon(Data,Return_type,Statement2_)
        },
        optional_indent(Data,Indent),
        for_(Data,[Statement1,Condition,Statement2,Body,Indent]).

statement(Data,Return_type,foreach_with_index(Array1,Var1,Index1,Body1,Type1)) -->
        {
                indent_data(Indent,Data,Data1),
                Array = expr(Data,[array,Type1],Array1),
                Index = expr(Data,int,Index1),
                Var = var_name_(Data,Type1,Var1),
                Type = type(Data,Type1),
                Body = statements(Data1,Return_type,Body1)
        },
        optional_indent(Data,Indent),
        foreach_with_index_(Data,[Array,Var,Index,Type,Body,Indent]).

statement(Data,Return_type,foreach(Array1,Var1,Body1,Type1)) -->
        {
                indent_data(Indent,Data,Data1),
                Array = expr(Data,[array,Type1],Array1),
                Var = var_name_(Data,Type1,Var1),
                Type = type(Data,Type1),
                Body = statements(Data1,Return_type,Body1)
        },
        optional_indent(Data,Indent),
        foreach_(Data,[Array,Var,Type,Body,Indent]).

statement(Data,Return_type,while(Expr1,Body1)) -->
        {
				indent_data(Indent,Data,Data1),
				B = statements(Data1,Return_type,Body1),
                A = expr(Data,bool,Expr1)
        },
        optional_indent(Data,Indent),
        while_(Data,[A,B,Indent]).
        
statement(Data,Return_type,do_while(Expr1,Body1)) -->
        {
				indent_data(Indent,Data,Data1),
				B = statements(Data1,Return_type,Body1),
                A = expr(Data,bool,Expr1)
        },
        optional_indent(Data,Indent),
        do_while_(Data,[A,B,Indent]).


statement(Data,Return_type,if(Expr_,Statements_,Elif_or_else_,Else_)) -->
        {
                indent_data(Indent,Data,Data1),
                A = expr(Data,bool,Expr_),
                B = statements(Data1,Return_type,Statements_),
                C = elif_or_else(Data,Return_type,Elif_or_else_),
                D = else(Data,Return_type,Else_)
        },
        optional_indent(Data,Indent),
        if(Data,[A,B,C,D,Indent]).
statement(Data,Return_type, switch(Expr_,Expr1_,Statements_,Case_or_default_)) -->
		{
				indent_data(Indent,Data,Data1),
				A = parentheses_expr(Data,int,Expr_),
				B = first_case(Data1,Return_type,Expr_,int,[Expr1_,Statements_,Case_or_default_])
		},
		optional_indent(Data,Indent),
		switch_(Data,[A,B,Indent]).
