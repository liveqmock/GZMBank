<%@page import="org.apache.commons.lang.StringUtils"%>
<%@page import="com.gdbocom.util.HpTenBallCreater.HpTenParam"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="java.text.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
	//设置显示的值的顺序
	String[] keyOrder = {};

	//设置非循环体需要显示的值和名称,
	Map sequenceShowKey = new HashMap();

	//设置循环体需要显示的值和名称,
	Map loopShowKey = new HashMap();
	
	//获取服务端调用结果集
	Map responseVal=(Map)request.getAttribute("responseVal");
	
	//设置需要显示的值的类型
	Map keyType = new HashMap();

	int bus = Integer.parseInt(ReqParamUtil.reqParamTirm(request,"Bus"));
	String title = "";
	String remark = "";
	if(bus==WelLot.HP_TEN_QRY){//双色球投注查询
		title = "";
		keyOrder = new String[]{"DrawId","KenoId","BetLin", "BetAmt","PlayId","TLogNo"};
		
		loopShowKey.put("DrawId", "投注期号");
		loopShowKey.put("KenoId", "小期号");
		loopShowKey.put("PlayId", "投注种类");
		loopShowKey.put("BetLin", "投注号码");
		loopShowKey.put("BetAmt", "投注金额");
		loopShowKey.put("TLogNo", "投注流水号");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM_HPTEN));
		keyType.put("BetAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else if(bus==WelLot.HP_TEN_WINQRY){//双色球中奖查询
		title = "";
		keyOrder = new String[]{"DrawId","KenoId","BetLin", "PrzAmt","PlayId", "TLogNo"};
		
		loopShowKey.put("DrawId", "中奖期号");
		loopShowKey.put("KenoId", "小期号");
		loopShowKey.put("PlayId", "投注种类");
		loopShowKey.put("BetLin", "中奖号码");
		loopShowKey.put("PrzAmt", "中奖金额");
		loopShowKey.put("TLogNo", "投注流水号");
		
		keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM_HPTEN));
		keyType.put("PrzAmt", WelFormatter.getSingleton(WelFormatter.CURRENCY));

	}else{
		title = "";
	}
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
			<label><%=title%></label><br/>
	            <%
	String loopCntStr=responseVal.get("LoopCnt").toString();
	int loopCnt =Integer.parseInt(loopCntStr);
	if(0==loopCnt){
		out.println("<label>无记录</label><br/>");
	}else{
		List loopBody = (List)responseVal.get("LoopBody");
		//解拆循环字段
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
				String originValue = StringUtils.trimToEmpty((String)oneRecord.get(key));
				//DebugUtils.log(request,"结果值  key:"+key+" val:"+originValue);
				
				if("PlayId".equals(key)&&StringUtils.isNotEmpty(originValue)){
					HpTenParam param=new HpTenBallCreater(originValue).getParam();
					out.println("<label>"+showName+":"+param.name+"</label><br/>");
				}else if(null==originValue){
					out.println("<label>"+showName+":null</label><br/>");
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
			<label><%=remark%></label>
			<label> </label>
	</content>
</res>