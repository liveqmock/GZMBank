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
	public static final int DOUBLE_FIX_PACKAGE_76 = 76;
	
	/**
	 * 快乐十分菜单
	 */
	public static final int HP_TEN_SUMMARY = 51;
	public static final int HP_TEN_BUY = 52;
	public static final int HP_TEN_QRY = 53;
	public static final int HP_TEN_WINQRY = 54;
	
	/**
	 * 快乐十分投注方式
	 */
	public class HpTenBuy{
		/**
		 * 选一数投
		 */
		public static final int ONE = 521;
		/**
		 * 选一红投
		 */
		public static final int ONE_RED = 522;
		/**
		 * 任选二
		 */
		public static final int TWO = 523;
		/**
		 * 选二连直
		 */
		public static final int TWO_LINE= 524;
		/**
		 * 选一连组
		 */
		public static final int TWO_GROUP= 525;
		/**
		 * 任选三
		 */
		public static final int THREE = 526;
		/**
		 * 选三前直
		 */
		public static final int THREE_LINE= 527;
		/**
		 * 选三前组
		 */
		public static final int THREE_GROUP= 528;
		/**
		 * 任选四
		 */
		public static final int FOUR = 529;
		/**
		 * 任选五
		 */
		public static final int FIVE = 5210;
	}

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
		case DOUBLE_WINQRY:
		case DOUBLE_FIX_WINQRY:
			return "485414";
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
