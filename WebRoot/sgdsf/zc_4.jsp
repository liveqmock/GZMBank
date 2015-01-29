<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%
	String TXNCNL = "6";
	/**********************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	
	String FUNFLG = request.getParameter("FUNFLG");
	//System.out.println("FUNFLG:"+FUNFLG);
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	//System.out.println("CLI_IDENTITY_CARD:"+CLI_IDENTITY_CARD);
	String CLI_NAME = request.getParameter("CLI_NAME").toString().trim();
	//System.out.println("CLI_NAME:"+CLI_NAME);
	String CLI_SEX = request.getParameter("CLI_SEX").toString();
	//System.out.println("CLI_SEX:"+CLI_SEX);
	String CLI_AGE = request.getParameter("CLI_AGE").toString();
	//System.out.println("CLI_AGE:"+CLI_AGE);
	String CLI_EMAIL = request.getParameter("CLI_EMAIL").toString().trim();
	//System.out.println("CLI_EMAIL:"+CLI_EMAIL);
	String CLI_MENO = request.getParameter("CLI_MENO").toString().trim();
	
	String CLI_HOME_TELEPHONE = request.getParameter("CLI_HOME_TELEPHONE").toString().trim();
	
	String CLI_STATUS = request.getParameter("CLI_STATUS").toString().trim();
	
	
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
//	request.setAttribute("BUSCLA", "05");
pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
    pageContext.setAttribute("CLI_STATUS", CLI_STATUS, PageContext.SESSION_SCOPE);
    pageContext.setAttribute("CLI_MENO", CLI_MENO, PageContext.SESSION_SCOPE);
    pageContext.setAttribute("CLI_HOME_TELEPHONE", CLI_HOME_TELEPHONE, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("TXNCNL", "6", PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("FUNFLG", FUNFLG, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_TYPE", "01", PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_NAME", CLI_NAME, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_SEX", CLI_SEX, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_AGE", CLI_AGE, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("CLI_EMAIL", CLI_EMAIL, PageContext.SESSION_SCOPE);
 	
 	Map responseValues = new HashMap();
	try{
		 responseValues.putAll(
				Transation.createMapSend(pageContext,"466601","@SGD_A",TransationFactory.SGD466601)
			);
		
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		//gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
//		forwardString.append(errPage).append("?");
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
		<label>交易成功，谢谢您的使用！</label>
		<%
			}else{
			if(responseValues.get("RspMsg").equals("增加用户失败")){
			%>
				<label>该用户已注册</label>
			<%
			}else{
		 %>
		 <label><%=responseValues.get("RspMsg") %></label>
		 <%
			}
		}
		 %>
		 </form>
	</content>
</res>
