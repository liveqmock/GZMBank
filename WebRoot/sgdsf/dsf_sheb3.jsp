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
	pageContext.setAttribute("ACTNO", CrdNo, PageContext.SESSION_SCOPE);
	Map responseValue = new HashMap();
	try{
		 
		 responseValue.putAll(
		Transation.createMapSend(pageContext,"466676","@SGD_A",TransationFactory.SGD466676)
	);
		
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
	String PAYFLG = request.getParameter("PAYFLG").toString();
	String FENLEI = request.getParameter("FENLEI");
	
//	String yewufenlei = request.getParameter("yewufenlei");
//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
//	request.setAttribute("BUSCLA", "05");
 	pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("BUSTYPE", BUSTYPE.substring(0, 2), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("COMPNO", ENTERID.substring(0, 6), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("PAYFLG", PAYFLG, PageContext.SESSION_SCOPE);
 	Map responseValues = new HashMap();
	try{
		 
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466611","@SGD_A",TransationFactory.SGD466611)
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
			
			if(responseValues.get("MsgTyp").equals("N")){
	
    		    gzLog.Write("["+uri+"]forward到"+"");
		
    		    String TXNAMT = responseValues.get("TXNAMT").toString().trim();
    	    	String LOGNO = responseValues.get("LOGNO").toString().trim();
    	    	String CLI_NAME = responseValues.get("MACTXT").toString().trim();
        		
		 %>
		  
		  <label>客户姓名：<%=CLI_NAME %></label>
		  <br/>
		  <label>付款账号：<%=CrdNo %></label>
		  <br/>
		  <label>账号户名：<%=ACCNAM %></label>
          <br/>
          <label>业务种类：<%=BUSTYPE.substring(2).trim() %></label>
		  <br/>
		  <label>缴费标识：<%=PAYFLG %></label>
		  <br/>
		  <label>需缴纳金额：<%=TXNAMT %></label>
		  <br/>
		  <label>交易密码：</label>
    		<input class='input2'  save='yes' isRandomPass='true' type='password' name='password' style="-wap-input-format:  'N';-wap-input-required: 'true'"  maxleng='6' encrypt></input>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<input type='hidden'  name='MBK_VERIFY' value='true' ></input>
		  
		 <input type='hidden' name='AREANUM'  value="<%=AREANUM %>"/>
		<input type='hidden' name='LOGNO'  value='<%=LOGNO %>'/>
		<input type='hidden' name='PAYFLG'  value="<%=PAYFLG %>"/>
		<input type='hidden' name='BUSTYPE'  value="<%=BUSTYPE %>"/>
		<input type='hidden' name='TXNAMT'  value="<%=TXNAMT %>"/>
		<input type='hidden' name='PAYACT'  value="<%=CrdNo %>"/>
		<input type='hidden' name='ACCNAM'  value="<%=ACCNAM %>"/>
		<br/>
		<input type='submit' value='确认缴费'/>
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
