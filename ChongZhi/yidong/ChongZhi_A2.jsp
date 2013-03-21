d<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Date" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	
	
	
	gzLog.Write("移动充值业务第3个界面=====ChongZhi_A2.JSP：\n");
	
	String tranAmt  = MessManTool.changeChar(request.getParameter("tranAmt")); //充值金额
	String ydNumber = MessManTool.changeChar(request.getParameter("ydNumber"));//移动手机号码
	String plantPwd = request.getHeader("password"); //移植密码
	
	
	gzLog.Write("tranAmt="+tranAmt+"\n"+"ydNumber"+ydNumber);
	
%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
		String sendContext = "biz_id,28|biz_step_id,2|TXNSRC,MB441|CTSQ,"+ydNumber+"|AMT1,"+tranAmt+"|ActTyp,4|CDNO,"+cdno
		+"|PSWD,"+plantPwd+"|";
		
		String sendContext1 = "biz_id,28|biz_step_id,2|TXNSRC,MB441|CTSQ,"+ydNumber+"|AMT1,"+tranAmt+"|ActTyp,4|CDNO,"+cdno
		+"|PSWD,"+"******"+"|";
		
		gzLog.Write("这是移动话费充值=====最后阶段=====STEP4"+"\n上传的报文组装完毕，内容如下："+sendContext1);  //log
		
		//这里开始才会转到网关上啊
		String info = "";
		MidServer midServer = new MidServer();
		BwResult bwResult = new BwResult();
		bwResult = midServer.sendMessage(sendContext);
		
		//接收到网关传来的报文
		info = bwResult.getContext();
		gzLog.Write("这是移动充值=====最后阶段===ChongZhi_A2.jsp"+"\n服务器下行返回的报文内容："+info);
		
//========================================做正常返回测试的时候的报文例子=================
		 
		 //info = "|bocom_mid|biz_id,28|biz_no,00028|biz_step_id,2|display_zone,手机号码： 13726623917           <br>缴费金额： 50.00  <br>会计流水： ABIA0410300  <br><b>交费成功! 请及时查询结果。</b><br>|MGID,000000|";
		 gzLog.Write("这是移动充值=====最后阶段===ChongZhi_A2.jsp"+"\n服务器下行返回的报文内容："+info);

		 //===============================================================================================
		
		String MGID = MessManTool.getValueByName(info, "MGID");	
		gzLog.Write("校验码MGID:  "+MGID);
		
		String display_zone = MessManTool.getValueByName(info, "display_zone");	
		gzLog.Write("返回内容display_zone:  "+display_zone);
		
		
		SimpleDateFormat df = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");//设置日期格式
		String today = df.format(new Date());
		
		
		
		//如果返回正确
		if("000000".equals(MGID)){

			int k = display_zone.indexOf("手机号码");
			int n = display_zone.indexOf("缴费金额");
			int m = display_zone.indexOf("会计流水");
			int length = display_zone.length();
			
			gzLog.Write("手机号码"+k+"|缴费金额"+n+"|会计流水"+m+"|length="+length);
			
			String amount  ="";
			String tranFlow = "";
			String callNum ="";
			amount=display_zone.substring(n, n+13);
			tranFlow=display_zone.substring(m, m+18);
			callNum=display_zone.substring(k,k+18);
			
			gzLog.Write("amount:"+amount+"|tranFlow:"+tranFlow+"|callNum:"+callNum);
			
			//gzLog.Write(n+"|"+m+"|"+k);
		
	%>
			<label>
					充值交易成功，感谢您的使用
			</label>
		    <br/>
			<label>
					<%=callNum%>
			</label>
		    <br/>
			<label>
					<%=amount%>
			</label>
		    <br/>   
			<label>
					<%=tranFlow%>
			</label>
			<br/>
			<label>交易时间： </label>
			<br/>
			<label><%=today%></label>
		
	<%
		} else {
		  //将[]中的错误原因拆分出来
			String errorMsg = "";
		  if(display_zone==null){
			  errorMsg = "";
		  }else if(display_zone.length()!=0){
			 int i,j;
			  i=display_zone.lastIndexOf("[");
			  j=display_zone.lastIndexOf("]");
			  errorMsg= display_zone.substring(i,j+1);
		  }
		  
		  
		  gzLog.Write("****错误信息:"+errorMsg);
	
		  
	%>  
	
			<label>抱歉，交易遇到了错误，交易失败</label>
		    <br/>
			<label>错误信息为：<%=errorMsg%></label>
		    <br/>
			<label>交易时间： <%=today%></label>
			<br/>
			<label>
				 如果需要任何帮助，请拨打95559.
			</label>
		    <br/>    
	<%
		}
	%>
	</content>
</res>