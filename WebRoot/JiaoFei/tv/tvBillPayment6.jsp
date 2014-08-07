<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	String plantPwd = request.getHeader("password"); //移植密码
	String message = MessManTool.changeChar(request.getParameter("MESS"));  //那一大堆需要组包上传的东西
	
	
	
	gzLog.Write("这是有线电视缴费=====最后阶段=====STEP4：\n"+message);
	
	String RsFld1  = MessManTool.getValueByName(message, "RsFld1"); //第三方交易码
	String RsFld2 = MessManTool.getValueByName(message, "RsFld2");//第三方业务类型
	String TCusID = MessManTool.getValueByName(message, "TCusID");//缴费号码
	String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");//交易金额
	String ActTyp = MessManTool.getValueByName(message, "ActTyp");//帐号类型
	String ActNo = MessManTool.getValueByName(message, "ActNo");//代扣帐号
	String PinBlk = MessManTool.getValueByName(message, "PinBlk");//交易密码
	String TxCck2 = MessManTool.getValueByName(message, "TxCck2");//第二磁道
	String TxCck3 = MessManTool.getValueByName(message, "TxCck3");//第三磁道
  String Jflag = MessManTool.getValueByName(message, "Jflag");//缴费金额类型
	String TCusNm = MessManTool.getValueByName(message, "TCusNm");//客户名称
  
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
		//在这里开始拼装即将发往服务器的一串报文。 注意有其固定格式
		
		String sendContext = "biz_id,31|biz_step_id,2|RsFld1,P002|RsFld2,|TCusID,"+TCusID+"|TxnAmt,"+TxnAmt
		+"|ActTyp,"+ActTyp+"|ActNo,"+ActNo+"|PinBlk,"+PinBlk+"|TxCck2,"+TxCck2+"|TxCck3,"+TxCck3+"|Jflag,"+Jflag+"|TCusNm,"+TCusNm+"|PSWD,"+plantPwd+"|";
		
		String sendContextNoPSWD = "biz_id,31|biz_step_id,2|RsFld1,P002|RsFld2,|TCusID,"+TCusID+"|TxnAmt,"+TxnAmt
		+"|ActTyp,"+ActTyp+"|ActNo,"+ActNo+"|PinBlk,"+PinBlk+"|TxCck2,"+TxCck2+"|TxCck3,"+TxCck3+"|Jflag,"+Jflag+"|TCusNm,"+TCusNm+"|PSWD,******|";
		
		//这是在做测试的时候 要将密码做一下修改。 不做加密等操作，实际使用要用上卖弄的一段代码
		//String sendContext = "biz_id,31|biz_step_id,2|RsFld1,P002|RsFld2,|TCusID,"+TCusID+"|TxnAmt,"+TxnAmt
		+"|ActTyp,"+ActTyp+"|ActNo,"+ActNo+"|PinBlk,"+PinBlk+"|TxCck2,"+TxCck2+"|TxCck3,"+TxCck3+"|Jflag,"+Jflag+"|TCusNm,"+TCusNm+"|PSWD,"+"1234567890"+"|";
		
		gzLog.Write("这是有线电视缴费=====最后阶段=====STEP4"+"\n上传的报文组装完毕，内容如下："+sendContextNoPSWD);  //log
		
		//这里开始才会转到网关上啊
		MidServer midServer = new MidServer();
		BwResult bwResult = new BwResult();
		
	//BEGIN 身份认证
	//
		String verify = request.getHeader("MBK_VERIFY_RESULT");
	  	String info = "";
		if(verify!=null&&verify.equals("P")){
		   //通过身份认证，向后台发送交易
		   bwResult = midServer.sendMessage(sendContext);
		   info = bwResult.getContext();
		   gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+info);
		}else if(verify.equals("F")){
			info = "|MGID,000333|RspMsg,身份验证不通过|";
		}else if(verify.equals("N")){
		    info = "|MGID,000444|RspMsg,身份未验证|";
		}else {
		    info = "|MGID,000555|RspMsg,身份验证系统出错|";
		}
	
    //END 身份认证
		
		gzLog.Write("这是有线电视缴费=====最后阶段=====STEP4"+"\n服务器下行返回的报文内容："+info);
		
		String MGID = MessManTool.getValueByName(info, "RspCod");	
		gzLog.Write("这里是有线电视缴费Step4报文返回的第一站，检查RspCod:  "+MGID);
		
		//如果返回正确
		if("000000".equals(MGID)){

			String tCusID = MessManTool.getValueByName(info, "TCusID"); //代理代码
			String tCusNm = MessManTool.getValueByName(info, "TCusNm");	//客户名称
			String rcvAmt = MessManTool.getValueByName(info, "RcvAmt");	//交易金额
			String tckNo = MessManTool.getValueByName(info, "TckNo");	  //会计流水
			String rsFld2 = MessManTool.getValueByName(info, "RsFld2");	//
		
	 %>	 
			<label>
				交易成功！感谢您的使用。
			</label>
		    <br/>
		    <br/>
		    
		    <table border='1'>
		    	<tr>
		        	<td>代理代码</td>
		        	<td><%=tCusID%></td>
		        </tr>
		        <tr>
		        	<td>客户名称</td>
		        	<td><%=tCusNm%></td>
		        </tr>
		        <tr>
		        	<td>交易金额</td>
		        	<td><%=rcvAmt%></td>
		        </tr>
		        <tr>
		        	<td>会计流水</td>
		        	<td><%=tckNo%></td>
		        </tr>
		    </table>
		    <br/>    
		
	<%
		} else {
	      String RspCod = MessManTool.getValueByName(info, "RspCod");
 	      String RspMsg = MessManTool.getValueByName(info, "RspMsg"); 
 	      
 	      gzLog.Write("****错误码:"+RspCod+"错误信息"+RspMsg);
 	      
 	      out.println("<label>错误码为:"+RspCod+"</label><br/>");
		  if("PD5012".equals(RspCod)){
			 	out.println("<label>错误原因为:密码错误</label><br/>");
		}
 	}
    %> 
		
    <%
	gzLog.Write("有线电视缴费完毕！！！！！");
    %>	
	</content>
</res>