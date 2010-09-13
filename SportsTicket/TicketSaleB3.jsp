<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	//String ErrMsg = request.getParameter("ErrMsg")==null?"":new String(request.getParameter("ErrMsg").getBytes("ISO-8859-1"), "UTF-8").trim();
	String ErrMsg = request.getParameter("ErrMsg")!=null?request.getParameter("ErrMsg"):"";
	//if(!ErrMsg.equals("")){
		//ErrMsg=new String(ErrMsg.getBytes("GBK"), "utf-8").trim();
	//}
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<h1>12选2</h1><br/>
	<%if(!ErrMsg.equals("")){out.println("<label>"+ErrMsg+"</label>");}%>
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleB4.jsp'>

<!-- 投注号码 -->
	<label>请选择投注号码(选择个数2~12):</label>
	<br/>
	<%
		for(int i=1;i<=12;i++){
	%>
			<input type='checkbox' name='LotNum<%=i%>' value='<%=this.formatnumber(i)%>'><%=i%></input>
	<%				
		}
	%>

<!-- 倍数 -->
	<label>请输入倍数(输入范围1~99):</label>
	<br/>
	<input type='text' name='MulTip' style="-wap-input-format: 'N'; -wap-input-required: 'true'" maxleng='2'></input>

<!-- 购票方式-->
	<input type='hidden' name='TikMod' value='01'></input>
<!-- 购票方式-->
	<input type='hidden' name='NotNum' value=''></input>
<!-- 购票方式-->
	<input type='hidden' name='LotTyp' value='28'></input>
<!-- 扩展号码 -->
	<input type='hidden' name='ExtNum' value=''></input>

	<input type='submit' value='下一步'/>
    </form>
	</content>
</res>
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}
%>