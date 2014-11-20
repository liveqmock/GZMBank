<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.util.*" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入["+uri+"]");

%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_Bus_Red.jsp'>

		<label>定投业务简介</label>
		<label>双色球是由中国福利彩票发行管理中心发行的一款彩票玩法，双色球彩票投注区分为红色球号码区和蓝色球号码区。双色球每注投注号码由6个红色球号码和1个蓝色球号码组成。红色球号码从1-33中选择，蓝色球号码从1-16中选择，顺序不限，每注2元，每周二、四、日晚20:50开奖。客户办理定投业务后，福彩中心将每期自动按照客户提交的号码、套餐类型等信息为客户进行自动购买。目前可在我行办理双色球306定投套餐306元（共153期）和144元（共72期）。若客户中奖，单注奖金小于等于1万元时，奖金自动转入客户银行卡账户；单注奖金大于1万元，将由福彩中心客服人员人工通知客户携带本恩身份证前往福彩中心领取。</label>
		</form>
    </content>
</res> 
