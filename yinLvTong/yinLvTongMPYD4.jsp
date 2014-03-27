<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<res> 
	<content>
		<div id="ewp_back" class="clear"/>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String sightContext = MessManTool.changeChar(request.getParameter("sightContext"));
	String tmp[] = sightContext.split("#:>");
	String gmzs = MessManTool.changeChar(request.getParameter("gmzs"));//购买张数 
	String sjlx = MessManTool.changeChar(request.getParameter("sjlx"));//手机类型
	String syrq = MessManTool.changeChar(request.getParameter("syrq"));//门票日期
	
	if(syrq!=null){
		syrq = syrq.substring(0,8);
	}
	String sjhm1 = MessManTool.changeChar(request.getParameter("sjhm1"));//手机号码
	String sjhm2 = MessManTool.changeChar(request.getParameter("sjhm2"));
	sightContext+="#:>"+gmzs;//门票张数10
	sightContext+="#:>"+sjlx;//手机类型11
	sightContext+="#:>"+sjhm1;//手机号码12
	sightContext+="#:>"+syrq;//门票日期13
	
	String dqrq=DateUtils.FormatDate(new Date(),"yyyyMMdd");
	
	
	gzLog.Write("shjm1:"+sjhm1+" sjhm2:"+sjhm2+" 门票数量:"+gmzs+" sjlx:"+sjlx+" syrq:"+syrq+" dqrq:"+dqrq);
	
	
	boolean isFalse=false;
	String message = "";
	if(Integer.parseInt(gmzs)<1){
		isFalse=true;
		message="输入门票小于1张！";
	}
	if(!sjhm1.equals(sjhm2)||sjhm1.length()!=11){
		isFalse=true;
		message="手机号码两次输入不符！";
	}
	
  
	if(Integer.parseInt(dqrq)>Integer.parseInt(syrq)){
		isFalse=true;
		message="门票日期小于当天！";
	}
	//String kcrq=tmp[6].trim();//开始日期
	//String jsrq=tmp[7].trim();//结束日期
	
	//gzLog.Write("beginDate:"+kcrq+" endDate:"+jsrq);
	
	//if(Integer.parseInt(kcrq)>Integer.parseInt(syrq)||Integer.parseInt(syrq)>Integer.parseInt(jsrq)){
	//	isFalse=true;
	//	message="门票日期不在有效期内！";
	//}
	if(isFalse){
		%>
		<%=message%>
<%
	}else
		{
%>
		<form method='post' action='/GZMBank/yinLvTong/yinLvTongMPYD5.jsp'>
		<input type="hidden" name="sightContext" value="<%=sightContext%>"/>
		<label>请输入交易密码:</label>
		<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
		<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
		
		<input type='hidden'  name='MBK_VERIFY' value='true'></input>
		<input type="submit" value="确定"/> 
		</form>
<%
}
%>
	</content>
</res>