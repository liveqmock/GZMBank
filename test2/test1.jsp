<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.sql.*"%>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n测试");
%>



   
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
	
		<form method='post' action='/GZMBank/test2/test2.jsp'>
		
		
     
		<table border="1">

		
	dfwfwdfw	
		</table>
		  
    
    
<input type="submit" value="确定"></input>
		</form>

<form method='post' action='/GZMBank/test2/test1.jsp'>

		<input type="submit" value="下一页"></input>
		
			</form>
	</content>
</res>


