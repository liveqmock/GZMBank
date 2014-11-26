<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");


	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//设置显示的值的顺序
	String[] keyOrder = null;

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map loopShowKey = new HashMap();

	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE));
	String title = "";
	String remark = "";
	if(bus==WelLot.DOUBLE_FIX_QRY){//双色球投注查询
		title = "";
		//sequenceShowKey.put("CrdNo", "签约手机号");
		keyOrder = new String[]{"PlanNo", "BetPer", "BetLin", "BetAmt", "DoPer", "LevPer"};
		
		loopShowKey.put("BetPer", "套餐类型");
		loopShowKey.put("BetLin", "投注号码");
		loopShowKey.put("BetAmt", "投注金额");
		loopShowKey.put("DoPer", "已投注期数");
		loopShowKey.put("LevPer", "剩余投注期数");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else{
		title = "";
	}



%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<label><%=title%></label><br/>
		<label>签约手机号：<%=CrdNo%></label><br/>
		<form method='post' action='/GZMBank/WelLot/Wel_Fix_DCnf.jsp'>
<%

	int loopCnt = 
		((Integer)pageContext.getAttribute("LoopCnt", PageContext.SESSION_SCOPE)).intValue();
	if(0==loopCnt){
		out.println("<label>无记录</label><br/>");
	}else{

		//解拆循环字段
		List loopBody = (List)pageContext.getAttribute("LoopBody", PageContext.SESSION_SCOPE);
		for(int recordIndex=0; recordIndex<loopBody.size(); recordIndex++){
			Map oneRecord = (Map)loopBody.get(recordIndex);
	
	
			for(int keyIndex=0; keyIndex<keyOrder.length; keyIndex++){
	
				//英文值，类似"DrawId"
				String key = keyOrder[keyIndex];
				//显示的中文名字，类似"投注期号"
				String showName = (String)loopShowKey.get(key);
				//使用的格式化对象，类似 WelFormatter.getSingleton(WelFormatter.BETNUM)
				FormatterInterface type = (FormatterInterface)keyType.get(key);
				//为格式化的值
				String originValue = (String)oneRecord.get(key);
	
				if(null==originValue){
					out.println("<label>"+showName+":null</label><br/>");
				}else if("PlanNo".equals(key)){
					out.println("<input type='radio' name='"+key+"' value='"+originValue+"' /><br/>");
				}else if(null==type){
					out.println("<label>"+showName+":"+originValue+"</label><br/>");
				}else{
					//格式化后的值
					String formattedValue = type.getFormattedValue(originValue);
					
					out.println("<label>"+showName+":"+formattedValue+"</label><br/>");

				}
	
			}
			out.println("<label>***********************</label><br/>");
	
		}
	}
	

%>
		<input type='hidden' name='preSaveKey' value='PlanNo' />
		<input type='submit' value='撤销'/><br/>
		</form>
		<label><%=remark%></label>
		<label> </label>
	</content>
</res>
