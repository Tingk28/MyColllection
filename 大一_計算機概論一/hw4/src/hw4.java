import java.util.Scanner;
import java.io.*;
public class hw4{
	public static void main(String[]args){
		try{
			Scanner scan=new Scanner(System.in);//scan提供使用者輸入指令
			Scanner environment=new Scanner(new FileInputStream("environment.txt"));//environment匯入當前天氣
			player player=new player();//創建玩家的物件
			land landA=new land();//創建土地一塊
			tools wateringcan=new tools(); 
			tools hoe=new tools();
			tools sickle=new tools();
			System.out.println("歡迎來到成電農場物語\n從這裡開始你的農場人生吧！");
			System.out.println("================================================");
			System.out.println("請輸入玩家名稱：");
			player.setname();//執行命名的method
			int day=1,$$=player.getmoney();//宣告變數包含累計天數(day)和當前資金
			boolean datechenge=false;//若日期改變時為true
			String[]SoilList={"無","sand","clay","loam"};//土地種類陣列
			String[]PlantList={"無","watermelon","mulberry"};//植物種類陣列
			String[]Weather={"Sunny","Storm","Normal","Rainy"};//天氣種類陣列
			int[]WeatherEff={-15,+10,-5,+5};//天氣種類影響
			String[]ShopItem={"watering","hoe","sickle","watermelon","mulberry","sand","clay","loam"};//商店清單
			int[]ShopPrice={50,420,210,10,5,15,20,20};//商店價目表
			tools[]ToolBox={wateringcan,hoe,sickle};//工具列表
			System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
			String env=environment.nextLine();//讀出第一天的天氣
			int envchange=0;//天氣對土壤的變化
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
			boolean playercheck=true;//檢查玩家使否擁有足夠的種子、土讓等物品，若沒有則為false，遊戲結束
			while($$+landA.getpredictrev()>0&&environment.hasNextLine()&&playercheck){//遊戲實際迴圈，當金錢大於0或是仍有環境變數時繼續
				System.out.println("《剩餘體力》"+player.getenergy());//印出剩餘體力
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
					if(landA.getsoil()!=0){//如果有填土
						landA.wetchange(envchange);//改變土壤濕度
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
						landA.deathcheck();//檢查土地A的濕度值並過夜
						continue;
					}
				}
				String command=scan.nextLine();//要求輸入指令
				command=command.toLowerCase();
				String [] Splitcommand=command.split(" ");
				if("water".equals(Splitcommand[0])){//澆水
					int wet=0;//要澆的植物
					if(Splitcommand.length==2){
						for(int i=1;i<PlantList.length;i++){//比對作物清單
							if(PlantList[i].equals(Splitcommand[1])){
								wet=i;//要澆水的植物編號
								CommandCheck=true;//指令無誤
								break;
							}
							if(i==PlantList.length-1){
								System.out.println("輸入的植物種類不存在，請重新檢查");
							}
						}
					}
					else{
						System.out.println("輸入的澆水指令有錯請重新輸入\n指令格式：water [植物名稱]");
					}
					if(CommandCheck==false){//指令錯誤，重跑
						System.out.println("================================================");
						continue;
					}
					else {//若指令格式正確
						if(wet==landA.getplant()){//檢查澆水植物和土地A現在種的植物是不是一樣
							if(player.getenergy()>=10&&wateringcan.aviliable()){//檢查體力是否>10以及是否有澆水器
								landA.wetchange(5);//濕度+5
								wateringcan.tooluse(5);//澆水並消耗澆花器
									if(wateringcan.aviliable()==false){//如果使用完澆水器後澆水器壞了
										player.useitem(0,1);
									}
								System.out.println("成功對"+PlantList[wet]+"澆水，目前濕度為"+landA.getwet());
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
							System.out.println("您目前沒有種植"+PlantList[wet]+"現在田裡種的是："+PlantList[landA.getplant()]);
							System.out.println("================================================");
						}
					}
				}
				else if("fill".equals(Splitcommand[0])){//填土並鬆土
					if(Splitcommand.length!=4){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名]");
						System.out.println("================================================");
						continue;
					}
					if(!"loosen".equals(Splitcommand[2])){//檢查填土指令
						System.out.println("填土並鬆土的指令有錯請重新輸入\n指令格式：fill and loosen [土壤名]");
						System.out.println("================================================");
						continue;					
					}
					int soil=0;//要種植的土種
					for(int i=1;i<4;i++){//檢查填土指令
						if(SoilList[i].equals(Splitcommand[3])){
							CommandCheck=true;//指令格式正確
							soil=i;//定位要填土壤在土壤表的位子
							break;
						}
						else if(i==3){
							System.out.println("輸入的土壤種類不存在請重新確認");
							System.out.println("================================================");
							CommandCheck=false;//指令格式錯誤
						}
					}
					if(CommandCheck){//若指令格式正確
						if(player.getitemq(soil+4)>0&&hoe.aviliable()&&player.getenergy()>=5&&landA.getplant()==0){//檢查物品、工具、體力是否均足夠
							hoe.tooluse(10);//使用鋤頭
							if(hoe.aviliable()==false){//鬆土後鋤頭壞了
								player.useitem(1,1);//使用鋤頭一個
							}
							player.energyuse(5);//消耗五點能量
							landA.setsoil(soil);//填土
							player.useitem(soil+4,1);//玩家物品-1
							landA.wetchange(envchange);//土壤受當天天氣影響
							System.out.println("成功鬆土並把"+SoilList[soil]+"填入");//系統提示
							System.out.println("================================================");
						}
						else if(player.getitemq(soil+4)<=0){//如果沒有足夠的土壤
							System.out.println("你目前沒有"+SoilList[soil]+"土壤，去商店購買吧！");
							System.out.println("================================================");
							continue;
						}
						else if(hoe.aviliable()==false){//如果沒有鋤頭
							hoe.tooluse(10);//內含報錯指令
						}
						else if(player.getenergy()<5){//如果體力不夠
							player.energyuse(5);//energyuse內含系統提示功能
							System.out.println("================================================");
						}
						else if(landA.getplant()!=0){
							System.out.println("你目前農地中已有"+PlantList[landA.getplant()]+"如果要重新種植請使用remove指令");
							System.out.println("================================================");
						}	
					}
				}
				else if("remove".equals(Splitcommand[0])){//移除作物
					if(landA.getplant()>0&&player.getenergy()>=10){
						landA.resetland();
						System.out.println("成功移除農地中的作物");
						System.out.println("================================================");
					}
					else if(landA.getplant()==0){
						System.out.println("目前田地沒有種植作物，無法移除");
						System.out.println("================================================");
					}
					else if(player.getenergy()<10){	
					player.energyuse(10);
					System.out.println("================================================");
					}	
				}
				else if("plant".equals(Splitcommand[0])){//種植
					if(Splitcommand.length==2){//大致檢查plant指令格式
						int plant=0;//種植植物編號
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
						if(CommandCheck==false){//指令格式錯誤，跳出
							System.out.println("================================================");
							continue;
						}
						if(landA.getsoil()!=0&&player.getitemq(plant+2)>0&&player.getenergy()>=15&&landA.getplant()==0){//檢查是否填土、種植及物品、體力是否均足夠
							player.useitem(plant+2,1);//使用物品
							player.energyuse(15);//扣體力
							landA.grow(plant);//種植
							System.out.println("================================================");
						}
						else if(landA.getsoil()==0){//如果沒有填土
							System.out.println("你還沒有填土跟鬆土呢，輸入fill and loosen指令吧！");
							System.out.println("================================================");
							continue;
						}
						else if(player.getitemq(plant+2)==0){//若物品不足
							System.out.println("你還沒有"+PlantList[plant]+"種子，去商店買點吧！");
							System.out.println("================================================");
							continue;
						}
						else if(player.getenergy()<15){//若體力不足
							player.energyuse(15);//報錯本指令含系統提示
							System.out.println("================================================");
							continue;
						}
						else if(landA.getplant()!=0){//如已經有作物在裡面
							landA.grow(plant);//報錯本指令含系統提示
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("輸入的plant指令格式錯誤，請重新檢查\nplant [植物名稱] ");
						System.out.println("================================================");
						continue;
					}
					
					
					
					
				}
				else if("reap".equals(Splitcommand[0])){//收割
					int plant=0;//本次要採收的植物
					if(Splitcommand.length!=4){//檢查填土指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//檢查填土指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱]");
						System.out.println("================================================");
						continue;
					}
					if(!"sell".equals(Splitcommand[2])){//檢查填土指令
						System.out.println("收割並販賣的指令有錯請重新輸入\n指令格式：reap and sell [植物名稱]");
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
					if(landA.getplant()==plant&&sickle.aviliable()){
						if(landA.getoutputdate()!=0){
							System.out.println("要採收的作物還沒有成熟呢再等等吧！");
							System.out.println("================================================");
						}
						else{
							sickle.tooluse(20);
							if(sickle.aviliable()==false){//如果採收後鐮刀壞了
								player.useitem(2,1);//使用鐮刀一個
							}
							$$+=landA.getpredictrev();
							System.out.println("成功採收"+PlantList[plant]+"賣得"+landA.getpredictrev()+"元");
							System.out.println("玩家金錢："+$$);
							landA.setsoil(0);
							System.out.println("================================================");
						}
					}
					else if(landA.getplant()!=plant){
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
					int buy=10;//一個用於儲存購買物品商品編號的變數
					int quantity=0;//購買的數量
					if(1<Splitcommand.length&&Splitcommand.length<4){
						boolean noitem=false;
						for(int i=0;i<8;i++){
							if(ShopItem[i].equals(Splitcommand[1])){
								buy=i;
								break;
							}
							else if(i==7){
								System.out.println("購買的商品不存在請重新檢查");
								noitem=true;
							}
						}
						if(noitem){
							System.out.println("================================================");
							continue;
						}
						try{
							if(buy==0){
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
						if(buy!=10&&Splitcommand.length==2){
							CommandCheck=true;
							quantity=1;
						}
						if(buy!=10&&Splitcommand.length==3&&CommandCheck==false){
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
						if($$>=ShopPrice[buy]*quantity){
							if(buy<3){//購買工具
								int $=$$;//成立虛帳簿
								$=ToolBox[buy].buytools($,buy);//用虛帳簿的錢購買工具
								if($!=$$){//購買前後金額不同（實!=虛）有成功購買
									player.additemq(buy,1);//玩家物品數量增加
									$$=$;//扣款
									System.out.println("成功購買"+ShopItem[buy]+" "+quantity+"個\n剩餘金錢："+$$+"元");
									System.out.println("================================================");
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
				}
				else if("backpack".equals(Splitcommand[0])){//包包物品
					if(player.itemsum()==0){
						System.out.println("包包現在空空如也，去商店買點什麼吧！\n輸入shop可以看到商店目錄");
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
				else if("check".equals(command)){//檢查田地狀況
					if(player.energyuse(5)){
						landA.printdata(1);
						System.out.println("================================================");
					}
				}
				else if("sleep".equals(Splitcommand[0])){//睡覺
					player.sleep();
					day++;
					player.setmoney($$);
					if(environment.hasNextLine()){
						datechenge=true;
						System.out.println("================================================");
						System.out.println("第"+day+"天\n剩餘金錢："+player.getmoney());
						landA.deathcheck();
						continue;
					}
				}
				else if("endgame".equals(command)){//退出、結束遊戲
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
				else if("plant?".equals(command)){//顯示土壤說明
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
				//存檔功能
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