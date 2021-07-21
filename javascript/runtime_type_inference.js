function array_type(a){
	if(Array.isArray(a)){
  	return array_type(a[0]);
  }
  else{
  	return GLSL_type(a);
  }
}

function array_dimensions(a){
  if(Array.isArray(a)){
    	return "["+a.length+"]"+array_dimensions(a[0]);
    }
    else{
    	return "";
    }
}
function GLSL_type(a){
	let the_type = typeof a;
  if(the_type == "number"){
  	return "float";
  }
  else if(the_type == "boolean"){
  	return "bool";
  }
  else if(Array.isArray(a)){
  	return array_type(a)+array_dimensions(a);
  }
}

//from https://stackoverflow.com/questions/1249531/how-to-get-a-javascript-objects-class
var STRIP_COMMENTS = /((\/\/.*$)|(\/\*[\s\S]*?\*\/))/mg;
var ARGUMENT_NAMES = /([^\s,]+)/g;
function getParamNames(func) {
  var fnStr = func.toString().replace(STRIP_COMMENTS, '');
  var result = fnStr.slice(fnStr.indexOf('(')+1, fnStr.indexOf(')')).match(ARGUMENT_NAMES);
  if(result === null)
     result = [];
  return result;
}

var annotated_functions = [];
function infer_types(func,args){
	//to do: generate a type signature from this input
	let input_types = args.map(x => GLSL_type(x));
	let function_source = func.toString();
	let parameter_names = getParamNames(func);
	let type_signature = "";
	for(let i = 0; i < parameter_names.length; i++){
		type_signature += parameter_names[i]+":"+input_types[i];
		if(i < parameter_names.length -1) type_signature += ","
	}
	//return type_signature;
	let result = func.apply(this, args);
	var annotated = function_source.replace(/\(.*\)/, "("+type_signature+")"+":"+GLSL_type(result));
	annotated_functions.push(annotated);
	return result;
}

function decorator_return_types(func){
	//return a function that infers the types and then returns the result
	return function(){
		return infer_types(func,Array.prototype.slice.call(arguments));
	}
}
//to do: define a function that decorates all functions in the current scope.
	//to get all functions of an object: https://stackoverflow.com/questions/7548291/get-all-functions-of-an-object-in-javascript

class Example{
static sine1(x){
	return Example.sine(x);
}
static sine(x){
	return Math.sin(x);
}
}
function decorate_all(class_name){
	let all_methods = Object.getOwnPropertyNames(class_name).filter(function (p) {
    return typeof class_name[p] === 'function';
});
  for(let x of all_methods){
  console.log(x);
  	class_name[x] = decorator_return_types(class_name[x]);
  }
}
decorate_all(Example);


//Example.sine = decorator_return_types(Example.sine);
//infer_types(sine,[3]);
Example.sine1(3);
console.log(annotated_functions.join("\n"));

//alert(GLSL_type([[1,2,3]]));
//alert(GLSL_type([true,false,false]));
