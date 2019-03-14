#include <iostream>
#include <string>
#include <algorithm>

int largestPalindromeProduct() {
  int product = 0;
  for(int i = 999; i >= 100; i--) {
    for(int j = 999; j >= 100; j--) {
      product = i * j;
      std::string stringified = std::to_string(product);

      std::string reversed = "";

      for(int i = stringified.length()-1; i >= 0; i--) {
       reversed[stringified.length()-1-i] = stringified[i];
      }

      std::cout << reversed <<  std::endl;
      if(stringified == reversed) {
        return product;
      }
    }
  }
    return -1;
}

int main() {
  std::cout << largestPalindromeProduct() << std::endl;
  return 0;
}


