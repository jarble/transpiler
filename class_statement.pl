
class_statement(Data,Class_name,constructor(Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Global_vars,Indent],
                Data1 = [Lang,Is_input,[Class_name|Namespace],Global_vars,indent(Indent)],
                Name = function_name(Data,Class_name,Class_name,Params1),
                Body = statements(Data1,_,Body1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
                Indent_ = (Indent;"")
        },
        %put this at the beginning of each statement without a semicolon
        Indent_,({memberchk(Lang,['rebol'])}->
                "new:",ws_,"func",ws,"[",ws,Params,ws,"]",ws,"[",ws,"make",ws_,"self",ws,"[",ws,Body,ws,"]",ws,"]";
        {memberchk(Lang,['crosslanguage'])}->
                "(",ws,"constructor",ws_,Name,ws_,Params,ws_,Body,ws,")";
        {memberchk(Lang,['visual basic .net'])}->
                "Sub",ws_,"New",ws,"(",ws,Params,ws,")",ws_,Body,ws_,"End",ws_,"Sub";
        {memberchk(Lang,['python'])}->
                "def",ws_,"__init__",ws,"(",ws,"",ws,"self",ws,",",ws,Params,ws,")",ws,":",Body;
        {memberchk(Lang,['java','c#','vala'])}->
                "public",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['swift'])}->
                "init",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['javascript'])}->
                "constructor",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"initialize",ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['php'])}->
                "function",ws_,"construct",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,"new",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,"new",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['c++','dart'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['d'])}->
                "this",ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['chapel'])}->
                "proc",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {not_defined_for(Data,'constructor')}).

class_statement(Data,_,static_method(Name1,Type1,Params1,Body1)) -->
        {
                Data = [Lang,Is_input,Namespace,Var_types,Indent],
                Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
                Name = function_name(Data,Type1,Name1,Params1),
                Body = statements(Data1,Type1,Body1),
                Type = type(Lang,Type1),
                (Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
                Indent_ = (Indent;"")
        },
        %put this at the beginning of each statement without a semicolon
        Indent_,({memberchk(Lang,['swift','pseudocode'])}->
                "class",ws_,"func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Shared",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws_,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['haxe','pseudocode'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['lua','julia'])}->
                "function",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['java','c#','pseudocode'])}->
                "public",ws_,"static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['c++','dart','pseudocode'])}->
                "static",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['php','pseudocode'])}->
                "public",ws_,"static",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,"self",ws,".",ws,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['c'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['javascript','pseudocode'])}->
                "static",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['picat'])}->
                ws;
        {memberchk(Lang,['python'])}->
                "@staticmethod",ws,"\n",ws_,"def",ws_,Name,ws,"(",ws,"",ws,Params,ws,")",ws,":",Body;
        {not_defined_for(Data,'static_method')}).

class_statement(Data,_,instance_method(Name1,Type1,Params1,Body1)) -->
	{
		Data = [Lang,Is_input,Namespace,Var_types,Indent],
		Data1 = [Lang,Is_input,[Name1|Namespace],Var_types,indent(Indent)],
		Name = function_name(Data,Type1,Name1,Params1),
		Body = statements(Data1,Type1,Body1),
		Type = type(Lang,Type1),
		(Params1 = [], Params = ""; Params = parameters(Data1,Params1)),
		Indent_ = (Indent;"")
	},
	%put this at the beginning of each statement without a semicolon
    Indent_,
	({memberchk(Lang,['swift'])}->
                "func",ws_,Name,ws,"(",ws,Params,ws,")",ws,"->",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,[logtalk])}->
                Name,ws,"(",ws,Params,ws,",",ws,"Return",ws,")",ws_,":-",ws_,Body;
        {memberchk(Lang,['perl'])}->
                "sub",ws_,Name,ws,"{",ws,Params,ws,Body,(Indent;ws),"}";
        {memberchk(Lang,['visual basic .net'])}->
                "Public",ws_,"Function",ws_,"InstanceMethod",ws,"(",ws,Params,ws,")",ws,"As",ws_,Type,ws_,Body,ws_,"End",ws_,"Function";
        {memberchk(Lang,['javascript'])}->
                Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['perl 6'])}->
                "method",ws_,Name,ws_,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['chapel'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['java','c#'])}->
                "public",ws_,Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['php'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['ruby'])}->
                "def",ws_,Name,ws,"(",ws,Params,ws,")",ws_,Body,(Indent;ws_),"end";
        {memberchk(Lang,['c++','d','dart'])}->
                Type,ws_,Name,ws,"(",ws,Params,ws,")",ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['haxe'])}->
                "public",ws_,"function",ws_,Name,ws,"(",ws,Params,ws,")",ws,":",ws,Type,ws,"{",ws,Body,(Indent_;ws),"}";
        {memberchk(Lang,['python'])}->
                "def",ws_,Name,ws,"(",ws,"self,",ws,Params,ws,")",ws,":",Body;
        {not_defined_for(Data,'instance_method')}).

class_statement(Data,_,initialize_static_var_with_value(Type1,Name1,Expr1)) -->
        {
                Data = [Lang|_],
                Value = expr(Data,Type1,Expr1),
                Name = var_name(Data,Type1,Name1),
                Type = type(Lang,Type1)
        },
    ({memberchk(Lang,['polish notation'])}->
        "=",ws_,Name,ws_,Value;
    {memberchk(Lang,['reverse polish notation'])}->
        Name,ws_,Value,ws_,"=";
    {memberchk(Lang,['go'])}->
        "var",ws_,Name,ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['rust'])}->
        "let",ws_,"mut",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['dafny'])}->
        "var",ws,Name,ws,":",ws,Type,ws,":=",ws,Value;
    {memberchk(Lang,['z3'])}->
        "(",ws,"declare-const",ws_,Name,ws_,Type,ws,")",ws,"(",ws,"assert",ws_,"(",ws,"=",ws_,Name,ws_,Value,ws,")",ws,")";
    {memberchk(Lang,['f#'])}->
        "let",ws_,"mutable",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['common lisp'])}->
        "(",ws,"setf",ws_,Name,ws_,Value,ws,")";
    {memberchk(Lang,['minizinc'])}->
        Type,ws,":",ws,Name,ws,"=",ws,Value,ws,";";
    {memberchk(Lang,['python','ruby','haskell','erlang','prolog','julia','picat','octave','wolfram'])}->
        Name,ws,"=",ws,Value;
    {memberchk(Lang,['javascript','hack','swift'])}->
        "var",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['lua'])}->
        "local",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['janus'])}->
        "local",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['perl'])}->
        "my",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['perl 6'])}->
        "my",ws_,Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['c','java','c#','c++','d','dart','englishscript','ceylon','vala'])}->
        Type,ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['rebol'])}->
        Name,ws,":",ws,Value;
    {memberchk(Lang,['visual basic','visual basic .net','openoffice basic'])}->
        "Dim",ws_,Name,ws_,"As",ws_,Type,ws,"=",ws,Value;
    {memberchk(Lang,['r'])}->
        Name,ws,"<-",ws,Value;
    {memberchk(Lang,['fortran'])}->
        Type,ws,"::",ws,Name,ws,"=",ws,Value;
    {memberchk(Lang,['chapel','haxe','scala','typescript'])}->
        "var",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['monkey x'])}->
        "Local",ws_,Name,ws,":",ws,Type,ws,"=",ws,Value;
    {memberchk(Lang,['vbscript'])}->
        "Dim",ws_,Name,ws_,"Set",ws_,Name,ws,"=",ws,Value;
    {memberchk(Lang,['seed7'])}->
        "var",ws_,Type,ws,":",ws,Name,ws_,"is",ws_,Value;
    {not_defined_for(Data,'initialize_static_var_with_value')}).
