<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.sql.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.sportticket.format.*" %>
<%@ page import="com.gdbocom.util.ConnPool" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤6");

	String TxnAmt = request.getParameter("TxnAmt");
	String TrmCod = request.getParameter("TrmCod");
	String TikMod = request.getParameter("TikMod");
	String LotTyp = request.getParameter("LotTyp");
	String SigDup = request.getParameter("SigDup");
	String NotNum = request.getParameter("NotNum");
	String MulTip = request.getParameter("MulTip");
	String ExtNum = request.getParameter("ExtNum");
	String LotNum = request.getParameter("LotNum");//接收前一表单的投注号码
	String[] LotNums = new String[7];              //接收返回表单的投注号码
	String LotNumDis = "";                         //回显投注号码

 	//BEGIN 密码解密
	//String sessionId = null;
	//Cookie ckies[] = request.getCookies();
	//if(ckies != null){
	//	for(int i=0;i<ckies.length;i++){
	//		if(ckies[i].getName().equals("JSESSIONID")){
	//	    	sessionId = ckies[i].getValue();
	//	    	int idx = sessionId.indexOf(":");
	//	    	if(idx != -1){
	//	    		sessionId = sessionId.substring(0,idx);
	//	   		}
	//	    	break;
	//	    }
	//	}
	//}
  //	String pwd = request.getHeader("password");
  //	java.security.Security.addProvider(new org.bouncycastle.jce.provider.BouncyCastleProvider());
	//String plantPwd = MBSecurityUtil.decryptData(cdno,sessionId,pwd);
	//plantPwd = plantPwd.substring(0,6);
	//END 密码解密
	String plantPwd = request.getHeader("password");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	String sendContext = "|biz_id,29|biz_step_id,3|TXNSRC,MB441"
						+ "|CrdNo,"  + cdno 
						+ "|PSWD," + plantPwd //交易密码
 						+ "|TxnAmt," + TxnAmt 
						+ "|TrmCod," + TrmCod 
						+ "|TikMod," + TikMod 
						+ "|LotTyp," + LotTyp 
						+ "|SigDup," + SigDup 
						+ "|NotNum," + NotNum 
						+ "|MulTip," + MulTip 
						+ "|ExtNum," + ExtNum 
						+ "|LotNum," + LotNum 
						+ "|CntTel," + sjNo
						+ "|";
	String sendContext2 = "|biz_id,29|biz_step_id,3|TXNSRC,MB441"
						+ "|CrdNo,"  + cdno 
//						+ "|PSWD," + plantPwd //交易密码
 						+ "|TxnAmt," + TxnAmt 
						+ "|TrmCod," + TrmCod 
						+ "|TikMod," + TikMod 
						+ "|LotTyp," + LotTyp 
						+ "|SigDup," + SigDup 
						+ "|NotNum," + NotNum 
						+ "|MulTip," + MulTip 
						+ "|ExtNum," + ExtNum 
						+ "|LotNum," + LotNum 
						+ "|CntTel," + sjNo
						+ "|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext2);

	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {

 	  	String TRspCd = MessManTool.getValueByName(message, "TRspCd");
 		String LogNo = MessManTool.getValueByName(message, "LogNo");
 		String TLogNo = MessManTool.getValueByName(message, "TLogNo");
  		NotNum = MessManTool.getValueByName(message, "NotNum");
		for(int i=1;i<=5;i++){
			if(MessManTool.getValueByName(message, "LotNum"+i).indexOf("*")!=-1){
				LotNums[i] = MessManTool.getValueByName(message, "LotNum"+i);
				LotNumDis = LotNumDis + "<label>" + LotNumFormat.OneSimplexRecordFormat(MessManTool.getValueByName(message, "LotNum"+i),LotTyp) + "</label><br/>";
			}
		}
		if(MessManTool.getValueByName(message, "LotNum6").indexOf("*")!=-1){
				LotNums[6] = MessManTool.getValueByName(message, "LotNum6");
				LotNumDis = LotNumDis + "<label>" + LotNumFormat.OneMultipleRecordFormat(MessManTool.getValueByName(message, "LotNum6"), LotTyp) + "</label><br/>";
		}
		gzLog.Write("投注号码为："+LotNumDis);
 		MulTip = MessManTool.getValueByName(message, "MulTip");
 		TrmCod = MessManTool.getValueByName(message, "TrmCod");
 %> 
		<form method='post' action='/GZMBank/SportsTicket/TicketSale1.jsp'>		
        <label><%=new LotTypFormat().NtoC(LotTyp)%></label>
        <label>购买成功</label>
		
				<label>查询流水号:<%=LogNo%></label>
		
				<label>购彩流水号:<%=TLogNo%></label>
			
				<label>注数:<%=NotNum%></label>
			
				<label>投注号码为:<%=LotNumDis%></label>
		
				<label>倍数:<%=MulTip%></label>
			
				<label>期号:<%=TrmCod%></label>
			
		    <label>所有数据以广东省体育彩票发行中心数据为准</label>
		</form>

	<!--form method='post' action='/GZMBank/SportsTicket/TicketDraw1.jsp'>
<%
	/*Connection connection = null;
	Statement st = null;
	ResultSet rs = null;
	ConnPool connpool = new ConnPool();

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		st.executeUpdate("insert into TICKETDRAW(CrdNo, SgnMob) values('"+cdno+"', '"+sjNo+"')");
		//充值手机号
		out.println("<label>您增加了一次抽奖的机会，请点击抽奖。</label><br/>");
		out.println("<input type='submit' value='抽奖' />");
		
	}catch(NamingException e){
		gzLog.Write("MidServPoolDs连接池故障:"+e.getMessage());
	}catch(SQLException e){
		gzLog.Write("数据库故障:"+e.getMessage());
	}catch(Exception e){
		gzLog.Write("其他故障:"+e.getMessage());
		e.printStackTrace();
	}finally{
		if(rs != null){
			rs.close();
		}
		if(st != null){
			st.close();
		}
		if(connection != null){
			connection.close();
		}
	}*/
  
%>
	</form-->
<%
 	}else{
 		String RspCod = MessManTool.getValueByName(message, "RspCod");
 		String RspMsg = MessManTool.getValueByName(message, "RspMsg");
 	%>
 	
		<form method='post' action='/GZMBank/SportsTicket/TicketSale1.jsp'>		
   		<label>错误码为:<%=RspCod%></label>
 		
 		<%
	  	if("PD5012".equals(RspCod)){
    %>
		  <label>错误原因为:密码错误。</label>
    <%
		  }
		%>
		</form>
  <%
	}
%>
	</content>
</res>