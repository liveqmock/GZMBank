<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	
	//设置需要显示的值和名称,
	Map showKey = new HashMap();
	showKey.put("TelNum", "充值手机号");
	showKey.put("TxnAmt", "充值金额");
  showKey.put("TckNo", "会计流水号");
  

	Map keyType = new HashMap();
	keyType.put("TxnAmt", "BigDecimal");

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
       <form method='post' action='/GZMBank/ChongZhi/liantong/ChongZhi_liantong_TelNum.jsp'>
			<label>充值交易成功，感谢您的使用!</label>
<%

	Map form = request.getParameterMap();


	//显示确认值
	Set keys = showKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);
		
		if(form.containsKey(key)){
			String formValue = ( (String[])form.get(key) )[0];
			String formattedValue = null==type?formValue:getFormattedValue(formValue, type);
			out.println("<label>"+showValue+":"+formattedValue+"</label>");
		}else{
			out.println("<label>"+showValue+":null</label>");
		}
	}

%>
  </form> 
	</content>
</res>
<%!
	public String getFormattedValue(String value, String type){
		if("BigDecimal".equals(type)){
			return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
		}else{
			return value;
		}

	}
%>