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
		<form method='post' action='/GZMBank/NotTax/NotTax_461501.jsp'>

			<label>缴费地区：</label>
			<select name="DitCod">
				<option value="440100" checked>广州市</option>
				<option value="440192">广州南沙经济技术开发区</option>
				<option value="440103">荔湾区</option>
				<option value="440104">越秀区</option>
				<option value="440105">海珠区</option>
				<option value="440112">黄埔区</option>
				<option value="440116">萝岗区</option>
				<option value="440184">从化市</option>
				<option value="440191">广州经济技术开发区</option>
				<option value="440183">增城市</option>
				<option value="440113">番禺区</option>
				<option value="440111">白云区</option>
				<option value="440106">天河区</option>
				<option value="440115">南沙区</option>
				<option value="440114">花都区</option>
			</select><br/>			
			<label>通知书编号：</label>
			<input type='text' name='AdnCod' style="-wap-input-required: 'true'" /><br/>
			<label>通知书填写方式：</label>
			<input type='radio' name='HndFlg' value='0'  checked>机打票</input><br/>
			<input type='radio' name='HndFlg' value='1' >手写票</input><br/>
			<label>查询刷新标识：</label>
			<input type='radio' name='UpdAdnFg' value='0' checked>首次查询</input><br/>
			<input type='radio' name='UpdAdnFg' value='1' >非首次查询</input><br/>
			<input type='hidden' name='PBilTyp' value=' ' /><br/>
			<input type='hidden' name='PBilNo' value=' ' /><br/>
			<input type='hidden' name='RipFlg' value='0' /><br/>
			<input type='hidden' name='preSaveKey' value='AdnCod,PBilTyp,PBilNo,HndFlg,UpdAdnFg,RipFlg,DitCod' />

			<input type='submit' value='确定' /><br/>
		</form>
    </content>
</res>