public class tools{
	private boolean haveornot=false;//�O�_�֦��Ӥu��
	private int hp=100; //�u��@�[��
	public boolean tooluse(int i){//�ϥάY�u��A����i�I�@�[��
		if(!haveornot){
			System.out.println("�ثe�S���X�A���u��A�Ш�ө��ʶR");
			System.out.println("================================================");
			return false;
		}
		else{
			hp-=i;
			if(hp==0){//�u��@�[���k0
				haveornot=false;
			}
			return true;
		}
	}
	public int buytools(int $,int k){//�ε�bï$�ʶRk�����u��
		if(haveornot){
			System.out.println("�{�����u���٨S���a���A�A���@�U�a�I");
			System.out.println("================================================");
			return $;
		}
		else{
			haveornot=true;
			hp=100;
			$-=k;
			return $;
		}
	}
	public int gethp(){//�^�ǬY�u��@�[
		return hp;
	}
	public boolean aviliable(){//�^�ǬO�_�֦��Y�u��
		return haveornot;
	}
	public void sethp(String i){
		hp=Integer.valueOf(i);
	}
	public void setaviliable(String i){
		if("true".equals(i)){
			haveornot=true;
		}
		else{
			haveornot=false;
		}
	}
	public void reset(){
		haveornot=false;
		hp=100;
	}	
}