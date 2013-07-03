<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%
    request.setCharacterEncoding("UTF-8");
%>
<%@ page import="com.viatt.util.GzLog"%>
<%@ page import="com.gdbocom.util.communication.custom.gds.*"%>
<%
    GzLog gzLog = new GzLog("c:/gzLog_sj");
    String cdno = request.getHeader("MBK_ACCOUNT");
    String sjNo = request.getHeader("MBK_MOBILE");
    String uri = request.getRequestURI();
    gzLog.Write(sjNo + "进入[" + uri + "]");
    int businessType = new Integer(request.getParameter("GdsBId"))
            .intValue();
    String action_next;

    /** 根据购彩类型设置跳转页面 */
    switch (businessType) {
    case 44102: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44103: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44104: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44107: {
        action_next = "Gds_469901_PTv.jsp";
        break;
    }
    case 44108: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44105: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44101: {
        action_next = "Gds_Pub_Suc.jsp";
        break;
    }
    case 44106: {
        action_next = "Gds_Ele_Note.jsp";
        break;
    }
    default: {
        action_next = "Gds_Pub_Menu.jsp";
    }
    }
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res> <content> <jsp:forward page="<%=action_next%>">
</jsp:forward> </content> </res>