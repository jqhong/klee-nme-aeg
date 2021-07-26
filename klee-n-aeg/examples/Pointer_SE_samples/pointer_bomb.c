#include <stdio.h>
#include <stdlib.h>
#include <assert.h>

void bomb(char* a, char* b, char i, char j, char x) {
  char f;
  a[i] = x;
  if(b[j] == x)
    f = 1;
  else
    f = 0;
  assert(!f); // fail when f==1
}

int main(int argc, char *argv[]) {
/*    char a[40] = {
      0,1,2,3,4,5,6,7,8,9,
      10,11,12,13,14,15,16,17,18,19,
      20,21,22,23,24,25,26,27,28,29,
      30,31,32,33,34,35,36,37,38,39,
    };
*/
    char *a = malloc(sizeof(char)*30);
    char *b = a+10;
    // a = &a;
    char i=0, j=-10, x=23;
    bomb(a, b, i, j, x);
}
