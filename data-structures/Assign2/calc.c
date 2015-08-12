//Lucy Wyman and Chase Coltman

#include <stdlib.h>
#include <stdio.h>
#include <string.h>
#include <assert.h>
#include <math.h>
#include "dynamicArray.h"
#define pi 3.14159
#define e 2.79


/* param: s the string
param: num a pointer to double
returns: true (1) if s is a number else 0 or false.
postcondition: if it is a number, num will hold
the value of the number
*/
int isNumber(char *s, double *num)
{
	char *end;
	double returnNum;

	if(strcmp(s, "0") == 0)
	{
		*num = 0;
		return 1;
	}
	else 
	{
		returnNum = strtod(s, &end);
		/* If there's anythin in end, it's bad */
		if((returnNum != 0.0) && (strcmp(end, "") == 0))
		{
			*num = returnNum;
			return 1;
		}
	}
	return 0;  //if got here, it was not a number
}

/*	param: stack the stack being manipulated
pre: the stack contains at least two elements
post: the top two elements are popped and 
their sum is pushed back onto the stack.
*/
void add (struct DynArr *stack)
{
	assert(!isEmptyDynArr(stack));
	double num1;
	double num2;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	num2 = topDynArr(stack);
	popDynArr(stack);

	sum = num1 + num2;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

/*	param: stack the stack being manipulated
pre: the stack contains at least two elements
post: the top two elements are popped and 
their difference is pushed back onto the stack.
*/
void subtract(struct DynArr *stack)
{
	assert(!isEmptyDynArr(stack));
	double num1;
	double num2;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	num2 = topDynArr(stack);
	popDynArr(stack);

	sum = num2 - num1;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

/*	param: stack the stack being manipulated
pre: the stack contains at least two elements
post: the top two elements are popped and 
their quotient is pushed back onto the stack.
*/
void divide(struct DynArr *stack)
{
	assert(!isEmptyDynArr(stack));
	double num1, num2, sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	num2 = topDynArr(stack);
	popDynArr(stack);

	sum = num2 / num1;
	pushDynArr(stack, sum); 
	printf("Solution: %f\n", sum);
}

void multiply(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1, num2, sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	num2 = topDynArr(stack);
	popDynArr(stack);

	sum = num1 * num2;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void power(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1, num2, sum = 1.0;
	num1 = topDynArr(stack);
	popDynArr(stack);

	num2 = topDynArr(stack);
	popDynArr(stack);
	sum = pow(num2, num1);
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void square(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1, num2, sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	sum = num1 * num1;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void cube(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1, sum;
	num1 = topDynArr(stack);
	popDynArr(stack);
	sum = num1*num1*num1;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void absolut(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1;
	double sum;

	num1 =  topDynArr(stack);
	popDynArr(stack);

	if (num1 < 0){
		sum = num1 * (-1);
	}
	else
		sum = num1;
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void squareRoot(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	sum = sqrt(num1);
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}



void expon(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	sum = exp(num1);
	pushDynArr(stack, sum);
	printf("Solution for base e: %f\n", sum);
}

void nattyLog(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	sum = log(num1);
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}

void logBaseTen(struct DynArr *stack){
	assert(!isEmptyDynArr(stack));
	double num1;
	double sum;

	num1 = topDynArr(stack);
	popDynArr(stack);

	sum = log10(num1);
	pushDynArr(stack, sum);
	printf("Solution: %f\n", sum);
}
double calculate(int numInputTokens, char **inputString)
{
	int i, count = 0;
	double result = 0.0, num1 = 0.0, num2 = 0.0;
	char *s;
	struct DynArr *stack;
	//set up the stack
	stack = createDynArr(20);
	// start at 1 to skip the name of the calculator calc
	for(i=1 ;i < numInputTokens;i++) 
	{
		s = inputString[i];
		if (numInputTokens >= 4){
			if(isNumber(inputString[1], &num1)==1 && isNumber(inputString[2], &num2)==1){
				pushDynArr(stack, num1);
				pushDynArr(stack, num2);
				if (strcmp(s, "+") == 0)
					add(stack);
				else if (strcmp(s, "-") == 0)
					subtract(stack);
				else if (strcmp(s, "/") == 0)
					divide(stack);
				else if (strcmp(s, "x") == 0)
					multiply(stack);
				else if (strcmp(s, "^") == 0)
					power(stack);
			}
			else{
				printf("\e[1;31mYou done goofed!\e[0m");
			}
		}

		else if (numInputTokens <= 3){
			if(isNumber(inputString[1], &num1)==1){
				pushDynArr(stack, num1);
				if (strcmp(s, "^2") == 0)
					square(stack);
				else if (strcmp(s, "^3") == 0)
					cube(stack);
				else if (strcmp(s, "abs") == 0)
					absolut(stack);
				else if (strcmp(s, "sqrt") == 0)
					squareRoot(stack);
				else if (strcmp(s, "exp") == 0)
					expon(stack);
				else if (strcmp(s, "ln") == 0)
					nattyLog(stack);
				else if (strcmp(s, "log") == 0)
					logBaseTen(stack);
			}
			else{
				printf("\e[1;31mYou done goofed!\e[0m\n");
			}
		}
		else
		{
			count = count+1;
			if(count = numInputTokens-1){
				printf("\e[1;31mYou done goofed! Please try again\e[0m\n");
				exit(1);
			}
		}
	}	
	return result;
}

int main(int argc, char** argv)
{
	// assume each argument is contained in the argv array
	// argc1 determines the number of operands + operators
	if (argc == 1)
		return 0;

	calculate(argc, argv);
	return 0;
}
