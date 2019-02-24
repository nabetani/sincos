#include <iostream>
#include <cmath>
#include <iomanip>

int main(){
  double t;
  std::cin >> t;
  std::cout << std::setprecision(20)
  << std::sin(t) << ","
  << std::cos(t) << ","
  << std::tan(t) << ","
  << std::atan(t) << ","
  << std::atan2(t,t/2)
  ;
}
