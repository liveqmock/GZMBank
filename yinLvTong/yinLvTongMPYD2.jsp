<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
%>
<%
	String sightCode = MessManTool.changeChar(request.getParameter("sightCode"));
	String tmp[] = sightCode.split("#:>");
	sightCode = tmp[0];
	String sightName = tmp[1];
	List list = new ArrayList();
	String content = "biz_id,21|i_biz_step_id,4|Provider_Code," + sightCode + "|txncnl,MOB|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+content);
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	String tmp1 = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+tmp1);
	MessManTool messManTool = new MessManTool();
	list = messManTool.yinLvTongGetResult2(tmp1);
	int total = list.size();
	int pageSize = 100;
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
	<div>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD3.jsp'>
		<table border="1">
			<tr><td>选择</td><td>门票名称</td><td>原价</td><td>优惠价</td><td>门票使用日期</td></tr>
<%
	for (int i = 0; i < total; i++) {
			if ((i >= (currPage - 1) * pageSize)
			&& (i < currPage * pageSize)) {
				HashMap map = (HashMap) list.get(i);
				String price1 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param4")).trim()) / 100, "###0.00");
				String price2 = MoneyUtils.FormatMoney(Double.parseDouble(((String) map.get("param5")).trim()) / 100, "###0.00");
				String tmpstr=
						sightCode.trim()//门票代码0
						+"#:>"+sightName.trim()//景点名称1
						+"#:>"+((String) map.get("param2")).trim()//门票代码2
						+"#:>"+((String) map.get("param3")).trim()//门票名称3
						+"#:>"+price1//门市价4
						+"#:>"+price2//电子价5
						+"#:>"+((String) map.get("param6")).trim()//开始日期6
						+"#:>"+((String) map.get("param7")).trim()//结束日期7
						+"#:>"+((String) map.get("param8")).trim()//有效日期8
						+"#:>"+((String) map.get("param9")).trim()+"TheEnd";//备注9
				
%>
			<tr><td><input type="radio" value="<%=tmpstr%>" name="sightContext"/></td><td><%=((String) map.get("param3")).trim()%></td><td><%=price1%></td><td><%=price2%></td><td><%=((String) map.get("param6")).trim()+"到"+((String) map.get("param7")).trim()%></td></tr>
<%
		}
	}
%>
		</table>
		
<%
	double d = total * 1.0 / pageSize;
	int totalPage = (int) Math.ceil(d);
	if(totalPage>1){
		if(currPage==1){
%>
	<!-- 
			<br/>
			<a>下一页</a>
	 -->
<%			
		}else if(currPage==totalPage){
%>
			<br/>
			<a>上一页</a>
<%				
		}else{
%>
			<br/>
			<a>上一页</a>
			<br/>
			<a>下一页</a>
			
<%		
		}
	}
%>
		<input type="submit" value="提交"/>
		</form>
		</div>
	</content>
	
</res>