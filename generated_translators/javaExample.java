public class A extends B {
	public static int doSomething (int a, int b){
		functionCall(a,b,c);
		if(b > a){
			return Math.sin(a) + Math.cos(b) + Math.tan(a+b);
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
				break;
			case b:
				return func(4) + func(5);
				break;
			default:
				return 10;
		}
		return a + b;
	}
}
