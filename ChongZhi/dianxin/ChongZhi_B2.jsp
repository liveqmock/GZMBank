<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	
	
	
	gzLog.Write("电信充值业务第3个界面=====ChongZhi_B2.JSP：\n");
	
	String tranAmt  = MessManTool.changeChar(request.getParameter("tranAmt")); //充值金额
	String dxNumber = MessManTool.changeChar(request.getParameter("dxNumber"));//电信充值号码
	String optType  = MessManTool.changeChar(request.getParameter("optType"));//
	String plantPwd = request.getHeader("password"); //移植密码
	
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
		String sendContext = "biz_id,26|biz_step_id,3|TXNSRC,MB441|CTSQ,"+dxNumber+"|AMT1,"+tranAmt+"|DestAttr,"+optType+"|ActTyp,4|CDNO,"+cdno
		+"|PSWD,"+plantPwd+"|";
		
		String sendContext1 = "biz_id,26|biz_step_id,3|TXNSRC,MB441|CTSQ,"+dxNumber+"|AMT1,"+tranAmt+"|DestAttr,"+optType+"|ActTyp,4|CDNO,"+cdno
		+"|PSWD,"+"******"+"|";
		
		gzLog.Write("这是电信充值=====最后阶段=====STEP4"+"\n上传的报文组装完毕，内容如下："+sendContext1);  //log
		
		//这里开始才会转到网关上啊
		MidServer midServer = new MidServer();
		BwResult bwResult = new BwResult();
		bwResult = midServer.sendMessage(sendContext);
		String info = "";
		info = bwResult.getContext();
		
		
//===================ics服务器返回的报文 测试样例=====================================================
//正确情况的返回报文
		//info="biz_id,26|biz_no,00026|biz_step_id,2|display_zone,交易日期： 2012-7-30  <br>缴费卡号： 6222600710007364773  <br>电话号码： 02038490466           <br>充值金额： 50.00  <br>会计流水号： ABIA0410048  <br><b>充值成功! 请及时查询结果。</b><br>|MGID,000000|";

//错误情况的返回报文


//====================================================================================================
		gzLog.Write("这是电信充值=====最后阶段===ChongZhi_B2.jsp"+"\n服务器下行返回的报文内容："+info);
		
		String MGID = MessManTool.getValueByName(info, "MGID");	
		gzLog.Write("校验码MGID:  "+MGID);
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String today = df.format(new Date());
		
		String display_zone = MessManTool.getValueByName(info, "display_zone");	
		gzLog.Write("返回内容display_zone:  "+display_zone);
		
		//如果返回正确
		if("000000".equals(MGID)){

			String[] strArray = display_zone.split("<br>");
			for(int i=0; i<strArray.length;i++){
				gzLog.Write("strArray["+i+"]:"+strArray[i]);			
	%>
				<label><%=strArray[i]%></label>
				<br/>
				<br/>
	<%
			}

		} else {
				  String errorMsg = "";
				  int i =0;
				  int j =0; 
				  //将[]中的错误原因拆分出来
				  if(display_zone!=null||display_zone.length()!=0){
					 
					  i=display_zone.lastIndexOf("[");
					  j=display_zone.lastIndexOf("]");
					  errorMsg= display_zone.substring(i,j+1);
				  }
				  gzLog.Write("****错误信息:"+errorMsg);
	     
	%>  
	
				<label>
					抱歉，充值交易出失败。
				</label>
				<br/>
				<br/>
				<label>错误信息：<%=errorMsg%></label>
				<br/>
				<br/>
				<br/>
				<label>如有疑问，请及时与开户银行联系！或请拨打95559客服电话。</label>
	<%
		}

	%>  	    
	</content>
</res>