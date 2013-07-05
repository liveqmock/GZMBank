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

%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>

		<form method='post' action='/GZMBank/SignAtOne/Gds_Spe_Data.jsp'>

			<input type='hidden' name='ActNo' value='<%=CrdNo%>' /><br/>
			<input type='hidden' name='TelTyp' value='' /><br/>
			<input type='hidden' name='TelNo' value='' /><br/>
			<input type='hidden' name='MobTyp' value='<%=GdsPubData.telNum2telType(sjNo)%>' /><br/>
			<input type='hidden' name='MobTel' value='<%=sjNo%>' /><br/>

			<label>请输入您的电子邮件地址：</label><br/>
			<input type='text' name='EMail' /><br/>
			<label>请输入您的联系地址：</label><br/>
			<input type='text' name='Addr' /><br/>

<%
	Map form = new HashMap();
	form.putAll(request.getParameterMap());
    gzLog.Write(form.toString());

    //处理checkbox表单项
    StringBuffer gdsBIdsBuffer = new StringBuffer();
    Map business = GdsPubData.getSignBusiness();
    Iterator itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {
        String businessKey = "GdsBId" + (String) itBusiness.next();
        if(null!=form.get(businessKey)){
            gzLog.Write(((String[]) form.get(businessKey))[0]);
            gdsBIdsBuffer.append(((String[]) form.get(businessKey))[0]);
        }
    }
    if("".equals(gdsBIdsBuffer.toString())){
        pageContext.forward("Gds_Pub_Menu.jsp");
    }else{
        String[] gdsBIds = { gdsBIdsBuffer.toString() };
        form.put("GdsBIds", gdsBIds);
    }

    //卡号缺省需要添加
    if (!form.containsKey("CrdNo") && CrdNo != null) {
        String[] values = { CrdNo };
        form.put("CrdNo", values);
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
