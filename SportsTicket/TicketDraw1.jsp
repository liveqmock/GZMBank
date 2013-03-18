<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="java.sql.Connection" %>
<%@ page import="java.sql.Statement" %>
<%@ page import="java.sql.ResultSet" %>
<%@ page import="java.sql.SQLException" %>
<%@ page import="javax.naming.NamingException" %>
<%@ page import="com.gdbocom.util.ConnPool" %>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购彩抽奖步骤1");
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
	<form method='post' action='/GZMBank/SportsTicket/TicketDraw2.jsp'>

<%

	try{
		//是否购买的标志
		boolean isbuy = false;
		//可以抽奖的总记录条数
		int tolcnt = 0;
		//已经抽奖的记录条数
		int nocnt = 0;
		//中奖的记录条数
		int wincnt = 0;
		//兑奖的记录数
		int reccnt = 0;

		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		rs = st.executeQuery("select Drawlevel, RecvSign from dbo.TICKETDRAW where SgnMob='"+sjNo+"'");
		
		while(rs.next()){
			isbuy = true;
			tolcnt++;
			if(1==rs.getInt("Drawlevel")){//1为中奖
				nocnt++;
				wincnt++;
				if(1==rs.getInt("RecvSign")){//1为已兑奖
					reccnt++;
				}
			}else if(2==rs.getInt("Drawlevel")){//2为不中奖
				nocnt++;
			}
		}
		
		if(!isbuy){

			out.println("<label>感谢您一直以来对交行的支持，本次抽奖需先进行体彩购彩，谢谢参与！</label><br/>");

		}else if(tolcnt==nocnt){

			out.println("<label>感谢您一直以来对交行的支持，您已经中了"+wincnt+"张充值卡，其中"+(wincnt-reccnt)+"将会在稍后兑付，请稍等！</label><br/>");
			
		}else{

			//可以抽奖的总记录条数-已经抽奖的记录条数
			out.println("<input type='hidden' name='cntdiff'  value='"+(tolcnt-nocnt)+"' ></input>");
			out.println("<label>感谢您一直以来对交行的支持，您还有"+(tolcnt-nocnt)+"次的抽奖资格，请点击抽奖！</label><br/>");
			out.println("<input type='submit' value='抽奖' />");

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
	</form>
	</content>
</res>