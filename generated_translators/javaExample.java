public class javaExample{
	//Does this comment work?

	public static boolean predicateExample(int a, int b){
		if(a > b){
			return a;
		}
		else if(a < b){
			return b;
		}
		else{
			return a + b;
		}
	}
	public static boolean arrayExample(int[] a, int[] b){
		return (a[0] + b[0]) == 1;
	}
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
