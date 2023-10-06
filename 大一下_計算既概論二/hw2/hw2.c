#include<stdio.h>
#include<string.h>
int main(void){
	int len [8][5]={{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0},{0,0,0,0,0}} ;//課名長度清單
	char weekday[]="12345";
	char classname [2000]=" ";//course name list
	int cmd=0;//command
	int longest=1;//the longest course name(for the format while print out)
	while(cmd!=4){
		int space,I;
		int line=2;//the lenth of the "=" line
		printf("\n");
		printf(" |");
		for (I=0;I<5;I++){//print out "Mon. ~ Fri." 
			for (space=0;space<longest-1;space++){
				printf(" ");
				line++;
			}
			printf("%c|",weekday[I]);
			line+=2;
		}
		/*for (space=0;space<longest;space++){
				printf("-");
			}*/  
		printf("\n");
		for(I=0;I<line;I++){//print the =======line
			printf("=");
		}
		printf("\n");
		for (I=0;I<8;I++){//print the table
			printf("%d",I+1);//class 1-8
			int b,c;
				for(b=0;b<5;b++){//print the space
					printf("|");
					for (space=0;space<longest-len[I][b];space++){
						printf(" ");
					}
					if(len[I][b]!=0){//course name
						for (space=0;space<len[I][b];space++){
							int c=250*I+50*b+space;
							printf("%c",classname[c]);
						}
					}
				}
			printf("|\n");
			for(c=0;c<line;c++){//print the =======line
				printf("=");
			}
			printf("\n");
		}
		printf("Enter the command(1-4):");
		scanf("%d", &cmd);
		if(cmd==1){//add
			char str[100];
			int i=0;//day
			int j=0;//period 
			printf("Enter the course name:");
			while(1==1){
				scanf("\n");
				gets(str);//input the name
				if(strlen(str)>50){
				printf("The course name is too long please enter again(<50 char).");
				}
				else{
					break;
				}
			}
			printf("coures name is:%s\n",str);
			printf("lenth:%d\n",strlen(str));
			while(1==1){
				int i=0;//day 
				int j=0;//period 
				while(i<1||i>5){//input day
					printf("The day of the course(1-5):");
					scanf("%d",&i);
					if(i<1||i>5){
						printf("The day isn't correct(must be 1-5 int.)\n");
					}
				}
				while(j<1||j>8){//input period
					printf("The period of the course(1-8):");
					scanf("%d",&j);
					if(j<1||j>8){
						printf("The period isn't correct(must be 1-8 int.)\n");
					}
				}
				if(len[j-1][i-1]==0){//check if any conflict
					len[j-1][i-1]=strlen(str);
					int temp=0;//a temperary varible for inputting the char
					if(strlen(str)>longest){
						longest=strlen(str);
					}
					for(temp=0;temp<len[j-1][i-1];temp++){//input the courese name in classname array
						int n=temp+250*j+50*i-300;//cal calculate the position of the data 
						classname[n]=str[temp];//write in the data
					}
					break;
				}
				else{
					printf("The time you've enter already had courses please check agian.'\n");
					continue;
				}
			}
		}
		else if(cmd==2){//del
			char str[100];
			int i=0;//day
			int j=0;//period
			int del=0;
			printf("Enter the course you want to delete:");
			scanf("\n");
			gets(str);//input the name
			if(strlen(str)>50){
				printf("The course name is too long please enter again(<50 char).");
				continue;
			}
			for(i=0;i<5;i++){// compare every data in classname array
				for(j=0;j<8;j++){
					if(len[j][i]==strlen(str)){//if having same lenth
						int temp;
						int n=250*j+50*i;
						for(temp=0;temp<strlen(str);temp++){//compare the course name
							if(classname[temp+n]!=str[temp]){
								break;
							}
							else if(classname[temp+n]==str[temp]&&temp==strlen(str)-1){//course name is totally the same
								len[j][i]=0;
								for(temp=0;temp<strlen(str);temp++){//re-initialize the array
									classname[temp+n]='\0';
								}
								del=1;
								printf("====================\n");
								printf("Removed Successfully\nday:%d\nperiods:%d\nname:%s\n",i+1,j+1,str);
								printf("====================\n");
							}
						}
					}
				}
			}
			if(del==1){//had delete the data
				int b1,b2,big;
				if(strlen(str)==longest){//the lenth equal the longest course
					big=1;
					for(b1=0;b1<5;b1++){//update the "longest" variable
						for(b2=0;b2<8;b2++){
							if(len[b2][b1]>big){
								big=len[b2][b1];
							}
						}
					}
				longest=big;
				}
			}
			else if(del==0){
				printf("can't find the course you entered.\nPlease check again\n");
			}
		}
		else if(cmd==3){//edit
			int changed=0;//an int use as a boolean
			int i=0;//day 
			int j=0;//period  
			printf("Edit mode\n");
			while(1==1){
				printf("enter 1 for deleting specific classes or enter 2 to change the course name:");	
				scanf("%d", &cmd);
				if(cmd==1){
					while(i<1||i>5){//input day
						printf("The day of the course(1-5):");
						scanf("%d",&i);
						if(i<1||i>5){
							printf("The day isn't correct(must be 1-5 int.)\n");
						}
					}
					while(j<1||j>8){//input period
						printf("The period of the course(1-8):");
						scanf("%d",&j);
						if(j<1||j>8){
							printf("The period isn't correct(must be 1-8 int.)\n");
						}
					}
					if(len[j-1][i-1]==0){//there is no course
						printf("The period you want to delete is empty\n");
						break;
					}
					if(len[j-1][i-1]!=0){//there is a course
						int n=250*j+50*i-300;
						int temp;
						for(temp=0;temp<len[j-1][i-1];temp++){//delete the course
							classname[temp+n]='\0';
						}
						len[j-1][i-1]=0;
						printf("====================\n");
						printf("Removed Successfully\nday:%d\nperiods:%d\n",i,j);
						printf("====================\n");
						changed=1;
					}
				}
				else if(cmd==2){
					char before[100];
					char after[100];
					while(1==1){//enter before
						printf("Enter the course name you want to chage\n");
						scanf("\n");
						gets(before);
						if(strlen(before)<50){
							break;
						}
						printf("The course name is too long please enter again(<50 char).");
					}
					while(1==1){//enter after
						printf("Enter the course name after chaged\n");
						gets(after);
						if(strlen(after)<50){
							break;
						}
						printf("The course name is too long please enter again(<50 char).");
					}
					int a1;
					if(strlen(before)==strlen(after)){
						for(a1=0;a1<strlen(before);a1++){
							if(before[a1]!=after[a1]){
								break;
							}
							else if(before[a1]==after[a1]&&a1==strlen(before)-1){//before=after
								printf("The course name is the same nothing changed.");
								changed=1;
							}
						}
					}
					if(changed!=1){
						for(i=0;i<5;i++){//compare every data in classname
							for(j=0;j<8;j++){
								if(len[j][i]==strlen(before)){
									int temp;
									int n=250*j+50*i;
									for(temp=0;temp<strlen(before);temp++){
										if(classname[temp+n]!=before[temp]){
											break;
										}
										else if(classname[temp+n]==before[temp]&&temp==strlen(before)-1){//course name is totally the same
											len[j][i]=strlen(after);
											for(temp=0;temp<strlen(before);temp++){//delete course name in array
												classname[temp+n]='\0';
											}
											for(temp=0;temp<strlen(after);temp++){//rewrite the course name in array
												classname[temp+n]=after[temp];
											}
											changed=1;
											printf("=========================\n");
											printf("Name changed Successfully\nday:%d\nperiods:%d\nname:%s to %s\n",i+1,j+1,before,after);
											printf("=========================\n");
										}
									}
								}
							}
						}
					}
					if(changed==0){
						printf("Can't find the course %s please check again",before);
						break;//back to main menu
					}
				}
				else{//neither 1 nor 2
					printf("The command you enter is not correct please enter again");
				}
					int b1,b2;
					int big=1;
					for(b1=0;b1<5;b1++){//update the "longest"
						for(b2=0;b2<8;b2++){
							if(len[b2][b1]>big){
								big=len[b2][b1];
							}
						}
					}
					longest=big;
					break;//back to main menu
			}
		}
		else if(cmd!=4){
			printf("The command code is wrong(must be 1-4 int.)");
		} 
	}
}
