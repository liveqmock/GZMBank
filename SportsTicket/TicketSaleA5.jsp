<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.sportticket.format.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");

	String TikMod = request.getParameter("TikMod");
	String SigDup = request.getParameter("SigDup");
	String NotNum = request.getParameter("NotNum");
	String LotNum = request.getParameter("LotNum");//接收前一表单的投注号码
	String[] LotNums = new String[7];              //接收返回表单的投注号码
	String LotNumDis = "";                         //回显投注号码
	String LotTyp = request.getParameter("LotTyp");
	String MulTip = request.getParameter("MulTip");
	String ExtNum = request.getParameter("ExtNum");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤5：TikMod:"+TikMod
				+"|SigDup:"+SigDup
				+"|NotNum:"+NotNum
				+"|LotNum:"+LotNum
				+"|LotTyp:"+LotTyp
				+"|MulTip:"+MulTip
				+"|ExtNum:"+ExtNum
				+"|");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	String sendContext = "|biz_id,29|biz_step_id,2|TXNSRC,MB441|"
						+ "|TikMod," + TikMod 
						+ "|SigDup," + SigDup 
						+ "|NotNum," + NotNum 
						+ "|LotNum," + LotNum 
						+ "|LotTyp," + LotTyp 
						+ "|MulTip," + MulTip 
						+ "|ExtNum," + ExtNum 
						+ "|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+sendContext);

	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	String message = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+message);
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {

		String TRspCd = MessManTool.getValueByName(message, "TRspCd");
		NotNum = MessManTool.getValueByName(message, "NotNum");
		for(int i=1;i<=5;i++){
			if(MessManTool.getValueByName(message, "LotNum"+i).indexOf("*")!=-1){
				LotNums[i] = MessManTool.getValueByName(message, "LotNum"+i);
				LotNumDis = LotNumDis + LotNumFormat.OneSimplexRecordFormat(MessManTool.getValueByName(message, "LotNum"+i),LotTyp);
			}
		}
		if(MessManTool.getValueByName(message, "LotNum6").indexOf("*")!=-1){
				LotNums[6] = MessManTool.getValueByName(message, "LotNum6");
				LotNumDis = LotNumDis + LotNumFormat.OneMultipleRecordFormat(MessManTool.getValueByName(message, "LotNum6"), LotTyp);
		}
		gzLog.Write("投注号码为："+LotNumDis);
		String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");
 		MulTip = MessManTool.getValueByName(message, "MulTip");
 		String TrmCod = MessManTool.getValueByName(message, "TrmCod");
 %> 
 	<label><%=new LotTypFormat().NtoC(LotTyp)%></label>
 	<label>请确认购彩信息</label>
	
			<label>注数:<%=NotNum%></label>
	
<%
		if("01".equals(TikMod)){
%>
	
			<label>投注号码为:</label>
		  <%=LotNumDis%>
<%
		}
%>
	
			<label>金额:<%=MoneyUtils.FormatMoney(Double.parseDouble(TxnAmt.trim()) / 100, "###0.00")%> </label>
	
			<label>倍数:<%=MulTip%></label>
		
			<label>期号:<%=TrmCod%></label>
	
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleA6.jsp'>
		<label>请输入交易密码:</label>
		
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt></input>
		<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
		
		<input type='hidden' name='CrdNo'  value='<%=cdno%>'  ></input>
		<!--交易金额-->
		<input type='hidden' name='TxnAmt' value='<%=TxnAmt%>'></input>
		<!--期号-->
		<input type='hidden' name='TrmCod' value='<%=TrmCod%>'></input>
		<!--购票方式-->
		<input type='hidden' name='TikMod' value='<%=TikMod%>'></input>
		<!--彩票类型-->
		<input type='hidden' name='LotTyp' value='<%=LotTyp%>'></input>
		<!--单复式区分-->
		<input type='hidden' name='SigDup' value='<%=SigDup%>'></input>
		<!--注数-->
		<input type='hidden' name='NotNum' value='<%=NotNum%>'></input>
		<!--倍数-->
		<input type='hidden' name='MulTip' value='<%=MulTip%>'></input>
		<!--扩展号码-->
		<input type='hidden' name='ExtNum' value='<%=ExtNum%>'></input>
		<!--投注号码-->
		<input type='hidden' name='LotNum' value='<%=LotNum%>'></input>
		
		<input type='submit' value='下一步'></input>
    </form>

<%
 	}else{
 		String RspCod = MessManTool.getValueByName(message, "RspCod");
 		String RspMsg = MessManTool.getValueByName(message, "RspMsg");
%>
		<form method='post' action='/GZMBank/SportsTicket/TicketSale1.jsp'>		
			<label>错误码为:<%=RspCod%></label>
			<label>错误原因为:<%=RspMsg%></label>
		</form>
<%
	}
%>

	</content>
</res>