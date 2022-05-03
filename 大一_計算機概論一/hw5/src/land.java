public class land{
	String[]SoilList={"無","sand","clay","loam","magicdust"};
	String[]PlantList={"無","watermelon","mulberry","sungrass","starflower"};
	int[]PlantMaxWet={0,25,35,20,40};
	int[]PlantMinWet={0,15,25,10,30};
	int[]OutputList={0,4,8,6,8};//預期產量列表，後兩者為功能型植物的剩餘天數
	int[]OutputDateList={0,12,16};//產出時間列表
	int[]PriceList={0,35,10,0,0};//售價列表（後兩者為功能性作物、0元）
	private int id=0;//土地編號，方便系統提示
	private int soil=0;//土壤編號，預設為0(無種植)
	private int plant=0;//植物編號，預設為0(無種植)
	private int output=0;//預期產量	
	private int predictrev=0;//預期收入
	private int outputdate=0;//成熟倒數	
	private int date=0;//生長天數
	private int wet=20;//初始濕度為20
	private int deathcount=0;//計算該植物曾經不合濕度的天數
	private int playerjob=0;//儲存玩家的職業（植物學家&商人用）
	private boolean decline=false;//是否會減少產量
	private boolean sungrasseff=false;//是否受過太陽草影響
	private boolean starflowereff=false;//是否受過星辰花影響
	private boolean firstdecline=true;//第一次達三天不會減少產量
	public void setid(int newid){//設定土地編號(1-9)
		id=newid;
	}
	public void setplayerjob(int newjob){//寫入玩家職業
		playerjob=newjob;
	}
	public void resetland(){//重設土壤指令
			soil=0;
			plant=0;
			output=0;
			outputdate=0;
			date=0;
			wet=20;
			deathcount=0;
			decline=false;
			firstdecline=true;
	}
	public void setsoil(int s){//填土指令
		soil=s;
		plant=0;
		output=0;
		outputdate=0;
		date=0;
		wet=20;
		deathcount=0;
		decline=false;
		firstdecline=true;
	}
	public void wetchange(int i){//改變濕度（可能因澆水／天氣...影響）
		wet+=i;
		if(wet>100){
			wet=100;
		}
		else if(wet<0){
			wet=0;
		}
	}
	public boolean grow(int p){//種植植物指令
		boolean planted=false;//該次是否有成功種植
		if(p<3){
			if(plant==0&&soil==1){
				plant=p;
				output=OutputList[p];
				outputdate=OutputDateList[p];
				date=0;
				System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//如果玩家是商人
					predictrev+=output;//單價+1
				}
				planted=true;
			}
			else if(plant==0&&soil==2){
				plant=p;
				output=OutputList[p]-1;
				outputdate=OutputDateList[p]-3;
				date=0;
				System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//如果玩家是商人
					predictrev+=output;//單價+1
				}
				planted=true;
			}
			else if(plant==0&&soil==3){
				plant=p;
				output=OutputList[p]+1;
				outputdate=OutputDateList[p]+3;
				date=0;
				System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//如果玩家是商人
					predictrev+=output;//單價+1
				}
				planted=true;
			}
			else if(plant==0&&soil==4){
				System.out.println("魔法土只能種功能型植物");
			}
			else{
				System.out.println("該塊地已經種了"+PlantList[plant]+"剷掉重新填土再試試吧！");
			}
		}
		else if (p>2){
			if(plant==0&&soil==4){
				plant=p;
				output=OutputList[p];
				planted=true;
				outputdate=1;//不會更動（因溼度檢查部分需看剩餘產出時間，故設一個>0的數）
				System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
			}
			else if (plant==0&&soil!=4){
				System.out.println("功能型植物只能種在魔法土中");
			}
			else{
				System.out.println("該塊地已經種了"+PlantList[plant]+"剷掉重新填土再試試吧！");
			}
		}
		if(planted&&playerjob==1){//該次種植成功，且玩家職業為植物學家
			output++;
		}
		return planted;
	}
	public void deathcheck(){//過夜&濕度檢查
		if(plant>0){
			if(wet>PlantMaxWet[plant]||wet<PlantMinWet[plant]&&outputdate>0){
				if(plant<3){
					deathcount++;
					date++;
					outputdate--;
					if(deathcount==3){
						decline=true;
					}
					else if(deathcount==5){//植物死掉了，初始化
						System.out.println("田地"+id+"中的"+PlantList[plant]+"因為長期濕度不合死掉了，下次要好好照顧它喔！");
						resetland();
					}
					if(decline&&firstdecline==false){
						output--;
					}
					if(output==0&&plant>0){
						System.out.println("田地"+id+"中的"+PlantList[plant]+"因為無法結果死掉了，下次要好好照顧它喔！");
						resetland();
					}
					if(decline&&firstdecline){
						firstdecline=false;
					}
				}
				else{
					date++;
					output-=2;//減少功能型植物剩餘天數兩天（原本一天+濕度不合一天）
					if(output<=0){
						System.out.println("田地"+id+"中的"+PlantList[plant]+"因為時間到了而枯萎");
						resetland();
					}
				}
			}
			else if(outputdate>0){//符合濕度的經濟作物
				deathcount=0;
				date++;
				outputdate--;
			}
			else if(plant>2){//功能型植物因時間衰減
				date++;
				output--;
				if(output<=0){
						System.out.println("田地"+id+"中的"+PlantList[plant]+"因為時間到了而枯萎");
						resetland();
					}
			}
			if(outputdate==0&&plant>0&&plant<3){//已經成熟的經濟型作物
				System.out.println("田地"+id+"中的"+PlantList[plant]+"已經成熟了，快用reap and sell 指令收割吧！");
			}
			predictrev=PriceList[plant]*output;
			if(playerjob==2){//如果玩家是商人
					predictrev+=output;//單價+1
			}
		}
	}
	public void sungrasseff(){//受太陽花影響
		if(sungrasseff==false&&plant>0&&plant<3){
			outputdate-=3;
			sungrasseff=true;
		}
	}
	public void starflowereff(){//受星辰花影響
		if(starflowereff==false&&outputdate>0&&plant>0&&plant<3){
			output++;
			starflowereff=true;
		}
	}
	public void printdata(int i){
		if(soil>0){
			if(plant>0&&plant<3){//賺錢型植物
				System.out.println("《田地"+i+"》\n土壤："+SoilList[soil]+"    植物："+PlantList[plant]+"   濕度為："+wet);
				if(outputdate>0){
				System.out.println("已生長"+date+"天     預計再過 "+outputdate+" 天結成 "+output+" 顆果實：");
				}
				else{
				System.out.println("已生長"+date+"天     已經結成 "+output+" 顆果實：");
				}
				System.out.println("濕度連續未達標已"+deathcount+"天    作物是否有可能減產（濕度曾連續三天未達標）"+decline);
			}
			else if(plant>2){//功能型植物
				System.out.println("《田地"+i+"》\n土壤："+SoilList[soil]+"    植物："+PlantList[plant]+"   濕度為："+wet);
				System.out.println("已生長"+date+"天     預計再過 "+output+" 天死亡：");
			}
			else{
				System.out.println("《田地"+i+"》\n土壤："+SoilList[soil]+"    濕度為："+wet+"\n目前沒有植物");
			}
		}
		else{
			System.out.println("《田地"+i+"》");
			System.out.println("田地"+i+"目前空空如也，去商店買點耗材吧");
		}
	}
	public int getid(){//回傳土地編號(1-9)
		return id;
	}
	public int getsoil(){//回傳土壤種類
		return soil;
	}
	public int getplant(){//回傳作物編號
		return plant;
	}
	public int getwet(){//回傳濕度
		return wet;
	}
	public int getoutputdate(){//回傳收成日期
		return outputdate;
	}
	public int getpredictrev(){//得到預期收益，用於結束遊戲檢查功能
		return predictrev;
	}
	public String toString(){
		return ("田地"+id);
	}
	public String intinfo(){
		String data=id+","+soil+","+plant+","+output+","+predictrev+","+outputdate+","+date+","+wet+","+deathcount+","+playerjob;
		return data;
	}
	public String booleaninfo(){
		String data=decline+","+sungrasseff+","+starflowereff+","+firstdecline;
		return data;
	}
	public void setintdata(String a,String b,String c,String d,String e,String f,String g,String h,String i,String j){
		id=Integer.valueOf(a);
		soil=Integer.valueOf(b);
		plant=Integer.valueOf(c);
		output=Integer.valueOf(d);
		predictrev=Integer.valueOf(e);
		outputdate=Integer.valueOf(f);
		date=Integer.valueOf(g);
		wet=Integer.valueOf(h);
		deathcount=Integer.valueOf(i);
		playerjob=Integer.valueOf(j);
	}
	public void setbooleandata(String a,String b,String c,String d){
		decline=Boolean.valueOf(a);
		sungrasseff=Boolean.valueOf(b);
		starflowereff=Boolean.valueOf(c);
		firstdecline=Boolean.valueOf(d);
	}
}