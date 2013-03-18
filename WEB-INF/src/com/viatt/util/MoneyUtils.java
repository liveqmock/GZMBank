package com.viatt.util;

import java.text.DecimalFormat;

public class MoneyUtils {
	// 120,000,000,000.22
	private static String moneyFormat = ",##0.00";

	public MoneyUtils() {
	}

	/**
	 * 将钱格式化
	 * 
	 * @param money
	 *            钱数
	 * @return 字符串
	 */
	public static String FormatMoney(double money) {
		DecimalFormat df = new DecimalFormat(moneyFormat);
		return df.format(money);
	}

	public static String FormatMoney(String moneyStr) {
		double money = 0;
		try {
			money = Double.parseDouble(moneyStr);
		} catch (Exception e) {
		}
		DecimalFormat df = new DecimalFormat(moneyFormat);
		return df.format(money);
	}

	/**
	 * 将钱格式化
	 * 
	 * @param money
	 *            钱数
	 * @param format
	 *            格式化参数
	 * @return 字符串
	 */
	public static String FormatMoney(double money, String format) {
		DecimalFormat df = new DecimalFormat(format);
		return df.format(money);
	}

	public static String FormatMoney(String moneyStr, String format) {
		DecimalFormat df = new DecimalFormat(format);
		double money = 0;
		try {
			money = Double.parseDouble(moneyStr);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return df.format(money);
	}

	public static String FormatMoney(String moneyStr, String format,
			boolean convertCent) {
		DecimalFormat df = new DecimalFormat(format);
		double money = 0;
		try {
			money = Double.parseDouble(moneyStr);
			if (convertCent) {
				money = money / 100;
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return df.format(money);
	}

	/**
	 * 说明: 把钱的数字格式转化成中文表达
	 * 
	 * @param number
	 *            数字钱数
	 * @return String 中文钱数
	 */
	private String hashWord(int number) {
		switch (number) {
		case 0:
			return "零";
		case 1:
			return "壹";
		case 2:
			return "贰";
		case 3:
			return "叁";
		case 4:
			return "肆";
		case 5:
			return "伍";
		case 6:
			return "陆";
		case 7:
			return "柒";
		case 8:
			return "捌";
		case 9:
			return "玖";
		default:
			return null;
		}
	}

	/**
	 * 说明: 把位数转化成中文
	 * 
	 * @param number
	 *            数字钱数
	 * @return String 中文位数
	 */
	private String hashCellWord(int number) {
		switch (number) {
		case 0:
			return "";
		case 1:
			return "十";
		case 2:
			return "百";
		case 3:
			return "千";
		case 4:
			return "万";
		case 5:
			return "十";
		case 6:
			return "百";
		case 7:
			return "千";
		case 8:
			return "亿";
		case 9:
			return "十";
		case 10:
			return "百";
		case 11:
			return "千";
		case 12:
			return "万";
		default:
			return "十万";
		}
	}
}
