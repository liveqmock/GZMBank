<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>

<%
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
	//固话缴费
	//message = "bocom_mid|biz_id,1|biz_no,00001|biz_step_id,1|display_zone,电话号码： 38866360                        <br>客户姓名： 陈**锋                                                        <br>缴费金额： 6.02  <br><br>温馨提示： 确认缴费提交后，将无法退款，请仔细核对您的缴费信息!<br>|MGID,000000|AMT1,000000000000602|CTSQ,38866360                      |passWord,######|CusNm,陈俊锋                                                      |";
	//小灵通预缴费
	//message = "bocom_mid|biz_id,2|biz_no,00002|biz_step_id,1|display_zone,电话号码： 85891621                        <br>客户姓名： 预**费小灵通充值                                              <br>话费余额： 0.12  <br>温馨提示： 确认缴费提交后，将无法退款，请仔细核对您的缴费信息!<br>|MGID,000000|AMT1,000000000000012|CTSQ,85891621                      |passWord,######|CusNm,预付费小灵通充值                                            |";
	//CDMA缴费
	//message = "bocom_mid|biz_id,22|biz_no,00022|biz_step_id,1|display_zone,<font color=ff0000>--->交易失败</font><br>--->失败原因：[482199] [该电话号码无欠费记录                                    ] <br>|MGID,482199|";
	//CDMA预缴费
	//message = "bocom_mid|biz_id,23|biz_no,00023|biz_step_id,1|display_zone,电话号码： 13310891077                     <br>客户姓名： 吴**利                                                        <br>话费余额： 182.22  <br>温馨提示： 确认缴费提交后，将无法退款，请仔细核对您的缴费信息!<br>|MGID,000000|AMT1,000000000018222|CTSQ,13310891077                   |passWord,######|CusNm,吴胜利                                                      |";
	String MGID = MessManTool.getValueByName(message, "MGID");
	if ("000000".equals(MGID)) {
	    String AMT1  = MessManTool.getValueByName(message, "AMT1");
	    String CusNm = MessManTool.getValueByName(message, "CusNm");
%>
	<label>
		查询成功
	</label>
	<br/>
	<form method='post' action='/GZMBank/txDianXin/txDianXin4.jsp'> 
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
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		<!-- 
		<input type='hidden'  name='MBK_VERIFY' value=' true'></input>
		-->
		<input type='hidden' name='PhoneNum' value='<%=PhoneNum%>'></input>
		<input type='hidden' name='BusTyp'   value='<%=BusTyp%>'></input>
		<input type='hidden' name='CusNm'    value='<%=CusNm%>'></input>
		<input type='hidden' name='AMT1'     value='<%=AMT1%>'></input>
		<input type="submit" value="确定"></input>
	</form> 
<%
	} else {
%> 
		<%=MessManTool.getValueByName(message, "display_zone")%>
<%
	}
%>
</content>
</res> 