import java.util.Scanner;
import java.io.*;
public class hw5{
	public static void main(String[]args){
		try{
			String[]SoilList={"無","sand","clay","loam","magicdust"};//土地種類陣列
			String[]PlantList={"無","watermelon","mulberry","sungrass","starflower"};//植物種類陣列
			String[]Weather={"Sunny","Storm","Normal","Rainy"};//天氣種類陣列
			int[]WeatherEff={-15,+10,-5,+5};//天氣種類影響
			String[]ShopItem={"watering","hoe","sickle","watermelon","mulberry","sungrass","starflower","sand","clay","loam","magicdust"};//商店清單
			int[]ShopPrice={50,420,210,10,5,15,20,15,20,20,30};//商店價目表
			tools wateringcan=new tools(); 
			tools hoe=new tools();
			tools sickle=new tools();
			tools[]ToolBox={wateringcan,hoe,sickle};//工具列表
			Scanner scan=new Scanner(System.in);//scan提供使用者輸入指令
			Scanner environment=new Scanner(new FileInputStream("environment.txt"));//environment匯入當前天氣
			player player=new player();//創建玩家的物件
			land [] LandList=new land[9];
			int day=1,$$=player.getmoney(),landpredictrev=0,energycost=0;//宣告變數包含累計天數(day)、當前資金、預期總產出、某動作所需體力
			int envchange=0;//天氣對土壤的變化
			boolean datechenge=false;//若日期改變時為true
			boolean playercheck=true;//檢查玩家使否擁有足夠的種子、土讓等物品，若沒有則為false，遊戲結束
			String env="";//儲存天氣名稱
			for(int i=0;i<LandList.length;i++){//為每塊地編號
				LandList[i]=new land();
				LandList[i].setid(i+1);
			}
			System.out.println("歡迎來到成電農場物語\n從這裡開始你的農場人生吧！");
			System.out.println("================================================");
			System.out.println("請輸入玩家名稱：\n或輸入load讀取存檔");
			String name=scan.nextLine();
			name=name.toLowerCase();
			boolean load=false;
			if("load".equals(name)){//讀檔功能
				try{
					Scanner Load=new Scanner(new FileInputStream("save.txt"));
					day=Integer.valueOf(Load.next());//載入天數
					for(int i=0;i<ToolBox.length;i++){//寫入工具資料
						ToolBox[i].setaviliable(Load.next());
						ToolBox[i].sethp(Load.next());
						}
					for(int i=0;i<LandList.length;i++){//寫入土地資料
						String number=Load.next();
						String[]n=number.split(",");
						LandList[i].setintdata(n[0],n[1],n[2],n[3],n[4],n[5],n[6],n[7],n[8],n[9]);
						String TF=Load.next();
						String[]SplitTF=number.split(",");
						LandList[i].setbooleandata(SplitTF[0],SplitTF[1],SplitTF[2],SplitTF[3]);
					}
					player.setname(Load.next());//玩家資料區
					String Number=Load.next();
					String[]N=Number.split(",");
					int[]number=new int[14];
					for(int i=0;i<N.length;i++){//string to int
						number[i]=Integer.valueOf(N[i]);
					}
					player.setmoney(number[0]);
					player.setenergy(number[1]);
					player.setjob(number[2]);
					for(int i=3;i<14;i++){//寫入包包物品數量
						player.additemq(i-3,number[i]);
					}
					for(int i=0;i<day;i++){
						env=environment.nextLine();//讀出天氣到第day天
					}
					$$=player.getmoney();
					player.sleep();//所有資料寫入完畢，準備過夜
					day++;
					datechenge=true;
					player.setmoney($$);
					if(environment.hasNextLine()){//如果仍有下一天天氣
						System.out.println("================================================");
						System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//檢查土地i的濕度值並過夜
							landpredictrev+=LandList[i].getpredictrev();//加總可能預期的果實產出
						}
					}
					load=true;
				}
				catch(Exception e){//報錯指令、將剛剛寫入的東西全部洗掉
					e.printStackTrace();
					for(int i=0;i<ToolBox.length;i++){
						ToolBox[i].reset();
					}
					for(int i=0;i<LandList.length;i++){
						LandList[i].resetland();
					}
					player.reset();
					System.out.println("沒有找到過去存檔的檔案或檔案損毀\n系統提示：將直接創新角色\n請輸入玩家名稱：");
					name=scan.nextLine();
				}
			}
			if(load==false){
				player.setname(name);//執行命名的method
				while(player.getjob()==0){//職業設定
					System.out.println("請輸入玩家職業：\n或輸入job?查看職業說明");
					String [] JobList={"botanist","merchant","hercules"};
					String job=scan.next();
					job=job.toLowerCase();
					if("job?".equals(job)){//顯示職業說明
						try{
							Scanner Job=new Scanner(new FileInputStream("./Explanation/job.txt"));
							while(Job.hasNextLine()){
								String JOB=Job.nextLine();
								System.out.println(JOB);
							}
						}
						catch(Exception e){
							System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
						}
						continue;
					}
					for(int i=0;i<JobList.length;i++){
						if(job.equals(JobList[i])){
							player.setjob(i+1);
							for(int I=0;I<9;I++){
								LandList[I].setplayerjob(i+1);
							}
							System.out.println("成功將職業設定為"+JobList[i]);
							System.out.println("================================================");
							break;
						}
						else if(i==JobList.length-1){
							System.out.println("輸入的職業不存在，請重新檢查");
						}
					}
				}
				System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
				env=environment.nextLine();//讀出第一天的天氣
				for(int i=0;i<4;i++){//設定第一天天的溼度變數
					if(Weather[i].equals(env)){
						envchange=WeatherEff[i];
						if(envchange>0){
							System.out.println("今天天氣："+env+"  土壤濕度:+"+envchange);
							System.out.println("================================================");
						}
						else{
							System.out.println("今天天氣："+env+"  土壤濕度:"+envchange);
							System.out.println("================================================");
						}
						break;
					}
				}
			}
			while($$+landpredictrev>0&&environment.hasNextLine()&&playercheck){//遊戲實際迴圈，當金錢大於0或是仍有環境變數時繼續
				System.out.println("《剩餘體力》"+player.getenergy());//印出剩餘體力
				System.out.println("《剩餘金錢》"+$$);//印出剩餘金錢
				if(datechenge){//天數改變時讀取下一行
					env=environment.nextLine();
					datechenge=false;
					for(int i=0;i<4;i++){//第二天之後的溼度變數
						if(Weather[i].equals(env)){
							envchange=WeatherEff[i];//今天的天氣編號
							if(envchange>0){
								System.out.println("今天天氣："+env+"土壤濕度:+"+envchange);
								System.out.println("================================================");
							}
							else{
								System.out.println("今天天氣："+env+"土壤濕度:"+envchange);
								System.out.println("================================================");
							}
						break;
						}
					}
					for(int i=0;i<LandList.length;i++){
						if(LandList[i].getsoil()!=0){//如果有填土
							LandList[i].wetchange(envchange);//改變土壤濕度
						}
					}
				}
				boolean CommandCheck=false;//指令格式正確時為true
				if(player.getenergy()<=0){//如果體力<=0
					System.out.println("玩家"+player.getname()+"累倒了");
					player.sleep();//玩家睡覺
					day++;
					datechenge=true;
					player.setmoney($$);//結算當天金額
					if(environment.hasNextLine()){//如果仍有下一天天氣
						System.out.println("================================================");
						System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//檢查土地i的濕度值並過夜
							landpredictrev+=LandList[i].getpredictrev();//加總可能預期的果實產出
						}
					}
				}
				String command=scan.nextLine();//要求輸入指令
				command=command.toLowerCase();
				String [] Splitcommand=command.split(" ");
				if("water".equals(Splitcommand[0])){//澆水
					int wet=0;//要澆的田地編號
					if(Splitcommand.length==2){//檢查指令長度&田地編號
						try{
							wet=Integer.valueOf(Splitcommand[1]);
							if(wet<1||wet>9){
								System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
								continue;
							}
						}
						catch(Exception e){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
						}
					}
					else{
						System.out.println("輸入的澆水指令有錯請重新輸入\n指令格式：water [田地編號]");
						continue;
					}
					if(LandList[wet-1].getplant()>0){//檢查土地現在是否種植作物
						if(player.getenergy()>=10&&wateringcan.aviliable()){//檢查體力是否>10以及是否有澆水器
							LandList[wet-1].wetchange(5);//濕度+5
							wateringcan.tooluse(5);//澆水並消耗澆花器
								if(wateringcan.aviliable()==false){//如果使用完澆水器後澆水器壞了
									player.useitem(0,1);//消耗澆水器一個
									System.out.println("你的澆水器因為耐久歸零壞掉了，再去商店買一個吧");//系統提示
								}
							System.out.println("成功對"+LandList[wet-1]+"澆水，目前濕度為"+LandList[wet-1].getwet());
							System.out.println("================================================");
						}
						else if(player.getenergy()<10){//體力不足
							player.energyuse(10);//內含報錯指令
						}
						else if(wateringcan.aviliable()==false){//沒有澆水器
							wateringcan.tooluse(5);//內含報錯指令
						}
					}
					else{
						System.out.println("您的"+LandList[wet-1]+"目前沒有種植作物\n趕快種下你要的作物吧！");
						System.out.println("================================================");
					}
				}
				else if("fill".equals(Splitcommand[0])){//填土並鬆土
					if(Splitcommand.length!=5){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名稱] [田地編號] ");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名稱] [田地編號] ");
						System.out.println("================================================");
						continue;
					}
					if(!"loosen".equals(Splitcommand[2])){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名稱] [田地編號] ");
						System.out.println("================================================");
						continue;					
					}
					int soil=0,land=-1;//要種植的土種及位置
					for(int i=1;i<SoilList.length;i++){//檢查填土指令
						if(SoilList[i].equals(Splitcommand[3])){
							soil=i;//定位要填土壤在土壤表的位子
							CommandCheck=true;//指令格式暫時正確
							break;
						}
						else if(i==SoilList.length-1){
							System.out.println("輸入的土壤種類不存在請重新確認");
							System.out.println("================================================");
							CommandCheck=false;//指令格式錯誤
						}
					}
					if(CommandCheck==false){
						continue;
					}
					try{
						land=Integer.valueOf(Splitcommand[4]);
						if(land<1||land>9){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
						}
					}
					catch(Exception e){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
					}
					if(CommandCheck){//若指令格式正確
						if(player.getjob()==1){
							energycost=5;
						}
						else if(player.getjob()==2){
							energycost=10;
						}
						else{
							energycost=0;
						}
						if(player.getitemq(soil+6)>0&&hoe.aviliable()&&player.getenergy()>=energycost&&LandList[land-1].getplant()==0){//檢查物品、工具、體力是否均足夠
							hoe.tooluse(10);//使用鋤頭
							if(hoe.aviliable()==false){//鬆土後鋤頭壞了
								player.useitem(1,1);//使用鋤頭一個
								System.out.println("你的鋤頭因為耐久歸零壞掉了，再去商店買一個吧");//系統提示
							}
							player.energyuse(energycost);//消耗能量
							LandList[land-1].setsoil(soil);//填土
							player.useitem(soil+6,1);//玩家物品-1
							LandList[land-1].wetchange(envchange);//土壤受當天天氣影響
							System.out.println("成功鬆土並把"+SoilList[soil]+"填入"+LandList[land-1]+"中");//系統提示
							System.out.println("================================================");
						}
						else if(player.getitemq(soil+6)<=0){//如果沒有足夠的土壤
							System.out.println("你目前沒有"+SoilList[soil]+"土壤，去商店購買吧！");
							System.out.println("================================================");
							continue;
						}
						else if(hoe.aviliable()==false){//如果沒有鋤頭
							hoe.tooluse(10);//內含報錯指令
						}
						else if(player.getenergy()<energycost){//如果體力不夠
							player.energyuse(energycost);//energyuse內含系統提示功能
							System.out.println("================================================");
						}
						else if(LandList[land-1].getplant()!=0){
							System.out.println("你目前"+LandList[land-1]+"中已有"+PlantList[LandList[land-1].getplant()]+"如果要重新種植請使用remove指令");
							System.out.println("================================================");
						}
					}
				}
				else if("remove".equals(Splitcommand[0])){//移除作物
					if(Splitcommand.length!=2){
						System.out.println("輸入的remove指令格式錯誤請重新檢查\n指令格式：remove[田地編號]");
						System.out.println("================================================");
						continue;
					}
					int land=-1;
					try{
						land=Integer.valueOf(Splitcommand[1]);
						if(land<1||land>9){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
						}
					}
					catch(Exception e){
						System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
						continue;
					}
					if(LandList[land-1].getplant()>0&&player.getenergy()>=10){
						LandList[land-1].resetland();
						player.energyuse(10);
						System.out.println("成功移除"+LandList[land-1]+"中的作物");
						System.out.println("================================================");
					}
					else if(LandList[land-1].getplant()==0){//田地沒有作物
						System.out.println(LandList[land-1]+"目前沒有種植作物，無法移除");
						System.out.println("================================================");
					}
					else if(player.getenergy()<10){//玩家體力不足
					player.energyuse(10);//報錯、內含系統提示功能
					System.out.println("================================================");
					}	
				}
				else if("plant".equals(Splitcommand[0])){//種植
					if(Splitcommand.length==3){//大致檢查plant指令格式
						int plant=0,land=-1;//種植植物編號、填入土地編號
						for(int i=1;i<PlantList.length;i++){//比對植物編號
							if(PlantList[i].equals(Splitcommand[1])){
								plant=i;
								CommandCheck=true;//指令格式無誤
								break;
							}
							else if(i==PlantList.length-1){
								System.out.println("輸入的植物種類不存在，請重新檢查");
								CommandCheck=false;//指令格式錯誤
							}
						}
						try{
							land=Integer.valueOf(Splitcommand[2]);
							if(land<1||land>9){
								System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
								continue;
							}
						}
						catch(Exception e){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
						}
						if(CommandCheck==false){//指令格式錯誤，跳出
							System.out.println("================================================");
							continue;
						}
						if(player.getjob()==1){
							energycost=15;
						}
						else if(player.getjob()==2){
							energycost=20;
						}
						else{
							energycost=10;
						}
						if(LandList[land-1].getsoil()!=0&&player.getitemq(plant+2)>0&&player.getenergy()>=energycost&&LandList[land-1].getplant()==0&&LandList[land-1].grow(plant)){//檢查是否填土、種植及物品、體力是否均足夠
							player.useitem(plant+2,1);//使用物品
							player.energyuse(energycost);//扣體力
							System.out.println("================================================");
							for(int i=0;i<LandList.length;i++){//種植完後檢查是否有植物會受到功能型植物影響（含經濟作物被既有功能型影響及新種下的功能型影響既有植物）
								if(LandList[i].getplant()==3){//太陽草
									try{//右
										LandList[i+1].sungrasseff();
									}
									catch(Exception e){
									}
									try{//左
										LandList[i-1].sungrasseff();
									}
									catch(Exception e){
									}
									try{//下
										LandList[i+3].sungrasseff();
									}
									catch(Exception e){
									}
									try{//上
										LandList[i-3].sungrasseff();
									}
									catch(Exception e){
									}
								}
								if(LandList[i].getplant()==4){//星辰花
									try{//右
										LandList[i-1].starflowereff();
									}
									catch(Exception e){
									}
									try{//左
										LandList[i+1].starflowereff();
									}
									catch(Exception e){
									}
									try{//下
										LandList[i+3].starflowereff();
									}
									catch(Exception e){
									}
									try{//上
										LandList[i-3].starflowereff();
									}
									catch(Exception e){
									}
								}
							}
						}
						else if(LandList[land-1].getsoil()==0){//如果沒有填土
							System.out.println("你還沒有填土跟鬆土呢，輸入fill and loosen指令吧！");
							System.out.println("================================================");
							continue;
						}
						else if(player.getitemq(plant+2)==0){//若物品不足
							System.out.println("你還沒有"+PlantList[plant]+"種子，去商店買點吧！");
							System.out.println("================================================");
							continue;
						}
						else if(player.getenergy()<energycost){//若體力不足
							player.energyuse(energycost);//報錯、本指令含系統提示
							System.out.println("================================================");
							continue;
						}
						else if(LandList[land-1].getplant()!=0){//如已經有作物在裡面
							LandList[land-1].grow(plant);//報錯、本指令含系統提示
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("輸入的plant指令格式錯誤，請重新檢查\nplant [植物名稱] [田地編號]");
						System.out.println("================================================");
						continue;
					}
				}
				else if("reap".equals(Splitcommand[0])){//收割
					int plant=0,land=0;//本次要採收的植物
					if(Splitcommand.length!=5){//檢查收割指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱] [田地編號]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//檢查收割指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱] [田地編號]");
						System.out.println("================================================");
						continue;
					}
					if(!"sell".equals(Splitcommand[2])){//檢查收割指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱] [田地編號]");
						System.out.println("================================================");
						continue;					
					}
					for(int i=1;i<PlantList.length;i++){
						if(PlantList[i].equals(Splitcommand[3])){
							CommandCheck=true;
							plant=i;
							break;
						}
						else if(i==PlantList.length-1){
							System.out.println("輸入的作物種類不存在，請重新輸入");
							CommandCheck=false;
						}
					}
					if(CommandCheck==false){
						System.out.println("================================================");
						continue;
					}
					try{
						land=Integer.valueOf(Splitcommand[4]);
						if(land<1||land>9){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
						}
					}
					catch(Exception e){
							System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
							continue;
					}
					if(LandList[land-1].getplant()==plant&&sickle.aviliable()){
						if(LandList[land-1].getoutputdate()!=0&&LandList[land-1].getplant()>0&&LandList[land-1].getplant()<3){//未成熟的經濟作物
							System.out.println("要採收的作物還沒有成熟呢再等等吧！");
							System.out.println("================================================");
						}
						else if(LandList[land-1].getplant()>2){
							System.out.println("功能型植物無法被採收");
							System.out.println("================================================");
						}
						else{
							sickle.tooluse(20);
							if(sickle.aviliable()==false){//如果採收後鐮刀壞了
								player.useitem(2,1);//使用鐮刀一個
								System.out.println("你的鐮刀因為耐久歸零壞掉了，再去商店買一個吧");//系統提示
							}
							$$+=LandList[land-1].getpredictrev();
							System.out.println("成功採收"+PlantList[plant]+"賣得"+LandList[land-1].getpredictrev()+"元");
							System.out.println("玩家金錢："+$$);
							LandList[land-1].setsoil(0);
							System.out.println("================================================");
						}
					}
					else if(LandList[land-1].getplant()!=plant){
						System.out.println("您目前田裡沒有種植"+PlantList[plant]+"去商店買來種吧");
						System.out.println("================================================");
						continue;
					}
					else if(sickle.aviliable()==false){
						System.out.println("您目前沒有鐮刀去商店買把吧！");
						System.out.println("================================================");
					}
				}
				else if("buy".equals(Splitcommand[0])){//購買
					int buy=-1;//一個用於儲存購買物品商品編號的變數
					int quantity=0;//購買的數量
					if(1<Splitcommand.length&&Splitcommand.length<4){
						boolean noitem=false;
						for(int i=0;i<ShopItem.length;i++){
							if(ShopItem[i].equals(Splitcommand[1])){
								buy=i;
								break;
							}
							else if(i==ShopItem.length-1){
								System.out.println("購買的商品不存在請重新檢查");
								noitem=true;
							}
						}
						if(noitem){
							System.out.println("================================================");
							continue;
						}
						try{
							if(buy==0){//如果買澆水器
								if("can".equals(Splitcommand[2])==false){
								System.out.println("購買的商品不存在請重新檢查");
								System.out.println("================================================");
								continue;
								}
								else{
								CommandCheck=true;
								quantity=1;
								}
							}
						}
						catch(Exception e){
							System.out.println("購買的商品不存在請重新檢查");
							System.out.println("================================================");
							continue;
						}
						if(buy!=-1&&Splitcommand.length==2){
							CommandCheck=true;
							quantity=1;
						}
						if(buy!=-1&&Splitcommand.length==3&&CommandCheck==false){
							try{
								int quant=Integer.valueOf(Splitcommand[2]);
								if(buy<3&&quant!=1){
									System.out.println("工具類一次只能購買／擁有一個，請重新輸入");
									System.out.println("================================================");
									continue;
								}
								else if(buy<3&&quant==1){
									CommandCheck=true;
									quantity=quant;
								}
								else if(buy>2&&quant>0){
									CommandCheck=true;
									quantity=quant;
								}
								else{
									System.out.println("購買的數量不正確(需>0)，請重新檢查");
									System.out.println("================================================");
									continue;
								}
							}
							catch(Exception e){
								System.out.println("未輸入購買商品數量或購買的數量不正確，請重新檢查");
								System.out.println("================================================");
								continue;
							}
						}
						int price=0;//此次購買的金額
						if(player.getjob()==2&&buy<3){
							price=(ShopPrice[buy]-10);
						}
						else{
							price=ShopPrice[buy]*quantity;
						}
						if($$>=price){
							if(buy<3){//購買工具
								int $=$$;//成立虛帳簿
								$=ToolBox[buy].buytools($,price);//用虛帳簿的錢購買price元的工具
								if($!=$$){//購買前後金額不同（實!=虛）有成功購買
									player.additemq(buy,1);//玩家物品數量增加
									$$=$;//扣款
									if(buy==0){//購買澆水器
										System.out.println("成功購買"+ShopItem[buy]+" can"+quantity+"個\n剩餘金錢："+$$+"元");
										System.out.println("================================================");
									}
									if(buy>0){
										System.out.println("成功購買"+ShopItem[buy]+" "+quantity+"個\n剩餘金錢："+$$+"元");
										System.out.println("================================================");
									}
								}
							}
							else{
								$$=player.buysth($$,buy,quantity);
								System.out.println("成功購買"+ShopItem[buy]+" "+quantity+"個\n剩餘金錢："+$$+"元");
								System.out.println("================================================");
							}
						}
						else{
							System.out.println("您現在的錢不夠，努力賺錢買自己想要的東西吧！");
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("輸入的buy指令格式錯誤，請重新檢查\n應為：buy [想要購買的商店販買物品] ([數量])");
						System.out.println("================================================");
						continue;
					}
				}
				else if("shop".equals(Splitcommand[0])){//印出商店清單
					System.out.println("\n品名           價格");
					for(int i=0;i<ShopItem.length;i++){
						if(i==0){
							System.out.println(ShopItem[i]+" can   "+ShopPrice[i]);
						}
						else{
							System.out.print(ShopItem[i]);
							for (int I=0;I<(15-ShopItem[i].length());I++){
								System.out.print(" ");
							}
							System.out.println(ShopPrice[i]);
						}
					}
					System.out.println("===================");
					System.out.println("如有購買需求請輸入購買指令\nbuy [想要購買的商店販買物品] ([數量])");
					System.out.println("================================================");
				}
				else if("backpack".equals(Splitcommand[0])){//包包物品
					if(player.itemsum()==0){
						System.out.println("包包現在空空如也，去商店買點什麼吧！\n輸入shop可以看到商店目錄");
						System.out.println("================================================");
					}
					else{
						System.out.println("\n品名           數量    耐久度");
						for(int i=0;i<player.itemkind();i++){
							if(player.getitemq(i)!=0&&i<3){
								System.out.print(player.getitemname(i));
								for(int I=0;I<15-player.getitemname(i).length();I++){
									System.out.print(" ");
								}
							System.out.println(player.getitemq(i)+"       "+ToolBox[i].gethp());
							}
							if(player.getitemq(i)!=0&&i>2){
								System.out.print(player.getitemname(i));
								for(int I=0;I<15-player.getitemname(i).length();I++){
									System.out.print(" ");
								}
							System.out.println(player.getitemq(i));
							}
						}
						System.out.println("================================================");
					}
				}
				else if("check".equals(Splitcommand[0])){//檢查田地狀況
					int check=-1;//要檢查的田地
					if(Splitcommand.length==2){
						if("all".equals(Splitcommand[1])){
							check=100;
						}
						else{
							try{
								check=Integer.valueOf(Splitcommand[1]);
								if(check<1||check>9){
									System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
									continue;
								}
							}
							catch(Exception e){
								System.out.println("輸入的田地編號不存在（應為1～9），請重新輸入");
								continue;
							}
						}
					}
					else{
						System.out.println("輸入check指令格式錯誤\n指令格式：check [田地編號] ");
						System.out.println("================================================");
						continue;
					}
					if(check<10){
						if(player.energyuse(5)){
							LandList[check-1].printdata(check);
							System.out.println("================================================");
						}
					}
					else if(check==100){
						if(player.getenergy()>=45){
							player.energyuse(45);
							for(int i=0;i<9;i++){
							LandList[i].printdata(i+1);
							System.out.println("================================================");
							}
						}
						else{
							player.energyuse(45);//內含系統提示功能
						}
					}
				}
				else if("sleep".equals(Splitcommand[0])){//睡覺
					player.sleep();
					day++;
					datechenge=true;
					player.setmoney($$);
					if(environment.hasNextLine()){//如果仍有下一天天氣
						System.out.println("================================================");
						System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//檢查土地i的濕度值並過夜
							landpredictrev+=LandList[i].getpredictrev();//加總可能預期的果實產出
						}
					}
				}
				else if("endgame".equals(command)){//退出、結束遊戲
					player.setmoney($$);//結算當天金額
					break;
				}
				else if("cls".equals(command)){//清空畫面
					try{
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
					}
				}
				else if("help".equals(command)){//顯示指令集
					try{
						Scanner Help=new Scanner(new FileInputStream("./Explanation/help.txt"));
						while(Help.hasNextLine()){
							String help=Help.nextLine();
							System.out.println(help);
						}
					}
					catch(Exception e){
						System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
					}
				}
				else if("env?".equals(command)){//顯示天氣說明
					try{
						Scanner Enveff=new Scanner(new FileInputStream("./Explanation/enveff.txt"));
						while(Enveff.hasNextLine()){
							String enveff=Enveff.nextLine();
							System.out.println(enveff);
						}
					}
					catch(Exception e){
						System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
					}
				}
				else if("soil?".equals(command)){//顯示土壤說明
					try{
						Scanner Soileff=new Scanner(new FileInputStream("./Explanation/soileff.txt"));
						while(Soileff.hasNextLine()){
							String soileff=Soileff.nextLine();
							System.out.println(soileff);
						}
					}
					catch(Exception e){
						System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
					}
				}
				else if("plant?".equals(command)){//顯示作物說明
					try{
						Scanner Planteff=new Scanner(new FileInputStream("./Explanation/planteff.txt"));
						while(Planteff.hasNextLine()){
							String planteff=Planteff.nextLine();
							System.out.println(planteff);
						}
					}
					catch(Exception e){
						System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
					}
				}
				else if("job?".equals(command)){//顯示作物說明
					try{
							Scanner job=new Scanner(new FileInputStream("./Explanation/job.txt"));
							while(job.hasNextLine()){
								String JOB=job.nextLine();
								System.out.println(JOB);
							}
						}
					catch(Exception e){
						System.out.println("該指令出現錯誤，請嘗試聯繫管理員");
					}
				}
				else if("save".equals(command)){//存檔功能
					player.setmoney($$);
					try{
						PrintWriter save=new PrintWriter(new FileOutputStream("save.txt",false));
						save.println(day);//遊玩日期
						for(int i=0;i<ToolBox.length;i++){//存入工具
							save.println(ToolBox[i].aviliable()+"\n"+ToolBox[i].gethp());
							save.flush();
						}
						for(int i=0;i<LandList.length;i++){
							save.println(LandList[i].intinfo());
							save.println(LandList[i].booleaninfo());
							save.flush();
						}
						save.println(player.getname());
						save.println(player.intinfo());
						save.flush();
						//save.close();
						System.out.println("已成功存檔，退出遊戲");
						break;
					}
					catch(Exception e){
						System.out.println("存檔錯誤");
					}
				}
				else{
					System.out.println("輸入的指令不正確，請重新檢查或輸入help查看指令集");
					System.out.println("================================================");
				}
				if($$==0){
					playercheck=player.possiblerev();
				}
			}//while迴圈大括號
			System.out.println("已遊玩"+day+"天，遊戲後餘額為："+player.getmoney());
		}
		catch(FileNotFoundException fnfe){
		}
	}
}	