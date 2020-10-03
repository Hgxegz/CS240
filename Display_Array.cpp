#include <stdio.h>

extern "C" void print_array(long array[], long index);

void print_array(long array[], long index){
  for(long i = 0; i < index; i++){
    printf("%ld", array[i]);
    printf("%s", " ");
  }
}
