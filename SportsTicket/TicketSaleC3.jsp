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
	char[] LotTyp2 = request.getParameter("LotTyp2").toCharArray();
	int LotNumLength = 0;
	String LotTypName = "";
	String LotTyp = "";
	if("7".equals(String.valueOf(LotTyp2[1]))){
		LotNumLength = 7;
		LotTypName = "七星彩";
		LotTyp = "05";
	}else{
		LotNumLength = 0;
		LotTypName = "";
		LotTyp = "";
	}

%>
<!-- 分行特色业务频道列表 -->
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<h1><%=LotTypName%></h1><br/>
		
    <form method='post' action='/GZMBank/SportsTicket/TicketSaleC4.jsp'>

<!-- 购票方式-->
	<label>请选择购票方式: </label>
	<br/>
	<select name="TikMod">
		<option value='01' checked="checked">自选</option>
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

<!-- 公共部分开始 -->
<!-- 倍数 -->
	<label>请输入倍数: (输入范围1~99)</label>
	<br/>
	<input type='text' name='MulTip' style="-wap-input-format: 'N'; -wap-input-required: 'true'" maxleng='2'></input>

<!-- 扩展号码 -->
	<input type='hidden' name='ExtNum' value=''></input>

<!-- 投注号码个数 -->
	<input type='hidden' name='LotNumLength' value='<%=LotNumLength%>'></input>

<!-- 彩票类型 -->
	<input type='hidden' name='LotTyp' value='<%=LotTyp%>'></input>

<!-- 控制流程 -->
	<input type='hidden' name='workflow' value='C3'></input>
<!-- 公共部分结束 -->


	<input type='submit' value='下一步'/>
    </form>
	</content>
</res>