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
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
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

	if(this.is10086(mobtel)){

		Connection connection = null;
		Statement st = null;
		ResultSet rs = null;
		ConnPool connpool = new ConnPool();
		
	
		try{ 
			
			connection = connpool.getConn();
			gzLog.Write("连接数据库正常："+connection);
			st = connection.createStatement();
			st.executeUpdate("update dbo.TICKETDRAW set MobTel='"+mobtel+"' where ID="+id);
			
			if(remcnt>0){
				out.println("<form method='post' action='/GZMBank/SportsTicket/TicketDraw1.jsp'>");
				out.println("<label>充值手机号码已经登记，还具有"+remcnt+"次抽奖资格，请点击再次抽奖。</label><br/>");
				out.println("<input type='submit' value='再次抽奖' />");
				out.println("</form>");
			}else{
				out.println("<label>充值手机号码已经登记，稍后会有专人将资金充入指定的手机号。</label><br/>");
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

	}else{

		out.println("<form method='post' action='/GZMBank/SportsTicket/TicketDraw3.jsp'>");
		//可以抽奖的总记录条数-已经抽奖的记录条数
		out.println("<input type='hidden' name='cntdiff'  value='"+cntdiff+"' ></input>");
		//ID
		out.println("<input type='hidden' name='ID'  value='"+id+"' ></input>");
		out.println("<label>输入错误，请输入中国移动手机号码</label><br/>");
		//充值手机号
		out.println("<input type='text' name='MobTel' style=\"-wap-input-format: 'N'; -wap-input-required: 'true'\" minleng='11' maxleng='11'></input><br/>");
		out.println("<input type='submit' value='提交' />");
		out.println("</form>");
	
	}
	  
%>
	</content>
</res>
<%!
	public boolean is10086(String phonenumber){

		int numberhead = Integer.parseInt(phonenumber.substring(0,3));
		switch(numberhead){
			case 134:
			case 135:
			case 136:
			case 137:
			case 138:
			case 139:
			case 150:
			case 151:
			case 152:
			case 157:
			case 158:
			case 159:
			case 182:
			case 183:
			case 187:
			case 188: return true;
			default: return false;
			
		}
	}
%>