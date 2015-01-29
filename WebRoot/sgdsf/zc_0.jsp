<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String MBK_VERIFY=application.getInitParameter("MBK_VERIFY");
%>
<res>
	<content>
       <form method='post'
			action='<%=request.getContextPath()+"/jsp/web/kjava_taxTxnAmtConfirm.jsp"%>'>
		<label>选择操作类别: </label>
		 <table>
		 <tr>	
		 <td>	
		 <a href='<%=request.getContextPath()+"/sgdsf/zc_5.jsp?GNXX=0"%>'>新              增</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<%=request.getContextPath()+"/sgdsf/zc_1.jsp?GNXX=1"%>'>修              改</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<%=request.getContextPath()+"/sgdsf/zc_1.jsp?GNXX=2"%>'>销 户 或 恢 复</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<%=request.getContextPath()+"/sgdsf/zc_1.jsp?GNXX=3"%>'>查              询</a>
		 </td>
		 </tr>
		 </table>
		</form>
	</content>
</res>
