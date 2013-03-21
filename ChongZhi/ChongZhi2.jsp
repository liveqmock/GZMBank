<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE")); 
	String optType = MessManTool.changeChar(request.getParameter("optType"));  //0-移动充值 1 -电信充值
	
	int opt=Integer.parseInt(optType.trim());
	
	gzLog.Write("###充值业务第二个界面##ChongZhi2.jsp====Step2"+"cardNumber:"+cdno+"   phoneNumber:"+sjNo+"\n");
	
	
	String action_next="";
	
	switch(opt){
	    // 移动充值
		case 0:{
			action_next="ChongZhi_A.jsp";
			break;
		}
		//电信充值
		case 1:{
			action_next="ChongZhi_B.jsp";
			break;
		}
		//联通充值
		case 2:{
			action_next="liantong/ChongZhi_liantong_TelNum.jsp";
			break;
		}
		default:{
			action_next="ChongZhi1.jsp";
		}
	}
%>
	
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
	</content>
</res>	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
%>


<?xml version = "1.0"  encoding = "utf-8"?>
<res>
	<content>
	<%
    if(optType.equals("0")){
	%>  
	<form method='post' action='/GZMBank/ChongZhi/ChongZhi_A.jsp'>
			<label>请输入移动公司手机号码： </label>
			<input type='text' name='ydNumber' style="-wap-input-required: 'true'" minleng='11' maxleng='11'/>
			
			<br/>
			<br/>
			<label>温馨提示: </label>	
		    <br/>
		    <label>尊敬的客户：移动充值业务目前支持广东省（除深圳地区）的移动号码充值，如为广东省外其他地区，请选择其他方式充值，如有不便敬请谅解。</label>	
			<br/>
			<br/>
			<br/>
			<input type='submit' value='下一步'/>
			
	</form>
    <%
	  }else {
    %>
	<form method='post' action='/GZMBank/ChongZhi/ChongZhi_B.jsp'>
	    <label>请输入电信公司充值号码:</label>
			<br/>
			<label>请带区号（例如：02038000000）</label>
			<input type='text' name='dxNumber' style="-wap-input-required: 'true'" />
			<br/>
			<br/>
			<label>充值号码种类：</label>
			<br/>
			<select name="optType">
				<option value="0">固定电话</option>
				<option value="1">小灵通</option>
				<option value="2">移动号码</option>
				<option value="3">ADSL</option>
				<option value="6">付费易账户</option>
			</select>	
			<br/>
			<br/>
			<label>尊敬的客户：电信充值业务目前支持广东省（含深圳地区）的电信号码充值，如为广东省外其他地区，请选择其他方式充值，如有不便敬请谅解。 </label>
			<br/>
			<br/>
			<br/>
			<input type='submit' value='下一步'/>	
	</form> 
	   
   <%
	}
   %>
	   
	   
			
	</content>
</res>