import java.util.Scanner;
public class player{
	private String name;
	private int Money=900,energy=100;
	private int[]ItemQ={0,0,0,0,0,0,0,0,0,0};
	//物品數量清單，依序前三項為工具類第四項起為西瓜、桑樹、砂土、黏土、壤土、西瓜果實、桑葚
	String[]AllItem={"watering can","hoe","sickle","watermelon","mulberry","sand","clay","loam"};//總物品名稱表
	int[]ShopPrice={50,420,210,10,5,15,20,20};//商店價目表	
	Scanner scan=new Scanner(System.in);
	public void setname(){//設定名字
		name=scan.next();
	}
	public void setmoney(int rightmoney){//設定金錢
		Money=rightmoney;
	}
	public void useitem(int i,int k){//使用物品表中第i個物品k個
		ItemQ[i]-=k;
	}
	public String getname(){//回傳名字
		return name;
	}
	public int getmoney(){//回傳金錢
		return Money;
	}
	public int getenergy(){//回傳剩餘能量值
		return energy;
	}
	public int getitemq(int i){//回傳某物品數量
		return ItemQ[i];
	}
	public int itemkind(){//回傳有幾種物品
		return ItemQ.length;
	}
	public String getitemname(int i){
		return AllItem[i];
	}		
	public boolean energyuse(int e){//使用e點能量
		if(energy>=e){
			energy-=e;
			return true;
		}
		else{
			System.out.println("目前體力不足"+e+"點，目前體力為"+energy);
			System.out.println("================================================");
			return false;
		}
	}
	public void additemq(int buy,int i){//將物品數量增加i個
		ItemQ[buy]+=i;
	}
	public int buysth(int $,int buy,int q){//購買商品編號buy的東西q個
		$-=ShopPrice[buy]*q;
		ItemQ[buy]+=q;
		return $;
	}
	public int itemsum(){//回傳包包物品總合，用於backpack功能
		int S=0;
		for(int i=0;i<ItemQ.length;i++){
		S+=ItemQ[i];
		}
		return S;
	}
	/*public int sellsth(int item,int n,int $$){//在虛帳簿$$中賣物品item n個
		ItemQ[item]-=n;	
	}*/
	public void sleep(){//玩家睡覺指令
		energy+=70;
		if(energy>100){
			energy=100;
		}
		else if(energy<70){
			energy=70;
		}
	}
	public boolean possiblerev(){
		if(Money==0){
			int q=0,k=0,m=0,n=0;
			k=ItemQ[1];//看看有沒有鋤頭
			q=ItemQ[2];//看看有沒有鐮刀
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
}