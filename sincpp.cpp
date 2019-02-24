#include <iostream>
#include <cmath>
#include <iomanip>

int main(){
  for( int i=1 ; i<=64 ; ++i ){
    double t = std::pow(2.0, static_cast<double>(i) );
    std::cout << std::setprecision(20) << std::sin(t) << "\n";
  }
}
