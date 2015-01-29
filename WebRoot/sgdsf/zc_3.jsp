<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>
<%
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String GNXX = request.getParameter("GNXX");
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
	String SEX = null;
	if(CLI_SEX.equals("0")){
	   SEX="女";
	}else if(CLI_SEX.equals("1")){
	   SEX="男";
	}
	String STATUS = null;
	if(CLI_STATUS.equals("1")){
	   STATUS="正常";
	}else if(CLI_STATUS.equals("2")){
	   STATUS="暂停";
	}else if(CLI_STATUS.equals("3")){
	   STATUS="销户";
	}
%>

<res>
	<content>
	<form method='post' action='<%=request.getContextPath() + "/sgdsf/zc_4.jsp"%>' >
		    <label>客户姓名: <%=CLI_NAME %></label>
			<br/>
			<label>客户性别: <%=SEX %></label>
			<br/>
    		<label>客户年龄：<%=CLI_AGE %></label>
    		<br/>
    		<label>联系电话：<%=CLI_HOME_TELEPHONE %></label>
    		<br/>
    		<label>E_mail：<%=CLI_EMAIL %></label>
    		<br/>
    		<label>备    注：<%=CLI_MENO %></label>
    		<br/>
    		<label>明细状态：<%=STATUS %></label>
    		
    		<input type="hidden" name="CLI_STATUS" value="<%=CLI_STATUS %>" />
    		<input type="hidden" name="CLI_NAME" value="<%=CLI_NAME %>" />
    		<input type="hidden" name="CLI_SEX" value="<%=CLI_SEX %>" />
    		<input type="hidden" name="CLI_AGE" value="<%=CLI_AGE %>" />
    		<input type="hidden" name="CLI_HOME_TELEPHONE" value="<%=CLI_HOME_TELEPHONE %>" />
    		<input type="hidden" name="CLI_EMAIL" value="<%=CLI_EMAIL %>" />
    		<input type="hidden" name="CLI_MENO" value="<%=CLI_MENO %>" />
    		
    		<input type="hidden" name="FUNFLG" value="<%=FUNFLG %>" />
    		<input type="hidden" name="CLI_IDENTITY_CARD" value="<%=CLI_IDENTITY_CARD %>" />
    		
    		<input type="submit" value="确认"/>
    		</form>
	</content>
</res>
