// Use this code to make it work offline:
//     https://gist.github.com/kosamari/7c5d1e8449b2fbc97d372675f16b566e

{var var_number = 0; var type_in_arr = undefined; var anonymous_structs = []; var class_names = []; var class_methods = ""; var extended_methods = {}; var class_fields = ""; var extended_fields = {}; var to_append = []; var temp_vars  = []; var redundant_vars = {}; var declared_redundant_vars = {}; var last_parsed = ""; var current_return_type = undefined; var return_types = {}; var expression_types = {}; var type_parameters = {}; var functions_to_append = []; var function_number = 0;
expression_types["true"] = "bool";
expression_types["false"] = "bool";
let break_if_returned = "if(is_returned == 1) break;"

function replaceAll(str1,str2,str){
    if(str1.indexOf("<") === -1) return str2;
    let sub1 = str1.substring(str1.indexOf("<")+1,str1.indexOf(">"));
    //alert(JSON.stringify([list1,list3]));
    let list1 = sub1.split(",");
    let list3 = str.split(",");
    var mapObj = {};
    for(let i = 0; i < list1.length; i++){
        mapObj[list1[i]] = list3[i];
    }
    var re = new RegExp("\\b(?:"+Object.keys(mapObj).join("|")+")\\b","g");

    return str2.replace(re, function(matched){
        return mapObj[matched];
    });
}
function unify_expression_types(a,b){
if(expression_types[a] == undefined) expression_types[a] = expression_types[b];
if(expression_types[b] == undefined) expression_types[b] = expression_types[a];
}
//alert(replaceAll("add<A>","A","float"));

}

expressions = _ a:statements _ {
	let anonymous_functions = functions_to_append.map(function(x){
		return "\n#define "+"func_" + (functions_to_append.indexOf(x)+function_number)+x;
	}).join("");
	let structs_to_append = anonymous_structs.map(function(x){
		return "struct "+"struct_" + anonymous_structs.indexOf(x)+x+";";
	}).join("");
	let macros_to_append = `#define function_body(a) \{for(int is_returned = 0; is_returned < 1; is_returned++)\{a\}\}
#define for_loop(a,b) for a b if(is_returned == 1) break;
#define while_loop(a,b) for a b if(is_returned == 1) break;
#define return_statement(returned,a) returned = a;is_returned = 1;break
#define foreach(type,item,array,body) for(int count = 0; count < array.length(); count++)\{type item = array[count];body\} if(is_returned == 1) break;
#define map(function,input1,output1) for(int i = 0; i < input1.length(); i++){output1[i] = function(input1[i]);}
`;
	function_number += functions_to_append.length; to_append = []; functions_to_append = [];
	return macros_to_append+structs_to_append + anonymous_functions + a;
}

statements = head:statement tail:(_ statement)* {
      return tail.reduce(function(result, element) {
        return result + element[1];
      }, head);
    }

interface_statements = head:method_parameter ";" tail:(_ method_parameter _ ";")* {
      return tail.reduce(function(result, element) {
        return result + element[1] + ";";
      }, head);
    }
    
class_statements = head:class_statement tail:( _ class_statement)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + ";";
      }, head);
    }

instance_method = ("static" / "") _ name:var_name _ "(" _ params:method_parameters _ ")" _ ":" _ type1:type _ "{" _ body:statements _ "}" {
	return_types[name] = type1;
	class_methods += "void " + name+"(class_name self,"+(params===""?"":(params+","))+"inout "+type1+" returned) {"+body+"}\n";
	return "";
}

constructor = "constructor" _ "(" _ params:method_parameters _ ")" _ "{" _ body:statements _ "}" {
	class_methods += "void " + "new("+(params===""?"":(params+","))+"inout class_name self) {"+body+"}\n";
	return "";
}

class_statement = constructor / instance_method / a:method_parameter _ ";" {class_fields += a+";"; return ";"}

access_modifier= "public" / "private"

class_=
	"type" __ a:var_name _ "=" _ b:type ";" {return "\n#define "+a+" "+b+"\n";}
	/ "interface" __ a2:var_name _ "{" _ a4:interface_statements _ "}" {return ["struct ",a2,"{",a4,"};"].join("");}
	/ "class" __ name:var_name super_class:( _ ":" _ var_name / "") _ "{" _ a4:class_statements _ "}" {
		class_names.push(name);
		let superclass_methods = "";
		let superclass_fields = "";
		return_types[name] = name;
		if(super_class.length !== 0){
			superclass_fields = extended_fields[super_class[3]];
			superclass_methods = extended_methods[super_class[3]];
		}
		
		let to_return = ["\n#define class_name "+name+"\nstruct class_name{",superclass_fields,class_fields,"};",superclass_methods,class_methods,"\n#undef class_name\n"].join("");


		extended_methods[name] = class_methods;
		extended_fields[name] = class_fields;
		class_methods = "";
		class_fields = "";
		return to_return;
	}

statement =
	a1:statement_ {return a1;}
	/ a1:statement_with_semicolon _ (";" / "") {
	let to_be_appended = a1+((a1==="")?"":";");
	for(let i1 = to_append.length-1; i1 > -1; i1--){
		let x = to_append[i1];
		let function_name = x.substr(0, x.indexOf('('));
		let var_name = "temp_" + (to_append.indexOf(x)+var_number)
		
		for(let name of class_names){
			//if function name is class name, replace function call with constructor call
			if(x.startsWith(name)){
				x = x.replace(name+"(","new(");
			}
		}
		
		let subs = x.substring(0,x.length-1)
		//alert(function_name+":"+return_types[function_name]);
		//alert(JSON.stringify(type_parameters));
        //alert(JSON.stringify(return_types));
        let var_declaration = "";
        
        if(Object.keys(redundant_vars).indexOf(var_name) !== -1){
			var_name = redundant_vars[var_name];
        }
        
        if(Object.keys(declared_redundant_vars).indexOf(var_name) !== -1){
			var_name = declared_redundant_vars[var_name];
        }
        else{
			var_declaration = return_types[function_name] +" "+ var_name + ";";
        }
        //alert(var_name+":"+to_be_appended);
        //alert(to_be_appended+","+var_name+","+to_be_appended.includes(var_name));
        //alert();
        if(((new RegExp("\\b"+var_name+"\\b")).test(to_be_appended)) || to_be_appended === ""){
			
			//to do: search the string for a match of a regex instead of a substring 
			to_be_appended = var_declaration + subs+(subs.endsWith("(")?"":",")+var_name+");"+to_be_appended;
		
		}
	}
	
	
	var_number += to_append.length; to_append = []; return to_be_appended;}

statement_
    =
    class_
    / "while" _ "(" _ a3:e _ ")" _ a5:bracket_statements {return ["while(",a3,"){",a5,"}",break_if_returned].join("");}
    / "do" _ a2:bracket_statements _ "while" _ "(" _ a5:e _ ")" _ ";" {return ["do ",a2," while(",a5,");",break_if_returned].join("");}
    / "switch" _ "(" _ a3:e _ ")" _ "{" _ a6:case_statements _ "}" {return ["switch(",a3,"){",a6,"}",break_if_returned].join("");}
    / "for" _ "(" _ a3:statement_with_semicolon _ ";" _ a5:e _ ";" _ a7:statement_with_semicolon _ ")" _ a9:bracket_statements {return ["for(",a3,";",a5,";",a7,"){",a9,"}",break_if_returned].join("");}
    / "for" _ "(" _ ("let" / "var") _ item:var_name __ "of" __ the_arr:var_name _ ")" _ body:bracket_statements {
		if(expression_types[item] !== undefined){
			expression_types[the_arr] = expression_types[item]+"[]";
		}
		else if(expression_types[the_arr] !== undefined){
			expression_types[item] = expression_types[the_arr].substring(0,expression_types[the_arr].length-2);
		}
		return "foreach("+expression_types[the_arr].substring(0,expression_types[the_arr].length-2)+","+item+","+the_arr+",{"+body+"})";
	}
    / "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements _ a6:elif {expression_types[a3] = "bool"; return ["if(",a3,"){",a5,"}",a6].join("");}
	/ "if" _ "(" _ a3:e _ ")" _ a5:bracket_statements {expression_types[a3] = "bool"; return ["if(",a3,"){",a5,"}"].join("");}
    / "function" __ name:var_name _ "(" _ b:identifiers _ ")" _ "{" _ c:statements _ "}" {
		if(current_return_type === undefined){current_return_type = "void"}; return_types[name] = current_return_type; current_return_type = undefined; return "\n#define "+name+"("+(b===""?"":(b+","))+"returned) function_body({"+c+"})\n"
	}
    
    // #define add(param_a,param_b,returned) {int a = param_a; int b = param_b; returned = a+b;}
    
    / "function" __ name:var_name _ type_params:("<" _ identifiers _ ">" _ / "") "(" _ params:function_parameters _ ")" _ type1:(":" _ type _ / "") "{" _ body:statements _ "}" {
		if(type1.length > 0) return_types[name] = type1[2]; else return_types[name] = current_return_type; current_return_type = undefined; if(params[1] === undefined){params[1] = "";}
		if(type_params.length > 0){type_parameters[name+"<"+type_params[2]+">"] = return_types[name]; return "\n#define "+name+"("+type_params[2]+","+(params===""?"":(params[0]+","))+"returned) function_body({"+params[1]+body+"})\n";}
		else return "\n#define "+name+"("+(params===""?"":(params[0]+","))+"returned) function_body({"+params[1]+body+"})\n";
	}
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
   "return" __ a2:e  {
		current_return_type = expression_types[a2];
		if(temp_vars.indexOf(a2) !== -1){declared_redundant_vars[a2] = "returned"; return "";}
		else{
		return "returned = "+a2+";is_returned = 1;break";
		}
		}
		
   / "return"  {return "return";}
   / ("const" / "let" / "var") __ name:var_name _ "=" _ val:e {
		unify_expression_types(name,val);
		let type1 = expression_types[val];
		if(temp_vars.indexOf(val) !== -1){redundant_vars[val] = name; return "";}
		else{
		return type1+" "+name+" = "+val;
		}
	}
   / ("let" / "const" / "var") __ name:var_name _ ":" type1:type_  _ "=" _ val:e {
		expression_types[name] = type1;
		expression_types[val] = type1;
		if(temp_vars.indexOf(val) !== -1){redundant_vars[val] = name; return "";}
		else{
		return type1+" "+name+" = "+val;
		}
	}
   / ("let" / "const" / "var") __ name:var_name _ ":" type1:type_ {
		expression_types[name] = type1;
		return type1+" "+name;
	}
   / ("let" / "const" / "var") __ name:var_name _ ":" type1:type_ "[" "]"  _ "=" _ "[" val:exprs "]" {
		type1 = type1 + "[]";
		expression_types[name] = type1;
		val = type1+"("+val+")";
		expression_types[val] = type1;
		if(temp_vars.indexOf(val) !== -1){redundant_vars[val] = name; return "";}
		else{
		return type1+" "+name+" = "+val;
		}
	}
   / "const" __ name:var_name _ ":" type1:type_ "[" "]"  _ "=" _ "[" val:exprs "]" {expression_types[name] = type1+"[]"; return "const "+type1+"[] "+name+"="+type1+"[]("+val+")";}
   / name:assignable _ a2:"=" _ val:e {
   		if(temp_vars.indexOf(val) !== -1){declared_redundant_vars[val] = name; return "";}
		else{
			return name+a2+val;
		}
   }
   / a1:assignable _ a2:("++" / "--") {expression_types[a1] = "float"; return a1+a2;}
   / a1:assignable _ a2:("+=" / "%=" / "-=" / "*=" / "/=") _ a3:e {expression_types[a1] = "float"; expression_types[a3] = "float"; return a1+a2+a3;}
   / var_name


type =  t1:type_ "[" "]" {return t1+"[]";} / "Array" "<" t1:type_ ">" {return type+"[]";} / type_
type_ = name:IDENTIFIER {return (name === "number"?"float":name==="boolean"?"bool":name==="void"?"void":"compiled_"+name)}
types = head:type tail:(_ (',') _ type)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "" {return "";}

e
    =
     a1:e6 _ "?" _ a3:e6 _ ":" _ a5:e {expression_types[a3] = "bool"; return a1+"?"+a3+":"+a5;}
    /e6


e6
  = head:e5 tail:(_ ("||") _ e5)* {
      let to_return = tail.reduce(function(result, element) {
        let to_return = result + element[1] + element[3]; expression_types[to_return] = "bool"; expression_types[result] = "bool"; expression_types[element[3]] = "bool"; return to_return;
      }, head);
      return to_return;
    }

e5
  = head:e4 tail:(_ ("&&") _ e4)* {
      let to_return = tail.reduce(function(result, element) {
        let to_return = result + element[1] + element[3]; expression_types[to_return] = "bool"; expression_types[result] = "bool"; expression_types[element[3]] = "bool"; return to_return;
      }, head);
      return to_return;
    }

e4_op= '!==' {return "!=";} / "===" {return "==";}

e4
  = head:e3 tail:(_ ('<='/'<'/'>='/'>'/e4_op) _ e3)* {
      return tail.reduce(function(result, element) {
        let to_return = result + element[1] + element[3]; expression_types[to_return] = "bool"; if([1] === "==" || element[1] === "==="){unify_expression_types(result,element[3]);} else{expression_types[result] = "float";} expression_types[element[3]] = "float"; return to_return;
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
        let to_return = result + element[1] + element[3];
        expression_types[to_return] = "float";
        expression_types[result] = "float";
        expression_types[element[3]] = "float";
        return to_return;
      }, head);
    }
    
e1= head:not_expr tail:(_ ('*' / '/' / '%') _ not_expr)* {
      return tail.reduce(function(result, element) {
        let to_return = result + element[1] + element[3];
        expression_types[to_return] = "float";
        expression_types[result] = "float";
        expression_types[element[3]] = "float";
        return to_return;
      }, head);
    }
    / '-' _ a2:e1
        {return "-"+a2;}

assignable = head:dot_expr tail:(_ access_array_)* {
      return tail.reduce(function(result, element) {
        let to_return = result + element[1];
        if((expression_types[result] !== undefined) && expression_types[result].endsWith("[]")){
			expression_types[to_return] = expression_types[result].substring(0,expression_types[result].length-2);
		}
        return to_return;
      }, head);
    }

access_array = head:function_call tail:(_ access_array_)* {
      return tail.reduce(function(result, element) {
        let to_return = result + element[1];
        if((expression_types[result] !== undefined) && expression_types[result].endsWith("[]")){
			expression_types[to_return] = expression_types[result].substring(0,expression_types[result].length-2);
		}
        return to_return;
      }, head);
    }

access_array_ = "[" _ a:e _ "]" {expression_types[a] = "float"; return "[int("+a+")]";}

function_call
  = head:callable type_params:("<" types ">" / "") tail:(_ function_call_ / "") {
	  var split_head = head.split(".");
      if(split_head.length === 2 && split_head[0] === "compiled_Math" && (["sin","cos","tan","sinh","cosh","tanh","abs","floor","ceil","exp","pow","log","log2","sqrt","trunc","sign"].indexOf(split_head[1]) !== -1)){
	      let to_return = split_head[1] + tail[1];
	      expression_types[to_return] = "float";
	      return to_return;
      }
      else if(head === "compiled_Number"){
		  let to_return = "float" + tail[1];
	      expression_types[to_return] = "float";
	      return to_return;
      }
      else if(head === "compiled_Boolean"){
		  let to_return = "float" + tail[1];
	      expression_types[to_return] = "bool";
	      return to_return;
      }
      else{
      let to_return = head+(type_params === ""?"":"<"+type_params[1]+">");
      if(type_params !== ""){
		//get return type

		for(let key of Object.keys(type_parameters)){
		
			if(key.startsWith(head+"<")){
				//alert(key);
				//alert(key.substring(head.length+1,key.length-1));
				//alert(return_types[key]);
				//alert(type_params[1]);
				//alert(replaceAll(return_types[key],type_params[1],key.substring(head.length+1,key.length-1)));
				//alert(replaceAll(key,return_types[key],toString(type_params[1])));
				
				//alert("replaced: "+replaceAll(key,type_parameters[key],type_params[1]));
				//alert(JSON.stringify([key,type_parameters[key],type_params[1]]));
				return_types[to_return] = replaceAll(key,type_parameters[key],type_params[1]);
				//alert(to_return+tail[1]);
				//alert(replaceAll("fun<dog,doggy>","doggy[],dog[]","a,b"))
			}
		}
      }
      
      if(tail !== ""){
      to_return += tail[1];
      if(to_append.indexOf(to_return) === -1){
		to_append.push(to_return);
      }
      to_return = "temp_"+(to_append.indexOf(to_return)+var_number);
      temp_vars.push(to_return);
      expression_types[to_return] = return_types[head];
      return to_return;
      }
      
	  return to_return;
	  }
    }

function_call_ = "(" _ a2:exprs _ ")" {return "("+a2+")";}

not_expr= a1:"!" _ a2:access_array {let to_return = "!"+a2; expression_types[a2] = "bool"; expression_types[to_return] = "bool"; return to_return;} / access_array

object_member = a1:var_name _ ":" _ t1:e {return [expression_types[t1]+" "+a1+";",t1];}

object_members = head:object_member tail:(_ (',') _ object_member)* {
      return tail.reduce(function(result, element) {
        return [result[0]+element[3][0], result[1]+","+element[3][1]];
      }, head);
    } / "" {return "";}

callable=
	"(" _ a2:e _ ")" {let to_return  ="("+a2+")"; expression_types[to_return] = expression_types[a2]; return to_return;}
	/ "new" __ a:function_call {return a;}
    / "[" a2:array_exprs "]" {let to_return = type_in_arr + "[]" + "("+a2+")"; expression_types[to_return] = type_in_arr + "[]"; return to_return;}
	/ "{" _ a:object_members _ "}" {
	
	  //avoid duplicate structs
	  //this works in C, but not in GLSL
	  
	  //a[0] = a[0].split(";");
	  //a[0].sort();
	  //a[0] = a[0].join(";");
	  //a[0].substring(1,a[0].length)
	  let declare_struct = "{"+a[0]+"}";
	  
      if(anonymous_structs.indexOf(declare_struct) === -1){
		anonymous_structs.push(declare_struct);
      }
      let var_name = "struct_"+(anonymous_structs.indexOf(declare_struct));

      //expression_types[to_return] = return_types[head];
      var to_return = var_name+"("+a[1]+")";
      expression_types[to_return] = var_name;
      return to_return;
	
	
	}
	/ "function" _ "(" _ params:function_parameters _ ")" _ ":" _ type1:type _ "{" _ body:statements _ "}" {
		//anonymous function
		let to_return = "("+(params===""?"":(params[0]+","))+"returned) {"+params[1]+body+"}\n";
	    //alert(body);
	    if(functions_to_append.indexOf(to_return) === -1){
		  functions_to_append.push(to_return);
        }
        to_return = "func_"+(functions_to_append.indexOf(to_return)+function_number);
        return_types[to_return] = type1;
        return to_return;
	}
	/ "function" _ "(" _ params:identifiers _ ")" _ "{" _ body:statements _ "}" {
		let to_return = "("+(params===""?"":(params+","))+"returned) {"+body+"}\n";
	    if(functions_to_append.indexOf(to_return) === -1){
		  functions_to_append.push(to_return);
        }
        to_return = "func_"+(functions_to_append.indexOf(to_return)+function_number);
        return_types[to_return] = current_return_type;
        return to_return;
	}
	/ "(" _ "(" _ params:identifiers _ ")" _ "=>" _ body:e _ ")" {
		let to_return = "("+(params===""?"":(params+","))+"returned) {return "+body+";}\n";
	    if(functions_to_append.indexOf(to_return) === -1){
		  functions_to_append.push(to_return);
        }
        to_return = "func_"+(functions_to_append.indexOf(to_return)+function_number);
        return_types[to_return] = expression_types[body];
        return to_return;
	}
	/ dot_expr
    / STRING_LITERAL
    / a:NUMBER {expression_types[a] = "float"; return a;}

dot_expr = head:var_name tail:(_ ('.') _ IDENTIFIER)* {
      let to_return = tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
      if(to_return === "compiled_Math.PI")
		return "radians(180)";
	  else if(to_return === "compiled_Math.SQRT2")
		return "sqrt(2.)";
	  else return to_return;
    }

method_parameter= a1:var_name ":" t1:type {return t1 + " " + a1;}

method_parameters = head:method_parameter tail:(_ (',') _ method_parameter)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "" {return "";}

function_parameter = a1:var_name _ ":" _ t1:type {expression_types[a1] = t1; return ["param_"+a1,t1 + " " + a1+"=param_"+a1+";"];}

function_parameters = head:function_parameter tail:(_ (',') _ function_parameter)* {
      return tail.reduce(function(result, element) {
        return [result[0]+","+element[3][0], result[1]+element[3][1]];
      }, head);
    } / "" {return "";}

exprs = head:e tail:(_ (',') _ e)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "";

array_exprs = head:e tail:(_ (',') _ e)* {
      return tail.reduce(function(result, element) {
        type_in_arr = expression_types[element[3]];
        return result + element[1] + element[3];
      }, head);
    } / "";

else_if= "else" __ "if" / "elseif";
elif = head:elif_ tail:(_ elif_)* {
      return tail.reduce(function(result, element) {
        return result + element[1] + element[3];
      }, head);
    } / "else" a2:bracket_statements {return "else {"+a2+"}";}

elif_ = a1:else_if _ "(" _ a3:e _ ")" _ a5:bracket_statements {return "else if("+a3+"){"+a5+"}";}

var_name= a1:IDENTIFIER {if(a1 == "this") return "self"; else if(a1 === "true" || a1 === "false") return a1; else return "compiled_"+a1;}

bracket_statements= "{" _ a2:statements _ "}" {return a2;} / a1:statement_with_semicolon _ ";" {return a1+";";}

IDENTIFIER = [a-zA-Z_][a-zA-Z0-9_]* {return text();}
STRING_LITERAL = '"' @$([^"\\] / "\\" .)* '"'

NUMBER = a:Integer b:NUMBER_ {return a+"."+b;}
NUMBER_ = "." a:Integer {return a;} / ("." / "") {return "";}

Integer "integer"
  = _ [0-9]+ { return text(); }

_
  = [ \t\n\r]*
  
__
  = [ \t\n\r] [ \t\n\r]*
