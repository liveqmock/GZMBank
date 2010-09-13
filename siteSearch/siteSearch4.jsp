<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n营业网点搜索");
%>

<%
   String dxButton =  MessManTool.changeChar(request.getParameter("dxButton"));
   String mphone = request.getParameter("mphone");
%>
 <%  ConnDXPT dxpt = new ConnDXPT();
	String rt = dxpt.sendMessage(dxButton,mphone,cdno);	%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/siteSearch/siteSearch4.jsp'>
		 <br/> 
		  <br/> 
	<label>短信已发送，请您查收，谢谢使用！</label>
		 <br/> 
		  <br/> 
	
		<input type='button' name='cancel' value='返回'/>
		</form>
	</content>
</res>
   
