<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<% 

%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/txDianXin/txDianXin2.jsp'>
		<table border="1">
			<tr>
				<td> 选择 </td>
				<td> 业务种类 </td>
			</tr>

			<tr>
				<td><input type="radio" value="Phonepay" name="BusTyp" checked='checked'/></td>
				<td>固话缴费</td>
			</tr>

			<tr>
				<td><input type="radio" value="XLTpay" name="BusTyp"/></td>
				<td>小灵通充值</td>
			</tr>

			<tr>
				<td><input type="radio" value="CDMApay" name="BusTyp"/></td>
				<td>CDMA缴费</td>
			</tr>

			<tr>
				<td><input type="radio" value="CDMAprepay" name="BusTyp"/></td>
				<td>CDMA预付费</td>
			</tr>

		</table>
		

		<input type="submit" value="确定"></input>
		</form>
	</content>
</res>