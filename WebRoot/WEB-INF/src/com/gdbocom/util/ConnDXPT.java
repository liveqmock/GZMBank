package com.gdbocom.util;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;
import java.net.Socket;
import java.util.HashMap;
import java.util.List;
import java.util.Properties;
import java.io.UnsupportedEncodingException;



/**
 * @time 2009
 * @author 
 *
 */
public class ConnDXPT {
	private String ip="";
	private int port=9897;
	
	public ConnDXPT(){
		InputStream is = getClass().getResourceAsStream("/GZMBank.properties");
		Properties sysProps = new Properties();
		try {
			sysProps.load(is);
			this.ip=sysProps.getProperty("dxpt_ip");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public String getIp() {
		return ip;
	}

	public void setIp(String ip) {
		this.ip = ip;
	}


	public int getPort() {
		return port;
	}

	public void setPort(int port) {
		this.port = port;
	}
	
	/**
	* 发送信息到短信平台
	* @param message 短信信息
	* @param phone   手机号码
	* @param cardno  银行卡号
	* @return
	*/
	
	public String sendMessage(String message,String phone,String cardno){
		char ff ='\u0000';
		String content      = "";      //发送报文
		String sRecvContent = "";      //接收报文
		String unino    = "";
		String sCardno  = ConnDXPT.addBit(cardno, 20);
		String sPhone   = ConnDXPT.addBit(phone, 15);
		String sMessage = ConnDXPT.addBit(message,500);
		
		if(sPhone.substring(0, 3).equals("139")|| sPhone.substring(0, 3).equals("138") ||sPhone.substring(0, 3).equals("137") ||sPhone.substring(0, 3).equals("136") ||sPhone.substring(0, 3).equals("135") ||sPhone.substring(0, 3).equals("134") || sPhone.substring(0, 3).equals("150") || sPhone.substring(0, 3).equals("151") || sPhone.substring(0, 3).equals("157") || sPhone.substring(0, 3).equals("158") || sPhone.substring(0, 3).equals("159") || sPhone.substring(0, 3).equals("187") || sPhone.substring(0, 3).equals("188"))
			unino = "0001";/*移动*/
		else if(sPhone.substring(0, 3).equals("130") || sPhone.substring(0, 3).equals("131") || sPhone.substring(0, 3).equals("132") || sPhone.substring(0, 3).equals("152") || sPhone.substring(0, 3).equals("155") || sPhone.substring(0, 3).equals("156") || sPhone.substring(0, 3).equals("185") || sPhone.substring(0, 3).equals("186"))
			unino = "0002";/*联通*/
		else 
			unino = "0003";/*电信*/		
				
		content = sCardno; /*帐号  无用*/
		content = content + ff;            /*分隔符*/
		content = content + "00000000000000000000"; /*客户号  无用*/
		content = content + ff;            /*分隔符*/
		content = content + sPhone;       /*手机号*/
		content = content + ff;            /*分隔符*/
		content = content + "0";          /*即发标志*/
		content = content + ff;            /*分隔符*/
		content = content + "2";          /*收费标准*/
		content = content + ff;            /*分隔符*/
		content = content + unino;         /*运营商标志*/
		content = content + ff;            /*分隔符*/
		content = content + sMessage;     /*短信信息*/
		content = content + ff;            /*分隔符*/
		content = content + "0000000";    /*0000000*/
		content = content + ff;            /*分隔符*/
		content = content + "             ";
		content = content + ff;            /*分隔符*/
		content = content + "1";
		content = content + ff;            /*分隔符*/	
		try {
			BufferedReader in = null; /* receive */
			// *BufferedWriter out=null;
			PrintWriter out = null; /* send */
			Socket soc = new Socket(ip, port);
			in = new BufferedReader(new InputStreamReader(soc.getInputStream()));
			out = new PrintWriter(new BufferedWriter(new OutputStreamWriter(soc
					.getOutputStream())), true);
			System.out.println("==="+content);
     		out.println(content);
			sRecvContent=in.readLine();
		
		} catch (Exception e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		return sRecvContent;
	}

	/**
	* 字符串长度不够补位为空格
	* @param str
	* @param bitNum 要达到的长度
	* @return
	*/

	public static String addBit(String str,int bitNum){
    /*
	  if(str.length()>bitNum){
	      return str;
	     }
	     int lessNum=bitNum-str.length();
	     System.out.println(str.length());
	     System.out.println(lessNum);
	     for(int i=0;i<lessNum;i++){
	      str=str+" ";
	     }
	     return str;
	 */
		  int len = 0; 
		  byte[] b = str.getBytes();
		  len = b.length;
		  if(len > bitNum){
		      return str;
		     }
		     int lessNum=bitNum-len;
		     for(int i=0;i<lessNum;i++){
		      str=str+" ";
		     }
		     return str;	
	}
	
	public static void main(String arg[]){
        /*可以转换字符编码
		String b ="";
        try {
		   byte[] bytes={00};
		   String c = new String(bytes, "UTF-8" );
		   b = c;
		} catch (UnsupportedEncodingException e) {
			// TODO Auto-generated catch block
			e.printStackTrace();
		}
		*/
	

		
		ConnDXPT ConnDXPT=new ConnDXPT();
		
		String sReturnCod = ConnDXPT.sendMessage("未解决89899","13800000000","60142890000");

		System.out.println("==="+sReturnCod);


	}
}
