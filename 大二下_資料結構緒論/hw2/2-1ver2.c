#include<stdio.h>
#include<math.h>
typedef struct charstack charstack;
struct charstack{
	char c[100];
	char *cpoint;
	int top;
	int *toppoint;
};
float postfixnum[26];
char pop(charstack stack){//�ǤJcharstack return pop's char 
	if(stack.top==0){//�Ū� 
		printf("empty stack\n");
	}
	else
	{
		stack.top--;
		*stack.toppoint=stack.top;
		return stack.c[stack.top+1];
	}
}
int push(charstack stack,char c){//push char to charchar
	if(stack.top<100){//���\�^�� 1 
		stack.top++;
		*stack.toppoint=stack.top;
		*(stack.cpoint+stack.top)=c;
		//printf("%c is pushed\n",c);
		return 1;
	}
	else{//���Ѧ^�� 0 
		printf("stack is full\n");
		return 0;
	}
}
int index(char a,char s[],int range){//�^�� char a �blist s������m �Y�L�������^��-1 
	int i;
	for(i=0;i<range;i++){
		if(a==s[i]){
			return i;
		}
	}
	return -1;
}
char* In2Post(char s[],int size,char result[]){
	int resultindex=0;
	char hier[]="(+-*/)";
	int hiertable[]={0,1,1,2,2,3};
	int haspar=0;//�O�_���A�� 
	int over2digit=0;//�O�_�W�L���� 
	int outputindex=0;//char to int index
	charstack temp={//�B��l��charstack
		.top=0,
		.toppoint=&temp.top,
		.cpoint=&temp.c
	};
	int i;
	for(i=0;i<size-1;i++){
		char c=s[i];
		if(index(c,hier,6)>=0){//���B��l
			char previous =temp.c[temp.top];
			if(c=='('){
				haspar++;
			}
			else if(index(previous,hier,6)==-1){//expression stack empty
			}
			else if(hiertable[index(c,hier,6)]==hiertable[index(previous,hier,6)]){//�춥�۵� 
				result[resultindex]=pop(temp);
				resultindex++;
			}
			else if(hiertable[index(c,hier,6)]>hiertable[index(previous,hier,6)]&&c!=')'){//�춥��j
			}
			else{
				if(haspar==0){//�S�����A�� 
					while(hiertable[index(c,hier,6)]<hiertable[index(previous,hier,6)]){
						result[resultindex]=pop(temp);
						resultindex++;
						previous =temp.c[temp.top];
					}
				}
				else{//�����A�������p
					if(c==')'){
						while(previous!='('){//c�����A��
							result[resultindex]=pop(temp);
							resultindex++;
							previous =temp.c[temp.top];
						}
						pop(temp);
						haspar--;
					}
					else{
						while(hiertable[index(c,hier,6)]<=hiertable[index(previous,hier,6)]){
							result[resultindex]=pop(temp);
							resultindex++;
							previous =temp.c[temp.top];
						}
					}
				}
				
			}
			if(c!=')'){
				push(temp,c);
			}
			over2digit=0;
		}
		else if(atoi(&c)>0||c=='0'){//���Ʀr 
			float now =atoi(&c);
			if(over2digit==0){//�s�Ʀr 
				over2digit=1;
				result[resultindex]='a'+outputindex;
				//push(postfix,'a'+outputindex);
				postfixnum[outputindex]=now;
				outputindex++;
				resultindex++;
			}
			else{//�G��ƥH�W 
				postfixnum[outputindex-over2digit];
				int j;
				float number;
				for(j=0;j<=over2digit;j++){//char[] to int e.g. char"12"��int 12 
					char longnum[over2digit];
					char at = s[i-j];
					longnum[over2digit-j]=at;
					number=(float) atoi(longnum);//�]��pow(10,2)=99.999 ��int�|�����׿��~ 
				}
				postfixnum[outputindex-1]=number;
				over2digit++;
			}
		}
		int t;
	}
	while(temp.top!=0){
		result[resultindex]=pop(temp);
		resultindex++;
	}
	result[resultindex]='\0';
	return resultindex;
}
void postfixcal(char exp[],int num[],float numindex[]){
	int i;
	float ans;
	float numstack[26];
	int top;
	char hier[]="(+-*/)";
	for(i=0;i<num;i++){
		char c=exp[i];
		if(index(c,hier,6)<0){
			numstack[top]=numindex[c-'a'];
			top++;
		}
		else{
			float num1=0,num2=0;
			top--;
			num2=numstack[top];
			top--;
			num1=numstack[top];
			if(index(c,hier,6)==1){
				numstack[top]=num1+num2;
				top++;
			}
			else if(index(c,hier,6)==2){
				numstack[top]=num1-num2;
				top++;
			}
			else if(index(c,hier,6)==3){
				numstack[top]=num1*num2;
				top++;
			}
			else if(index(c,hier,6)==4){
				numstack[top]=num1/num2;
				top++;
			}
		}
	}
	printf("result = %.2f\n",numstack[0]);
}
int main(){
	char input[100]="";
	while (gets(input)){
		printf("",input);
		int i;
		char postfix[100];
		int postfixlen=In2Post(input,index('\0',input,100)+1,postfix);
		postfixcal(postfix,postfixlen,postfixnum);
	}
	return 0;
}
