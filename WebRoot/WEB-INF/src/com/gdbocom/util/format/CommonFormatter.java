package com.gdbocom.util.format;

import java.text.*;

public class CommonFormatter implements FormatterInterface{

	/** 格式话金额类型 */
	public static final int CURRENCY = 1;
	/** 格式类型 */
	private int FormatterType = 0;
	/** 单例 */
	private static CommonFormatter currencyFormatter =
			new CommonFormatter(CommonFormatter.CURRENCY);

	/**
	 * 生成对应的格式类
	 * @param FormatterType
	 */
	private CommonFormatter(int formatterType){
		this.FormatterType = formatterType;
	}

	/**
	 * 为防止格式类太多，使用单例模式
	 * @param formatterType
	 * @return
	 */
	public static CommonFormatter getSingleton(int formatterType){
		if(CURRENCY==formatterType){
			return currencyFormatter;

		}else{
			return null;
		}

	}

	/**
	 * 得到对应的值
	 * @param value
	 * @return
	 */
	public String getFormattedValue(String value) {
		if(CURRENCY==this.FormatterType){
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
		System.out.println(CommonFormatter.getSingleton(CommonFormatter.CURRENCY)
				.getFormattedValue("1000"));
				
		System.out.println(CommonFormatter.getSingleton(0)
				.getFormattedValue("1000"));

	}

}
