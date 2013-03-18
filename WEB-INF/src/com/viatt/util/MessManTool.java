package com.viatt.util;

import java.io.UnsupportedEncodingException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

public class MessManTool {
	public static String getValueByName(String message, String param) {
		String result = "";
		if (message == null || message.equals("")) {
			return null;
		}
		if (param == null || param.equals("")) {
			return null;
		}
		int n = message.indexOf("|" + param.trim() + ",");
		if (n != -1) {
			message = message.substring(n + 1);
			int tmp = message.indexOf("|");
			if (tmp == -1) {
				result = message.substring(message.indexOf(",") + 1).trim();
			} else {
				result = message.substring(message.indexOf(",") + 1,
						message.indexOf("|")).trim();
			}
		} else {
			return null;
		}
		return result;
	}

	public static String changeChar(String param) {
		if (param == null) {
			return "";
		} else {
			try {
				return new String(param.getBytes("ISO-8859-1"), "GBK").trim();
			} catch (UnsupportedEncodingException e) {
				// TODO Auto-generated catch block
				e.printStackTrace();
				return "";
			}
		}
	}

	public static int getMessLength(String message) {
		int result = 0;
		if (message == null || message.equals("")) {
			return -1;
		}
		for (int i = 0; i < message.length(); i++) {
			if (message.charAt(i) > '~') {
				result += 2;
			} else {
				result += 1;
			}
		}
		return result;
	}

	public List yinLvTongGetResult1(String message) {
		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return result;
		}
		/*
		 * message = message .substring(0, message.indexOf("|MGID,") != -1 ?
		 * message .indexOf("|MGID,") : 0); int n =
		 * message.indexOf("display_zone,|"); if (n == -1) { return result; }
		 */

		message = MessManTool.getValueByName(message, "jingquxingxi");
		/*
		 * message = message.substring(n + 14); message =
		 * message.substring(message.indexOf(",") + 1);
		 */

		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int f = 0;
		for (int i = 0; message != null && i < message.length(); i++) {
			if (message.charAt(i) > '~') {
				m += 2;
			} else {
				m += 1;
			}
			bf.append(message.charAt(i));
			if (m == 3 + (75 * f)) {
				map.put("param1", bf.toString());
				bf = new StringBuffer();
			}
			if (m == 15 + (75 * f)) {
				map.put("param2", bf.toString());
				bf = new StringBuffer();
			}
			if (m == 75 + (75 * f)) {
				map.put("param3", bf.toString());
				bf = new StringBuffer();
				f += 1;
				result.add(map);
				map = new HashMap();
			}
		}
		return result;
	}

	public List yinLvTongGetResult2(String message) {

		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return new ArrayList();
		}
		message = message
				.substring(0, message.indexOf("|MGID,") != -1 ? message
						.indexOf("|MGID,") : 0);
		int n = message.indexOf("display_zone,|");
		if (n == -1) {
			return new ArrayList();
		}
		message = message.substring(n + 14);
		message = message.substring(message.indexOf(",") + 1);
		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int f = 0;
		try {
			for (int i = 0; message != null && i < message.length(); i++) {
				if (message.charAt(i) > '~') {
					m += 2;
				} else {
					m += 1;
				}
				bf.append(message.charAt(i));
				if (m == 3 + (272 * f)) {
					map.put("param1", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 15 + (272 * f)) {
					map.put("param2", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 65 + (272 * f)) {
					map.put("param3", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 79 + (272 * f)) {
					map.put("param4", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 93 + (272 * f)) {
					map.put("param5", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 101 + (272 * f)) {
					map.put("param6", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 109 + (272 * f)) {
					map.put("param7", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 112 + (272 * f)) {
					map.put("param8", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 272 + (272 * f)) {
					map.put("param9", bf.toString());
					bf = new StringBuffer();
					f += 1;
					result.add(map);
					map = new HashMap();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
		return result;
	}

	public List yinLvTongGetResult3(String message) {

		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return new ArrayList();
		}
		message = message
				.substring(0, message.indexOf("|MGID,") != -1 ? message
						.indexOf("|MGID,") : 0);
		int n = message.indexOf("display_zone,");
		if (n == -1) {
			return new ArrayList();
		}
		message = message.substring(n + 13);
		message = message.substring(message.indexOf(",") + 1);
		// System.out.println("==df=d="+message);
		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int f = 0;
		try {
			for (int i = 0; message != null && i < message.length(); i++) {
				if (message.charAt(i) > '~') {
					m += 2;
				} else {
					m += 1;
				}
				bf.append(message.charAt(i));
				if (m == 3 + (474 * f)) {
					map.put("param1", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 9 + (474 * f)) {
					map.put("param2", bf.toString());// 交易码
					bf = new StringBuffer();
				}
				if (m == 69 + (474 * f)) {
					map.put("param3", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 119 + (474 * f)) {
					map.put("param4", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 131 + (474 * f)) {
					map.put("param5", bf.toString());// 订单编号
					bf = new StringBuffer();
				}
				if (m == 142 + (474 * f)) {
					map.put("param6", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 192 + (474 * f)) {
					map.put("param7", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 252 + (474 * f)) {
					map.put("param8", bf.toString());// 预定内容
					bf = new StringBuffer();
				}
				if (m == 266 + (474 * f)) {
					map.put("param9", bf.toString());// 总金额
					bf = new StringBuffer();
				}
				if (m == 280 + (474 * f)) {
					map.put("param10", bf.toString());// 电子优惠价
					bf = new StringBuffer();
				}
				if (m == 284 + (474 * f)) {
					map.put("param11", bf.toString());// 预订产品数量
					bf = new StringBuffer();
				}
				if (m == 287 + (474 * f)) {
					map.put("param12", bf.toString());// 有效天数
					bf = new StringBuffer();
				}
				if (m == 447 + (474 * f)) {
					map.put("param13", bf.toString());// 备注
					bf = new StringBuffer();
				}
				if (m == 458 + (474 * f)) {
					map.put("param14", bf.toString());// 会计流水
					bf = new StringBuffer();
				}
				if (m == 466 + (474 * f)) {
					map.put("param16", bf.toString());// 交易日期
					bf = new StringBuffer();
				}
				if (m == 474 + (474 * f)) {
					map.put("param15", bf.toString());// 使用日期
					bf = new StringBuffer();
					f += 1;
					result.add(map);
					map = new HashMap();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
		return result;
	}

	public List kongZhongChongZhiGetResult3(String message) {

		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return new ArrayList();
		}
		message = message
				.substring(0, message.indexOf("|MGID,") != -1 ? message
						.indexOf("|MGID,") : 0);
		int n = message.indexOf("display_zone,");
		if (n == -1) {
			return new ArrayList();
		}
		message = message.substring(n + 13);
		message = message.substring(message.indexOf(",") + 1);
		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int f = 0;
		try {
			for (int i = 0; message != null && i < message.length(); i++) {
				if (message.charAt(i) > '~') {
					m += 2;
				} else {
					m += 1;
				}
				bf.append(message.charAt(i));
				if (m == 3 + (51 * f)) {
					map.put("param1", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 13 + (51 * f)) {
					map.put("param2", bf.toString());// 羊城通卡号
					bf = new StringBuffer();
				}
				if (m == 21 + (51 * f)) {
					map.put("param3", bf.toString());// 充值日期
					bf = new StringBuffer();
				}
				if (m == 33 + (51 * f)) {
					map.put("param4", bf.toString());// 会计流水号
					bf = new StringBuffer();
				}
				if (m == 45 + (51 * f)) {
					map.put("param5", bf.toString());// 交易金额
					bf = new StringBuffer();
				}
				if (m == 51 + (51 * f)) {
					map.put("param6", bf.toString());// 充值终端号
					bf = new StringBuffer();
					f += 1;
					result.add(map);
					map = new HashMap();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
		return result;
	}

	public List kongZhongChongZhi1(String message) {
		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return new ArrayList();
		}
		message = message
				.substring(0, message.indexOf("|MGID,") != -1 ? message
						.indexOf("|MGID,") : 0);
		int n = message.indexOf("qianyuexinxi,");
		if (n == -1) {
			return new ArrayList();
		}
		message = message.substring(n + 13 + 21);
		message = message.substring(message.indexOf(",") + 1);
		// System.out.println("==df=d="+message);
		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int h = 0;
		int f = 0;
		try {
			for (int i = 0; message != null && i < message.length(); i++) {
				if (message.charAt(i) > '~') {
					m += 2;
				} else {
					m += 1;
				}
				bf.append(message.charAt(i));
				h += 3;
				if (m == h + (573 * f)) {
					map.put("param1", bf.toString());
					bf = new StringBuffer();
				}
				h += 1;
				if (m == h + (573 * f)) {
					map.put("param2", bf.toString());
					bf = new StringBuffer();
				}
				h += 9;
				if (m == h + (573 * f)) {
					map.put("param3", bf.toString());
					bf = new StringBuffer();
				}
				h += 1;
				if (m == h + (573 * f)) {
					map.put("param4", bf.toString());
					bf = new StringBuffer();
				}
				h += 1;
				if (m == h + (573 * f)) {
					map.put("param5", bf.toString());
					bf = new StringBuffer();
				}
				h += 1;
				if (m == h + (573 * f)) {
					map.put("param6", bf.toString());
					bf = new StringBuffer();
				}
				h += 10;
				if (m == h + (573 * f)) {
					map.put("param7", bf.toString());
					bf = new StringBuffer();
				}
				h += 30;
				if (m == h + (573 * f)) {
					map.put("param8", bf.toString());
					bf = new StringBuffer();
				}
				h += 3;
				if (m == h + (573 * f)) {
					map.put("param9", bf.toString());
					bf = new StringBuffer();
				}
				h += 14;
				if (m == h + (573 * f)) {
					map.put("param10", bf.toString());
					bf = new StringBuffer();
				}
				h += 12;
				if (m == h + (573 * f)) {
					map.put("param11", bf.toString());
					bf = new StringBuffer();
				}
				h += 2;
				if (m == h + (573 * f)) {
					map.put("param12", bf.toString());
					bf = new StringBuffer();
				}
				h += 21;
				if (m == h + (573 * f)) {
					map.put("param13", bf.toString());
					bf = new StringBuffer();
				}
				h += 20;
				if (m == h + (573 * f)) {
					map.put("param14", bf.toString());
					bf = new StringBuffer();
				}
				h += 30;
				if (m == h + (573 * f)) {
					map.put("param15", bf.toString());
					bf = new StringBuffer();
				}
				h += 1;
				if (m == h + (573 * f)) {
					map.put("param16", bf.toString());
					bf = new StringBuffer();
				}
				h += 15;
				if (m == h + (573 * f)) {
					map.put("param17", bf.toString());
					bf = new StringBuffer();
				}
				h += 15;
				if (m == h + (573 * f)) {
					map.put("param18", bf.toString());
					bf = new StringBuffer();
				}
				h += 6;
				if (m == h + (573 * f)) {
					map.put("param19", bf.toString());
					bf = new StringBuffer();
				}
				h += 50;
				if (m == h + (573 * f)) {
					map.put("param20", bf.toString());
					bf = new StringBuffer();
				}
				h += 50;
				if (m == h + (573 * f)) {
					map.put("param21", bf.toString());
					bf = new StringBuffer();
				}
				h += 10;
				if (m == h + (573 * f)) {
					map.put("param22", bf.toString());
					bf = new StringBuffer();
				}
				h += 10;
				if (m == h + (573 * f)) {
					map.put("param23", bf.toString());
					bf = new StringBuffer();
				}
				h += 10;
				if (m == h + (573 * f)) {
					map.put("param24", bf.toString());
					bf = new StringBuffer();
				}
				h += 10;
				if (m == h + (573 * f)) {
					map.put("param25", bf.toString());
					bf = new StringBuffer();
				}
				h += 12;
				if (m == h + (573 * f)) {
					map.put("param26", bf.toString());
					bf = new StringBuffer();
				}
				h += 4;
				if (m == h + (573 * f)) {
					map.put("param27", bf.toString());
					bf = new StringBuffer();
				}
				h += 4;
				if (m == h + (573 * f)) {
					map.put("param28", bf.toString());
					bf = new StringBuffer();
				}
				h += 4;
				if (m == h + (573 * f)) {
					map.put("param29", bf.toString());
					bf = new StringBuffer();
				}
				h += 4;
				if (m == h + (573 * f)) {
					map.put("param30", bf.toString());
					bf = new StringBuffer();
				}
				h += 30;
				if (m == h + (573 * f)) {
					map.put("param31", bf.toString());
					bf = new StringBuffer();
				}
				h += 30;
				if (m == h + (573 * f)) {
					map.put("param32", bf.toString());
					bf = new StringBuffer();
				}
				h += 30;
				if (m == h + (573 * f)) {
					map.put("param33", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 573 + (573 * f)) {
					map.put("param34", bf.toString());
					bf = new StringBuffer();
					f += 1;
					result.add(map);
					map = new HashMap();
				}
				h = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
		return result;
	}

	public List lianTongShouKa1(String message) {
		List result = new ArrayList();
		int m = 0;
		if (message == null) {
			return new ArrayList();
		}
		message = message
				.substring(0, message.indexOf("|MGID,") != -1 ? message
						.indexOf("|MGID,") : 0);
		int n = message.indexOf("display_zone,");
		if (n == -1) {
			return new ArrayList();
		}
		message = message.substring(n + 13);
		message = message.substring(message.indexOf(",") + 1);

		StringBuffer bf = new StringBuffer();
		HashMap map = new HashMap();
		int h = 0;
		int f = 0;
		try {
			for (int i = 0; message != null && i < message.length(); i++) {
				if (message.charAt(i) > '~') {
					m += 2;
				} else {
					m += 1;
				}
				bf.append(message.charAt(i));
				h += 3;
				if (m == h + (34 * f)) {
					map.put("param1", bf.toString());
					bf = new StringBuffer();
				}
				h += 16;
				if (m == h + (34 * f)) {
					map.put("param2", bf.toString());
					bf = new StringBuffer();
				}
				if (m == 34 + (34 * f)) {
					map.put("param3", bf.toString());
					bf = new StringBuffer();
					f += 1;
					result.add(map);
					map = new HashMap();
				}
				h = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
			return new ArrayList();
		}
		return result;
	}

	public static void main(String[] arg) {

		MessManTool messManTool = new MessManTool();
		String tmp = "0958|bocom_mid|biz_id,25|biz_no,00025|biz_step_id,6|display_zone,048012234999920090423ABIA0410313 000000010000Z01051048012234999920090423ABIA0410312 000000010000Z01051|MGID,000000|";
		// String
		// tmp="0142|bocom_mid|biz_id,24|biz_no,00024|biz_step_id,1|display_zone,031小灵通30
		// 000000000003000031小灵通50 000000000005000|MGID,000000|";
		// List list=messManTool.lianTongShouKa1(tmp);
		List list = messManTool.kongZhongChongZhiGetResult3(tmp);

		for (int i = 0; i < list.size(); i++) {
			HashMap map = (HashMap) list.get(i);
			// System.out.println(map.get("param1")+"==="+map.get("param2")+"==="+map.get("param3"));
			System.out.println(map.get("param1") + "===" + map.get("param2")
					+ "===" + map.get("param3") + "=" + map.get("param4") + "="
					+ map.get("param5") + "=" + map.get("param6"));
		}

	}
}
