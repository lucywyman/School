/* CS261- Assignment 1 - Q.2*/
/* Name: Lucy Wyman and Chase Coltman
 * Date: July 3, 2014
 * Solution description:
 */
 
#include <stdio.h>
#include <stdlib.h>

int foo(int* a, int* b, int c){
    *a = *a*2;
    *b = *b/2;
    c = *a + *b;
	return c;
}

int main(){
    int x = 7, y = 8, z = 9;
    printf("\e[1;31mX=%d \e[0m\e[1;36m Y=%d \e[0m\e[1;35m Z=%d\e[0m\n", x, y, z);
    int answer = foo(&x, &y, z);
    printf("\e[1;32mAnswer is %d\e[0m\n", answer);
    printf("\e[1;31mX=%d \e[0m\e[1;36m Y=%d \e[0m\e[1;35m Z=%d\e[0m\n", x, y, z);
    //Z is not changed because we only changed the "face value" of it, not the value stored in memory, as we did with A and B
	return 0;
}
    
    
