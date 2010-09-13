<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<% 
	List list = new ArrayList();
	String tmp="";
	String content = "biz_id,21|i_biz_step_id,3|";
	MidServer midServer = new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	if (bwResult == null || bwResult.getCode() == null||!bwResult.getCode().equals("000")) {
			
	}
	tmp = bwResult.getContext();
	MessManTool messManTool = new MessManTool();
	list = messManTool.yinLvTongGetResult1(tmp);
	int total = list.size();
	int pageSize = 100;
	String currPage1 = request.getParameter("page") != null ? request
			.getParameter("page") : "1";
	int currPage = Integer.parseInt(currPage1);
	
%>
<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD2.jsp'>
		<table border="1">
			<tr>
				<td> 选择 </td>
				<td> 景区名称 </td>
			</tr>
<%
	for (int i = 0; i < total; i++) {
		if ((i >= (currPage - 1) * pageSize)&& (i < currPage * pageSize)) {
			HashMap map = (HashMap) list.get(i);
			String tmpstr = (String)map.get("param2")+"#:>"+(String)map.get("param3");
%>
			<tr>
				<td><input type="radio" value="<%=tmpstr %>" name="sightCode"/></td>
				<td><%=map.get("param3")%></td>
			</tr>
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
		<input type="submit" value="确定"></input>
		</form>
	</content>
</res>