#include <iostream>
using namespace std;

int x = 1;

void f1() {
  x = 2;
  cout << x << endl;
}

void f2(){
  x = x + 2;
  cout<<x<<endl;
}

int main() {
  f1();
  cout << x << endl;
  f2();
  return 0;
}