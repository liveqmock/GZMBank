<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.math.BigInteger" %>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.gdbocom.util.format.*" %>
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
	String forepart="";
	String rear="";
	int forepart_cnt=0;
	int rear_cnt=0;

	//遍历前区
	for(int i=1;i<=33;i++){
		if(request.getParameter("forepart"+i)!=null){
			forepart+=request.getParameter("forepart"+i);
			forepart_cnt++;
		}
	}
	//遍历后区
	for(int i=1;i<=16;i++){
		if(request.getParameter("rear"+i)!=null){
			rear+=request.getParameter("rear"+i);
			rear_cnt++;
		}
	}
	//拼接投注号码字段
	BetLin = this.formatnumber(forepart_cnt)+forepart+this.formatnumber(rear_cnt)+rear;
	String ShowNum = WelFormatter.getFormattedValue(BetLin, WelFormatter.BETNUM);
	pageContext.setAttribute("BetLin", BetLin, PageContext.SESSION_SCOPE);
	if(forepart_cnt>=6&&forepart_cnt<=16&&rear_cnt>=1){//合法的号码个数

		if(forepart_cnt==5&&rear_cnt==2){//单式
			BetMod="1";
		}else{//复式
			BetMod="12";
		}
		pageContext.setAttribute("BetMod", BetMod, PageContext.SESSION_SCOPE);

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

	//复式
	int betMode = BetMoney.betMode_Multiple;//单复式
	int multiple = Integer.parseInt((String)pageContext.getAttribute("BetMul", PageContext.SESSION_SCOPE));//投注倍数
	double price = 2;//单注投注金额
	int section = 0;//单式投注注数,复式无意义
	int betRedNum = 6;//单注红球号码个数
	int redTailNum = forepart_cnt;//选择红球号码个数
	int betBlueNum = 1;//单注蓝球号码个数
	int blueNum = rear_cnt;//选择蓝球号码个数
	int redBaseNum = 0;//实际投注红球胆号码个数，复式无意义
	System.out.println();
	double BetAmt = new BetMoney().CalculateBMoney(betMode, multiple,
		    		price, section, betRedNum,
		    		betBlueNum, redBaseNum, redTailNum, blueNum);
	pageContext.setAttribute("BetAmt",
			String.valueOf((int)BetAmt*100),
			PageContext.SESSION_SCOPE);
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

%>