package com.gdbocom.util.format;

import java.text.DecimalFormat;

public class TxnAmtFormat {

	public static String format(String TxnAmt){
		DecimalFormat df = new DecimalFormat("###,###,##0.00");
		double dblTxnAmt = Double.parseDouble(TxnAmt);
		return df.format(dblTxnAmt/100.0);

	}
}
