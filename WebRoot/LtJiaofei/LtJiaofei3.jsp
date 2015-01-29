<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	String plantPwd = MessManTool.changeChar(request.getHeader("password")); //移植密
	String ActNo  = MessManTool.changeChar(request.getParameter("ActNo")); //银行账号
	String TCusNm = MessManTool.changeChar(request.getParameter("TCusId")); //电话号码
	String FfNo= MessManTool.changeChar(request.getParameter("FfNo")); //电话号码
	String LChkTm = MessManTool.changeChar(request.getParameter("LChkTm")); //账单年月
	String YwLei = MessManTool.changeChar(request.getParameter("YwLei"));//业务类型
  String TxnAmt = MessManTool.changeChar(request.getParameter("TxnAmt"));
  String displayTxnAmt = TxnAmtFormat.format(TxnAmt);
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/LtJiaofei/LtJiaofei1.jsp'>
	<%	
		//在这里开始拼装即将发往服务器的一串报文。 注意有其固定格式
		
		String sendContext = "biz_id,35|biz_step_id,2|TXNSRC,MB441|ActNo,"+cdno+"|BusiType,"+YwLei+"|TCusId,"+LChkTm+"|TCusNm,"+FfNo+"|MonSum,"+TxnAmt+"|IdType,1|IdNo,55555|ActTpe,4|PSWD,"+plantPwd+"|ActNam,55555|";  //密码字段到时要修改
		
		
		
		gzLog.Write("这是联通缴费=====最后阶段=====STEP4"+"\n上传的报文组装完毕，内容如下："+sendContext);  //log
		
		//这里开始才会转到网关上啊
		MidServer midServer = new MidServer();
		BwResult bwResult = new BwResult();
		bwResult = midServer.sendMessage(sendContext);
		String info = bwResult.getContext();
		gzLog.Write("这是联通缴费=====最后阶段=====STEP4"+"\n服务器下行返回的报文内容："+info);
		
		String MGID = MessManTool.getValueByName(info, "MGID");	
		gzLog.Write("校验码MGID:  "+MGID);
		
		//如果返回正确
		if("000000".equals(MGID)){

			String TransSeq = MessManTool.getValueByName(info, "TransSeq");
			String OppTransSeq = MessManTool.getValueByName(info, "OppTransSeq");	
		
	 %>	 
			<label>
				联通账单缴费交易成功！
			</label>
       <label>电话号码:<%=TCusNm%></label>
       <label>账单年月:<%=LChkTm%></label>
       <label>缴费金额:<%=displayTxnAmt%></label>
       <label>银行会计流水号:<%=TransSeq%></label>
	
		
	<%
		} else {
	      String RspCod = MessManTool.getValueByName(info, "RspCod");
 	      String RspMsg = MessManTool.getValueByName(info, "RspMsg"); 
 	      
 	      gzLog.Write("****错误码:"+RspCod+"错误信息"+RspMsg);
 	       %> 
 	      <label>交易失败!</label>
 	      <label>错误码为:<%=RspCod%></label>
 	      <label>错误信息:<%=RspMsg%></label>
 	      <%
 	}
	gzLog.Write("联通缴费完毕！！！！！");
    %>	
		</form>
	</content>
</res>