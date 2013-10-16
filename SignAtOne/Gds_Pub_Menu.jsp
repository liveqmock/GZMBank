<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%
    request.setCharacterEncoding("utf-8");
%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.GzLog"%>
<%@ page import="com.gdbocom.util.communication.custom.gds.*"%>
<%
    GzLog gzLog = new GzLog("c:/gzLog_sj");
    String uri = request.getRequestURI();
    String crdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
    String sjNo = request.getHeader("MBK_MOBILE"); //手机号码
    gzLog.Write(sjNo + "进入[" + uri + "]");

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
<content>

        <label>已受理</label><br />
<%
	//特色部分
	//获取已签约数据
	String signResult = (String)pageContext.getAttribute("Gds_signResult",
            PageContext.SESSION_SCOPE);
	//可以签约的交易列表
    Map business = GdsPubData.getSignBusiness();
    Iterator itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {
        String businessKey = (String) itBusiness.next();
        if (signResult.indexOf(String.valueOf(businessKey)) != -1) {
            out.println("<label>" + business.get(businessKey)
                    + "</label><br/>");
        }
    }
%>

    <label>请选择签约业务的类型</label><br />

    <a href='/GZMBank/SignAtOne/Gds_Ele_Note.jsp'>电费划扣</a>

<form method='post'
    action='/GZMBank/SignAtOne/Gds_GdsBIds'>
<%
    itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {
        String businessKey = (String) itBusiness.next();
        if (signResult.indexOf(String.valueOf(businessKey)) < 0) {
            out.println("<input type='checkbox' name='GdsBId"
                    +businessKey+"' value='"
                    +businessKey+"' >"
                    +business.get(businessKey)+"</input><br/>");
        }
    }

 %>
    <input type='submit' value='确定' /><br />
</form>
</content>
</res>