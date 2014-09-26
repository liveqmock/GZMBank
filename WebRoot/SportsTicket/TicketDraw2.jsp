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
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购彩抽奖步骤2");

	String cntdiff = request.getParameter("cntdiff");
	int remcnt = Integer.valueOf(cntdiff).intValue()-1;

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
<%

	try{ 
		
		connection = connpool.getConn();
		gzLog.Write("连接数据库正常："+connection);
		st = connection.createStatement();
		rs = st.executeQuery("select ID from dbo.TICKETDRAW where SgnMob='"+sjNo+"' and (NO=0 or Drawlevel='0') order by ID asc");
		int id;
		int exist_number;
		int drawlevel;
		
		if(rs.next()){
			id = rs.getInt("ID");
		}else{
			gzLog.Write("ID号为空");
			throw new Exception("ID号为空");
		}
		
		rs = st.executeQuery("select count(ID) as EXNO from dbo.TICKETDRAW where ID<="+id);
		
		if(rs.next()){
			exist_number = rs.getInt("EXNO");
		}else{
			gzLog.Write("无法计算ID总数");
			throw new Exception("无法计算ID总数");
		}
		
		//计算获奖等级
		if(exist_number%50==0){
			drawlevel=1;
		}else{
			drawlevel=2;
		}
		
		st.executeUpdate("update dbo.TICKETDRAW set NO="+exist_number+", Drawlevel='"+drawlevel+"' where ID="+id);
		
		if(1==drawlevel){
			out.println("<form method='post' action='/GZMBank/SportsTicket/TicketDraw3.jsp'>");
			//可以抽奖的总记录条数-已经抽奖的记录条数
			out.println("<input type='hidden' name='cntdiff'  value='"+cntdiff+"' ></input>");
			//ID
			out.println("<input type='hidden' name='ID'  value='"+id+"' ></input>");
			out.println("<label>恭喜您！<br/>在本次购彩活动中喜中50元移动话费充值卡!详情请咨询“95559”</label><br/>");
			//充值手机号
			out.println("<label>请输入充值手机号码（必须为移动手机号码）</label><br/>");
			out.println("<input type='text' name='MobTel' style=\"-wap-input-format: 'N'; -wap-input-required: 'true'\" minleng='11' maxleng='11'></input><br/>");
			out.println("<input type='submit' value='提交' />");
			out.println("</form>");
		}else if(remcnt>0){
			out.println("<form method='post' action='/GZMBank/SportsTicket/TicketDraw1.jsp'>");
			out.println("<label>谢谢您的参与，本次抽奖没有中奖，还具有"+remcnt+"次抽奖资格，请点击再次抽奖。</label><br/>");
			out.println("<input type='submit' value='再次抽奖' />");
			out.println("</form>");
			
		}else{
			out.println("<label>谢谢您的参与。请不要放弃！继续购彩还有机会哦！</label><br/>");
		}
		
	}catch(NamingException e){
		gzLog.Write("MidServPoolDs连接池故障:"+e.getMessage());
		out.println("<label>系统繁忙，请稍后再试！</label><br/>");
	}catch(SQLException e){
		gzLog.Write("数据库故障:"+e.getMessage());
		out.println("<label>系统繁忙，请稍后再试！</label><br/>");
	}catch(Exception e){
		gzLog.Write("其他故障:"+e.getMessage());
		e.printStackTrace();
		out.println("<label>系统繁忙，请稍后再试！</label><br/>");
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