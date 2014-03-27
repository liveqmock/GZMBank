<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%
	String BusTyp = MessManTool.changeChar(request.getParameter("BusTyp"));
	
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
		<form method='post' action='/GZMBank/JiaoFei/txDianXin/txDianXin3.jsp'>
		<%
		  if (BusTyp.equals("Phonepay")) {
		%>
		   <label>电话号码：</label>
		<%
		  }
		  else if (BusTyp.equals("XLTpay")) {
		%>
             <label>小灵通号码：</label>
		<%
		  }
		  else if (BusTyp.equals("CDMApay")) {
		%>
          <label>CDMA号码：</label>
		<%
		  }
		  else if (BusTyp.equals("CDMAprepay")) {
		%>
		  <label>CDMA号码：</label>
		<%
		  }
		%>
        <input type="text" name="PhoneNum"  style="-wap-input-required: 'true'"   />
        <input type='hidden' name='BusTyp' value='<%=BusTyp%>'></input>
        <input type="submit" value="确定"></input>
		</form>
	</content>
	
</res>