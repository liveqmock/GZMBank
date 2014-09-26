package com.gdbocom.test;

import com.gdbocom.lottdraw.TipsShow;

public class drawLawTest {

	/**
	 * @param args
	 */
	public static void main(String[] args) {
		drawLawTest test = new drawLawTest();
		for(int i=0; i<10; i++){
			System.out.println(i+":"+test.drawLaw(i));
		}
		System.out.println("2641:"+test.drawLaw(2641));
		System.out.println("3001:"+test.drawLaw(3001));
		System.out.println("1999:"+test.drawLaw(1999));
		
	}

	public int drawLaw(int exist_number){
    	boolean OUTSTANDING_switch = false;//�صȽ�����
	    boolean MAJOR_switch = true;//һ�Ƚ�����
	    
		if(OUTSTANDING_switch&&exist_number==99999){//�صȽ�
			return TipsShow.OUTSTANDING;
		}else if(MAJOR_switch&&(exist_number==2641)){//һ�Ƚ�
			return TipsShow.MAJOR;
		}else if((exist_number%1000==999||exist_number==3001)&&(exist_number!=1999)){//���Ƚ�
			return TipsShow.ACCESSIT;
		}else if(exist_number%2==0){//���Ƚ�
			return TipsShow.THIRD_CLASS;
		}else{//����
			return TipsShow.NONE;
		}
	}
}
