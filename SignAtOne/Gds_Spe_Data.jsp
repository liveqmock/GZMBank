<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write(sjNo+"进入["+uri+"]");

	String[] GdsBIds = request.getParameterValues("GdsBIds");
	StringBuffer signingBusiness = new StringBuffer();
	for(int i=0; i<GdsBIds.length; i++){
	    signingBusiness.append(GdsBIds[i]);
	}
    //可以签约的交易列表
    Map business = GdsPubData.getSignBusiness();
%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>

		<form method='post' action='/GZMBank/SignAtOne/Gds_Pub_Suc.jsp'>

<%
    Iterator itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {

        String businessKey = (String) itBusiness.next();
        String businessName = (String) business.get(businessKey);
        if(signingBusiness.indexOf(businessKey)!=-1){
            out.println("<label>"+businessName+"：</label><br/>");
            out.println("<label>请输入"+businessName+"缴费号:</label><br/>");
            out.println("<input type='text' name='"+businessKey+"TCusId' value='123456' /><br/>");
            out.println("<label>请输入"+businessName+"缴费户名:</label><br/>");
            out.println("<input type='text' name='"+businessKey+"TCusNm' value='顾启明' /><br/>");
        }
    }


    Map form = new HashMap();
	form.putAll(request.getParameterMap());

	//卡号缺省需要添加
	if(!form.containsKey("CrdNo")&&CrdNo!=null){
		form.put("CrdNo",CrdNo);
	}

	//前一页面提交的表单域同时在本页面进行提交,防止数据的丢失
	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

%>

			<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 
