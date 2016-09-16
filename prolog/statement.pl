statement(Data,enum(Name,Body)) -->
        {
            namespace(Data,Data1,Name,Indent)
        },
        enum_(Data,[
			symbol(Name),
			enum_list(Data1,Body),
			Indent
		]).

statement(Data,Type1,function(Name,Type,Params1,Body)) -->
        {
                namespace(Data,Data1,Name1,Indent),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1))
        },
        %put this at the beginning of each statement without a semicolon
		optional_indent(Data,Indent),
		function_(Data,[
			function_name(Data,Type,Name,Params1),
			type(Data,Type),
			Params,
			statements(Data1,Type,Body),
			Indent
		]).

%java-like class statements
statement(Data,Name,class(Name,Body)) -->
        {
                namespace(Data,Data1,Name,Indent)
        },
		optional_indent(Data,Indent),
		class_(Data,[
		        symbol(Name),
                class_statements(Data1,Name,Body),
				Indent
		]).

statement(Data,C1,class_extends(C2,B)) -->
        {
                namespace(Data,Data1,C1,Indent)
        },
        optional_indent(Data,Indent),
        class_extends_(Data,[
			    symbol(C1),
                symbol(C2),
                class_statements(Data1,C1,B),
                Indent
        ]).

statement(Data,Return_type,semicolon(A)) -->
		{Data = [_,_,_,_,Indent,_],offside_rule_langs(Offside_rule_langs)},
        optional_indent(Data,Indent),
        semicolon_(Data,[
			statement_with_semicolon(Data,Return_type,A)
		]).

statement(Data,Return_type,for(Statement1,Expr,Statement2,Body)) -->
        {
                indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        for_(Data,[
			    statement_with_semicolon(Data,Return_type,Statement1),
                expr(Data,bool,Expr),
                statement_with_semicolon(Data,Return_type,Statement2),
                statements(Data1,Return_type,Body),
				Indent
		]).

statement(Data,Return_type,foreach_with_index(Array,Var,Index,Body,Type)) -->
        {
                indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        foreach_with_index_(Data,[
			    expr(Data,[array,Type],Array),
                var_name_(Data,Type,Var),
                expr(Data,int,Index),
                type(Data,Type),
                statements(Data1,Return_type,Body),
				Indent
		]).

statement(Data,Return_type,foreach(Array,Var,Body,Type)) -->
        {
                indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        foreach_(Data,[
                expr(Data,[array,Type],Array),
                var_name_(Data,Type,Var),
                type(Data,Type),
                statements(Data1,Return_type,Body),
				Indent
		]).

statement(Data,Return_type,try_catch(Body1,Name,Body2)) -->
        {
			indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        try_catch_(Data,[
			statements(Data1,Return_type,Body1),
			var_name_(Data1,int,Name),
			statements(Data1,Return_type,Body2),
			Indent
		]).

statement(Data,Return_type,while(Expr,Body)) -->
        {
			indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        while_(Data,[
			expr(Data,bool,Expr),
			statements(Data1,Return_type,Body),
			Indent
		]).

statement(Data,Return_type,do_while(Expr,Body)) -->
        {
				indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        do_while_(Data,[
			expr(Data,bool,Expr),
			statements(Data1,Return_type,Body),
			Indent
		]).


statement(Data,Return_type,if(Expr_,Statements_,Elif_or_else_,Else_)) -->
        {
                indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),
        if(Data,[
                expr(Data,bool,Expr_),
                statements(Data1,Return_type,Statements_),
                elif_or_else(Data,Return_type,Elif_or_else_),
                else(Data,Return_type,Else_),
				Indent
        ]).
statement(Data,Return_type, switch(Expr_,Expr1_,Statements_,Case_or_default_)) -->
		{
				indent_data(Indent,Data,Data1)
		},
		optional_indent(Data,Indent),
		switch_(Data,[
			parentheses_expr(Data,int,Expr_),
			first_case(Data1,Return_type,Expr_,int,[Expr1_,Statements_,Case_or_default_]),
			Indent
		]).
