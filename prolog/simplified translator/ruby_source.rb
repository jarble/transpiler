

def infix_arithmetic_langs(lang) 
	return ["javascript","perl","python","java","lua","c","c++","perl","ruby","haxe"].include?(lang)
end 
def last_char(the_string) 
	return the_string[(the_string.size)-1]
end 
def index_in_array(the_arr,to_find) 
	i=0 
	while(i<the_arr.size) do 
		the_index=the_arr[i] 
		if the_index+0==to_find then 
			return the_arr[i]
		else 
			i=i+1
		end
	end 
	return -1
end 
def matches_pattern(arr,pattern) 
	if pattern.size!=arr.size then 
		return false
	else 
		i=0 
		while(i<arr.size) do 
			if (last_char(pattern[i])!='_') and (pattern[i]!=arr[i]) then 
				return false
			else 
				i=i+1
			end
		end
	end 
	return true
end 
def string_matches_pattern(str1,pattern) 
	return matches_pattern(str1.split(" "),pattern.split(" "))
end 
z=string_matches_pattern("hello stuff","hello 1_") 
def while_loop(lang,a,b) 
	if ["javascript","java","c","c++"].include?(lang) then 
		return "while("+a+"){"+b+"}"
	else 
		return "undefined"
	end
end 
def if_statement(lang,a,b) 
	if ["javascript","java","c","c++"].include?(lang) then 
		return "if("+a+"){"+b+"}"
	else 
		return "undefined"
	end
end 
def elif_statement(lang,a,b) 
	if [("java"+"script"),"java","c","c++"].include?(lang) then 
		return "else if("+a+"){"+b+"}"
	else 
		return "undefined"
	end
end 
def infix_operator(lang,operator,a,b) 
	if infix_arithmetic_langs(lang) then 
		return a+" "+operator+" "+b
	else 
		return "("+operator+" "+a+" "+b+")"
	end
end 
def add(lang,a,b) 
	return infix_operator(lang,"+",a,b)
end 
def subtract(lang,a,b) 
	return infix_operator(lang,"-",a,b)
end 
def multiply(lang,a,b) 
	return infix_operator(lang,"*",a,b)
end 
def divide(lang,a,b) 
	return infix_operator(lang,"/",a,b)
end 
def less_than(lang,a,b) 
	return infix_operator(lang,"=",a,b)
end 
def less_than_or_equal(lang,a,b) 
	return infix_operator(lang,"<=",a,b)
end 
def greater_than_or_equal(lang,a,b) 
	return infix_operator(lang,">=",a,b)
end 
def greater_than(lang,a,b) 
	return infix_operator(lang,">",a,b)
end 
def compare(lang,a,b) 
	return infix_operator(lang,"==",a,b)
end 
def concatenate_string(lang,a,b) 
	if ["lua"].include?(lang) then 
		return infix_operator(lang,"..",a,b)
	elsif ["php","perl"].include?(lang) 
		return infix_operator(lang,".",a,b)
	elsif ["haskell"].include?(lang) 
		return infix_operator(lang,"++",a,b)
	else 
		return infix_operator(lang,"+",a,b)
	end
end 
def compare_strings(lang,a,b) 
	if ["php","javascript"].include?(lang) then 
		return infix_operator(lang,"===",a,b)
	elsif ["prolog"].include?(lang) 
		return infix_operator(lang,"=",a,b)
	elsif ["python"].include?(lang) 
		return infix_operator(lang,"==",a,b)
	else 
		return "undefined"
	end
end 
def indent_line(line,number_of_indents) 
	i=0 
	while(i<number_of_indents) do 
		line="    "+line 
		i=i+1
	end 
	return line
end