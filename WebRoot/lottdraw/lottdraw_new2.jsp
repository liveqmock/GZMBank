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
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n手机银行登录有豪礼新客户抽奖步骤2");

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
		rs = st.executeQuery("select ID from LOTTDRAW where PhoneNO='"+sjNo+"'");
		int id;
		int exist_number;
		int drawlevel;
		
		if(rs.next()){
			id = rs.getInt("ID");
		}else{
			gzLog.Write("ID号为空");
			throw new Exception("ID号为空");
		}
		
		rs = st.executeQuery("select count(ID) as EXNO from LOTTDRAW where ID<="+id);
		
		if(rs.next()){
			exist_number = rs.getInt("EXNO");
		}else{
		
			gzLog.Write("无法计算ID总数");
			throw new Exception("无法计算ID总数");
		}
		
		//计算获奖等级
		drawlevel = this.drawLaw(exist_number);
		
		st.executeUpdate("update LOTTDRAW set NO="+exist_number+", Drawlevel='"+drawlevel+"' where PhoneNO='"+sjNo+"'");
		
		out.println(TipsShow.getTips(drawlevel));
		
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
	</content>
</res>
<%!
	private int drawLaw(int exist_number){
    	boolean OUTSTANDING_switch = false;//特等奖开关
	    boolean MAJOR_switch = false;//一等奖开关
	    boolean ACCESSIT_switch = false;//二等奖开关
	    
		if(OUTSTANDING_switch&&exist_number==999999){//特等奖
			return TipsShow.OUTSTANDING;
		}else if(MAJOR_switch&&(exist_number==50000)){//一等奖
			return TipsShow.MAJOR;
		}else if(ACCESSIT_switch&&(exist_number==999999)){//二等奖
			return TipsShow.ACCESSIT;
		}else if(exist_number%150==1){//三等奖
			return TipsShow.THIRD_CLASS;
		}else{//不中
			return TipsShow.NONE;
		}
	}
%>
