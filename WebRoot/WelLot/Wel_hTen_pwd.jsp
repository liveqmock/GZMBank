<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_hTen_Comm.jsp'>
			<label>请输入交易密码：</label><br/>
			<input type='password' name='password' isRandomPass='true' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<%=
				ReqParamUtil.reqParamAttrToHtmlStr(request)
			%>
			<input type='submit' value='确定'/><br/>
		</form>
	</content>
</res>