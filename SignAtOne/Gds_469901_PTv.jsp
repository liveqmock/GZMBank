<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	//设置正常情况需要跳转的页面
	String forwardPage = "Gds_Pub_Menu.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../errPage.jsp";
	//设置需要从网关正常返回中获取下来的值的名称,
	String saveKey = "signResult";	

//处理外发交易特殊数据
	Map<String, String> requestData = new HashMap<String, String>();
	requestData.putAll(request);
	if(requestData.containsKey("Func")){
	    requestData.remove("Func");
	    requestData.put("Func", GdsPubData.functionQuery);
	}
	//需要查询的各个签约情况
	int[] business = {
	        GdsPubData.businessOfWater,
	        GdsPubData.businessOfMobile,
	        GdsPubData.businessOfUnicom,
	        GdsPubData.businessOfTele,
	        GdsPubData.businessOfGas,
	        GdsPubData.businessOfElectricity,
	        GdsPubData.businessOfProvTv,
	        GdsPubData.businessOfCityTv
	};
//在这里开始与服务器进行通讯
	StringBuffer signResult = new StringBuffer();
	Map<String, String> responseData;
	for(int busiIndex=0; busiIndex<business.length; busiIndex++){
		if(requestData.containsKey("GdsBId")){
		    requestData.remove("GdsBId");
		    requestData.put("GdsBId", String.valueOf(business[busiIndex]));
		}
		//通讯
		gzLog.Write("["+uri+"]网关请求集合："+requestData);
	    responseData = Transation.exchangeData(
	            IcsServer.getServer("@GDS"),
	            requestData,
	            TransationFactory.GDS469901);
		gzLog.Write("["+uri+"]网关返回集合："+responseData);

		if(!"N".equals(responseData.get("MsgTyp"))){//异常报文不处理
		    continue;
		}
		if(responseData.containsKey("RecNum")
	            &&(Integer.parseInt(responseData.get("RecNum"))>0) ){
	        signResult.append(String.valueOf(business[busiIndex]));
	    }
	}

	

	//检查返回是否异常
	//if("N".equals(responseData.get("MsgTyp"))){//如果返回正确
	if(true){
		gzLog.Write("["+uri+"]forward到"+forwardPage);

		String[] saveKeys = saveKey.split(",");
		StringBuffer forwardString = new StringBuffer();
		forwardString.append(forwardPage).append("?");
		for(int index=0; index<saveKeys.length; index++){
			forwardString.append(saveKeys[index])
				.append("=")
				.append(responseData.get(saveKeys[index]));
			if(index<saveKeys.length-1){//如果还有值的话需要添加&做间隔
				forwardString.append("&");
			}
		}
	    pageContext.forward(forwardString.toString());

	}else{//如果返回不正确
		gzLog.Write("["+uri+"]forward到"+errPage);
		String RspCod = responseData.get("RspCod");
		String RspMsg = responseData.get("RspMsg"); 

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

%>