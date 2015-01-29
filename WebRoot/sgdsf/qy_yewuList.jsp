<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String MBK_VERIFY=application.getInitParameter("MBK_VERIFY");
 %>
<res>
	<content>
       <form method='post'
			action='<%=request.getContextPath()+"/jsp/web/kjava_taxTxnAmtConfirm.jsp"%>'>
		<label>选择操作类型: </label>
		<table>
		 <tr>
		 <td>	
		 <a href='<%=request.getContextPath()+"/sgdsf/mxqy_channelList.jsp"%>'>新                增</a>
		</td>
		</tr>
		</table>
		 <table>
		 <tr>	
		 <td>
		 <a href='<%=request.getContextPath()+"/sgdsf/qy_1.jsp"%>'>修                改</a>
		 </td>
		 </tr>
		 </table>
		 
		</form>
	</content>
</res>
