<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="weblogic.utils.StringUtils" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>
<%
	String uri = request.getRequestURI();
    String crdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write(sjNo+"进入["+uri+"]");

%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>

		<form method='post' action='/GZMBank/SignAtOne/Gds_PreCorfirm'>

<%
    String gds_GdsBIds = (String)pageContext
            .getAttribute("Gds_GdsBIds", PageContext.SESSION_SCOPE);
	String[] gdsBids = gds_GdsBIds.split(",");
    Map business = GdsPubData.getSignBusiness();
	for(int i=0; i<gdsBids.length; i++){
	    if( null!=gdsBids[i] && (!"".equals(gdsBids[i])) ){
	        String businessId = gdsBids[i];
	        String businessName = (String) business.get(businessId);

	        out.println("<label>"+businessName+"：</label><br/>");
            out.println("<label>请输入"+businessName+"缴费号:</label><br/>");
            out.println("<input type='text' name='TCusId"+businessId
                    +"' style=\"-wap-input-required: 'true'\" /><br/>");
            out.println("<label>请输入"+businessName+"缴费户名:</label><br/>");
            out.println("<input type='text' name='TCusNm"+businessId
                    +"' style=\"-wap-input-required: 'true'\" /><br/>");
            out.println("<br/>");
	    }
	}


%>

			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 
