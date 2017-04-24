/* CS261- Assignment 1 - Q.1*/
/* Name: Lucy Wyman and Chase Coltman
 * Date: June 27, 2014
 * Solution description: 
 */

#include <stdio.h>
#include <stdlib.h>
#include <math.h>

struct student{
	int id;
	int score;
};

//Allocate memory for student array and set all values to 0 w/ calloc
struct student* allocate(){
	struct student* student_array;
	student_array = (struct student*)calloc(10, sizeof(struct student));  
	return student_array;
}

//Randomly assign ID to each student, and randomly generate score between 0 and 100
void generate(struct student* students){
	int length = 10;
	struct student* new_array;
	new_array = students;
	//To randomly assign we instead just randomly found an "empty" student in the array and assigned them the current iteration value, then generated score
	for(int j=0; j<length; j++){
		int at = rand()%length;
		while(new_array[at].id!=0){
			at = rand()%length;
		}
		new_array[at].id = j+1; 
		new_array[at].score = rand()%100;
	}
}

void output(struct student* students){
	for (int i = 0; i<10; i++){  
		printf("\e[1;31mStudent\e[0m\e[1;33m %d \e[0m\e[1;31mscored \e[0m\e[1;33m%d\e[0m\n", students[i].id, students[i].score);
	}
	printf("\n");
}

void summary(struct student* students){
	struct student minimum = students[0];
	for (int i = 0; i<10; i++){
		if (students[i].score<minimum.score)
			minimum = students[i];
	}
	struct student maximum = students[0];
	for (int i = 0; i<10; i++){
		if (students[i].score>maximum.score)
			maximum = students[i];
	}
	int total = 0;
	for (int i = 0; i<10; i++){
		total = total+students[i].score;
	}
	int average = total/10;
	//Longest print statement ever, but too lazy to break it up.  The eternal struggle of the programmer
	printf("\e[1;34mStudent \e[0m\e[1;35m%d\e[0m\e[1;34m got a minimum score of \e[0m\e[1;35m%d\e[0m\n\e[1;34mStudent \e[0m\e[1;35m%d \e[0m\e[1;34mgot a maximum score of \e[0m\e[1;35m%d\e[0m\n\e[1;34mThe average score was \e[0m\e[1;35m%d\e[0m\n", minimum.id, minimum.score, maximum.id, maximum.score, average);
}

void deallocate(struct student* stud){
	free(stud);
}

int main(){
	struct student* stud = NULL;
	stud = allocate();
	generate(stud);
	output(stud);
	summary(stud);
	deallocate(stud);
	return 0;
}
