import java.util.Scanner;
public class Pitcher {
	Scanner scan = new Scanner(System.in);
	private int ID;//���s��
	private int energy=10;//����q�ȡA�B�w�]��10�I
	private String side;//���k��
	private String high;//�W��/�C�ӧ�
	private String ballA;//�Ĥ@�ؾժ��y��
	private String ballB;//�ĤG�ؾժ��y��
	private String ballC;//�ĤT�ؾժ��y��
	private boolean OnorNot=false;//�O�_�b���W
	
	public void setID(){//�]�w���s��
		System.out.print("�]�w���s���]��������ơ^�G");
		while(1==1){
			try{
				ID =scan.nextInt();
				if(ID<1){
					System.out.print("��J�����s����������ơA�Э��s��J�G");
				}
				else{
					break;
				}
			}
			catch(Exception e){
				System.out.print("��J�����s����������ơA�Э��s��J�G");
				scan.next();
			}
		}
	}
	public void setenergy(int E){//�]�w��q
		energy=E;
	}
	public void setside(){//�]�w���k��
		System.out.println("�]�w��y����\n�]��Jleft������F��Jright���k��^");
		while(1==1){//��J���ˬd��y��O�_�ŦX�榡
			side=scan.next();
			side=side.toLowerCase();
			if("right".equals(side)){
				break;
		}
			else if("left".equals(side)){
				break;
		}
			else{
				System.out.println("��J�Ω��y���⤣�šA�Э��s��J");
		}
	}
	}
	public void sethigh(){//�]�w�W/�C�ӧ�
		System.out.println("�]�w��⬰�W���C�ӧ�\n�]��Jup���W�ӧ�F��Jdown���C�ӧ�^");
		while(1==1){//��J���ˬd���W���C�ӧ�O�_�ŦX�榡
			high=scan.next();
			high=high.toLowerCase();
			if("up".equals(high)){
				break;
			}
			else if("down".equals(high)){
				break;
			}
			else{
				System.out.println("��J���W���C�ӧ뤣�šA�Э��s��J");
			}
	}
	}
	String [] BallType ={"a","b","c","d","e","f","g"};
	int i=0;
	public void setballA(){//�]�w�Ĥ@�ؾժ��y��
		System.out.print("�ѷӤW��]�w���Ĥ@�ؾժ��y�إN�X\n");
		while(1==1){//��J�Ĥ@�ؾժ����y�ءA���ˬd���S����
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
				System.out.println("��J���ժ��y�ؤ��s�b�A�Э��s�T�{");
			}
		}//while�j��j�A��
	}
	public void setballB(){//�]�w�ĤG�ؾժ��y��
		System.out.print("�ѷӤW��]�w���ĤG�ؾժ��y�إN�X\n");
		while(1==1){//��J�ĤG�ؾժ����y�ءA���ˬd���S����
			ballB=scan.next();
			ballB=ballB.toLowerCase();
			boolean check=BallType[i].equals(ballB);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ballB);
				if(BallType[i].equals(ballB)){
					break;
				}
			}
			if(check){//�ˬd�Ĥ@�G�ؾժ��y�جO�_����
				if(ballA.equals(ballB)){
					System.out.println("��J�ժ����y�ػP�Ĥ@�ح��ơA�Э��s��J");
				}
				else{
					break;
				}
			}
			else{//�Y�������X
			System.out.println("��J���ժ��y�ؤ��s�b�A�Э��s�T�{");
			}
		}//while�j��j�A��
	}
	public void setballC(){//�]�w�ĤT�ؾժ��y��
		System.out.print("�ѷӤW��]�w���ĤT�ؾժ��y�إN�X\n");
		while(1==1){//��J�ĤT�ؾժ����y�ءA���ˬd���S����
			ballC=scan.next();
			ballC=ballC.toLowerCase();
			boolean check=BallType[i].equals(ballC);
			for(i=0;i<6;i++){
				check=BallType[i].equals(ballC);
				if(BallType[i].equals(ballC)){
					break;
				}
			}
		if(check){//�ˬd�Ĥ@�G�ؾժ��y�جO�_����
			if(ballA.equals(ballC)){//�M�Ĥ@�ؾժ��y��
				System.out.println("��J�ժ����y�ػP�Ĥ@�ح��ơA�Э��s��J");
			}
			else if(ballB.equals(ballC)){//�M�ĤG�ؾժ��y��
				System.out.println("��J�ժ����y�ػP�ĤG�ح��ơA�Э��s��J");
			}
			else{
				break;
			}
		}
		else{//�Y�������X
		System.out.println("��J���ժ��y�ؤ��s�b�A�Э��s�T�{");
		}
		}
	}
	public void setOnorNot(boolean onornot){
		OnorNot=onornot;
	}
	public int getID(){//�^�ǧ��s��
		return ID;
	}
	public int getenergy(){//�^�ǳѾl��q
		return energy;
	}
	public String getside(){//�^�ǥ��k��
		return side;
	}
	public String gethigh(){//�^�ǰ�/�C�ӧ�
		return high;
	}
	public String getballA(){//�^�ǲĤ@�ؾժ��y��
		return ballA;
	}
	public String getballB(){//�^�ǲĤG�ؾժ��y��
		return ballB;
	}
	public String getballC(){//�^�ǲĤT�ؾժ��y��
		return ballC;
	}
	public boolean getOnorNot(){//�^�Ǧb���W�P�_
		return OnorNot;
	}
	public void getdataforstricker(){
		System.out.println("\n�y�����X�G"+ID+"\n�Ѿl�i��y���ơG"+energy);
	}
	public void getdata(){
		System.out.println("\n�y�����X�G"+ID+"\n�Ѿl�i��y���ơG"+energy+"\n�ժ����y�ءG"+ballA+","+ballB+","+ballC);
	}
	public void pitch(){
		energy-=1;
		if(energy==0){
		OnorNot=false;
		}
	}
}