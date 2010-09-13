<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>

<res> 
	<content>
		<div id="ewp_back" class="clear"/>
<%
	String Reserve_Code = request.getParameter("Reserve_Code");
	String Product_Name = MessManTool.changeChar(request.getParameter("Product_Name"));
	String Provide_Name = MessManTool.changeChar(request.getParameter("Provide_Name"));
	String Trans_Toal_Amount = request.getParameter("Trans_Toal_Amount");
	String Paid_Amount = request.getParameter("Paid_Amount");
	String Arrearage_Amount = request.getParameter("Arrearage_Amount");
%> 
	<form method='post' action='/GZMBank/yinLvTong/yinLvTongJF4.jsp'> 
		<input type='hidden' name='Reserve_Code' value="<%=Reserve_Code%>"/>
		<input type='hidden' name='Product_Name' value="<%=Product_Name%>"/>
		<input type='hidden' name='Provide_Name' value="<%=Provide_Name%>"/>
		<input type='hidden' name='Trans_Toal_Amount' value="<%=Trans_Toal_Amount%>"/>
		<input type='hidden' name='Paid_Amount' value="<%=Paid_Amount%>"/>
		<input type='hidden' name='Arrearage_Amount' value="<%=Arrearage_Amount%>"/>
    <label>请输入交易密码:</label>
		<br/>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
		<input type='hidden'  name='MBK_VERIFY' value=' true'></input>		
		<input type='submit' value='确定' /> 
	</form> 
</content>
</res> 