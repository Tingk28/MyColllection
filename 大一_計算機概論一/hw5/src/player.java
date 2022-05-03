import java.util.Scanner;
public class player{
	private String name;
	private int Money=2000,energy=100;
	private int Job=0;//職業代碼0為沒有職業1,2,3分別為植物學家、商人、力士
	private int[]ItemQ={0,0,0,0,0,0,0,0,0,0,0};
	//物品數量清單，依序前三項為工具類第四項起為西瓜、桑樹、砂土、黏土、壤土、西瓜果實、桑葚
	String[]AllItem={"watering","hoe","sickle","watermelon","mulberry","sungrass","starflower","sand","clay","loam","magicdust"};//總物品名稱表
	int[]ShopPrice={50,420,210,10,5,15,20,15,20,20,30};//商店價目表
	Scanner scan=new Scanner(System.in);
	public void setname(String newname){//設定名字
		name=newname;
	}
	public void setjob(int newjob){//設定職業
		Job=newjob;
		if(newjob==1){
			energy=90;
		}
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
	public int getjob(){//回傳職業
		return Job;
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
	public int buysth(int $,int buy,int q){//購買商品編號buy的東西q個，總價K元
		$=$-ShopPrice[buy]*q;
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
	public void sleep(){//玩家睡覺指令
		if(Job!=1){
			energy+=70;
			if(energy>100){
				energy=100;
			}
			if(Job==3){//力士完全恢復體力
				energy=100;
			}
		}
		if(Job==1){//植物學家體力上限為90
			energy+=70;
			if(energy>90){
				energy=90;
			}
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
	public String intinfo(){//（存檔用）
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
	public void setenergy(int e){//設定體力（讀檔用）
		energy=e;
	}
	public void reset(){//重設玩家
		name="";
		Money=2000;
		energy=100;
		Job=0;
		for(int i=0;i<ItemQ.length;i++){
			ItemQ[i]=0;
		}
	}
}