<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>

<%
	
	String FUNFLG = "2";//功能选项
	
	/*********************************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	pageContext.setAttribute("ACTNO", CrdNo, PageContext.SESSION_SCOPE);
	String CLI_UNIT_CODE = request.getParameter("CLI_UNIT_CODE");
	String CLI_TRADE_FLAG = request.getParameter("CLI_TRADE_FLAG");
	String AREACOD = request.getParameter("AREACOD");
	String BUSCLA = request.getParameter("BUSCLA");
	String CLI_CODE = request.getParameter("CLI_CODE");
	String CLI_NAME = request.getParameter("CLI_NAME");
	String CLI_BANK_ACCOUNT = request.getParameter("CLI_BANK_ACCOUNT");
	String CLI_BANK_ACCNAM = request.getParameter("CLI_BANK_ACCNAM");
	String CLI_TRADE_IDENT = request.getParameter("CLI_TRADE_IDENT");
	String CLI_CODE_STATUS = request.getParameter("CLI_CODE_STATUS");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	String STATUS = "";
	String FLAG = null;
			if(CLI_TRADE_FLAG.equals("24")){
						      FLAG = "仁化伟达服务";
						   }else if(CLI_TRADE_FLAG.equals("26")){
						      FLAG = "南枫物业";
						   }else if(CLI_TRADE_FLAG.equals("51")){
						      FLAG = "联通";
						   }else if(CLI_TRADE_FLAG.equals("61")){
						      FLAG = "电信/铁通";
						   }else if(CLI_TRADE_FLAG.equals("63")){
						      FLAG = "燃气";
						   }else if(CLI_TRADE_FLAG.equals("65")){
						      FLAG = "水费";
						   }else if(CLI_TRADE_FLAG.equals("66")){
						      FLAG = "卫生";
						   }else if(CLI_TRADE_FLAG.equals("67")){
						      FLAG = "垃圾";
						   }else if(CLI_TRADE_FLAG.equals("68")){
						      FLAG = "电";
						   }else if(CLI_TRADE_FLAG.equals("70")){
						      FLAG = "电视";
						   }else if(CLI_TRADE_FLAG.equals("81")){
						      FLAG = "税务";
						   }else if(CLI_TRADE_FLAG.equals("85")){
						      FLAG = "社保";
						   }else if(CLI_TRADE_FLAG.equals("90")){
						      FLAG = "养老保险";
						   }
	if(CLI_CODE_STATUS.equals("1")){
	    STATUS = "正常";
	}else if(CLI_CODE_STATUS.equals("2")){
	    STATUS = "暂停";
	}else if(CLI_CODE_STATUS.equals("3")){
	    STATUS = "销户";
	}
	
%>
<res>
	<content>
     <form method='post'
	action='<%=request.getContextPath() + "/sgdsf/qy_5.jsp"%>'>
		<label>客户姓名：<%=CLI_NAME %></label>
		<br/>
		<label>客户证件号：<%=CLI_IDENTITY_CARD %></label>
		<br/>
		<label>签约账号：<%=CLI_BANK_ACCOUNT %></label>
		<br/>
		<label>签约户名：<%=CLI_BANK_ACCNAM %></label>
		<br/>
		<label>业务种类：<%=FLAG %></label>
		<br/>
		<label>收款企业代码：<%=CLI_UNIT_CODE %></label>
		<br/>
		<label>缴费标识：<%=CLI_TRADE_IDENT %></label>
		<br/>
		<label>客户明细状态：<%=STATUS %></label>
		<input type='hidden' name='CLI_UNIT_CODE'  value='<%=CLI_UNIT_CODE %>'/>
		<input type='hidden' name='CLI_TRADE_FLAG'  value='<%=CLI_TRADE_FLAG %>'/>
		<input type='hidden' name='AREACOD'  value='<%=AREACOD %>'/>
		<input type='hidden' name='BUSCLA'  value='<%=BUSCLA %>'/>
		
		<input type='hidden' name='CLI_CODE' value='<%=CLI_CODE %>'/>
		<input type='hidden' name='CLI_NAME' value='<%=CLI_NAME %>'/>
		<input type='hidden' name='CLI_BANK_ACCOUNT'  value='<%=CLI_BANK_ACCOUNT %>'/>
		<input type='hidden' name='CLI_BANK_ACCNAM'  value='<%=CLI_BANK_ACCNAM %>'/>
		<input type='hidden' name='CLI_TRADE_FLAG'  value='<%=CLI_TRADE_FLAG %>'/>
		<input type='hidden' name='CLI_IDENTITY_CARD'  value='<%=CLI_IDENTITY_CARD %>'/>
		<input type='hidden' name='CLI_TRADE_IDENT'  value='<%=CLI_TRADE_IDENT %>'/>
		<input type='hidden' name='CLI_CODE_STATUS'  value='<%=CLI_CODE_STATUS %>'/>
		<br/>
		<input type='submit' value='确认' />
		
		</form>
	</content>
</res>
