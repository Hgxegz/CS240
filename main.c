#include <stdio.h>
#include <stdint.h>

long int manager();

int main(){
  long int result_code = -999;
  printf("%s", "Welcome\n");
  result_code = manager();
  printf("%s%ld%s\n", "Main received ", result_code, ", and is not sure what to do with it.");
  printf("%s", "Main will return 0 to the operating system. Bye.");
  return 0;
}
