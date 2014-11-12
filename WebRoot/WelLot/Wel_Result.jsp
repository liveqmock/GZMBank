<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@ page import="com.gdbocom.util.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");


	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//设置需要显示的值和名称,
	Map showKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE));
	String title = "";
	String remark = "";
	if(bus==WelLot.ADDREG){
		title = "福彩用户注册成功";
	}else if(bus==WelLot.UPDREG){
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.DOUBLE_SEL){//双色球自选
		title = "双色球实时投注购买成功";
		showKey.put("TLogNo", "购彩流水号");
		showKey.put("ShowNum", "投注号码");
	}else if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.DOUBLE_WINQRY){//双色球中奖查询
		title = "福彩用户注册信息更改成功";
	}else{
		title = "";
	}

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
			<label><%=title%></label><br/>
<%

	Map form = request.getParameterMap();


	//显示确认值
	Set keys = showKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);

		String pageContextValue = (String)pageContext.getAttribute(key, PageContext.SESSION_SCOPE);
		if(null!=pageContextValue){
			String formattedValue = null==type?pageContextValue:getFormattedValue(pageContextValue, type);
			out.println("<label>"+showValue+":"+formattedValue+"</label><br/>");
		}else{
			out.println("<label>"+showValue+":null</label><br/>");
		}
		
	}

%>
			<label><%=remark%></label>
			<label> </label>
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