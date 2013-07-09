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

		<form method='post' action='/GZMBank/SignAtOne/Gds_Pub_Confirm.jsp'>

<%
	Map form = new HashMap();
	form.putAll(request.getParameterMap());
	gzLog.Write(form.toString());

	//处理checkbox表单项，通过轮循GdsBid440**，生成GdsBids，以后可以直接通过
	//gdsBIdsBuffer.indexOf(businessKey)!=-1来判断是否勾选了对应项
	StringBuffer gdsBIdsBuffer = new StringBuffer();
	Map business = GdsPubData.getSignBusiness();
	Iterator itBusiness = business.keySet().iterator();
	while (itBusiness.hasNext()) {
	    String businessKey = "GdsBId" + (String) itBusiness.next();
	    if(null!=form.get(businessKey)){
	        gdsBIdsBuffer.append(((String[]) form.get(businessKey))[0]);
	    }
	}
	//如果没有勾选签约项，返回选择菜单
	if("".equals(gdsBIdsBuffer.toString())){
	    pageContext.forward("Gds_Pub_Menu.jsp");
	}else{
	    String[] gdsBIds = { gdsBIdsBuffer.toString() };
	    form.put("GdsBIds", gdsBIds);
	}

	//可以签约的交易列表
    itBusiness = business.keySet().iterator();
    while (itBusiness.hasNext()) {

        String businessKey = (String) itBusiness.next();
        String businessName = (String) business.get(businessKey);
        //只显示有勾选的类型
        if(gdsBIdsBuffer.indexOf(businessKey)!=-1){
            out.println("<label>"+businessName+"：</label><br/>");
            out.println("<label>请输入"+businessName+"缴费号:</label><br/>");
            out.println("<input type='text' name='TCusId"+businessKey
                    +"' style=\"-wap-input-required: 'true'\" /><br/>");
            out.println("<label>请输入"+businessName+"缴费户名:</label><br/>");
            out.println("<input type='text' name='TCusNm"+businessKey
                    +"' style=\"-wap-input-required: 'true'\" /><br/>");
            out.println("<br/>");
        }
    }


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
