<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");


	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//设置显示的值的顺序
	String[] keyOrder = {};

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
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
	}else if(bus==WelLot.DOUBLE_FIX_BUY){//双色球中奖查询
		title = "双色球定投购买成功";

		keyOrder = new String[]{"DrawId", "BetLin", "BetAmt"};
		
		showKey.put("TLogNo", "购彩流水号");
		showKey.put("ShowNum", "投注号码");
		showKey.put("BetPer", "注数");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
	}else if(bus==WelLot.DOUBLE_FIX_CANCEL){//双色球中奖查询
		title = "双色球定投取消成功";

	}else{
		throw new IllegalArgumentException("错误的bus值");
	}

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
			<label><%=title%></label><br/>
<%

	for(int keyIndex=0; keyIndex<keyOrder.length; keyIndex++){
	
		//英文值，类似"DrawId"
		String key = keyOrder[keyIndex];
		//显示的中文名字，类似"投注期号"
		String showName = (String)showKey.get(key);
		//使用的格式化对象，类似 WelFormatter.getSingleton(WelFormatter.BETNUM)
		FormatterInterface type = (FormatterInterface)keyType.get(key);
		//为格式化的值
		String originValue = (String)pageContext.getAttribute(key, PageContext.SESSION_SCOPE);
	
	
		if(null==originValue){
			out.println("<label>"+showName+":null</label><br/>");
		}else if(null==type){
			out.println("<label>"+showName+":"+originValue+"</label><br/>");
		}else{
			//格式化后的值
			String formattedValue = type.getFormattedValue(originValue);
			out.println("<label>"+showName+":"+formattedValue+"</label><br/>");
	
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