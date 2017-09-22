

public static boolean infix_arithmetic_langs(String lang){
	return Arrays.asList(new String[]{"javascript","perl","python","java","lua","c","c++","perl","ruby","haxe"}).contains(lang);
}
public static char last_char(String the_string){
	return the_string.charAt((the_string.length())-1);
}
public static double index_in_array(double[] the_arr,double to_find){
	int i=0;
	while(i<the_arr.length){
		double the_index=the_arr[i];
		if(the_index+0==to_find){
			return the_arr[i];
		}
		else{
			i++;
		}
	}
	return -1;
}
public static boolean matches_pattern(String[] arr,String[] pattern){
	if(pattern.length!=arr.length){
		return false;
	}
	else{
		int i=0;
		while(i<arr.length){
			if((last_char(pattern[i])!='_')&&(!pattern[i].equals(arr[i]))){
				return false;
			}
			else{
				i++;
			}
		}
	}
	return true;
}
public static boolean string_matches_pattern(String str1,String pattern){
	return matches_pattern(str1.split(" "),pattern.split(" "));
}
boolean z=string_matches_pattern("hello stuff","hello 1_");
public static String while_loop(String lang,String a,String b){
	if(Arrays.asList(new String[]{"javascript","java","c","c++"}).contains(lang)){
		return "while("+a+"){"+b+"}";
	}
	else{
		return "undefined";
	}
}
public static String if_statement(String lang,String a,String b){
	if(Arrays.asList(new String[]{"javascript","java","c","c++"}).contains(lang)){
		return "if("+a+"){"+b+"}";
	}
	else{
		return "undefined";
	}
}
public static String elif_statement(String lang,String a,String b){
	if(Arrays.asList(new String[]{("java"+"script"),"java","c","c++"}).contains(lang)){
		return "else if("+a+"){"+b+"}";
	}
	else{
		return "undefined";
	}
}
public static String infix_operator(String lang,String operator,String a,String b){
	if(infix_arithmetic_langs(lang)){
		return a+" "+operator+" "+b;
	}
	else{
		return "("+operator+" "+a+" "+b+")";
	}
}
public static String add(String lang,String a,String b){
	return infix_operator(lang,"+",a,b);
}
public static String subtract(String lang,String a,String b){
	return infix_operator(lang,"-",a,b);
}
public static String multiply(String lang,String a,String b){
	return infix_operator(lang,"*",a,b);
}
public static String divide(String lang,String a,String b){
	return infix_operator(lang,"/",a,b);
}
public static String less_than(String lang,String a,String b){
	return infix_operator(lang,"=",a,b);
}
public static String less_than_or_equal(String lang,String a,String b){
	return infix_operator(lang,"<=",a,b);
}
public static String greater_than_or_equal(String lang,String a,String b){
	return infix_operator(lang,">=",a,b);
}
public static String greater_than(String lang,String a,String b){
	return infix_operator(lang,">",a,b);
}
public static String compare(String lang,String a,String b){
	return infix_operator(lang,"==",a,b);
}
public static String concatenate_string(String lang,String a,String b){
	if(Arrays.asList(new String[]{"lua"}).contains(lang)){
		return infix_operator(lang,"..",a,b);
	}
	else if(Arrays.asList(new String[]{"php","perl"}).contains(lang)){
		return infix_operator(lang,".",a,b);
	}
	else if(Arrays.asList(new String[]{"haskell"}).contains(lang)){
		return infix_operator(lang,"++",a,b);
	}
	else{
		return infix_operator(lang,"+",a,b);
	}
}
public static String compare_strings(String lang,String a,String b){
	if(Arrays.asList(new String[]{"php","javascript"}).contains(lang)){
		return infix_operator(lang,"===",a,b);
	}
	else if(Arrays.asList(new String[]{"prolog"}).contains(lang)){
		return infix_operator(lang,"=",a,b);
	}
	else if(Arrays.asList(new String[]{"python"}).contains(lang)){
		return infix_operator(lang,"==",a,b);
	}
	else{
		return "undefined";
	}
}
public static String indent_line(String line,double number_of_indents){
	double i=0;
	while(i<number_of_indents){
		line="    "+line;
		i++;
	}
	return line;
}