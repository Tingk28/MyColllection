#include<stdio.h>
#include<time.h> 
#include <stdlib.h> 
void print (int a[]);
void scanred(int a[],float r[],float b[],int area[],float rinfo[],float binfo[],int color);
void scanarea(int a[],int area[],float rinfo[],float binfo[],int i,int pos,int color);
void scan(int a[]);
void update(int a[],char stat[],int area[]);
void numoutput(int a[]);
int Redpossible(int a[],float r[]);
int Bluepossible(int a[],float b[]);
void RPP(int a,int b,int c);
void BPP(int a,int b,int c);
void recenter(int block[],int c);
void updateleft(int a[],char left[]);
void printleft(int a[]);
void updatelefttxt(int a[],char lef[]);
void updateboardtxt(int a[],char stat[]);
void SPB(int a[],int p,int q,int r,int c);
int decidecolor(char Color[]);
void numoutput2 (int a[]);
void numoutput3 (float a[],char f[]);
void printfloat(float a[]);
void floatboardprint (float a[]);
//int head=184;
int left[21];//�Ѿl��� 
int IDcount[21]={0,1,3,7,9,10,18,22,26,28,36,40,44,48,52,56,64,65,73,81,89};//�C�ؤ���}�l���s����
int IDtoLeft[91]={0,1,1,2,2,2,2,3,3,4,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,8,8,9,9,9,9,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14,15,15,15,15,15,15,15,15,16,17,17,17,17,17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,20,20};//���ID���ڬY�������Ӫ� 
//1,2,4,2,1,8,4,4,2,8,4,4,4,4,4,8,1,8,8,8,2
int Two[4]={0,1,0,22};//���n��1-2��������Ϊ��]�Ԩ�document�^;
int Three[18]={0,-1,22,0,-22,-1,0,-22,1,0,1,22,0,-1,1,0,-22,22};//���n=3 
int Four[76]={0,1,22,23,0,-1,1,21,0,-23,-22,22,0,-21,-1,1,0,-22,22,23,0,-23,-1,1,0,-22,-21,22,0,-1,1,23,0,-22,21,22,0,-1,1,22,0,-22,-1,22,0,-22,-1,1,0,-22,1,22,0,-1,22,23,0,-22,-1,21,0,-22,-21,-1,0,-22,1,23,0,-1,1,2,0,-22,22,44}; //���n=4 
int Five[315]={0,-1,1,21,22,0,-23,-22,-1,22,0,-22,-21,-1,1,0,-22,1,22,23,0,-23,-22,-1,1,0,-22,-21,1,22,0,-1,1,22,23,0,-22,-1,21,22,0,-1,1,21,23,0,-23,-22,21,22,0,-23,-21,-1,1,0,-22,-21,22,23,0,-1,1,22,44,0,-22,-2,-1,22,0,-44,-22,-1,1,0,-22,1,2,22,0,-1,1,21,43,0,-24,-23,-22,22,0,-43,-21,-1,1,0,-22,22,23,24,0,-23,-22,1,23,0,-21,1,21,22,0,-23,-1,22,23,0,-22,-21,-1,21,0,-23,-1,1,23,0,-22,-21,21,22,0,-21,-1,1,21,0,-23,-22,22,23,0,-23,-1,1,22,0,-22,-21,-1,22,0,-22,-1,1,23,0,-22,1,21,22,0,-22,-1,1,21,0,-23,-22,1,22,0,-21,-1,1,22,0,-22,-1,22,23,0,-22,-1,1,22,0,-1,1,2,21,0,-23,-22,22,44,0,-21,-2,-1,1,0,-44,-22,22,23,0,-23,-1,1,2,0,-22,-21,22,44,0,-2,-1,1,23,0,-44,-22,21,22,0,-2,-1,22,23,0,-44,-22,-1,21,0,-1,22,23,24,0,-21,1,22,44,0,-22,-21,-2,-1,0,-44,-22,1,23,0,1,2,21,22,0,-23,-1,22,44,0,-1,1,2,22,0,-22,-1,22,44,0,-22,-2,-1,1,0,-44,-22,1,22,0,-22,-1,1,2,0,-22,1,22,44,0,-2,-1,1,22,0,-44,-22,-1,22,0,-2,-1,1,2,0,-44,-22,22,44};//���n=5 
float redpoint[]={0,0.5,1,0,0.5,0,0,1.25,1,2,0};//�t��
float bluepoint[]={0.5,0,1,0,1.25,1,0,0.5,0,2,0};
int rcross[100]={0};
int bcross[100]={0};
int color=0;//��e�C�� 
int main(int argc,char* argv[]){
	clock_t start,end;
	start=clock();
	int board [484]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,2,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,5,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,};
	float rboard[484]={0};
	float bboard[484]={0};
	float redareainfo[120]={0};
	float blueareainfo[120]={0};
	int area[484]={0};
	color=decidecolor(argv[1]);//��1��2
	update(board,argv[2],area);//Ū���L�� 
	updateleft(left,argv[3]);//Ū���Ѿl
	scan(board);//���L�������]�Ԩ�document�^
	scanred(board,rboard,bboard,area,redareainfo,blueareainfo,color);
	/*floatboardprint (rboard);
	printleft(left);
	printfloat(redareainfo);
	print(board);*/
	//print(area);
	numoutput2(area);
	numoutput3(rboard,"rnumoutput.txt");
	numoutput3(bboard,"bnumoutput.txt");
	//print(rboard);
	if(color==1){//���� 
		int a=1;//�`�i��U�@�B�ƶq 
		a=Redpossible(board,rboard);//�����@���h�֥i�� 
		if(a==0){
			return 1;
		}
	}
	else{//�Ŧ� 
		int b;//�`�i��U�@�B�ƶq 
		b=Bluepossible(board,bboard);//�����@���h�֥i�� 
		if(b==0){
			return 1;
		}
	}
	numoutput(board);//��X�L����ơ]���R��) 
	updateboardtxt(board,argv[2]);//��s�ѽL��� 
	updatelefttxt(left,argv[3]);//��s�Ѿl 
	//print(area);
	//numoutput(board);
	print(board);
	return 0;
}
void scan (int a[]){//���y 
	int i=92;//�q�ѽL���W�}�l�j�M 
	int xb,xr,r,b;
	while(i<392){
		if(a[i]!=1&&a[i]!=4&&a[i]!=8){
			xb=0,xr=0,r=0,b=0;
			if(a[i-21]==1||a[i-23]==1||a[i+21]==1||a[i+23]==1){xr=1;}// �ר����L���� 
			if(a[i-21]==4||a[i-23]==4||a[i+21]==4||a[i+23]==4){xb=1;}// �ר����L�Ŧ� 
			if(a[i-22]==1||a[i-1]==1||a[i+1]==1||a[i+22]==1){r=1;}// ���䦳���� 
			if(a[i-22]==4||a[i-1]==4||a[i+1]==4||a[i+22]==4){b=1;}// ���䦳�Ŧ�
			if(xb==1&&r==1&&b==0){a[i]=-2;}//�̾ڹ��������p�������� 
			else if(xr==1&&b==1&&r==0){a[i]=-1;}
			else if(xr==1&&xb==0&&b==0&&r==0){a[i]=2;}
			else if(xb==0&&b==0&&r==1){a[i]=3;}
			else if(xb==1&&xr==0&&r==0&&b==0){a[i]=5;}
			else if(xr==0&&r==0&&b==1){a[i]=6;}
			else if(xb==1&&xr==1&&b==0&&r==0){a[i]=7;}
			else if(b==1&&r==1){a[i]=8;}
		}
		i++;
	}
}
void scanred(int a[],float r[],float b[],int area[],float rinfo[],float binfo[],int color){
	//memset(r,0,484);
	int p,i=1;
	int rcrosspointer=0,bcrosspointer=0;
	for(p=92;p<392;p++){
		if(a[p]==5||a[p]==7||a[p]==-2){
			r[p]+=5;
			r[p+1]+=2;
			r[p-1]+=2;
			r[p-22]+=2;
			r[p+22]+=2;
			r[p+23]+=2;
			r[p-23]+=2;
			r[p+21]+=2;
			r[p-21]+=2;
			r[p-46]+=1;
			r[p-45]+=1;
			r[p-44]+=1;
			r[p-43]+=1;
			r[p-42]+=1;
			r[p+46]+=1;
			r[p+45]+=1;
			r[p+44]+=1;
			r[p+43]+=1;
			r[p+42]+=1;
			r[p+24]+=1;
			r[p+20]+=1;
			r[p-24]+=1;
			r[p-20]+=1;
			r[p-2]+=1;
			r[p+2]+=1;
		}
		if(a[p]==2||a[p]==7||a[p]==-1){
			b[p]+=5;
			b[p+1]+=2;
			b[p-1]+=2;
			b[p-22]+=2;
			b[p+22]+=2;
			b[p+23]+=2;
			b[p-23]+=2;
			b[p+21]+=2;
			b[p-21]+=2;
			b[p-46]+=1;
			b[p-45]+=1;
			b[p-44]+=1;
			b[p-43]+=1;
			b[p-42]+=1;
			b[p+46]+=1;
			b[p+45]+=1;
			b[p+44]+=1;
			b[p+43]+=1;
			b[p+42]+=1;
			b[p+24]+=1;
			b[p+20]+=1;
			b[p-24]+=1;
			b[p-20]+=1;
			b[p-2]+=1;
			b[p+2]+=1;
		}
		if(area[p]==0){
			scanarea(a,area,rinfo,binfo,i,p,color);
			i+=2;
		}
		if(a[p]==1&&a[p+23]==1&&a[p+1]!=1&&a[p+22]!=1){
			bcross[bcrosspointer]=p+1;
			bcross[bcrosspointer+1]=p+22;
			b[p+22]+=10;
			b[p+1]+=10;
			printf("b%d++,b%d++\n",p+22,p+1);
			bcrosspointer+=2;
		}
		if(a[p]==1&&a[p+21]==1&&a[p-1]!=1&&a[p+22]!=1){
			bcross[bcrosspointer]=p+22;
			bcross[bcrosspointer]=p-1;
			b[p+22]+=10;
			b[p-1]+=10;
			bcrosspointer+=2;
			printf("b%d++,b%d++\n",p+22,p-1);
		}
		if(a[p]==4&&a[p+23]==4&&a[p+1]!=4&&a[p+22]!=4){
			rcross[rcrosspointer]=p+22;
			rcross[rcrosspointer]=p+1;
			r[p+22]+=10;
			r[p+1]+=10;
			//printf("r%d++,r%d++\n",p+22,p+1);
			rcrosspointer+=2;
		}
		if(a[p]==4&&a[p+21]==4&&a[p-1]!=4&&a[p+22]!=4){
			rcross[rcrosspointer]=p+22;
			rcross[rcrosspointer]=p-1;
			r[p+22]+=10;
			r[p-1]+=10;
			//printf("r%d++,r%d++\n",p+22,p-1);
			rcrosspointer+=2;
		}
		if(p%22==17){
			p+=8;
		}
	}
	for(p=92;p<392;p++){
		if(a[p]==1){
			r[p]=-1;
			b[p]=-1;
		}
		if(a[p]==4){
			r[p]=-2;
			b[p]=-2;
		}/*
		if(area[p]!=-1&&area[p]!=-2&&p%22>3&&p%22<18){
			//printf("area=%.0f,m=%.2f\n",rinfo[area[p]],rinfo[area[p]-1]);
			int M=rinfo[area[p]-1];
			float m=(float)M;
			//printf("pos=%d,m=%.2f\n",p,m);
			r[p]=r[p]*m;
			M=binfo[area[p]-1];
			m=(float)M;
			b[p]=b[p]*m;
		}*/
		if(area[p]!=-1&&area[p]!=-2&&p%22>3&&p%22<18){
			printf("area=%.0f,m=%.2f\n",rinfo[area[p]],rinfo[area[p]-1]);
			int M=rinfo[area[p]-1]/rinfo[area[p]]*1000;
			float m=(float)M/1000;
			printf("pos=%d,m=%.2f\n",p,m);
			r[p]=r[p]*m;
			M=binfo[area[p]-1]/binfo[area[p]]*1000;
			m=(float)M/1000;
			b[p]=b[p]*m;
		}
	}
	int point=0;
	int last=0;
	if(rcrosspointer>bcrosspointer){
		last=rcrosspointer;
	}
	else{
		last=bcrosspointer;
	}
	for(point=0;point<=last;point++){
		if(r[rcross[point]]<r[rcross[point+1]]&&r[rcross[point+1]]>0){
			r[rcross[point+1]]=r[rcross[point]];
		}
		else if(r[rcross[point]]>r[rcross[point+1]]&&r[rcross[point]]>0){
			r[rcross[point]]=r[rcross[point+1]];
		}
		if(b[bcross[point]]<b[bcross[point+1]]&&b[bcross[point+1]]>0){
			b[bcross[point+1]]=b[bcross[point]];
		}
		else if(b[bcross[point]]>b[bcross[point+1]]&&b[bcross[point]]>0){
			b[bcross[point]]=b[bcross[point+1]];
		}
	}
}
void print (int a[]){//�L�X�Ʀr�ѽL 
	int i,p;/*����ѽL 
	for(i=0;i<484;i++){
		if(i%22!=0&&i!=0){
			printf(" %d",a[i]);
		}
		if(i%22==0){
			printf("\n %d",a[i]);
		}
	}*/
	p=0;
	printf("\n============================\n");
	for(i=92;i<392;i++){//��¦L�X14*14 
		if(p!=0||i==92){
			printf(" %d",a[i]);
			p++;
			if(p==14){
				p=0;
				i+=9;
			}
		}
		if(p==0&&i!=400){
			printf("\n %d",a[i]);
			p++;
		}
	}
	printf("\n============================\n");
}
void floatboardprint(float a[]){//�L�X�Ʀr�ѽL 
	int i,p;/*����ѽL 
	for(i=0;i<484;i++){
		if(i%22!=0&&i!=0){
			printf(" %d",a[i]);
		}
		if(i%22==0){
			printf("\n %d",a[i]);
		}
	}*/
	p=0;
	printf("\n============================\n");
	for(i=92;i<392;i++){//��¦L�X14*14 
		if(p!=0||i==92){
			printf(" %.2f",a[i]);
			p++;
			if(p==14){
				p=0;
				i+=9;
			}
		}
		if(p==0&&i!=400){
			printf("\n %.2f",a[i]);
			p++;
		}
	}
	printf("\n============================\n");
}
void update(int a[],char stat[],int area[]){//Ū���ѽL���A 
	FILE *status=fopen(stat,"r");
	char str[27];
	int line=0;
	while(fscanf(status,"%s",str)==1){
		int i=0;
		for(i=0;i<27;i+=2){
			if(str[i]=='R'){//�Ӯ欰���� 
				a[92+22*line+i/2]=1;
				area[92+22*line+i/2]=-1;
			}
			else if(str[i]=='B'){//�Ӯ欰�Ŧ� 
				a[92+22*line+i/2]=4;
				area[92+22*line+i/2]=-2;
			}
		}
		line++;
	}
	if(a[299]==1&&a[184]!=4&&a[184]!=1){
		a[184]=5;
	}
	fclose(status);
}
void updateleft(int a[],char lef[]){//��s�Ѿl��� 
	FILE *leftpatten=fopen(lef,"r");
	char str[45];
	int u,v=0;//for for loop
	while(fscanf(leftpatten,"%s",str)==1){
	}
	for(u=1;u<43;u+=2){//Ū�� 
		left[v]=atoi(&str[u]);//char��int 
		v++;
	}
	fclose(leftpatten);
}
int decidecolor(char Color[]){//Ū���C�� 
	if(Color[0]=='R'){
		return 1;
	}
	return 2;
}
void numoutput (int a[]){//�L�X�Ʀr���A���}�C 
	FILE *numoutput=fopen("numoutput.txt","w");
	int n=1;
	while(n<485){
		fprintf(numoutput,"%d,",a[n-1]);
		if(n%22==0&&n!=0){
			fputs("\n",numoutput);
		}
		n++;
	}
	fclose(numoutput);
}
void numoutput2 (int a[]){//�L�X�Ʀr���A���}�C 
	FILE *numoutput=fopen("numoutput2.txt","w");
	int n=1;
	while(n<485){
		fprintf(numoutput,"%d,",a[n-1]);
		if(n%22==0&&n!=0){
			fputs("\n",numoutput);
		}
		n++;
	}
	fclose(numoutput);
}
void numoutput3 (float a[],char f[]){//�L�X�Ʀr���A���}�C 
	FILE *numoutput=fopen(f,"w");
	int n=1;
	while(n<485){
		fprintf(numoutput,"%.2f,",a[n-1]);
		if(n%22==0&&n!=0){
			fputs("\n",numoutput);
		}
		n++;
	}
	fclose(numoutput);
}
void printfloat(float a[]){//�L�X�B�I�}�C
	int i=0;
	for(i=0;i<120;i++){
		/*if(a[i]==0&&a[i+1]==0){
			printf("I=%d,break",i);
			break;
		}*/
		printf("I=%d,point=%.2f,area=%0.f\n",i+1,a[i],a[i+1]);
		i++;
	}
}
float Rable(int a[],float r[],int p,int ID,int shift){
	int block[5]={0};
	float point=0;
	if(ID==0){//���n=1 ����� �A������m
		return r[p]+1;//�i�H��m
	}
	else if (ID<3){//���n<2 
		int write;
		for(write=0;write<2;write++){//���ID�����T�g�Jblock[] 
			block[write]=Two[2*ID-2+write];
		}
		recenter(block,shift);//����shift���block[]
		int now;
		for(now=0;now<2;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==1){//�h��m 
				point+=2;
				return point;//�i�H��m 
			}
		}
	}
	else if(ID<9){//���n=3 
		int write;
		for(write=0;write<3;write++){//���ID�����T�g�Jblock[] 
			block[write]=Three[3*ID-9+write];
		}
		recenter(block,shift);
		int now;
		for(now=0;now<3;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==2){ 
				point+=3;
				return point;//�i�H��m 
			}
		}
	}
	else if(ID<28){//���n=4 
		int write;
		for(write=0;write<4;write++){//���ID�����T�g�Jblock[] 
			block[write]=Four[4*ID-36+write];
		}
		recenter(block,shift);
		int now;	
		for(now=0;now<4;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=r[p+block[now]];	
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){					
				return -1;
			}
			else if(now==3){//�h��m 
				point+=4;
				return point;
			}
		}
	}
	else{//���n=5 
		int write;
		for(write=0;write<5;write++){//���ID�����T�g�Jblock[] 
			block[write]=Five[5*ID-140+write];
		} 
		recenter(block,shift);
		int now;
		for(now=0;now<5;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;//�����
			}
			else if(now==4){//�h��m 
				point+=5;
				return point;//�i�H��m 
			}
		}
	}
}
float Bable(int a[],float b[],int p,int ID,int shift){
	int block[5]={0};
	float point=0;
	if(ID==0){//���n=1 ����� �A������m
		return b[p]+1;//�i�H��m
	}
	else if (ID<3){//���n<2 
		int write;
		for(write=0;write<2;write++){//���ID�����T�g�Jblock[] 
			block[write]=Two[2*ID-2+write];
		}
		recenter(block,shift);//����shift���block[]
		int now;
		for(now=0;now<2;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==1){//�h��m 
				point+=2;
				return point;//�i�H��m 
			}
		}
	}
	else if(ID<9){//���n=3 
		int write;
		for(write=0;write<3;write++){//���ID�����T�g�Jblock[] 
			block[write]=Three[3*ID-9+write];
		}
		recenter(block,shift);
		int now;
		for(now=0;now<3;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==2){ 
				point+=3;
				return point;//�i�H��m 
			}
		}
	}
	else if(ID<28){//���n=4 
		int write;
		for(write=0;write<4;write++){//���ID�����T�g�Jblock[] 
			block[write]=Four[4*ID-36+write];
		}
		recenter(block,shift);
		int now;		
		for(now=0;now<4;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){					
				return -1;
			}
			else if(now==3){//�h��m 
				point+=4;
				return point;
			}
		}
	}
	else{//���n=5 
		int write;
		for(write=0;write<5;write++){//���ID�����T�g�Jblock[] 
			block[write]=Five[5*ID-140+write];
		} 
		recenter(block,shift);
		int now;
		for(now=0;now<5;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;//�����
			}
			else if(now==4){//�h��m 
				point+=5;
				return point;//�i�H��m 
			}
		}
	}
}
int Redpossible(int a[],float r[]){//��X����Ҧ��i��� 
	FILE *possiblity=fopen("Redpossiblity.txt","w");//�M�ŰO�ƥ� 
	fclose(possiblity);
	int p;//
	float maxpoint=-1;
	int position[3]={0};
	for(p=92;p<392;p++){
		int ID,center;//block ID
		if(a[p]==2||a[p]==7||a[p]==-1){//�p�G�Ӯ�i�H�Q��m 
			for(ID=0;ID<91;ID++){//�qID0�}�l 
				int piece=IDtoLeft[ID];//��XID������� 
				if(left[piece]==0){//�ݬ��٦��S���� 
					if(piece==20){//�������S���F�A���X 
						break;
					}
					ID=IDcount[piece+1]-1;//�S���Ӥ���A���U�@��
					continue;
				}
				if(ID==0){
					float putable=Rable(a,r,p,ID,0);
					if(putable>0){
						RPP(ID,0,p);
						if(putable>maxpoint){
							position[0]=ID;
							position[1]=0;
							position[2]=p;
							maxpoint=putable;
						}
					}
				}
				else if(ID<3){
					int s;
					for(s=0;s<2;s++){
						int putable=Rable(a,r,p,ID,s);
						if(putable>0){
							RPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else if(ID<9){
					int s;
					for(s=0;s<3;s++){
						float putable=Rable(a,r,p,ID,s);
						if(putable>0){
							RPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else if(ID<28){
					int s;
					for(s=0;s<4;s++){
						float putable=Rable(a,r,p,ID,s);
						if(putable>0){
							RPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else{
					int s;
					for(s=0;s<5;s++){
						float putable=Rable(a,r,p,ID,s);
						if(putable>0){
							RPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
			}
			if(p%22==17){//��ѽL���ݡA���� 
				p+=8;
			}
			//printf("[]=%d,%d,%d,max=%d\n",position[0],position[1],position[2],maxpoint);
		}
	}
	if(maxpoint==-1){
		printf("endgame\n");
		return 0;	
	}
	//printf("Red possible steps:%d\n",solution);
	SPB(a,position[0],position[1],position[2],1);
	printf("max=%.3f\n",maxpoint);
	return 1;
}
int Bluepossible(int a[],float b[]){//�޿�PRedpossible�ߧP�_��_��m���ѼƤ��P 
	FILE *possiblity=fopen("Bluepossiblity.txt","w");//�M�ŰO�ƥ� 
	fclose(possiblity);
	int p;//
	float maxpoint=-1;
	int position[3]={0};
	for(p=92;p<392;p++){
		int ID,center;//block ID
		if(a[p]==5||a[p]==7||a[p]==-2){
			for(ID=0;ID<91;ID++){
				int piece=IDtoLeft[ID];
				if(left[piece]==0){
					if(piece==20){
						break;
					}
					ID=IDcount[piece+1]-1;
					continue;
				}
				if(ID==0){
					float putable=Bable(a,b,p,ID,0);
					if(putable>0){
						BPP(ID,0,p);
						if(putable>maxpoint){
							position[0]=ID;
							position[1]=0;
							position[2]=p;
							maxpoint=putable;
						}
					}
				}
				else if(ID<3){
					int s;
					for(s=0;s<2;s++){
						float putable=Bable(a,b,p,ID,s);
						if(putable>0){
							BPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else if(ID<9){
					int s;
					for(s=0;s<3;s++){
						float putable=Bable(a,b,p,ID,s);
						if(putable>0){
							BPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else if(ID<28){
					int s;
					for(s=0;s<4;s++){
						float putable=Bable(a,b,p,ID,s);
						if(putable>0){
							BPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
				else{
					int s;
					for(s=0;s<5;s++){
						float putable=Bable(a,b,p,ID,s);
						if(putable>0){
							BPP(ID,s,p);
							if(putable>maxpoint){
								position[0]=ID;
								position[1]=s;
								position[2]=p;
								maxpoint=putable;
							}
						}
					}
				}
			}
		}
		if(p%22==17){//��ѽL���ݡA���� 
			p+=8;
		}
	}
	if(maxpoint==-1){
		printf("endgame\n");
		return 0;	
	}
	SPB(a,position[0],position[1],position[2],4);
	printf("max=%.3f\n",maxpoint);
	return 1;
}
void RPP(int a,int b,int c){//(red)print posiblity//�b��mc�W����b���Wa��
	FILE *possiblity=fopen("Redpossiblity.txt","a");
	fprintf(possiblity,"%d",a);
	fprintf(possiblity," %d",b);
	fprintf(possiblity," %d\n",c);
	fclose(possiblity);
}
void BPP(int a,int b,int c){//(Blue)print posiblity//�b��mc�W����b���Wa��
	FILE *possiblity=fopen("Bluepossiblity.txt","a");
	fprintf(possiblity,"%d",a);
	fprintf(possiblity," %d",b);
	fprintf(possiblity," %d\n",c);
	fclose(possiblity);
}
void recenter(int block[],int c){//�HC�欰0�A�p��block[]���U�Ѽƪ��۹�t�� 
	int re=block[c];//�Ȧs
	block[0]-=re;
	block[1]-=re;
	block[2]-=re;
	block[3]-=re;
	block[4]-=re;
}
void printleft(int a[]){//�L�X�Ѿl��� 
	int i=0;
	for(i=0;i<21;i++){
		printf("%d,",a[i]);
	}
}
void updatelefttxt(int a[],char lef[]){//�L�X�Ѿl�����txt 
	FILE *leftpatten=fopen(lef,"a+");
	int i,p=0;
	char str[44]={'['};
	//str[0]='[';
	for(i=1;i<42;i++){
		str[i]=left[p]+'0';
		p++;
		i++;
		str[i]=',';
	}
	str[42]=']';
	fputs("\n",leftpatten);
	fputs(str,leftpatten);
}
void updateboardtxt(int a[],char stat[]){//�L�X�ѽL���A��txt 
	FILE *status=fopen(stat,"w");
	int i,p=0;
	//char str[27];
	for(i=92;i<392;i++){
		if(p!=0||i==92){
			if(a[i]==1){
				fputs("R",status);
			}
			else if(a[i]==4){
				fputs("B",status);
			}
			else{
				fputs("N",status);;
			}
			p++;
			if(p==27){
				p=0;
				i+=8;
				continue;
			}
			fputs(",",status);
			p++;
		}
		if(p==0&&i!=400){
			if(i!=92){
				fputs("\n",status);
			} 
			if(a[i]==1){
				fputs("R",status);
			}
			else if(a[i]==4){
				fputs("B",status);
			}
			else{
				fputs("N",status);
			}
			p++;
			fputs(",",status);
			p++;
		}
	}
//puts(str,status);
	fclose(status);
}
void SPB(int a[],int p,int q,int r,int c){//Red Read Possibiltiy//��ک�m 
	int i=0;
	int place[3]={p,q,r};
	int block[5]={0};
	printf("%d,%d,%d",place[0],place[1],place[2]);
	if(place[0]==0){//�u��@�� 
		a[place[2]]=c;
		left[0]=0;
		return;
	}
	if(place[0]<3){//���� 
		int write;
		for(write=0;write<2;write++){//�g�JID�������T 
			block[write]=Two[2*place[0]-2+write];
		}
		recenter(block,place[1]);//���s�w�� 
		for(i=0;i<2;i++){//��m 
			a[place[2]+block[i]]=c;
		}
	}
	else if(place[0]<9){//��T�� 
		int write;
		for(write=0;write<3;write++){//�g�JID�������T 
			block[write]=Three[3*place[0]-9+write];
		}
		recenter(block,place[1]);//���s�w��
		for(i=0;i<3;i++){
			a[place[2]+block[i]]=c;//��m
		}
	}
	else if(place[0]<28){//��|�� 
		int write;
		for(write=0;write<4;write++){//�g�JID�������T 
			block[write]=Four[4*place[0]-36+write];
		}
		recenter(block,place[1]);//���s�w��
		for(i=0;i<4;i++){
			a[place[2]+block[i]]=c;//��m
		}
	}
	else {//�񤭭� 
		int write;
		for(write=0;write<5;write++){//�g�JID�������T 
			block[write]=Five[5*place[0]-140+write];
		}
		recenter(block,place[1]);//���s�w��
		for(i=0;i<5;i++){
			a[place[2]+block[i]]=c;//��m
		}
	}
	left[IDtoLeft[place[0]]]=0;
}
void scanarea(int a[],int area[],float rinfo[],float binfo[],int i,int pos,int color){//a����l�L�� i���y����
	if(pos<392&&pos>91&&pos%22>3&&pos%22<18){//4<pos%22<18���ѽL�d��
		if(area[i]==0){
			area[pos]=i;
			if(area[pos+1]==0){//�ˬd�k��
				scanarea(a,area,rinfo,binfo,i,pos+1,color);
			}
			if(area[pos-22]==0){//�ˬd�W��
				scanarea(a,area,rinfo,binfo,i,pos-22,color);
			}
			if(area[pos+22]==0){//�ˬd�U��
				scanarea(a,area,rinfo,binfo,i,pos+22,color);
			}
			if(area[pos-1]==0){//�ˬd����
				scanarea(a,area,rinfo,binfo,i,pos-1,color);
			}
			if(color==1){
				//printf("pos=%d,%d+1,++%.2f\n",pos,i,redpoint[a[pos]+2]);
				rinfo[i-1]+=redpoint[a[pos]+2];
				rinfo[i]++;
			}
			if(color==2){
				binfo[i-1]+=bluepoint[a[pos]+2];
				binfo[i]++;
			}
		}	
	}
}
