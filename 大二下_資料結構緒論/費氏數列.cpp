#include<stdio.h>
int f(int n){
	if(n==0 || n==1){
		return 1;
	}
	else{
		return f(n-1)+f(n-2);
	}
}
int main(void){
	printf("%d\n",f(55));
	return 0;
}
