<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.*" %>
<!-- 分行特色业务频道列表 -->
<%
	
	request.setCharacterEncoding("UTF-8");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	
	String BusCla = null;
	String BUSCLA = request.getParameter("BUSCLA");
	if(BUSCLA.equals("01")){
	   BusCla = "税务";
	}else if(BUSCLA.equals("02")){
	   BusCla = "社保";
	}
	else if(BUSCLA.equals("03")){
	   BusCla = "居民养老保险";
	}
	else if(BUSCLA.equals("04")){
	   BusCla = "通讯";
	}
	else if(BUSCLA.equals("05")){
	   BusCla = "水费";
	}
	else if(BUSCLA.equals("06")){
	   BusCla = "电费";
	}
	else if(BUSCLA.equals("07")){
	   BusCla = "燃气";
	}
	else if(BUSCLA.equals("08")){
	   BusCla = "电视";
	}
	else if(BUSCLA.equals("09")){
	   BusCla = "物业";
	}
	//System.out.print("BUSCLA:"+BUSCLA);
	gzLog.Write("进入["+uri+"]");
	String errPage = "";
 %>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/qy_xinz1.jsp"%>' >
    		<table>
    		<tr>
    		<td><label>客户证件号：</label></td>
    		<td><input type="text" name="CLI_IDENTITY_CARD"  style="-wap-input-format: 'Y'; -wap-input-required: 'true'" /></td>
    		</tr>
    		</table>
    		<br/>
    		<input type="hidden" name="BUSCLA" value="<%=BUSCLA %>" />
    		<input type="hidden" name="BusCla" value="<%=BusCla %>" />
    		<input type='submit' value='下一步'/>
		</form>
	</content>
</res>
