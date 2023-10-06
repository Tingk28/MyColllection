#include<stdio.h>
#include<string.h>
int ANS(void){
	char ans [5]={'e','d','c','b','a'};
	int correct=0;
	while(correct==0){
		char Z;
		scanf(" %c",&Z);
		int i =0;
		for(i=0;i<5;i++){
			//printf("%d\n",i);
			if(Z==ans[i]){
				i++;
				return i;
				correct=1;
				break;
			}
			else if(i==4){
			printf("輸入的答案不正確請重新檢查\n");
			}
		}
	}		
}
int main(void){
	FILE *question;
	char str[500];
	question=fopen("題庫.txt","r");
	printf("================\n");
	fgets(str,500,question);
	puts(str);
	printf("以下是個小測驗，請輸入a b c d e來作答\n（依序為非常不同意、不同意、無意見、同意、非常同意）\n");
	printf("================\n");
	int sum=0;
	int i=0;
	while(i<10){
		fgets(str,500,question);
		puts(str);
		sum+=ANS();
		i++;
	}
	printf("你的焦慮分數為%d分（越低越焦慮）\n不妨看看我們給你的小建議喔～\n",sum);
	while(1==1){
	if(sum<=20){
	fgets(str,500,question);
	puts(str);
	fgets(str,500,question);
	puts(str);
	break;	
}
	else{
	fgets(str,500,question);
	fgets(str,500,question);
	}
	if(sum>=40){
	fgets(str,500,question);
	puts(str);
	fgets(str,500,question);
	puts(str);
	break;
	}
	else{
	fgets(str,500,question);
	fgets(str,500,question);
	}
	fgets(str,500,question);
	puts(str);
	fgets(str,500,question);
	puts(str);
	break;
}
}
