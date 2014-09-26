package com.gdbocom.test;

import com.viatt.util.*;

public class midServerTest {
	
	private String sendContext = null;

	public void uncaTest(String txnCode) throws Exception{
		if("460601".equals(txnCode)){
			this.sendContext = "biz_id,33|biz_step_id,1|TXNSRC,WE441|TelNum,1231231234|";
		}else if("460602".equals(txnCode)){
			this.sendContext = "biz_id,33|biz_step_id,2|TXNSRC,WE441|TelNum,1231231234|" +
					"CrdNo,6222600710007815865565|TxnAmt,50|";
		}else{
			throw new Exception("wrong txncode");
		}
		MidServer midServer = new MidServer();
		BwResult bwResult = midServer.sendMessage(this.sendContext);
		System.out.println(bwResult.getContext());
	}

	public void yidongTest(String txnCode) throws Exception{
		if("460601".equals(txnCode)){
			this.sendContext = "biz_id,28|biz_step_id,1|TXNSRC,WE441|CDNO,123|PSWD,null|CTSQ,"+null+"|";
		}else{
			throw new Exception("wrong txncode");
		}
		MidServer midServer = new MidServer();
		BwResult bwResult = midServer.sendMessage(this.sendContext);
		System.out.println(bwResult.getContext());
	}
	
	/**
	 * @param args
	 */
	public static void main(String[] args) throws Exception{
//		new midServerTest().uncaTest("460601");
//		new midServerTest().uncaTest("460602");
		new midServerTest().yidongTest("460601");

	}

}
