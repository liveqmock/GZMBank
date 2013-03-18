package com.viatt.util;

import java.text.DecimalFormat;

public class MoneyUtils {
	// 120,000,000,000.22
	private static String moneyFormat = ",##0.00";

	public MoneyUtils() {
	}

	/**
	 * ��Ǯ��ʽ��
	 * 
	 * @param money
	 *            Ǯ��
	 * @return �ַ���
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
	 * ��Ǯ��ʽ��
	 * 
	 * @param money
	 *            Ǯ��
	 * @param format
	 *            ��ʽ������
	 * @return �ַ���
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
	 * ˵��: ��Ǯ�����ָ�ʽת�������ı��
	 * 
	 * @param number
	 *            ����Ǯ��
	 * @return String ����Ǯ��
	 */
	private String hashWord(int number) {
		switch (number) {
		case 0:
			return "��";
		case 1:
			return "Ҽ";
		case 2:
			return "��";
		case 3:
			return "��";
		case 4:
			return "��";
		case 5:
			return "��";
		case 6:
			return "½";
		case 7:
			return "��";
		case 8:
			return "��";
		case 9:
			return "��";
		default:
			return null;
		}
	}

	/**
	 * ˵��: ��λ��ת��������
	 * 
	 * @param number
	 *            ����Ǯ��
	 * @return String ����λ��
	 */
	private String hashCellWord(int number) {
		switch (number) {
		case 0:
			return "";
		case 1:
			return "ʮ";
		case 2:
			return "��";
		case 3:
			return "ǧ";
		case 4:
			return "��";
		case 5:
			return "ʮ";
		case 6:
			return "��";
		case 7:
			return "ǧ";
		case 8:
			return "��";
		case 9:
			return "ʮ";
		case 10:
			return "��";
		case 11:
			return "ǧ";
		case 12:
			return "��";
		default:
			return "ʮ��";
		}
	}
}
