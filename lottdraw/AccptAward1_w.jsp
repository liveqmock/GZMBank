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
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n手机银行登录有豪礼领奖步骤1");
	if(sjNo==null){
		throw new Exception("手机号为空");
	}

	Connection connection = null;
	Statement st = null;
	ResultSet rs = null;
	ConnPool connpool = new ConnPool();

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0"?>
<!DOCTYPE html PUBLIC "-//WAPFORUM//DTD XHTML Mobile 1.0//EN" "http://www.wapforum.org/DTD/xhtml-mobile10.dtd">
 
<html xmlns="http://www.w3.org/1999/xhtml">
<head>
<title>手机银行登录有豪礼领奖（员工兑奖时进入）</title>
</head>
 
<body>
<form method='post' action='/GZMBank/lottdraw/Accptaward2_w.jsp'>

<%

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		rs = st.executeQuery("select * from CLIENT_BEFORE_JUNE where PhoneNO='"+sjNo+"'");
		
		
		if(rs.next()){

			out.println("<label>感谢您一直以来对交行的支持，谢谢参与！</label><br/>");

		}else{

			rs = st.executeQuery("select Drawlevel, RecvSign from LOTTDRAW where PhoneNO='"+sjNo+"'");
			if(rs.next()){
			
				int drawlevel = rs.getInt("Drawlevel");
				String RecvSign = rs.getString("RecvSign");
			
				if(drawlevel==1||drawlevel==2||drawlevel==4){
				
					if("0".equals(RecvSign)||RecvSign==null){
						out.println(new TipsShow().getTips2(drawlevel));
						out.println("<input type='submit' value='兑奖登记' />");
					}else{
						out.println("<label>您的礼品已经兑现，请不要重复兑奖。</label><br/>");
					}


				}else if(drawlevel==3){
				
					out.println("<label>恭喜您！您喜获本次活动的二等奖50元移动充值卡!我行客服中心95559将于次周联系您，并将话费充入您指定的手机号码。</label><br/>");
				
				}else if(drawlevel==5){
				
					out.println("<label>感谢您一直以来对交行的支持，谢谢参与！</label><br/>");
				
				}else{

					out.println("<label>您还没进行抽奖，请先进行抽奖。</label><br/>");

				}
			}else{

				out.println("<label>您还没进行抽奖，请先进行抽奖。</label><br/>");

			}

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
</body>
</html>
