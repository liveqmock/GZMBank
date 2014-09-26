<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.viatt.util.*"%>

<!-- 分行特色业务频道列表 -->
<%
		
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	GzLog log = new GzLog("c:/gzLog_sj");
	log.Write("==============noticementContent.jsp==begin==============================");
	log.Write("CARDNO= "+cdno+"\n"+"MobileNo= "+sjNo);
	
%>

<res>
	<content>	
			<label>	
				您好！欢迎使用广东省分行缴费充值业务，<br/>
				您在交通银行电子渠道（含个人网银、手机银行、自助通）进行充值、缴费业务时，将会实时把您充值所需的基本资料：含缴费银行卡号、充值金额、手机号码、订单号等，发送至业务所对应的合作商家<br/>
				(目前合作商含广东移动、广东电信、银旅通有限公司、天翼电子商务有限公司、羊城通有限公司、广东省福彩中心、智益电子商务有限公司、广州市电力局等)。<br/>
				因业务发展需要，我行将对上述合作商家进行调整（含新增和减少）不再另行通知，以上如有疑问可电询95559。
			</label>
	    
	     <form method='post' action='/GZMBank/noticement/noticementAgree.jsp'>
	     	  <input type='hidden' name='willInsert' value='YES'></input>
		      <input type='submit' value='同意' /> 
		      <input type='button' name='cancel' value='不同意'/>
		  </form> 
		 
	</content>
</res>