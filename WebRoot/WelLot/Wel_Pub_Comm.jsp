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

	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//获取bus字段,判断交易类型
	String busStr = (String)pageContext.getAttribute("Bus", PageContext.SESSION_SCOPE);
	int bus = null==busStr?0:Integer.parseInt(busStr);

	//设置正常情况需要跳转的页面
	String forwardPage = null;
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";
	//设置需要从网关正常返回中获取下来的值的名称,
	String saveKey = null;
	//保存上一页面的值
	//保存交易密码值
	String password = request.getHeader("password");
	pageContext.setAttribute("password", password, PageContext.SESSION_SCOPE);
	//是否需要验证短信密码
	int isCheckMessagePw = 0;//0:不检验，非0检验


	//根据业务标志来进行通讯
	int txnCod;
	String txnName = null;
	String serverName = "";
	if(bus==WelLot.ADDREG){//用户注册
		saveKey="LotNam";
		txnCod=TransationFactory.WEL485404;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
		txnName = WelLot.getTxnCod(bus);
	}else if(bus==WelLot.UPDREG){//注册变更
		saveKey="MobTel";
		txnCod=TransationFactory.WEL485405;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.DOUBLE_SEL){//双色球自选
		saveKey="TLogNo,Cipher,Verify,LotNam,LotBal";
		txnCod=TransationFactory.WEL485412;
		serverName = "@WEL_B";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else if(bus==WelLot.DOUBLE_BETSQRY){//双色球投注查询
		saveKey="LoopBody";
		txnCod=TransationFactory.WEL485413;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_More_Result.jsp";
	}else if(bus==WelLot.DOUBLE_WINQRY){//双色球中奖查询
		saveKey="LoopBody";
		txnCod=TransationFactory.WEL485414;
		serverName = "@WEL_B";
		isCheckMessagePw = 0;
		forwardPage = "Wel_More_Result.jsp";
	}else if(bus==WelLot.DOUBLE_FIX_BUY){//双色球定投录入
		saveKey="";//TODO 需要增加购彩流水号，但是接口没有
		txnCod=TransationFactory.WEL485407;
		serverName = "@WEL_A";
		isCheckMessagePw = 1;
		forwardPage = "Wel_Result.jsp";
	}else{
		throw new IllegalArgumentException();
	}

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