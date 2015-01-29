<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%
String MBK_VERIFY=application.getInitParameter("MBK_VERIFY");
 %>
<res>
	<content>
       <form method='post'
			action='<!--%=request.getContextPath()+"/jsp/web/kjava_taxTxnAmtConfirm.jsp"%>'>
		<label>选择业务分类: </label>
		 <!-- <table>
		 <tr>	
		 <td>	
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=01"%>'>税                务</a>
		 </td>
		 </tr>
		 </table>-->
		 <table>
		 <tr>	
		 <td>		
		 <a href='<%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=02"%>'>社                保</a>
		 </td>
		 </tr>
		 </table>
		 <!-- <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=03"%>'>居民养老保险</a>
		 </td>
		 </tr>
		 </table> -->
		 <table>
		 <tr>	
		 <td>		
		 <a href='<%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=04"%>'>通                讯</a>
		 </td>
		 </tr>
		 </table>
		 <!-- <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=05"%>'>水                费</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=06"%>'>电                费</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=07"%>'>燃     气      费</a>
		 </td>
		 </tr>
		 </table>
		 <!-- <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=08"%>'>电                视</a>
		 </td>
		 </tr>
		 </table>
		 <table>
		 <tr>	
		 <td>		
		 <a href='<!--%=request.getContextPath()+"/sgdsf/dsf_sheb.jsp?BUSCLA=09"%>'>物                业</a>
		 </td>
		 </tr>
		 </table>-->
		</form>
	</content>
</res>
