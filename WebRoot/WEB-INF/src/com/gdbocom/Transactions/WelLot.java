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
	 * 双色球投注菜单
	 */
	public static final int DOUBLE_SEL = 31;
	public static final int DOUBLE_BETSQRY = 32;
	public static final int DOUBLE_WINQRY = 33;

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
			return "485404";
		case DOUBLE_WINQRY:
			return "485404";
		default:
			return "";
		}
	}
}
