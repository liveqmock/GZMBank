package com.gdbocom.util.format;

import com.gdbocom.util.format.CommonFormatter;

public class WelFormatter implements FormatterInterface{

	//福利彩票特殊的格式化类型
	public static final int BetNum = 2;
	public static final int Currency = 3;

	public String getFormattedValue(String value, int FormaterType) {
		if(BetNum==FormaterType){
			return getBetNumFormatter(value);

		}else if(Currency==FormaterType){
			return getCurrencyFormatter(value);

		}else{
			return value;
		}
	}

	public String getCurrencyFormatter(String value){
		return new CommonFormatter().getDecimalFormatter(value) + " 元";
	};

	public String getBetNumFormatter(String value){
		StringBuffer result = new StringBuffer();
		int length = value.length();
		int offset = 0;
		//前区
		int foreCnt = Integer.valueOf(value.substring(0, 2)).intValue();
		offset += 2;
		for(int i=0; i<foreCnt; i++, offset +=2){
			result.append(value.substring(i*2+2, i*2+4));
			System.out.println("result::"+result);

			//最后一个号码不需要逗号
			if(i<foreCnt-1){
				result.append(", ");
			}
			
		}
		result.append("#");
		//后区
		int backCnt = Integer.valueOf(value.substring(offset, offset+2)).intValue();
		offset += 2;
		//String backString = value.substring(offset);
		for(int i=0; i<backCnt; i++, offset +=2){
			result.append(value.substring(foreCnt*2+i*2+2, foreCnt*2+i*2+4));
			//最后一个号码不需要逗号
			if(i<backCnt-1){
				result.append(", ");
			}
			
			
		}
		
		return result.toString();

	}
	public static void main(String[] args) {
//		System.out.println(FormatterFactory
//				.getFormattedValue(new WelFormatter(), "1000", WelFormatter.Currency));
		System.out.println(FormatterFactory
				.getFormattedValue(new WelFormatter(), "0211120122", WelFormatter.BetNum));
		System.out.println(FormatterFactory
				.getFormattedValue(new WelFormatter(), "02111203222324", WelFormatter.BetNum));
//		System.out.println(FormatterFactory
//				.getFormattedValue(new WelFormatter(), "1000", 0));


	}

}
