// Use this code to make it work offline:
//     https://gist.github.com/kosamari/7c5d1e8449b2fbc97d372675f16b566e

{var var_number = 0; var to_append = []; var last_parsed = ""; var return_types = {};}

expressions = _ a:statements _ {return a;}

statements = head:statement tail:(_ statement)* {
      return tail.reduce(function(result, element) {
        return result + element[1];
      }, head);
    }

interface_statements = head:parameter ";" tail:(_ parameter _ ";")* {
      return tail.reduce(function(result, element) {
        return result + element[1] + ";";
      }, head);
    }

access_modifier= "public" / "private"

class_=
	"type" __ a:var_name _ "=" _ b:type ";" {return "#define "+a+" "+b+"\n";}
	/ ("interface" / "class") __ a2:var_name _ "{" _ a4:interface_statements _ "}" {return ["struct ",a2,"{",a4,"};"].join("");}

statement =
	a1:statement_ {return a1;}
	/ a1:statement_with_semicolon _ ";" {const to_be_appended = to_append.map(function(x){
		let function_name = x.substr(0, x.indexOf('('));
		let var_name = "temp_" + (to_append.indexOf(x)+var_number)
		return return_types[function_name] +" "+ var_name + ";" + x.substring(0,x.length-1)+","+var_name+");"
	}).join(""); var_number += to_append.length; to_append = []; return to_be_appended + a1+";";}

statement_
    =
    ("const" / "let" / "var") __ name:var_name _ "=" _ val:e ";" {return "#define "+name+" ("+val+")\n";}
    / class_
    / "while" _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["while(",a3,"){",a5,"}"].join("");}
    / "do" _ a2:bracket_statements _ "while" _ "(" _ a5:e _ ")" _ ";" {return ["do ",a2," while(",a5,");"].join("");}
    / "switch" _ "(" _ a3:e _ ")" _ "{" _ a6:case_statements _ "}" {return ["switch(",a3,"){",a6,"}"].join("");}
    / "for" _ "(" _ a3:statement_with_semicolon _ ";" _ a5:e _ ";" _ a7:statement_with_semicolon _ ")" _ a9:bracket_statements {return ["for(",a3,";",a5,";",a7,"){",a9,"}"].join("");}
    / "foreach" _ "(" _ a3:var_name __ "as" __ a5:var_name _ "=>" _ a7:var_name _ ")" _ a9:bracket_statements {return ["foreach_with_index","Object",a5,a7,a3,a9];}
    / "foreach" _ "(" _ a3:var_name __ "as" __ a5:var_name _ ")" _ a7:bracket_statements {return ["for(",a3," in ",a5,"){",a7,"}"].join("");}
    / "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements _ a6:elif {return ["if(",a3,"){",a5,"}",a6].join("");}
	/ "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["if(",a3,"){",a5,"}"].join("");}
    / "function" __ a:var_name "(" _ b:identifiers _ ")" _ "{" _ "return" __ c:e ";" _ "}" {return "#define "+a+"("+b+") ("+c+")\n"}
    
    // #define add(param_a,param_b,returned) {int a = param_a; int b = param_b; returned = a+b;}
    
    / "function" __ name:var_name _ "(" _ params:function_parameters _ ")" _ ":" _ type1:type _ "{" _ body:statements _ "}" {return_types[name] = type1; return "#define "+name+"("+params[0]+",returned) {"+params[1]+body+"}\n";}
    / "function" __ name:var_name _ "<" _ type_parameters:identifiers _ ">" _ "(" _ params:parameters _ ")" _ ":" _ type1:type _ "{" _ body:statements _ "}" {return ["#define generic_",name,"("+type_parameters+") ",type1," ",name,"(",params,"){",body,"}\n"].join("");}

identifiers = head:var_name tail:(_ (',') _ var_name)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

case_statement= "case" __ a2:e _ ":" _ a4:statements _ "break" _ ";" {return ["case ",a2,":",a4].join("")}

case_statements_ = head:case_statement tail:(_ case_statement)* {
      return tail.reduce(function(result, element) {
        return result + element[1];
      }, head);
    }

case_statements= a1:case_statements_ a2:(_ default_statement / "") {return a1+a2};

default_statement = "default" _ ":" _ a4:statements {return ["default:",a4].join("")}

statement_with_semicolon
   = 
   "return" __ a2:e  {return ["returned = ",a2].join("");}
   / "return"  {return "return";}
   / ("let" / "var") __ name:var_name _ ":" type1:type_  _ "=" _ val:e {return type1+" "+name+"="+val;}
   / "const" _ name:var_name _ ":" type1:type_  _ "=" _ val:e {return "const "+type1+" "+name+"="+val;}
   / ("let" / "var") __ name:var_name _ ":" type1:type_ "[" "]"  _ "=" _ "[" val:exprs "]" {return type1+"[] "+name+"="+type1+"[]("+val+")";}
   / "const" __ name:var_name _ ":" type1:type_ "[" "]"  _ "=" _ "[" val:exprs "]" {return "const "+type1+"[] "+name+"="+type1+"[]("+val+")";}
   / a1:var_name _ a2:"=" _ a3:e {return [a1,a2,a3].join("");}
   / a1:var_name _ a2:("++" / "--") {return [a1,a2].join("");}
   / a1:var_name _ a2:("+=" / "%=" / "-=" / "*=" / "/=") _ a3:e {return [a1,a2,a3].join("");}
   / var_name


type = type_ / t1:type_ "[" "]" {return type+"[]";} / "Array" "<" t1:type_ ">" {return type+"[]";}
type_ = "number" {return "float";} / "boolean" {return "bool";}

e
    =
     a1:e6 _ "?" _ a3:e6 _ ":" _ a5:e {return a1+"?"+a3+":"+a5;}
    /e6


e6
  = head:e5 tail:(_ ("||") _ e5)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

e5
  = head:e4 tail:(_ ("&&") _ e4)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

e4_op= '!==' {return "!=";} / "===" {return "==";}

e4
  = head:e3 tail:(_ ('<='/'<'/'>='/'>'/e4_op) _ e3)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

e3
  = head:e2 tail:(_ ('>>'/'<<') _ e2)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

e2
  = head:e1 tail:(_ ('+'/'-') _ e1)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }
    
e1= head:not_expr tail:(_ ('*' / '/' / '%') _ not_expr)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }
    / '-' _ a2:e1
        {return ["-",a2].join("");}

function_call
  = head:callable tail:(_ function_call_ / "") {
      let to_return = head;
      if(tail !== ""){
      to_return += tail[1];
      if(to_append.indexOf(to_return) === -1){
		//to_append.push(var_number);
		to_append.push(to_return);
		//var_number += 1.;
		
      }
      return "temp_"+(to_append.indexOf(to_return)+var_number);
      }
	  return to_return;
      
    }

function_call_ = "(" _ a2:exprs _ ")" {return "("+a2+")";}

not_expr= a1:"!" _ a2:function_call {return "!"+a2;} / function_call

callable=
	"(" _ a2:e _ ")" {return "("+a2+")";}
	/ "new" __ a:var_name _ "(" _ b:exprs _ ")" {return a+"("+b+")"}
    / "[" _ "]" {return "[]";} / "[" a2:exprs "]" {return "["+a2+"]";}
	/ var_name
    / STRING_LITERAL
    / NUMBER

parameter= a1:var_name ":" t1:type {return t1 + " " + a1;}

parameters = head:parameter tail:(_ (',') _ parameter)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "" {return "";}

function_parameter = a1:var_name ":" t1:type {return ["param_"+a1,t1 + " " + a1+"=param_"+a1+";"];}

function_parameters = head:function_parameter tail:(_ (',') _ function_parameter)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "" {return "";}

exprs = head:e tail:(_ (',') _ e)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    }

else_if= "else" __ "if" / "elseif";
elif = head:elif_ tail:(_ elif_)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "else" a2:bracket_statements {return ["else {",a2,"}"].join("");}

elif_ = a1:else_if _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["else if(",a3,"){",a5,"}"].join("")}

var_name= IDENTIFIER

bracket_statements= "{" _ a2:statements _ "}" {return a2;} / a1:statement_with_semicolon _ ";" {return a1+";";}

IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]* {return text();}
STRING_LITERAL = '"' @$([^"\\] / "\\" .)* '"'

NUMBER = a:Integer b:NUMBER_ {return a+"."+b;}
NUMBER_ = "." a:Integer {return a;} / "" {return "";}

Integer "integer"
  = _ [0-9]+ { return text(); }

_
  = [ \t\n\r]*
  
__
  = [ \t\n\r] [ \t\n\r]*
