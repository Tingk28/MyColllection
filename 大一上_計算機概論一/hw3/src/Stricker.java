import java.util.Scanner;
public class Stricker{
	Scanner scan= new Scanner(System.in);
	private int ID;//打者編號
	private int energy=3;//打者剩餘能量，預設為3
	private String ball;//打者擅長的球種
	
	public void setID(){//設定打者編號
		System.out.print("設定打者編號（須為正整數）：");
		while(1==1){
			try{
				ID =scan.nextInt();
				if(ID<1){
					System.out.print("輸入的打者編號須為正整數，請重新輸入：");
				}
				else{
					break;
				}
			}
			catch(Exception e){
				System.out.print("輸入的打者編號須為正整數，請重新輸入：");
				scan.next();
			}
		}
	}
	String [] BallType ={"a","b","c","d","e","f","g"};
	int i=0;
	public void setball(){//設定擅長球種
		System.out.print("參照上表設定打者擅長打擊的球種代碼。");
		while(1==1){//輸入第一種擅長的球種，並檢查有沒有錯
			ball=scan.next();
			ball=ball.toLowerCase();
			boolean check=BallType[i].equals(ball);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ball);
				if(BallType[i].equals(ball)){
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
	public int getID(){//回傳投手編號
		return ID;
	}
	public int getenergy(){//回傳剩餘能量
		return energy;
	}
	public String getball(){//回傳第一種擅長球種
		return ball;
	}
	public void getdataforpitcher(){
		System.out.println("\n球員號碼："+ID+"\n剩餘可投球次數："+energy);
	}
	public void getdata(){
		System.out.println("\n球員號碼："+ID+"\n剩餘可投球次數："+energy+"\n擅長的球種："+ball);
	}
	public void strick(){
		energy-=1;
	}
}