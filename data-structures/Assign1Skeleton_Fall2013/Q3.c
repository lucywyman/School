/* CS261- Assignment 1 - Q.3*/
/* Name: Chase Coltman, Lucy Wyman
 * * Date: 7/3/2014
 * * Solution description:
 * */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

void sort(int* number, int n){
	/*Sort the given array number , of length n*/  
	int temp;
	for (int i = n - 1; i > 0; i--){
		for (int j = 0; j < i; j++)
			if (number[j]>number[j + 1]){
				temp = number[j];
				number[j] = number[j+1];
				number[j + 1] = temp;
			}
	}
}

int main(){
	/*Declare an integer n and assign it a value of 20.*/
	int n = 20;
	/*Allocate memory for an array of n integers using malloc.*/
	int *newArray;
	newArray = (int*)calloc(n, sizeof(int));
	/*Fill this array with random numbers between 0 and n, using rand().*/
	printf("\n");
	printf("Random Array");
	printf("\n");
	srand(time(NULL));
	for (int c = 0; c < n; c++) {
		newArray[c] = rand() % n;
	}
	/*Print the contents of the array.*/
	for (int d = 0; d < n; d++) {
		printf("%d\n", newArray[d]);
	}
	/*Pass this array along with n to the sort() function.*/
	sort(newArray, n);
	/*Print the contents of the array.*/    
	printf("\n");
	printf("Sorted Array");
	printf("\n");
	for (int d = 0; d < n; d++) {
		printf("%d\n", newArray[d]);
	}
	return 0;
}
