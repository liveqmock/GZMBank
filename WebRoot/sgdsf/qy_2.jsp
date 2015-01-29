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
	String CLI_IDENTITY_CARD = request
			.getParameter("CLI_IDENTITY_CARD");
	//	String yewufenlei = request.getParameter("yewufenlei");
	//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入[" + uri + "]");

	String errPage = "";
	String list1="";
	pageContext.setAttribute("CLI_IDENTITY_CARD", CLI_IDENTITY_CARD,
			PageContext.SESSION_SCOPE);
	Map responseValue = new HashMap();
	try {
		responseValue.putAll(Transation.createMapSend(pageContext,
				"466603", "@SGD_A", TransationFactory.SGD466603));
		//System.out.println("responseValues:" + responseValue);
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
	action='<%=request.getContextPath() + "/sgdsf/qy_3.jsp"%>'>

	<%
		
		if (responseValue.get("MsgTyp").equals("N")) {
			pageContext.setAttribute("CLI_CODE",
					responseValue.get("CLI_CODE2"),
					PageContext.SESSION_SCOPE);
			Map responseValues = new HashMap();
			try {
				responseValues.putAll(Transation.createMapSend(pageContext,
						"466604", "@SGD_A", TransationFactory.SGD466604));
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

			if (responseValues.get("MsgTyp").equals("N")) {
	%>
	<table>
			<tr>
			    <td><label></label></td>
				<td><label>企业代码</label></td>
				<td><label>业务种类</label></td>
				<td><label>缴费标识</label></td>
		 </tr>
	</table>
	<table>
		
			<%
				List loopBody = (List) responseValues.get("LoopBody");
						String keyOrder[] = new String[] { "CLI_UNIT_CODE",
								"CLI_TRADE_FLAG", "CLI_TRADE_IDENT" };
						//设置需要显示的值的类型
						Map keyType = new HashMap();
						//设置循环体需要显示的值和名称,
						Map loopShowKey = new HashMap();
						keyType.put("BetLin",
								WelFormatter.getSingleton(WelFormatter.BETNUM));
						for (int recordIndex = 0; recordIndex < loopBody.size(); recordIndex++) {
							Map oneRecord = (Map) loopBody.get(recordIndex);
							//                    if(oneRecord.get("").toString().equals("")){

							//                   }
			%>
		
		<tr align="left" >
			<td align="left" ><input type="radio" name="mingxi" maxlength="3" value="<%=recordIndex %>"/>
			</td>
			<%
				for (int keyIndex = 0; keyIndex < keyOrder.length; keyIndex++) {

						String key = keyOrder[keyIndex];
								
						FormatterInterface type = (FormatterInterface) keyType
								.get(key);
								//为格式化的值
						
						String originValue = (String) oneRecord.get(key);
						list1 = list1+originValue;
						if(key.equals("CLI_TRADE_FLAG")){
						   if(originValue.equals("24")){
						      originValue = "仁化伟达服务";
						   }else if(originValue.equals("26")){
						      originValue = "物业";
						   }else if(originValue.equals("51")){
						      originValue = "联通";
						   }else if(originValue.equals("61")){
						      originValue = "电信/铁通";
						   }else if(originValue.equals("63")){
						      originValue = "燃气";
						   }else if(originValue.equals("65")){
						      originValue = "水费";
						   }else if(originValue.equals("66")){
						      originValue = "卫生";
						   }else if(originValue.equals("67")){
						      originValue = "垃圾";
						   }else if(originValue.equals("68")){
						      originValue = "电";
						   }else if(originValue.equals("70")){
						      originValue = "电视";
						   }else if(originValue.equals("81")){
						      originValue = "税务";
						   }else if(originValue.equals("85")){
						      originValue = "社保";
						   }else if(originValue.equals("90")){
						      originValue = "养老保险";
						   }
						}
						
			%>
			<td align="left" ><label><%=originValue.trim()%></label></td>
		 <%
		 	}
		 %></tr>
		<%
			}
		%>
	</table>
	<input type="hidden" name="CLI_IDENTITY_CARD" value="<%=CLI_IDENTITY_CARD %>"/>
	<input type="hidden" name="list" value="<%=list1 %>"/>
    <input type='submit' value='修改' />
	<%
		} else {
	%>
	<label><%=responseValues.get("RspMsg")%></label>
	<%
		}
		} else {
	%>
	<label><%=responseValue.get("RspMsg")%></label>
	<%
		}
	%>
    </form>
</content>
</res>