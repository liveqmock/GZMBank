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
	String BUSTYPE = request.getParameter("BUSTYPE");  //手机号码
	String AREANUM = request.getParameter("AREANUM");
	String ENTERID = request.getParameter("ENTERID");
	String BUSCLA = request.getParameter("BUSCLA");
	String PAYFLG = request.getParameter("PAYFLG").toString();
	String FENLEI = request.getParameter("FENLEI");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	
	//System.out.println("BUSTYPE："+request.getParameter("BUSTYPE"));
	//System.out.println("AREANUM："+request.getParameter("AREANUM"));
	//System.out.println("ENTERID："+request.getParameter("ENTERID"));
	//System.out.println("PAYFLG："+request.getParameter("PAYFLG"));
//	String yewufenlei = request.getParameter("yewufenlei");
//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
 	pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD, PageContext.SESSION_SCOPE);
 	
 	Map responseValues = new HashMap();
	try{
		 
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466603","@SGD_A",TransationFactory.SGD466603)
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
			//System.out.println("responseValu ==============="+responseValues.get("RspCod"));
			if(responseValues.get("MsgTyp").equals("N")){
	
    		    gzLog.Write("["+uri+"]forward到"+"");
		
    		    String CLI_CODE = responseValues.get("CLI_CODE2").toString().trim();
    		    String CLI_NAME = responseValues.get("CLI_NAME2").toString().trim();
    	    	
		 %>
		    <label>客户证件号：<%=CLI_IDENTITY_CARD %></label>
		    <br/>
		    <label>客户姓名：<%=CLI_NAME %></label>
		    <br/>
		    <label>付款账号：<%=CrdNo %></label>
		    <br/>
    		<label>账号户名：<%=ACCNAM %></label>
    		<br/>
		    <label>业务分类：<%=FENLEI %></label>
		    <br/>
		    <label>区      域：<%=AREANUM.substring(2).trim() %></label>
		    <br/>
		    <label>收费企业：<%=ENTERID.substring(6).trim() %></label>
		    <br/>
		    <label>业务种类：<%=BUSTYPE.substring(2).trim() %></label>
		    <br/>
		    <label>标识：<%=PAYFLG %></label>
		    <br/>
		    <label>交易密码：</label>
    		<input class='input2'  save='yes' isRandomPass='true' type='password' name='password' style="-wap-input-format:  'N';-wap-input-required: 'true'"  maxleng='6' encrypt></input>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<input type='hidden'  name='MBK_VERIFY' value='true' ></input>
		    
		    
		    <input type='hidden' name='BUSCLA'  value="<%=BUSCLA %>"/>
    		<input type='hidden' name='AREANUM'  value="<%=AREANUM %>"/>
    		<input type='hidden' name='BUSTYPE'  value="<%=BUSTYPE %>"/>
    		<input type='hidden' name='ENTERID'  value="<%=ENTERID %>"/>
    		<input type='hidden' name='CLI_CODE'  value='<%=CLI_CODE %>'/>
    		<input type='hidden' name='CLI_NAME'  value='<%=CLI_NAME %>'/>
    		<input type='hidden' name='PAYFLG'  value="<%=PAYFLG %>"/>
    		<input type='hidden' name='CLI_IDENTITY_CARD'  value='<%=CLI_IDENTITY_CARD %>'/>
    		<br/>
    		<input type='submit' value='确认'/>
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
