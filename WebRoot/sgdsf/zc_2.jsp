<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.*" %>
<!-- 分行特色业务频道列表 -->
<%
	String CLISTATUS = "1";
	String TXNCNL = "6";
	/*******************************/
	request.setCharacterEncoding("UTF-8");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	String GNXX = request.getParameter("GNXX");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	
	if(CLI_IDENTITY_CARD == null || CLI_IDENTITY_CARD == ""){
	  String MsgTy = "客户证件号";
	  String errPages = request.getContextPath() + "/sgdsf/pagenull.jsp";
	  StringBuffer forwardStrings = new StringBuffer();
      forwardStrings.append(errPages).append("?");
      forwardStrings.append("MsgTy=").append(MsgTy);
      pageContext.forward(forwardStrings.toString());
	}
	gzLog.Write("进入["+uri+"]");
	String errPage = "";
 %>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/zc_3.jsp"%>' >
       <%
       if(GNXX.equals("0")){
        %>
        <table>
            <tr>
            <td><label>客户姓名: </label></td>
			<td><input type="text" name="CLI_NAME" maxlength="60" style="-wap-input-format: 'Y'; -wap-input-required: 'true'" /></td>
    		</tr>
    		<tr>
    		<td><label>客户性别：</label></td>
    		<td><select name="CLI_SEX">
    		   <option value="0">女</option>
    		   <option value="1">男</option>
    		</select></td>
    		</tr>
    		<tr>
    		<td><label>客户年龄：</label></td>
    		<td><input type="text" name="CLI_AGE" maxlength="3" style="-wap-input-format: 'N'; -wap-input-required: 'true'" /></td>
    		</tr>
    		<tr>
    		<td><label>联系电话：</label></td>
    		<td><input type="text" name="CLI_HOME_TELEPHONE"  style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxlength="3"/></td>
    		</tr>
    		<tr>
    		<td><label>E_mail：</label></td>
    		<td><input type="text" name="CLI_EMAIL" /></td>
    		</tr>
    		<tr>
    		<td><label>备注：</label></td>
    		<td><input type="text" name="CLI_MENO"  /></td>
    		</tr>

    		</table>
    		<br/>
    		<input type="hidden" name="FUNFLG" value="<%=GNXX %>" />
    		<input type="hidden" name="CLI_STATUS" value="<%=CLISTATUS %>" />
    		<input type="hidden" name="CLI_IDENTITY_CARD" value="<%=CLI_IDENTITY_CARD %>" />
    		
    		<input type='submit' value='确认'/>
    		
		<%
    					}else{ 
    						    pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
    						    pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD, PageContext.SESSION_SCOPE);
    				        	Map responseValues = new HashMap();
    				        	try{
    				        		 responseValues.putAll(
    				    				Transation.createMapSend(pageContext,"466602","@SGD_A",TransationFactory.SGD466602)
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
    					if(responseValues.get("MsgTyp").equals("N")){
    					   String CLI_NAME = responseValues.get("CLI_NAME").toString().trim();
    					   String CLI_SEX = responseValues.get("CLI_SEX").toString();
    					   String CLI_AGE = responseValues.get("CLI_AGE").toString();
    					   String CLI_EMAIL = responseValues.get("CLI_EMAIL").toString().trim();
    					   String CLI_LEVEL = responseValues.get("CLI_LEVEL").toString().trim();
    					   String CLI_STATUS = responseValues.get("CLI_STATUS").toString().trim();
    					   String CLI_HOME_ADDRESS = responseValues.get("CLI_HOME_ADDRESS").toString().trim();
    					   String CLI_HOME_TELEPHONE = responseValues.get("CLI_HOME_TELEPHONE").toString().trim();
    					   String CLI_HOME_POST = responseValues.get("CLI_HOME_POST").toString().trim();
    					   String CLI_HOMEPAGE = responseValues.get("CLI_HOMEPAGE").toString().trim();
    					   String CLI_UNIT_NAME = responseValues.get("CLI_UNIT_NAME").toString().trim();
    					   String CLI_UNIT_ADRESS = responseValues.get("CLI_UNIT_ADRESS").toString().trim();
    					   String CLI_UNIT_TELEPHONE = responseValues.get("CLI_UNIT_TELEPHONE").toString().trim();
    					   String CLI_UNIT_POST = responseValues.get("CLI_UNIT_POST").toString().trim();
    					   String CLI_MARROW_UNIT_NAME = responseValues.get("CLI_MARROW_UNIT_NAME").toString().trim();
    					   String CLI_MARROW_NAME = responseValues.get("CLI_MARROW_NAME").toString().trim();
    					   String CLI_MARROW_UNIT_ADDRESS = responseValues.get("CLI_MARROW_UNIT_ADDRESS").toString().trim();
    					   String CLI_MARROW_UNIT_TELEPHONE = responseValues.get("CLI_MARROW_UNIT_TELEPHONE").toString().trim();
    					   String CLI_MARROW_UNIT_POST = responseValues.get("CLI_MARROW_UNIT_POST").toString().trim();
    					   String CLI_MENO = responseValues.get("CLI_MENO").toString().trim();
    					   String SEX = null;
    					   if(CLI_SEX.equals("0")){
    					      SEX = "女";
    					   }else if(CLI_SEX.equals("1")){
    					      SEX = "男";
    					   }
    					   if(CLI_EMAIL.trim().equals("guangzhou@126.com")){
    					      CLI_EMAIL="";
    					   }
    					   if(CLI_MENO.trim().equals("无")){
    					      CLI_MENO="";
    					   }
    					   String statu = null;
    					   if(CLI_STATUS.equals("1")){
    					      statu = "正常";
    					   }else if(CLI_STATUS.equals("2")){
    					      statu = "暂停";
    					   }else if(CLI_STATUS.equals("3")){
    					      statu = "销户";
    					   }
    					   
    				     		if(GNXX.equals("1")){
    				%>
    		<table>
    		<tr>
    		<td><label>客户姓名: </label></td>
			<td><input type="text" name="CLI_NAME" value='<%=CLI_NAME %>' maxlength="60" style="-wap-input-format: 'Y'; -wap-input-required: 'true'" />
			</td>
    		</tr>
    		<tr>
    		<td><label>客户年龄：</label></td>
    		<td><input type="text" name="CLI_AGE" value='<%=CLI_AGE %>' maxlength="3" style="-wap-input-format: 'N'; -wap-input-required: 'true'" />
    		</td>
    		</tr>
    		<tr>
    		<td><label>联系电话：</label></td>
    		<td><input type="text" name="CLI_HOME_TELEPHONE"  value='<%=CLI_HOME_TELEPHONE %>' maxlength="3" style="-wap-input-format: 'N'; -wap-input-required: 'true'" />
    		</td>
    		</tr>
    		<tr>
    		<td><label>E_mail：</label></td>
    		<td><input type="text" name="CLI_EMAIL" value='<%=CLI_EMAIL %>'/></td>
    		</tr>
    		<tr>
    		<td><label>备注：</label></td>
    		<td><input type="text" name="CLI_MENO" value='<%=CLI_MENO %>' /></td>
    		</tr>
    		</table>
    		<input type="hidden" name="CLI_STATUS" value="<%=CLI_STATUS %>" />
    		<input type="hidden" name="CLI_SEX" value="<%=CLI_SEX %>" />
    		
    		<input type="hidden" name="FUNFLG" value="<%=GNXX %>" />
    		<input type="hidden" name="CLI_IDENTITY_CARD" value="<%=CLI_IDENTITY_CARD %>" />
    		
    		<input type='submit' value='确认'/>
    		
    		<%}else if(GNXX.equals("2")){ %>
    		
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
    		<label>备注：<%=CLI_MENO %></label>
    		<br/>
    		<table>
    		<tr>
    		<td><label>明细状态：</label></td>
    		<td><select name="CLI_STATUS">
    		    <option value="1">正常</option>
    		    <option value="2">暂停</option>
    		    <option value="3">销户</option>
    		</select></td>
    		</tr>
    		</table>
    		<input type="hidden" name="CLI_NAME" value="<%=CLI_NAME %>" />
    		<input type="hidden" name="CLI_SEX" value="<%=CLI_SEX %>" />
    		<input type="hidden" name="CLI_AGE" value="<%=CLI_AGE %>" />
    		<input type="hidden" name="CLI_HOME_TELEPHONE" value="<%=CLI_HOME_TELEPHONE %>" />
    		<input type="hidden" name="CLI_EMAIL" value="<%=CLI_EMAIL %>" />
    		<input type="hidden" name="CLI_MENO" value="<%=CLI_MENO %>" />
    		
    		<input type="hidden" name="FUNFLG" value="<%=GNXX %>" />
    		<input type="hidden" name="CLI_IDENTITY_CARD" value="<%=CLI_IDENTITY_CARD %>" />
    		
    		<input type='submit' value='确认'/>
    		<%}else if(GNXX.equals("3")){ %>
    		
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
    		<label>备      注：<%=CLI_MENO %></label>
    		<br/>
    		<label>客户状态：<%=statu %></label>
    		
    		<input type="hidden" name="CLI_STATUS" value="<%=CLI_STATUS %>" />
    		<input type="hidden" name="CLI_NAME" value="<%=CLI_NAME %>" />
    		<input type="hidden" name="CLI_SEX" value="<%=CLI_SEX %>" />
    		<input type="hidden" name="CLI_AGE" value="<%=CLI_AGE %>" />
    		<input type="hidden" name="CLI_HOME_TELEPHONE" value="<%=CLI_HOME_TELEPHONE %>" />
    		<input type="hidden" name="CLI_EMAIL" value="<%=CLI_EMAIL %>" />
    		<input type="hidden" name="CLI_MENO" value="<%=CLI_MENO %>" />
    		<%} %>
    		
    		
    		
    	<%
    	}else{ 
    	%>
    	<label><%=responseValues.get("RspMsg") %></label>
    	<%} %>
    	
    <%} %>
    		
    		
		
		</form>
	</content>
</res>
