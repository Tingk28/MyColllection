import java.util.Scanner;
import java.text.DecimalFormat;
import java.util.ArrayList;
import java.text.DecimalFormat;
public class hw2{
	public static void main (String [] args){
		Scanner scan=new Scanner(System.in);
		Drinks Coffee1=new Drinks();
		Drinks Coffee2=new Drinks();
		Drinks Coffee3=new Drinks();
		Drinks Coffee4=new Drinks();
		Drinks Coffee5=new Drinks();
		Drinks Coffee6=new Drinks();
		Drinks Coffee7=new Drinks();
		Drinks Coffee8=new Drinks();
		Drinks Coffee9=new Drinks();
		Drinks Coffee10=new Drinks();
		
		Coffee1.Coffee="Americano";
		Coffee1.Size="Medium";
		Coffee1.Price=55;
		Coffee1.Cal=19.8;
		Coffee2.Coffee="Americano";
		Coffee2.Size="Large";
		Coffee2.Price=65;
		Coffee2.Cal=26.4;
		//����
		Coffee3.Coffee="Cappuccino";
		Coffee3.Size="Medium";
		Coffee3.Price=70;
		Coffee3.Cal=217.6;
		Coffee4.Coffee="Cappuccino";
		Coffee4.Size="Large";
		Coffee4.Price=85;
		Coffee4.Cal=290.6;
		//�d���_��
		Coffee5.Coffee="Mocha";
		Coffee5.Size="Medium";
		Coffee5.Price=70;
		Coffee5.Cal=390.9;
		Coffee6.Coffee="Mocha";
		Coffee6.Size="Large";
		Coffee6.Price=85;
		Coffee6.Cal=483.5;
		//���d
		Coffee7.Coffee="Latte";
		Coffee7.Size="Medium";
		Coffee7.Price=75;
		Coffee7.Cal=243.8;
		Coffee8.Coffee="Latte";
		Coffee8.Size="Large";
		Coffee8.Price=90;
		Coffee8.Cal=315.3;
		//���K
		Coffee9.Coffee="Macchiato";
		Coffee9.Size="Medium";
		Coffee9.Price=80;
		Coffee9.Cal=252.1;
		Coffee10.Coffee="Macchiato";
		Coffee10.Size="Large";
		Coffee10.Price=90;
		Coffee10.Cal=340.6;
		//���X����
		System.out.println("�w��ϥΥ��@���U�I�\�t�ΡA�������p�U�G");
		/*	{Americano  ,Medium ,55 , 19.8},
			{Americano  ,Large  ,65 , 26.4},
			{Cappuccino ,Medium ,70 ,217.6},
			{Cappuccino ,Large  ,85 ,290.6},
			{Mocha      ,Medium ,70 ,390.9},
			{Mocha      ,Large  ,85 ,483.5},
			{Latte      ,Medium ,75 ,243.8},
			{Latte      ,Large  ,90 ,315.3},
			{Macchiato  ,Medium ,80 ,252.1},
			{Macchiato  ,Large  ,90 ,340.6};*/
		String [] CoffeeType ={"AMERICANO","CAPPUCCINO","MOCHA","LATTE","MACCHIATO"};
		String [] SizeType={"MEDIUM","LARGE"};
		String [] IceSugar ={"NO","LOW","HALF","LESS","NORMAL"};
		double [] BasicCal={19.8,26.4,217.6,290.6,390.9,483.5,243.8,315.3,252.1,340.6};
		double [] SugarCal={0,60,100,140,180};
		double [] BasicPrice ={55,65,70,85,70,85,75,90,80,90};
		
		System.out.println("================================\n�~�W        "+"�j�p    "+"����  "+"���q");
		System.out.println(Coffee1.Coffee+"   "+Coffee1.Size+"  "+Coffee1.Price+"  "+Coffee1.Cal+"\n");
		System.out.println(Coffee2.Coffee+"   "+Coffee2.Size+"   "+Coffee2.Price+"  "+Coffee2.Cal+"\n");
		System.out.println(Coffee3.Coffee+"  "+Coffee3.Size+"  "+Coffee3.Price+"  "+Coffee3.Cal+"\n");
		System.out.println(Coffee4.Coffee+"  "+Coffee4.Size+"   "+Coffee4.Price+"  "+Coffee4.Cal+"\n");
		System.out.println(Coffee5.Coffee+"       "+Coffee5.Size+"  "+Coffee5.Price+"  "+Coffee5.Cal+"\n");
		System.out.println(Coffee6.Coffee+"       "+Coffee6.Size+"   "+Coffee6.Price+"  "+Coffee6.Cal+"\n");
		System.out.println(Coffee7.Coffee+"       "+Coffee7.Size+"  "+Coffee7.Price+"  "+Coffee7.Cal+"\n");
		System.out.println(Coffee8.Coffee+"       "+Coffee8.Size+"   "+Coffee8.Price+"  "+Coffee8.Cal+"\n");
		System.out.println(Coffee9.Coffee+"   "+Coffee9.Size+"  "+Coffee9.Price+"  "+Coffee9.Cal+"\n");
		System.out.println(Coffee10.Coffee+"   "+Coffee10.Size+"   "+Coffee10.Price+"  "+Coffee10.Cal+"\n");
		System.out.println("���@���U���ѥH�U�Ȼs�Ʋ��סGno/low/half/less/normal\n");
		System.out.println("�H�ΥH�U�Ȼs�ƦB���q�Gno/low/half/less/normal\n");
		System.out.println("================================\n�аѷӤW���I�\�A����add �A�̦���J�G�~�W �j�p ���� �B�� ����\n�p2�M���M�����L�}�֦B�п�J\nadd Americano Medium less less 2\n\n�ο�Jhelp�Ӭd�ݩҦ����O");
		ArrayList <String>DrinksList=new ArrayList<>();//���~�M��
		ArrayList <Integer> Cups= new ArrayList<>();//�M�ƲM��
		ArrayList <Double> Cal= new ArrayList<>();
		ArrayList <Double> Price= new ArrayList<>();//�����M��
		String CommandHead="initial";
		while (!"bill".equals(CommandHead)){
		String Command=scan.nextLine();//��J���O
		String [] SplitCommand=Command.split("\\ ");//�Ѻc���O
		CommandHead=SplitCommand[0];//�N���O�פJCommandHead�A�H�K�����O
		String commandhead=CommandHead.toLowerCase();//�N���O�p�g�Ϩ䤣�Ϥ��j�p�g
		if("add".equals(commandhead)){//����"�K�["�������O
		if(SplitCommand.length!=6){//�ˬdadd���O�O�_�j�P�ŦX�榡�]�H�K�}�C���פ��X�������X�^
			System.out.println("��J��add���O�榡���X�A�Э��s�ˬd�榡�p�U�G\nadd �~�W �j�p ���� �B�� ���ơ]�`�N�ݥΪŮ�j�}�^");
			continue;
		}
		Command=Command.substring(4);//����add�r��W�[���~�M���Ū��
		String CommandCup=SplitCommand[5];//�������~�M�ƪ�����
		int RealCup=Integer.valueOf(CommandCup);//�N�M�ƥ�String�令int
		DrinksList.add(Command);//��~�W���ԲӸ�Ƽg�J���~�M��
		String CommandCoffee=SplitCommand[1];
		String COMMANDCOFFEE=CommandCoffee.toUpperCase();
		String CommandSize=SplitCommand[2];
		String COMMANDSIZE=CommandSize.toUpperCase();
		String CommandSugar=SplitCommand[3];
		String COMMANDSUGAR=CommandSugar.toUpperCase();
		String CommandIce=SplitCommand[4];
		String COMMANDICE=CommandIce.toUpperCase();
		//�N���O�����j�g�A�H�F�������j�p�g
		//��ѲK�[���@�ت��ԲӰѼơA�H�K����dubug
		boolean CoffeeCheck=true;
		boolean SizeCheck=true;
		boolean SugarCheck=true;
		boolean IceCheck=true;
		for(int i=0;i<5;i++){//�ˬd�@�غ���
			CoffeeCheck=(CoffeeType[i].equals(COMMANDCOFFEE));
			if(CoffeeCheck){//�T�{�L�~���X�j��
				break;}
		}
		if(CoffeeCheck!=true){//�Y�@�خ榡���X�A���s��J
			System.out.println("�K�[���@�ث~�����s�b�ή榡���~�A�Э��s��J\n�]�����j�p�g�^");
			DrinksList.remove(Command);
		continue;
		}
		for(int i=0;i<2;i++){//�ˬd�@�ؤj�p
			SizeCheck=(SizeType[i].equals(COMMANDSIZE));
			if(SizeCheck){//�T�{�L�~���X�j��
				break;}
		}
		if(SizeCheck!=true){//�Y�@�ؤj�p���X�A���s��J
			System.out.println("�K�[���@�ؤj�p���s�b�ή榡���~�A�Э��s��J\n�]�����j�p�g�^");
			DrinksList.remove(Command);
			continue;
		}
		for(int i=0;i<5;i++){//�ˬd�@�ز���
			SugarCheck=(IceSugar[i].equals(COMMANDSUGAR));
			if(SugarCheck){//�T�{�L�~���X�j��
				break;}
		}
		if(SugarCheck!=true){//�@�ز��׮榡���X�A���s��J
			System.out.println("�K�[���@�ز��פ��s�b�ή榡���~�A�Э��s��J\n�]�`�N���ץ����p�g�^");
			DrinksList.remove(Command);
			continue;
		}
		for(int i=0;i<5;i++){//�ˬd�@�ئB��
			IceCheck=(IceSugar[i].equals(COMMANDICE));
			if(IceCheck){//�T�{�L�~���X�j��
				break;}
		}
		if(IceCheck!=true){//�@�ئB���榡���X�A���s��J
			System.out.println("�K�[���@�ئB�����s�b�ή榡���~�A�Э��s��J\n�]�`�N�B�������p�g�^");
			DrinksList.remove(Command);
			continue;
		}
		if(RealCup<1){//�ˬd�M�Ʈ榡
			System.out.println("��J���M�Ʈ榡���šA�Э��s�ˬd\n�]�ȯ��J�j�󵥩�1����ơ^");
			DrinksList.remove(Command);//�������X�����O
			continue;
		}
		}//add���O�j�A��
		else if("check".equals(commandhead)){//����"�ˬd"�������O
			Cal.clear();//�M�ż��q��
			Cups.clear();//�M�ŪM�ƪ�
			Price.clear();//�M�Ż����A�H�K�������P���q�����­�
			for(int i=0;i<DrinksList.size();i++){//�p��@�ؼ��q�B����
			String Calculate=DrinksList.get(i);
			int CalculateCoffeeNumber=0;
			int CalculateSugarNumber=0;
			boolean CalculateCoffee=true;
			boolean CalculateSugar=true;
			String[] NowCalculate=Calculate.split("\\ ");
			String CalculateCoffeeName=NowCalculate[0];//�W�ߥX�@�ئW��
			CalculateCoffeeName=CalculateCoffeeName.toUpperCase();
			String CalculateCoffeeSize=NowCalculate[1];//�W�ߥX�@�ؤj�p
			CalculateCoffeeSize=CalculateCoffeeSize.toUpperCase();
			String CalculateSugarType=NowCalculate[2];//�W�ߥX�}��
			CalculateSugarType=CalculateSugarType.toUpperCase();
			String CalculateCups=NowCalculate[4];//�W�ߥX�M��
			int CalculateRealCup=Integer.valueOf(CalculateCups);//�N�M�ƥ�String�令int
			Cups.add(CalculateRealCup);//�M�Ƽg�J�M�ƲM��
			for(int I=0;I<5;I++){//��X�@�ؽs��
				CalculateCoffee=(CoffeeType[I].equals(CalculateCoffeeName));
				if(CalculateCoffee){
				CalculateCoffeeNumber=I;
				break;}
				}
			for(int I=0;I<5;I++){//��X�}���s��
				CalculateSugar=(IceSugar[I].equals(CalculateSugarType));
				if(CalculateSugar){
				CalculateSugarNumber=I;
				break;}
				}
			if ("MEDIUM".equals(CalculateCoffeeSize)){//�p��өR�O�b���q����m
				CalculateCoffeeNumber=CalculateCoffeeNumber*2;
				}
			else{
				CalculateCoffeeNumber=CalculateCoffeeNumber*2+1;
				}
			double CalculateCoffeeCal=BasicCal[CalculateCoffeeNumber]+SugarCal[CalculateSugarNumber];
			double CalculateCoffeePrice=BasicPrice[CalculateCoffeeNumber];
			Cal.add(CalculateCoffeeCal);
			Price.add(CalculateCoffeePrice);
			//System.out.println(CalculateCoffeeNumber);
			}
			System.out.println("�z�ثe���I�����~�p�U�G");
			for(int i=0;i<DrinksList.size();i++ ){//�L�X�W�� i+1���s�� ���欰�涵�`��
				System.out.println(i+1+"."+DrinksList.get(i)+"\n�p�p�G"+Price.get(i)*Cups.get(i)+"  ���q�G"+Cal.get(i)+"�j�d");
			}
			System.out.println("�б����J���O�A�p�ݵ��b�п�Jbill�A�p�ݧ��h��Jedit�A�ο�Jhelp�d�ݫ��O��λ���");
		}
		else if("edit".equals(commandhead)){//����"�s��"�������O
		if(SplitCommand.length!=4){//�ˬdedit���O�O�_�j�P�ŦX�榡�]�H�K�}�C���פ��X�������X�^
				System.out.println("��J��edit���O�榡���X�A�Э��s�ˬd�榡�p�U�G\nedit �渹 �קﶵ�� �ק�ᵲ�G�]�`�N�ݥΪŮ�j�}�^");
				continue;
			}
		String CommandEditNubmer=SplitCommand[1];//�����諸�渹�D�X
		int EditNumber=Integer.valueOf(CommandEditNubmer);//��渹�令int
		String EditTitle=SplitCommand[2];//�W�ߥX�קﶵ��
		String EditResult=SplitCommand[3];//�W�ߥX�קﵲ�G
		EditTitle=EditTitle.toUpperCase();//�קﶵ�ؤj�g�A��K�ϥΪ�
		String EDITRESULT=EditResult.toUpperCase();//���ص��G�j�g�A��K�ϥΪ�
		int DrinksListSize=DrinksList.size();
		if (EditNumber>DrinksListSize){//�ˬd����諸�渹�s���s�b
		System.out.println("��諸�q��渹���s�b�Э��s�ˬd");
		continue;
		}
		String EditLine=DrinksList.get(EditNumber-1);//Ū�����ק諸�渹
		String [] SplitEdit=EditLine.split("\\ ");//�A���Ѻc�����Ѫ��渹
		String AfterEdit ="";
		boolean EditCheck=true;
		if ("SIZE".equals(EditTitle)){//���j�p
			for(int i=0;i<2;i++){//�ˬd�@�ؤj�p
				EditCheck=(SizeType[i].equals(EDITRESULT));
				if(EditCheck){//�T�{�L�~���X�j��
					break;}
			}
			if(EditCheck!=true){//�Y�@�ؤj�p���X�A���s��J
				System.out.println("�s�誺�@�ؤj�p���s�b�ή榡���~�A�Э��s��J\n�]�����j�p�g�^");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+EditResult+" "+SplitEdit[2]+" "+SplitEdit[3]+" "+SplitEdit[4];
		}
		else if ("SUGAR".equals(EditTitle)){//��ﲢ��
			for(int i=0;i<5;i++){//�ˬd�@�ز��׮榡
				EditCheck=(IceSugar[i].equals(EDITRESULT));
				if(EditCheck){//�T�{�L�~���X�j��
					break;}
			}
			if(EditCheck!=true){//�Y�@�ز��פ��X�A���s��J
				System.out.println("�s�誺�@�ز��פ��s�b�ή榡���~�A�Э��s��J\n�]�����j�p�g�^");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+EditResult+" "+SplitEdit[3]+" "+SplitEdit[4];
		}
		else if ("ICE".equals(EditTitle)){//���B��
			for(int i=0;i<5;i++){//�ˬd�@�ئB���榡
				EditCheck=(IceSugar[i].equals(EDITRESULT));
				if(EditCheck){//�T�{�L�~���X�j��
					break;}
			}
			if(EditCheck!=true){//�Y�@�ئB�����X�A���s��J
				System.out.println("�s�誺�@�ئB�����s�b�ή榡���~�A�Э��s��J\n�]�����j�p�g�^");
				continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+SplitEdit[2]+" "+EditResult+" "+SplitEdit[4];
		}
		else if ("QUANTITY".equals(EditTitle)){//���ƶq
			int EditQuantity=Integer.valueOf(EditResult);//��渹�令int
			if(EditQuantity<1){
			System.out.println("��諸�M�Ʈ榡���X�]���o�p��1�^�A�Э��s��J");
			continue;
			}
			AfterEdit=SplitEdit[0]+" "+SplitEdit[1]+" "+SplitEdit[2]+" "+SplitEdit[3]+" "+EditResult;
		}
		else{//�Y�����ŦX�A�ШϥΪ̭��s��J
			System.out.println("��J��edit���O�榡���X�A�Э��s�ˬd�榡�p�U�G\nedit �渹 �קﶵ�� �ק�ᵲ�G�]�`�N�ݥΪŮ�j�}�^\n�׸Ӷ��ؤ䴩�G�j�psize����sugar�B��ice����quantity");
				continue;
		}
		DrinksList.remove(EditNumber-1);//�����ª����~���O
		DrinksList.add(EditNumber-1,AfterEdit);//�s�W�s�����T���O
		System.out.println("���\�N"+EditNumber+"���\�I�אּ\n"+AfterEdit);//�^�Ǧ��\�q��
		}//edit�j�A��
		else if("menu".equals(commandhead)){//����"���"�������O
		System.out.println("================================\n�~�W        "+"�j�p    "+"����  "+"���q");
		System.out.println(Coffee1.Coffee+"   "+Coffee1.Size+"  "+Coffee1.Price+"  "+Coffee1.Cal+"\n");
		System.out.println(Coffee2.Coffee+"   "+Coffee2.Size+"   "+Coffee2.Price+"  "+Coffee2.Cal+"\n");
		System.out.println(Coffee3.Coffee+"  "+Coffee3.Size+"  "+Coffee3.Price+"  "+Coffee3.Cal+"\n");
		System.out.println(Coffee4.Coffee+"  "+Coffee4.Size+"   "+Coffee4.Price+"  "+Coffee4.Cal+"\n");
		System.out.println(Coffee5.Coffee+"       "+Coffee5.Size+"  "+Coffee5.Price+"  "+Coffee5.Cal+"\n");
		System.out.println(Coffee6.Coffee+"       "+Coffee6.Size+"   "+Coffee6.Price+"  "+Coffee6.Cal+"\n");
		System.out.println(Coffee7.Coffee+"       "+Coffee7.Size+"  "+Coffee7.Price+"  "+Coffee7.Cal+"\n");
		System.out.println(Coffee8.Coffee+"       "+Coffee8.Size+"   "+Coffee8.Price+"  "+Coffee8.Cal+"\n");
		System.out.println(Coffee9.Coffee+"   "+Coffee9.Size+"  "+Coffee9.Price+"  "+Coffee9.Cal+"\n");
		System.out.println(Coffee10.Coffee+"   "+Coffee10.Size+"   "+Coffee10.Price+"  "+Coffee10.Cal+"\n");
		System.out.println("���סGno/low/half/less/normal\n");
		System.out.println("�B���Gno/low/half/less/normal\n");
		System.out.println("================================\n�аѷӤW���I�\�A����add �A�̦���J�G�~�W �j�p ���� �B�� ����\n�p2�M���M�����L�}�֦B�п�J\nadd Americano Medium less less 2\n\n�ο�Jhelp�Ӭd�ݩҦ����O");
		}
		else if("help".equals(commandhead)){//����"���U"�������O	
		System.out.println("���I�\�t�Ϊ����O�θԲӻ����p�U\n");
		System.out.println("1.add �~�W �j�p ���� �B�� ����");
		System.out.println("�s�W�@�ئ��\�I���Ӥ��C�H�U���s�W2�M�j�M�d���_�եb�}�֦B�ܩ��Ӥ��C\nadd Cappuccino large half less 2\n");
		System.out.println("2.check");
		System.out.println("��ܥثe�Ҧ����\�I���ӡA�]�t �s���B���~�B�j�p�B���סB �B���B���ơB����H�μ��q�C\n");
		System.out.println("3.edit �s�� ���� ���e");
		System.out.println("�i�s��Y�@�h�\�I���Ӥ��� �j�p(size)�B����(sugar)�B�B ��(ice)�B����(quantity)�C�H�U���N�Ĥ@�h�\�I�����j�p�אּmedium�C\nedit 1 size medium\n");
		System.out.println("4.menu");
		System.out.println("��ܥi���ʪ����~�A�]�t�� ��μ��q�C\n");
		System.out.println("5.help");
		System.out.println("�C�X�Ҧ����O���A�û����U �ӫ��O���\��C\n");
		System.out.println("6.delete");
		System.out.println("�R���Ӧ��I�\�����C�Ҧp�R���ĤT��\ndelete 3\n");
		System.out.println("7.bill");
		System.out.println("�i�浲�b�A�C�X�Ҧ��\�I���өM�`��\n");
		System.out.println("���G���t�ΩҦ����O�������j�p�g�C");
		}
		else if("delete".equals(commandhead)){//����"�R��"�������O
		if(SplitCommand.length!=2){//�ˬddelete���O�O�_�j�P�ŦX�榡�]�H�K�}�C���פ��X�������X�^
				System.out.println("��J��delete���O�榡���X�A�Э��s�ˬd�榡�p�U�G\ndelete �渹");
				continue;
			}
		String DeleteNubmer=SplitCommand[1];//����R�����渹�D�X
		int RealDeleteNumber=Integer.valueOf(DeleteNubmer);//��渹�令int
		DrinksList.remove(RealDeleteNumber-1);
		System.out.println("���\�R����"+RealDeleteNumber+"���\�I");//�^�Ǧ��\�q��
		}
		else if("bill".equals(commandhead)){//���X�j��i�浲�b
		//���s����@��check���O�]���L�X����
		Cal.clear();//�M�ż��q��
			Cups.clear();//�M�ŪM�ƪ�
			Price.clear();//�M�Ż����A�H�K�������P���q�����­�
			for(int i=0;i<DrinksList.size();i++){//�p��@�ؼ��q�B����
			String Calculate=DrinksList.get(i);
			int CalculateCoffeeNumber=0;
			int CalculateSugarNumber=0;
			boolean CalculateCoffee=true;
			boolean CalculateSugar=true;
			String[] NowCalculate=Calculate.split("\\ ");
			String CalculateCoffeeName=NowCalculate[0];//�W�ߥX�@�ئW��
			CalculateCoffeeName=CalculateCoffeeName.toUpperCase();
			String CalculateCoffeeSize=NowCalculate[1];//�W�ߥX�@�ؤj�p
			CalculateCoffeeSize=CalculateCoffeeSize.toUpperCase();
			String CalculateSugarType=NowCalculate[2];//�W�ߥX�}��
			CalculateSugarType=CalculateSugarType.toUpperCase();
			String CalculateCups=NowCalculate[4];//�W�ߥX�M��
			int CalculateRealCup=Integer.valueOf(CalculateCups);//�N�M�ƥ�String�令int
			Cups.add(CalculateRealCup);//�M�Ƽg�J�M�ƲM��
			for(int I=0;I<5;I++){//��X�@�ؽs��
				CalculateCoffee=(CoffeeType[I].equals(CalculateCoffeeName));
				if(CalculateCoffee){
				CalculateCoffeeNumber=I;
				break;}
				}
			for(int I=0;I<5;I++){//��X�}���s��
				CalculateSugar=(IceSugar[I].equals(CalculateSugarType));
				if(CalculateSugar){
				CalculateSugarNumber=I;
				break;}
				}
			if ("MEDIUM".equals(CalculateCoffeeSize)){//�p��өR�O�b���q����m
				CalculateCoffeeNumber=CalculateCoffeeNumber*2;
				}
			else{
				CalculateCoffeeNumber=CalculateCoffeeNumber*2+1;
				}
			double CalculateCoffeeCal=BasicCal[CalculateCoffeeNumber]+SugarCal[CalculateSugarNumber];
			double CalculateCoffeePrice=BasicPrice[CalculateCoffeeNumber];
			Cal.add(CalculateCoffeeCal);
			Price.add(CalculateCoffeePrice);
			//System.out.println(CalculateCoffeeNumber);
			}
			System.out.println("�z�ثe���I�����~�p�U�G");
			for(int i=0;i<DrinksList.size();i++ ){//�L�X�W�� i+1���s�� ���欰�涵�`��
				System.out.println(i+1+"."+DrinksList.get(i)+"\n�p�p�G"+Price.get(i)*Cups.get(i)+"  ���q�G"+Cal.get(i)+"�j�d");
			}
		}
		else{//�Y���X������O�A�n�D���s��J
			System.out.println("��J�����O�榡���šA�Э��s�ˬd�]�����j�p�g�^�C�ο�Jhelp�d�ݫ��O��λ���");
		}
		}//While�j�骺�j�A��
		//�i�浲�b�A�}�l�p���`��
		int[] BillCups=new int[10];//�ŧi�@��int�}�C�A�Ω��x�s�U�ؤj�p�@�ت��M��
		int DrinksListSize=DrinksList.size();
		for(int i=0;i<DrinksListSize;i++){//�p�M�j��
			String NowBill=DrinksList.get(i);//�W�ߥX�{�b�n�p�M���渹
			String [] NowBillArray=NowBill.split("\\ ");
			String BillCoffee=NowBillArray[0];
			BillCoffee=BillCoffee.toUpperCase();
			int BillCoffeeNumber=0;
			String BillSize=NowBillArray[1];
			BillSize=BillSize.toUpperCase();
			Boolean BillCoffeeMatch=true;
			for(int I=0;I<5;I++){//��X�@�ؽs��
				BillCoffeeMatch=(CoffeeType[I].equals(BillCoffee));
				if(BillCoffeeMatch){
				BillCoffeeNumber=I;
				break;}
				}
			if ("MEDIUM".equals(BillSize)){//�p��ӳ渹���@�ؽs��
				BillCoffeeNumber=BillCoffeeNumber*2;
				}
			else{
				BillCoffeeNumber=BillCoffeeNumber*2+1;
				}
			BillCups[BillCoffeeNumber]=BillCups[BillCoffeeNumber]+Cups.get(i);
		}//�p�M�j��j�A��
		double Sum=0;
		for(int i=0;i<5;i++){
			double note=0;
			int M=BillCups[2*i];//���M
			int L=BillCups[2*i+1];//��j�M
			double MP=BasicPrice[2*i];
			double LP=BasicPrice[2*i+1];
			//int count=i;
			if(M>L){//���M��j�M�h
			int ML=(M-L)/2;//���M�ĤG�M�b���ռ�
				note=L*(MP*0.5+LP)+(MP*1.5)*ML+((M-L)-ML*2)*MP;
			}
			else if(M==L){//���M��j�M�M�ƬۦP
				note=M*(MP*0.5+LP);
			}
			else if(M<L){//�j�M�񤤪M�h
				int LM=(L-M)/2;//�j�d�ĤG�M�b���ռ�
				note=M*(MP*0.5+LP)+(LP*1.5)*LM+((L-M)-LM*2)*LP;
			}
			double Check=note%1;
			if(Check==0.5){//�N�p�p�|�ˤ��J
			note=note +0.5;
			}
			Sum=Sum+note;
		}
		DecimalFormat FinalSum =new DecimalFormat("0.#"); 
		System.out.println("\n�����q���`���B��"+FinalSum.format(Sum)+"���C�P�±z�ϥΥ��I�\�t�ΡA���ݱz�A���Y�{�C");
	}
}

