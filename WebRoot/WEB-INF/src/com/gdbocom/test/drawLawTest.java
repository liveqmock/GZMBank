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
    	boolean OUTSTANDING_switch = false;//特等奖开关
	    boolean MAJOR_switch = true;//一等奖开关
	    
		if(OUTSTANDING_switch&&exist_number==99999){//特等奖
			return TipsShow.OUTSTANDING;
		}else if(MAJOR_switch&&(exist_number==2641)){//一等奖
			return TipsShow.MAJOR;
		}else if((exist_number%1000==999||exist_number==3001)&&(exist_number!=1999)){//二等奖
			return TipsShow.ACCESSIT;
		}else if(exist_number%2==0){//三等奖
			return TipsShow.THIRD_CLASS;
		}else{//不中
			return TipsShow.NONE;
		}
	}
}
