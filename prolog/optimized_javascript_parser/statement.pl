optional_indent(Data,Indent,Data1) -->
	    {
                indent_data(Indent,Data,Data1)
        },
        optional_indent(Data,Indent),!.

statement(Data,Type1,function(Name,Type,Params1,Body)) -->
        %put this at the beginning of each statement without a semicolon
		namespace(Data,Data1,Name1,Indent),
		function_(Data,[
			function_name(Data,Type,Name,Params1),
			type(Data,Type),
			parameters(Data1,Params1),
			statements(Data1,Type,Body),
			Indent
		]),!.

%java-like class statements
statement(Data,Name,class(Name,Body)) -->
		optional_indent(Data,Indent,Data1),
		class_(Data,[
		        symbol(Name),
                class_statements(Data1,Name,Body),
				Indent
		]),!.

statement(Data,C1,class_extends(C2,B)) -->
        namespace(Data,Data1,C1,Indent),
        class_extends_(Data,[
			    symbol(C1),
                symbol(C2),
                class_statements(Data1,C1,B),
                Indent
        ]),!.

statement(Data,Return_type,semicolon(A)) -->
		{Data = [_,_,_,Indent],offside_rule_langs(Offside_rule_langs)},
        optional_indent(Data,Indent,_),
        semicolon_(Data,[
			statement_with_semicolon(Data,Return_type,A)
		]),!.

statement(Data,Return_type,for(Statement1,Expr,Statement2,Body)) -->
        optional_indent(Data,Indent,Data1),
        for_(Data,[
			    statement_with_semicolon(Data,Return_type,Statement1),
                expr(Data,bool,Expr),
                statement_with_semicolon(Data,Return_type,Statement2),
                statements(Data1,Return_type,Body),
				Indent
		]),!.

statement(Data,Return_type,foreach_with_index(Array,Var,Index,Body,Type)) -->
        optional_indent(Data,Indent,Data1),
        foreach_with_index_(Data,[
			    expr(Data,[array,Type],Array),
                var_name_(Data,Type,Var),
                expr(Data,int,Index),
                type(Data,Type),
                statements(Data1,Return_type,Body),
				Indent
		]),!.

statement(Data,Return_type,foreach(Array,Var,Body,Type)) -->
        optional_indent(Data,Indent,Data1),
        foreach_(Data,[
                expr(Data,[array,Type],Array),
                var_name_(Data,Type,Var),
                type(Data,Type),
                statements(Data1,Return_type,Body),
				Indent
		]),!.

statement(Data,Return_type,try_catch(Body1,Name,Body2)) -->
        optional_indent(Data,Indent,Data1),
        try_catch_(Data,[
			statements(Data1,Return_type,Body1),
			var_name_(Data1,int,Name),
			statements(Data1,Return_type,Body2),
			Indent
		]),!.

statement(Data,Return_type,while(Expr,Body)) -->
        optional_indent(Data,Indent,Data1),
        while_(Data,[
			expr(Data,bool,Expr),
			statements(Data1,Return_type,Body),
			Indent
		]),!.

statement(Data,Return_type,do_while(Expr,Body)) -->
        optional_indent(Data,Indent,Data1),
        do_while_(Data,[
			expr(Data,bool,Expr),
			statements(Data1,Return_type,Body),
			Indent
		]),!.


statement(Data,Return_type,if(Expr_,Statements_,Elif_or_else_,Else_)) -->
        optional_indent(Data,Indent,Data1),
        if(Data,[
                expr(Data,bool,Expr_),
                statements(Data1,Return_type,Statements_),
                elif_statements(Data,Return_type,Elif_or_else_),
                else(Data,Return_type,Else_),
				Indent
        ]),!.

statement(Data,Return_type,if_without_else(Expr_,Statements_,Elif_or_else_,Else_)) -->
        optional_indent(Data,Indent,Data1),
        if_without_else_(Data,[
                expr(Data,bool,Expr_),
                statements(Data1,Return_type,Statements_),
				Indent
        ]),!.

statement(Data,Return_type, switch(Expr_,Expr1_,Statements_,Case_or_default_)) -->
		optional_indent(Data,Indent,Data1),
		switch_(Data,[
			parentheses_expr(Data,int,Expr_),
			first_case(Data1,Return_type,Expr_,int,[Expr1_,Statements_,Case_or_default_]),
			Indent
		]),!.
