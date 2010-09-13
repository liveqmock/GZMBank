<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%
	String sightContext = MessManTool.changeChar(request.getParameter("sightContext"));
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
<%
//为了避免选错门票线路，只能选测试线路
if( "150".equals(tmp[0].trim()) && "2048".equals(tmp[2].trim()) ) {
//end xuan 
%>
		<div id="ewp_back" class="clear"/>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD4.jsp'>
		<input type="hidden" name="sightContext" value="<%=sightContext%>"/>
			门票单价：<br/>
			<%=tmp[5]%>
			门票说明：<br/>
			<%
				String temp2=tmp[9].substring(0,(tmp[9].length()-6));
			%>
			<%=temp2 %><br/>
			购买张数：
			<input type="text" name="gmzs" value="" style="-wap-input-required: 'true';-wap-input-format: 'N'" maxleng="2"/>
			手机类型： 
			<select name="sjlx">
				<option value="11">中国移动彩信手机</option>
				<option value="00">非中国移动彩信手机</option>
			</select>
			手机号码：
			<input type="text" name="sjhm1" value="<%=request.getHeader("MBK_MOBILE")%>" style="-wap-input-required: 'true';-wap-input-format: 'phone'"  minleng="11" maxleng="11" />
			手机号码的确定：
			<input type="text" name="sjhm2" value="<%=request.getHeader("MBK_MOBILE")%>" style="-wap-input-required: 'true';-wap-input-format: 'phone'"  minleng="11" maxleng="11" />
			门票使用日期：
			<input type="text" name="syrq" style="-wap-input-format: 'date'"/>
			门 票 有 效 期 为：<%=yxrq1 %>天。 使 用 期 限 为：<%=kcrq3 %>到<%=jsrq3 %> 
		<input type="submit" value="提交"/> 
		</form>
<%
}
else {
%>
只能选测试线路,做测试<br/>
<%
}
%>
	</content>
	
</res>