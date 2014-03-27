<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>

		<form method='post' action='/GZMBank/ChongZhi/yidong/ChongZhi_check.jsp'>
			<label>请输入您要充值的移动手机号码:   </label>
		    <input type='text' name='ydNumber' />
			<br/>
			<label>请选择充值金额数目:</label>
			<br/>
			<select name="optAmount">
				<option value="0">50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select>
			<br/>
			<br/>
			<br/>
		    <input type='submit' value='下一步'/>
		</form>
</content>
</res> 