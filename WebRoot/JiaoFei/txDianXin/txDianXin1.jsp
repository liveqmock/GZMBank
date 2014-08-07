<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="java.util.*"%>
<% 

%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/txDianXin/txDianXin2.jsp'>
			
		 	<label>请选择业务种类: </label>
 			
 			<select name="BusTyp">
				<option value="Phonepay">固话缴费</option>
				<option value="XLTpay">小灵通充值</option>
				<option value="CDMApay">CDMA缴费</option>
				<option value="CDMAprepay">CDMA预付费</option>
			</select>
			<br/>
		  <br/>
		  <br/>
		  
		  <label>该业务目前仅限广州市区号码缴费，如有不便敬请谅解。</label>
		  <br/>
		  <br/>

		<input type="submit" value="确定"></input>
		</form>
	</content>
</res>