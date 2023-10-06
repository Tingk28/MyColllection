#include<stdio.h>
#include<stdlib.h>
#include<math.h>
#define max(x, y) (((x) > (y)) ? (x) : (y))
typedef struct node node;
struct node{
	int data,rrange,lrange;
	node* lchild;
	node* rchild;
};
int buildtree(node* r,int depth,int currentd,int index,int* data,int size){//rode r 該樹深度為depth 該節點深度為currentd 範圍為index開始 
	int range= pow(2,depth-currentd);
	r->lrange=index;
	r->rrange=index+range-1;
	int num1,num2;
	if(depth!=currentd){
		node* lnode=malloc(sizeof(node));
		node* rnode=malloc(sizeof(node));
		r->lchild=lnode;
		r->rchild=rnode;
		num1=buildtree(r->lchild,depth,currentd+1,index,data,size);
		num2=buildtree(r->rchild,depth,currentd+1,(index*2+range)/2,data,size);
		//printf("num1=%d,num2=%d\n",num1,num2);
	}
	else{
		if(index>=size){
			r->data=0;
			return 0;
		}
		r->data=*(data+index);
		return *(data+index);
	}
	r->data=max(num1,num2);
}
int max_element(node* root,int lowrange,int uprange,int* choosednum,int max){//尋找最大值 
	int split_points=(root->lrange+root->rrange+1)/2;
	//printf("now at=%d low=%d up=%d lr=%d rr=%d max=%d sp=%d\n",root->data,lowrange,uprange,root->lrange,root->rrange,max,split_points);
	if(lowrange<=root->lrange&&uprange>=root->rrange){
		//0printf("now at=%d lr=%d rr=%d\n",root->data,root->lrange,root->rrange);
		*(choosednum)+=1;
		printf("choosing point %d = %d\n",*choosednum,root->data);
		if(root->data>max){
			return root->data;
		}
		else{
			return max;
		}
	}
	else if(uprange>=split_points&&lowrange<split_points){
		max=max_element(root->lchild,lowrange,split_points-1,choosednum,max);
		max=max_element(root->rchild,split_points,uprange,choosednum,max);
	}
	else if(uprange>=split_points&&lowrange>=split_points){
		max=max_element(root->rchild,lowrange,uprange,choosednum,max);
	}
	else if(uprange<split_points&&lowrange<split_points){
		max=max_element(root->lchild,lowrange,uprange,choosednum,max);
	}
}
int main (){
	srand(time(NULL));
	int size,i,up,down,choosed;
	printf("type data number:\n");
	scanf("%d",&size);
	int* data=malloc(size*sizeof(int));
	for(i=0;i<size;i++){
		*(data+i)=rand()%100+1;
		printf("number_array[%d] = %d\n",i,*(data+i));
	}
	int depth=log(size)/log(2);
	if((log(size)/log(2))-(int)(log(size)/log(2))>0){
		depth++;
	};
	node* root=malloc(sizeof(node));
	buildtree(root,depth,0,0,data,size);
	printf("type search data range:\n");
	char range[20]="";
	int splitpoint=0;
	fflush(stdin);
	gets(range);
	char charup[10]="";
	for(i=0;i<20;i++){
		if(range[i]==' '){
			splitpoint=i+1;
			down=atoi(charup);
			continue;
		}
		else if(range[i]=='\0'){
			up=atoi(charup);
			break;
		}
		else{
			charup[i-splitpoint]=range[i];
		}
	}
	int *chooseptr=&choosed;
	choosed=0;
	printf("in range number_array[%d] ~ number_array[%d], max = %d",down,up,max_element(root,down,up,chooseptr,0));
}
