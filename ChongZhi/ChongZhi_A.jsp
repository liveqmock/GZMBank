<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String ydNumber = MessManTool.changeChar(request.getParameter("ydNumber")); //充值的移动手机号码
	gzLog.Write("ChongZhi_A.jsp===移动充值第二个界面"+ydNumber);
	
	
	
	
	
	//===========================================
	
	//在收到了客户输入的电话号码之后需要上传到ICS上发给移动去做查询确认。
	
	String sendContext = "biz_id,28|biz_step_id,1|TXNSRC,WE441|CDNO,"+cdno+"|PSWD,null|CTSQ,"+ydNumber+"|";
	gzLog.Write("这是移动话费充值=====查询阶段=====STEP1"+"\n上传的报文组装完毕，内容如下："+sendContext);  
	
	
	//这里开始才会转到网关上啊	
	String info = "";
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	bwResult = midServer.sendMessage(sendContext);
	
	
	//接收到网关传来的报文
	info = bwResult.getContext();
	gzLog.Write("这是移动充值=====最后阶段===ChongZhi_A2.jsp"+"\n服务器下行返回的报文内容："+info);
	
	
	//=======================用来做测试的报文============开始=====================================
	
	//正常情况
	info="biz_id,28|biz_no,00028|biz_step_id,1|display_zone,手机号码： 13660395790           <br>|MGID,000000|User_status,00|CTSQ,13660395790|";
	
	
	//错误情况
	//info="biz_id,28|biz_no,00028|biz_step_id,1|display_zone,<font color=ff0000><b>--->手机状态： 状态不正常  <br></font><br>|MGID,000001|CTSQ,11112222511|";

	
	//=======================用来做测试的报文============结束=====================================
	
	
	String MGID = MessManTool.getValueByName(info, "MGID");	
	gzLog.Write("校验码MGID:  "+MGID);
		
	String display_zone = MessManTool.getValueByName(info, "display_zone");	
	gzLog.Write("返回内容display_zone:  "+display_zone);
	
%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
<%
		
	//如果返回正确
	if("000000".equals(MGID)){
		String CTSQ = MessManTool.getValueByName(info, "CTSQ");	

%>		
		<form method='post' action='/GZMBank/ChongZhi/yidong/ChongZhi_A1.jsp'>
			<label>充值号码为: <%=CTSQ%></label>
			<br/>
			<label>
				请选择充值金额数目:
			</label>
			<br/>
			<select name="optAmount">
				<option value="0">50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select>
			<br/>
			<br/>
			<br/>
		    <input type='hidden' name='ydNumber' value="<%=CTSQ%>"/>
		    <input type='submit' value='下一步'/>
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

		<label>验证手机出现错误</label>
		<br/>
		<br/>
		<label>错误描述:  <%=nubStat%> </label>
		<br/>
		<br/>
		<br/>
		<br/>
		<label>
			请您再次确认您输入的电话号码是否有误，如果需要任何帮助，请拨打95559.
		</label>
		<br/>
		
<%
	}
%>	
</content>
</res> 