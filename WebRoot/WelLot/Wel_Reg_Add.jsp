<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行卡号
	String sjNo = request.getHeader("MBK_MOBILE");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	gzLog.Write("进入["+uri+"]");


%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/WelLot/Wel_Reg_Pre.jsp'>

			<label>选择证件类型：</label>
			<select name="IdTyp">
				<option value="15">身份证</option>
			</select><br/>			

			<label>请输入您银行卡开户证件号：</label>
			<input type='text' name='IdNo' style="-wap-input-required: 'true'" /><br/>

			<input type='radio' name='SigTyp' value='0'  checked>签约本机手机号：<%=sjNo%></input><br/>
			<input type='radio' name='SigTyp' value='1' >签约其他手机号：</input><br/>
			<input type='text' name='MobTel' style="-wap-input-required: 'true'" /><br/>
			<label>请再次输入手机号：</label>
			<input type='text' name='MobTel_Con' style="-wap-input-required: 'true'" /><br/>
			<label>（用于发送投注成功确认短信以及中奖通知等相关事宜，如您期间变更手机号，请通过“签约手机号修改”功能及时变更您预留的手机号。）</label>
			<input type='hidden' name='preSaveKey' value='IdTyp,IdNo,SigTyp,MobTel,MobTel_Con' />

			<input type='submit' value='确定' /><br/>
		</form>
    </content>
</res> 