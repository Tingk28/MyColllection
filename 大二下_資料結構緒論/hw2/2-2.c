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
		while(head->next!=NULL){//�s��last node
			head=head->next;
		}
		Node *n2;
		n2=malloc(sizeof(Node));
		head->next=n2;//�s�� 
		n2->data=c;//assign data
		n2->next=NULL;
	}
}
Node* Reverse(Node *head){//����linked list 
	Node* current=malloc(sizeof(Node));
	Node* pre=malloc(sizeof(Node));
	Node* next=malloc(sizeof(Node));
	current=head->next;
	pre=head;//pre�|�bcurrent���e�� 
	pre->next=NULL;//�̫�@��node ���VNULL 
	if(current==NULL){//�B�zlinked list���׬�1�����p
		return pre;
	}
	while(current->next!=NULL){//�p�G�٦��U��node 
		next=current->next;//�w��next node 
		current->next=pre;//current node �s�� pre node 
		pre=current;//���ʨ�U�@�� 
		current=next;//���ʨ�U�@��
	}
	if(current->next==NULL){//last node
		current->next=pre;
	}
	return current;
}
void PrintList(Node *head){//input head node head �v�B�L�X
	printf("%c",head->data);//�L�X�Ĥ@�ӡ]�קKlen(input)==1�^
	while(head->next!=NULL){//�����
		head=head->next;
		printf("->%c",head->data);
	}
}
int main(void){
	char input[100]="";//�Ŧr���}�C
	while(gets(input)){
		Node *head;//��l��
		head = malloc(sizeof(Node));
		head->next=NULL;
		head->data='\0';
		int i;
		for(i=0;i<sizeof(input)-1;i++){//��J���
			char c=input[i];
			if(c=='\0'){//���Ū�J����
				break;
			}
			NewNode(head,c);
		}
		printf("Input linked list : ");
		PrintList(head);//����e
		printf("\nreverse linked list : ");
		PrintList(Reverse(head));//�����
		printf("\n");
	}
 return 0;
}

