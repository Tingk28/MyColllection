import java.util.Scanner;
import java.io.*;
public class hw4{
	public static void main(String[]args){
		try{
			Scanner scan=new Scanner(System.in);//scan���ѨϥΪ̿�J���O
			Scanner environment=new Scanner(new FileInputStream("environment.txt"));//environment�פJ��e�Ѯ�
			player player=new player();//�Ыت��a������
			land landA=new land();//�Ыؤg�a�@��
			tools wateringcan=new tools(); 
			tools hoe=new tools();
			tools sickle=new tools();
			System.out.println("�w��Ө즨�q�A�����y\n�q�o�̶}�l�A���A���H�ͧa�I");
			System.out.println("================================================");
			System.out.println("�п�J���a�W�١G");
			player.setname();//����R�W��method
			int day=1,$$=player.getmoney();//�ŧi�ܼƥ]�t�֭p�Ѽ�(day)�M��e���
			boolean datechenge=false;//�Y������ܮɬ�true
			String[]SoilList={"�L","sand","clay","loam"};//�g�a�����}�C
			String[]PlantList={"�L","watermelon","mulberry"};//�Ӫ������}�C
			String[]Weather={"Sunny","Storm","Normal","Rainy"};//�Ѯ�����}�C
			int[]WeatherEff={-15,+10,-5,+5};//�Ѯ�����v�T
			String[]ShopItem={"watering","hoe","sickle","watermelon","mulberry","sand","clay","loam"};//�ө��M��
			int[]ShopPrice={50,420,210,10,5,15,20,20};//�ө����ت�
			tools[]ToolBox={wateringcan,hoe,sickle};//�u��C��
			System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
			String env=environment.nextLine();//Ū�X�Ĥ@�Ѫ��Ѯ�
			int envchange=0;//�Ѯ��g�[���ܤ�
			for(int i=0;i<4;i++){//�]�w�Ĥ@�ѤѪ��ë��ܼ�
				if(Weather[i].equals(env)){
					envchange=WeatherEff[i];
					if(envchange>0){
						System.out.println("���ѤѮ�G"+env+"  �g�[���:+"+envchange);
						System.out.println("================================================");
					}
					else{
						System.out.println("���ѤѮ�G"+env+"  �g�[���:"+envchange);
						System.out.println("================================================");
					}
					break;
				}
			}
			boolean playercheck=true;//�ˬd���a�ϧ_�֦��������ؤl�B�g�������~�A�Y�S���h��false�A�C������
			while($$+landA.getpredictrev()>0&&environment.hasNextLine()&&playercheck){//�C����ڰj��A������j��0�άO���������ܼƮ��~��
				System.out.println("�m�Ѿl��O�n"+player.getenergy());//�L�X�Ѿl��O
				if(datechenge){//�ѼƧ��ܮ�Ū���U�@��
					env=environment.nextLine();
					datechenge=false;
					for(int i=0;i<4;i++){//�ĤG�Ѥ��᪺�ë��ܼ�
						if(Weather[i].equals(env)){
							envchange=WeatherEff[i];//���Ѫ��Ѯ�s��
							if(envchange>0){
								System.out.println("���ѤѮ�G"+env+"�g�[���:+"+envchange);
								System.out.println("================================================");
							}
							else{
								System.out.println("���ѤѮ�G"+env+"�g�[���:"+envchange);
								System.out.println("================================================");
							}
						break;
						}
					}
					if(landA.getsoil()!=0){//�p�G����g
						landA.wetchange(envchange);//���ܤg�[���
					}
				}
				boolean CommandCheck=false;//���O�榡���T�ɬ�true
				if(player.getenergy()<=0){//�p�G��O<=0
					System.out.println("���a"+player.getname()+"�֭ˤF");
					player.sleep();//���a��ı
					day++;
					datechenge=true;
					player.setmoney($$);//�����Ѫ��B
					if(environment.hasNextLine()){//�p�G�����U�@�ѤѮ�
						System.out.println("================================================");
						System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
						landA.deathcheck();//�ˬd�g�aA����׭ȨùL�]
						continue;
					}
				}
				String command=scan.nextLine();//�n�D��J���O
				command=command.toLowerCase();
				String [] Splitcommand=command.split(" ");
				if("water".equals(Splitcommand[0])){//���
					int wet=0;//�n�媺�Ӫ�
					if(Splitcommand.length==2){
						for(int i=1;i<PlantList.length;i++){//���@���M��
							if(PlantList[i].equals(Splitcommand[1])){
								wet=i;//�n������Ӫ��s��
								CommandCheck=true;//���O�L�~
								break;
							}
							if(i==PlantList.length-1){
								System.out.println("��J���Ӫ��������s�b�A�Э��s�ˬd");
							}
						}
					}
					else{
						System.out.println("��J��������O�����Э��s��J\n���O�榡�Gwater [�Ӫ��W��]");
					}
					if(CommandCheck==false){//���O���~�A���]
						System.out.println("================================================");
						continue;
					}
					else {//�Y���O�榡���T
						if(wet==landA.getplant()){//�ˬd����Ӫ��M�g�aA�{�b�ت��Ӫ��O���O�@��
							if(player.getenergy()>=10&&wateringcan.aviliable()){//�ˬd��O�O�_>10�H�άO�_�������
								landA.wetchange(5);//���+5
								wateringcan.tooluse(5);//����î��Ӽ�Ᾱ
									if(wateringcan.aviliable()==false){//�p�G�ϥΧ�������������a�F
										player.useitem(0,1);
									}
								System.out.println("���\��"+PlantList[wet]+"����A�ثe��׬�"+landA.getwet());
								System.out.println("================================================");
							}
							else if(player.getenergy()<10){//��O����
								player.energyuse(10);//���t�������O
							}
							else if(wateringcan.aviliable()==false){//�S�������
								wateringcan.tooluse(5);//���t�������O
							}
						}
						else{
							System.out.println("�z�ثe�S���ش�"+PlantList[wet]+"�{�b�и̺ت��O�G"+PlantList[landA.getplant()]);
							System.out.println("================================================");
						}
					}
				}
				else if("fill".equals(Splitcommand[0])){//��g���P�g
					if(Splitcommand.length!=4){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W]");
						System.out.println("================================================");
						continue;
					}
					if(!"loosen".equals(Splitcommand[2])){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W]");
						System.out.println("================================================");
						continue;					
					}
					int soil=0;//�n�شӪ��g��
					for(int i=1;i<4;i++){//�ˬd��g���O
						if(SoilList[i].equals(Splitcommand[3])){
							CommandCheck=true;//���O�榡���T
							soil=i;//�w��n��g�[�b�g�[����l
							break;
						}
						else if(i==3){
							System.out.println("��J���g�[�������s�b�Э��s�T�{");
							System.out.println("================================================");
							CommandCheck=false;//���O�榡���~
						}
					}
					if(CommandCheck){//�Y���O�榡���T
						if(player.getitemq(soil+4)>0&&hoe.aviliable()&&player.getenergy()>=5&&landA.getplant()==0){//�ˬd���~�B�u��B��O�O�_������
							hoe.tooluse(10);//�ϥξS�Y
							if(hoe.aviliable()==false){//�P�g��S�Y�a�F
								player.useitem(1,1);//�ϥξS�Y�@��
							}
							player.energyuse(5);//���Ӥ��I��q
							landA.setsoil(soil);//��g
							player.useitem(soil+4,1);//���a���~-1
							landA.wetchange(envchange);//�g�[����ѤѮ�v�T
							System.out.println("���\�P�g�ç�"+SoilList[soil]+"��J");//�t�δ���
							System.out.println("================================================");
						}
						else if(player.getitemq(soil+4)<=0){//�p�G�S���������g�[
							System.out.println("�A�ثe�S��"+SoilList[soil]+"�g�[�A�h�ө��ʶR�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(hoe.aviliable()==false){//�p�G�S���S�Y
							hoe.tooluse(10);//���t�������O
						}
						else if(player.getenergy()<5){//�p�G��O����
							player.energyuse(5);//energyuse���t�t�δ��ܥ\��
							System.out.println("================================================");
						}
						else if(landA.getplant()!=0){
							System.out.println("�A�ثe�A�a���w��"+PlantList[landA.getplant()]+"�p�G�n���s�شӽШϥ�remove���O");
							System.out.println("================================================");
						}	
					}
				}
				else if("remove".equals(Splitcommand[0])){//�����@��
					if(landA.getplant()>0&&player.getenergy()>=10){
						landA.resetland();
						System.out.println("���\�����A�a�����@��");
						System.out.println("================================================");
					}
					else if(landA.getplant()==0){
						System.out.println("�ثe�Цa�S���شӧ@���A�L�k����");
						System.out.println("================================================");
					}
					else if(player.getenergy()<10){	
					player.energyuse(10);
					System.out.println("================================================");
					}	
				}
				else if("plant".equals(Splitcommand[0])){//�ش�
					if(Splitcommand.length==2){//�j�P�ˬdplant���O�榡
						int plant=0;//�شӴӪ��s��
						for(int i=1;i<PlantList.length;i++){//���Ӫ��s��
							if(PlantList[i].equals(Splitcommand[1])){
								plant=i;
								CommandCheck=true;//���O�榡�L�~
								break;
							}
							else if(i==PlantList.length-1){
								System.out.println("��J���Ӫ��������s�b�A�Э��s�ˬd");
								CommandCheck=false;//���O�榡���~
							}
						}
						if(CommandCheck==false){//���O�榡���~�A���X
							System.out.println("================================================");
							continue;
						}
						if(landA.getsoil()!=0&&player.getitemq(plant+2)>0&&player.getenergy()>=15&&landA.getplant()==0){//�ˬd�O�_��g�B�شӤΪ��~�B��O�O�_������
							player.useitem(plant+2,1);//�ϥΪ��~
							player.energyuse(15);//����O
							landA.grow(plant);//�ش�
							System.out.println("================================================");
						}
						else if(landA.getsoil()==0){//�p�G�S����g
							System.out.println("�A�٨S����g���P�g�O�A��Jfill and loosen���O�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(player.getitemq(plant+2)==0){//�Y���~����
							System.out.println("�A�٨S��"+PlantList[plant]+"�ؤl�A�h�ө��R�I�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(player.getenergy()<15){//�Y��O����
							player.energyuse(15);//���������O�t�t�δ���
							System.out.println("================================================");
							continue;
						}
						else if(landA.getplant()!=0){//�p�w�g���@���b�̭�
							landA.grow(plant);//���������O�t�t�δ���
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("��J��plant���O�榡���~�A�Э��s�ˬd\nplant [�Ӫ��W��] ");
						System.out.println("================================================");
						continue;
					}
					
					
					
					
				}
				else if("reap".equals(Splitcommand[0])){//����
					int plant=0;//�����n�Ħ����Ӫ�
					if(Splitcommand.length!=4){//�ˬd��g���O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//�ˬd��g���O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��]");
						System.out.println("================================================");
						continue;
					}
					if(!"sell".equals(Splitcommand[2])){//�ˬd��g���O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��]");
						System.out.println("================================================");
						continue;					
					}
					for(int i=1;i<PlantList.length;i++){
						if(PlantList[i].equals(Splitcommand[3])){
							CommandCheck=true;
							plant=i;
							break;
						}
						else if(i==PlantList.length-1){
							System.out.println("��J���@���������s�b�A�Э��s��J");
							CommandCheck=false;
						}
					}
					if(CommandCheck==false){
						System.out.println("================================================");
						continue;
					}
					if(landA.getplant()==plant&&sickle.aviliable()){
						if(landA.getoutputdate()!=0){
							System.out.println("�n�Ħ����@���٨S�������O�A�����a�I");
							System.out.println("================================================");
						}
						else{
							sickle.tooluse(20);
							if(sickle.aviliable()==false){//�p�G�Ħ����I�M�a�F
								player.useitem(2,1);//�ϥ��I�M�@��
							}
							$$+=landA.getpredictrev();
							System.out.println("���\�Ħ�"+PlantList[plant]+"��o"+landA.getpredictrev()+"��");
							System.out.println("���a�����G"+$$);
							landA.setsoil(0);
							System.out.println("================================================");
						}
					}
					else if(landA.getplant()!=plant){
						System.out.println("�z�ثe�и̨S���ش�"+PlantList[plant]+"�h�ө��R�Ӻاa");
						System.out.println("================================================");
						continue;
					}
					else if(sickle.aviliable()==false){
						System.out.println("�z�ثe�S���I�M�h�ө��R��a�I");
						System.out.println("================================================");
					}
				}
				else if("buy".equals(Splitcommand[0])){//�ʶR
					int buy=10;//�@�ӥΩ��x�s�ʶR���~�ӫ~�s�����ܼ�
					int quantity=0;//�ʶR���ƶq
					if(1<Splitcommand.length&&Splitcommand.length<4){
						boolean noitem=false;
						for(int i=0;i<8;i++){
							if(ShopItem[i].equals(Splitcommand[1])){
								buy=i;
								break;
							}
							else if(i==7){
								System.out.println("�ʶR���ӫ~���s�b�Э��s�ˬd");
								noitem=true;
							}
						}
						if(noitem){
							System.out.println("================================================");
							continue;
						}
						try{
							if(buy==0){
								if("can".equals(Splitcommand[2])==false){
								System.out.println("�ʶR���ӫ~���s�b�Э��s�ˬd");
								System.out.println("================================================");
								continue;
								}
								else{
								CommandCheck=true;
								quantity=1;
								}
							}
						}
						catch(Exception e){
							System.out.println("�ʶR���ӫ~���s�b�Э��s�ˬd");
							System.out.println("================================================");
							continue;
						}
						if(buy!=10&&Splitcommand.length==2){
							CommandCheck=true;
							quantity=1;
						}
						if(buy!=10&&Splitcommand.length==3&&CommandCheck==false){
							try{
								int quant=Integer.valueOf(Splitcommand[2]);
								if(buy<3&&quant!=1){
									System.out.println("�u�����@���u���ʶR���֦��@�ӡA�Э��s��J");
									System.out.println("================================================");
									continue;
								}
								else if(buy<3&&quant==1){
									CommandCheck=true;
									quantity=quant;
								}
								else if(buy>2&&quant>0){
									CommandCheck=true;
									quantity=quant;
								}
								else{
									System.out.println("�ʶR���ƶq�����T(��>0)�A�Э��s�ˬd");
									System.out.println("================================================");
									continue;
								}
							}
							catch(Exception e){
								System.out.println("����J�ʶR�ӫ~�ƶq���ʶR���ƶq�����T�A�Э��s�ˬd");
								System.out.println("================================================");
								continue;
							}
						}
						if($$>=ShopPrice[buy]*quantity){
							if(buy<3){//�ʶR�u��
								int $=$$;//���ߵ�bï
								$=ToolBox[buy].buytools($,buy);//�ε�bï�����ʶR�u��
								if($!=$$){//�ʶR�e����B���P�]��!=��^�����\�ʶR
									player.additemq(buy,1);//���a���~�ƶq�W�[
									$$=$;//����
									System.out.println("���\�ʶR"+ShopItem[buy]+" "+quantity+"��\n�Ѿl�����G"+$$+"��");
									System.out.println("================================================");
								}
							}
							else{
								$$=player.buysth($$,buy,quantity);
								System.out.println("���\�ʶR"+ShopItem[buy]+" "+quantity+"��\n�Ѿl�����G"+$$+"��");
								System.out.println("================================================");
							}
						}
						else{
							System.out.println("�z�{�b���������A�V�O�ȿ��R�ۤv�Q�n���F��a�I");
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("��J��buy���O�榡���~�A�Э��s�ˬd\n�����Gbuy [�Q�n�ʶR���ө��c�R���~] ([�ƶq])");
						System.out.println("================================================");
						continue;
					}
				}
				else if("shop".equals(Splitcommand[0])){//�L�X�ө��M��
					System.out.println("\n�~�W           ����");
					for(int i=0;i<ShopItem.length;i++){
						if(i==0){
							System.out.println(ShopItem[i]+" can   "+ShopPrice[i]);
						}
						else{
							System.out.print(ShopItem[i]);
							for (int I=0;I<(15-ShopItem[i].length());I++){
								System.out.print(" ");
							}
							System.out.println(ShopPrice[i]);
						}
					}
					System.out.println("===================");
					System.out.println("�p���ʶR�ݨD�п�J�ʶR���O\nbuy [�Q�n�ʶR���ө��c�R���~] ([�ƶq])");
				}
				else if("backpack".equals(Splitcommand[0])){//�]�]���~
					if(player.itemsum()==0){
						System.out.println("�]�]�{�b�ŪŦp�]�A�h�ө��R�I����a�I\n��Jshop�i�H�ݨ�ө��ؿ�");
					}
					else{
						System.out.println("\n�~�W           �ƶq    �@�[��");
						for(int i=0;i<player.itemkind();i++){
							if(player.getitemq(i)!=0&&i<3){
								System.out.print(player.getitemname(i));
								for(int I=0;I<15-player.getitemname(i).length();I++){
									System.out.print(" ");
								}
							System.out.println(player.getitemq(i)+"       "+ToolBox[i].gethp());
							}
							if(player.getitemq(i)!=0&&i>2){
								System.out.print(player.getitemname(i));
								for(int I=0;I<15-player.getitemname(i).length();I++){
									System.out.print(" ");
								}
							System.out.println(player.getitemq(i));
							}
						}
						System.out.println("================================================");
					}
				}
				else if("check".equals(command)){//�ˬd�Цa���p
					if(player.energyuse(5)){
						landA.printdata(1);
						System.out.println("================================================");
					}
				}
				else if("sleep".equals(Splitcommand[0])){//��ı
					player.sleep();
					day++;
					player.setmoney($$);
					if(environment.hasNextLine()){
						datechenge=true;
						System.out.println("================================================");
						System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
						landA.deathcheck();
						continue;
					}
				}
				else if("endgame".equals(command)){//�h�X�B�����C��
					break;
				}
				else if("cls".equals(command)){//�M�ŵe��
					try{
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
					}
				}
				else if("help".equals(command)){//��ܫ��O��
					try{
						Scanner Help=new Scanner(new FileInputStream("./Explanation/help.txt"));
						while(Help.hasNextLine()){
							String help=Help.nextLine();
							System.out.println(help);
						}
					}
					catch(Exception e){
						System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
					}
				}
				else if("env?".equals(command)){//��ܤѮ𻡩�
					try{
						Scanner Enveff=new Scanner(new FileInputStream("./Explanation/enveff.txt"));
						while(Enveff.hasNextLine()){
							String enveff=Enveff.nextLine();
							System.out.println(enveff);
						}
					}
					catch(Exception e){
						System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
					}
				}
				else if("soil?".equals(command)){//��ܤg�[����
					try{
						Scanner Soileff=new Scanner(new FileInputStream("./Explanation/soileff.txt"));
						while(Soileff.hasNextLine()){
							String soileff=Soileff.nextLine();
							System.out.println(soileff);
						}
					}
					catch(Exception e){
						System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
					}
				}
				else if("plant?".equals(command)){//��ܤg�[����
					try{
						Scanner Planteff=new Scanner(new FileInputStream("./Explanation/planteff.txt"));
						while(Planteff.hasNextLine()){
							String planteff=Planteff.nextLine();
							System.out.println(planteff);
						}
					}
					catch(Exception e){
						System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
					}
				}
				//�s�ɥ\��
				else{
					System.out.println("��J�����O�����T�A�Э��s�ˬd�ο�Jhelp�d�ݫ��O��");
					System.out.println("================================================");
				}
				if($$==0){
					playercheck=player.possiblerev();
				}
			}//while�j��j�A��
			System.out.println("�w�C��"+day+"�ѡA�C����l�B���G"+player.getmoney());
		}
		catch(FileNotFoundException fnfe){
		}
	}
}	