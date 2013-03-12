<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.TxnAmtFormat"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行卡号
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));

	String dxNumber = MessManTool.changeChar(request.getParameter("dxNumber")); 
	String optType =  MessManTool.changeChar(request.getParameter("phoneType"));
	gzLog.Write("####ChongZhi_B.jsp=====dxNumber:"+dxNumber+"    optType:"+optType);
	
	
	//String sendContext = "biz_id,26|biz_step_id,1|TXNSRC,MB441|CDNO,"+cdno+"|CTSQ,"+dxNumber+"|DestAttr,"+optType+"|";
	
	
	//=================下面的sendContext是用来做测试的模拟报文=============================================
	String sendContext = "biz_id,26|biz_step_id,1|TXNSRC,MB441|CDNO,6222601310009822651|PSWD,null|CTSQ,18928265568|DestAttr,0002|";
	//========================================================================================================
	
	gzLog.Write("ChongZhi_B.jsp the sendContext sent to server ==="+sendContext);
	
	//这里开始才会转到网关上啊
	MidServer midServer = new MidServer();
	BwResult bwResult = new BwResult();
	bwResult = midServer.sendMessage(sendContext);
	String info = "";
	info = bwResult.getContext();
	
	//==================下面的info是用来做测试的String报文，分成正常返回和错误返回两种模式==========================
	//正确返回的情况
	info="|bocom_mid|biz_id,26|biz_no,00026|biz_step_id,1|display_zone,话费余额： -138.00  <br>余额有效期开始时间： 19901010 <br>余额到期时间： 20991010 <br>号码归属地区号： 0769  <br>|MGID,000000|BalTyp,01000000|Balance,-00000013800|EffTime,19901010      |ExpireTime,20991010      |BillMode,18A|DestAttr,0002|DqCode,0769 |objectHome,02|CTSQ,18928265568         |";
	
	//错误返回的情况
	//info="|bocom_mid|biz_id,26|biz_no,00026|biz_step_id,1|display_zone,<font color=ff0000>--->交易失败</font><br>--->失败原因：[482199] [电信方:用户不存在                                       ] <br>|MGID,482199|";
	
	//================================================================================================================
	
	
	
	gzLog.Write("这是电信充值===ChongZhi_B.jsp"+"\n服务器下行返回的报文内容："+info);
	
	String MGID = MessManTool.getValueByName(info, "MGID");	
	gzLog.Write("校验码MGID:  "+MGID);
	
	String display_zone = MessManTool.getValueByName(info, "display_zone");	
	gzLog.Write("返回信息:  "+display_zone);
%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
	
	
<%
	//如果返回正确
	if("000000".equals(MGID)){
			String CTSQ = MessManTool.getValueByName(info, "CTSQ");	
%>
	<label>充值电信号码：<%=CTSQ%></label>
	<br/>
<%

		
			String[] strArray = display_zone.split("<br>");
			for(int i=0; i<strArray.length;i++){
				gzLog.Write("strArray["+i+"]:"+strArray[i]);
%>
			<label><%=strArray[i]%></label>
			<br/>


<%	
			}
%>			
		<br/>
		<br/>
		<form method='post' action='/GZMBank/ChongZhi/dianxin/ChongZhi_B1.jsp'>
			<br/>
			<br/>
			<br/>
			<label>请选择充值金额：</label>
			<select name="optAmount">
				<option value="0">50  元</option>
				<option value="1">100 元</option>
				<option value="2">150 元</option>
				<option value="3">200 元</option>
				<option value="4">500 元</option>
			</select>
		
		    <input type='hidden' name='dxNumber' value="<%=CTSQ%>"/>
			<input type='hidden' name='optType' value="<%=optType%>"/>
		    <input type='submit' value='下一步'></input> 
		</form>
		
<%
	}else{
			String[] errArray = display_zone.split("--->");
			for(int i=0; i<errArray.length;i++){
				errArray[i]=errArray[i].trim();
				gzLog.Write("错误信息errArray["+i+"]:["+errArray[i]);
%>
				<label> <%=errArray[i]%></label>
			    <br/>
				<br/>
<%
			}
%>
		
			<label>
			号码验证失败，请您再次确认您输入的电话号码是否有误，如果需要任何帮助，请拨打95559.
			</label>

<%
	}
%>

</content>
</res> 

