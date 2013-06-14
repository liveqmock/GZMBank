<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
			<label>暂不支持电费的电子渠道委托签约，您可直接通过我行交博汇网上商城，手机银行或自助通终端进行自助缴费，或携带身份证、任一期缴费发票到交通银行网点办理签约手续。</label><br/>
	</content>
</res>
