<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
  GzLog gzLog = new GzLog("c:/gzLog_sj");
  String cdno = request.getHeader("MBK_ACCOUNT");
  String sjNo = request.getHeader("MBK_MOBILE");
  gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤1");
%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
  <content>
    
    <form method='post' action='/GZMBank/SportsTicket/TicketSale2.jsp'>
<!-- 彩票类型-->
      <label>请选择彩票类型: </label>
      <br/>
      <input type='radio' name='LotTyp2' value='A' checked>体彩大乐透</input><br/>
      <input type='radio' name='LotTyp2' value='B'>12选2</input><br/>
      <input type='submit' value='下一步'/>
    </form>
  </content>
</res>
