package com.gdbocom.util.format;

import com.gdbocom.Transactions.WelLot;

public class WelFormatter implements FormatterInterface{

	/** 福利彩票特殊的格式化类型 */
	public static final int BETNUM = 2;
	/** 格式化金额类型 */
	public static final int CURRENCY = 3;
	/** 格式化套餐类型 */
	public static final int PACKAGE = 4;
	/** 格式类型 */
	private int formatterType = 0;
	/** 单例 */
	private static WelFormatter betNumFormatter =
			new WelFormatter(WelFormatter.BETNUM);
	private static WelFormatter currencyFormatter =
			new WelFormatter(WelFormatter.CURRENCY);
	private static WelFormatter packageFormatter =
			new WelFormatter(WelFormatter.PACKAGE);


	/**
	 * 生成对应的格式类
	 * @param FormatterType
	 */
	private WelFormatter(int formatterType){
		this.formatterType = formatterType;
	}

	/**
	 * 为防止格式类太多，使用单例模式获取格式话对象
	 * @param formatterType
	 * @return
	 */
	public static WelFormatter getSingleton(int formatterType){
		if(BETNUM==formatterType){
			return betNumFormatter;

		}else if(CURRENCY==formatterType){
			return currencyFormatter;

		}else if(PACKAGE==formatterType){
			return packageFormatter;

		}else{
			return null;
		}

	}

	/**
	 * 根据不同格式类型来格式化值
	 * @param value
	 * @param formatterType
	 * @return
	 */
	public String getFormattedValue(String value) {
		if(BETNUM==this.formatterType){
			return getBetNumFormatter(value);

		}else if(CURRENCY==this.formatterType){
			return getCurrencyFormatter(value);

		}else if(PACKAGE==this.formatterType){
			return getPackageFormatter(Integer.valueOf(value).intValue());

		}else{
			return value;
		}
	}

	/**
	 * 在送过来的数字后面增加“元”，分为单位
	 * @param value
	 * @return
	 */
	private static String getCurrencyFormatter(String value){
		return CommonFormatter.getSingleton(CommonFormatter.CURRENCY)
				.getFormattedValue(value)
				+ " 元";
	};

	/**
	 * 套餐名称代码转换
	 * @param value
	 * @return
	 */
	private static String getPackageFormatter(int value){
		if(value==WelLot.DOUBLE_FIX_PACKAGE_153){
			return "双色球153期套餐";
		}else if(value==WelLot.DOUBLE_FIX_PACKAGE_72){
			return "双色球72期套餐";
		}else{
			return "非法套餐";
		}
	};

	/**
	 * 格式话投注号码，如
	 * 021112032223将格式化成11，12#03，22，23
	 * @param value
	 * @return
	 */
	private static String getBetNumFormatter(String value){

		StringBuffer result = new StringBuffer();
		int offset = 0;

		//前区
		int foreCnt = Integer.valueOf(value.substring(0, 2)).intValue();
		offset += 2;
		for(int i=0; i<foreCnt; i++, offset +=2){
			result.append(value.substring(i*2+2, i*2+4));

			//最后一个号码不需要逗号
			if(i<foreCnt-1){
				result.append(", ");
			}
			
		}
		result.append("#");

		//双色球交易没有后区
		if(offset<value.length()){
			//后区
			int backCnt = Integer.valueOf(value.substring(offset, offset+2)).intValue();
			offset += 2;

			for(int i=0; i<backCnt; i++, offset +=2){
				result.append(value.substring(foreCnt*2+i*2+2, foreCnt*2+i*2+4));
				//最后一个号码不需要逗号
				if(i<backCnt-1){
					result.append(", ");
				}
				
				
			}
		}
		return result.toString();

	}

	public static void main(String[] args) {

		System.out.println(WelFormatter.getSingleton(WelFormatter.BETNUM)
				.getFormattedValue("0211120122"));

		System.out.println(WelFormatter.getSingleton(WelFormatter.BETNUM)
				.getFormattedValue("02111203222324"));
		
		System.out.println(WelFormatter.getSingleton(WelFormatter.CURRENCY)
				.getFormattedValue("1011"));

		System.out.println(WelFormatter.getSingleton(WelFormatter.PACKAGE)
				.getFormattedValue(String.valueOf(WelLot.DOUBLE_FIX_PACKAGE_72)));


	}

}
