<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>


<%
   //System.out.println("羊城通自动充值yctKZCZ2.....");
   String sContract = request.getParameter("contract");
   
%>

<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
  if (sContract.equals("1")) {  //签约
      String    sCDNO       = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
      /*由于总行主机测试环境暂不对外开放，暂封闭该段
      String    sendContext = "biz_id,25|i_biz_step_id,4|CDNO,"+sCDNO+"|";
      MidServer midServer   = new MidServer();
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
      */
      String    recvContext = "|bocom_mid|biz_id,25|biz_no,00025|biz_step_id,4|IDTyp,1|IDNo,430419197307012465|ActNam,交行客户|ActSts,正常|CrdTyp,借记卡|display_zone,|MGID,000000|";
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");
      
      if ("000000".equals(sMGID)){
         //IDTyp,1|IDNo,13022719841210281X|ActNam,张杰|ActSts,正常|CrdTyp,借记卡|display_zone,|MGID,000000 
         String    sIDTyp       = MessManTool.getValueByName(recvContext, "IDTyp");
         String    sIDNo        = MessManTool.getValueByName(recvContext, "IDNo");
         String    sActNam      = MessManTool.getValueByName(recvContext, "ActNam");


%>
	  <form method='post' action='/GZMBank/yctKZCZ/yctKZCZ3.jsp'>
         <h4>请输入相应签约信息</h4>
         <h4>用户姓名:</h4>
         <!--input type='text' name='cusnam' value='<%=sActNam%>' style="-wap-input-required: 'true'"  maxleng='20' /-->
         <input type='hidden' name='cusnam' value='<%=sActNam%>'></input>
         <%=sActNam%>
         <br/>
         
         <h3>身份证号码:</h3>
         <!--input type='text' name='cusid' value='<%=sIDNo%>' style="-wap-input-format:'N'; -wap-input-required: 'true'"  maxleng='18' /-->
         <input type='hidden' name='cusid' value='<%=sIDNo%>'></input>
         <%=sIDNo%>
         <br/>
         
         <h4>性别:</h4>
		     <select name='cussex'>
		       <option value="0">男</option>
		  	   <option value="1">女</option>
		     </select>

         <h4>羊城通卡号:</h4>
         <input type='text' name='yctcdno' style="-wap-input-format:'N'; -wap-input-required: 'true'"  minleng='10' maxleng='10' />

         <label>温馨提示：如果您的羊城通卡片号无法读取，请通过我行自助充值机充值后的打印凭条读取羊城通卡号。</label>
         <input type='hidden' name='cusidtyp' value='<%=sIDTyp%>'></input>
		 <input type="submit" value="下一步"/>
	   </form>
<%
      }
      else {
%>
          <table>
             <tr><td>错误代码:</td><td><%=sMGID%></td></tr>
             <tr><td>错误信息:</td><td>客户信息查询失败</td></tr>
          </table>
<%
      }
  }
  else if (sContract.equals("2")) { //解约
      String    sCDNO        = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
      String    sSightcontext= request.getParameter("sightContext");
      String    sInfo[]     = sSightcontext.split("#:>");
      String    sendContext = "biz_id,25|i_biz_step_id,3|sign_flag,0|inst_no,交通银行|bank_acc,"+sCDNO+"|card1,"+sInfo[1].trim()+"|card2,|card3,|";
      MidServer midServer   = new MidServer();
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");
      if ("000000".equals(sMGID)){

%>
          <div id="ewp_back" class="refresh"/>
          <table>
             <tr><td>返回信息:</td><td>羊城通自动充值解约成功</td></tr>
          </table>
<%
      }
      else {
          String    sCodeMsg   = MessManTool.getValueByName(recvContext, "PB_Return_Code_Msg");
%>
          <table>
             <tr><td>错误代码:</td><td><%=sMGID%></td></tr>
             <tr><td>错误信息:</td><td><%=sCodeMsg%></td></tr>
          </table>
<%
      }
  }
%>
	</content>
</res>