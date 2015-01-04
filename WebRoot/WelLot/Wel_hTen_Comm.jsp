<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@page import="org.apache.commons.lang.StringUtils"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
//保存交易密码值
	String password=request.getHeader("password");
	request.setAttribute("password",password);
	//String buyMode = ReqParamUtil.reqParamTirm(request,"buyMode");
	
	//String cdno = request.getHeader("MBK_ACCOUNT");
	
	String busStr=ReqParamUtil.reqParamTirm(request,"Bus");
	int bus =Integer.parseInt(busStr);

	//设置正常情况需要跳转的页面
	String forwardPage = null;
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";
	
	//是否需要验证短信密码
	int isCheckMessagePw = 0;//0:不检验，非0检验

	//根据业务标志来进行通讯
	int txnCod=0;
	String txnName = null;
	String serverName = "";
	//报文字段存放容器
	Map callMap=new HashMap();
	callMap.put("GameId",WelLot.GameId.HPAAY_TEN);//标识只查询快乐十分
	
	if(bus==WelLot.HP_TEN_BUY){//投注购买
		txnCod=TransationFactory.WEL485412;
		serverName = "@WEL_B";
		isCheckMessagePw = 1;
		forwardPage = "Wel_hTen_result.jsp";
	}else if(bus==WelLot.HP_TEN_QRY){//投注查询
		txnCod=TransationFactory.WEL485413;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_hTen_More_Result.jsp";
	}else if(bus==WelLot.HP_TEN_WINQRY){//中奖查询(定投/实时)
		txnCod=TransationFactory.WEL485414;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_hTen_More_Result.jsp";
	}else{
		throw new IllegalArgumentException("没有定义交易码");
	}
	
	txnName = WelLot.getTxnCod(bus);
	
	//获取调用字段
	callMap.put("TTxnCd", txnName);
	callMap.put("FeCod", txnName );
    //获取attribute和parameter的全部参数
    Map paMap=ReqParamUtil.getParamAttr(request);
    callMap.putAll(paMap);
    
    DebugUtils.printMap(request, callMap);
	
	if(0!=isCheckMessagePw){
		//BEGIN 身份认证
		//
		/*String verify = request.getHeader("MBK_VERIFY_RESULT");
		if(verify!=null&&!verify.equals("P")){
			String RspCod = "MID999";
			String RspMsg = "手机短信密码验证不通过"; 
			gzLog.Write("["+uri+"]MGID不正确");

			StringBuffer forwardString = new StringBuffer();
			forwardString.append(errPage).append("?");
			forwardString.append("RspCod").append("=").append(RspCod);
			forwardString.append("&");
			forwardString.append("RspMsg").append("=").append(RspMsg);
	        pageContext.forward(forwardString.toString());
		}*/
	    //END 身份认证
	}

	txnName = WelLot.getTxnCod(bus);
	Map responseValues = new HashMap();
	try{
		responseValues.putAll(
				Transation.exchangeData(IcsServer.getServer(serverName),
                callMap,
                txnCod)
				);

	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		DebugUtils.log(request,"MGID不正确");
		
		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

	request.setAttribute("responseVal", responseValues);
	if ("N".equals(responseValues.get("MsgTyp"))) {// ICS返回Normal
	    pageContext.forward(forwardPage);

    } else if ("E".equals(responseValues.get("MsgTyp"))) {// ICS返回Error
		String RspMsg =responseValues.get("RspMsg").toString(); 
		DebugUtils.log(request,"MGID不正确  RspMsg:"+RspMsg);
        pageContext.forward(errPage);
    }
%>