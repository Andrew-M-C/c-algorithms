// test_main.c

#include <stdio.h>

#define PRINTLN(fmt, args...)   printf(__FILE__", Line %03d: "fmt"\n", __LINE__, ##args)

int main(int argc, char *argv[])
{
    PRINTLN("Hello c algorithms!");
    return 0;
}
