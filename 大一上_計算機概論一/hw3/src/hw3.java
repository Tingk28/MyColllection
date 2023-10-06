import java.util.Scanner;
public class hw3 {
	public static void main (String[] args){
		Scanner scan = new Scanner(System.in);
		int point=0;//玩家乙的總得分
		Pitcher pitcher1 =new Pitcher();
		Pitcher pitcher2 =new Pitcher();
		Pitcher pitcher3 =new Pitcher();
		Stricker stricker1= new Stricker();
		Stricker stricker2= new Stricker();
		Stricker stricker3= new Stricker();
		Stricker stricker4= new Stricker();
		Stricker stricker5= new Stricker();
		Stricker stricker6= new Stricker();//創建三個投手六個打者的object
		System.out.println("歡迎遊玩本棒球小遊戲，遊玩方法請參照readme.text");//歡迎訊息
		//由玩家甲操作
		System.out.println("玩家甲擔任投手方，並開始設定投手資料");
		System.out.println("《設定第一名投手》");//設定第一名投手資料
		pitcher1.setID();
		pitcher1.setside();
		pitcher1.sethigh();
		System.out.print("a 快速球 b 曲球 c 滑球 d 變速球 e 指叉球 f 伸卡球 \n");
		pitcher1.setballA();
		pitcher1.setballB();
		pitcher1.setballC();
		System.out.println("===============================");	
		System.out.println("《設定第二名投手》");//設定第二名投手資料
		while(1==1){//設定第二位投手的編號，並檢查不得與第一個重複
			pitcher2.setID();
			if(pitcher1.getID()==pitcher2.getID()){
				System.out.println("投手二的球員號碼不得與投手一相同，請重新輸入");
			}
			else{
				break;
			}
		}
		pitcher2.setside();
		pitcher2.sethigh();
		System.out.print("a 快速球 b 曲球 c 滑球 d 變速球 e 指叉球 f 伸卡球 \n");
		pitcher2.setballA();
		pitcher2.setballB();
		pitcher2.setballC();
		System.out.println("===============================");	
		System.out.println("《設定第三名投手》");//設定第三名投手資料
		while(1==1){//設定第三位投手的編號，並檢查不得與第一個重複
			pitcher3.setID();
			if(pitcher1.getID()==pitcher3.getID()){
				System.out.println("投手三的球員號碼不得與投手一相同，請重新輸入");
			}
			else if(pitcher2.getID()==pitcher3.getID()){
				System.out.println("投手三的球員號碼不得與投手二相同，請重新輸入");
			}
			else{
				break;
			}
		}
		pitcher3.setside();
		pitcher3.sethigh();
		System.out.print("a 快速球 b 曲球 c 滑球 d 變速球 e 指叉球 f 伸卡球 \n");
		pitcher3.setballA();
		pitcher3.setballB();
		pitcher3.setballC();
		System.out.println("===============================");
		try{//投手資料設定完成，清空畫面
			new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		}
		catch(Exception e){
			System.out.println("Fail");
		}
		//開始改由玩家乙操作
		System.out.println("玩家乙擔任打者方，並開始設定打者資料\n");
		System.out.println("《設定第一名打者》");//設定第一名打者資料
		stricker1.setID(); //設定球員一號碼
		System.out.println("a 快速球 b 曲球 c 滑球 d 變速球 e 指叉球 f 伸卡球 \n");
		stricker1.setball();
		System.out.println("=========================================");
		System.out.println("《設定第二名打者》");//設定第二名打者資料
		while(1==1){//設定球員二號碼
			stricker2.setID();
			if(stricker1.getID()==stricker2.getID()){
				System.out.println("打者二的球員號碼不得與打者一相同，請重新輸入");
			}
			else{
				break;
			}
		}
		stricker2.setball();
		System.out.println("=========================================");
		System.out.println("《設定第三名打者》");//設定第三名打者資料
		while(1==1){//設定球員三號碼
			stricker3.setID();
			if(stricker3.getID()==stricker1.getID()){
				System.out.println("打者三的球員號碼不得與打者一相同，請重新輸入");
			}
			else if(stricker3.getID()==stricker2.getID()){
				System.out.println("打者三的球員號碼不得與打者二相同，請重新輸入");
			}
			else{
				break;
			}
		}
		stricker3.setball();
		System.out.println("=========================================");
		System.out.println("《設定第四名打者》");//設定第四名打者資料
		while(1==1){//設定球員四號碼
			stricker4.setID();
			if(stricker4.getID()==stricker1.getID()){
				System.out.println("打者四的球員號碼不得與打者一相同，請重新輸入");
			}
			else if(stricker4.getID()==stricker2.getID()){
				System.out.println("打者四的球員號碼不得與打者二相同，請重新輸入");
			}
			else if(stricker4.getID()==stricker3.getID()){
				System.out.println("打者四的球員號碼不得與打者三相同，請重新輸入");
			}
			else{
				break;
			}
		}
		stricker4.setball();
		System.out.println("=========================================");
		System.out.println("《設定第五名打者》");//設定第五名打者資料
		while(1==1){//設定球員五號碼
			stricker5.setID();
			if(stricker5.getID()==stricker1.getID()){
				System.out.println("打者五的球員號碼不得與打者一相同，請重新輸入");
			}
			else if(stricker5.getID()==stricker2.getID()){
				System.out.println("打者五的球員號碼不得與打者二相同，請重新輸入");
			}
			else if(stricker5.getID()==stricker3.getID()){
				System.out.println("打者五的球員號碼不得與打者三相同，請重新輸入");
			}
			else if(stricker5.getID()==stricker4.getID()){
				System.out.println("打者五的球員號碼不得與打者四相同，請重新輸入");
			}
			else{
				break;
			}
		}
		stricker5.setball();
		System.out.println("=========================================");
		System.out.println("《設定第六名打者》");//設定第六名打者資料
		while(1==1){//設定球員六號碼
			stricker6.setID();
			if(stricker6.getID()==stricker1.getID()){
				System.out.println("打者六的球員號碼不得與打者一相同，請重新輸入");
			}
			else if(stricker6.getID()==stricker2.getID()){
				System.out.println("打者六的球員號碼不得與打者二相同，請重新輸入");
			}
			else if(stricker6.getID()==stricker3.getID()){
				System.out.println("打者六的球員號碼不得與打者三相同，請重新輸入");
			}
			else if(stricker6.getID()==stricker4.getID()){
				System.out.println("打者六的球員號碼不得與打者四相同，請重新輸入");
			}
			else if(stricker6.getID()==stricker5.getID()){
				System.out.println("打者六的球員號碼不得與打者五相同，請重新輸入");
			}
			else{
				break;
			}
		}
		stricker6.setball();
		System.out.println("=========================================");
		try{//打者資料設定完成，清空畫面
			new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		}
		catch(Exception e){
			System.out.println("Fail");
		}
		Pitcher [] pitcherlist={pitcher1,pitcher2,pitcher3};
		Stricker [] strickerlist={stricker1,stricker2,stricker3,stricker4,stricker5,stricker6};
		/*int [] point={{1,2,3},{4,5,6},{7,8,9}}
		String [] hitpoint={{?,?,?},{?,?,?}{?,?,?}}*/
		int CountofPitcherOn=-1;//目前上場的投手序號
		int CountofStrickerOn=0;//目前上場的打者序號
		//遊戲開始
		while(stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy()>0&&pitcher1.getenergy()+pitcher2.getenergy()+pitcher3.getenergy()>0){
			System.out.println("請玩家甲挑選投手：投手狀態如下");//進入挑選階段
			boolean AnyPitcherOn=false;//是否有投手上場
			System.out.println("\n《目前上場的投手：》");
			for(int i=0;i<3;i++){//輸出目前在場上的投手
				if(pitcherlist[i].getOnorNot()){
					pitcherlist[i].getdata();
					AnyPitcherOn=true;
					break;
				}
				else if(pitcherlist[i].getOnorNot()==false&&i==2){//都沒有則顯示無
					System.out.print("無\n");
					AnyPitcherOn=false;
				}
			}
			System.out.println("===========================\n《尚未上場的投手》");
			for(int i=0;i<3;i++){//輸出不在場上的投手
				if(pitcherlist[i].getOnorNot()==false){
					pitcherlist[i].getdata();
				}
			}
			System.out.println("===========================\n《敵方尚有上場機會的打者》");
			for(int i=0;i<6;i++){//輸出敵方尚有上場機會的打者
				if(strickerlist[i].getenergy()>0){
					System.out.print(i+1+".");
					strickerlist[i].getdataforpitcher();
				}
			}
			System.out.println("===========================\n《請選擇上場的投手》\n指令：select pitcher [投手球員號碼]，或輸入continue續用");
			while(1==1){//pitcher select while迴圈
				String PickPitcher=scan.nextLine();//輸入挑選投手的指令
				PickPitcher=PickPitcher.toLowerCase();//通通小寫以不區分大小寫
				int PitcherNumber;//獨立球員號碼
				String [] PickPitcherCommand=PickPitcher.split("\\ ");//解構指令
				if(PickPitcherCommand.length==3){//當使用select指令
					try{
						PitcherNumber=Integer.valueOf(PickPitcherCommand[2]);//把球員號碼轉成int
					}
					catch(Exception e){
						System.out.println("輸入的球員號碼錯誤，請重新輸入");
						continue;
					}
					if("select".equals(PickPitcherCommand[0])==false){//如select單字不合
					System.out.println("輸入的select指令有誤\n應為：select pitcher [投手球員號碼]");
					continue;//跳出要求重新輸入
					}
					if("pitcher".equals(PickPitcherCommand[1])==false){//如pitcher單字不合
					System.out.println("輸入的select指令有誤\n應為：select pitcher [投手球員號碼]");
					continue;//跳出要求重新輸入
					}
					boolean numernotmatch=false;
					boolean noenergy=false;
					for(int i=0;i<3;i++){//檢查球員號碼存在與否
						if(PitcherNumber==pitcherlist[i].getID()){//當號碼存在
							if(pitcherlist[i].getenergy()>0){//則檢查是否還有體力
								if(CountofPitcherOn==-1){//第一次執行程式給予投手序號初始值
									CountofPitcherOn=i;
								}
								int NewCountofPitcherOn=i;//當前投手序號為i
								if(NewCountofPitcherOn!=CountofPitcherOn){//新選擇的投手和當前投手不同
									pitcherlist[CountofPitcherOn].setenergy(0);//則將剩餘能量歸零
									pitcherlist[CountofPitcherOn].setOnorNot(false);//將上場與否改為否
									CountofPitcherOn=NewCountofPitcherOn;//更新投手序號
								}
								pitcherlist[i].setOnorNot(true);//有體力則改為上場
								break;//跳出球員檢查迴圈
							}
							else{
								noenergy=true;
							}
						}
						else if (i==2){//若全部比對完仍無符合的號碼
						System.out.println("select指令的球員號碼不存在（或體力為0），請重新檢查");
						numernotmatch=true;
						}
					}
					if(numernotmatch){//沒有對應的球員，要求重新輸入
						continue;//跳出要求重新輸入
					}
					if(noenergy){//體力不足，要求重新輸入
						continue;//沒有體力要求重新輸入
					}
					try{//上場投手設定完成，清空畫面
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;//跳出pitcher select while迴圈
				}
				else if(PickPitcherCommand.length==1&&"continue".equals(PickPitcherCommand[0])){//檢查長度符不符合，且檢查是否為continue
					if(AnyPitcherOn==false){
						System.out.println("場上無投手，無法使用continue指令");
					}
					else{
						try{//上場投手設定完成，清空畫面
							new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
						}
						catch(Exception e){
							System.out.println("Fail");
						}
						break;
					}
				}
				else{//都不合的話
				System.out.println("輸入的指令格式錯誤。\n挑選投手請輸入：select pitcher [投手球員號碼]\n繼續使用該投手則輸入continue");
				}
			}
			//開始設定上場打者
			System.out.println("《尚有機會上場的打者：》");
			for(int i=0;i<6;i++){//輸出仍有機會上場的打者
				if(strickerlist[i].getenergy()>0){
				strickerlist[i].getdata();
				}
			}
			System.out.println("===========================\n《目前在場上的投手》");
			pitcherlist[CountofPitcherOn].getdataforstricker();
			System.out.println("===========================\n《請選擇上場的打者》\n指令：select batter [打者球員號碼]");
			while(1==1){//stricker select while迴圈
				String PickStricker=scan.nextLine();//輸入挑選投手的指令
				PickStricker=PickStricker.toLowerCase();//通通小寫以不區分大小寫
				int StrickerNumber;//獨立球員號碼
				String [] PickStrickerCommand=PickStricker.split("\\ ");//解構指令
				if(PickStrickerCommand.length==3){//當使用select指令
					try{
						StrickerNumber=Integer.valueOf(PickStrickerCommand[2]);//把球員號碼轉成int
					}
					catch(Exception e){
						System.out.println("輸入的球員號碼錯誤，請重新輸入");
						continue;
					}
					if("select".equals(PickStrickerCommand[0])==false){//如select單字不合
					System.out.println("輸入的select指令有誤\n應為：select batter [打者球員號碼]");
					continue;//跳出要求重新輸入
					}
					if("batter".equals(PickStrickerCommand[1])==false){//如batter單字不合
					System.out.println("輸入的select指令有誤\n應為：select batter [打者球員號碼]");
					continue;//跳出要求重新輸入
					}
					boolean numernotmatch=false;
					boolean noenergy=false;
					for(int i=0;i<6;i++){//檢查球員號碼存在與否
						if(StrickerNumber==strickerlist[i].getID()){//當號碼存在
							if(strickerlist[i].getenergy()>0){//則檢查是否還有體力
								CountofStrickerOn=i;//將上場打者序號改為該球員
								break;//跳出球員檢查迴圈
							}
							else{
								System.out.println("select指令的球員已經沒有體力，請重新輸入");
								noenergy=true;
								break;
							}
						}
						else if (i==5){//若全部比對完仍無符合的號碼
						System.out.println("select指令的球員號碼不存在，請重新檢查");
						numernotmatch=true;
						}
					}
					if(numernotmatch){//沒有匹配的球員號碼，要求重新輸入
						continue;
					}
					if(noenergy){
						continue;
					}
					try{//上場打者設定完成，清空畫面
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;//跳出stricker select while迴圈
				}
				else{//都不合的話
				System.out.println("輸入的指令格式錯誤。\n挑選投手請輸入：select batter [打者球員號碼]");
				}
			}
			System.out.println("《目前在場上的投手》");
			pitcherlist[CountofPitcherOn].getdata();
			System.out.println("===========================\n《目前在場上的打者》\n");
			System.out.println("球員號碼："+strickerlist[CountofStrickerOn].getID());
			System.out.println("===========================\n請玩家甲選擇球種及進壘點：\n指令：pitch [球種編號] [進壘點編號] （進壘點編號為1-9正整數）");
			int PitchPoint=0;//獨立進壘點
			int SwingPoint=0;//打擊點
			String BallType=new String();
			while(1==1){//投球指令迴圈
				String PitchCommand=scan.nextLine();//輸入投球指令
				PitchCommand=PitchCommand.toLowerCase();//通通小寫以不區分大小寫
				String [] SplitPitchCommand=PitchCommand.split("\\ ");//解構指令
				if(SplitPitchCommand.length==3){//粗略檢查指令格式
					try{//避免進球點為小數造成程式退出
						PitchPoint=Integer.valueOf(SplitPitchCommand[2]);
					}
					catch(Exception e){
						System.out.println("輸入進球點錯誤，請重新輸入（須為1-9的正整數）");
						continue;
					}
					if("pitch".equals(SplitPitchCommand[0])==false){//檢查pitch拼字
						System.out.println("輸入的投球指令錯誤，請重新確認\n指令：pitch [球種編號] [進壘點編號]");
						continue;
					}
					if(pitcherlist[CountofPitcherOn].getballA().equals(SplitPitchCommand[1])){//檢查球種是否存在
						BallType=pitcherlist[CountofPitcherOn].getballA();
					}
					else if(pitcherlist[CountofPitcherOn].getballB().equals(SplitPitchCommand[1])){
						BallType=pitcherlist[CountofPitcherOn].getballB();
					}
					else if(pitcherlist[CountofPitcherOn].getballC().equals(SplitPitchCommand[1])){
						BallType=pitcherlist[CountofPitcherOn].getballC();
					}
					else{
						System.out.println("輸入擅長球種不存在，請重新確認");
						continue;
					}
					if(PitchPoint<1||PitchPoint>9){//檢查進球點存不存在
						System.out.println("輸入進球點錯誤，請重新輸入（須為1-9的正整數）");
						continue;
					}
					try{//投球點設定完成，清空畫面
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;
				}
				else{
					System.out.println("輸入的投球指令錯誤，請重新確認\n指令：pitch [球種編號] [進壘點編號]（進壘點編號為1-9正整數）");
				}
			}
			if(BallType.equals(strickerlist[CountofStrickerOn].getball())){
				System.out.println("恭喜！投手投出打者擅長球種\n唯一進壘點為："+PitchPoint);
			}
			else if (PitchPoint==1){
				System.out.println("投手投球了\n可能的進壘點為：1、2、4、5");
			}
			else if (PitchPoint==3){
				System.out.println("投手投球了\n可能的進壘點為：2、3、5、6");
			}
			else if (PitchPoint==7){
				System.out.println("投手投球了\n可能的進壘點為：4、5、7、8");
			}
			else if (PitchPoint==9){
				System.out.println("投手投球了\n可能的進壘點為：5、6、8、9");
			}
			//投手為右投上肩
			else if("right".equals(pitcherlist[CountofPitcherOn].getside())&&"up".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==2){
					System.out.println("投手投球了\n可能的進壘點為：1、2、4、5");
				}
				else if(PitchPoint==6){
					System.out.println("投手投球了\n可能的進壘點為：5、6、8、9");
				}
				else{//PitchPoint=4、5、8
					System.out.println("投手投球了\n可能的進壘點為：4、5、7、8");
				}
			}
			//投手為右投低肩
			else if("right".equals(pitcherlist[CountofPitcherOn].getside())&&"down".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==6){
					System.out.println("投手投球了\n可能的進壘點為：2、3、5、6");
				}
				else if(PitchPoint==8){
					System.out.println("投手投球了\n可能的進壘點為：4、5、7、8");
				}
				else{//PitchPoint=2、4、5
					System.out.println("投手投球了\n可能的進壘點為：1、2、4、5");
				}
			}
			//投手為左投上肩
			else if("left".equals(pitcherlist[CountofPitcherOn].getside())&&"up".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==2){
					System.out.println("投手投球了\n可能的進壘點為：2、3、5、6");
				}
				else if(PitchPoint==4){
					System.out.println("投手投球了\n可能的進壘點為：4、5、7、8");
				}
				else{//PitchPoint=5、6、8
					System.out.println("投手投球了\n可能的進壘點為：5、6、8、9");
				}
			}
			//投手為左投低肩
			else if("left".equals(pitcherlist[CountofPitcherOn].getside())&&"down".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==4){
					System.out.println("投手投球了\n可能的進壘點為：1、2、4、5");
				}
				else if(PitchPoint==8){
					System.out.println("投手投球了\n可能的進壘點為：5、6、8、9");
				}
				else{//PitchPoint=2、5、6
					System.out.println("投手投球了\n可能的進壘點為：2、3、5、6");
				}
			}
			System.out.println("===========================\n請玩家乙選擇打擊點位置\n指令為：swing [打擊點編號]（打擊點編號為1-9正整數） ");
			while(1==1){//揮棒指令迴圈
				String SwingCommand=scan.nextLine();
				SwingCommand=SwingCommand.toLowerCase();
				String [] SplitSwingCommand=SwingCommand.split("\\ ");
				if(SplitSwingCommand.length==2){
					try{//避免打擊點為小數造成程式退出
						SwingPoint=Integer.valueOf(SplitSwingCommand[1]);
					}
					catch(Exception e){
						System.out.println("輸入打擊點錯誤，請重新輸入（須為1-9的正整數）");
						continue;
					}
					if("swing".equals(SplitSwingCommand[0])==false){//檢查swing拼字
						System.out.println("輸入的swing指令有誤請重新確認\n指令為：swing [打擊點編號]");
						continue;
					}
					if(SwingPoint<1||SwingPoint>9){
						System.out.println("輸入打擊點錯誤，請重新輸入（須為1-9的正整數）");
						continue;
					}
					break;
				}
				else{
					System.out.println("輸入的swing指令有誤請重新確認\n指令為：swing [打擊點編號]");
				}
			}
			try{//打擊點設定完成，清空畫面
				new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
			}
			catch(Exception e){
				System.out.println("Fail");
			}
			String HitorNot=new String();
			if(PitchPoint==SwingPoint){
				point+=1;
				HitorNot="擊中";
			}
			else{
				HitorNot="揮空";
			}
			pitcherlist[CountofPitcherOn].pitch();
			strickerlist[CountofStrickerOn].strick();
			System.out.println("《回合結算畫面》");
			System.out.println("場上投手球員號碼："+pitcherlist[CountofPitcherOn].getID());
			System.out.println("場上打者球員號碼："+strickerlist[CountofStrickerOn].getID());
			System.out.println("打擊結果："+HitorNot);
			System.out.println("玩家乙目前得分："+point+"\n===========================");
		}
		if(stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy()>0){
			point=point+stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy();
		}
		System.out.println("玩家乙的最終得分為："+point+"分");
	}//main大括號
}//最外層大括號