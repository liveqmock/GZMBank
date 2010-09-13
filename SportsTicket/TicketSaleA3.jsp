<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤3");

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<h1>大乐透</h1><br/>
		
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleA4.jsp'>

<!-- 购票方式-->
	<label>请选择购票方式: </label>
	<br/>
	<select name="TikMod">
		<option value='01' visible='SigDup_Msg,SigDup' checked="checked">自选</option>
        <option value='02' visible='NotNum_Msg,NotNum'>机选</option>
        <!-- option value='03'>自选定期定制</option-->
        <!-- option value='04'>全包</option-->
        <!-- option value='05'>机选定期定制</option-->
	</select>

<!-- 机选部分开始 -->
<!-- 机选注数-->
	<label name='NotNum_Msg'>请选择机选注数: </label>
	<br/>
	<select name="NotNum">
        <option value='01' checked="checked">1注</option>
        <option value='02'>2注</option>
        <option value='03'>3注</option>
        <option value='04'>4注</option>
        <option value='05'>5注</option>
	</select>
<!-- 机选部分结束 -->

<!-- 单复式区分-->
	<!--label name="SigDup_Msg">请选择游戏方式: </label>
	<br/>
	<select name="SigDup">
		<option value='1' selected="selected">单式</option>
        <option value='2'>复式</option>
        <option value='3'>胆拖</option>
        <option value='5'>包位</option>
        <option value='6'>包段</option>
        <option value='7'>和值</option>
        <option value='8'>包胆</option>
        <option value='9'>包串</option>
        <option value='10'>包奇偶</option>
        <option value='11'>包对</option>
	</select-->

<!-- 公共部分开始 -->
<!-- 倍数 -->
	<label>请输入倍数: (输入范围1~99)</label>
	<br/>
	<input type='text' name='MulTip' style="-wap-input-format: 'N'; -wap-input-required: 'true'" maxleng='2'></input>

<!-- 追加 -->
	<input type='checkbox' name='add'>是否追加</input>

<!-- 扩展号码 -->
	<input type='hidden' name='ExtNum' value=''></input>
<!-- 公共部分结束 -->
<!-- 控制流程 -->
	<input type='hidden' name='workflow' value='A3'></input>

	<input type='submit' value='下一步'/>
    </form>
	</content>
</res>