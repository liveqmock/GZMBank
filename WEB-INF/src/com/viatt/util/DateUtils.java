package com.viatt.util;

import java.text.DateFormat;
import java.text.ParseException;
import java.text.ParsePosition;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.GregorianCalendar;

public class DateUtils {

	// static long now = System.currentTimeMillis();
	// public static Date CurrTime = new Date(now);

	public DateUtils() {
	}

	// ȡϵͳʱ��ʱһ��Ҫ������������������ڿ��ܲ���
	public static Date getCurrDateTime() {
		return new Date(System.currentTimeMillis());
	}

	/**
	 * ȡ�õ�ǰϵͳʱ��
	 *  
	 * @return yyyy-MM-dd HH:mm:ss
	 */
	public static String getCurrTime() {
		Date date_time = new Date();
		return FormatDate(date_time, "yyyy-MM-dd HH:mm:ss");
	}

	public static String getCurrDate() {
		Date date_time = new Date();
		return FormatDate(date_time, "yyyy-MM-dd");
	}

	/**
	 * ȡ�����ڵ����
	 * 
	 * @param date
	 *            ����
	 * @return yyyy ����ַ���
	 */
	public static String getYear(Date date) {
		return FormatDate(date, "yyyy");
	}

	/**
	 * ȡ�����ڵ��·�
	 * 
	 * @param date
	 *            ����
	 * @return mm �·��ַ���
	 */
	public static String getMonth(Date date) {
		return FormatDate(date, "MM");
	}

	/**
	 * ȡ�����ڵ����
	 * 
	 * @param date
	 *            ����
	 * @return dd ���ַ���
	 */
	public static String getDay(Date date) {
		return FormatDate(date, "dd");
	}

	/**
	 * ȡ�����ڵ�Сʱ
	 * 
	 * @param date
	 *            ����
	 * @return hh Сʱ�ַ���
	 */
	public static String getHour(Date date) {
		return FormatDate(date, "HH");
	}

	/**
	 * ȡ�����ڵķ���
	 * 
	 * @param date
	 *            ʱ��
	 * @return mm �����ַ���
	 */
	public static String getMinute(Date date) {
		return FormatDate(date, "mm");
	}

	/**
	 * ȡ��ʱ�����
	 * 
	 * @param date
	 *            ʱ��
	 * @return ss ���ַ���
	 */
	public static String getSecond(Date date) {
		return FormatDate(date, "ss");
	}

	/**
	 * ȡ��������������ʼʱ��
	 * 
	 * @param granularity
	 *            ����
	 * @param statisticDate
	 *            ����ʱ��
	 * @return ��ʼʱ��
	 */
	public String getBeginDate(String granularity, String statisticDate) {
		String beginDate = "";
		Date date = this.stringToDateShort(statisticDate);
		Date beginDateTemp = null;
		if (granularity.equals("2")) {// ��
			beginDateTemp = this.getMonthBegin(date);
		} else if (granularity.equals("3")) {// ��
			beginDateTemp = this.getSeasonBegin(date);
		} else if (granularity.equals("4")) {// ��
			beginDateTemp = this.getYearBegin(date);
		}
		beginDate = this.dateToStringShort(beginDateTemp);
		return beginDate;
	}

	/**
	 * ȡ��ʱ������ �� yyyy��mm��dd �� yyyy��mm�� �� yyyy��ڡ����� �� yyyy��
	 * 
	 * @param granularity
	 *            ����
	 * @param statisticDate
	 *            ʱ��
	 * @return ʱ���Ӧ���ȵ�����
	 */
	public String getTimedes(String granularity, String statisticDate) {
		String timedes = "";
		Date date = this.stringToDateShort(statisticDate);
		String year = "", month = "01", day = "01";
		year = DateUtils.getYear(date);
		month = DateUtils.getMonth(date);
		day = DateUtils.getDay(date);
		if (granularity.equals("1")) {// ��
			timedes = statisticDate;
		} else if (granularity.equals("4")) {// ��
			timedes = year + "��" + month + "��";

		} else if (granularity.equals("8")) {// ��
			String quarter = month + "-" + day;
			if (quarter.equals("03-31")) {
				timedes = year + "�� ��1����";
			} else if (quarter.equals("06-30")) {
				timedes = year + "�� ��2����";
			} else if (quarter.equals("09-30")) {
				timedes = year + "�� ��3����";
			} else if (quarter.equals("12-31")) {
				timedes = year + "�� ��4����";
			}
		} else if (granularity.equals("32")) {// ��
			timedes = year + "��";
		}
		return timedes;
	}

	/**
	 * ����ת��Ϊ�ַ���
	 * 
	 * @param date
	 *            ʱ��
	 * @return yyyy-MM-dd HH:mm:ss ��ʽ����ʱ���ַ���
	 */
	public static String dateToString(Date date) {
		if (date == null)
			return "";
		return FormatDate(date, "yyyy-MM-dd HH:mm:ss");
	}

	public static String dateToString(Date date, String sf) {
		if (date == null)
			return "";
		return FormatDate(date, sf);
	}

	/**
	 * ����ת��Ϊ�ַ���
	 * 
	 * @param date
	 *            ʱ��
	 * @return yyyy-MM-dd ��ʽ����ʱ���ַ���
	 */
	public static String dateToStringShort(Date date) {
		if (date == null)
			return "";
		return FormatDate(date, "yyyy-MM-dd");
	}

	/**
	 * �ַ���ת��Ϊ����
	 * 
	 * @param dateString
	 *            yyyy-MM-dd HH:mm:ss
	 * @return ����
	 */
	public static Date stringToDate(String dateString) {
		String sf = "yyyy-MM-dd HH:mm:ss";
		Date dt = stringToDate(dateString, sf);
		return dt;
	}

	public static Date shortstringToDate(String dateString) {
		String sf = "yyyy-MM-dd";
		Date dt = stringToDate(dateString, sf);
		return dt;
	}

	/**
	 * �ַ���ת��Ϊ����
	 * 
	 * @param dateString
	 *            yyyy-MM-dd
	 * @return ����
	 */
	public static Date stringToDateShort(String dateString) {
		if (dateString == null)
			return null;
		String sf = "yyyyMMdd";
		Date dt = stringToDate(dateString, sf);
		return dt;
	}

	/**
	 * �����ڽ��и�ʽ��
	 * 
	 * @param date
	 *            ����
	 * @param sf
	 *            ���ڸ�ʽ
	 * @return �ַ���
	 */
	public static String FormatDate(Date date, String sf) {
		if (date == null)
			return "";
		SimpleDateFormat dateformat = new SimpleDateFormat(sf);
		return dateformat.format(date);
	}

	/**
	 * �ַ���ת��Ϊ����
	 * 
	 * @param dateString
	 *            ���ڸ�ʽ�ַ���
	 * @param sf
	 *            ���ڸ�ʽ������
	 * @return ת���������
	 */
	public static Date stringToDate(String dateString, String sf) {
		ParsePosition pos = new ParsePosition(0);
		SimpleDateFormat sdf = new SimpleDateFormat(sf);
		Date dt = sdf.parse(dateString, pos);
		return dt;
	}

	/**
	 * �����������ڲ���룩
	 * 
	 * @param date1
	 *            ʱ��1
	 * @param date2
	 *            ʱ��2
	 * @return ��������
	 */
	public static long diffTwoDate(Date date1, Date date2) {
		long l1 = date1.getTime();
		long l2 = date2.getTime();
		return (l1 - l2);
	}

	/**
	 * �����������ڲ�죩
	 * 
	 * @param date1
	 *            ʱ��1
	 * @param date2
	 *            ʱ��2
	 * @return �������
	 */
	public static int diffTwoDateDay(Date date1, Date date2) {
		long l1 = date1.getTime();
		long l2 = date2.getTime();
		int diff = Integer.parseInt("" + (l1 - l2) / 3600 / 24 / 1000);
		return diff;
	}

	/**
	 * 
	 * @param currentTime
	 *            ���������
	 * @param type
	 *            ƫ�Ƶ����
	 * @param iQuantity
	 *            ƫ������
	 * @return ƫ�ƺ��ʱ�䴮
	 */
	public String getDateChangeTime(String currentTime, String type,
			int iQuantity) {
		Date curr = this.stringToDate(currentTime);
		curr = this.getDateChangeTime(curr, type, iQuantity);
		return this.dateToString(curr);
	}

	/**
	 * 
	 * @param currentTime
	 *            ���������
	 * @param type
	 *            ƫ�Ƶ����
	 * @param iQuantity
	 *            ƫ������
	 * @return ƫ�ƺ��ʱ��
	 */
	public Date getDateChangeTime(Date currentTime, String type, int iQuantity) {
		// System.out.println("currentTime:"+currentTime+"
		// type:"+type+iQuantity);
		int year = Integer.parseInt(this.FormatDate(currentTime, "yyyy"));
		int month = Integer.parseInt(this.FormatDate(currentTime, "MM"));
		// �·�����
		month = month - 1;
		int day = Integer.parseInt(this.FormatDate(currentTime, "dd"));
		int hour = Integer.parseInt(this.FormatDate(currentTime, "HH"));
		int mi = Integer.parseInt(this.FormatDate(currentTime, "mm"));
		int ss = Integer.parseInt(this.FormatDate(currentTime, "ss"));
		GregorianCalendar gc = new GregorianCalendar(year, month, day, hour,
				mi, ss);
		// �·�����
		// gc.add(GregorianCalendar.MONTH, -1);
		if (type.equalsIgnoreCase("y")) {
			gc.add(GregorianCalendar.YEAR, iQuantity);
		} else if (type.equalsIgnoreCase("m")) {
			gc.add(GregorianCalendar.MONTH, iQuantity);
		} else if (type.equalsIgnoreCase("d")) {
			gc.add(GregorianCalendar.DATE, iQuantity);
		} else if (type.equalsIgnoreCase("h")) {
			gc.add(GregorianCalendar.HOUR, iQuantity);
		} else if (type.equalsIgnoreCase("mi")) {
			gc.add(GregorianCalendar.MINUTE, iQuantity);
		} else if (type.equalsIgnoreCase("s")) {
			gc.add(GregorianCalendar.SECOND, iQuantity);
		}
		// System.out.println("gc.getTime()"+gc.getTime());
		return gc.getTime();
	}

	/**
	 * 
	 * @param currentTime
	 *            ��������
	 * @param type
	 *            ƫ�Ƶ����
	 * @param iQuantity
	 *            ƫ������
	 * @return ƫ�ƺ��ʱ�䴮
	 */
	public String getDateChangeALL(String currentTime, String type,
			int iQuantity) {
		Date curr = null;
		String newtype = "";
		if (currentTime.length() == 10) {
			curr = this.stringToDateShort(currentTime);
		}
		if (currentTime.length() > 10) {
			curr = this.stringToDate(currentTime);
		}
		if (type.equals("q")) {
			iQuantity = iQuantity * 3;
			newtype = "m";
		} else {
			newtype = type;
		}
		Date change = this.getDateChangeTime(curr, newtype, iQuantity);
		if (!type.equals("d")) {
			change = this.getMonthEnd(change);
		}
		return this.dateToStringShort(change);
	}

	/**
	 * ������
	 * 
	 * @param args
	 *            ���Բ���
	 */
	public static void main(String[] args) {
		System.out.println(getCurrDate());
	}

	/**
	 * �����ꡢ��ȡ����ĩ������
	 * 
	 * @param year
	 *            ��
	 * @parm month ��
	 * @return time �������ڸ�ʽ"yyyy-mm-dd"
	 */
	public static String getTime(String year, String month) {
		String time = "";
		int len = 31;
		int iYear = Integer.parseInt(year);
		int iMonth = Integer.parseInt(month);
		if (iMonth == 4 || iMonth == 6 || iMonth == 9 || iMonth == 11)
			len = 30;
		if (iMonth == 2) {
			len = 28;
			if ((iYear % 4 == 0 && iYear % 100 == 0 && iYear % 400 == 0)
					|| (iYear % 4 == 0 && iYear % 100 != 0)) {
				len = 29;
			}
		}
		time = year + "-" + month + "-" + String.valueOf(len);
		return time;
	}

	/**
	 * ȡ�³�
	 * 
	 * @param date
	 * @return
	 */
	public Date getMonthBegin(Date date) {
		String newDateStr = this.FormatDate(date, "yyyy-MM") + "-01";
		// FormatDate(date, "yyyy-MM-dd");
		return this.stringToDateShort(newDateStr);
	}

	/**
	 * ȡ��ĩʱ��
	 * 
	 * @param date
	 *            ����
	 * @return date
	 */
	public static Date getMonthEnd(Date date) {
		int year = Integer.parseInt(FormatDate(date, "yyyy"));
		int month = Integer.parseInt(FormatDate(date, "MM"));
		int day = Integer.parseInt(FormatDate(date, "dd"));

		GregorianCalendar calendar = new GregorianCalendar(year, month - 1,
				day, 0, 0, 0);
		int monthLength = calendar.getActualMaximum(calendar.DAY_OF_MONTH);
		String newDateStr = FormatDate(date, "yyyy") + "-"
				+ FormatDate(date, "MM") + "-";
		if (monthLength < 10)
			newDateStr += "0" + monthLength;
		else
			newDateStr += "" + monthLength;
		return stringToDateShort(newDateStr);
	}

	/**
	 * ȡ����
	 * 
	 * @param date
	 * @return
	 */
	public Date getSeasonBegin(Date date) {
		int year = Integer.parseInt(this.FormatDate(date, "yyyy"));
		int month = Integer.parseInt(this.FormatDate(date, "MM"));
		String newDateStr = this.FormatDate(date, "yyyy") + "-";
		if (month >= 1 && month <= 3) {
			newDateStr += "01-01";
		} else if (month >= 4 && month <= 6) {
			newDateStr += "04-01";
		} else if (month >= 7 && month <= 9) {
			newDateStr += "07-01";
		} else if (month >= 10 && month <= 12) {
			newDateStr += "10-01";
		}
		return this.stringToDateShort(newDateStr);
	}

	/**
	 * ȡ����ĩʱ��
	 * 
	 * @param date
	 *            ����
	 * @return date
	 */
	public static Date getSeasonEnd(Date date) {
		int year = Integer.parseInt(FormatDate(date, "yyyy"));
		int month = Integer.parseInt(FormatDate(date, "MM"));
		String newDateStr = FormatDate(date, "yyyy") + "-";
		if (month >= 1 && month <= 3) {
			newDateStr += "03-31";
		} else if (month >= 4 && month <= 6) {
			newDateStr += "06-30";
		} else if (month >= 7 && month <= 9) {
			newDateStr += "09-30";
		} else if (month >= 10 && month <= 12) {
			newDateStr += "12-31";
		}
		return stringToDateShort(newDateStr);
	}

	/**
	 * �Ƿ�Ϊ����ĩ
	 * 
	 * @param date
	 *            ʱ��
	 * @return
	 */
	public Date getHalfYearEnd(Date date) {
		int month = Integer.parseInt(this.FormatDate(date, "MM"));
		String newDateStr = this.FormatDate(date, "yyyy");
		if (month >= 1 && month <= 6) {
			newDateStr += "-6-30";
		} else if (month >= 7 && month <= 12) {
			newDateStr += "-12-31";
		}
		return this.stringToDateShort(newDateStr);
	}

	/**
	 * ȡ�����
	 * 
	 * @param date
	 * @return
	 */
	public Date getYearBegin(Date date) {
		String newDateStr = this.FormatDate(date, "yyyy") + "-01-01";
		return this.stringToDateShort(newDateStr);
	}

	/**
	 * �Ƿ�Ϊ��ĩ
	 * 
	 * @param date
	 *            ʱ��
	 * @return
	 */
	public static Date getYearEnd(Date date) {
		String newDateStr = FormatDate(date, "yyyy") + "-12-31";
		return stringToDateShort(newDateStr);
	}

	/**
	 * �Ƿ�ΪѮĩ
	 * 
	 * @param date
	 *            ʱ��
	 * @return �ǻ��
	 */
	public boolean IsXperiodEnd(Date date) {

		boolean flag = false;

		String day = this.getDay(date);
		String month = this.getMonth(date);

		if (day.equalsIgnoreCase("10")) {
			flag = true;
		} else if (day.equalsIgnoreCase("20")) {
			flag = true;
		}
		// ��ĩ����Ѯĩ
		// else if( this.getMonthEnd(date).compareTo(date)==0 ){
		// flag = true;
		// }

		return flag;
	}

	// �ж�ʱ��date1�Ƿ���ʱ��date2֮ǰ
	// ʱ���ʽ 2007-1-21 16:16:34
	public static boolean isDateBefore(String date1, String date2) {
		try {
			DateFormat df = DateFormat.getDateTimeInstance();
			return df.parse(date1).before(df.parse(date2));
		} catch (ParseException e) {
			System.out.print("[SYS] " + e.getMessage());
			return false;
		}
	}

	// �ж�ʱ��date1�Ƿ���ʱ��date2֮ǰ
	// ʱ���ʽ 2007-1-21
	public static boolean isDateBefore2(String date1, String date2) {
		try {
			return DateUtils.stringToDateShort(date1).before(
					DateUtils.stringToDateShort(date2));
		} catch (Exception e) {
			System.out.print("[SYS] " + e.getMessage());
			return false;
		}
	}

	// �ж�ʱ��date1�Ƿ����date2
	// ʱ���ʽ 2007-1-21
	public static boolean isDateEquals(String date1, String date2) {
		try {
			return DateUtils.stringToDateShort(date1).equals(
					DateUtils.stringToDateShort(date2));
		} catch (Exception e) {
			System.out.print("[SYS] " + e.getMessage());
			return false;
		}
	}

	// �жϵ�ǰʱ���Ƿ���ʱ��date2֮ǰ
	// ʱ���ʽ 2005-1-21 16:16:34
	public static boolean isDateBefore(String date2) {
		try {
			Date date1 = new Date();
			DateFormat df = DateFormat.getDateTimeInstance();
			return date1.before(df.parse(date2));
		} catch (ParseException e) {
			System.out.print("[SYS] " + e.getMessage());
			return false;
		}
	}
}
