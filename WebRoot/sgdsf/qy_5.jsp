<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>

<%
	
	String FUNFLG = "2";//功能选项
	String TXNCNL = "6";
	/*********************************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	pageContext.setAttribute("ACTNO", CrdNo, PageContext.SESSION_SCOPE);
	Map responseValue = new HashMap();
	try{
		 
		 responseValue.putAll(
				Transation.createMapSend(pageContext,"466676","@SGD_A",TransationFactory.SGD466676)
			);
		//System.out.println("responseValu111es:"+responseValue);
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
	String CLI_TRADE_FLAG = request.getParameter("CLI_TRADE_FLAG");  //手机号码
	String AREACOD = request.getParameter("AREACOD");
	String CLI_UNIT_CODE = request.getParameter("CLI_UNIT_CODE");
	String BUSCLA = request.getParameter("BUSCLA");
	String CLI_TRADE_IDENT = request.getParameter("CLI_TRADE_IDENT").toString();
	String FENLEI = request.getParameter("FENLEI");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	String CLI_CODE = request.getParameter("CLI_CODE");
	String CLI_NAME = request.getParameter("CLI_NAME");
	
	String CLI_CODE_STATUS = request.getParameter("CLI_CODE_STATUS");
	
	//System.out.println("CLI_TRADE_FLAG："+request.getParameter("BUSTYPE"));
	//System.out.println("AREACOD："+request.getParameter("AREACOD"));
	//System.out.println("CLI_UNIT_CODE："+request.getParameter("CLI_UNIT_CODE"));
	//System.out.println("BUSCLA："+request.getParameter("BUSCLA"));
	//System.out.println("CLI_TRADE_IDENT："+request.getParameter("CLI_TRADE_IDENT"));
	//System.out.println("FENLEI："+request.getParameter("FENLEI"));
	//System.out.println("CLI_IDENTITY_CARD："+request.getParameter("CLI_IDENTITY_CARD"));
	//System.out.println("CLI_CODE："+request.getParameter("CLI_CODE"));
	//System.out.println("CLI_NAME："+request.getParameter("CLI_NAME"));
	//System.out.println("CLI_CODE_STATUS："+request.getParameter("CLI_CODE_STATUS"));
//	String yewufenlei = request.getParameter("yewufenlei");
//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
	pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("FUNFLG", FUNFLG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_CODE", CLI_CODE, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_NAME", CLI_NAME, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("BUSCLA", BUSCLA, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("AREANUM", AREACOD, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_UNIT_CODE", CLI_UNIT_CODE, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_TRADE_FLAG", CLI_TRADE_FLAG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_BANK_ACCOUNT", CrdNo, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PIN", "7EB3FE2C1A278F18", PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_BANK_ACCNAM", ACCNAM, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_TRADE_IDENT", CLI_TRADE_IDENT, PageContext.SESSION_SCOPE);
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
      <form method='post' action='<%=request.getContextPath() + "/sgdsf/dsf_sheb4.jsp"%>' >
		<%	
			
			if(responseValues.get("MsgTyp").equals("N")){
		 %>
		    <label>交易成功</label>

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
