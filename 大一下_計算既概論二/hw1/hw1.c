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
			printf("��J�����פ����T�Э��s�ˬd\n");
			}
		}
	}		
}
int main(void){
	FILE *question;
	char str[500];
	question=fopen("�D�w.txt","r");
	printf("================\n");
	fgets(str,500,question);
	puts(str);
	printf("�H�U�O�Ӥp����A�п�Ja b c d e�ӧ@��\n�]�̧Ǭ��D�`���P�N�B���P�N�B�L�N���B�P�N�B�D�`�P�N�^\n");
	printf("================\n");
	int sum=0;
	int i=0;
	while(i<10){
		fgets(str,500,question);
		puts(str);
		sum+=ANS();
		i++;
	}
	printf("�A���J�{���Ƭ�%d���]�V�C�V�J�{�^\n�����ݬݧڭ̵��A���p��ĳ���\n",sum);
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
