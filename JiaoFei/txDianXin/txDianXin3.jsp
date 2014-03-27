<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>

<%
  GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	
	String PhoneNum = MessManTool.changeChar(request.getParameter("PhoneNum"));//服务号码
	String BusTyp   = MessManTool.changeChar(request.getParameter("BusTyp"));  //业务种类 

	String biz_id = "0";
	if (BusTyp.equals("Phonepay")){
	  biz_id = "1";
	} else if (BusTyp.equals("XLTpay")) {
	  biz_id = "2";
	} else if (BusTyp.equals("CDMApay")) {
	  biz_id = "22";
	} else if (BusTyp.equals("CDMAprepay")) {
	  biz_id = "23";
	}
	
	String sendContext = "biz_id,"+biz_id+"|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|PSWD,******|CTSQ,"+PhoneNum+"|";
	//System.out.println("====="+sendContext);
	
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	String message = "";	
	
	bwResult = midServer.sendMessage(sendContext);
	message  = bwResult.getContext();
	 gzLog.Write("电信缴费查询"+"\n接收报文为："+message);
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
	    String AMT1  = MessManTool.getValueByName(message, "AMT1");
	    String CusNm = MessManTool.getValueByName(message, "CusNm");
%>
	<label>
		查询成功
	</label>
	<br/>
	<form method='post' action='/GZMBank/JiaoFei/txDianXin/txDianXin4.jsp'> 
	<%
		String display_zone = MessManTool.getValueByName(message, "display_zone");
		String tmp3[] = display_zone.split("<br>");
		for(int i=0;i<tmp3.length;i++){
			String tmp5=tmp3[i].trim();
	%>
		<label><%=tmp5%></label>
			<br/>
	<%
		}
		if (BusTyp.equals("CDMAprepay") || BusTyp.equals("XLTpay"))  {
	%>
        <table border="1">
			<tr>
				<td> 选择 </td>
				<td> 充值金额</td>
			</tr>

			<tr>
				<td><input type="radio" value="pay50" name="PayTyp"/></td>
				<td>50元</td>
			</tr>

			<tr>
				<td><input type="radio" value="pay100" name="PayTyp"/></td>
				<td>100元</td>
			</tr>

			<tr>
				<td><input type="radio" value="pay150" name="PayTyp"/></td>
				<td>150元</td>
			</tr>

			<tr>
				<td><input type="radio" value="pay200" name="PayTyp"/></td>
				<td>200元</td>
			</tr>

		</table>	
	<%
	    }
	%>
		<label>
			请输入交易密码:
		</label>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
		<input type='hidden'  name='MBK_VERIFY' value='true'></input>
		<input type='hidden' name='PhoneNum' value='<%=PhoneNum%>'></input>
		<input type='hidden' name='BusTyp'   value='<%=BusTyp%>'></input>
		<input type='hidden' name='CusNm'    value='<%=CusNm%>'></input>
		<input type='hidden' name='AMT1'     value='<%=AMT1%>'></input>
		<input type="submit" value="确定"></input>
	</form> 
<%
	} else {
%> 
	<%
		String display_zone = MessManTool.getValueByName(message, "display_zone");
		String tmp3[] = display_zone.split("<br>");
		for(int i=1;i<tmp3.length;i++){
			String tmp5=tmp3[i].trim();
	%>
		<label><%=tmp5%></label>
			<br/>
	<%
		}
	}
%>
</content>
</res> 