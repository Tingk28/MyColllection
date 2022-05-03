import java.util.Scanner;
import java.io.*;
public class hw5{
	public static void main(String[]args){
		try{
			String[]SoilList={"�L","sand","clay","loam","magicdust"};//�g�a�����}�C
			String[]PlantList={"�L","watermelon","mulberry","sungrass","starflower"};//�Ӫ������}�C
			String[]Weather={"Sunny","Storm","Normal","Rainy"};//�Ѯ�����}�C
			int[]WeatherEff={-15,+10,-5,+5};//�Ѯ�����v�T
			String[]ShopItem={"watering","hoe","sickle","watermelon","mulberry","sungrass","starflower","sand","clay","loam","magicdust"};//�ө��M��
			int[]ShopPrice={50,420,210,10,5,15,20,15,20,20,30};//�ө����ت�
			tools wateringcan=new tools(); 
			tools hoe=new tools();
			tools sickle=new tools();
			tools[]ToolBox={wateringcan,hoe,sickle};//�u��C��
			Scanner scan=new Scanner(System.in);//scan���ѨϥΪ̿�J���O
			Scanner environment=new Scanner(new FileInputStream("environment.txt"));//environment�פJ��e�Ѯ�
			player player=new player();//�Ыت��a������
			land [] LandList=new land[9];
			int day=1,$$=player.getmoney(),landpredictrev=0,energycost=0;//�ŧi�ܼƥ]�t�֭p�Ѽ�(day)�B��e����B�w���`���X�B�Y�ʧ@�һ���O
			int envchange=0;//�Ѯ��g�[���ܤ�
			boolean datechenge=false;//�Y������ܮɬ�true
			boolean playercheck=true;//�ˬd���a�ϧ_�֦��������ؤl�B�g�������~�A�Y�S���h��false�A�C������
			String env="";//�x�s�Ѯ�W��
			for(int i=0;i<LandList.length;i++){//���C���a�s��
				LandList[i]=new land();
				LandList[i].setid(i+1);
			}
			System.out.println("�w��Ө즨�q�A�����y\n�q�o�̶}�l�A���A���H�ͧa�I");
			System.out.println("================================================");
			System.out.println("�п�J���a�W�١G\n�ο�JloadŪ���s��");
			String name=scan.nextLine();
			name=name.toLowerCase();
			boolean load=false;
			if("load".equals(name)){//Ū�ɥ\��
				try{
					Scanner Load=new Scanner(new FileInputStream("save.txt"));
					day=Integer.valueOf(Load.next());//���J�Ѽ�
					for(int i=0;i<ToolBox.length;i++){//�g�J�u����
						ToolBox[i].setaviliable(Load.next());
						ToolBox[i].sethp(Load.next());
						}
					for(int i=0;i<LandList.length;i++){//�g�J�g�a���
						String number=Load.next();
						String[]n=number.split(",");
						LandList[i].setintdata(n[0],n[1],n[2],n[3],n[4],n[5],n[6],n[7],n[8],n[9]);
						String TF=Load.next();
						String[]SplitTF=number.split(",");
						LandList[i].setbooleandata(SplitTF[0],SplitTF[1],SplitTF[2],SplitTF[3]);
					}
					player.setname(Load.next());//���a��ư�
					String Number=Load.next();
					String[]N=Number.split(",");
					int[]number=new int[14];
					for(int i=0;i<N.length;i++){//string to int
						number[i]=Integer.valueOf(N[i]);
					}
					player.setmoney(number[0]);
					player.setenergy(number[1]);
					player.setjob(number[2]);
					for(int i=3;i<14;i++){//�g�J�]�]���~�ƶq
						player.additemq(i-3,number[i]);
					}
					for(int i=0;i<day;i++){
						env=environment.nextLine();//Ū�X�Ѯ���day��
					}
					$$=player.getmoney();
					player.sleep();//�Ҧ���Ƽg�J�����A�ǳƹL�]
					day++;
					datechenge=true;
					player.setmoney($$);
					if(environment.hasNextLine()){//�p�G�����U�@�ѤѮ�
						System.out.println("================================================");
						System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//�ˬd�g�ai����׭ȨùL�]
							landpredictrev+=LandList[i].getpredictrev();//�[�`�i��w�����G�겣�X
						}
					}
					load=true;
				}
				catch(Exception e){//�������O�B�N���g�J���F������~��
					e.printStackTrace();
					for(int i=0;i<ToolBox.length;i++){
						ToolBox[i].reset();
					}
					for(int i=0;i<LandList.length;i++){
						LandList[i].resetland();
					}
					player.reset();
					System.out.println("�S�����L�h�s�ɪ��ɮש��ɮ׷l��\n�t�δ��ܡG�N�����зs����\n�п�J���a�W�١G");
					name=scan.nextLine();
				}
			}
			if(load==false){
				player.setname(name);//����R�W��method
				while(player.getjob()==0){//¾�~�]�w
					System.out.println("�п�J���a¾�~�G\n�ο�Jjob?�d��¾�~����");
					String [] JobList={"botanist","merchant","hercules"};
					String job=scan.next();
					job=job.toLowerCase();
					if("job?".equals(job)){//���¾�~����
						try{
							Scanner Job=new Scanner(new FileInputStream("./Explanation/job.txt"));
							while(Job.hasNextLine()){
								String JOB=Job.nextLine();
								System.out.println(JOB);
							}
						}
						catch(Exception e){
							System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
						}
						continue;
					}
					for(int i=0;i<JobList.length;i++){
						if(job.equals(JobList[i])){
							player.setjob(i+1);
							for(int I=0;I<9;I++){
								LandList[I].setplayerjob(i+1);
							}
							System.out.println("���\�N¾�~�]�w��"+JobList[i]);
							System.out.println("================================================");
							break;
						}
						else if(i==JobList.length-1){
							System.out.println("��J��¾�~���s�b�A�Э��s�ˬd");
						}
					}
				}
				System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
				env=environment.nextLine();//Ū�X�Ĥ@�Ѫ��Ѯ�
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
			}
			while($$+landpredictrev>0&&environment.hasNextLine()&&playercheck){//�C����ڰj��A������j��0�άO���������ܼƮ��~��
				System.out.println("�m�Ѿl��O�n"+player.getenergy());//�L�X�Ѿl��O
				System.out.println("�m�Ѿl�����n"+$$);//�L�X�Ѿl����
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
					for(int i=0;i<LandList.length;i++){
						if(LandList[i].getsoil()!=0){//�p�G����g
							LandList[i].wetchange(envchange);//���ܤg�[���
						}
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
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//�ˬd�g�ai����׭ȨùL�]
							landpredictrev+=LandList[i].getpredictrev();//�[�`�i��w�����G�겣�X
						}
					}
				}
				String command=scan.nextLine();//�n�D��J���O
				command=command.toLowerCase();
				String [] Splitcommand=command.split(" ");
				if("water".equals(Splitcommand[0])){//���
					int wet=0;//�n�媺�Цa�s��
					if(Splitcommand.length==2){//�ˬd���O����&�Цa�s��
						try{
							wet=Integer.valueOf(Splitcommand[1]);
							if(wet<1||wet>9){
								System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
								continue;
							}
						}
						catch(Exception e){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
						}
					}
					else{
						System.out.println("��J��������O�����Э��s��J\n���O�榡�Gwater [�Цa�s��]");
						continue;
					}
					if(LandList[wet-1].getplant()>0){//�ˬd�g�a�{�b�O�_�شӧ@��
						if(player.getenergy()>=10&&wateringcan.aviliable()){//�ˬd��O�O�_>10�H�άO�_�������
							LandList[wet-1].wetchange(5);//���+5
							wateringcan.tooluse(5);//����î��Ӽ�Ᾱ
								if(wateringcan.aviliable()==false){//�p�G�ϥΧ�������������a�F
									player.useitem(0,1);//���Ӽ�����@��
									System.out.println("�A��������]���@�[�k�s�a���F�A�A�h�ө��R�@�ӧa");//�t�δ���
								}
							System.out.println("���\��"+LandList[wet-1]+"����A�ثe��׬�"+LandList[wet-1].getwet());
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
						System.out.println("�z��"+LandList[wet-1]+"�ثe�S���شӧ@��\n���ֺؤU�A�n���@���a�I");
						System.out.println("================================================");
					}
				}
				else if("fill".equals(Splitcommand[0])){//��g���P�g
					if(Splitcommand.length!=5){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W��] [�Цa�s��] ");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W��] [�Цa�s��] ");
						System.out.println("================================================");
						continue;
					}
					if(!"loosen".equals(Splitcommand[2])){//�ˬd��g���O
						System.out.println("��g���P�g�����O�����Э��s��J\n���O�榡�Gfill and loosen [�g�[�W��] [�Цa�s��] ");
						System.out.println("================================================");
						continue;					
					}
					int soil=0,land=-1;//�n�شӪ��g�ؤΦ�m
					for(int i=1;i<SoilList.length;i++){//�ˬd��g���O
						if(SoilList[i].equals(Splitcommand[3])){
							soil=i;//�w��n��g�[�b�g�[����l
							CommandCheck=true;//���O�榡�Ȯɥ��T
							break;
						}
						else if(i==SoilList.length-1){
							System.out.println("��J���g�[�������s�b�Э��s�T�{");
							System.out.println("================================================");
							CommandCheck=false;//���O�榡���~
						}
					}
					if(CommandCheck==false){
						continue;
					}
					try{
						land=Integer.valueOf(Splitcommand[4]);
						if(land<1||land>9){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
						}
					}
					catch(Exception e){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
					}
					if(CommandCheck){//�Y���O�榡���T
						if(player.getjob()==1){
							energycost=5;
						}
						else if(player.getjob()==2){
							energycost=10;
						}
						else{
							energycost=0;
						}
						if(player.getitemq(soil+6)>0&&hoe.aviliable()&&player.getenergy()>=energycost&&LandList[land-1].getplant()==0){//�ˬd���~�B�u��B��O�O�_������
							hoe.tooluse(10);//�ϥξS�Y
							if(hoe.aviliable()==false){//�P�g��S�Y�a�F
								player.useitem(1,1);//�ϥξS�Y�@��
								System.out.println("�A���S�Y�]���@�[�k�s�a���F�A�A�h�ө��R�@�ӧa");//�t�δ���
							}
							player.energyuse(energycost);//���ӯ�q
							LandList[land-1].setsoil(soil);//��g
							player.useitem(soil+6,1);//���a���~-1
							LandList[land-1].wetchange(envchange);//�g�[����ѤѮ�v�T
							System.out.println("���\�P�g�ç�"+SoilList[soil]+"��J"+LandList[land-1]+"��");//�t�δ���
							System.out.println("================================================");
						}
						else if(player.getitemq(soil+6)<=0){//�p�G�S���������g�[
							System.out.println("�A�ثe�S��"+SoilList[soil]+"�g�[�A�h�ө��ʶR�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(hoe.aviliable()==false){//�p�G�S���S�Y
							hoe.tooluse(10);//���t�������O
						}
						else if(player.getenergy()<energycost){//�p�G��O����
							player.energyuse(energycost);//energyuse���t�t�δ��ܥ\��
							System.out.println("================================================");
						}
						else if(LandList[land-1].getplant()!=0){
							System.out.println("�A�ثe"+LandList[land-1]+"���w��"+PlantList[LandList[land-1].getplant()]+"�p�G�n���s�شӽШϥ�remove���O");
							System.out.println("================================================");
						}
					}
				}
				else if("remove".equals(Splitcommand[0])){//�����@��
					if(Splitcommand.length!=2){
						System.out.println("��J��remove���O�榡���~�Э��s�ˬd\n���O�榡�Gremove[�Цa�s��]");
						System.out.println("================================================");
						continue;
					}
					int land=-1;
					try{
						land=Integer.valueOf(Splitcommand[1]);
						if(land<1||land>9){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
						}
					}
					catch(Exception e){
						System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
						continue;
					}
					if(LandList[land-1].getplant()>0&&player.getenergy()>=10){
						LandList[land-1].resetland();
						player.energyuse(10);
						System.out.println("���\����"+LandList[land-1]+"�����@��");
						System.out.println("================================================");
					}
					else if(LandList[land-1].getplant()==0){//�Цa�S���@��
						System.out.println(LandList[land-1]+"�ثe�S���شӧ@���A�L�k����");
						System.out.println("================================================");
					}
					else if(player.getenergy()<10){//���a��O����
					player.energyuse(10);//�����B���t�t�δ��ܥ\��
					System.out.println("================================================");
					}	
				}
				else if("plant".equals(Splitcommand[0])){//�ش�
					if(Splitcommand.length==3){//�j�P�ˬdplant���O�榡
						int plant=0,land=-1;//�شӴӪ��s���B��J�g�a�s��
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
						try{
							land=Integer.valueOf(Splitcommand[2]);
							if(land<1||land>9){
								System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
								continue;
							}
						}
						catch(Exception e){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
						}
						if(CommandCheck==false){//���O�榡���~�A���X
							System.out.println("================================================");
							continue;
						}
						if(player.getjob()==1){
							energycost=15;
						}
						else if(player.getjob()==2){
							energycost=20;
						}
						else{
							energycost=10;
						}
						if(LandList[land-1].getsoil()!=0&&player.getitemq(plant+2)>0&&player.getenergy()>=energycost&&LandList[land-1].getplant()==0&&LandList[land-1].grow(plant)){//�ˬd�O�_��g�B�شӤΪ��~�B��O�O�_������
							player.useitem(plant+2,1);//�ϥΪ��~
							player.energyuse(energycost);//����O
							System.out.println("================================================");
							for(int i=0;i<LandList.length;i++){//�شӧ����ˬd�O�_���Ӫ��|����\�૬�Ӫ��v�T�]�t�g�٧@���Q�J���\�૬�v�T�ηs�ؤU���\�૬�v�T�J���Ӫ��^
								if(LandList[i].getplant()==3){//�Ӷ���
									try{//�k
										LandList[i+1].sungrasseff();
									}
									catch(Exception e){
									}
									try{//��
										LandList[i-1].sungrasseff();
									}
									catch(Exception e){
									}
									try{//�U
										LandList[i+3].sungrasseff();
									}
									catch(Exception e){
									}
									try{//�W
										LandList[i-3].sungrasseff();
									}
									catch(Exception e){
									}
								}
								if(LandList[i].getplant()==4){//�P����
									try{//�k
										LandList[i-1].starflowereff();
									}
									catch(Exception e){
									}
									try{//��
										LandList[i+1].starflowereff();
									}
									catch(Exception e){
									}
									try{//�U
										LandList[i+3].starflowereff();
									}
									catch(Exception e){
									}
									try{//�W
										LandList[i-3].starflowereff();
									}
									catch(Exception e){
									}
								}
							}
						}
						else if(LandList[land-1].getsoil()==0){//�p�G�S����g
							System.out.println("�A�٨S����g���P�g�O�A��Jfill and loosen���O�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(player.getitemq(plant+2)==0){//�Y���~����
							System.out.println("�A�٨S��"+PlantList[plant]+"�ؤl�A�h�ө��R�I�a�I");
							System.out.println("================================================");
							continue;
						}
						else if(player.getenergy()<energycost){//�Y��O����
							player.energyuse(energycost);//�����B�����O�t�t�δ���
							System.out.println("================================================");
							continue;
						}
						else if(LandList[land-1].getplant()!=0){//�p�w�g���@���b�̭�
							LandList[land-1].grow(plant);//�����B�����O�t�t�δ���
							System.out.println("================================================");
						}
					}
					else{
						System.out.println("��J��plant���O�榡���~�A�Э��s�ˬd\nplant [�Ӫ��W��] [�Цa�s��]");
						System.out.println("================================================");
						continue;
					}
				}
				else if("reap".equals(Splitcommand[0])){//����
					int plant=0,land=0;//�����n�Ħ����Ӫ�
					if(Splitcommand.length!=5){//�ˬd���Ϋ��O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��] [�Цa�s��]");
						System.out.println("================================================");
						continue;
					}
					if(!"and".equals(Splitcommand[1])){//�ˬd���Ϋ��O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��] [�Цa�s��]");
						System.out.println("================================================");
						continue;
					}
					if(!"sell".equals(Splitcommand[2])){//�ˬd���Ϋ��O
						System.out.println("���Ψóc�檺���O�����Э��s��J\n���O�榡�Greap and sell [�Ӫ��W��] [�Цa�s��]");
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
					try{
						land=Integer.valueOf(Splitcommand[4]);
						if(land<1||land>9){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
						}
					}
					catch(Exception e){
							System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
							continue;
					}
					if(LandList[land-1].getplant()==plant&&sickle.aviliable()){
						if(LandList[land-1].getoutputdate()!=0&&LandList[land-1].getplant()>0&&LandList[land-1].getplant()<3){//���������g�٧@��
							System.out.println("�n�Ħ����@���٨S�������O�A�����a�I");
							System.out.println("================================================");
						}
						else if(LandList[land-1].getplant()>2){
							System.out.println("�\�૬�Ӫ��L�k�Q�Ħ�");
							System.out.println("================================================");
						}
						else{
							sickle.tooluse(20);
							if(sickle.aviliable()==false){//�p�G�Ħ����I�M�a�F
								player.useitem(2,1);//�ϥ��I�M�@��
								System.out.println("�A���I�M�]���@�[�k�s�a���F�A�A�h�ө��R�@�ӧa");//�t�δ���
							}
							$$+=LandList[land-1].getpredictrev();
							System.out.println("���\�Ħ�"+PlantList[plant]+"��o"+LandList[land-1].getpredictrev()+"��");
							System.out.println("���a�����G"+$$);
							LandList[land-1].setsoil(0);
							System.out.println("================================================");
						}
					}
					else if(LandList[land-1].getplant()!=plant){
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
					int buy=-1;//�@�ӥΩ��x�s�ʶR���~�ӫ~�s�����ܼ�
					int quantity=0;//�ʶR���ƶq
					if(1<Splitcommand.length&&Splitcommand.length<4){
						boolean noitem=false;
						for(int i=0;i<ShopItem.length;i++){
							if(ShopItem[i].equals(Splitcommand[1])){
								buy=i;
								break;
							}
							else if(i==ShopItem.length-1){
								System.out.println("�ʶR���ӫ~���s�b�Э��s�ˬd");
								noitem=true;
							}
						}
						if(noitem){
							System.out.println("================================================");
							continue;
						}
						try{
							if(buy==0){//�p�G�R�����
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
						if(buy!=-1&&Splitcommand.length==2){
							CommandCheck=true;
							quantity=1;
						}
						if(buy!=-1&&Splitcommand.length==3&&CommandCheck==false){
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
						int price=0;//�����ʶR�����B
						if(player.getjob()==2&&buy<3){
							price=(ShopPrice[buy]-10);
						}
						else{
							price=ShopPrice[buy]*quantity;
						}
						if($$>=price){
							if(buy<3){//�ʶR�u��
								int $=$$;//���ߵ�bï
								$=ToolBox[buy].buytools($,price);//�ε�bï�����ʶRprice�����u��
								if($!=$$){//�ʶR�e����B���P�]��!=��^�����\�ʶR
									player.additemq(buy,1);//���a���~�ƶq�W�[
									$$=$;//����
									if(buy==0){//�ʶR�����
										System.out.println("���\�ʶR"+ShopItem[buy]+" can"+quantity+"��\n�Ѿl�����G"+$$+"��");
										System.out.println("================================================");
									}
									if(buy>0){
										System.out.println("���\�ʶR"+ShopItem[buy]+" "+quantity+"��\n�Ѿl�����G"+$$+"��");
										System.out.println("================================================");
									}
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
					System.out.println("================================================");
				}
				else if("backpack".equals(Splitcommand[0])){//�]�]���~
					if(player.itemsum()==0){
						System.out.println("�]�]�{�b�ŪŦp�]�A�h�ө��R�I����a�I\n��Jshop�i�H�ݨ�ө��ؿ�");
						System.out.println("================================================");
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
				else if("check".equals(Splitcommand[0])){//�ˬd�Цa���p
					int check=-1;//�n�ˬd���Цa
					if(Splitcommand.length==2){
						if("all".equals(Splitcommand[1])){
							check=100;
						}
						else{
							try{
								check=Integer.valueOf(Splitcommand[1]);
								if(check<1||check>9){
									System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
									continue;
								}
							}
							catch(Exception e){
								System.out.println("��J���Цa�s�����s�b�]����1��9�^�A�Э��s��J");
								continue;
							}
						}
					}
					else{
						System.out.println("��Jcheck���O�榡���~\n���O�榡�Gcheck [�Цa�s��] ");
						System.out.println("================================================");
						continue;
					}
					if(check<10){
						if(player.energyuse(5)){
							LandList[check-1].printdata(check);
							System.out.println("================================================");
						}
					}
					else if(check==100){
						if(player.getenergy()>=45){
							player.energyuse(45);
							for(int i=0;i<9;i++){
							LandList[i].printdata(i+1);
							System.out.println("================================================");
							}
						}
						else{
							player.energyuse(45);//���t�t�δ��ܥ\��
						}
					}
				}
				else if("sleep".equals(Splitcommand[0])){//��ı
					player.sleep();
					day++;
					datechenge=true;
					player.setmoney($$);
					if(environment.hasNextLine()){//�p�G�����U�@�ѤѮ�
						System.out.println("================================================");
						System.out.println("��"+day+"��\n�Ѿl�����G"+player.getmoney());
						landpredictrev=0;
						for(int i=0;i<LandList.length;i++){
							LandList[i].deathcheck();//�ˬd�g�ai����׭ȨùL�]
							landpredictrev+=LandList[i].getpredictrev();//�[�`�i��w�����G�겣�X
						}
					}
				}
				else if("endgame".equals(command)){//�h�X�B�����C��
					player.setmoney($$);//�����Ѫ��B
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
				else if("plant?".equals(command)){//��ܧ@������
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
				else if("job?".equals(command)){//��ܧ@������
					try{
							Scanner job=new Scanner(new FileInputStream("./Explanation/job.txt"));
							while(job.hasNextLine()){
								String JOB=job.nextLine();
								System.out.println(JOB);
							}
						}
					catch(Exception e){
						System.out.println("�ӫ��O�X�{���~�A�й����pô�޲z��");
					}
				}
				else if("save".equals(command)){//�s�ɥ\��
					player.setmoney($$);
					try{
						PrintWriter save=new PrintWriter(new FileOutputStream("save.txt",false));
						save.println(day);//�C�����
						for(int i=0;i<ToolBox.length;i++){//�s�J�u��
							save.println(ToolBox[i].aviliable()+"\n"+ToolBox[i].gethp());
							save.flush();
						}
						for(int i=0;i<LandList.length;i++){
							save.println(LandList[i].intinfo());
							save.println(LandList[i].booleaninfo());
							save.flush();
						}
						save.println(player.getname());
						save.println(player.intinfo());
						save.flush();
						//save.close();
						System.out.println("�w���\�s�ɡA�h�X�C��");
						break;
					}
					catch(Exception e){
						System.out.println("�s�ɿ��~");
					}
				}
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