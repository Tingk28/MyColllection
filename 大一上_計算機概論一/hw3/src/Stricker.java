import java.util.Scanner;
public class Stricker{
	Scanner scan= new Scanner(System.in);
	private int ID;//���̽s��
	private int energy=3;//���̳Ѿl��q�A�w�]��3
	private String ball;//���̾ժ����y��
	
	public void setID(){//�]�w���̽s��
		System.out.print("�]�w���̽s���]��������ơ^�G");
		while(1==1){
			try{
				ID =scan.nextInt();
				if(ID<1){
					System.out.print("��J�����̽s����������ơA�Э��s��J�G");
				}
				else{
					break;
				}
			}
			catch(Exception e){
				System.out.print("��J�����̽s����������ơA�Э��s��J�G");
				scan.next();
			}
		}
	}
	String [] BallType ={"a","b","c","d","e","f","g"};
	int i=0;
	public void setball(){//�]�w�ժ��y��
		System.out.print("�ѷӤW��]�w���̾ժ��������y�إN�X�C");
		while(1==1){//��J�Ĥ@�ؾժ����y�ءA���ˬd���S����
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
				System.out.println("��J���ժ��y�ؤ��s�b�A�Э��s�T�{");
			}
		}//while�j��j�A��
		
	}
	public int getID(){//�^�ǧ��s��
		return ID;
	}
	public int getenergy(){//�^�ǳѾl��q
		return energy;
	}
	public String getball(){//�^�ǲĤ@�ؾժ��y��
		return ball;
	}
	public void getdataforpitcher(){
		System.out.println("\n�y�����X�G"+ID+"\n�Ѿl�i��y���ơG"+energy);
	}
	public void getdata(){
		System.out.println("\n�y�����X�G"+ID+"\n�Ѿl�i��y���ơG"+energy+"\n�ժ����y�ءG"+ball);
	}
	public void strick(){
		energy-=1;
	}
}