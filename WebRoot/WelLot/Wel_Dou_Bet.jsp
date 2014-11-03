<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	//gzLog.Write(request.getQueryString().toString());
	
	//获取bus字段,判断交易类型
	int bus = Integer.parseInt((String)pageContext.getAttribute("Bus"));

	//设置正常情况需要跳转的页面
	String forwardPage = "Wel_Result.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";
	//设置需要从网关正常返回中获取下来的值的名称,
	String saveKey = "";

	//根据业务标志来进行通讯
	int txnCod;
	String txnName = null;
	String serverName = "";
	if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		saveKey="MobTel";
		txnCod=TransationFactory.WEL485413;
		serverName = "@WEL_B";
	}else if(bus==WelLot.DOUBLE_WINQRY){//双色球中奖查询
		saveKey="MobTel";
		txnCod=TransationFactory.WEL485414;
		serverName = "@WEL_B";
	}else{
		txnCod=0;
	}

	txnName = WelLot.getTxnCod(txnCod);
	Map responseValues = new HashMap();
	try{
		responseValues.putAll(
				Transation.createMapSend(pageContext,
						txnName,
						serverName,
						txnCod
					)
				);

	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

	if ("N".equals(responseValues.get("MsgTyp"))) {// ICS返回Normal
		gzLog.Write("["+uri+"]forward到"+forwardPage);

		//保存特别的字段
		String[] saveKeys = saveKey.split("\\,");
		for(int i=0; i<saveKeys.length; i++){
			pageContext.setAttribute(
					saveKeys[i],
					responseValues.get(saveKeys[i]),
					PageContext.SESSION_SCOPE
					);

		}
	    pageContext.forward(forwardPage);

    } else if ("E".equals(responseValues.get("MsgTyp"))) {// ICS返回Error
		String RspCod = (String)responseValues.get("RspCod");
		String RspMsg = URLEncoder.encode((String)responseValues.get("RspMsg"), "UTF-8"); 
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
    }
%>