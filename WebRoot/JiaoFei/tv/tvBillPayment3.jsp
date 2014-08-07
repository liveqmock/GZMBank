<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String optType = MessManTool.changeChar(request.getParameter("optType"));  // 0 有线电视  1  珠江数码  2  珠江宽频
	String checkType = MessManTool.changeChar(request.getParameter("checkType"));  // 0 身份证  1  手册号码
	gzLog.Write("有线电视交费====Step2"+"银行卡号"+cdno+"手机号码"+sjNo+"客户查询类型"+optType+"\n");
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<%
    if(checkType.equals("0")){
	%>  
	<form method='post' action='/GZMBank/JiaoFei/tv/tvBillPayment3_1.jsp'>
		 
			<lable>缴费卡号：</lable>  
			<br/>
			<%=cdno%>
			<br/>
			
			<lable>缴费号码</lable>
			<br/>
			
			<input type='text' name='TCusID' style="-wap-input-required:'true'" maxleng='30'/>
			
			<br/>
			<lable>身份证号</lable>
			<br/>
			<input type='text' name='CusNo' style="-wap-input-format:'N'; -wap-input-required:'true'" maxleng='20'/>
			<br/>
			
			<input type='submit' value='查询'/>		
				
		</form>
    <%
	  }else {
    %>
	<form method='post' action='/GZMBank/tv/BillPayment4.jsp'>
		 
			<lable>缴费卡号：</lable>  
			<br/>
			<%=cdno%>
			<br/>
			
			<lable>缴费号码</lable>
			<br/>
			
			<input type='text' name='TCusID' style="-wap-input-required:'true'" maxleng='30'/>
			
			<br/>
			<lable>用户手册号</lable>
			<br/>
			<input type='text' name='CusNo' style="-wap-input-format:'N'; -wap-input-required:'true'" maxleng='20'/>
			<br/>
			
			<input type='submit' value='查询'/>		
				
		</form>
	   
   <%
	}
   %>
	</content>
</res>
