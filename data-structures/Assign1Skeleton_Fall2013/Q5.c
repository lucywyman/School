/* CS261- Assignment 1 - Q.5*/
/* Name: Chase Coltman, Lucy Wyman
 * * Date: 7/2/2014
 * * Solution description:
 * */

#include <stdio.h>
#include <stdlib.h>

/*converts ch to upper case, assuming it is in lower case currently*/
char toUpperCase(char ch){
	    return ch-'a'+'A';
}

/*converts ch to lower case, assuming it is in upper case currently*/
char toLowerCase(char ch){
	    return ch-'A'+'a';
}

void studly(char* word){
	    /*Convert to studly caps*/
	int c;
	for (c = 0; word[c] != '\0'; c++){
		if (word[c] >= 'a'&&word[c] <= 'z'){
			word[c] = toUpperCase(word[c]);
		}
	}

	for (c = 1; word[c] != '\0'; c = c + 2){
		word[c] = toLowerCase(word[c]);
	}
}

int main(){
	   /*Read word from the keyboard using scanf*/
	char enterWord[100];
	printf("Please enter your word: ");
	scanf("%s", enterWord);
	/*Call studly*/
	studly(enterWord);
	   /*Print the new word*/
	printf("%s\n", enterWord);
	   return 0;
}

