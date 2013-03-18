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
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购彩抽奖步骤3");

	String cntdiff = request.getParameter("cntdiff");
	int remcnt = Integer.valueOf(cntdiff).intValue()-1;
	String mobtel = request.getParameter("MobTel");
	String id = request.getParameter("ID");
	
	if((cntdiff==null)||(mobtel==null)||(id==null)){
		gzLog.Write("基础数据不足\ncntdiff："+cntdiff+",mobtel："+mobtel+",id："+id);
		throw new Exception("基础数据不足");
	}

	Connection connection = null;
	Statement st = null;
	ResultSet rs = null;
	ConnPool connpool = new ConnPool();
	
	//boolean Topswitch = false;
	//boolean Fstswitch = true;

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<form method='post' action='/GZMBank/SportsTicket/TicketDraw1.jsp'>
<%

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		st.executeUpdate("update dbo.TICKETDRAW set MobTel='"+mobtel+"' where ID="+id);
		
		if(remcnt>0){
			out.println("<label>充值手机号码已经登记，还具有"+remcnt+"次抽奖资格，请点击再次抽奖。</label><br/>");
			out.println("<input type='submit' value='再次抽奖' />");
		}else{
			out.println("<label>充值手机号码已经登记，稍后会有专人将资金充入指定的手机号。</label><br/>");
		}
		
	}catch(NamingException e){
		gzLog.Write("MidServPoolDs连接池故障:"+e.getMessage());
	}catch(SQLException e){
		gzLog.Write("数据库故障:"+e.getMessage());
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
	</form>
	</content>
</res>