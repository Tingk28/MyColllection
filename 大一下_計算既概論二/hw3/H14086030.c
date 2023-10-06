#include<stdio.h>
#include<time.h> 
#include <stdlib.h> 
void print (int a[]);
void scan(int a[]);
void update(int a[],char stat[]);
void numoutput(int a[]);
int Redpossible(int a[]);
int Bluepossible(int a[]);
void RPP(int a,int b,int c);
void BPP(int a,int b,int c);
void recenter(int block[],int c);
void updateleft(int a[],char left[]);
void printleft(int a[]);
void updatelefttxt(int a[],char lef[]);
void updateboardtxt(int a[],char stat[]);
void RRP(int a[],int n);
void BRP(int a[],int n);
int decidecolor(char Color[]);
//int head=184;
int left[21];//剩餘方塊 
int IDcount[21]={0,1,3,7,9,10,18,22,26,28,36,40,44,48,52,56,64,65,73,81,89};//每種方塊開始的編號數
int IDtoLeft[91]={0,1,1,2,2,2,2,3,3,4,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,8,8,9,9,9,9,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14,15,15,15,15,15,15,15,15,16,17,17,17,17,17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,20,20};//方塊ID跟實際某方塊的對照表 
//1,2,4,2,1,8,4,4,2,8,4,4,4,4,4,8,1,8,8,8,2
int Two[4]={0,1,0,22};//面積為1-2的方塊的形狀（詳見document）;
int Three[18]={0,-1,22,0,-22,-1,0,-22,1,0,1,22,0,-1,1,0,-22,22};//面積=3 
int Four[76]={0,1,22,23,0,-1,1,21,0,-23,-22,22,0,-21,-1,1,0,-22,22,23,0,-23,-1,1,0,-22,-21,22,0,-1,1,23,0,-22,21,22,0,-1,1,22,0,-22,-1,22,0,-22,-1,1,0,-22,1,22,0,-1,22,23,0,-22,-1,21,0,-22,-21,-1,0,-22,1,23,0,-1,1,2,0,-22,22,44}; //面積=4 
int Five[315]={0,-1,1,21,22,0,-23,-22,-1,22,0,-22,-21,-1,1,0,-22,1,22,23,0,-23,-22,-1,1,0,-22,-21,1,22,0,-1,1,22,23,0,-22,-1,21,22,0,-1,1,21,23,0,-23,-22,21,22,0,-23,-21,-1,1,0,-22,-21,22,23,0,-1,1,22,44,0,-22,-2,-1,22,0,-44,-22,-1,1,0,-22,1,2,22,0,-1,1,21,43,0,-24,-23,-22,22,0,-43,-21,-1,1,0,-22,22,23,24,0,-23,-22,1,23,0,-21,1,21,22,0,-23,-1,22,23,0,-22,-21,-1,21,0,-23,-1,1,23,0,-22,-21,21,22,0,-21,-1,1,21,0,-23,-22,22,23,0,-23,-1,1,22,0,-22,-21,-1,22,0,-22,-1,1,23,0,-22,1,21,22,0,-22,-1,1,21,0,-23,-22,1,22,0,-21,-1,1,22,0,-22,-1,22,23,0,-22,-1,1,22,0,-1,1,2,21,0,-23,-22,22,44,0,-21,-2,-1,1,0,-44,-22,22,23,0,-23,-1,1,2,0,-22,-21,22,44,0,-2,-1,1,23,0,-44,-22,21,22,0,-2,-1,22,23,0,-44,-22,-1,21,0,-1,22,23,24,0,-21,1,22,44,0,-22,-21,-2,-1,0,-44,-22,1,23,0,1,2,21,22,0,-23,-1,22,44,0,-1,1,2,22,0,-22,-1,22,44,0,-22,-2,-1,1,0,-44,-22,1,22,0,-22,-1,1,2,0,-22,1,22,44,0,-2,-1,1,22,0,-44,-22,-1,22,0,-2,-1,1,2,0,-44,-22,22,44};//面積=5 
int color=0;//當前顏色 
int main(int argc,char* argv[]){
	clock_t start,end;
	start=clock();
	int board [484]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,2,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,5,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,};
	color=decidecolor(argv[1]);
	update(board,argv[2]);//讀取盤面 
//	printf("%s",argv[3]);
	updateleft(left,argv[3]);//讀取剩餘 
	scan(board);//為盤面打分（詳見document） 
//	print(board);
	if(color==1){//紅色 
		int a=1;//總可能下一步數量 
		a=Redpossible(board);//評估共有多少可能 
		if(a>0){//如果仍有下一步 
			RRP(board,a);//放置掃描後的最後一個可能性 
		}
		else{//pass 
			return 1;
		}
	}
	else{//藍色 
		int a;//總可能下一步數量 
		a=Bluepossible(board);//評估共有多少可能 
		if(a>0){//如果仍有下一步 
			BRP(board,a);//放置掃描後的最後一個可能性 
		}
		else{//pass 
			return 1;
		}
		
	}
//	numoutput(board);//輸出盤面資料（分析用) 
	updateboardtxt(board,argv[2]);//更新棋盤資料 
	updatelefttxt(left,argv[3]);//更新剩餘 
	//end=clock();
	///printf("\n%f",(float)(end-start)/CLOCKS_PER_SEC);
	return 1;
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
void update(int a[],char stat[]){//讀取棋盤狀態 
	FILE *status=fopen(stat,"r");
	char str[27];
	int line=0;
	while(fscanf(status,"%s",str)==1){
		int i=0;
		for(i=0;i<27;i+=2){
			if(str[i]=='R'){//該格為紅色 
				a[92+22*line+i/2]=1;
			}
			else if(str[i]=='B'){//該格為藍色 
				a[92+22*line+i/2]=4;
			}
		}
		line++;
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
int Redpossible(int a[]){//輸出紅色所有可能性 
	FILE *possiblity=fopen("Redpossiblity.txt","w");//清空記事本 
	fclose(possiblity);
	int p;//
	int solution=0;
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
				int block[5]={0};
				if(ID==0){//面積=1 的方塊 ，直接放置 
					RPP(ID,0,p);//在位置P上偏移0格放上0(ID)號 
					solution++;//總解法+1
				}
				else if (ID<3){//面積<2 
					int write;
					for(write=0;write<2;write++){//把該ID方塊資訊寫入block[] 
						block[write]=Two[2*ID-2+write];
					}
					for(center=0;center<2;center++){//平移搜尋 
						recenter(block,center);//重新改寫偏移後block[]
						int now;
						for(now=0;now<2;now++){//如果該block的每個方塊都可以被放到棋盤上 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==1){//則放置 
								RPP(ID,center,p);//在位置P上偏移center格放上ID號 
								solution++;//總解法+1 
							}
						}
					}
					
				}
				else if(ID<9){//面積=3 
					int write;
					for(write=0;write<3;write++){//把該ID方塊資訊寫入block[] 
						block[write]=Three[3*ID-9+write];
					}
					for(center=0;center<3;center++){//平移搜尋 
						recenter(block,center);
						int now;
						for(now=0;now<3;now++){//如果該block的每個方塊都可以被放到棋盤上 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==2){//則放置 
								RPP(ID,center,p);//在位置P上偏移center格放上ID號
								solution++;//總解法+1 
							}
						}
					}
				}
				else if(ID<28){//面積=4 
					int write;
					for(write=0;write<4;write++){//把該ID方塊資訊寫入block[] 
						block[write]=Four[4*ID-36+write];
					}
					for(center=0;center<4;center++){//平移搜尋 
						recenter(block,center);
						int now;
						for(now=0;now<4;now++){//如果該block的每個方塊都可以被放到棋盤上 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==3){//則放置 
								RPP(ID,center,p);//在位置P上偏移center格放上ID號
								solution++;//總解法+1 
							}
						}
					}
				}
				else{//面積=5 
					int write;
					for(write=0;write<5;write++){//把該ID方塊資訊寫入block[] 
						block[write]=Five[5*ID-140+write];
					}
					for(center=0;center<5;center++){//平移搜尋 
						recenter(block,center);
						int now;
						for(now=0;now<5;now++){//如果該block的每個方塊都可以被放到棋盤上 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==4){//則放置 
								RPP(ID,center,p);//在位置P上偏移center格放上ID號
								solution++;//總解法+1 
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
	
	if(solution==0){
		printf("endgame\n");
		return solution;	
	}
	printf("Red possible steps:%d\n",solution);
	return solution;
}
int Bluepossible(int a[]){//邏輯同Redpossible唯判斷能否放置的參數不同 
	FILE *possiblity=fopen("Bluepossiblity.txt","w");//清空記事本 
	fclose(possiblity);
	int p;//
	int solution=0;
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
				int block[5]={0};
				if(ID==0){//面積=1 的方塊 
					BPP(ID,0,p);
					solution++;
				}
				else if (ID<3){
					int write;
					for(write=0;write<2;write++){
						block[write]=Two[2*ID-2+write];
					}
					for(center=0;center<2;center++){
						recenter(block,center);
						int now;
						for(now=0;now<2;now++){
							if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==1){
								BPP(ID,center,p);
								solution++;
							}
						}
					}
					
				}
				else if(ID<9){//面積=3 
					int write;
					for(write=0;write<3;write++){
						block[write]=Three[3*ID-9+write];
					}
					for(center=0;center<3;center++){
						recenter(block,center);
						int now;
						for(now=0;now<3;now++){
							if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==2){
								BPP(ID,center,p);
								solution++;
							}
						}
					}
				}
				else if(ID<28){//面積=4 
					int write;
					for(write=0;write<4;write++){
						block[write]=Four[4*ID-36+write];
					}
					for(center=0;center<4;center++){
						recenter(block,center);
						int now;
						for(now=0;now<4;now++){
							if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==3){
								BPP(ID,center,p);
								solution++;
							}
						}
					}
				}
				else{//面積=5 
					int write;
					for(write=0;write<5;write++){
						block[write]=Five[5*ID-140+write];
					}
					for(center=0;center<5;center++){
						recenter(block,center);
						int now;
						for(now=0;now<5;now++){
							if(a[p+block[now]]==-1||a[p+block[now]]==1||a[p+block[now]]==6||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==4){
								BPP(ID,center,p);
								solution++;
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
	
	if(solution==0){
		printf("endgame\n");
	}
	printf("Blue possible steps:%d\n",solution);
	return solution;
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
	char str[27];
	for(i=92;i<392;i++){
		if(p!=0||i==92){
			if(a[i]==1){
				str[p]='R';
			}
			else if(a[i]==4){
				str[p]='B';
			}
			else{
				str[p]='N';
			}
			p++;
			if(p==27){
				p=0;
				i+=8;
				continue;
			}
			str[p]=',';
			p++;
		}
		if(p==0&&i!=400){
			if(i!=92){
				fprintf(status,"%s\n",str);
			} 
			if(a[i]==1){
				str[p]='R';
			}
			else if(a[i]==4){
				str[p]='B';
			}
			else{
				str[p]='N';
			}
			p++;
			str[p]=',';
			p++;
		}
	}
	fprintf(status,"%s",str);
	fclose(status);
}
void RRP(int a[],int n){//Red Read Possibiltiy//實際放置 
	int c=1;
	FILE *Poss=fopen("Redpossiblity.txt","r");//打開存所有可能方法的檔案 
	int i=0;
	int place[3]={0,0,0};
	int block[5]={0};
	for(i=0;i<n;i++){//讀取數值轉成int 
		fscanf(Poss,"%d",&place[0]);
		fscanf(Poss,"%d",&place[1]);
		fscanf(Poss,"%d",&place[2]);
	}
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
void BRP(int a[],int n){//Bule Read Possibiltiy//同放紅色，僅參數不同 
	int c=4;
	FILE *Poss=fopen("Bluepossiblity.txt","r");;
	int i=0;
	int place[3]={0,0,0};
	int block[5]={0};
	for(i=0;i<n;i++){
		fscanf(Poss,"%d",&place[0]);
		fscanf(Poss,"%d",&place[1]);
		fscanf(Poss,"%d",&place[2]);
	}
	printf("%d,%d,%d",place[0],place[1],place[2]);
	if(place[0]==0){
		a[place[2]]=c;
		left[0]=0;
		return;
	}
	if(place[0]<3){
		int write;
		for(write=0;write<2;write++){
			block[write]=Two[2*place[0]-2+write];
		}
		recenter(block,place[1]);
		for(i=0;i<2;i++){
			a[place[2]+block[i]]=c;
		}
	}
	else if(place[0]<9){
		int write;
		for(write=0;write<3;write++){
			block[write]=Three[3*place[0]-9+write];
		}
		recenter(block,place[1]);
		for(i=0;i<3;i++){
			a[place[2]+block[i]]=c;
		}
		
	}
	else if(place[0]<28){
		int write;
		for(write=0;write<4;write++){
			block[write]=Four[4*place[0]-36+write];
		}
		recenter(block,place[1]);
		for(i=0;i<4;i++){
			a[place[2]+block[i]]=c;
		}
	}
	else {
		int write;
		for(write=0;write<5;write++){
			block[write]=Five[5*place[0]-140+write];
		}
		recenter(block,place[1]);
		for(i=0;i<5;i++){
			a[place[2]+block[i]]=c;
		}
	}
	left[IDtoLeft[place[0]]]=0;
}

