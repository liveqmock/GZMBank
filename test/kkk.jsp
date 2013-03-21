<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.sportticket.format.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
 	<label>&nbsp;请确认购彩信息</label><br/>
	<table border="1">
		<!--tr>
			<td>状态:</td><td>1</td>
		</tr-->
		<tr>
			<td>注数:</td><td>2</td>
		</tr>
		<tr>
			<td>投注号码为:</td><td><label>06,13,16,28,31|04,10</label><br/><label>06,16,28,30,33|03,09</label></td>
		</tr>
		<tr><td> </td><td> </td></tr>
		<tr>
			<td>金额:</td><td><label>06,13,16,28,31|04,10</label><br/><label>06,16,28,30,33|03,09</label><br/></td>
		</tr>
		<tr><td colspan="2"><input type="radio" value="1" name="sightCode">1111111</input></td>
		<!--tr>
			<td>倍数:</td><td><p>06,13,16,28,31|04,10</p><p>06,16,28,30,33|03,09</p></td>
		</tr-->
		<!--tr>
			<td>期号:</td><td><p>06,13,16,28,31|04,10</p><br/><p>06,16,28,30,33|03,09</p><br/></td>
		</tr-->
	</table>

	</content>
</res>