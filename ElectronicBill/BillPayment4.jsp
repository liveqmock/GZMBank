<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));  //银行账户
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));  //手机号码
	String plantPwd = request.getHeader("password"); //移植密码
	String message = MessManTool.changeChar(request.getParameter("MESS"));  //那一大堆需要组包上传的东西
	
	
	
	gzLog.Write("这是电卡缴费=====最后阶段=====STEP4"+message);
	
	String ActNo  = MessManTool.getValueByName(message, "ActNo"); //银行账号
	String TCusId = MessManTool.getValueByName(message, "TCusId");//用户编号
	String LChkTm = MessManTool.getValueByName(message, "LChkTm");//电费日期
	String TxnAmt = MessManTool.getValueByName(message, "TxnAmt");//金额
	String ChkTim = MessManTool.getValueByName(message, "ChkTim");//交易日期
	String DptTyp = MessManTool.getValueByName(message, "DptTyp");//部门种类
	String UsrNam = MessManTool.getValueByName(message, "UsrNam");//用户姓名
	String UsrAdd = MessManTool.getValueByName(message, "UsrAdd");//用户地址

%>


<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
	<%	
		//在这里开始拼装即将发往服务器的一串报文。 注意有其固定格式
		
		String sendContext = "biz_id,31|biz_step_id,2|ActNo,"+ActNo+"|TCusId,"+TCusId+"|TCusNm,"+UsrNam+"|LChkTm,"+LChkTm
		+"|DptTyp,"+DptTyp+"|TxnAmt,"+TxnAmt+"|Fee,"+""+"|VchTyp,"+"007"+"|VchNo,"+""+"|BilDat,"+""+"|PSWD,"+plantPwd+"|";
		
		
		//这是在做测试的时候 要将密码做一下修改。 不做加密等操作，实际使用要用上卖弄的一段代码
		//String sendContext = "biz_id,31|biz_step_id,2|ActNo,"+ActNo+"|TCusId,"+TCusId+"|TCusNm,"+UsrNam+"|LChkTm,"+LChkTm
		//+"|DptTyp,"+DptTyp+"|TxnAmt,"+TxnAmt+"|Fee,"+""+"|VchTyp,"+""+"|VchNo,"+""+"|BilDat,"+""+"|PSWD,"+"1234567890"+"|";
		
		gzLog.Write("这是电卡缴费=====最后阶段=====STEP4"+"\n上传的报文组装完毕，内容如下："+sendContext);  //log
		
		//这里开始才会转到网关上啊
		MidServer midServer = new MidServer();
		
	//BEGIN 身份认证
	//
	//	String verify = request.getHeader("MBK_VERIFY_RESULT");
	//  String info = "";
	//	if(verify!=null&&verify.equals("P")){
	//	   //通过身份认证，向后台发送交易
	//	   bwResult = midServer.sendMessage(sendContext);
	//	   info = bwResult.getContext();
	//	   gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+info);
	//	}else if(verify.equals("F")){
	//		info = "|MGID,000333|RspMsg,身份验证不通过|";
	//	}else if(verify.equals("N")){
	//	    info = "|MGID,000444|RspMsg,身份未验证|";
	//	}else {
	//	    info = "|MGID,000555|RspMsg,身份验证系统出错|";
	//	}
	//
    //END 身份认证
		
		//开始发送报文，并且立刻接受返回的信息
		BwResult bwResult = midServer.sendMessage(sendContext);
		String info = bwResult.getContext();
		gzLog.Write("这是电卡缴费=====最后阶段=====STEP4"+"\n服务器下行返回的报文内容："+info);
		
		String MGID = MessManTool.getValueByName(info, "MGID");	
		gzLog.Write("这里是缴费Step4报文返回的第一站，检查MGID"+MGID);
		
		String tLogNo = MessManTool.getValueByName(info, "TLogNo");
		String tckNo = MessManTool.getValueByName(info, "TckNo");	
		String tActDt = MessManTool.getValueByName(info, "TActDt");	
		
		
		//如果返回正确
		if("000000".equals(MGID)){
	 %>	 
			<label>
				交易成功！谢谢您。
			</label>
		    <br/>
		    <br/>
		    
		    <table border='1'>
		    	<tr>
		        	<td>供电公司系统参考号</td>
		        	<td><%=tLogNo%></td>
		        </tr>
		        <tr>
		        	<td>会计业务流水号</td>
		        	<td><%=tckNo%></td>
		        </tr>
		      <!--   <tr>
		        	<td>供电公司清算日期</td>
		        	<td><%=tActDt%></td>
		        </tr>  -->
		    </table>
		    <br/>    
		
	<%
		} else {
	      String RspCod = MessManTool.getValueByName(info, "RspCod");
 	      String RspMsg = MessManTool.getValueByName(info, "RspMsg"); 
 	      
 	      gzLog.Write("****错误码:"+RspCod+"错误信息"+RspMsg);
 	      
 	      out.println("<label>错误码为:"+RspCod+"</label><br/>");
		  if("PD5012".equals(RspCod)){
			 	out.println("<label>错误原因为:密码错误</label><br/>");
		}
 	}
    %> 
		
    <%
	gzLog.Write("电力缴费完毕！！！！！");
    %>	
    </form>
	</content>
</res>