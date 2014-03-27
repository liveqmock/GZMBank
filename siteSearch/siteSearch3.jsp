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
   System.out.print("dxButton");
%>
 
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/siteSearch/siteSearch4.jsp'>
		 <br/> 
		  <br/> 
	<label>请输入手机号码：</label>
		   <input type='text' name='mphone' value="<%=sjNo%>" style=" -wap-input-required: 'true' ;-wap-input-format: 'phone'"  maxleng='11' />
		   <br/> 
		    <br/> 
	<input type="hidden" name="dxButton" value="<%=dxButton%>"/>
		
	<input type="submit" value="确定"></input>
		</form>
	</content>
</res>