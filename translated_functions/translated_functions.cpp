#include <iostream>
#include <vector> 
 
template <class T>
void print(T a) {
	std::cout << a << "\n"; 
}

template <class T>
int abs(T a){
	return std::abs(a);
}

template <class T>
int len(T a){
	return a.size();
}

template <class t1,class t2,class t3>t3 add(t1 A,t1 B){
    return A+B;
}

int main ()
{
  std::vector<int> myints;
  std::cout << "0. size: " << myints.size() << '\n';

  for (int i=0; i<10; i++) myints.push_back(i);
  std::cout << "1. size: " << myints.size() << '\n';

  myints.insert (myints.end(),10,100);
  print("2. size: ");
  print(len(myints));
  print(add(3,4));
  
  myints.pop_back();
  std::cout << "3. size: " << myints.size() << '\n';

  return 0;
}
