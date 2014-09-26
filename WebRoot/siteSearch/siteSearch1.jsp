<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n营业网点搜索");
%>



<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>


	<form method='post' action='/GZMBank/siteSearch/siteSearch2.jsp'>
	
	
		
		   <label>城市：</label>
		   <select name="city">
		  <option value="GZ">广州</option>
		  <option value="ZH">珠海</option>
		  <option value="FS">佛山</option>
		  <option value="ZS">中山</option>
		  <option value="ST">汕头</option>
		  <option value="HZ">惠州</option>
		  <option value="JM">江门</option>
		  <option value="DG">东莞</option>
		  <option value="JY">揭阳</option>
		  </select>
		<br/>
		<br/>
		   <label>网点名称：</label>
		   <input type='text' name='sitename' style=" -wap-input-required: 'false'"  maxleng='20'/>
		   <br/> 
		        <label> (可输入网点名称关键字)</label>
	   <br/>
	    <br/>
		
            
			 <input type="hidden" name="dxButton"  value=""></input>
		   <input type='submit' value='搜索'/>    
			<br/>
			<br/>
		<label>提示：“城市”为必选项，“网点名称”为可选项。</label>
		
		</form>
	</content>
</res>
