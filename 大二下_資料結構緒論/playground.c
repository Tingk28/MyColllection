#include <stdio.h>
#include <math.h> 
int index(char a,char s[]){//回傳 char a 在list s中的位置 若無此元素回傳-1 
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
