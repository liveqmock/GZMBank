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
    String CrdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
    String sjNo = request.getHeader("MBK_MOBILE"); //手机号码
    gzLog.Write(sjNo + "进入[" + uri + "]");

    //特色部分
    //获取已签约数据
    String signResult = request.getParameter("signResult");
    gzLog.Write(signResult);
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
<content>

        <label>已签约</label><br />
<%
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
    <!--a href='/GZMBank/yiDongCharge/yiDongCharge0.jsp'>移动全品牌划扣</a-->

<form method='post'
    action='/GZMBank/SignAtOne/Gds_Spe_Data.jsp'>
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

    Map form = new HashMap();
    form.putAll(request.getParameterMap());
    gzLog.Write(form.toString());

    //卡号缺省需要添加
    if (!form.containsKey("CrdNo") && CrdNo != null) {
        String[] values = { CrdNo };
        form.put("CrdNo", values);
    }

    //System.out.println("CrdNo"+CrdNo);
    //前一页面提交的表单域同时在本页面进行提交,防止数据的丢失
    Iterator itKeys = form.keySet().iterator();
    while (itKeys.hasNext()) {
        String key = (String) itKeys.next();
        String[] values = ((String[]) form.get(key));
        if (1 == values.length) {
            out.println("<input type='hidden' name='" + key
                    + "' value='" + values[0] + "'/><br/>");
        }
    }
 %>
    <input type='submit' value='确定' /><br />
</form>
</content>
</res>