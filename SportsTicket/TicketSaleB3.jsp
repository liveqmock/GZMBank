<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String ErrMsg = request.getParameter("ErrMsg")!=null?request.getParameter("ErrMsg"):"";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<label>12选2</label>
	<%
	if(!ErrMsg.equals(""))
	{
	%>
	
	<label><%=ErrMsg%></label>
	<%
	}
	%>
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleB4.jsp'>

<!-- 投注号码 -->
	<label>请选择投注号码(选择个数2~12):</label>
	

	
	<%
	    for(int i=0; i<2; i++){
	%>
	    
	        <%
	            for(int j=1;j<=6;j++){
							int tmp = i*6+j;
	        %>
	            <input type='checkbox' name='LotNum<%=tmp%>' value='<%=this.formatnumber(tmp)%>'></input>
	            <label><%=tmp%></label>
				<%				
				    }
				%>
	    
	<%				
	}
	%>
	

<!-- 倍数 -->
	<label>请输入倍数(输入范围1~99):</label>
	
	<input type='text' name='MulTip' style="-wap-input-format: 'N'; -wap-input-required: 'true'" maxleng='2'></input>

<!-- 购票方式-->
	<input type='hidden' name='TikMod' value='01'></input>
<!-- 购票方式-->
	<input type='hidden' name='NotNum' value=''></input>
<!-- 购票方式-->
	<input type='hidden' name='LotTyp' value='28'></input>
<!-- 扩展号码 -->
	<input type='hidden' name='ExtNum' value=''></input>

	<input type='submit' value='下一步'></input>
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