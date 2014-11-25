package com.gdbocom.Transactions;

public class WelLot {

	/**
	 * 首页菜单
	 */
	public static final int ADDREG = 1;
	public static final int UPDREG = 2;
	public static final int DOUBLEBUY = 3;
	public static final int DOUBLEFIXBUY = 4;
	public static final int TENBUY = 5;

	/**
	 * 双色球投注子菜单
	 */
	public static final int DOUBLE_SEL = 31;
	public static final int DOUBLE_BETSQRY = 32;
	public static final int DOUBLE_WINQRY = 33;

	/**
	 * 双色球定投子菜单
	 */
	public static final int DOUBLE_FIX_SUMMARY = 41;
	public static final int DOUBLE_FIX_BUY = 42;
	public static final int DOUBLE_FIX_QRY = 43;
	public static final int DOUBLE_FIX_CANCEL = 44;
	public static final int DOUBLE_FIX_WINQRY = 45;

	/**
	 * 双色球定投套餐子菜单
	 */
	public static final int DOUBLE_FIX_PACKAGE_153 = 153;
	public static final int DOUBLE_FIX_PACKAGE_72 = 72;

	/**
	 * 转换菜单值为通讯码
	 * @param busType
	 * @return
	 */
	public static String getTxnCod(int busType){
		switch(busType){
		case ADDREG:
			return "485404";
		case UPDREG:
			return "485405";
		case DOUBLE_SEL:
			return "485412";
		case DOUBLE_BETSQRY:
			return "485413";
		case DOUBLE_FIX_BUY:
			return "485407";
		case DOUBLE_FIX_QRY:
			return "485409";
		case DOUBLE_FIX_CANCEL:
			return "485410";
		default:
			throw new IllegalArgumentException("没有定义交易码");
		}
	}
}
