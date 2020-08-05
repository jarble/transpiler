#include <iostream>
#include <vector> 
#include <math.h> 



namespace C_sharp{
	namespace Convert{
		template <class T> std::string ToString(T a){
			return std::to_string(a);
		}
	}
}

namespace Python {
	template <class T> void print(T a) {
		std::cout << a << "\n"; 
	}

	template <class T> int abs(T a){
		return std::abs(a);
	}

	template <class T> int len(T a){
		return a.size();
	}

	template <class T> T __add__(T A,T B){
		return A+B;
	}

	template <class T> T __mul__(T A,T B){
		return A*B;
	}
	
	std::string type(std::string a){
		return  "str";
	}
	
}

namespace Java{
	namespace Integer{
		std::string toString(int a){
			return std::to_string(a);
		}
	}
	namespace System{
		namespace out{
			template <class T> void println(T a) {
				std::cout << a << "\n"; 
			}
		}
	}
}

namespace Ruby{
	template <class T> void puts(T A){
		std::cout << A << "\n";
	}
}

namespace PHP{
	std::string gettype(int a){
		return "integer";
	}
	std::string gettype(std::string a){
		return "string";
	}
	std::string gettype(bool a){
		return "bool";
	}
	template <typename T> void echo(T a){
		Ruby::puts(a);
	}
}

namespace Lua{
	std::string type(std::string a){
		return "string";
	}
	std::string type(bool a){
		return "boolean";
	}
	std::string type(int a){
		return "number";
	}
}

namespace JavaScript{
	
	template <typename T> class console {
			public:
			static void log(T a){
				Ruby::puts(a);
			}
		};

	template <typename T> class Math {
		public:
		static int round(T A){
			return round(A);
		}
		static int floor(T A){
			return floor(A);
		}
	};
}

namespace Prolog{
	bool integer(int a){
		return true;
	}
	template <typename T> void writeln(T a){
		Ruby::puts(a);
	}
}

int main ()
{

  Ruby::puts(PHP::gettype(1));
  Ruby::puts(PHP::gettype(2));
  Ruby::puts(3);
  JavaScript::console<std::string>::log("Length of a is:");
  std::string a = "3";
  JavaScript::console<int>::log(Python::len(a));
  //JavaScript::console<std::string>::log(C_sharp::Convert::ToString(3));
  Java::System::out::println(3);
  //JavaScript::console<int>::log(JavaScript::Math<double>::round(4.5));
  Prolog::writeln(Prolog::integer(3));
  return 0;
}
