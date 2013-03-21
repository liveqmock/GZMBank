package com.gdbocom.test;

import java.text.DecimalFormat;
import java.util.Date; 
import java.text.SimpleDateFormat;

public class StringChange {

	public static void main(String[] args) throws Exception{

		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
	      System.out.println(df.format(new Date()));// new Date()为获取当前系统时间
	   String lChkTm = "201202";
	   
	   System.out.println(lChkTm.substring(0,4)+"年"+(("0".equals(lChkTm.substring(4, 5)))?lChkTm.substring(5, 6):lChkTm.substring(4, 6))+"月");
	}
	
	public void DecimalFormat() throws Exception{
		String TxnAmt = "900000";
		TxnAmt = "12345678";
		int i=0;
		String result="";
		while(true){
			TxnAmt = String.valueOf(i);
			DecimalFormat df = new DecimalFormat("###,###,##0.00");
			double dblTxnAmt = Double.parseDouble(TxnAmt);
			/*String temp = String.valueOf(dblTxnAmt/100.0);
			System.out.println(String.format("000,000,000.00", new String[]{temp}));*/
			String displayTxnAmt = df.format(dblTxnAmt/100.0);
			System.out.println(displayTxnAmt);
			Thread.sleep(100);
			//System.out.println(String.format("###,###,###.##", new String[]{TxnAmt}));
			i++;
		}
//		System.out.println(tmp.length());
	}
}
