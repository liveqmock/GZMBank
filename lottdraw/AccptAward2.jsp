<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.gdbocom.util.ConnPool" %>
<%@ page import="com.gdbocom.lottdraw.TipsShow" %>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n手机银行登录有豪礼领奖步骤2");
	if(sjNo==null){
		throw new Exception("手机号为空");
	}

	Connection connection = null;
	Statement st = null;
	ResultSet rs = null;
	ConnPool connpool = new ConnPool();

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>

<%

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		
		st.executeUpdate("update LOTTDRAW set RecvSign='1' where PhoneNO='"+sjNo+"'");

		rs = st.executeQuery("select RecvSign from LOTTDRAW where PhoneNO='"+sjNo+"'");
		if(rs.next()){
		
			String RecvSign = rs.getString("RecvSign");
		
			if(RecvSign.equals("1")){

				out.println("<label>您的礼品已经兑现，请确认已经收到礼物。</label><br/>");

			}else{

				out.println("<label>兑奖不成功。请稍后进行操作。</label><br/>");

			}
		}else{

			out.println("<label>系统异常。</label><br/>");

		}

		
	}catch(NamingException e){
		gzLog.Write("MidServPoolDs连接池故障:"+e.getMessage());
	}catch(SQLException e){
		gzLog.Write("连接数据库故障:"+e.getMessage());
	}catch(Exception e){
		gzLog.Write("其他故障:"+e.getMessage());
		e.printStackTrace();
	}finally{
		if(rs != null){
			rs.close();
		}
		if(st != null){
			st.close();
		}
		if(connection != null){
			connection.close();
		}
	}
     
  
  
%>
	</content>
</res>