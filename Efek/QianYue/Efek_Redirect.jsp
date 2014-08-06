<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n步骤2，选择购彩类型为："+YWLX[0]);
	String action_next;

	String qdbz = request.getParameter("QDBZ");
	String qyzt = request.getParameter("QYZT");
	if("3".equals(qdbz)){
		//设置需要从网关正常返回中获取下来的值的名称
		saveKey = "JYLSH,JYRQ,JYSJ,YJYLSH,YJYRQ,YJYSJ,DWBM,JFH,JSHMC,YDDZ,QYZT,YQYYHDM,YQYZH,YQYZHMC,BZ";
		//网关i_biz_step_id值
		i_biz_step_id = "3";
		forwardPage="Efek_Redirect.jsp";
	}else{
		//设置需要从网关正常返回中获取下来的值的名称
		saveKey = "";
		//网关i_biz_step_id值
		i_biz_step_id = "4";
		forwardPage="Efek_Result.jsp";
	}

/** 根据购彩类型设置跳转页面 */	
	switch(YWLX[0]){
		case '3':{//查询
			action_next="Efek_Qry_Input.jsp";
			break;
		}

		case '0'://新增
		case '1'://修改
		case '2':{//注销
			action_next="Efek_Confirm.jsp";
			break;
		}
		default:{
			action_next="Efek_Select.jsp";
		}
	}
	

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<jsp:forward page="<%=action_next%>">
		</jsp:forward>
	</content>
</res>