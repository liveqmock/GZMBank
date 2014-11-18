package com.gdbocom.util.format;

import java.text.*;

public class CommonFormatter{

	/** 格式话金额类型 */
	public static final int CURRENCY = 1;

	public static String getFormattedValue(String value, int FormaterType) {
		if(CURRENCY==FormaterType){
			return getCurrencyFormatter(value);

		}else{
			return value;
		}

	}

	/**
	 * 格式化金额，增加千分号和小数点,分为单位
	 * @param value
	 * @return
	 */
	private static String getCurrencyFormatter(String value){
		return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
	};

	public static void main(String[] args) {
		System.out.println(CommonFormatter
				.getFormattedValue("1000", CommonFormatter.CURRENCY));
				
		System.out.println(CommonFormatter
				.getFormattedValue("1000", 0));

	}

}
