<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	

	//在这里开始拼装即将发往服务器的一串报文
	String requestContext = Context.createContext(request, "33", "1");
	gzLog.Write("["+uri+"]网关请求报文："+requestContext);
	

	//上送网关
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	bwResult = midServer.sendMessage(requestContext);
	String responseContext = bwResult.getContext();
	gzLog.Write("["+uri+"]网关返回报文："+requestContext);
	

	//检查返回是否异常
	String MGID = MessManTool.getValueByName(responseContext, "RspCod");	
	
	if("000000".equals(MGID)){//如果返回正确
		String AreCod = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "AreCod"));
		if(!"true".equals(AreCod)){
%>
			<jsp:forward page="errPage.jsp">
				<jsp:param name="RspCod" value="<%=AreCod%>" />
				<jsp:param name="RspMsg" value="输入手机号不正确" />
			</jsp:forward>
<%
		}else{
%>
			<jsp:forward page="ChongZhi_liantong_TxnAmt.jsp">
				<jsp:param name="AreCod" value="<%=AreCod%>" />
			</jsp:forward>
<%
		}
	}else{//如果返回不正确
		String RspCod = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "RspCod"));
		String RspMsg = MessManTool.changeChar(MessManTool.getValueByName(responseContext, "RspMsg")); 
%>
		<jsp:forward page="errPage.jsp">
			<jsp:param name="RspCod" value="<%=RspCod%>" />
			<jsp:param name="RspMsg" value="<%=RspMsg%>" />
		</jsp:forward>
<%
	}

%>