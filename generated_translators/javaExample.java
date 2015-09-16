public class javaExample{
	//Does this comment work?
	public static int doSomething (int a, int b){
		if(b > a){
			System.out.println(b);
		}
		else if(b < a){
			System.out.println(a);
		}
		else{
			System.out.println("Does this translator work?");
			return a - b;
		}
		switch(a){
			case 1:
				return func(3);
			case b:
				return func(4) + func(5);
			default:
				return 10;
		}
		return a + b;
	}
	public static String doSomething(String a, String b){
		return a + b; 
	}
}
