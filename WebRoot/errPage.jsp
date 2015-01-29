<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	gzLog.Write("进入["+uri+"]");
	
	String errorCode=ReqParamUtil.getParamAttr(request,"errorCode");
	String errorStr=ReqParamUtil.getParamAttr(request,"errorStr");
	String rspCod="";
	String rspMsg="";
	Map resVal=(Map)request.getAttribute("responseVal");
	if(resVal!=null){
		rspCod=(String)resVal.get("RspCod");
		rspMsg=(String)resVal.get("RspMsg");
	}else{
		rspCod=ReqParamUtil.getParamAttr(request,"RspCod");
		rspMsg=request.getParameter("RspMsg");
		if(StringUtils.isNotEmpty(rspMsg)){
			rspMsg=URLDecoder.decode(rspMsg, "UTF-8");
		}
	}
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
			<label>交易失败:</label><br/>
			<label>错误码:<%=StringUtils.trimToEmpty(rspMsg)%><%=StringUtils.trimToEmpty(errorCode)%></label><br/>
			<label>错误信息:<%=StringUtils.trimToEmpty(rspMsg)%><%=StringUtils.trimToEmpty(errorStr)%></label><br/>
			<label></label><br/>
	</content>
</res>
