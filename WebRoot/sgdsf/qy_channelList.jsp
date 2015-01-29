<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String MBK_VERIFY=application.getInitParameter("MBK_VERIFY");
 %>
<res>
	<content>
       <form method='post'
			action='<%=request.getContextPath()+"/jsp/web/kjava_taxTxnAmtConfirm.jsp"%>'>
		<label>选择业务类型: </label>
		 <table>
		 <tr>
		 <td>	
		 <a href='<%=request.getContextPath()+"/sgdsf/zc_0.jsp"%>'>新客户注册</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>
		 <td>	
		 <a href='<%=request.getContextPath()+"/sgdsf/qy_yewuList.jsp"%>'>业 务 签  约</a>
		 </td>
		 </tr>
		 </table>
		</form>
	</content>
</res>
