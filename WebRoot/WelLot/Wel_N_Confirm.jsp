<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.gdbocom.action.wel.*" %>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	String preSaveKey = request.getParameter("preSaveKey");
	PreAction.savePreFormValue(pageContext, request, preSaveKey);

	//设置正常情况需要跳转的页面
	String forwardPage = "Wel_Confirm.jsp";
	//设置出错情况需要跳转的页面
	String errPage = "../../errPage.jsp";
	

	String BetMod="";
	String BetLin="";
	String ShowNum="";
	String forepart="";
	String rear="";
	int forepart_cnt=0;
	int rear_cnt=0;
	
	for(int i=1;i<=33;i++){
		if(request.getParameter("forepart"+i)!=null){
			forepart+=request.getParameter("forepart"+i);
			forepart_cnt++;
			ShowNum = ShowNum + i +",";
			gzLog.Write("前区号码为:"+i);
		}
	}
	//去掉尾部的逗号
	ShowNum = ShowNum.substring(0, ShowNum.length()-1);
	ShowNum = ShowNum + "#";
	for(int i=1;i<=16;i++){
		if(request.getParameter("rear"+i)!=null){
			rear+=request.getParameter("rear"+i);
			rear_cnt++;
			ShowNum = ShowNum + i +",";
			gzLog.Write("后区号码为:"+i);
		}
	}
	//去掉尾部的逗号
	ShowNum = ShowNum.substring(0, ShowNum.length()-1);
	//拼接投注号码字段
	BetLin = this.formatnumber(forepart_cnt)+forepart+this.formatnumber(rear_cnt)+rear;
	pageContext.setAttribute("BetLin", BetLin, PageContext.SESSION_SCOPE);
	if(forepart_cnt>=6&&forepart_cnt<=16&&rear_cnt>=1){//合法的号码个数

		if(forepart_cnt==5&&rear_cnt==2){//单式
			BetMod="1";
		}else{//复式
			BetMod="12";
		}
		pageContext.setAttribute("BetMod", BetMod, PageContext.SESSION_SCOPE);
	    //pageContext.forward(forwardPage);

	}else{//非法的号码个数
		String RspCod = "Wel999";
		String RspMsg = "非法号码数"; 
		gzLog.Write("["+uri+"]MGID不正确");

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}
	String BetAmt = String.valueOf(getTicketPay(2,
			Integer.parseInt((String)pageContext.getAttribute("BetMul", PageContext.SESSION_SCOPE)),
			forepart_cnt,
			rear_cnt));
	pageContext.setAttribute("BetAmt", BetAmt, PageContext.SESSION_SCOPE);
	pageContext.setAttribute("BetNum", String.valueOf(forepart_cnt+rear_cnt), PageContext.SESSION_SCOPE);
	pageContext.setAttribute("ShowNum", ShowNum, PageContext.SESSION_SCOPE);
	
	%>
		<form method='post' action='/GZMBank/WelLot/Wel_Confirm.jsp'>
			<label>银行卡号：<%=cdno%></label><br/>
			<label>投注号码：<%=ShowNum%></label>
			<label>交易金额：<%=BetAmt%>元</label>

			<input type='submit' value='确认'></input>
		</form>

	</content>
</res>
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}

	/**
	 * 计算投注金额
	 */
	public BigInteger getTicketPay(int oneTicketPay, int mul, int redCnt, int blueCnt){

		return BigInteger.valueOf(mul*oneTicketPay)
				.multiply(getCombination(redCnt, 6))
				.multiply(getCombination(blueCnt, 1));
		
	}

	/**
	 * 计算组合数
	 */
	public BigInteger getCombination(int n, int m){
		return getFactorial(n)
				.divide(getFactorial(n-m).multiply(getFactorial(m)));
		
	}

	/**
	 * 计算阶乘
	 */
	public BigInteger getFactorial(int n){
		BigInteger fact = new BigInteger("1");
		for(int i=2; i<=n; i++){
			fact.multiply(BigInteger.valueOf(n));
		}
		return fact;
	}
%>