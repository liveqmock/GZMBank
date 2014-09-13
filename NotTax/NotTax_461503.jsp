<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");

	//设置正常情况需要跳转的页面
	String forwardPage = "NotTax_Result.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";
	//设置需要从网关正常返回中获取下来的值的名称,
	String saveKey = "";

	//在这里开始拼装即将发往服务器的一串报文
	String requestContext = Context.createContext(pageContext, "34", "4");
	gzLog.Write("["+uri+"]网关请求报文："+requestContext);
	

	//上送网关
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	bwResult = midServer.sendMessage(requestContext);
	String responseContext = bwResult.getContext();
	gzLog.Write("["+uri+"]网关返回报文："+responseContext);
	

	//检查返回是否异常
	String MGID = MessManTool.getValueByName(responseContext, "MGID");	
	
	if("000000".equals(MGID)){//如果返回正确
		gzLog.Write("["+uri+"]forward到"+forwardPage);

		PreAction.saveMidServerValue(pageContext, responseContext, saveKey);
	    pageContext.forward(forwardPage);

	}else{//如果返回不正确
		String RspCod = MessManTool.getValueByName(responseContext, "RspCod");
		String RspMsg = MessManTool.getValueByName(responseContext, "RspMsg"); 
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

%>