import java.util.Scanner;
import java.text.DecimalFormat;
public class hw1
{
	public static void main(String[] args)
	{
	System.out.println("�w��ϥΦ��q�Ȧ���f���ഫ�t��");
	System.out.println("==============================");
	System.out.println("���t�δ��ѥH�U�f���ഫ�\��\n");
	//�w�虜��;
	double Buy,Sell,Rate;//��X�R�J���B
	int SellCurrency=0;
	int BuyCurrency=0;//��X�R�J����
	double Ntd=1;
	double Usd=31.25;
	double Gbp=39.58;
	double Jpy=0.2898;
	double Eur=34.78;
	double Krw=0.02815;
	double Myr=7.935;
	double Hkd=4.006;
	double Cny=4.437;
	//�ܼƫŧi����J�ײv
	String NTD ="1.�s�x��";
	String USD ="2.����";
	String GBP ="3.�^��";
	String JPY ="4.���";
	String EUR ="5.�ڤ�";
	String KRW ="6.����";
	String MYR ="7.���ӹ�";
	String HKD ="8.���";
	String CNY ="9.�H����";
	System.out.println(NTD+"\n"+USD+"\n"+GBP+"\n"+JPY+"\n"+EUR+"\n"+KRW+"\n"+MYR+"\n"+HKD+"\n"+CNY+"\n");
	//��ܴ��ѹ��O
	Scanner scan = new Scanner(System.in);
	while(SellCurrency<1 || SellCurrency>9){
	System.out.println("�Ш̤W���J����X�]��a�^�f�����N�X�A�p�s�x���п�J1�C\n�ο�J9999��o�ײv�`��");	
	SellCurrency = scan.nextInt();
	
	if (SellCurrency==9999){
			System.out.println("\n��e�R�J�U�C�f�����欰�]�H�s�O������¦�^�G");
			System.out.println("1.�s�x��   1.00");
			System.out.println("2.�����@�@31.25");
			System.out.println("3.�^��@  39.58");
			System.out.println("4.���@�@ 0.2898");
			System.out.println("5.�ڤ��@�@34.78");
			System.out.println("6.�����@�@ 0.02815");
			System.out.println("7.���ӹ��@ 7.935");
			System.out.println("8.����@   4.006");
			System.out.println("9.�H�����@ 4.437\n");
			}
	if (SellCurrency<1 || SellCurrency>9&&SellCurrency!=9999)
		System.out.println("\n��J�ȵL�ġA�п�J�W���C���N��(1��9)\n");
		
	}//��J��X���O�A�åB�P�_��J�O�_���T
	System.out.println("");//�ƪ����[�ݨD�Ť@��
	String [] Currency={"�s�x��","����","�^��","���","�ڤ�","����","���ӹ�","���","�H����"};
	System.out.println("�п�J�n��X��"+Currency[SellCurrency-1]+"���B�]�ӫ~����^\n�]�ܦh�����ܤp���I��ĤG��A�Y�W�L�h�|�ˤ��J�A�p3.123����3.12�^");
	Sell=scan.nextDouble();
	System.out.println("");//�ƪ����[�ݨD�Ť@��
	while(BuyCurrency<1 || BuyCurrency>9){
	System.out.println("�Ш̤W���J���R�J�]�ϥΪ̼��x�^�f�����N�X�A�p�s�x���п�J1�C\n�ο�J9999��o�ײv�`��");
	BuyCurrency = scan.nextInt();
	if (BuyCurrency==9999){
			System.out.println("\n��e�R�J�U�C�f�����欰�]�H�s�O������¦�^�G");
			System.out.println("1.�s�x��   1.00");
			System.out.println("2.�����@�@31.25");
			System.out.println("3.�^��@  39.58");
			System.out.println("4.���@�@ 0.2898");
			System.out.println("5.�ڤ��@�@34.78");
			System.out.println("6.�����@�@ 0.02815");
			System.out.println("7.���ӹ��@ 7.935");
			System.out.println("8.����@   4.006");
			System.out.println("9.�H�����@ 4.437\n");
			}
	if 	(BuyCurrency<1 || BuyCurrency>9&&BuyCurrency!=9999)
		System.out.println("\n��J�ȵL�ġA�п�J�W���C���N��(1��9)\n");
		}	
	//��J��X���O�A�åB�P�_��J�O�_���T
	double [] ExchangeRate={1,31.25,39.58,0.2898,34.78,0.02815,7.935,4.006,4.437};
	Rate=ExchangeRate[SellCurrency-1]/ExchangeRate[BuyCurrency-1];
	DecimalFormat FinalRate = new DecimalFormat("#.####") ;
	DecimalFormat FinalAmount = new DecimalFormat("#,###.##");//�]�w��X���G�榡�]�t�|�ˤ��J��p���I����H�Τd����
	Buy=Sell*Rate;
	System.out.println("==============================\n"+FinalAmount.format(Sell)+"����"+Currency[SellCurrency-1]+"�i�H����"+FinalAmount.format(Buy)+"����"+Currency[BuyCurrency-1]+"\n�ײv��1:"+FinalRate.format(Rate));
	}
	
}