#include <stdio.h>   // IO
#include <string.h>  // strlen()

void stringprint(char* string, int flag) {
  size_t sz = strlen(string);

  // If flag is 0 we print odd positions.
  // If flag is 1 we print even positions.
  // Makes flag as the start index.
  // If flag is 1, start index is 0.
  // If flag is 0, start index is 1.
  flag = 1 - flag;

  // Loops through all alternate characters
  // starting from the flag.
  for (size_t i = flag; i < sz; i += 2) {
    printf("%c ", string[i]);
  }

  // Formatting of output(Optional).
  printf("\n");
}

int main() {
  char string[1000];  // Input string.
  int flag;           // Input flag.

  printf("Enter a string:");
  scanf("%s", string);

  printf("Enter a flag value(0/1):");
  scanf("%1d", &flag);

  if (flag > 1) {
    printf("Invalid input\n");
    return 0;
  }

  stringprint(string, flag);

  return 0;
}
