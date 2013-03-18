<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String CrdNo = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong3.jsp'>
			<label>请选择充值金额</label><br/>
			<select name="TxnAmt">
				<option value="0" selected>50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select><br/>
			
<%
	Map form = request.getParameterMap(); //充值的联通手机号码

	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			//context += key+","+values[0]+"|";
		}
	}


%>
			<input type='hidden' name='TelNum' value="<%=%>"/><br/>
			<input type='hidden' name='CrdNo' value="<%=CrdNo%>"/><br/>
			<input type='submit' value='确定'/><br/>
		</form>
	</content>
</res>