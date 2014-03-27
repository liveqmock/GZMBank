<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%
	String sightContext = MessManTool.changeChar(request.getParameter("sightContext"));
	String sjNo =  MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	String tmp[] = sightContext.split("#:>");
	String kcrq=tmp[6].trim();//开始日期
	String jsrq=tmp[7].trim();//结束日期
	String yxrq=tmp[8].trim();//有效日期
	int yxrq1=0;
	String kcrq3="";
	String jsrq3="";
	if(kcrq.equals("")||kcrq.length()!=8){
	}else{
		String tmp1=kcrq.substring(0,4);
		String tmp2=kcrq.substring(4,6);
		String tmp3=kcrq.substring(6,8);
		kcrq=tmp1+"/"+tmp2+"/"+tmp3;
		kcrq3=tmp1+"-"+tmp2+"-"+tmp3;
	}
	if(jsrq.equals("")||jsrq.length()!=8){
	}else{
		String tmp1=jsrq.substring(0,4);
		String tmp2=jsrq.substring(4,6);
		String tmp3=jsrq.substring(6,8);
		jsrq=tmp1+"/"+tmp2+"/"+tmp3;
		jsrq3=tmp1+"-"+tmp2+"-"+tmp3;
	}
	if(yxrq.equals("")){
	}else{
		yxrq1=Integer.parseInt(yxrq);
	}
	
%>
<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD4.jsp'>
		<input type="hidden" name="sightContext" value="<%=sightContext%>"/>
		<label>门票单价：</label>
		
			<label><%=tmp[5]%></label>
		<label>门票说明：</label>
		
		<%
			String temp2=tmp[9].substring(0,(tmp[9].length()-6));
		%>
		<label><%=temp2 %></label>
		
		<label>购买张数：</label>
		<input type="text" name="gmzs" value="" style="-wap-input-required: 'true';-wap-input-format: 'N'" maxleng="2"/>
		<label>手机类型： </label>
			<select name="sjlx">
				<option value="11">中国移动彩信手机</option>
				<option value="00">非中国移动彩信手机</option>
			</select>
		<label>手机号码：</label>
		<input type="text" name="sjhm1" value="<%=sjNo%>" style="-wap-input-required: 'true';-wap-input-format: 'phone'"  minleng="11" maxleng="11" />
		<label>手机号码的确定：</label>
	  <input type="text" name="sjhm2" value="<%=sjNo%>" style="-wap-input-required: 'true';-wap-input-format: 'phone'"  minleng="11" maxleng="11"></input>
		<label>门票使用日期：</label>
		<input type="text" name="syrq" style="-wap-input-format: 'date'"/>
		<label>门 票 有 效 期 为：<%=yxrq1 %> 天。 </label>
		<input type="submit" value="提交"/> 
		</form>
	</content>
	
</res>