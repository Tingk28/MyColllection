import java.util.Scanner;
public class hw3 {
	public static void main (String[] args){
		Scanner scan = new Scanner(System.in);
		int point=0;//���a�A���`�o��
		Pitcher pitcher1 =new Pitcher();
		Pitcher pitcher2 =new Pitcher();
		Pitcher pitcher3 =new Pitcher();
		Stricker stricker1= new Stricker();
		Stricker stricker2= new Stricker();
		Stricker stricker3= new Stricker();
		Stricker stricker4= new Stricker();
		Stricker stricker5= new Stricker();
		Stricker stricker6= new Stricker();//�ЫؤT�ӧ�⤻�ӥ��̪�object
		System.out.println("�w��C�����βy�p�C���A�C����k�аѷ�readme.text");//�w��T��
		//�Ѫ��a�Ҿާ@
		System.out.println("���a�Ҿ������A�ö}�l�]�w�����");
		System.out.println("�m�]�w�Ĥ@�W���n");//�]�w�Ĥ@�W�����
		pitcher1.setID();
		pitcher1.setside();
		pitcher1.sethigh();
		System.out.print("a �ֳt�y b ���y c �Ʋy d �ܳt�y e ���e�y f ���d�y \n");
		pitcher1.setballA();
		pitcher1.setballB();
		pitcher1.setballC();
		System.out.println("===============================");	
		System.out.println("�m�]�w�ĤG�W���n");//�]�w�ĤG�W�����
		while(1==1){//�]�w�ĤG���⪺�s���A���ˬd���o�P�Ĥ@�ӭ���
			pitcher2.setID();
			if(pitcher1.getID()==pitcher2.getID()){
				System.out.println("���G���y�����X���o�P���@�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		pitcher2.setside();
		pitcher2.sethigh();
		System.out.print("a �ֳt�y b ���y c �Ʋy d �ܳt�y e ���e�y f ���d�y \n");
		pitcher2.setballA();
		pitcher2.setballB();
		pitcher2.setballC();
		System.out.println("===============================");	
		System.out.println("�m�]�w�ĤT�W���n");//�]�w�ĤT�W�����
		while(1==1){//�]�w�ĤT���⪺�s���A���ˬd���o�P�Ĥ@�ӭ���
			pitcher3.setID();
			if(pitcher1.getID()==pitcher3.getID()){
				System.out.println("���T���y�����X���o�P���@�ۦP�A�Э��s��J");
			}
			else if(pitcher2.getID()==pitcher3.getID()){
				System.out.println("���T���y�����X���o�P���G�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		pitcher3.setside();
		pitcher3.sethigh();
		System.out.print("a �ֳt�y b ���y c �Ʋy d �ܳt�y e ���e�y f ���d�y \n");
		pitcher3.setballA();
		pitcher3.setballB();
		pitcher3.setballC();
		System.out.println("===============================");
		try{//����Ƴ]�w�����A�M�ŵe��
			new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		}
		catch(Exception e){
			System.out.println("Fail");
		}
		//�}�l��Ѫ��a�A�ާ@
		System.out.println("���a�A������̤�A�ö}�l�]�w���̸��\n");
		System.out.println("�m�]�w�Ĥ@�W���̡n");//�]�w�Ĥ@�W���̸��
		stricker1.setID(); //�]�w�y���@���X
		System.out.println("a �ֳt�y b ���y c �Ʋy d �ܳt�y e ���e�y f ���d�y \n");
		stricker1.setball();
		System.out.println("=========================================");
		System.out.println("�m�]�w�ĤG�W���̡n");//�]�w�ĤG�W���̸��
		while(1==1){//�]�w�y���G���X
			stricker2.setID();
			if(stricker1.getID()==stricker2.getID()){
				System.out.println("���̤G���y�����X���o�P���̤@�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		stricker2.setball();
		System.out.println("=========================================");
		System.out.println("�m�]�w�ĤT�W���̡n");//�]�w�ĤT�W���̸��
		while(1==1){//�]�w�y���T���X
			stricker3.setID();
			if(stricker3.getID()==stricker1.getID()){
				System.out.println("���̤T���y�����X���o�P���̤@�ۦP�A�Э��s��J");
			}
			else if(stricker3.getID()==stricker2.getID()){
				System.out.println("���̤T���y�����X���o�P���̤G�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		stricker3.setball();
		System.out.println("=========================================");
		System.out.println("�m�]�w�ĥ|�W���̡n");//�]�w�ĥ|�W���̸��
		while(1==1){//�]�w�y���|���X
			stricker4.setID();
			if(stricker4.getID()==stricker1.getID()){
				System.out.println("���̥|���y�����X���o�P���̤@�ۦP�A�Э��s��J");
			}
			else if(stricker4.getID()==stricker2.getID()){
				System.out.println("���̥|���y�����X���o�P���̤G�ۦP�A�Э��s��J");
			}
			else if(stricker4.getID()==stricker3.getID()){
				System.out.println("���̥|���y�����X���o�P���̤T�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		stricker4.setball();
		System.out.println("=========================================");
		System.out.println("�m�]�w�Ĥ��W���̡n");//�]�w�Ĥ��W���̸��
		while(1==1){//�]�w�y�������X
			stricker5.setID();
			if(stricker5.getID()==stricker1.getID()){
				System.out.println("���̤����y�����X���o�P���̤@�ۦP�A�Э��s��J");
			}
			else if(stricker5.getID()==stricker2.getID()){
				System.out.println("���̤����y�����X���o�P���̤G�ۦP�A�Э��s��J");
			}
			else if(stricker5.getID()==stricker3.getID()){
				System.out.println("���̤����y�����X���o�P���̤T�ۦP�A�Э��s��J");
			}
			else if(stricker5.getID()==stricker4.getID()){
				System.out.println("���̤����y�����X���o�P���̥|�ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		stricker5.setball();
		System.out.println("=========================================");
		System.out.println("�m�]�w�Ĥ��W���̡n");//�]�w�Ĥ��W���̸��
		while(1==1){//�]�w�y�������X
			stricker6.setID();
			if(stricker6.getID()==stricker1.getID()){
				System.out.println("���̤����y�����X���o�P���̤@�ۦP�A�Э��s��J");
			}
			else if(stricker6.getID()==stricker2.getID()){
				System.out.println("���̤����y�����X���o�P���̤G�ۦP�A�Э��s��J");
			}
			else if(stricker6.getID()==stricker3.getID()){
				System.out.println("���̤����y�����X���o�P���̤T�ۦP�A�Э��s��J");
			}
			else if(stricker6.getID()==stricker4.getID()){
				System.out.println("���̤����y�����X���o�P���̥|�ۦP�A�Э��s��J");
			}
			else if(stricker6.getID()==stricker5.getID()){
				System.out.println("���̤����y�����X���o�P���̤��ۦP�A�Э��s��J");
			}
			else{
				break;
			}
		}
		stricker6.setball();
		System.out.println("=========================================");
		try{//���̸�Ƴ]�w�����A�M�ŵe��
			new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
		}
		catch(Exception e){
			System.out.println("Fail");
		}
		Pitcher [] pitcherlist={pitcher1,pitcher2,pitcher3};
		Stricker [] strickerlist={stricker1,stricker2,stricker3,stricker4,stricker5,stricker6};
		/*int [] point={{1,2,3},{4,5,6},{7,8,9}}
		String [] hitpoint={{?,?,?},{?,?,?}{?,?,?}}*/
		int CountofPitcherOn=-1;//�ثe�W�������Ǹ�
		int CountofStrickerOn=0;//�ثe�W�������̧Ǹ�
		//�C���}�l
		while(stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy()>0&&pitcher1.getenergy()+pitcher2.getenergy()+pitcher3.getenergy()>0){
			System.out.println("�Ъ��a�ҬD����G��⪬�A�p�U");//�i�J�D�ﶥ�q
			boolean AnyPitcherOn=false;//�O�_�����W��
			System.out.println("\n�m�ثe�W�������G�n");
			for(int i=0;i<3;i++){//��X�ثe�b���W�����
				if(pitcherlist[i].getOnorNot()){
					pitcherlist[i].getdata();
					AnyPitcherOn=true;
					break;
				}
				else if(pitcherlist[i].getOnorNot()==false&&i==2){//���S���h��ܵL
					System.out.print("�L\n");
					AnyPitcherOn=false;
				}
			}
			System.out.println("===========================\n�m�|���W�������n");
			for(int i=0;i<3;i++){//��X���b���W�����
				if(pitcherlist[i].getOnorNot()==false){
					pitcherlist[i].getdata();
				}
			}
			System.out.println("===========================\n�m�Ĥ�|���W�����|�����̡n");
			for(int i=0;i<6;i++){//��X�Ĥ�|���W�����|������
				if(strickerlist[i].getenergy()>0){
					System.out.print(i+1+".");
					strickerlist[i].getdataforpitcher();
				}
			}
			System.out.println("===========================\n�m�п�ܤW�������n\n���O�Gselect pitcher [���y�����X]�A�ο�Jcontinue���");
			while(1==1){//pitcher select while�j��
				String PickPitcher=scan.nextLine();//��J�D���⪺���O
				PickPitcher=PickPitcher.toLowerCase();//�q�q�p�g�H���Ϥ��j�p�g
				int PitcherNumber;//�W�߲y�����X
				String [] PickPitcherCommand=PickPitcher.split("\\ ");//�Ѻc���O
				if(PickPitcherCommand.length==3){//��ϥ�select���O
					try{
						PitcherNumber=Integer.valueOf(PickPitcherCommand[2]);//��y�����X�নint
					}
					catch(Exception e){
						System.out.println("��J���y�����X���~�A�Э��s��J");
						continue;
					}
					if("select".equals(PickPitcherCommand[0])==false){//�pselect��r���X
					System.out.println("��J��select���O���~\n�����Gselect pitcher [���y�����X]");
					continue;//���X�n�D���s��J
					}
					if("pitcher".equals(PickPitcherCommand[1])==false){//�ppitcher��r���X
					System.out.println("��J��select���O���~\n�����Gselect pitcher [���y�����X]");
					continue;//���X�n�D���s��J
					}
					boolean numernotmatch=false;
					boolean noenergy=false;
					for(int i=0;i<3;i++){//�ˬd�y�����X�s�b�P�_
						if(PitcherNumber==pitcherlist[i].getID()){//���X�s�b
							if(pitcherlist[i].getenergy()>0){//�h�ˬd�O�_�٦���O
								if(CountofPitcherOn==-1){//�Ĥ@������{���������Ǹ���l��
									CountofPitcherOn=i;
								}
								int NewCountofPitcherOn=i;//��e���Ǹ���i
								if(NewCountofPitcherOn!=CountofPitcherOn){//�s��ܪ����M��e��⤣�P
									pitcherlist[CountofPitcherOn].setenergy(0);//�h�N�Ѿl��q�k�s
									pitcherlist[CountofPitcherOn].setOnorNot(false);//�N�W���P�_�אּ�_
									CountofPitcherOn=NewCountofPitcherOn;//��s���Ǹ�
								}
								pitcherlist[i].setOnorNot(true);//����O�h�אּ�W��
								break;//���X�y���ˬd�j��
							}
							else{
								noenergy=true;
							}
						}
						else if (i==2){//�Y������粒���L�ŦX�����X
						System.out.println("select���O���y�����X���s�b�]����O��0�^�A�Э��s�ˬd");
						numernotmatch=true;
						}
					}
					if(numernotmatch){//�S���������y���A�n�D���s��J
						continue;//���X�n�D���s��J
					}
					if(noenergy){//��O�����A�n�D���s��J
						continue;//�S����O�n�D���s��J
					}
					try{//�W�����]�w�����A�M�ŵe��
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;//���Xpitcher select while�j��
				}
				else if(PickPitcherCommand.length==1&&"continue".equals(PickPitcherCommand[0])){//�ˬd���ײŤ��ŦX�A�B�ˬd�O�_��continue
					if(AnyPitcherOn==false){
						System.out.println("���W�L���A�L�k�ϥ�continue���O");
					}
					else{
						try{//�W�����]�w�����A�M�ŵe��
							new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
						}
						catch(Exception e){
							System.out.println("Fail");
						}
						break;
					}
				}
				else{//�����X����
				System.out.println("��J�����O�榡���~�C\n�D����п�J�Gselect pitcher [���y�����X]\n�~��ϥθӧ��h��Jcontinue");
				}
			}
			//�}�l�]�w�W������
			System.out.println("�m�|�����|�W�������̡G�n");
			for(int i=0;i<6;i++){//��X�������|�W��������
				if(strickerlist[i].getenergy()>0){
				strickerlist[i].getdata();
				}
			}
			System.out.println("===========================\n�m�ثe�b���W�����n");
			pitcherlist[CountofPitcherOn].getdataforstricker();
			System.out.println("===========================\n�m�п�ܤW�������̡n\n���O�Gselect batter [���̲y�����X]");
			while(1==1){//stricker select while�j��
				String PickStricker=scan.nextLine();//��J�D���⪺���O
				PickStricker=PickStricker.toLowerCase();//�q�q�p�g�H���Ϥ��j�p�g
				int StrickerNumber;//�W�߲y�����X
				String [] PickStrickerCommand=PickStricker.split("\\ ");//�Ѻc���O
				if(PickStrickerCommand.length==3){//��ϥ�select���O
					try{
						StrickerNumber=Integer.valueOf(PickStrickerCommand[2]);//��y�����X�নint
					}
					catch(Exception e){
						System.out.println("��J���y�����X���~�A�Э��s��J");
						continue;
					}
					if("select".equals(PickStrickerCommand[0])==false){//�pselect��r���X
					System.out.println("��J��select���O���~\n�����Gselect batter [���̲y�����X]");
					continue;//���X�n�D���s��J
					}
					if("batter".equals(PickStrickerCommand[1])==false){//�pbatter��r���X
					System.out.println("��J��select���O���~\n�����Gselect batter [���̲y�����X]");
					continue;//���X�n�D���s��J
					}
					boolean numernotmatch=false;
					boolean noenergy=false;
					for(int i=0;i<6;i++){//�ˬd�y�����X�s�b�P�_
						if(StrickerNumber==strickerlist[i].getID()){//���X�s�b
							if(strickerlist[i].getenergy()>0){//�h�ˬd�O�_�٦���O
								CountofStrickerOn=i;//�N�W�����̧Ǹ��אּ�Ӳy��
								break;//���X�y���ˬd�j��
							}
							else{
								System.out.println("select���O���y���w�g�S����O�A�Э��s��J");
								noenergy=true;
								break;
							}
						}
						else if (i==5){//�Y������粒���L�ŦX�����X
						System.out.println("select���O���y�����X���s�b�A�Э��s�ˬd");
						numernotmatch=true;
						}
					}
					if(numernotmatch){//�S���ǰt���y�����X�A�n�D���s��J
						continue;
					}
					if(noenergy){
						continue;
					}
					try{//�W�����̳]�w�����A�M�ŵe��
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;//���Xstricker select while�j��
				}
				else{//�����X����
				System.out.println("��J�����O�榡���~�C\n�D����п�J�Gselect batter [���̲y�����X]");
				}
			}
			System.out.println("�m�ثe�b���W�����n");
			pitcherlist[CountofPitcherOn].getdata();
			System.out.println("===========================\n�m�ثe�b���W�����̡n\n");
			System.out.println("�y�����X�G"+strickerlist[CountofStrickerOn].getID());
			System.out.println("===========================\n�Ъ��a�ҿ�ܲy�ؤζi�S�I�G\n���O�Gpitch [�y�ؽs��] [�i�S�I�s��] �]�i�S�I�s����1-9����ơ^");
			int PitchPoint=0;//�W�߶i�S�I
			int SwingPoint=0;//�����I
			String BallType=new String();
			while(1==1){//��y���O�j��
				String PitchCommand=scan.nextLine();//��J��y���O
				PitchCommand=PitchCommand.toLowerCase();//�q�q�p�g�H���Ϥ��j�p�g
				String [] SplitPitchCommand=PitchCommand.split("\\ ");//�Ѻc���O
				if(SplitPitchCommand.length==3){//�ʲ��ˬd���O�榡
					try{//�קK�i�y�I���p�Ƴy���{���h�X
						PitchPoint=Integer.valueOf(SplitPitchCommand[2]);
					}
					catch(Exception e){
						System.out.println("��J�i�y�I���~�A�Э��s��J�]����1-9������ơ^");
						continue;
					}
					if("pitch".equals(SplitPitchCommand[0])==false){//�ˬdpitch���r
						System.out.println("��J����y���O���~�A�Э��s�T�{\n���O�Gpitch [�y�ؽs��] [�i�S�I�s��]");
						continue;
					}
					if(pitcherlist[CountofPitcherOn].getballA().equals(SplitPitchCommand[1])){//�ˬd�y�جO�_�s�b
						BallType=pitcherlist[CountofPitcherOn].getballA();
					}
					else if(pitcherlist[CountofPitcherOn].getballB().equals(SplitPitchCommand[1])){
						BallType=pitcherlist[CountofPitcherOn].getballB();
					}
					else if(pitcherlist[CountofPitcherOn].getballC().equals(SplitPitchCommand[1])){
						BallType=pitcherlist[CountofPitcherOn].getballC();
					}
					else{
						System.out.println("��J�ժ��y�ؤ��s�b�A�Э��s�T�{");
						continue;
					}
					if(PitchPoint<1||PitchPoint>9){//�ˬd�i�y�I�s���s�b
						System.out.println("��J�i�y�I���~�A�Э��s��J�]����1-9������ơ^");
						continue;
					}
					try{//��y�I�]�w�����A�M�ŵe��
						new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
					}
					catch(Exception e){
						System.out.println("Fail");
					}
					break;
				}
				else{
					System.out.println("��J����y���O���~�A�Э��s�T�{\n���O�Gpitch [�y�ؽs��] [�i�S�I�s��]�]�i�S�I�s����1-9����ơ^");
				}
			}
			if(BallType.equals(strickerlist[CountofStrickerOn].getball())){
				System.out.println("���ߡI����X���̾ժ��y��\n�ߤ@�i�S�I���G"+PitchPoint);
			}
			else if (PitchPoint==1){
				System.out.println("����y�F\n�i�઺�i�S�I���G1�B2�B4�B5");
			}
			else if (PitchPoint==3){
				System.out.println("����y�F\n�i�઺�i�S�I���G2�B3�B5�B6");
			}
			else if (PitchPoint==7){
				System.out.println("����y�F\n�i�઺�i�S�I���G4�B5�B7�B8");
			}
			else if (PitchPoint==9){
				System.out.println("����y�F\n�i�઺�i�S�I���G5�B6�B8�B9");
			}
			//��⬰�k��W��
			else if("right".equals(pitcherlist[CountofPitcherOn].getside())&&"up".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==2){
					System.out.println("����y�F\n�i�઺�i�S�I���G1�B2�B4�B5");
				}
				else if(PitchPoint==6){
					System.out.println("����y�F\n�i�઺�i�S�I���G5�B6�B8�B9");
				}
				else{//PitchPoint=4�B5�B8
					System.out.println("����y�F\n�i�઺�i�S�I���G4�B5�B7�B8");
				}
			}
			//��⬰�k��C��
			else if("right".equals(pitcherlist[CountofPitcherOn].getside())&&"down".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==6){
					System.out.println("����y�F\n�i�઺�i�S�I���G2�B3�B5�B6");
				}
				else if(PitchPoint==8){
					System.out.println("����y�F\n�i�઺�i�S�I���G4�B5�B7�B8");
				}
				else{//PitchPoint=2�B4�B5
					System.out.println("����y�F\n�i�઺�i�S�I���G1�B2�B4�B5");
				}
			}
			//��⬰����W��
			else if("left".equals(pitcherlist[CountofPitcherOn].getside())&&"up".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==2){
					System.out.println("����y�F\n�i�઺�i�S�I���G2�B3�B5�B6");
				}
				else if(PitchPoint==4){
					System.out.println("����y�F\n�i�઺�i�S�I���G4�B5�B7�B8");
				}
				else{//PitchPoint=5�B6�B8
					System.out.println("����y�F\n�i�઺�i�S�I���G5�B6�B8�B9");
				}
			}
			//��⬰����C��
			else if("left".equals(pitcherlist[CountofPitcherOn].getside())&&"down".equals(pitcherlist[CountofPitcherOn].gethigh())){
				if(PitchPoint==4){
					System.out.println("����y�F\n�i�઺�i�S�I���G1�B2�B4�B5");
				}
				else if(PitchPoint==8){
					System.out.println("����y�F\n�i�઺�i�S�I���G5�B6�B8�B9");
				}
				else{//PitchPoint=2�B5�B6
					System.out.println("����y�F\n�i�઺�i�S�I���G2�B3�B5�B6");
				}
			}
			System.out.println("===========================\n�Ъ��a�A��ܥ����I��m\n���O���Gswing [�����I�s��]�]�����I�s����1-9����ơ^ ");
			while(1==1){//���Ϋ��O�j��
				String SwingCommand=scan.nextLine();
				SwingCommand=SwingCommand.toLowerCase();
				String [] SplitSwingCommand=SwingCommand.split("\\ ");
				if(SplitSwingCommand.length==2){
					try{//�קK�����I���p�Ƴy���{���h�X
						SwingPoint=Integer.valueOf(SplitSwingCommand[1]);
					}
					catch(Exception e){
						System.out.println("��J�����I���~�A�Э��s��J�]����1-9������ơ^");
						continue;
					}
					if("swing".equals(SplitSwingCommand[0])==false){//�ˬdswing���r
						System.out.println("��J��swing���O���~�Э��s�T�{\n���O���Gswing [�����I�s��]");
						continue;
					}
					if(SwingPoint<1||SwingPoint>9){
						System.out.println("��J�����I���~�A�Э��s��J�]����1-9������ơ^");
						continue;
					}
					break;
				}
				else{
					System.out.println("��J��swing���O���~�Э��s�T�{\n���O���Gswing [�����I�s��]");
				}
			}
			try{//�����I�]�w�����A�M�ŵe��
				new ProcessBuilder("cmd", "/c", "cls").inheritIO().start().waitFor();
			}
			catch(Exception e){
				System.out.println("Fail");
			}
			String HitorNot=new String();
			if(PitchPoint==SwingPoint){
				point+=1;
				HitorNot="����";
			}
			else{
				HitorNot="����";
			}
			pitcherlist[CountofPitcherOn].pitch();
			strickerlist[CountofStrickerOn].strick();
			System.out.println("�m�^�X����e���n");
			System.out.println("���W���y�����X�G"+pitcherlist[CountofPitcherOn].getID());
			System.out.println("���W���̲y�����X�G"+strickerlist[CountofStrickerOn].getID());
			System.out.println("�������G�G"+HitorNot);
			System.out.println("���a�A�ثe�o���G"+point+"\n===========================");
		}
		if(stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy()>0){
			point=point+stricker1.getenergy()+stricker2.getenergy()+stricker3.getenergy()+stricker4.getenergy()+stricker5.getenergy()+stricker6.getenergy();
		}
		System.out.println("���a�A���̲ױo�����G"+point+"��");
	}//main�j�A��
}//�̥~�h�j�A��