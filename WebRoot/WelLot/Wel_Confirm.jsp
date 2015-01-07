<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.net.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="com.gdbocom.util.PreAction" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");

	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));
	
	//备注
	String remark = "";
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_Pub_Comm.jsp'>

			<label>请输入交易密码：</label><br/>
			<input type='password' name='password' isRandomPass='true' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<input type='hidden'  name='MBK_VERIFY' value='true'></input>

			<input type='submit' value='确定'/><br/>
			<label><%=remark%></label>
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