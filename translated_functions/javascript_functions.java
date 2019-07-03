public class JavaScript{
	private Object self;
	public Python(Object self){
		this.self = self;
	}
	public String substring(int start,int end){
		return this.self.substring(start,end);
	}
	public class Math{
		public static int min(int... args){
			int to_return = 0;
			for(var i = 0; i < args.length; i++){
				if(args[i] < to_return){
					to_return = args[i];
				}
			}
			return args[i];
		}
		public static int max(int... args){
			int to_return = 0;
			for(var i = 0; i < args.length; i++){
				if(args[i] > to_return){
					to_return = args[i];
				}
			}
			return args[i];
		}
	}
}
public class Python{
	private Object self;
	public static String str(int a){
		return Integer.parseInt(a);
	}
	public static String type(Object obj){
		return obj!=null && obj.getClass().isArray()
			? "list"
		:"";
	}
	static void print(String a) {
		System.out.println(a);
	}
	public Python(Object self){
		this.self = self;
	}
	public String replace(char old_char,char new_char){
		return str.replace(old_str,new_str);
	}
	public int find(String to_find){
		return this.self.indexOf(toFind);
	}
	public class math{
		public static double Random(){
			return Math.random();
		}
		public static T sin(T a) {
			return sin(a);
		}
	}
	public static String upper(String a){
		return a.toUpperCase(a);
	}
	public String[] split(String separator){
		return this.self.split(separator);
	}
	public static String lower(String a){
		return a.toUpperCase(a);
	}
	public class re{
		public static boolean search(String regex, String str){
			return str.matches(regex);
		}
		public static String sub(String foo, String bar,String s){
			return s.replaceAll(foo,bar);
		}
	}
}
