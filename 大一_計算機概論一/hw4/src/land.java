public class land{
	String[]SoilList={"無","sand","clay","loam"};
	String[]PlantList={"無","watermelon","mulberry"};
	int[]PlantMaxWet={0,25,35};
	int[]PlantMinWet={0,15,25};
	int[]OutputList={0,4,8};//預期產量列表
	int[]OutputDateList={0,12,16};//產出時間列表
	int[]PriceList={0,35,10};//售價列表
	private int soil=0;//土壤編號，預設為0(無種植)
	private int plant=0;//植物編號，預設為-1(無種植)	
	private int output=0;//預期產量	
	private int predictrev=0;//預期收入
	private int outputdate=0;//成熟倒數	
	private int date=0;//生長天數
	private int wet=20;//初始濕度為20
	private int deathcount=0;//計算該植物曾經不合濕度的天數
	private boolean decline=false;//是否會減少產量
	private boolean firstdecline=true;//第一次達三天不會減少產量
	
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
	public void grow(int p){//種植植物指令
		if(plant==0&&soil==1){
			plant=p;
			output=OutputList[p];
			outputdate=OutputDateList[p];
			date=0;
			System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
			predictrev=PriceList[plant]*output;
		}
		else if(plant==0&&soil==2){
			plant=p;
			output=OutputList[p]-1;
			outputdate=OutputDateList[p]-3;
			date=0;
			System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
			predictrev=PriceList[plant]*output;
		}
		else if(plant==0&&soil==3){
			plant=p;
			output=OutputList[p]+1;
			outputdate=OutputDateList[p]+3;
			date=0;
			System.out.println("成功把"+PlantList[plant]+"種入"+SoilList[soil]+"中");
			predictrev=PriceList[plant]*output;
		}
		else{
			System.out.println("該塊地已經種了"+PlantList[plant]+"剷掉重新填土再試試吧！");
		}
	}
	public void deathcheck(){//過夜&濕度檢查
		if(plant>0){
			predictrev=PriceList[plant]*output;
			if(wet>PlantMaxWet[plant]||wet<PlantMinWet[plant]&&outputdate>0){
				deathcount++;
				date++;
				outputdate--;
				if(deathcount==3){
					decline=true;
				}
				else if(deathcount==5){//植物死掉了，初始化
					System.out.println("你種的"+PlantList[plant]+"因為長期濕度不合死掉了，下次要好好照顧它喔！");
					resetland();
				}
				if(decline&&firstdecline==false){
					output--;
				}
				if(output==0){
					System.out.println("你種的"+PlantList[plant]+"因為無法結果死掉了，下次要好好照顧它喔！");
					resetland();
				}
				if(decline&&firstdecline){
					firstdecline=false;
				}
			}
			else if(outputdate>0){
				deathcount=0;
				date++;
				if(outputdate>0){
					outputdate--;
				}
			}
			if(outputdate==0&&plant>0){
				System.out.println("你種的"+PlantList[plant]+"已經成熟了，快用reap and sell 指令收割吧！");
			}
		}
	}
	public void printdata(int i){
		if(soil>0){
			if(plant>0){
				System.out.println("土地"+i+"\n土壤："+SoilList[soil]+"    植物："+PlantList[plant]+"   濕度為："+wet);
				if(outputdate>0){
				System.out.println("已生長"+date+"天     預計再過 "+outputdate+" 天結成 "+output+" 顆果實：");
				}
				else{
				System.out.println("已生長"+date+"天     已經結成 "+output+" 顆果實：");
				}
				System.out.println("濕度連續未達標已"+deathcount+"天    作物是否有可能減產（濕度曾連續三天未達標）"+decline);
			}
			else{
				System.out.println("土地"+i+"\n土壤："+SoilList[soil]+"    濕度為："+wet);
			}
		}
		else{
		System.out.println("田地目前空空如也，去商店買點耗材吧");
		}
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
	public int getpredictrev(){//得到預期收益，用於結束遊戲檢查功能//得到預期收益，用於結束遊戲檢查功能
		return predictrev;
	}
	
}