<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");
	
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/APPNAME/SUBAPPNAME/NEXTPAGE.jsp'>
			<label>请选择****</label><br/>
			<select name="FIELDNAME">
				<option value="50">50  元</option>
				<option value="100">100 元</option>
				<option value="150">150 元</option>
				<option value="200">200 元</option>
				<option value="500">500 元</option>
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