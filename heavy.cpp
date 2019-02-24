#include <iostream>
#include <iomanip>
#include <cmath>

double run(int size){
  double sum = 0;
  for( int y=0 ; y<size ; ++y ){
    for( int x=0 ; x<size ; ++x ){
      sum += std::sin(x+y+sum);
      sum += std::cos(x-y+sum);
    }
  }
  return sum;
}

int main(){
  int size;
  std::cin >> size;
  std::cout << std::setprecision(20) << run(size) << std::endl;
  return 0;
}
