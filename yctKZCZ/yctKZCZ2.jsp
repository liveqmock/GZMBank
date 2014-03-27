<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>


<%
		GzLog gzLog = new GzLog("c:/gzLog_sj");
		gzLog.Write("羊城通自动充值yctKZCZ2.....\n");
    String sContract = request.getParameter("contract");
   
%>

<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
  if (sContract.equals("1")) {  //签约
      String    sCDNO       = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
      /*由于总行主机测试环境暂不对外开放，暂封闭该段*/
      String    sendContext = "biz_id,25|i_biz_step_id,4|TXNSRC,MB441|CDNO,"+sCDNO+"|";
      MidServer midServer   = new MidServer();
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
      
      //String    recvContext = "|bocom_mid|biz_id,25|biz_no,00025|biz_step_id,4|TXNSRC,MB441|IDTyp,1|IDNo,430419197307012465|ActNam,交行客户|ActSts,正常|CrdTyp,借记卡|display_zone,|MGID,000000|";
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");
      
      if ("000000".equals(sMGID)){
         //IDTyp,1|IDNo,13022719841210281X|ActNam,张杰|ActSts,正常|CrdTyp,借记卡|display_zone,|MGID,000000 
         String    sIDTyp       = MessManTool.getValueByName(recvContext, "IDTyp");
         String    sIDNo        = MessManTool.getValueByName(recvContext, "IDNo");
         String    sActNam      = MessManTool.getValueByName(recvContext, "ActNam");


%>
	  <form method='post' action='/GZMBank/yctKZCZ/yctKZCZ3.jsp'>
         <label>请输入相应签约信息</label>
         <label>用户姓名:<%=sActNam%></label>
         <!--input type='text' name='cusnam' value='<%=sActNam%>' style="-wap-input-required: 'true'"  maxleng='20' /-->
         <input type='hidden' name='cusnam' value='<%=sActNam%>'></input>
         <label>身份证号码:<%=sIDNo%></label>
         <!--input type='text' name='cusid' value='<%=sIDNo%>' style="-wap-input-format:'N'; -wap-input-required: 'true'"  maxleng='18' /-->
         <input type='hidden' name='cusid' value='<%=sIDNo%>'></input>
         <label>性别:</label>
		     <select name='cussex'>
		       <option value="0">男</option>
		  	   <option value="1">女</option>
		     </select>

         <label>羊城通卡号:</label>
         <input type='text' name='yctcdno' style="-wap-input-format:'N'; -wap-input-required: 'true'"  minleng='8' maxleng='10' />

         <label>温馨提示：如果您的羊城通卡片号无法读取，请通过我行自助充值机充值后的打印凭条读取羊城通卡号。</label>
         <input type='hidden' name='cusidtyp' value='<%=sIDTyp%>'></input>
		     <input type='submit' value='下一步'/>
	   </form>
<%
      }
      else {
%>
		<form method='post' action='/GZMBank/yiDongCharge/yctKZCZ1.jsp'>
	    <label>错误代码:<%=sMGID%></label>
	    <label>错误信息:客户信息查询失败</label>
		</form>

         
<%
      }
  }
  else if (sContract.equals("2")) { //解约
      String    sCDNO        = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
      String    sSightcontext= request.getParameter("sightContext");
      String    sInfo[]     = sSightcontext.split("\\|");
      String    sendContext = "biz_id,25|i_biz_step_id,3|sign_flag,0|inst_no,交通银行|bank_acc,"+sCDNO+"|card1,"+sInfo[1].trim()+"|card2,|card3,|";
      MidServer midServer   = new MidServer();
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");
      if ("000000".equals(sMGID)){

%>
         
		<form method='post' action='/GZMBank/yiDongCharge/yctKZCZ1.jsp'>
      <label>返回信息:羊城通自动充值解约成功</label>
		</form>
         
<%
      }
      else {
          String    sCodeMsg   = MessManTool.getValueByName(recvContext, "PB_Return_Code_Msg");
%>
        
		<form method='post' action='/GZMBank/yiDongCharge/yctKZCZ1.jsp'>
      <label>错误代码:<%=sMGID%></label>
      <label>错误信息:<%=sCodeMsg%></label>
		</form>
          
<%
      }
  }
%>
	</content>
</res>