<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入["+uri+"]");

	String showMsg = null;
	String qyzt = request.getParameter("QYZT").trim();

	//准备显示字段
	Map showE = new HashMap();
	String action_next;
	if("1".equals(qyzt)||"2".equals(qyzt)){
		showMsg="本行已签约，请选择操作：";
		showE.put("JFH", "缴费号");
		showE.put("JSHMC", "结算户名称");
		showE.put("YDDZ", "结算户用电地址");
		action_next="Efek_Redirect.jsp";
	}else if("3".equals(qyzt)||"0".equals(qyzt)){
		showMsg="本行未签约，请选择操作：";
		action_next="Efek_Redirect.jsp";
	}else{
		action_next="Efek_Qry_Input.jsp";
	}

%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/Efek/<%=action_next%>'>

<%
	Map form = request.getParameterMap();

	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(showE.containsKey(key)){
			out.println("<lable>"+showE.get(key)+"</lable>");
			out.println("<lable>"+values[0]+"</lable>");
		}
	}

%>
		<lable><%=showMsg%></lable>
	if("1".equals(qyzt)||"2".equals(qyzt)){
		out.println("<input type='radio' name='QDBZ' value='1' >修改</input>");
		out.println("<input type='radio' name='QDBZ' value='2' >注销</input>");
	}else if("3".equals(qyzt)||"0".equals(qyzt)){
		out.println("<input type='radio' name='QDBZ' value='0' >新增</input>");
	}else{
		action_next="Efek_Qry_Input.jsp";
	}

		<input type='submit' value='确定'/><br/>
		</form>
    </content>
</res> 