<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.*" %>
<!-- 分行特色业务频道列表 -->
<%

	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	String errPage = "";
 %>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/qy_2.jsp"%>' >
    		<table>
    		<tr>
    		<td><label>客户证件号：</label></td>
    		<td><input type="text" name="CLI_IDENTITY_CARD" style="-wap-input-format: 'Y'; -wap-input-required: 'true'" /></td>
    		</tr>
    		</table>
    		<br/>
    		<input type='submit' value='下一步'/>
		
		</form>
	</content>
</res>
