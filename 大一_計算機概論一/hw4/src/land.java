public class land{
	String[]SoilList={"�L","sand","clay","loam"};
	String[]PlantList={"�L","watermelon","mulberry"};
	int[]PlantMaxWet={0,25,35};
	int[]PlantMinWet={0,15,25};
	int[]OutputList={0,4,8};//�w�����q�C��
	int[]OutputDateList={0,12,16};//���X�ɶ��C��
	int[]PriceList={0,35,10};//����C��
	private int soil=0;//�g�[�s���A�w�]��0(�L�ش�)
	private int plant=0;//�Ӫ��s���A�w�]��-1(�L�ش�)	
	private int output=0;//�w�����q	
	private int predictrev=0;//�w�����J
	private int outputdate=0;//�����˼�	
	private int date=0;//�ͪ��Ѽ�
	private int wet=20;//��l��׬�20
	private int deathcount=0;//�p��ӴӪ����g���X��ת��Ѽ�
	private boolean decline=false;//�O�_�|��ֲ��q
	private boolean firstdecline=true;//�Ĥ@���F�T�Ѥ��|��ֲ��q
	
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
	public void grow(int p){//�شӴӪ����O
		if(plant==0&&soil==1){
			plant=p;
			output=OutputList[p];
			outputdate=OutputDateList[p];
			date=0;
			System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
			predictrev=PriceList[plant]*output;
		}
		else if(plant==0&&soil==2){
			plant=p;
			output=OutputList[p]-1;
			outputdate=OutputDateList[p]-3;
			date=0;
			System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
			predictrev=PriceList[plant]*output;
		}
		else if(plant==0&&soil==3){
			plant=p;
			output=OutputList[p]+1;
			outputdate=OutputDateList[p]+3;
			date=0;
			System.out.println("���\��"+PlantList[plant]+"�ؤJ"+SoilList[soil]+"��");
			predictrev=PriceList[plant]*output;
		}
		else{
			System.out.println("�Ӷ��a�w�g�ؤF"+PlantList[plant]+"�б����s��g�A�ոէa�I");
		}
	}
	public void deathcheck(){//�L�]&����ˬd
		if(plant>0){
			predictrev=PriceList[plant]*output;
			if(wet>PlantMaxWet[plant]||wet<PlantMinWet[plant]&&outputdate>0){
				deathcount++;
				date++;
				outputdate--;
				if(deathcount==3){
					decline=true;
				}
				else if(deathcount==5){//�Ӫ������F�A��l��
					System.out.println("�A�ت�"+PlantList[plant]+"�]��������פ��X�����F�A�U���n�n�n���U����I");
					resetland();
				}
				if(decline&&firstdecline==false){
					output--;
				}
				if(output==0){
					System.out.println("�A�ت�"+PlantList[plant]+"�]���L�k���G�����F�A�U���n�n�n���U����I");
					resetland();
				}
				if(decline&&firstdecline){
					firstdecline=false;
				}
			}
			else if(outputdate>0){
				deathcount=0;
				date++;
				if(outputdate>0){
					outputdate--;
				}
			}
			if(outputdate==0&&plant>0){
				System.out.println("�A�ت�"+PlantList[plant]+"�w�g�����F�A�֥�reap and sell ���O���Χa�I");
			}
		}
	}
	public void printdata(int i){
		if(soil>0){
			if(plant>0){
				System.out.println("�g�a"+i+"\n�g�[�G"+SoilList[soil]+"    �Ӫ��G"+PlantList[plant]+"   ��׬��G"+wet);
				if(outputdate>0){
				System.out.println("�w�ͪ�"+date+"��     �w�p�A�L "+outputdate+" �ѵ��� "+output+" ���G��G");
				}
				else{
				System.out.println("�w�ͪ�"+date+"��     �w�g���� "+output+" ���G��G");
				}
				System.out.println("��׳s�򥼹F�Фw"+deathcount+"��    �@���O�_���i���]��״��s��T�ѥ��F�С^"+decline);
			}
			else{
				System.out.println("�g�a"+i+"\n�g�[�G"+SoilList[soil]+"    ��׬��G"+wet);
			}
		}
		else{
		System.out.println("�Цa�ثe�ŪŦp�]�A�h�ө��R�I�ӧ��a");
		}
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
	public int getpredictrev(){//�o��w�����q�A�Ω󵲧��C���ˬd�\��//�o��w�����q�A�Ω󵲧��C���ˬd�\��
		return predictrev;
	}
	
}