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

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map loopShowKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus"));
	String title = "";
	String remark = "";
	if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		title = "";
		loopShowKey.put("DrawId", "当前大期");
		loopShowKey.put("KenoId", "当前小期");
		loopShowKey.put("BetLin", "投注号码");
		loopShowKey.put("BetAmt", "投注金额");
		loopShowKey.put("KenoId", "当前小期");
		
		keyType.put("BetLin", "BetNum");
		keyType.put("BetAmt", "Currency");

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
	Set keys = sequenceShowKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)sequenceShowKey.get(key);
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

%>