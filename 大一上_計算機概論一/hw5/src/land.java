public class land{
	String[]SoilList={"�L","sand","clay","loam","magicdust"};
	String[]PlantList={"�L","watermelon","mulberry","sungrass","starflower"};
	int[]PlantMaxWet={0,25,35,20,40};
	int[]PlantMinWet={0,15,25,10,30};
	int[]OutputList={0,4,8,6,8};//�w�����q�C��A���̬��\�૬�Ӫ����Ѿl�Ѽ�
	int[]OutputDateList={0,12,16};//���X�ɶ��C��
	int[]PriceList={0,35,10,0,0};//����C��]���̬��\��ʧ@���B0���^
	private int id=0;//�g�a�s���A��K�t�δ���
	private int soil=0;//�g�[�s���A�w�]��0(�L�ش�)
	private int plant=0;//�Ӫ��s���A�w�]��0(�L�ش�)
	private int output=0;//�w�����q	
	private int predictrev=0;//�w�����J
	private int outputdate=0;//�����˼�	
	private int date=0;//�ͪ��Ѽ�
	private int wet=20;//��l��׬�20
	private int deathcount=0;//�p��ӴӪ����g���X��ת��Ѽ�
	private int playerjob=0;//�x�s���a��¾�~�]�Ӫ��Ǯa&�ӤH�Ρ^
	private boolean decline=false;//�O�_�|��ֲ��q
	private boolean sungrasseff=false;//�O�_���L�Ӷ���v�T
	private boolean starflowereff=false;//�O�_���L�P����v�T
	private boolean firstdecline=true;//�Ĥ@���F�T�Ѥ��|��ֲ��q
	public void setid(int newid){//�]�w�g�a�s��(1-9)
		id=newid;
	}
	public void setplayerjob(int newjob){//�g�J���a¾�~
		playerjob=newjob;
	}
	public void resetland(){//���]�g�[���O
			soil=0;
			plant=0;
			output=0;
			outputdate=0;
			date=0;
			wet=20;
			deathcount=0;
			decline=false;
			firstdecline=true;
	}
	public void setsoil(int s){//��g���O
		soil=s;
		plant=0;
		output=0;
		outputdate=0;
		date=0;
		wet=20;
		deathcount=0;
		decline=false;
		firstdecline=true;
	}
	public void wetchange(int i){//������ס]�i��]������Ѯ�...�v�T�^
		wet+=i;
		if(wet>100){
			wet=100;
		}
		else if(wet<0){
			wet=0;
		}
	}
	public boolean grow(int p){//�شӴӪ����O
		boolean planted=false;//�Ӧ��O�_�����\�ش�
		if(p<3){
			if(plant==0&&soil==1){
				plant=p;
				output=OutputList[p];
				outputdate=OutputDateList[p];
				date=0;
				System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//�p�G���a�O�ӤH
					predictrev+=output;//���+1
				}
				planted=true;
			}
			else if(plant==0&&soil==2){
				plant=p;
				output=OutputList[p]-1;
				outputdate=OutputDateList[p]-3;
				date=0;
				System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//�p�G���a�O�ӤH
					predictrev+=output;//���+1
				}
				planted=true;
			}
			else if(plant==0&&soil==3){
				plant=p;
				output=OutputList[p]+1;
				outputdate=OutputDateList[p]+3;
				date=0;
				System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
				predictrev=PriceList[plant]*output;
				if(playerjob==2){//�p�G���a�O�ӤH
					predictrev+=output;//���+1
				}
				planted=true;
			}
			else if(plant==0&&soil==4){
				System.out.println("�]�k�g�u��إ\�૬�Ӫ�");
			}
			else{
				System.out.println("�Ӷ��a�w�g�ؤF"+PlantList[plant]+"�б����s��g�A�ոէa�I");
			}
		}
		else if (p>2){
			if(plant==0&&soil==4){
				plant=p;
				output=OutputList[p];
				planted=true;
				outputdate=1;//���|��ʡ]�]�ë��ˬd�����ݬݳѾl���X�ɶ��A�G�]�@��>0���ơ^
				System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
			}
			else if (plant==0&&soil!=4){
				System.out.println("�\�૬�Ӫ��u��ئb�]�k�g��");
			}
			else{
				System.out.println("�Ӷ��a�w�g�ؤF"+PlantList[plant]+"�б����s��g�A�ոէa�I");
			}
		}
		if(planted&&playerjob==1){//�Ӧ��شӦ��\�A�B���a¾�~���Ӫ��Ǯa
			output++;
		}
		return planted;
	}
	public void deathcheck(){//�L�]&����ˬd
		if(plant>0){
			if(wet>PlantMaxWet[plant]||wet<PlantMinWet[plant]&&outputdate>0){
				if(plant<3){
					deathcount++;
					date++;
					outputdate--;
					if(deathcount==3){
						decline=true;
					}
					else if(deathcount==5){//�Ӫ������F�A��l��
						System.out.println("�Цa"+id+"����"+PlantList[plant]+"�]��������פ��X�����F�A�U���n�n�n���U����I");
						resetland();
					}
					if(decline&&firstdecline==false){
						output--;
					}
					if(output==0&&plant>0){
						System.out.println("�Цa"+id+"����"+PlantList[plant]+"�]���L�k���G�����F�A�U���n�n�n���U����I");
						resetland();
					}
					if(decline&&firstdecline){
						firstdecline=false;
					}
				}
				else{
					date++;
					output-=2;//��֥\�૬�Ӫ��Ѿl�Ѽƨ�ѡ]�쥻�@��+��פ��X�@�ѡ^
					if(output<=0){
						System.out.println("�Цa"+id+"����"+PlantList[plant]+"�]���ɶ���F�Ӭ\��");
						resetland();
					}
				}
			}
			else if(outputdate>0){//�ŦX��ת��g�٧@��
				deathcount=0;
				date++;
				outputdate--;
			}
			else if(plant>2){//�\�૬�Ӫ��]�ɶ��I��
				date++;
				output--;
				if(output<=0){
						System.out.println("�Цa"+id+"����"+PlantList[plant]+"�]���ɶ���F�Ӭ\��");
						resetland();
					}
			}
			if(outputdate==0&&plant>0&&plant<3){//�w�g�������g�٫��@��
				System.out.println("�Цa"+id+"����"+PlantList[plant]+"�w�g�����F�A�֥�reap and sell ���O���Χa�I");
			}
			predictrev=PriceList[plant]*output;
			if(playerjob==2){//�p�G���a�O�ӤH
					predictrev+=output;//���+1
			}
		}
	}
	public void sungrasseff(){//���Ӷ���v�T
		if(sungrasseff==false&&plant>0&&plant<3){
			outputdate-=3;
			sungrasseff=true;
		}
	}
	public void starflowereff(){//���P����v�T
		if(starflowereff==false&&outputdate>0&&plant>0&&plant<3){
			output++;
			starflowereff=true;
		}
	}
	public void printdata(int i){
		if(soil>0){
			if(plant>0&&plant<3){//�ȿ����Ӫ�
				System.out.println("�m�Цa"+i+"�n\n�g�[�G"+SoilList[soil]+"    �Ӫ��G"+PlantList[plant]+"   ��׬��G"+wet);
				if(outputdate>0){
				System.out.println("�w�ͪ�"+date+"��     �w�p�A�L "+outputdate+" �ѵ��� "+output+" ���G��G");
				}
				else{
				System.out.println("�w�ͪ�"+date+"��     �w�g���� "+output+" ���G��G");
				}
				System.out.println("��׳s�򥼹F�Фw"+deathcount+"��    �@���O�_���i���]��״��s��T�ѥ��F�С^"+decline);
			}
			else if(plant>2){//�\�૬�Ӫ�
				System.out.println("�m�Цa"+i+"�n\n�g�[�G"+SoilList[soil]+"    �Ӫ��G"+PlantList[plant]+"   ��׬��G"+wet);
				System.out.println("�w�ͪ�"+date+"��     �w�p�A�L "+output+" �Ѧ��`�G");
			}
			else{
				System.out.println("�m�Цa"+i+"�n\n�g�[�G"+SoilList[soil]+"    ��׬��G"+wet+"\n�ثe�S���Ӫ�");
			}
		}
		else{
			System.out.println("�m�Цa"+i+"�n");
			System.out.println("�Цa"+i+"�ثe�ŪŦp�]�A�h�ө��R�I�ӧ��a");
		}
	}
	public int getid(){//�^�Ǥg�a�s��(1-9)
		return id;
	}
	public int getsoil(){//�^�Ǥg�[����
		return soil;
	}
	public int getplant(){//�^�ǧ@���s��
		return plant;
	}
	public int getwet(){//�^�����
		return wet;
	}
	public int getoutputdate(){//�^�Ǧ������
		return outputdate;
	}
	public int getpredictrev(){//�o��w�����q�A�Ω󵲧��C���ˬd�\��
		return predictrev;
	}
	public String toString(){
		return ("�Цa"+id);
	}
	public String intinfo(){
		String data=id+","+soil+","+plant+","+output+","+predictrev+","+outputdate+","+date+","+wet+","+deathcount+","+playerjob;
		return data;
	}
	public String booleaninfo(){
		String data=decline+","+sungrasseff+","+starflowereff+","+firstdecline;
		return data;
	}
	public void setintdata(String a,String b,String c,String d,String e,String f,String g,String h,String i,String j){
		id=Integer.valueOf(a);
		soil=Integer.valueOf(b);
		plant=Integer.valueOf(c);
		output=Integer.valueOf(d);
		predictrev=Integer.valueOf(e);
		outputdate=Integer.valueOf(f);
		date=Integer.valueOf(g);
		wet=Integer.valueOf(h);
		deathcount=Integer.valueOf(i);
		playerjob=Integer.valueOf(j);
	}
	public void setbooleandata(String a,String b,String c,String d){
		decline=Boolean.valueOf(a);
		sungrasseff=Boolean.valueOf(b);
		starflowereff=Boolean.valueOf(c);
		firstdecline=Boolean.valueOf(d);
	}
}