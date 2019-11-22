
#include <stdio.h>
int f() {
  int x = 5;
  printf("function block variable x=%d\n", x);
  
  if (1) {
     int x = 7;
     printf("if block variable x=%d\n", x);
	 }
  printf("function block variable x=%d\n", x);  
}
int main() {
 f();
 return 0;
}
