public class tools{
	private boolean haveornot=false;//�O�_�֦��Ӥu��
	private int hp=100; //�u��@�[��
	
	int[]ShopPrice={50,420,210,10,5,15,20,20};//�ө����ت�
	
	
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
	public int buytools(int $,int k){//�ε�bï$�ʶR�s��k���u��
		if(haveornot){
			System.out.println("�{�����u���٨S���a���A�A���@�U�a�I");
			System.out.println("================================================");
			return $;
		}
		else{
			haveornot=true;
			hp=100;
			$-=ShopPrice[k];
			return $;
		}
	}
	public int gethp(){//�^�ǬY�u��@�[
		return hp;
	}
	public boolean aviliable(){//�^�ǬO�_�֦��Y�u��
		return haveornot;
	}


}