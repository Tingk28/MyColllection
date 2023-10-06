import java.util.Scanner;
import java.text.DecimalFormat;
public class hw1
{
	public static void main(String[] args)
	{
	System.out.println("歡迎使用成電旅行社貨幣轉換系統");
	System.out.println("==============================");
	System.out.println("本系統提供以下貨幣轉換功能\n");
	//歡迎介面;
	double Buy,Sell,Rate;//賣出買入金額
	int SellCurrency=0;
	int BuyCurrency=0;//賣出買入幣種
	double Ntd=1;
	double Usd=31.25;
	double Gbp=39.58;
	double Jpy=0.2898;
	double Eur=34.78;
	double Krw=0.02815;
	double Myr=7.935;
	double Hkd=4.006;
	double Cny=4.437;
	//變數宣告＆輸入匯率
	String NTD ="1.新台幣";
	String USD ="2.美金";
	String GBP ="3.英鎊";
	String JPY ="4.日圓";
	String EUR ="5.歐元";
	String KRW ="6.韓元";
	String MYR ="7.馬來幣";
	String HKD ="8.港幣";
	String CNY ="9.人民幣";
	System.out.println(NTD+"\n"+USD+"\n"+GBP+"\n"+JPY+"\n"+EUR+"\n"+KRW+"\n"+MYR+"\n"+HKD+"\n"+CNY+"\n");
	//顯示提供幣別
	Scanner scan = new Scanner(System.in);
	while(SellCurrency<1 || SellCurrency>9){
	System.out.println("請依上表輸入欲賣出（當地）貨幣的代碼，如新台幣請輸入1。\n或輸入9999獲得匯率總表");	
	SellCurrency = scan.nextInt();
	
	if (SellCurrency==9999){
			System.out.println("\n當前買入下列貨幣價格為（以新臺幣為基礎）：");
			System.out.println("1.新台幣   1.00");
			System.out.println("2.美金　　31.25");
			System.out.println("3.英鎊　  39.58");
			System.out.println("4.日圓　　 0.2898");
			System.out.println("5.歐元　　34.78");
			System.out.println("6.韓元　　 0.02815");
			System.out.println("7.馬來幣　 7.935");
			System.out.println("8.港幣　   4.006");
			System.out.println("9.人民幣　 4.437\n");
			}
	if (SellCurrency<1 || SellCurrency>9&&SellCurrency!=9999)
		System.out.println("\n輸入值無效，請輸入上表表列之代號(1～9)\n");
		
	}//輸入賣出幣別，並且判斷輸入是否正確
	System.out.println("");//排版美觀需求空一行
	String [] Currency={"新台幣","美金","英鎊","日圓","歐元","韓元","馬來幣","港幣","人民幣"};
	System.out.println("請輸入要賣出的"+Currency[SellCurrency-1]+"金額（商品價格）\n（至多接受至小數點後第二位，若超過則四捨五入，如3.123視為3.12）");
	Sell=scan.nextDouble();
	System.out.println("");//排版美觀需求空一行
	while(BuyCurrency<1 || BuyCurrency>9){
	System.out.println("請依上表輸入欲買入（使用者熟悉）貨幣的代碼，如新台幣請輸入1。\n或輸入9999獲得匯率總表");
	BuyCurrency = scan.nextInt();
	if (BuyCurrency==9999){
			System.out.println("\n當前買入下列貨幣價格為（以新臺幣為基礎）：");
			System.out.println("1.新台幣   1.00");
			System.out.println("2.美金　　31.25");
			System.out.println("3.英鎊　  39.58");
			System.out.println("4.日圓　　 0.2898");
			System.out.println("5.歐元　　34.78");
			System.out.println("6.韓元　　 0.02815");
			System.out.println("7.馬來幣　 7.935");
			System.out.println("8.港幣　   4.006");
			System.out.println("9.人民幣　 4.437\n");
			}
	if 	(BuyCurrency<1 || BuyCurrency>9&&BuyCurrency!=9999)
		System.out.println("\n輸入值無效，請輸入上表表列之代號(1～9)\n");
		}	
	//輸入賣出幣別，並且判斷輸入是否正確
	double [] ExchangeRate={1,31.25,39.58,0.2898,34.78,0.02815,7.935,4.006,4.437};
	Rate=ExchangeRate[SellCurrency-1]/ExchangeRate[BuyCurrency-1];
	DecimalFormat FinalRate = new DecimalFormat("#.####") ;
	DecimalFormat FinalAmount = new DecimalFormat("#,###.##");//設定輸出結果格式包含四捨五入到小數點後兩位以及千分位
	Buy=Sell*Rate;
	System.out.println("==============================\n"+FinalAmount.format(Sell)+"元的"+Currency[SellCurrency-1]+"可以換成"+FinalAmount.format(Buy)+"元的"+Currency[BuyCurrency-1]+"\n匯率為1:"+FinalRate.format(Rate));
	}
	
}