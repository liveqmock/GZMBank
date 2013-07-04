<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");
	
	//设置需要显示的值和名称,
	String agreeText = "--协议--";	
%>
            <input type='hidden' name='OrgCod' value='726482280' /><br/>
            <input type='hidden' name='TBusTp' value='00505' /><br/>
            <label>请输入缴费号:</label><br/>
            <input type='text' name='TCusId' value='123456' /><br/>
            <label>请输入缴费户名:</label><br/>
            <input type='text' name='TCusNm' value='顾启明' /><br/>
            <input type='hidden' name='GdsAId' value='015810190426853002013016222600710007815865' /><br/>
            <input type='hidden' name='EffDat' value='20130615' /><br/>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/SignAtOne/Gds_Pub_Menu.jsp'>
			<label>签约成功！</label><br/>
<%
	Map form = request.getParameterMap();
	//设置隐藏表单值
	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

%>
		</form>
	</content>
</res>
