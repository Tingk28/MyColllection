#include<stdio.h>
#define min(x, y) (((x) < (y)) ? (x) : (y))
//merge sort
int* merge_sort(int* a,int* b,int s1,int s2){
	int len=(s1+s2);
	int *result= malloc((sizeof(int))*len);
	int i;
	int p1=0;
	int p2=0;
	for(i=0;i<len;i++){
		int temp;
		if(len==2){
			if(b==NULL){
				printf("100\n");
			 	if(*(a)>*(a+1)){
			 		*(result+i)=*(a+1);
			 		i++;
					*(result+i)=*a;
					break;
				}
				else{
					*(result+i)=*a;
					i++;
					*(result+i)=*(a+1);
					break;	
				}
			}
			//printf("0");
			//printf("%d,%d",*a);
			else if(*(a)>*(b)){
				printf("1");
				*(result+i)=*a;
				i++;
				*(result+i)=*b;
				break;
			}
			else {
				printf("2");
				*(result+i)=*b;
				i++;
				*(result+i)=*a;
				break;
			}
		}
		else if(len==1){
			if(s1==1){
				*(result+i)=*a;
			}
			else{
				*(result+i)=*b;
			}
		}
		else{
			merge_sort(a,(a+s1/2),s1/2,(s1-s1/2));
			merge_sort((a+s1/2),NULL,len-,0);
			if(*(a+p1)>*(b+p2)){
				*(result+i)=*(a+p1);
				p1++;
			}
			else{
				*(result+i)=*(b+p2);
				p2++;
			}
		}
	}
	return(result);
}

int main(){
	int data[]={11,2,15,6,30,9};
	int i,j;
	int* a=merge_sort(data,NULL,sizeof(data)/4,0);
	for(i=0;i<sizeof(data)/4;i++){
		printf("%d,",*(a+i));
	}
}
