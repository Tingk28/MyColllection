#include <stdio.h>
#include <math.h> 
int index(char a,char s[]){//�^�� char a �blist s������m �Y�L�������^��-1 
	int i;
	for(i=0;i<6;i++){
		if(a==s[i]){
			return i;
		}
	}
	return -1;
}
int main(){
	char a[100]="apple";
	printf("%d",index('\0',a));
}
