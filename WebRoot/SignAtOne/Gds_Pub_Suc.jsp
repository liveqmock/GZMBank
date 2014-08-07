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

	//释放session变量
    pageContext.removeAttribute("Gds_signResult",
            PageContext.SESSION_SCOPE);
    pageContext.removeAttribute("Gds_GdsBIds",
            PageContext.SESSION_SCOPE);
    pageContext.removeAttribute("Gds_TCusId",
            PageContext.SESSION_SCOPE);
    pageContext.removeAttribute("Gds_TCusNm",
            PageContext.SESSION_SCOPE);
    pageContext.removeAttribute("Gds_Mobile",
            PageContext.SESSION_SCOPE);


	//设置需要显示的值和名称,
	String showText = "签约成功！";	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/SignAtOne/Gds_Pub_Menu.jsp'>
			<label>我行已受理您的签约申请。</label><br/>
			<label>各委托项目的自动代缴费业务功能自首次扣款成功之日起开通，请确保您的签约银行卡帐户余额充足，并留意签约银行卡扣款短信通知。感谢您对交行的支持!</label><br/>

		</form>
	</content>
</res>
