<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");

//特色部分
	String signResult = request.getParameter("signResult");
	Map<String, String> business = new HashMap<String, String>();
	business.put(GdsPubData.businessOfMobile, "移动划扣");
	business.put(GdsPubData.businessOfUnicom, "联通划扣");
	business.put(GdsPubData.businessOfTele, "电信划扣");
	business.put(GdsPubData.businessOfProvTv, "省有线电视划扣");
	business.put(GdsPubData.businessOfCityTv, "市有线电视（珠江数码）划扣");
	business.put(GdsPubData.businessOfGas, "燃气划扣");
	business.put(GdsPubData.businessOfWater, "水费划扣");
	business.put(GdsPubData.businessOfElectricity, "电费划扣");
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/SignAtOne/Gds_Pub_Router.jsp'>

			<label>已签约</label><br/>
<%
				Iterator<String> itBusiness = business.keySet().iterator();
				while(itBusiness.hasNext()){
				    String businessKey = itBusiness.next();
					if(signResult.indexOf(businessKey)>0){
						out.println("<label>"
							+business.get(businessKey)
							+"</label><br/>");
					}
				}
%>
			<label>请选择签约业务的类型</label><br/>
			<select name="GdsBId">
<%
				itBusiness = business.keySet().iterator();
				while(itBusiness.hasNext()){
				    String businessKey = itBusiness.next();
					if(signResult.indexOf(businessKey)<0){
						out.println("<option value='"+businessKey+"'>"
							+business.get(businessKey)
							+"</option>");
					}
				}
%>
			</select><br/>
			
<%
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