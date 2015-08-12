/* CS261- Assignment 1 - Q.4*/
 /*Name: Chase Coltman, Lucy Wyman
 * * Date:7/2/2014
 * Solution description:
 * */

#include <stdio.h>
#include <stdlib.h>
#include <time.h>

struct student{
	int id;
	int score;
};

void sort(struct student* students, int n){
	/*Sort the n students based on their score*/  
	int x, y, tempscore, tempid;
	for (x = (n - 1); x>0; x--){
		for (y = 1; y <= x; y++){
			if (students[y - 1].score > students[y].score){
				tempscore = students[y - 1].score;
				tempid = students[y - 1].id;
				students[y - 1].score = students[y].score;
				students[y - 1].id = students[y].id;
				students[y].score = tempscore;
				students[y].id = tempid;
			}
		}
	}
	/* Remember, each student must be matched with their original score after sorting */
}

int main(){
	/*Declare an integer n and assign it a value.*/
	int n = 10;
	/*Allocate memory for n students using malloc.*/
	struct student* newArray = malloc(n * (sizeof(struct student)));
	/*Generate random IDs and scores for the n students, using rand().*/
	srand(time(NULL));
	for (int cc = 0; cc < n; cc++){
		newArray[cc].id = rand() % 99999 + 9999;
		newArray[cc].score = rand() % 100 + 1;
	}
	/*Print the contents of the array of n students.*/
	for (int c = 0; c < n; c++){
		printf("ID: %d Score: %d\n", newArray[c].id, newArray[c].score);
	}
	/*Pass this array along with n to the sort() function*/
	sort(newArray, n); printf("\n");
	/*Print the contents of the array of n students.*/
	for (int d = 0; d < n; d++){
		printf("ID: %d Score: %d\n", newArray[d].id, newArray[d].score);
	}
	return 0;
}
