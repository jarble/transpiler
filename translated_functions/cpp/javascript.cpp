#include <iostream>
#include <vector> 
#include <math.h> 

enum types {Number,String};

class Object {
 public:
  std::string str;
  float number;
  types type;
  Object(float f){
	number = f;
	type = Number;
  }
  Object(std::string the_str){
	str = the_str;
	type = String;  
  }
  Object type_of(Object the_obj){
	  if(the_obj.type == Number){
		return Object("number");
	  }
  }
};
