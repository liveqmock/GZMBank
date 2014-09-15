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
	//准备显示字段
	Map showE = new HashMap();

	//准备更新字段
	Map updateE = new HashMap();
	updateE.put("AdnCod", "文书编号");
	updateE.put("PBilTyp", "打印票据种类");
	updateE.put("PBilNo", "打印票据编号");
	updateE.put("HndFlg", "通知书填写方式");
	updateE.put("UpdAdnFg", "查询刷新标识");
	updateE.put("RipFlg", "撕定额票标志");
	updateE.put("DitCod", "撕定额票标志");


%>


<?xml version="1.0" encoding="utf-8"?> 
<res> 
	<content>
		<form method='post' action='/GZMBank/NotTax/NotTax_461501.jsp'>

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
			<select name="DitCod">
				<option value="440192">广州南沙经济技术开发区</option>
				<option value="440100">广州市</option>
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
			<input type='hidden' name='RipFlg' value='0' /><br/>
			<input type='hidden' name='preSaveKey' value='AdnCod,PBilTyp,PBilNo,HndFlg,UpdAdnFg,RipFlg,DitCod' />

			<input type='submit' value='确定' /><br/>
		</form>
    </content>
</res>