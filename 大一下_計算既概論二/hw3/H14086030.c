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
int left[21];//�Ѿl��� 
int IDcount[21]={0,1,3,7,9,10,18,22,26,28,36,40,44,48,52,56,64,65,73,81,89};//�C�ؤ���}�l���s����
int IDtoLeft[91]={0,1,1,2,2,2,2,3,3,4,5,5,5,5,5,5,5,5,6,6,6,6,7,7,7,7,8,8,9,9,9,9,9,9,9,9,10,10,10,10,11,11,11,11,12,12,12,12,13,13,13,13,14,14,14,14,15,15,15,15,15,15,15,15,16,17,17,17,17,17,17,17,17,18,18,18,18,18,18,18,18,19,19,19,19,19,19,19,19,20,20};//���ID���ڬY�������Ӫ� 
//1,2,4,2,1,8,4,4,2,8,4,4,4,4,4,8,1,8,8,8,2
int Two[4]={0,1,0,22};//���n��1-2��������Ϊ��]�Ԩ�document�^;
int Three[18]={0,-1,22,0,-22,-1,0,-22,1,0,1,22,0,-1,1,0,-22,22};//���n=3 
int Four[76]={0,1,22,23,0,-1,1,21,0,-23,-22,22,0,-21,-1,1,0,-22,22,23,0,-23,-1,1,0,-22,-21,22,0,-1,1,23,0,-22,21,22,0,-1,1,22,0,-22,-1,22,0,-22,-1,1,0,-22,1,22,0,-1,22,23,0,-22,-1,21,0,-22,-21,-1,0,-22,1,23,0,-1,1,2,0,-22,22,44}; //���n=4 
int Five[315]={0,-1,1,21,22,0,-23,-22,-1,22,0,-22,-21,-1,1,0,-22,1,22,23,0,-23,-22,-1,1,0,-22,-21,1,22,0,-1,1,22,23,0,-22,-1,21,22,0,-1,1,21,23,0,-23,-22,21,22,0,-23,-21,-1,1,0,-22,-21,22,23,0,-1,1,22,44,0,-22,-2,-1,22,0,-44,-22,-1,1,0,-22,1,2,22,0,-1,1,21,43,0,-24,-23,-22,22,0,-43,-21,-1,1,0,-22,22,23,24,0,-23,-22,1,23,0,-21,1,21,22,0,-23,-1,22,23,0,-22,-21,-1,21,0,-23,-1,1,23,0,-22,-21,21,22,0,-21,-1,1,21,0,-23,-22,22,23,0,-23,-1,1,22,0,-22,-21,-1,22,0,-22,-1,1,23,0,-22,1,21,22,0,-22,-1,1,21,0,-23,-22,1,22,0,-21,-1,1,22,0,-22,-1,22,23,0,-22,-1,1,22,0,-1,1,2,21,0,-23,-22,22,44,0,-21,-2,-1,1,0,-44,-22,22,23,0,-23,-1,1,2,0,-22,-21,22,44,0,-2,-1,1,23,0,-44,-22,21,22,0,-2,-1,22,23,0,-44,-22,-1,21,0,-1,22,23,24,0,-21,1,22,44,0,-22,-21,-2,-1,0,-44,-22,1,23,0,1,2,21,22,0,-23,-1,22,44,0,-1,1,2,22,0,-22,-1,22,44,0,-22,-2,-1,1,0,-44,-22,1,22,0,-22,-1,1,2,0,-22,1,22,44,0,-2,-1,1,22,0,-44,-22,-1,22,0,-2,-1,1,2,0,-44,-22,22,44};//���n=5 
int color=0;//��e�C�� 
int main(int argc,char* argv[]){
	clock_t start,end;
	start=clock();
	int board [484]={0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,2,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,5,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,8,0,0,0,0,0,0,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,8,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,0,};
	color=decidecolor(argv[1]);
	update(board,argv[2]);//Ū���L�� 
//	printf("%s",argv[3]);
	updateleft(left,argv[3]);//Ū���Ѿl 
	scan(board);//���L�������]�Ԩ�document�^ 
//	print(board);
	if(color==1){//���� 
		int a=1;//�`�i��U�@�B�ƶq 
		a=Redpossible(board);//�����@���h�֥i�� 
		if(a>0){//�p�G�����U�@�B 
			RRP(board,a);//��m���y�᪺�̫�@�ӥi��� 
		}
		else{//pass 
			return 1;
		}
	}
	else{//�Ŧ� 
		int a;//�`�i��U�@�B�ƶq 
		a=Bluepossible(board);//�����@���h�֥i�� 
		if(a>0){//�p�G�����U�@�B 
			BRP(board,a);//��m���y�᪺�̫�@�ӥi��� 
		}
		else{//pass 
			return 1;
		}
		
	}
//	numoutput(board);//��X�L����ơ]���R��) 
	updateboardtxt(board,argv[2]);//��s�ѽL��� 
	updatelefttxt(left,argv[3]);//��s�Ѿl 
	//end=clock();
	///printf("\n%f",(float)(end-start)/CLOCKS_PER_SEC);
	return 1;
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
void update(int a[],char stat[]){//Ū���ѽL���A 
	FILE *status=fopen(stat,"r");
	char str[27];
	int line=0;
	while(fscanf(status,"%s",str)==1){
		int i=0;
		for(i=0;i<27;i+=2){
			if(str[i]=='R'){//�Ӯ欰���� 
				a[92+22*line+i/2]=1;
			}
			else if(str[i]=='B'){//�Ӯ欰�Ŧ� 
				a[92+22*line+i/2]=4;
			}
		}
		line++;
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
int Redpossible(int a[]){//��X����Ҧ��i��� 
	FILE *possiblity=fopen("Redpossiblity.txt","w");//�M�ŰO�ƥ� 
	fclose(possiblity);
	int p;//
	int solution=0;
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
				int block[5]={0};
				if(ID==0){//���n=1 ����� �A������m 
					RPP(ID,0,p);//�b��mP�W����0���W0(ID)�� 
					solution++;//�`�Ѫk+1
				}
				else if (ID<3){//���n<2 
					int write;
					for(write=0;write<2;write++){//���ID�����T�g�Jblock[] 
						block[write]=Two[2*ID-2+write];
					}
					for(center=0;center<2;center++){//�����j�M 
						recenter(block,center);//���s��g������block[]
						int now;
						for(now=0;now<2;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==1){//�h��m 
								RPP(ID,center,p);//�b��mP�W����center���WID�� 
								solution++;//�`�Ѫk+1 
							}
						}
					}
					
				}
				else if(ID<9){//���n=3 
					int write;
					for(write=0;write<3;write++){//���ID�����T�g�Jblock[] 
						block[write]=Three[3*ID-9+write];
					}
					for(center=0;center<3;center++){//�����j�M 
						recenter(block,center);
						int now;
						for(now=0;now<3;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==2){//�h��m 
								RPP(ID,center,p);//�b��mP�W����center���WID��
								solution++;//�`�Ѫk+1 
							}
						}
					}
				}
				else if(ID<28){//���n=4 
					int write;
					for(write=0;write<4;write++){//���ID�����T�g�Jblock[] 
						block[write]=Four[4*ID-36+write];
					}
					for(center=0;center<4;center++){//�����j�M 
						recenter(block,center);
						int now;
						for(now=0;now<4;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==3){//�h��m 
								RPP(ID,center,p);//�b��mP�W����center���WID��
								solution++;//�`�Ѫk+1 
							}
						}
					}
				}
				else{//���n=5 
					int write;
					for(write=0;write<5;write++){//���ID�����T�g�Jblock[] 
						block[write]=Five[5*ID-140+write];
					}
					for(center=0;center<5;center++){//�����j�M 
						recenter(block,center);
						int now;
						for(now=0;now<5;now++){//�p�G��block���C�Ӥ�����i�H�Q���ѽL�W 
							if(a[p+block[now]]==-2||a[p+block[now]]==1||a[p+block[now]]==3||a[p+block[now]]==8||a[p+block[now]]==4){
								break;
							}
							else if(now==4){//�h��m 
								RPP(ID,center,p);//�b��mP�W����center���WID��
								solution++;//�`�Ѫk+1 
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
	
	if(solution==0){
		printf("endgame\n");
		return solution;	
	}
	printf("Red possible steps:%d\n",solution);
	return solution;
}
int Bluepossible(int a[]){//�޿�PRedpossible�ߧP�_��_��m���ѼƤ��P 
	FILE *possiblity=fopen("Bluepossiblity.txt","w");//�M�ŰO�ƥ� 
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
				if(ID==0){//���n=1 ����� 
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
				else if(ID<9){//���n=3 
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
				else if(ID<28){//���n=4 
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
				else{//���n=5 
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
		if(p%22==17){//��ѽL���ݡA���� 
			p+=8;
		}
	}
	
	if(solution==0){
		printf("endgame\n");
	}
	printf("Blue possible steps:%d\n",solution);
	return solution;
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
void RRP(int a[],int n){//Red Read Possibiltiy//��ک�m 
	int c=1;
	FILE *Poss=fopen("Redpossiblity.txt","r");//���}�s�Ҧ��i���k���ɮ� 
	int i=0;
	int place[3]={0,0,0};
	int block[5]={0};
	for(i=0;i<n;i++){//Ū���ƭ��নint 
		fscanf(Poss,"%d",&place[0]);
		fscanf(Poss,"%d",&place[1]);
		fscanf(Poss,"%d",&place[2]);
	}
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
void BRP(int a[],int n){//Bule Read Possibiltiy//�P�����A�ȰѼƤ��P 
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

