<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*"%>

<%
	//System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));
	String sessionId = request.getSession().getId();
	String tmp="";
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String content = "biz_id,999|i_biz_step_id,1|CDNO,"+cdno+"|"+"Reserve_Code,123321|";
	MidServer midServer=new MidServer();
	BwResult bwResult = midServer.sendMessage(content);
	String message=bwResult.getContext();
	if (bwResult == null || bwResult.getCode() == null
	|| !bwResult.getCode().equals("000")) {
			
	 }
	tmp = bwResult.getContext();
	MessManTool messManTool = new MessManTool();
 	String Reserve_Code = MessManTool.getValueByName(message,"Reserve_Code");
 	String Product_Name = MessManTool.getValueByName(message,"Product_Name");
	System.out.println("sessionId:"+sessionId);
	System.out.println("cdno:"+cdno);
	String zhongwen1 = "厕所你好";
	String zhongwen= java.net.URLEncoder.encode("中文");
	/*短信发送测试
	ConnDXPT dxpt = new ConnDXPT();
	String rt = dxpt.sendMessage("天下为工2009-55-22","13800000000","60142890000");	
	*/
%>

<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		
		<form method='post' action='/GZMBank/test/mytest1.jsp'>
		<label>缴费卡号: <%=request.getHeader("MBK_ACCOUNT")%></label>
		<br/>
		<!--
		<label>缴费区域</label>
		<br/>
		<select name='district'>
			<option value="1">浦东水厂</option>
			<option value="2">静安水厂</option>
			<option value="3">徐汇水厂</option>
		</select>
		<br/>
		<label>水费单号</label>
		<br/>
		<input type='text' name='number' style="-wap-input-format: 'N'; -wap-input-required: 'true'"  maxleng='20'/>
		<br/>
		-->

		<table border="1">
			<tr><td>定单号:</td><td><input type='radio' name='ddh' value="<%=Reserve_Code %>"/></td><td><%=Reserve_Code %></td></tr>
			<tr><td>预定内容:</td><td><input type='radio' name='ddh' value="<%=Product_Name %>"/></td><td><%=Product_Name %></td></tr>
		</table>
		<br/>

		<label>交易密码:</label>
		<input type='password' name='password' style="-wap-input-required: 'true'"  maxleng='6' encrypt/>
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		<input type='hidden'  name='MBK_VERIFY' value="true"></input>
		<input type='hidden'  name='param' value='<%=zhongwen%>'></input>
		<input type='hidden'  name='param1' value='<%=zhongwen1%>'></input>
  
		<input type='submit' value='提交'/>
		</form>
		<a href='lp://GZMBank/test/nextpage.jsp'>下一页</a>
	</content>
</res>
