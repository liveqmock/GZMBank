<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.gdbocom.util.communication.*"%>
<%@ page import="com.viatt.util.GzLog"%>
<%@ page import="java.util.Map"%>
<%@ page import="com.gdbocom.util.format.*"%>

<%
	//System.out.println("==============================");
	request.setCharacterEncoding("UTF-8");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
	String sjNo = request.getHeader("MBK_MOBILE"); //手机号码
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	String radio = request.getParameter("mingxi");
	
	int a = Integer.parseInt(radio);
	String list = request.getParameter("list");
	//System.out.println("list:"+list);
	
	String CLI_UNIT_CODE = "";
	String CLI_TRADE_FLAG = "";
	String CLI_TRADE_IDENT = "";
	if((a+1)*23>=list.length()){
	    CLI_UNIT_CODE = list.substring(a*23, 6+a*23);
    	//System.out.println("==============6================");
    	CLI_TRADE_FLAG = list.substring(6+a*23, 8+a*23);
    	//System.out.println("==============7================");
    	CLI_TRADE_IDENT = list.substring(8+a*23).trim();
    	//System.out.println("==============8================");
	}else{
	    CLI_UNIT_CODE = list.substring(a*23, 6+a*23);
    	//System.out.println("CLI_UNIT_CODE："+CLI_UNIT_CODE);
    	CLI_TRADE_FLAG = list.substring(6+a*23, 8+a*23);
    	//System.out.println("CLI_TRADE_FLAG:"+CLI_TRADE_FLAG);
    	CLI_TRADE_IDENT = list.substring(8+a*23, 23+a*23).trim();
    	//System.out.println("CLI_TRADE_IDENT:"+CLI_TRADE_IDENT);
	}
	
	
	//System.out.println("CLI_UNIT_CODE:"+CLI_UNIT_CODE);
	//System.out.println("CLI_TRADE_FLAG:"+CLI_TRADE_FLAG);
	//System.out.println("CLI_TRADE_IDENT:"+CLI_TRADE_IDENT);
	
	gzLog.Write("进入[" + uri + "]");

	String errPage = "";
	pageContext.setAttribute("CLI_UNIT_CODE", CLI_UNIT_CODE,
	PageContext.SESSION_SCOPE);
	pageContext.setAttribute("CLI_TRADE_FLAG", CLI_TRADE_FLAG,
	PageContext.SESSION_SCOPE);
	pageContext.setAttribute("CLI_TRADE_IDENT", CLI_TRADE_IDENT,
	PageContext.SESSION_SCOPE);
	Map responseValues = new HashMap();
	try {
		responseValues.putAll(Transation.createMapSend(pageContext,
		"466675", "@SGD_A", TransationFactory.SGD466675));
		//System.out.println("responseValu111es:" + responseValues);
	} catch (Exception e) {
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
    <form method='post'
	action='<%=request.getContextPath() + "/sgdsf/qy_4.jsp"%>'>

		<br/>	
		<%	
			if(responseValues.get("MsgTyp").equals("N")){
			String CLI_CODE = responseValues.get("CLI_CODE").toString();
			String CLI_NAME = responseValues.get("CLI_NAME").toString();
			String BUSCLA = responseValues.get("BUSCLA").toString();
			String AREACOD = responseValues.get("AREACOD").toString();
			
			String CLI_BANK_ACCOUNT = responseValues.get("CLI_BANK_ACCOUNT").toString();
			String CLI_BANK_ACCNAM = responseValues.get("CLI_BANK_ACCNAM").toString();
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
			//String CLI_CODE_STATUS = responseValues.get("CLI_CODE_STATUS").toString();
		
		 %>
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
		<label>缴费标示: </label>
		<input type="text" name="CLI_TRADE_IDENT" maxlength="15" value="<%=CLI_TRADE_IDENT %>" style="-wap-input-format: 'Y'; -wap-input-required: 'true'" />
		<br/>
		<table>
		 <tr>
		    <td><label>明细状态：</label></td>
		    <td><select name="CLI_CODE_STATUS"  >
		        <option value="1">正常</option>
		        <option value="2">暂停</option>
		        <option value="3">销户</option>
		    </select>
		    </td>
		 </tr>
		 </table>
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
		<br/>
		<input type='submit' value='确认' />
		<%
			}else{
			
			%>
			
				<label><%=responseValues.get("RspMsg") %></label>
			<%
			}
		 %>
</form>
</content> </res>