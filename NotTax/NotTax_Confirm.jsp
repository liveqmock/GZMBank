<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="com.gdbocom.util.*" %>
<%@ page import="com.bocom.mobilebank.security.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.text.SimpleDateFormat" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	gzLog.Write("进入["+uri+"]");
	
	//设置需要显示的值和名称,
	Map showKey = new HashMap();
	showKey.put("AdnCod", "通知书编号");
	showKey.put("AgtFlg", "代收标识");
	showKey.put("AdnAmt", "应收总金额");
	showKey.put("HoActNo", "银行扣账账号");
	showKey.put("AdnKnd", "通知书性质");
	showKey.put("HoActNo", "银行入账账号");

	//设置需要显示的值的类型
	Map keyType = new HashMap();
	keyType.put("AdnAmt", "BigDecimal");
	keyType.put("AdnKnd", "AdnKnd");

	//设置需要更新的值
	Map addValue = new HashMap();
	addValue.put("HoActNo", CrdNo);
	addValue.put("OActFg", "4");
	addValue.put("AccFlg", "4");
	addValue.put("ActNo", CrdNo);
	addValue.put("CcyCod", "CNY");
	addValue.put("ChkPin", "1");
	addValue.put("Passwd", "");


	//备注
	String remark = "请仔细核对信息，如因客户输入错误导致缴费失败的，将不予退还缴费金额";
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/NotTax/NotTax_488010.jsp'>
			<label>请确认缴费信息:</label><br/>
<%
	Map form = request.getParameterMap();
	//将上一页所有变量设置成隐藏表单值
	Iterator itKeys = form.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) form.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

	//将需要增加的变量值设置成隐藏表单值
	itKeys = addValue.keySet().iterator();
	while(itKeys.hasNext()){
		String key = (String)itKeys.next();
		String[] values = ( (String[]) addValue.get(key) );
		if(1==values.length){
			out.println("<input type='hidden' name='"+key+"' value=\""+values[0]+"\"/><br/>");
		}
	}

	//显示确认值
	Set keys = showKey.keySet();

	for(Iterator it = keys.iterator(); it.hasNext(); ){

		String key = (String) it.next();
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);
		
		if(form.containsKey(key)){
			String formValue = ( (String[])form.get(key) )[0];
			String formattedValue = null==type?formValue:getFormattedValue(formValue, type);
			out.println("<label>"+showValue+":"+formattedValue+"</label><br/>");
		}else{
			out.println("<label>"+showValue+":null</label><br/>");
		}
	}

%>

			<label>请输入交易密码：</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>

			<input type='submit' value='确定'/><br/>
		</form>
		<label><%=remark%></label>
	</content>
</res>
<%!
	public String getFormattedValue(String value, String type){
		if("BigDecimal".equals(type)){
			return new DecimalFormat("#,###.00").format(Double.parseDouble(value)/100.0);
		}else if("AdnKnd".equals(type)){
			if("1".equals(value)){
				return "普通收缴";
			}else if("3".equals(value)){
				return "交通罚款";
			}else{
				return value;
			}			
		}else{
			return value;
		}

	}
%>