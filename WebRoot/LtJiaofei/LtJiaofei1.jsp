<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	gzLog.Write("联通缴费====Step1"+"卡号："+cdno+"手机号："+sjNo+"\n账单查询460621");
%>

<!-- 分行特色业务频道列表 -->
<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/LtJiaofei/LtJiaofei2.jsp'>
		 
			<label>缴费卡号：<%=cdno%></label><br/>  
　　　<label>业务类型:</label><br/>
			<select name="YwLei">
				<option value="G">GSM</option>
				<option value="C">CDMA</option>
        <option value="P">193长途</option>
				<option value="H">165窄带</option>
			</select>
			<label>电话号码:</label>
			<input type='text' name='TCusId' style="-wap-input-required:'true';" maxleng='21'/>
			<label>账单年月:</label>
      <input type='text' name='LChkTm' style="-wap-input-format:'N'; -wap-input-required:'true'" maxleng='8'/>
			<label>输入格式：请输入六位数，前4位为年份，后2位为月份，如：201202</lable>
			<input type='submit' value='查询'/>		
			
		</form>
	</content>
</res>
