import java.util.Scanner;
public class Pitcher {
	Scanner scan = new Scanner(System.in);
	private int ID;//投手編號
	private int energy=10;//投手能量值，且預設為10點
	private String side;//左右投
	private String high;//上肩/低肩投
	private String ballA;//第一種擅長球種
	private String ballB;//第二種擅長球種
	private String ballC;//第三種擅長球種
	private boolean OnorNot=false;//是否在場上
	
	public void setID(){//設定投手編號
		System.out.print("設定投手編號（須為正整數）：");
		while(1==1){
			try{
				ID =scan.nextInt();
				if(ID<1){
					System.out.print("輸入的投手編號須為正整數，請重新輸入：");
				}
				else{
					break;
				}
			}
			catch(Exception e){
				System.out.print("輸入的投手編號須為正整數，請重新輸入：");
				scan.next();
			}
		}
	}
	public void setenergy(int E){//設定能量
		energy=E;
	}
	public void setside(){//設定左右投
		System.out.println("設定投球的手\n（輸入left為左投；輸入right為右投）");
		while(1==1){//輸入並檢查投球手是否符合格式
			side=scan.next();
			side=side.toLowerCase();
			if("right".equals(side)){
				break;
		}
			else if("left".equals(side)){
				break;
		}
			else{
				System.out.println("輸入用於投球的手不符，請重新輸入");
		}
	}
	}
	public void sethigh(){//設定上/低肩投
		System.out.println("設定投手為上／低肩投\n（輸入up為上肩投；輸入down為低肩投）");
		while(1==1){//輸入並檢查投手上／低肩投是否符合格式
			high=scan.next();
			high=high.toLowerCase();
			if("up".equals(high)){
				break;
			}
			else if("down".equals(high)){
				break;
			}
			else{
				System.out.println("輸入投手上／低肩投不符，請重新輸入");
			}
	}
	}
	String [] BallType ={"a","b","c","d","e","f","g"};
	int i=0;
	public void setballA(){//設定第一種擅長球種
		System.out.print("參照上表設定投手第一種擅長球種代碼\n");
		while(1==1){//輸入第一種擅長的球種，並檢查有沒有錯
			ballA=scan.next();
			ballA=ballA.toLowerCase();
			boolean check=BallType[i].equals(ballA);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ballA);
				if(BallType[i].equals(ballA)){
					break;
				}
			}
			if(check){
				break;
			}
			else{
				System.out.println("輸入的擅長球種不存在，請重新確認");
			}
		}//while迴圈大括號
	}
	public void setballB(){//設定第二種擅長球種
		System.out.print("參照上表設定投手第二種擅長球種代碼\n");
		while(1==1){//輸入第二種擅長的球種，並檢查有沒有錯
			ballB=scan.next();
			ballB=ballB.toLowerCase();
			boolean check=BallType[i].equals(ballB);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ballB);
				if(BallType[i].equals(ballB)){
					break;
				}
			}
			if(check){//檢查第一二種擅長球種是否重複
				if(ballA.equals(ballB)){
					System.out.println("輸入擅長的球種與第一種重複，請重新輸入");
				}
				else{
					break;
				}
			}
			else{//若全部不合
			System.out.println("輸入的擅長球種不存在，請重新確認");
			}
		}//while迴圈大括號
	}
	public void setballC(){//設定第三種擅長球種
		System.out.print("參照上表設定投手第三種擅長球種代碼\n");
		while(1==1){//輸入第三種擅長的球種，並檢查有沒有錯
			ballC=scan.next();
			ballC=ballC.toLowerCase();
			boolean check=BallType[i].equals(ballC);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ballC);
				if(BallType[i].equals(ballC)){
					break;
				}
			}
		if(check){//檢查第一二種擅長球種是否重複
			if(ballA.equals(ballC)){//和第一種擅長球比
				System.out.println("輸入擅長的球種與第一種重複，請重新輸入");
			}
			else if(ballB.equals(ballC)){//和第二種擅長球比
				System.out.println("輸入擅長的球種與第二種重複，請重新輸入");
			}
			else{
				break;
			}
		}
		else{//若全部不合
		System.out.println("輸入的擅長球種不存在，請重新確認");
		}
		}
	}
	public void setOnorNot(boolean onornot){
		OnorNot=onornot;
	}
	public int getID(){//回傳投手編號
		return ID;
	}
	public int getenergy(){//回傳剩餘能量
		return energy;
	}
	public String getside(){//回傳左右投
		return side;
	}
	public String gethigh(){//回傳高/低肩投
		return high;
	}
	public String getballA(){//回傳第一種擅長球種
		return ballA;
	}
	public String getballB(){//回傳第二種擅長球種
		return ballB;
	}
	public String getballC(){//回傳第三種擅長球種
		return ballC;
	}
	public boolean getOnorNot(){//回傳在場上與否
		return OnorNot;
	}
	public void getdataforstricker(){
		System.out.println("\n球員號碼："+ID+"\n剩餘可投球次數："+energy);
	}
	public void getdata(){
		System.out.println("\n球員號碼："+ID+"\n剩餘可投球次數："+energy+"\n擅長的球種："+ballA+","+ballB+","+ballC);
	}
	public void pitch(){
		energy-=1;
		if(energy==0){
		OnorNot=false;
		}
	}
}