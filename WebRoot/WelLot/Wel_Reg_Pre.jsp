<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.net.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");

	//打印SESSION保存字段
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//保存上一表单(交易)字段
	String preSaveKey = request.getParameter("preSaveKey");
	PreAction.savePreFormValue(pageContext, request, preSaveKey);
	gzLog.Write(PreAction.strOfPageContext(pageContext));

	//设置正常情况需要跳转的页面
	String forwardPage = "Wel_Confirm.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";



	//检查返回是否异常
	String SigTyp = (String)pageContext.getAttribute("SigTyp", PageContext.SESSION_SCOPE);
	String MobTel = (String)pageContext.getAttribute("MobTel", PageContext.SESSION_SCOPE);
	String MobTel_Con = (String)pageContext.getAttribute("MobTel_Con", PageContext.SESSION_SCOPE);
	
	if(SigTyp=="0"||MobTel.equals(MobTel_Con)){//如果返回正确
		gzLog.Write("["+uri+"]forward到"+forwardPage);

		pageContext.setAttribute("CusNam", " ", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("CrdNo", CrdNo, PageContext.SESSION_SCOPE);
		pageContext.setAttribute("ActNo", CrdNo, PageContext.SESSION_SCOPE);
		pageContext.setAttribute("NodNo", " ", PageContext.SESSION_SCOPE);
//		pageContext.setAttribute("IdTyp", " ");
//		pageContext.setAttribute("IdNo", " ");
		pageContext.setAttribute("FixTel", " ", PageContext.SESSION_SCOPE);
		pageContext.setAttribute("Email", " ", PageContext.SESSION_SCOPE);
		gzLog.Write("SigTyp:["+SigTyp+"]");
		if("0".equals(SigTyp)){//选择了签约手机号
			pageContext.setAttribute("MobTel", sjNo, PageContext.SESSION_SCOPE);
		}else{//选择其他手机号
			pageContext.setAttribute("MobTel", MobTel, PageContext.SESSION_SCOPE);
		}
		
	    pageContext.forward(forwardPage);

	}else{//如果返回不正确
		String RspCod = "LOT999";
		String RspMsg = "两次输入不一致";
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}

%>