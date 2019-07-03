public class Interpreters{
	public class Python{
		public static string type(bool a){
			return "bool";
		}
		public static string type(string a){
			return "str"
		}
		public int index(String a){
			returm this.self.index(a);
		}
		public static string type(int a){
			return "int"
		}
		public class re{
			public static System.Text.RegularExpressions.Regex compile(String a){
				return new System.Text.RegularExpressions.Regex(a);
			}
			public static findall(String pattern,String text){
				return re.findall(re.compile(pattern),text);
			}
			public static findall(System.Text.RegularExpressions.Regex pattern,String text){
				return pattern.matches(text);
			}
			public static search(System.Text.RegularExpressions.Regex pattern,String text){
				return System.Text.RegularExpressions.Regex.Match(text);
			}
		}
		public class math{
			public static T sin<T>(T a){
				return Math.sin(a);
			}
			public static T cos<T>(T a){
				return Math.cos(a);
			}
			public static T tan<T>(T a){
				return Math.tan(a);
			}
			public String replace(char old_char,char new_char){
				return str.replace(old_str,new_str);
			}
			public static int min(params int args){
				int to_return = 0;
				for(var i = 0; i < args.length; i++){
					if(args[i] < to_return){
						to_return = args[i];
					}
				}
				return args[i];
			}
			public static int max(params int args){
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
	public class Java{
		public class Math{
			
		}
	}
	public class Lua{
		public static String type(int a){
			return "number";
		}
		public static String type(double a){
			return "number";
		}
	}
}
