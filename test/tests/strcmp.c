#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int main() {
  char str1[20] = "hello World!";
  char str2[20] = "Hello World!";
  if (strcmp(str1, str2) > 0) {
    printf("First string is greater\n");
  } else if (strcmp(str1, str2)) {
    printf("Second string is greater\n");
  } else {
    printf("strings are same");
  }
  return EXIT_SUCCESS;
}


/* Local Variables: */
/* compile-command: "gcc -O0 -S -fno-asynchronous-unwind-tables -fno-exceptions test.c " */
/* End: */