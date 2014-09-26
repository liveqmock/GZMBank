<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong_Confirm.jsp'>
			<label>请选择充值金额</label><br/>
			<select name="TxnAmt">
        <option value="2000">20  元</option>
				<option value="3000">30  元</option>
				<option value="5000">50 元</option>
				<option value="10000">100 元</option>
				<option value="20000">200 元</option>
        <option value="30000">300 元</option>
				<option value="50000">500 元</option>
			</select><br/>
			
<%
	Map form = request.getParameterMap();

	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}


%>
			<input type='submit' value='确定'/><br/>
		</form>
	</content>
</res>