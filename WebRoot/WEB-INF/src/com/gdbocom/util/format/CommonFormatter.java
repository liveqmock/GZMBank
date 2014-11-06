package com.gdbocom.util.format;

import java.text.*;

public class CommonFormatter implements FormatterInterface{

	//通用的格式化类型
	public static final int BigDecimal = 1;

	public String getFormattedValue(String value, int FormaterType) {
		if(BigDecimal==FormaterType){
			return getDecimalFormatter(value);

		}else{
			return value;
		}

	}

	public String getDecimalFormatter(String value){
		return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
	}

	public static void main(String[] args) {
		System.out.println(FormatterFactory
				.getFormattedValue(new CommonFormatter(), "1000", CommonFormatter.BigDecimal));
		System.out.println(FormatterFactory
				.getFormattedValue(new CommonFormatter(), "1000", 0));

	}

}
