<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String uri = request.getRequestURI();
	gzLog.Write(sjNo+"进入["+uri+"]");
	int businessType = (int)request.getParameter("GdsBId");
	String action_next;

/** 根据购彩类型设置跳转页面 */	
	switch(businessType){
		case GdsPubData.businessOfMobile:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfUnicom:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfTele:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfProvTv:{
			action_next="Gds_PTv_Ent.jsp";
			break;
		}
		case GdsPubData.businessOfCityTv:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfGas:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfWater:{
			action_next="Gds_Pub_Data.jsp";
			break;
		}
		case GdsPubData.businessOfElectricity:{
			action_next="Gds_Ele_Note.jsp";
			break;
		}
		default:{
			action_next="Gds_Pub_Menu.jsp";
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