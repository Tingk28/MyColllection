import java.util.Scanner;
public class player{
	private String name;
	private int Money=2000,energy=100;
	private int Job=0;//¾�~�N�X0���S��¾�~1,2,3���O���Ӫ��Ǯa�B�ӤH�B�O�h
	private int[]ItemQ={0,0,0,0,0,0,0,0,0,0,0};
	//���~�ƶq�M��A�̧ǫe�T�����u�����ĥ|���_����ʡB���B��g�B�H�g�B�[�g�B��ʪG��B��߸
	String[]AllItem={"watering","hoe","sickle","watermelon","mulberry","sungrass","starflower","sand","clay","loam","magicdust"};//�`���~�W�٪�
	int[]ShopPrice={50,420,210,10,5,15,20,15,20,20,30};//�ө����ت�
	Scanner scan=new Scanner(System.in);
	public void setname(String newname){//�]�w�W�r
		name=newname;
	}
	public void setjob(int newjob){//�]�w¾�~
		Job=newjob;
		if(newjob==1){
			energy=90;
		}
	}
	public void setmoney(int rightmoney){//�]�w����
		Money=rightmoney;
	}
	public void useitem(int i,int k){//�ϥΪ��~����i�Ӫ��~k��
		ItemQ[i]-=k;
	}
	public String getname(){//�^�ǦW�r
		return name;
	}
	public int getjob(){//�^��¾�~
		return Job;
	}
	public int getmoney(){//�^�Ǫ���
		return Money;
	}
	public int getenergy(){//�^�ǳѾl��q��
		return energy;
	}
	public int getitemq(int i){//�^�ǬY���~�ƶq
		return ItemQ[i];
	}
	public int itemkind(){//�^�Ǧ��X�ت��~
		return ItemQ.length;
	}
	public String getitemname(int i){
		return AllItem[i];
	}		
	public boolean energyuse(int e){//�ϥ�e�I��q
		if(energy>=e){
			energy-=e;
			return true;
		}
		else{
			System.out.println("�ثe��O����"+e+"�I�A�ثe��O��"+energy);
			System.out.println("================================================");
			return false;
		}
	}
	public void additemq(int buy,int i){//�N���~�ƶq�W�[i��
		ItemQ[buy]+=i;
	}
	public int buysth(int $,int buy,int q){//�ʶR�ӫ~�s��buy���F��q�ӡA�`��K��
		$=$-ShopPrice[buy]*q;
		ItemQ[buy]+=q;
		return $;
	}
	public int itemsum(){//�^�ǥ]�]���~�`�X�A�Ω�backpack�\��
		int S=0;
		for(int i=0;i<ItemQ.length;i++){
		S+=ItemQ[i];
		}
		return S;
	}
	public void sleep(){//���a��ı���O
		if(Job!=1){
			energy+=70;
			if(energy>100){
				energy=100;
			}
			if(Job==3){//�O�h������_��O
				energy=100;
			}
		}
		if(Job==1){//�Ӫ��Ǯa��O�W����90
			energy+=70;
			if(energy>90){
				energy=90;
			}
		}
	}
	public boolean possiblerev(){
		if(Money==0){
			int q=0,k=0,m=0,n=0;
			k=ItemQ[1];//�ݬݦ��S���S�Y
			q=ItemQ[2];//�ݬݦ��S���I�M
			for(int i=3;i<5;i++){
				m+=ItemQ[i];
			}
			for(int i=5;i<8;i++){
				n+=ItemQ[i];
			}
			if(q*m*n*k==0){
				return false;
			}
			else{
				return true;
			}
		}
		else{
			return true;
		}
	}
	public String intinfo(){//�]�s�ɥΡ^
		String item="";
		for(int i=0;i<ItemQ.length;i++){
			if(i==ItemQ.length-1){
				item+=String.valueOf(ItemQ[i]);
			}
			else{
				item+=String.valueOf(ItemQ[i])+",";
			}
		}
		String data=Money+","+energy+","+Job+","+item;
		return data;
	}
	public void setenergy(int e){//�]�w��O�]Ū�ɥΡ^
		energy=e;
	}
	public void reset(){//���]���a
		name="";
		Money=2000;
		energy=100;
		Job=0;
		for(int i=0;i<ItemQ.length;i++){
			ItemQ[i]=0;
		}
	}
}