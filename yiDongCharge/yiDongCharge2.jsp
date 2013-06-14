<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String signType =""; 
	String mainNo = MessManTool.changeChar(request.getParameter("mainNo"));
	String signNo ="";
	String optType = MessManTool.changeChar(request.getParameter("optType"));  //0-签约 1-解约
	String signTypeName="";
	String IdTypeName="";
	String URL="";
	
	
	if(optType.equals("1")){
	   signType="0";
	   signTypeName="签约解除";
	   signNo="";
	}
	
	else{
	    signType=MessManTool.changeChar(request.getParameter("signType"));
		if(signType.trim().equals("1")){
			signTypeName="主号签约";
		    signNo=mainNo;
		
		}
		else if(signType.trim().equals("2")){
			signTypeName="副号签约";
			signNo=MessManTool.changeChar(request.getParameter("signNo"));
		}
	}
	
	gzLog.Write("######客户信息查询交易#######yiDongCharge2.jsp===step2"+" cardNumber"+cdno+"phoneNumber"+sjNo+" signType"+signType+" mainNo"+mainNo+" signNo"+signNo);
	
	
	
%>

<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
	<% 		
		//拼装上传报文===这个地方时拼装送往查询交易的报文
		
		String sendContext = "biz_id,32|biz_step_id,3|TXNSRC,MB441|ActNo,"+cdno;
		
		gzLog.Write(">>>>>>>>>>>>>>>>>>接收报文MESSAGE为："+sendContext);  //log
		
		MidServer midServer = new MidServer();
		
		//获取返回的报文
		BwResult bwResult = midServer.sendMessage(sendContext);
		String message = bwResult.getContext();
		gzLog.Write("<<<<<<<<<<<<<<<接收报文MESSAGE为：" +message);
		
		String MGID = MessManTool.getValueByName(message, "MGID");
		
		
		
		
		//当返回成功
		if("000000".equals(MGID)){
	%>
	<%	
        //获取查询回来去得到的值

	  String IdTyp = MessManTool.getValueByName(message, "IdTyp");
		String IdNo  = MessManTool.getValueByName(message, "IdNo");
		String ActNam= MessManTool.getValueByName(message, "ActNam");
		String ActSts= MessManTool.getValueByName(message, "ActSts");
		
		
		
		int idtype = Integer.parseInt(IdTyp.trim());
		
		switch(idtype)
		{
			case 15: IdTypeName="居民身份证"; break; 
			case 23: IdTypeName="户口簿"; break;
			case 19: IdTypeName="港澳通行证"; break;
			case 16: IdTypeName="临时身份证"; break;
			case 25: IdTypeName="外国人居留证"; break;
			case 18: IdTypeName="武警身份证"; break;
			case 17: IdTypeName="军人身份证"; break;
			case 21: IdTypeName="其他"; break;
     	default : IdTypeName="ELSE";
			
		}
		
		
	%>
	<%
	 if(optType.equals("0")){ 
    %>	 
		<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge3.jsp'>
			<input type='hidden' name='IdTyp'    value="<%=IdTyp%>"/> 
			<input type='hidden' name='IdNo'     value="<%=IdNo%>"/> 
			<input type='hidden' name='ActNam'   value="<%=ActNam%>"/> 
			<input type='hidden' name='ActSts'   value="<%=ActSts%>"/>
			<input type='hidden' name='signType' value="<%=signType%>"/> 
			<input type='hidden' name='mainNo'   value="<%=mainNo%>"/> 
			<input type='hidden' name='signNo'   value="<%=signNo%>"/> 
			
			
			<table border = '1'>
		        <tr>
		        	<td>签约类型</td>
		        	<td><%=signTypeName%></td>
		        </tr>
		        <tr>
		        	<td>证件类型</td>
		        	<td><%=IdTypeName%></td>
		        </tr>
		         <tr>
		        	<td>客户姓名</td>
		        	<td><%=ActNam%></td>
		        </tr>
		        <tr>
		        	<td>证件号码</td>
		        	<td><%=IdNo%></td>
		        </tr>
				<tr>
		        	<td>主手机号</td>
		        	<td><%=mainNo%></td>
		        </tr>
				<tr>
		        	<td>签约手机号</td>
		        	<td><%=signNo%></td>
		        </tr>				
			</table>
			<br/>
			
			<label>交易密码</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<br/>
			
			<br/>
			<input type='submit' value='签约'/>		
		</form>		
	<%
	}else if(optType.equals("1")){
	%>	
		<form method='post' action='/GZMBank/yiDongCharge/yiDongCharge4.jsp'>
			<input type='hidden' name='IdTyp'    value="<%=IdTyp%>"/> 
			<input type='hidden' name='IdNo'     value="<%=IdNo%>"/> 
			<input type='hidden' name='ActNam'   value="<%=ActNam%>"/> 
			<input type='hidden' name='ActSts'   value="<%=ActSts%>"/>
			<input type='hidden' name='signType' value="<%=signType%>"/> 
			<input type='hidden' name='mainNo'   value="<%=mainNo%>"/>
			
			
			<table border = '1'>
		        <tr>
		        	<td>签约类型</td>
		        	<td><%=signTypeName%></td>
		        </tr>
		        <tr>
		        	<td>证件类型</td>
		        	<td><%=IdTypeName%></td>
		        </tr>
		         <tr>
		        	<td>客户姓名</td>
		        	<td><%=ActNam%></td>
		        </tr>
		        <tr>
		        	<td>证件号码</td>
		        	<td><%=IdNo%></td>
		        </tr>
				<tr>
		        	<td>签约主手机号</td>
		        	<td><%=mainNo%></td>
		        </tr>
				
			</table>
			<br/>
			
			<label>交易密码</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<br/>			
			<br/>
			<input type='submit' value='解约'/>		
		</form>		
    <%
     }
    %>	 
			
		
	<%	
    }else{
	     String errorReport = MessManTool.getValueByName(message, "RspMsg");
	     System.out.println("错误信息是："+errorReport );
    %>
    <label>查询信息出错，错误信息为</label>
    <br/>
         <%=errorReport%>
    <%
         }
    %>
	</content>
</res>
