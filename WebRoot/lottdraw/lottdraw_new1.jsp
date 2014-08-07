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
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n手机银行登录有豪礼新客户抽奖步骤1");
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
	<form method='post' action='/GZMBank/lottdraw/lottdraw_new2.jsp'>
	
     <label>您的手机号码为：</label>
	 <label><%=sjNo%></label><br/>
	 <label>温馨提示:"本次活动奖品为iPhone5及20元话费,祝您中奖!"</label><br/>
	 <label>参与对象:首次登录手机银行客户</label><br/>
		
<%

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		rs = st.executeQuery("select * from CLIENT_BEFORE_JUNE_BACKUP where PhoneNO='"+sjNo+"'");
		gzLog.Write("手机号："+sjNo);
		if(rs.next()){

			out.println(TipsShow.getTips(TipsShow.NONE));

		}else{

			rs = st.executeQuery("select Drawlevel, RecvSign from LOTTDRAW where PhoneNO='"+sjNo+"'");
			if(rs.next()){
			
				int drawlevel = rs.getInt("Drawlevel");
				int RecvSign = rs.getInt("RecvSign");
			
				if(drawlevel>=1&&drawlevel<=6){
					if(1==RecvSign){
						out.println(TipsShow.getTipsRev(drawlevel));
					}else{
						out.println(TipsShow.getTips(drawlevel));
					}
				}else{
			%>
    
					<input type='submit' value='抽奖' />
					<%

				}
			}else{ 
			
				st.executeUpdate("insert into LOTTDRAW(PhoneNO) values('"+sjNo+"')");
				%>
				
    
					<input type='submit' value='抽奖' />
					<%

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
	</content>
</res>