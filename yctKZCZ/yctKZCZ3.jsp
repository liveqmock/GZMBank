<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>

<%
   //System.out.println("羊城通自动充值yctKZCZ3.....");
   String sCusnam  = MessManTool.changeChar(request.getParameter("cusnam"));
   String sCusid   = MessManTool.changeChar(request.getParameter("cusid"));
   String sCussex  = MessManTool.changeChar(request.getParameter("cussex"));
   String sYCTcdno = MessManTool.changeChar(request.getParameter("yctcdno"));
   String sCusidtyp= MessManTool.changeChar(request.getParameter("cusidtyp"));
   String sParam   = sCusnam + "#:>"+ sCusid + "#:>"+ sCussex + "#:>"+ sYCTcdno +"#:>"+ sCusidtyp +"#:>"+"TheEnd";    //签约信息传递

%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/yctKZCZ/yctKZCZ4.jsp'>
       <label>《羊城通自动充值服务协议》《羊城通自动充值服务章程》《羊城通自动充值服务业务规则》，为本签约的有效组成部分，在申请人办理以上业务时，广州羊城通有限公司即视申请人已经清楚了解并同意按照以上文件行使和履行相关权力义务。
（以上文件内容详情请咨询羊城通有限公司）。</label>
       
             
      <input type='hidden'  name='param1' value='<%=sParam%>'></input>
      
      <input type='submit' value='同意'></input>

	    <input type='button' name='cancel' value='不同意'></input><br/>
	    
	    

		</form>

	</content>
</res>