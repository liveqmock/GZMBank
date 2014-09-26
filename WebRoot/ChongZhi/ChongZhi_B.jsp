<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("####ChongZhi_B.jsp");
	
%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/ChongZhi/dianxin/ChongZhi_B1.jsp'>
			
			 <label>充值号码为:   </label>
		    <input type='text' name='dxNumber' />
			
			<label>选择号码类型</label>
			<select name="numType">
				<option value="0000">固话</option>
				<option value="0001">小灵通</option>
				<option value="0002">手机</option>
				<option value="0003">ADSL</option>
			</select>
			
			
			<label>请选择充值金额：</label>
			<select name="optAmount">
				<option value="0">50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select>
		    <input type='submit' value='下一步'/> 
			<br/>
			<label>如果充值号码类型为固话,小灵通或ADSL,请记得加上区号.</label>
		</form>
	</content>
</res> 

