<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n银旅通订票查询");
%>
<%
	List list = new ArrayList();
	String tmp="";
	String content = "biz_id,21|i_biz_step_id,3|TXNSRC,MB441|";
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n发送报文为："+content);

	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null||!bwResult.getCode().equals("000")) {
			
	}
	tmp = bwResult.getContext();
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n接收报文为："+tmp);
	MessManTool messManTool = new MessManTool();
	list = messManTool.yinLvTongGetResult1(tmp);
	int total = list.size();
	int pageSize = 100;
	gzLog.Write(request.getParameter("page"));
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD2.jsp'>
		
<%
	for (int i = 0; i < total; i++) {
		if ((i >= (currPage - 1) * pageSize)&& (i < currPage * pageSize)) {
			HashMap map = (HashMap) list.get(i);
			String tmpstr = (String)map.get("param2")+"|"+(String)map.get("param3");
			String tmpstr2 =(String)map.get("param3");
    	gzLog.Write(i+":"+tmpstr);
%>
			<input type='radio' value='<%=tmpstr%>' name='sightCode'></input>
			<label><%=tmpstr2%></label>
<%
		}
	}
%>
		
		
<%
	double d = total * 1.0 / pageSize;
	int totalPage = (int) Math.ceil(d);
	if(totalPage>1){
		if(currPage==1){
%>
			<!-- <br/>
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
		<input type="submit" value="提交"></input>
		</form>
	</content>
</res>