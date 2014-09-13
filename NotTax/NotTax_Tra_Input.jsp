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
		<form method='post' action='/GZMBank/NotTax/NotTax_461509.jsp'>

			<label>文书编号</label>
			<input type='text' name='AdnCod' style="-wap-input-required: 'true'" /><br/>
			<label>打印票据种类</label>
			<input type='text' name='PBilTyp' style="-wap-input-required: 'true'" /><br/>
			<label>打印票据编号</label>
			<input type='text' name='PBilNo' style="-wap-input-required: 'true'" /><br/>
			<label>通知书填写方式</label>
			<input type='radio' name='HndFlg' value='0'  checked>机打票</input><br/>
			<input type='radio' name='HndFlg' value='1' >手写票</input><br/>
			<label>查询刷新标识</label>
			<input type='radio' name='UpdAdnFg' value='0'  checked>首次查询</input><br/>
			<input type='radio' name='UpdAdnFg' value='1' >信息刷新</input><br/>
			<input type='hidden' name='RipFlg' value='0' /><br/>
			<input type='hidden' name='preSaveKey' value='AdnCod,PBilTyp,PBilNo,HndFlg,UpdAdnFg,RipFlg' />

			<input type='submit' value='确定' /><br/>
		</form>
    </content>
</res> 