<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>



<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String optAmount  = MessManTool.changeChar(request.getParameter("optAmount")); //充值金额 0--50yuan 1--100, 2--150, 3--200 4--500
	String ydNumber = MessManTool.changeChar(request.getParameter("ydNumber"));//移动手机号码
	int opt=Integer.parseInt(optAmount.trim());
	String amount="";
	String tranAmt="";
	String icsAmount="";//used for translate the amount number to ICS
	
	switch(opt){
	case 0:
		amount="50"; 
		tranAmt="000000000005000";
		break;
	case 1:
		amount="100";
		tranAmt="000000000010000";
		break;
	case 2:
		amount="150";
		tranAmt="000000000015000";
		break;
	case 3:
		amount="200";
		tranAmt="000000000020000";
		break;
	case 4:
		amount="500";
		tranAmt="000000000050000";
		break;
	default :
		amount="00"; 
		tranAmt="000000000000000";
		break;
			
	}
	gzLog.Write("电话号码:"+ydNumber+"\n"+"充值金额:"+amount+"||"+tranAmt);
	
	//===========================================
	
	//在收到了客户输入的电话号码之后需要上传到ICS上发给移动去做查询确认。
	String sendContext = "biz_id,28|biz_step_id,1|TXNSRC,WE441|CDNO,"+cdno+"|PSWD,null|CTSQ,"+ydNumber+"|";
	gzLog.Write("这是移动话费充值=====查询阶段=====STEP1"+"\n上传的报文组装完毕，内容如下："+sendContext);  
	
	
	//这里开始才会转到网关上啊	
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(sendContext);
	
	//接收到网关传来的报文
	String info = bwResult.getContext();
	gzLog.Write("这是移动充值=====Query===ChongZhi_A2.jsp"+"\n服务器下行返回的报文内容："+info);
	
	
	//=======================用来做测试的报文============开始=====================================
	
	
	String MGID = MessManTool.getValueByName(info, "MGID");	
	gzLog.Write("校验码MGID:  "+MGID);
		
	String display_zone = MessManTool.getValueByName(info, "display_zone");	
	gzLog.Write("返回内容display_zone:  "+display_zone);
	
	//=======================用来做测试的报文============结束=====================================
	
%>

<res> 
	<content>


<%
	//如果返回正确
	if("000000".equals(MGID)){
		String CTSQ = MessManTool.getValueByName(info, "CTSQ");	

%>		
		 <form method='post' action='/GZMBank/ChongZhi/yidong/ChongZhi_A2.jsp'>
			<label>充值号码： <%=ydNumber%>	</label>
			<br/>
		  <label>充值金额:  <%=amount%> 元</label>
			<br/>
			<label>交易密码</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
			<input type='hidden' name='ydNumber' value="<%=ydNumber%>"/>
			<input type='hidden' name='tranAmt'  value="<%=tranAmt%>"/>
			<br/>			
			<br/>
			<br/>
			<input type='submit' value='确定'/>
			<br/>
			<label>请仔细核对充值手机号码的准确性,如因客户输入错误导致充值失败的,将不予退还充值金额.</label>
			
		</form> 
<%
	}else{
		String errorMsg="";
		String nubStat="";
		int k = 0;
		k=display_zone.indexOf("<b>");
		if(k!=0){
			nubStat=display_zone.substring(k+7, k+20);
		}
	
	gzLog.Write("错误描述:  "+nubStat);	
%>	
        <br/>
		<label>验证手机出现错误</label>
		
		<label>请您再次确认您输入的电话号码是否正确.</label>
		<br/>
		
<%
	}
%>	
</content>
</res> 