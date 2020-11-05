#include <stdio.h>

double circle();

int main()
{
    double result_code = -999;
    printf("%s\n", "Welcome to your friendly circle circumference calculator.");
    printf("%s\n", "The main program will now call the circle function.");
    printf("%s\n", "This circle function is brought to you by Devin Heng.");
    result_code = circle();
    printf("Main recieved this number: %.10lf = 0x%lx.\n ", result_code, *(unsigned long*)&result_code);
    printf("Have a nice day. Main will now return 0 to the operating system.");
    return 0;
} //End of main

// 6 precisions for double is the default precision. We have to set our own precision
