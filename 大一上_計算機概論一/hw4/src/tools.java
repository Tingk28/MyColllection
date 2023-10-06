public class tools{
	private boolean haveornot=false;//是否擁有該工具
	private int hp=100; //工具耐久度
	
	int[]ShopPrice={50,420,210,10,5,15,20,20};//商店價目表
	
	
	public boolean tooluse(int i){//使用某工具，消耗i點耐久度
		if(!haveornot){
			System.out.println("目前沒有合適的工具，請到商店購買");
			System.out.println("================================================");
			return false;
		}
		else{
			hp-=i;
			if(hp==0){//工具耐久度歸0
				haveornot=false;
			}
			return true;
		}
	}
	public int buytools(int $,int k){//用虛帳簿$購買編號k的工具
		if(haveornot){
			System.out.println("現有的工具還沒有壞掉，再撐一下吧！");
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
	public int gethp(){//回傳某工具耐久
		return hp;
	}
	public boolean aviliable(){//回傳是否擁有某工具
		return haveornot;
	}


}