<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%
	String TXNCNL = "6";
	/***********************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	String LOGNO = request.getParameter("LOGNO");
	String PAYFLG = request.getParameter("PAYFLG");
	String BUSTYPE = request.getParameter("BUSTYPE");
	String PAYACT = request.getParameter("PAYACT");
	String ACCNAM = request.getParameter("ACCNAM");
	String password = request.getParameter("password");
	//System.out.println("ACCNAM:"+ACCNAM);
	String TXNAMT = request.getParameter("TXNAMT");
	String RSPMSG = null;
	//System.out.print("区域："+request.getParameter("TxnAmt"));
//	String yewufenlei = request.getParameter("yewufenlei");
//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
//	request.setAttribute("BUSCLA", "05");
 	pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PAYTYPE", "02", PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("LOGNO", LOGNO, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PAYFLG", PAYFLG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PAYACT", CrdNo, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PAYNAM", ACCNAM, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PINBLK", password, PageContext.SESSION_SCOPE);
 	Map responseValues = new HashMap();
	try{
		 responseValues.putAll(
				Transation.createMapSend(pageContext,"466612","@SGD_A",TransationFactory.SGD466612)
			);
		
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		//gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}
%>

<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/dsf_sheb4.jsp"%>' >
			
		<%	
			//System.out.println("responseValu ==============="+responseValues.get("RspCod"));
			if(responseValues.get("MsgTyp").equals("N")){
		   
		 %>
		<label>交易成功，谢谢您的使用！</label>
		<br/>
		<label>业务种类：<%=BUSTYPE.substring(2).trim() %></label>
		<br/>
		<label>付款账号：<%=CrdNo %></label>
		<br/>
		<label>缴费标识：<%=PAYFLG %></label>
		<br/>
		<label>金        额：<%=TXNAMT %></label>
		<%
			}else{
			
			%>
				<label><%=responseValues.get("RspMsg") %></label>
			<%
			}
		 %>
		</form>
	</content>
</res>
