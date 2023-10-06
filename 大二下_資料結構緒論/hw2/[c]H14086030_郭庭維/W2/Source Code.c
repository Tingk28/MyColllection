#include<stdio.h>
typedef struct Node Node;
struct Node{
	char data;
	struct Node *next;
};
void NewNode(Node *head,char c){
	if(head->data=='\0'){
		head->data=c;
	}
	else{
		while(head->next!=NULL){//連到last node
			head=head->next;
		}
		Node *n2;
		n2=malloc(sizeof(Node));
		head->next=n2;//連接 
		n2->data=c;//assign data
		n2->next=NULL;
	}
}
Node* Reverse(Node *head){//反轉linked list 
	Node* current=malloc(sizeof(Node));
	Node* pre=malloc(sizeof(Node));
	Node* next=malloc(sizeof(Node));
	current=head->next;
	pre=head;//pre會在current的前面 
	pre->next=NULL;//最後一個node 指向NULL 
	if(current==NULL){//處理linked list長度為1的狀況
		return pre;
	}
	while(current->next!=NULL){//如果還有下個node 
		next=current->next;//定位next node 
		current->next=pre;//current node 連到 pre node 
		pre=current;//移動到下一階 
		current=next;//移動到下一階
	}
	if(current->next==NULL){//last node
		current->next=pre;
	}
	return current;
}
void PrintList(Node *head){//input head node head 逐步印出
	printf("%c",head->data);//印出第一個（避免len(input)==1）
	while(head->next!=NULL){//直到空
		head=head->next;
		printf("->%c",head->data);
	}
}
int main(void){
	char input[100]="";//空字元陣列
	while(gets(input)){
		Node *head;//初始化
		head = malloc(sizeof(Node));
		head->next=NULL;
		head->data='\0';
		int i;
		for(i=0;i<sizeof(input)-1;i++){//輸入資料
			char c=input[i];
			if(c=='\0'){//資料讀入完畢
				break;
			}
			NewNode(head,c);
		}
		printf("Input linked list : ");
		PrintList(head);//反轉前
		printf("\nreverse linked list : ");
		PrintList(Reverse(head));//反轉後
		printf("\n");
	}
 return 0;
}

