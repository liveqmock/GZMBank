<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码

  String TelNum= MessManTool.changeChar(request.getParameter("TelNum")); //充值金额 
	String TxnAmt= MessManTool.changeChar(request.getParameter("TxnAmt"));//
  String PinBlk= MessManTool.changeChar(request.getParameter("password"));//
	gzLog.Write("进入["+uri+"]");

	//设置正常情况需要跳转的页面
	String forwardPage = "ChongZhi_liantong_Result.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";

  String sendContext = "biz_id,33|biz_step_id,2|TXNSRC,MB441|TelNum,"+TelNum+"|CrdNo,"+CrdNo+"|TxnAmt,"+TxnAmt+"|PinBlk,"+PinBlk+"|";
	gzLog.Write("这是联通充值460602=========="+"\n上传的报文组装完毕，内容如下："+sendContext);  
	
	
	//这里开始才会转到网关上啊
	MidServer midServer = new MidServer();

  BwResult bwResult = midServer.sendMessage(sendContext);
	
  String responseContext = bwResult.getContext();

	gzLog.Write("这是联通充值=====460602"+"\n服务器下行返回的报文内容："+responseContext);



	//检查返回是否异常
	String MGID = MessManTool.getValueByName(responseContext, "MGID");	
	
	if("000000".equals(MGID)){//如果返回正确
		gzLog.Write("["+uri+"]forward到"+forwardPage);
    String saveKey="TckNo";
		String[] saveKeys = saveKey.split(",");
		StringBuffer forwardString = new StringBuffer();
		forwardString.append(forwardPage).append("?");
		for(int index=0; index<saveKeys.length; index++){
			forwardString.append(saveKeys[index]).append("=").append(MessManTool.getValueByName(responseContext, saveKeys[index]));
			if(index<saveKeys.length-1){//如果还有值的话需要添加&做间隔
				forwardString.append("&");
			}
		}
	    pageContext.forward(forwardString.toString());

	}else{//如果返回不正确
		String RspCod = MessManTool.getValueByName(responseContext, "RspCod");
		String RspMsg = MessManTool.getValueByName(responseContext, "RspMsg"); 
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

%>