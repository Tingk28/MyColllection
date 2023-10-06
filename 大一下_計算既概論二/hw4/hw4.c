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
int left[21];//剩餘方塊 
int IDcount[21]={0,1,3,7,9,10,18,22,26,28,36,40,44,48,52,56,64,65,73,81,89};//每種方塊開始的編號數
int IDtoLeft[91]={0,1,1,2,2,2,2,3,3,4,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,8,8,9,9,9,9,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14,15,15,15,15,15,15,15,15,16,17,17,17,17,17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,20,20};//方塊ID跟實際某方塊的對照表 
//1,2,4,2,1,8,4,4,2,8,4,4,4,4,4,8,1,8,8,8,2
int Two[4]={0,1,0,22};//面積為1-2的方塊的形狀（詳見document）;
int Three[18]={0,-1,22,0,-22,-1,0,-22,1,0,1,22,0,-1,1,0,-22,22};//面積=3 
int Four[76]={0,1,22,23,0,-1,1,21,0,-23,-22,22,0,-21,-1,1,0,-22,22,23,0,-23,-1,1,0,-22,-21,22,0,-1,1,23,0,-22,21,22,0,-1,1,22,0,-22,-1,22,0,-22,-1,1,0,-22,1,22,0,-1,22,23,0,-22,-1,21,0,-22,-21,-1,0,-22,1,23,0,-1,1,2,0,-22,22,44}; //面積=4 
int Five[315]={0,-1,1,21,22,0,-23,-22,-1,22,0,-22,-21,-1,1,0,-22,1,22,23,0,-23,-22,-1,1,0,-22,-21,1,22,0,-1,1,22,23,0,-22,-1,21,22,0,-1,1,21,23,0,-23,-22,21,22,0,-23,-21,-1,1,0,-22,-21,22,23,0,-1,1,22,44,0,-22,-2,-1,22,0,-44,-22,-1,1,0,-22,1,2,22,0,-1,1,21,43,0,-24,-23,-22,22,0,-43,-21,-1,1,0,-22,22,23,24,0,-23,-22,1,23,0,-21,1,21,22,0,-23,-1,22,23,0,-22,-21,-1,21,0,-23,-1,1,23,0,-22,-21,21,22,0,-21,-1,1,21,0,-23,-22,22,23,0,-23,-1,1,22,0,-22,-21,-1,22,0,-22,-1,1,23,0,-22,1,21,22,0,-22,-1,1,21,0,-23,-22,1,22,0,-21,-1,1,22,0,-22,-1,22,23,0,-22,-1,1,22,0,-1,1,2,21,0,-23,-22,22,44,0,-21,-2,-1,1,0,-44,-22,22,23,0,-23,-1,1,2,0,-22,-21,22,44,0,-2,-1,1,23,0,-44,-22,21,22,0,-2,-1,22,23,0,-44,-22,-1,21,0,-1,22,23,24,0,-21,1,22,44,0,-22,-21,-2,-1,0,-44,-22,1,23,0,1,2,21,22,0,-23,-1,22,44,0,-1,1,2,22,0,-22,-1,22,44,0,-22,-2,-1,1,0,-44,-22,1,22,0,-22,-1,1,2,0,-22,1,22,44,0,-2,-1,1,22,0,-44,-22,-1,22,0,-2,-1,1,2,0,-44,-22,22,44};//面積=5 
float redpoint[]={0,0.5,1,0,0.5,0,0,1.25,1,2,0};//配分
float bluepoint[]={0.5,0,1,0,1.25,1,0,0.5,0,2,0};
int rcross[100]={0};
int bcross[100]={0};
int color=0;//當前顏色 
int main(int argc,char* argv[]){
	clock_t start,end;
	start=clock();
	int board [484]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,2,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,5,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,};
	float rboard[484]={0};
	float bboard[484]={0};
	float redareainfo[120]={0};
	float blueareainfo[120]={0};
	int area[484]={0};
	color=decidecolor(argv[1]);//紅1藍2
	update(board,argv[2],area);//讀取盤面 
	updateleft(left,argv[3]);//讀取剩餘
	scan(board);//為盤面打分（詳見document）
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
	if(color==1){//紅色 
		int a=1;//總可能下一步數量 
		a=Redpossible(board,rboard);//評估共有多少可能 
		if(a==0){
			return 1;
		}
	}
	else{//藍色 
		int b;//總可能下一步數量 
		b=Bluepossible(board,bboard);//評估共有多少可能 
		if(b==0){
			return 1;
		}
	}
	numoutput(board);//輸出盤面資料（分析用) 
	updateboardtxt(board,argv[2]);//更新棋盤資料 
	updatelefttxt(left,argv[3]);//更新剩餘 
	//print(area);
	//numoutput(board);
	print(board);
	return 0;
}
void scan (int a[]){//掃描 
	int i=92;//從棋盤左上開始搜尋 
	int xb,xr,r,b;
	while(i<392){
		if(a[i]!=1&&a[i]!=4&&a[i]!=8){
			xb=0,xr=0,r=0,b=0;
			if(a[i-21]==1||a[i-23]==1||a[i+21]==1||a[i+23]==1){xr=1;}// 斜角有無紅色 
			if(a[i-21]==4||a[i-23]==4||a[i+21]==4||a[i+23]==4){xb=1;}// 斜角有無藍色 
			if(a[i-22]==1||a[i-1]==1||a[i+1]==1||a[i+22]==1){r=1;}// 邊邊有紅色 
			if(a[i-22]==4||a[i-1]==4||a[i+1]==4||a[i+22]==4){b=1;}// 邊邊有藍色
			if(xb==1&&r==1&&b==0){a[i]=-2;}//依據對應的狀況給予分數 
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
void print (int a[]){//印出數字棋盤 
	int i,p;/*完整棋盤 
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
	for(i=92;i<392;i++){//單純印出14*14 
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
void floatboardprint(float a[]){//印出數字棋盤 
	int i,p;/*完整棋盤 
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
	for(i=92;i<392;i++){//單純印出14*14 
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
void update(int a[],char stat[],int area[]){//讀取棋盤狀態 
	FILE *status=fopen(stat,"r");
	char str[27];
	int line=0;
	while(fscanf(status,"%s",str)==1){
		int i=0;
		for(i=0;i<27;i+=2){
			if(str[i]=='R'){//該格為紅色 
				a[92+22*line+i/2]=1;
				area[92+22*line+i/2]=-1;
			}
			else if(str[i]=='B'){//該格為藍色 
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
void updateleft(int a[],char lef[]){//更新剩餘方塊 
	FILE *leftpatten=fopen(lef,"r");
	char str[45];
	int u,v=0;//for for loop
	while(fscanf(leftpatten,"%s",str)==1){
	}
	for(u=1;u<43;u+=2){//讀取 
		left[v]=atoi(&str[u]);//char轉int 
		v++;
	}
	fclose(leftpatten);
}
int decidecolor(char Color[]){//讀取顏色 
	if(Color[0]=='R'){
		return 1;
	}
	return 2;
}
void numoutput (int a[]){//印出數字型態的陣列 
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
void numoutput2 (int a[]){//印出數字型態的陣列 
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
void numoutput3 (float a[],char f[]){//印出數字型態的陣列 
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
void printfloat(float a[]){//印出浮點陣列
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
	if(ID==0){//面積=1 的方塊 ，直接放置
		return r[p]+1;//可以放置
	}
	else if (ID<3){//面積<2 
		int write;
		for(write=0;write<2;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Two[2*ID-2+write];
		}
		recenter(block,shift);//偏移shift位後block[]
		int now;
		for(now=0;now<2;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==1){//則放置 
				point+=2;
				return point;//可以放置 
			}
		}
	}
	else if(ID<9){//面積=3 
		int write;
		for(write=0;write<3;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Three[3*ID-9+write];
		}
		recenter(block,shift);
		int now;
		for(now=0;now<3;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==2){ 
				point+=3;
				return point;//可以放置 
			}
		}
	}
	else if(ID<28){//面積=4 
		int write;
		for(write=0;write<4;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Four[4*ID-36+write];
		}
		recenter(block,shift);
		int now;	
		for(now=0;now<4;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=r[p+block[now]];	
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){					
				return -1;
			}
			else if(now==3){//則放置 
				point+=4;
				return point;
			}
		}
	}
	else{//面積=5 
		int write;
		for(write=0;write<5;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Five[5*ID-140+write];
		} 
		recenter(block,shift);
		int now;
		for(now=0;now<5;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=r[p+block[now]];
			if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;//不能放
			}
			else if(now==4){//則放置 
				point+=5;
				return point;//可以放置 
			}
		}
	}
}
float Bable(int a[],float b[],int p,int ID,int shift){
	int block[5]={0};
	float point=0;
	if(ID==0){//面積=1 的方塊 ，直接放置
		return b[p]+1;//可以放置
	}
	else if (ID<3){//面積<2 
		int write;
		for(write=0;write<2;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Two[2*ID-2+write];
		}
		recenter(block,shift);//偏移shift位後block[]
		int now;
		for(now=0;now<2;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==1){//則放置 
				point+=2;
				return point;//可以放置 
			}
		}
	}
	else if(ID<9){//面積=3 
		int write;
		for(write=0;write<3;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Three[3*ID-9+write];
		}
		recenter(block,shift);
		int now;
		for(now=0;now<3;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;
			}
			else if(now==2){ 
				point+=3;
				return point;//可以放置 
			}
		}
	}
	else if(ID<28){//面積=4 
		int write;
		for(write=0;write<4;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Four[4*ID-36+write];
		}
		recenter(block,shift);
		int now;		
		for(now=0;now<4;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){					
				return -1;
			}
			else if(now==3){//則放置 
				point+=4;
				return point;
			}
		}
	}
	else{//面積=5 
		int write;
		for(write=0;write<5;write++){//把該ID方塊資訊寫入block[] 
			block[write]=Five[5*ID-140+write];
		} 
		recenter(block,shift);
		int now;
		for(now=0;now<5;now++){//如果該block的每個方塊都可以被放到棋盤上 
			point+=b[p+block[now]];
			if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
				return -1;//不能放
			}
			else if(now==4){//則放置 
				point+=5;
				return point;//可以放置 
			}
		}
	}
}
int Redpossible(int a[],float r[]){//輸出紅色所有可能性 
	FILE *possiblity=fopen("Redpossiblity.txt","w");//清空記事本 
	fclose(possiblity);
	int p;//
	float maxpoint=-1;
	int position[3]={0};
	for(p=92;p<392;p++){
		int ID,center;//block ID
		if(a[p]==2||a[p]==7||a[p]==-1){//如果該格可以被放置 
			for(ID=0;ID<91;ID++){//從ID0開始 
				int piece=IDtoLeft[ID];//找出ID對應方塊 
				if(left[piece]==0){//看看還有沒有剩 
					if(piece==20){//全部都沒有了，跳出 
						break;
					}
					ID=IDcount[piece+1]-1;//沒有該方塊，換下一個
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
			if(p%22==17){//到棋盤末端，換行 
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
int Bluepossible(int a[],float b[]){//邏輯同Redpossible唯判斷能否放置的參數不同 
	FILE *possiblity=fopen("Bluepossiblity.txt","w");//清空記事本 
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
		if(p%22==17){//到棋盤末端，換行 
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
void RPP(int a,int b,int c){//(red)print posiblity//在位置c上偏移b格放上a號
	FILE *possiblity=fopen("Redpossiblity.txt","a");
	fprintf(possiblity,"%d",a);
	fprintf(possiblity," %d",b);
	fprintf(possiblity," %d\n",c);
	fclose(possiblity);
}
void BPP(int a,int b,int c){//(Blue)print posiblity//在位置c上偏移b格放上a號
	FILE *possiblity=fopen("Bluepossiblity.txt","a");
	fprintf(possiblity,"%d",a);
	fprintf(possiblity," %d",b);
	fprintf(possiblity," %d\n",c);
	fclose(possiblity);
}
void recenter(int block[],int c){//以C格為0，計算block[]中各參數的相對差值 
	int re=block[c];//暫存
	block[0]-=re;
	block[1]-=re;
	block[2]-=re;
	block[3]-=re;
	block[4]-=re;
}
void printleft(int a[]){//印出剩餘方塊 
	int i=0;
	for(i=0;i<21;i++){
		printf("%d,",a[i]);
	}
}
void updatelefttxt(int a[],char lef[]){//印出剩餘方塊到txt 
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
void updateboardtxt(int a[],char stat[]){//印出棋盤狀態到txt 
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
void SPB(int a[],int p,int q,int r,int c){//Red Read Possibiltiy//實際放置 
	int i=0;
	int place[3]={p,q,r};
	int block[5]={0};
	printf("%d,%d,%d",place[0],place[1],place[2]);
	if(place[0]==0){//只放一個 
		a[place[2]]=c;
		left[0]=0;
		return;
	}
	if(place[0]<3){//放兩個 
		int write;
		for(write=0;write<2;write++){//寫入ID的方塊資訊 
			block[write]=Two[2*place[0]-2+write];
		}
		recenter(block,place[1]);//重新定位 
		for(i=0;i<2;i++){//放置 
			a[place[2]+block[i]]=c;
		}
	}
	else if(place[0]<9){//放三個 
		int write;
		for(write=0;write<3;write++){//寫入ID的方塊資訊 
			block[write]=Three[3*place[0]-9+write];
		}
		recenter(block,place[1]);//重新定位
		for(i=0;i<3;i++){
			a[place[2]+block[i]]=c;//放置
		}
	}
	else if(place[0]<28){//放四個 
		int write;
		for(write=0;write<4;write++){//寫入ID的方塊資訊 
			block[write]=Four[4*place[0]-36+write];
		}
		recenter(block,place[1]);//重新定位
		for(i=0;i<4;i++){
			a[place[2]+block[i]]=c;//放置
		}
	}
	else {//放五個 
		int write;
		for(write=0;write<5;write++){//寫入ID的方塊資訊 
			block[write]=Five[5*place[0]-140+write];
		}
		recenter(block,place[1]);//重新定位
		for(i=0;i<5;i++){
			a[place[2]+block[i]]=c;//放置
		}
	}
	left[IDtoLeft[place[0]]]=0;
}
void scanarea(int a[],int area[],float rinfo[],float binfo[],int i,int pos,int color){//a為原始盤面 i為流水號
	if(pos<392&&pos>91&&pos%22>3&&pos%22<18){//4<pos%22<18為棋盤範圍
		if(area[i]==0){
			area[pos]=i;
			if(area[pos+1]==0){//檢查右邊
				scanarea(a,area,rinfo,binfo,i,pos+1,color);
			}
			if(area[pos-22]==0){//檢查上邊
				scanarea(a,area,rinfo,binfo,i,pos-22,color);
			}
			if(area[pos+22]==0){//檢查下邊
				scanarea(a,area,rinfo,binfo,i,pos+22,color);
			}
			if(area[pos-1]==0){//檢查左邊
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
