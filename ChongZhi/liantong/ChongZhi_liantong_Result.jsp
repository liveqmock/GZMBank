<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	
	//设置需要显示的值和名称,
	String showKey = "TelNum,充值手机号|TxnAmt,充值金额|ActDat,充值日期|TckNo,银行流水号|TLogNo,联通流水号";	

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
			<label>交易成功:</label><br/>
<%

	Map form = request.getParameterMap();

	String[] showKeys = showKey.split("\\|");
	for(int pairsIndex=0;pairsIndex<showKeys.length;pairsIndex++){
		String[] keyValue = showKeys[pairsIndex].split(",");
		if(form.containsKey(keyValue[0])){
			out.println("<label>"+keyValue[1]+":"+( (String[]) form.get(keyValue[0]) )[0]+"</label><br/>");
		}else{
			out.println("<label>"+keyValue[1]+":null</label><br/>");
		}
	}
%>
	</content>
</res>
