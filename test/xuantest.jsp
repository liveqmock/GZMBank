<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%
	//System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));
%>

<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		

		<form method='post' action='/GZMBank/test/xuantest1.jsp'>
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

<input type="checkbox" name="fruit" value ="apple" >苹果</input>
<input type="checkbox" name="fruit" value ="orange">桔子</input>
<input type="checkbox" name="fruit" value ="mango">芒果</input>
  
		<input type='submit' value='提交'/>
		</form>		
	</content>
</res>
