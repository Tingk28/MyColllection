import java.util.Scanner;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.text.DecimalFormat;
public class hw2{
	public static void main (String [] args){
		Scanner scan=new Scanner(System.in);
		Drinks Coffee1=new Drinks();
		Drinks Coffee2=new Drinks();
		Drinks Coffee3=new Drinks();
		Drinks Coffee4=new Drinks();
		Drinks Coffee5=new Drinks();
		Drinks Coffee6=new Drinks();
		Drinks Coffee7=new Drinks();
		Drinks Coffee8=new Drinks();
		Drinks Coffee9=new Drinks();
		Drinks Coffee10=new Drinks();
		
		Coffee1.Coffee="Americano";
		Coffee1.Size="Medium";
		Coffee1.Price=55;
		Coffee1.Cal=19.8;
		Coffee2.Coffee="Americano";
		Coffee2.Size="Large";
		Coffee2.Price=65;
		Coffee2.Cal=26.4;
		//美式
		Coffee3.Coffee="Cappuccino";
		Coffee3.Size="Medium";
		Coffee3.Price=70;
		Coffee3.Cal=217.6;
		Coffee4.Coffee="Cappuccino";
		Coffee4.Size="Large";
		Coffee4.Price=85;
		Coffee4.Cal=290.6;
		//卡布奇諾
		Coffee5.Coffee="Mocha";
		Coffee5.Size="Medium";
		Coffee5.Price=70;
		Coffee5.Cal=390.9;
		Coffee6.Coffee="Mocha";
		Coffee6.Size="Large";
		Coffee6.Price=85;
		Coffee6.Cal=483.5;
		//摩卡
		Coffee7.Coffee="Latte";
		Coffee7.Size="Medium";
		Coffee7.Price=75;
		Coffee7.Cal=243.8;
		Coffee8.Coffee="Latte";
		Coffee8.Size="Large";
		Coffee8.Price=90;
		Coffee8.Cal=315.3;
		//拿鐵
		Coffee9.Coffee="Macchiato";
		Coffee9.Size="Medium";
		Coffee9.Price=80;
		Coffee9.Cal=252.1;
		Coffee10.Coffee="Macchiato";
		Coffee10.Size="Large";
		Coffee10.Price=90;
		Coffee10.Cal=340.6;
		//瑪琪雅朵
		System.out.println("歡迎使用本咖啡廳點餐系統，本店菜單如下：");
		/*	{Americano  ,Medium ,55 , 19.8},
			{Americano  ,Large  ,65 , 26.4},
			{Cappuccino ,Medium ,70 ,217.6},
			{Cappuccino ,Large  ,85 ,290.6},
			{Mocha      ,Medium ,70 ,390.9},
			{Mocha      ,Large  ,85 ,483.5},
			{Latte      ,Medium ,75 ,243.8},
			{Latte      ,Large  ,90 ,315.3},
			{Macchiato  ,Medium ,80 ,252.1},
			{Macchiato  ,Large  ,90 ,340.6};*/
		String [] CoffeeType ={"AMERICANO","CAPPUCCINO","MOCHA","LATTE","MACCHIATO"};
		String [] SizeType={"MEDIUM","LARGE"};
		String [] IceSugar ={"NO","LOW","HALF","LESS","NORMAL"};
		double [] BasicCal={19.8,26.4,217.6,290.6,390.9,483.5,243.8,315.3,252.1,340.6};
		double [] SugarCal={0,60,100,140,180};
		double [] BasicPrice ={55,65,70,85,70,85,75,90,80,90};
		
		System.out.println("================================\n品名        "+"大小    "+"價格  "+"熱量");
		System.out.println(Coffee1.Coffee+"   "+Coffee1.Size+"  "+Coffee1.Price+"  "+Coffee1.Cal+"\n");
		System.out.println(Coffee2.Coffee+"   "+Coffee2.Size+"   "+Coffee2.Price+"  "+Coffee2.Cal+"\n");
		System.out.println(Coffee3.Coffee+"  "+Coffee3.Size+"  "+Coffee3.Price+"  "+Coffee3.Cal+"\n");
		System.out.println(Coffee4.Coffee+"  "+Coffee4.Size+"   "+Coffee4.Price+"  "+Coffee4.Cal+"\n");
		System.out.println(Coffee5.Coffee+"       "+Coffee5.Size+"  "+Coffee5.Price+"  "+Coffee5.Cal+"\n");
		System.out.println(Coffee6.Coffee+"       "+Coffee6.Size+"   "+Coffee6.Price+"  "+Coffee6.Cal+"\n");
		System.out.println(Coffee7.Coffee+"       "+Coffee7.Size+"  "+Coffee7.Price+"  "+Coffee7.Cal+"\n");
		System.out.println(Coffee8.Coffee+"       "+Coffee8.Size+"   "+Coffee8.Price+"  "+Coffee8.Cal+"\n");
		System.out.println(Coffee9.Coffee+"   "+Coffee9.Size+"  "+Coffee9.Price+"  "+Coffee9.Cal+"\n");
		System.out.println(Coffee10.Coffee+"   "+Coffee10.Size+"   "+Coffee10.Price+"  "+Coffee10.Cal+"\n");
		System.out.println("本咖啡廳提供以下客製化甜度：no/low/half/less/normal\n");
		System.out.println("以及以下客製化冰塊量：no/low/half/less/normal\n");
		System.out.println("================================\n請參照上表點餐，先打add 再依次輸入：品名 大小 甜度 冰塊 份數\n如2杯中杯美式微糖少冰請輸入\nadd Americano Medium less less 2\n\n或輸入help來查看所有指令");
		ArrayList <String>DrinksList=new ArrayList<>();//飲品清單
		ArrayList <Integer> Cups= new ArrayList<>();//杯數清單
		ArrayList <Double> Cal= new ArrayList<>();
		ArrayList <Double> Price= new ArrayList<>();//價錢清單
		String CommandHead="initial";
		while (!"bill".equals(CommandHead)){
		String Command=scan.nextLine();//輸入指令
		String [] SplitCommand=Command.split("\\ ");//解構指令
		CommandHead=SplitCommand[0];//將指令匯入CommandHead，以便後續辨別
		String commandhead=CommandHead.toLowerCase();//將指令小寫使其不區分大小寫
		if("add".equals(commandhead)){//執行"添加"相關指令
		if(SplitCommand.length!=6){//檢查add指令是否大致符合格式（以免陣列長度不合直接跳出）
			System.out.println("輸入的add指令格式不合，請重新檢查格式如下：\nadd 品名 大小 甜度 冰塊 份數（注意需用空格隔開）");
			continue;
		}
		Command=Command.substring(4);//移除add字串增加飲品清單易讀性
		String CommandCup=SplitCommand[5];//提取飲品杯數的部分
		int RealCup=Integer.valueOf(CommandCup);//將杯數由String改成int
		DrinksList.add(Command);//把品名等詳細資料寫入飲品清單
		String CommandCoffee=SplitCommand[1];
		String COMMANDCOFFEE=CommandCoffee.toUpperCase();
		String CommandSize=SplitCommand[2];
		String COMMANDSIZE=CommandSize.toUpperCase();
		String CommandSugar=SplitCommand[3];
		String COMMANDSUGAR=CommandSugar.toUpperCase();
		String CommandIce=SplitCommand[4];
		String COMMANDICE=CommandIce.toUpperCase();
		//將指令全部大寫，以達成不分大小寫
		//拆解添加的咖啡的詳細參數，以便後續dubug
		boolean CoffeeCheck=true;
		boolean SizeCheck=true;
		boolean SugarCheck=true;
		boolean IceCheck=true;
		for(int i=0;i<5;i++){//檢查咖啡種類
			CoffeeCheck=(CoffeeType[i].equals(COMMANDCOFFEE));
			if(CoffeeCheck){//確認無誤跳出迴圈
				break;}
		}
		if(CoffeeCheck!=true){//若咖啡格式不合，重新輸入
			System.out.println("添加的咖啡品項不存在或格式錯誤，請重新輸入\n（不分大小寫）");
			DrinksList.remove(Command);
		continue;
		}
		for(int i=0;i<2;i++){//檢查咖啡大小
			SizeCheck=(SizeType[i].equals(COMMANDSIZE));
			if(SizeCheck){//確認無誤跳出迴圈
				break;}
		}
		if(SizeCheck!=true){//若咖啡大小不合，重新輸入
			System.out.println("添加的咖啡大小不存在或格式錯誤，請重新輸入\n（不分大小寫）");
			DrinksList.remove(Command);
			continue;
		}
		for(int i=0;i<5;i++){//檢查咖啡甜度
			SugarCheck=(IceSugar[i].equals(COMMANDSUGAR));
			if(SugarCheck){//確認無誤跳出迴圈
				break;}
		}
		if(SugarCheck!=true){//咖啡甜度格式不合，重新輸入
			System.out.println("添加的咖啡甜度不存在或格式錯誤，請重新輸入\n（注意甜度全為小寫）");
			DrinksList.remove(Command);
			continue;
		}
		for(int i=0;i<5;i++){//檢查咖啡冰塊
			IceCheck=(IceSugar[i].equals(COMMANDICE));
			if(IceCheck){//確認無誤跳出迴圈
				break;}
		}
		if(IceCheck!=true){//咖啡冰塊格式不合，重新輸入
			System.out.println("添加的咖啡冰塊不存在或格式錯誤，請重新輸入\n（注意冰塊全為小寫）");
			DrinksList.remove(Command);
			continue;
		}
		if(RealCup<1){//檢查杯數格式
			System.out.println("輸入的杯數格式不符，請重新檢查\n（僅能輸入大於等於1的整數）");
			DrinksList.remove(Command);//移除不合的指令
			continue;
		}
		}//add指令大括號
		else if("check".equals(commandhead)){//執行"檢查"相關指令
			Cal.clear();//清空熱量表
			Cups.clear();//清空杯數表
			Price.clear();//清空價格表，以免更改後價格與熱量仍為舊值
			for(int i=0;i<DrinksList.size();i++){//計算咖啡熱量、價錢
			String Calculate=DrinksList.get(i);
			int CalculateCoffeeNumber=0;
			int CalculateSugarNumber=0;
			boolean CalculateCoffee=true;
			boolean CalculateSugar=true;
			String[] NowCalculate=Calculate.split("\\ ");
			String CalculateCoffeeName=NowCalculate[0];//獨立出咖啡名稱
			CalculateCoffeeName=CalculateCoffeeName.toUpperCase();
			String CalculateCoffeeSize=NowCalculate[1];//獨立出咖啡大小
			CalculateCoffeeSize=CalculateCoffeeSize.toUpperCase();
			String CalculateSugarType=NowCalculate[2];//獨立出糖份
			CalculateSugarType=CalculateSugarType.toUpperCase();
			String CalculateCups=NowCalculate[4];//獨立出杯數
			int CalculateRealCup=Integer.valueOf(CalculateCups);//將杯數由String改成int
			Cups.add(CalculateRealCup);//杯數寫入杯數清單
			for(int I=0;I<5;I++){//找出咖啡編號
				CalculateCoffee=(CoffeeType[I].equals(CalculateCoffeeName));
				if(CalculateCoffee){
				CalculateCoffeeNumber=I;
				break;}
				}
			for(int I=0;I<5;I++){//找出糖份編號
				CalculateSugar=(IceSugar[I].equals(CalculateSugarType));
				if(CalculateSugar){
				CalculateSugarNumber=I;
				break;}
				}
			if ("MEDIUM".equals(CalculateCoffeeSize)){//計算該命令在熱量表的位置
				CalculateCoffeeNumber=CalculateCoffeeNumber*2;
				}
			else{
				CalculateCoffeeNumber=CalculateCoffeeNumber*2+1;
				}
			double CalculateCoffeeCal=BasicCal[CalculateCoffeeNumber]+SugarCal[CalculateSugarNumber];
			double CalculateCoffeePrice=BasicPrice[CalculateCoffeeNumber];
			Cal.add(CalculateCoffeeCal);
			Price.add(CalculateCoffeePrice);
			//System.out.println(CalculateCoffeeNumber);
			}
			System.out.println("您目前所點的飲品如下：");
			for(int i=0;i<DrinksList.size();i++ ){//印出名細 i+1為編號 價格為單項總價
				System.out.println(i+1+"."+DrinksList.get(i)+"\n小計："+Price.get(i)*Cups.get(i)+"  熱量："+Cal.get(i)+"大卡");
			}
			System.out.println("請接續輸入指令，如需結帳請輸入bill，如需更改則輸入edit，或輸入help查看指令表及說明");
		}
		else if("edit".equals(commandhead)){//執行"編輯"相關指令
		if(SplitCommand.length!=4){//檢查edit指令是否大致符合格式（以免陣列長度不合直接跳出）
				System.out.println("輸入的edit指令格式不合，請重新檢查格式如下：\nedit 單號 修改項目 修改後結果（注意需用空格隔開）");
				continue;
			}
		String CommandEditNubmer=SplitCommand[1];//把欲更改的單號挑出
		int EditNumber=Integer.valueOf(CommandEditNubmer);//把單號改成int
		String EditTitle=SplitCommand[2];//獨立出修改項目
		String EditResult=SplitCommand[3];//獨立出修改結果
		EditTitle=EditTitle.toUpperCase();//修改項目大寫，方便使用者
		String EDITRESULT=EditResult.toUpperCase();//項目結果大寫，方便使用者
		int DrinksListSize=DrinksList.size();
		if (EditNumber>DrinksListSize){//檢查欲更改的單號存不存在
		System.out.println("更改的訂單單號不存在請重新檢查");
		continue;
		}
		String EditLine=DrinksList.get(EditNumber-1);//讀取欲修改的單號
		String [] SplitEdit=EditLine.split("\\ ");//再次解構欲分解的單號
		String AfterEdit ="";
		boolean EditCheck=true;
		if ("SIZE".equals(EditTitle)){//更改大小
			for(int i=0;i<2;i++){//檢查咖啡大小
				EditCheck=(SizeType[i].equals(EDITRESULT));
				if(EditCheck){//確認無誤跳出迴圈
					break;}
			}
			if(EditCheck!=true){//若咖啡大小不合，重新輸入
				System.out.println("編輯的咖啡大小不存在或格式錯誤，請重新輸入\n（不分大小寫）");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+EditResult+" "+SplitEdit[2]+" "+SplitEdit[3]+" "+SplitEdit[4];
		}
		else if ("SUGAR".equals(EditTitle)){//更改甜度
			for(int i=0;i<5;i++){//檢查咖啡甜度格式
				EditCheck=(IceSugar[i].equals(EDITRESULT));
				if(EditCheck){//確認無誤跳出迴圈
					break;}
			}
			if(EditCheck!=true){//若咖啡甜度不合，重新輸入
				System.out.println("編輯的咖啡甜度不存在或格式錯誤，請重新輸入\n（不分大小寫）");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+EditResult+" "+SplitEdit[3]+" "+SplitEdit[4];
		}
		else if ("ICE".equals(EditTitle)){//更改冰塊
			for(int i=0;i<5;i++){//檢查咖啡冰塊格式
				EditCheck=(IceSugar[i].equals(EDITRESULT));
				if(EditCheck){//確認無誤跳出迴圈
					break;}
			}
			if(EditCheck!=true){//若咖啡冰塊不合，重新輸入
				System.out.println("編輯的咖啡冰塊不存在或格式錯誤，請重新輸入\n（不分大小寫）");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+SplitEdit[2]+" "+EditResult+" "+SplitEdit[4];
		}
		else if ("QUANTITY".equals(EditTitle)){//更改數量
			int EditQuantity=Integer.valueOf(EditResult);//把單號改成int
			if(EditQuantity<1){
			System.out.println("更改的杯數格式不合（不得小於1），請重新輸入");
			continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+SplitEdit[2]+" "+SplitEdit[3]+" "+EditResult;
		}
		else{//若都不符合，請使用者重新輸入
			System.out.println("輸入的edit指令格式不合，請重新檢查格式如下：\nedit 單號 修改項目 修改後結果（注意需用空格隔開）\n修該項目支援：大小size甜度sugar冰塊ice份數quantity");
				continue;
		}
		DrinksList.remove(EditNumber-1);//移除舊的錯誤指令
		DrinksList.add(EditNumber-1,AfterEdit);//新增新的正確指令
		System.out.println("成功將"+EditNumber+"筆餐點改為\n"+AfterEdit);//回傳成功通知
		}//edit大括號
		else if("menu".equals(commandhead)){//執行"菜單"相關指令
		System.out.println("================================\n品名        "+"大小    "+"價格  "+"熱量");
		System.out.println(Coffee1.Coffee+"   "+Coffee1.Size+"  "+Coffee1.Price+"  "+Coffee1.Cal+"\n");
		System.out.println(Coffee2.Coffee+"   "+Coffee2.Size+"   "+Coffee2.Price+"  "+Coffee2.Cal+"\n");
		System.out.println(Coffee3.Coffee+"  "+Coffee3.Size+"  "+Coffee3.Price+"  "+Coffee3.Cal+"\n");
		System.out.println(Coffee4.Coffee+"  "+Coffee4.Size+"   "+Coffee4.Price+"  "+Coffee4.Cal+"\n");
		System.out.println(Coffee5.Coffee+"       "+Coffee5.Size+"  "+Coffee5.Price+"  "+Coffee5.Cal+"\n");
		System.out.println(Coffee6.Coffee+"       "+Coffee6.Size+"   "+Coffee6.Price+"  "+Coffee6.Cal+"\n");
		System.out.println(Coffee7.Coffee+"       "+Coffee7.Size+"  "+Coffee7.Price+"  "+Coffee7.Cal+"\n");
		System.out.println(Coffee8.Coffee+"       "+Coffee8.Size+"   "+Coffee8.Price+"  "+Coffee8.Cal+"\n");
		System.out.println(Coffee9.Coffee+"   "+Coffee9.Size+"  "+Coffee9.Price+"  "+Coffee9.Cal+"\n");
		System.out.println(Coffee10.Coffee+"   "+Coffee10.Size+"   "+Coffee10.Price+"  "+Coffee10.Cal+"\n");
		System.out.println("甜度：no/low/half/less/normal\n");
		System.out.println("冰塊：no/low/half/less/normal\n");
		System.out.println("================================\n請參照上表點餐，先打add 再依次輸入：品名 大小 甜度 冰塊 份數\n如2杯中杯美式微糖少冰請輸入\nadd Americano Medium less less 2\n\n或輸入help來查看所有指令");
		}
		else if("help".equals(commandhead)){//執行"幫助"相關指令	
		System.out.println("本點餐系統的指令及詳細說明如下\n");
		System.out.println("1.add 品名 大小 甜度 冰塊 份數");
		System.out.println("新增咖啡至餐點明細中。以下為新增2杯大杯卡布奇諾半糖少冰至明細中。\nadd Cappuccino large half less 2\n");
		System.out.println("2.check");
		System.out.println("顯示目前所有的餐點明細，包含 編號、飲品、大小、甜度、 冰塊、份數、價格以及熱量。\n");
		System.out.println("3.edit 編號 項目 內容");
		System.out.println("可編輯某一則餐點明細中的 大小(size)、甜度(sugar)、冰 塊(ice)、份數(quantity)。以下為將第一則餐點中的大小改為medium。\nedit 1 size medium\n");
		System.out.println("4.menu");
		System.out.println("顯示可選購的飲品，包含價 格及熱量。\n");
		System.out.println("5.help");
		System.out.println("列出所有指令集，並說明各 個指令的功能。\n");
		System.out.println("6.delete");
		System.out.println("刪除該次點餐紀錄。例如刪除第三筆\ndelete 3\n");
		System.out.println("7.bill");
		System.out.println("進行結帳，列出所有餐點明細和總價\n");
		System.out.println("註：本系統所有指令均不分大小寫。");
		}
		else if("delete".equals(commandhead)){//執行"刪除"相關指令
		if(SplitCommand.length!=2){//檢查delete指令是否大致符合格式（以免陣列長度不合直接跳出）
				System.out.println("輸入的delete指令格式不合，請重新檢查格式如下：\ndelete 單號");
				continue;
			}
		String DeleteNubmer=SplitCommand[1];//把欲刪除的單號挑出
		int RealDeleteNumber=Integer.valueOf(DeleteNubmer);//把單號改成int
		DrinksList.remove(RealDeleteNumber-1);
		System.out.println("成功刪除第"+RealDeleteNumber+"筆餐點");//回傳成功通知
		}
		else if("bill".equals(commandhead)){//跳出迴圈進行結帳
		//重新執行一次check指令（為印出明細
		Cal.clear();//清空熱量表
			Cups.clear();//清空杯數表
			Price.clear();//清空價格表，以免更改後價格與熱量仍為舊值
			for(int i=0;i<DrinksList.size();i++){//計算咖啡熱量、價錢
			String Calculate=DrinksList.get(i);
			int CalculateCoffeeNumber=0;
			int CalculateSugarNumber=0;
			boolean CalculateCoffee=true;
			boolean CalculateSugar=true;
			String[] NowCalculate=Calculate.split("\\ ");
			String CalculateCoffeeName=NowCalculate[0];//獨立出咖啡名稱
			CalculateCoffeeName=CalculateCoffeeName.toUpperCase();
			String CalculateCoffeeSize=NowCalculate[1];//獨立出咖啡大小
			CalculateCoffeeSize=CalculateCoffeeSize.toUpperCase();
			String CalculateSugarType=NowCalculate[2];//獨立出糖份
			CalculateSugarType=CalculateSugarType.toUpperCase();
			String CalculateCups=NowCalculate[4];//獨立出杯數
			int CalculateRealCup=Integer.valueOf(CalculateCups);//將杯數由String改成int
			Cups.add(CalculateRealCup);//杯數寫入杯數清單
			for(int I=0;I<5;I++){//找出咖啡編號
				CalculateCoffee=(CoffeeType[I].equals(CalculateCoffeeName));
				if(CalculateCoffee){
				CalculateCoffeeNumber=I;
				break;}
				}
			for(int I=0;I<5;I++){//找出糖份編號
				CalculateSugar=(IceSugar[I].equals(CalculateSugarType));
				if(CalculateSugar){
				CalculateSugarNumber=I;
				break;}
				}
			if ("MEDIUM".equals(CalculateCoffeeSize)){//計算該命令在熱量表的位置
				CalculateCoffeeNumber=CalculateCoffeeNumber*2;
				}
			else{
				CalculateCoffeeNumber=CalculateCoffeeNumber*2+1;
				}
			double CalculateCoffeeCal=BasicCal[CalculateCoffeeNumber]+SugarCal[CalculateSugarNumber];
			double CalculateCoffeePrice=BasicPrice[CalculateCoffeeNumber];
			Cal.add(CalculateCoffeeCal);
			Price.add(CalculateCoffeePrice);
			//System.out.println(CalculateCoffeeNumber);
			}
			System.out.println("您目前所點的飲品如下：");
			for(int i=0;i<DrinksList.size();i++ ){//印出名細 i+1為編號 價格為單項總價
				System.out.println(i+1+"."+DrinksList.get(i)+"\n小計："+Price.get(i)*Cups.get(i)+"  熱量："+Cal.get(i)+"大卡");
			}
		}
		else{//若不合任何指令，要求重新輸入
			System.out.println("輸入的指令格式不符，請重新檢查（不分大小寫）。或輸入help查看指令表及說明");
		}
		}//While迴圈的大括號
		//進行結帳，開始計算總價
		int[] BillCups=new int[10];//宣告一個int陣列，用於儲存各種大小咖啡的杯數
		int DrinksListSize=DrinksList.size();
		for(int i=0;i<DrinksListSize;i++){//計杯迴圈
			String NowBill=DrinksList.get(i);//獨立出現在要計杯的單號
			String [] NowBillArray=NowBill.split("\\ ");
			String BillCoffee=NowBillArray[0];
			BillCoffee=BillCoffee.toUpperCase();
			int BillCoffeeNumber=0;
			String BillSize=NowBillArray[1];
			BillSize=BillSize.toUpperCase();
			Boolean BillCoffeeMatch=true;
			for(int I=0;I<5;I++){//找出咖啡編號
				BillCoffeeMatch=(CoffeeType[I].equals(BillCoffee));
				if(BillCoffeeMatch){
				BillCoffeeNumber=I;
				break;}
				}
			if ("MEDIUM".equals(BillSize)){//計算該單號的咖啡編號
				BillCoffeeNumber=BillCoffeeNumber*2;
				}
			else{
				BillCoffeeNumber=BillCoffeeNumber*2+1;
				}
			BillCups[BillCoffeeNumber]=BillCups[BillCoffeeNumber]+Cups.get(i);
		}//計杯迴圈大括號
		double Sum=0;
		for(int i=0;i<5;i++){
			double note=0;
			int M=BillCups[2*i];//表中杯
			int L=BillCups[2*i+1];//表大杯
			double MP=BasicPrice[2*i];
			double LP=BasicPrice[2*i+1];
			//int count=i;
			if(M>L){//當中杯比大杯多
			int ML=(M-L)/2;//中杯第二杯半價組數
				note=L*(MP*0.5+LP)+(MP*1.5)*ML+((M-L)-ML*2)*MP;
			}
			else if(M==L){//中杯跟大杯杯數相同
				note=M*(MP*0.5+LP);
			}
			else if(M<L){//大杯比中杯多
				int LM=(L-M)/2;//大悲第二杯半價組數
				note=M*(MP*0.5+LP)+(LP*1.5)*LM+((L-M)-LM*2)*LP;
			}
			double Check=note%1;
			if(Check==0.5){//將小計四捨五入
			note=note +0.5;
			}
			Sum=Sum+note;
		}
		DecimalFormat FinalSum =new DecimalFormat("0.#"); 
		System.out.println("\n本次訂單總金額為"+FinalSum.format(Sum)+"元。感謝您使用本點餐系統，期待您再次蒞臨。");
	}
}

