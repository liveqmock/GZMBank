<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//设置显示的值的顺序
	String[] keyOrder = {};

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map showKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();
	
	String busStr=ReqParamUtil.reqParamTirm(request,"Bus");
	//获取服务端调用结果集
	Map responseVal=(Map)request.getAttribute("responseVal");
	
	int bus =Integer.parseInt(busStr);	
	String title = "";
	String remark = "";
	if(bus==WelLot.HP_TEN_BUY){

		title = "快乐十分实时投注购买成功";

		keyOrder = new String[]{"BetLin", "BetAmt", "TLogNo"};
		
		showKey.put("DrawId", "投注期号");
		showKey.put("KenoId", "小期号");
		showKey.put("BetLin", "投注号码");
		showKey.put("BetAmt", "投注金额");
		showKey.put("TLogNo", "投注流水号");
		showKey.put("TckNo", "会计流水号");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM_HPTEN));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else if(bus==WelLot.HP_TEN_QRY){//双色球投注查询
		title = "福彩用户注册信息更改成功";
	}else if(bus==WelLot.HP_TEN_WINQRY){//双色球中奖查询
		title = "福彩用户注册信息更改成功";
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
		String originValue = (String)responseVal.get(key);
		if(StringUtils.isEmpty(originValue)){
			originValue=ReqParamUtil.getParamAttr(request,key);
		}
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