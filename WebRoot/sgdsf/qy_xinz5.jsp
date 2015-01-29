<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>

<%
	String TXNCNL = "6";
	String FUNFLG = "1";//功能选项
	String CLI_CODE_STATUS = "1";
	/*********************************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	Map responseValue = new HashMap();
	try{
		 
		 responseValue.putAll(
		Transation.createMapSend(pageContext,"466676","@SGD_A",TransationFactory.SGD466676)
	);
		////System.out.println("responseValu111es:"+responseValue);
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		//gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}
	String ACCNAM = null;
	if(responseValue.get("MsgTyp").equals("N")){
	    ACCNAM = responseValue.get("ACTNAM").toString().trim();
	}
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	String BUSTYPE = request.getParameter("BUSTYPE");  //手机号码
	String AREANUM = request.getParameter("AREANUM");
	String ENTERID = request.getParameter("ENTERID");
	String BUSCLA = request.getParameter("BUSCLA");
	String PAYFLG = request.getParameter("PAYFLG").toString();
	String FENLEI = request.getParameter("FENLEI");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	String CLI_CODE = request.getParameter("CLI_CODE");
	String CLI_NAME = request.getParameter("CLI_NAME");
	String password = request.getParameter("password");
	
	//System.out.println("BUSTYPE："+request.getParameter("BUSTYPE"));
	//System.out.println("AREANUM："+request.getParameter("AREANUM"));
	//System.out.println("ENTERID："+request.getParameter("ENTERID"));
	//System.out.println("PAYFLG："+request.getParameter("PAYFLG"));
//	String yewufenlei = request.getParameter("yewufenlei");
//	//System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
	pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("FUNFLG", FUNFLG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_CODE", CLI_CODE, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_NAME", CLI_NAME, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("BUSCLA", BUSCLA.substring(0, 2), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("AREANUM", AREANUM.substring(0, 2), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_UNIT_CODE", ENTERID.substring(0, 6), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_TRADE_FLAG", BUSTYPE.substring(0, 2), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_BANK_ACCOUNT", CrdNo, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PIN", password, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_BANK_ACCNAM", ACCNAM, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_TRADE_IDENT", PAYFLG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_CODE_STATUS", CLI_CODE_STATUS, PageContext.SESSION_SCOPE);
 	
 	
 	Map responseValues = new HashMap();
	try{
		 
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466607","@SGD_A",TransationFactory.SGD466607)
	);
		//System.out.println("responseValu111es:"+responseValues);
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
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/qy_xinz5.jsp"%>' >
		<%	
			
			if(responseValues.get("MsgTyp").equals("N")){
		 %>
		    <label>交易成功，谢谢您的使用！</label>
		    <br/>
		    <label>客户姓名：<%=CLI_NAME %></label>
		    <br/>
		    <label>客户证件号：<%=CLI_IDENTITY_CARD %></label>
		    <br/>
		    <label>付款账号：<%=CrdNo %></label>
		    <br/>
    		<label>账号户名：<%=ACCNAM %></label>
    		<br/>
		    <label>企业代码：<%=ENTERID.substring(6).trim() %></label>
		    <br/>
		    <label>业务种类：<%=BUSTYPE.substring(2).trim() %></label>
		    <br/>
		    <label>缴费标识：<%=PAYFLG %></label>

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
