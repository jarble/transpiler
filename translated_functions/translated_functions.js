var pampy = require('pampy');
const randexp = require('randexp');
//var Algebrite = require('algebrite');
//var logicjs = require('logicjs');
//var mathjs = require('mathjs');
//var lp_solver = require('javascript-lp-solver');
//var lzma = require('lzma');


class C_math{
	static sin(a){
		return Math.sin(a);
	}
	static cos(a){
		return Math.cos(a);
	}
	static tan(a){
		return Math.tan(a);
	}
	static floor(a){
		return Math.floor(a);
	}
	static ceil(a){
		return Math.ceil(a);
	}
	static log(a){
		return Math.log(a);
	}
	static sqrt(a){
		return Math.sqrt(a);
	}
	static exp(a){
		return Math.exp(a);
	}
}

class Prolog {
  static nonvar(variable) {
    return (typeof variable !== 'undefined');
  }
  static length(the_list,the_length){
	return list.length === the_length;
  }
  //unfortunately, functions in JavaScript can't be named "var"
}

class Php{
  static isNumeric(n) {
    //from https://stackoverflow.com/questions/18082/validate-decimal-numbers-in-javascript-isnumeric
    return !isNaN(parseFloat(n)) && isFinite(n);
  }
  static in_array(needle,haystack){
	return haystack.includes(needle);  
  }
  static array_merge(arr1,arr2){
	return arr1.concat(arr2);  
  }
  static array_map(fun,iter){
	return Python.map(fun,iter);
  }
  static JSON_decode(a){
	return JSON.parse(a);  
  }
  static JSON_encode(a){
	return JSON.stringify(a);  
  }
  //unfortunately, functions in JavaScript can't be named "var"
}

class Python {
  constructor(self){
	this.self = self;
  }
  any(variable){
	return this.self.includes(variable);  
  }
  static print(a){
	console.log(a);  
  }
  append(variable){
	this.self.push(variable);  
  }
  static map(fun,iter){
	return iter.map(fun);
  }
  static type(a){
	if(Array.isArray(a)){
		return "list"
	}
	else if(typeof(a) === "boolean"){
		return "bool";
	}
	else if(typeof(a) === "string"){
		return "str";
	}
  }
  static is_instance(a,b){
	return A instanceof B;
  }
  split(separator){
	return this.self.split(separator);  
  }
  upper(){
	return this.self.toUpperCase();
  }
  lower(){
	return this.self.toLowerCase();
  }
  join(the_list){
	return the_list.join(this.self);  
  }
  find(to_find){
	return this.self.indexOf(to_find);  
  }
  pop(variable){
	//what should it return?
	this.self.pop(variable);  
  }
  reverse(variable){
	 //what should it return?
	this.self.reverse(variable);  
  }
  //unfortunately, functions in JavaScript can't be named "var"
}

class JavaScript{}

JavaScript.json = class {
	static loads(a){
		return JSON.stringify(a);	
	}
}

class Java{

}
Java.Math = class {
		static min(a,b){
			return Math.min(a,b);
		}
		static max(a,b){
			return Math.max(a,b);
		}
	};

class C_Sharp{

}
C_Sharp.Math = class {
		static min(a,b){
			return Math.min(a,b);
		}
		static max(a,b){
			return Math.max(a,b);
		}
	}

class Lua{

}
Lua.math = 	class {
		static max(){
			return Math.max(arguments);
		}
		static min(){
			return Math.min(arguments);
		}
		static random(){
			return Math.random();
		}
	};

class Ruby{

}
Ruby.Math = class extends C_math{

}

Ruby.JSON = class{
		static parse(a){
			return JSON.parse(a);
		}
	}

function replaceAll(str,mapObj){
    var re = new RegExp(Object.keys(mapObj).join("|"),"gi");

    return str.replace(re, function(matched){
        return mapObj[matched.toLowerCase()];
    });
}

Python.print(replaceAll("This person is here",{"person":"GUY"}))
