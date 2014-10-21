<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="java.net.*" %>
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
	Map seque = new HashMap();
	String adnKnd = (String)pageContext.getAttribute("AdnKnd", PageContext.SESSION_SCOPE);
	gzLog.Write(adnKnd+"["+adnKnd+"]");
	if("3".equals(adnKnd)){
		showKey.put("AdnCod", "通知书编号");
		showKey.put("DitCod", "行政区划");
		showKey.put("ColUntNm", "执收单位名称");
		showKey.put("CsgUntNm", "执罚单位名称");
		showKey.put("XPayNam", "当事人");
		showKey.put("AdnAmt", "应收总金额");

		seque.put( "0", "AdnCod");
		seque.put( "1", "DitCod");
		seque.put( "2", "ColUntNm");
		seque.put( "3", "CsgUntNm");
		seque.put( "4", "XPayNam");
		seque.put( "5", "AdnAmt");

	}else if("1".equals(adnKnd)){
		showKey.put("AdnCod", "通知书编号");
		showKey.put("DitCod", "行政区划");
		showKey.put("ColUntNm", "执收单位名称");
		showKey.put("XPayNam", "当事人");
		showKey.put("AdnAmt", "应收总金额");

		seque.put( "0", "AdnCod");
		seque.put( "1", "DitCod");
		seque.put( "2", "ColUntNm");
		seque.put( "3", "XPayNam");
		seque.put( "4", "AdnAmt");
		
	}

	//设置需要显示的值的类型
	Map keyType = new HashMap();
	keyType.put("AdnAmt", "BigDecimal");
	keyType.put("PntAmt", "BigDecimal");
	keyType.put("AgtAmt", "BigDecimal");
	keyType.put("AdnKnd", "AdnKnd");
	keyType.put("LevFlg", "LevFlg");
	keyType.put("DitCod", "DitCod");
	keyType.put("AgtFlg", "AgtFlg");
	keyType.put("RgnFlg", "RgnFlg");

	//设置需要更新的值
	Map addValue = new HashMap();
	addValue.put("HoActNo", CrdNo);
	addValue.put("OActFg", "4");
	addValue.put("AccFlg", "4");
	addValue.put("ActNo", CrdNo);
	addValue.put("CcyCod", "CNY");
	addValue.put("ChkPin", "1");
//	addValue.put("Passwd", " "); //488010交易添加了报文头密码
	addValue.put("BokSeq", " ");
	addValue.put("JJCod", " ");

	//保存需要更新的字段
	String preSaveKey = "HoActNo,OActFg,AccFlg,ActNo,CcyCod,ChkPin,BokSeq,JJCod";
	PreAction.saveMapValue(pageContext, addValue, preSaveKey);
	gzLog.Write(PreAction.strOfPageContext(pageContext));


	//备注
	String remark = "请仔细核对信息，如因客户输入错误导致缴费失败的，将不予退还缴费金额";
%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/NotTax/NotTax_488010.jsp'>

            <label>  </label><br/>
            <label>请确认缴费信息:</label><br/>
<%
	//显示确认值
	for(int i=0; i<seque.size(); i++){

		String key = (String) seque.get(String.valueOf(i));
		String showValue = (String)showKey.get(key);
		String type = (String)keyType.get(key);

		String pageContextValue = (String)pageContext.getAttribute(key, PageContext.SESSION_SCOPE);
		if(null!=pageContextValue){
			String formattedValue = null==type?pageContextValue:getFormattedValue(pageContextValue, type);
			out.println("<label>"+showValue+":"+formattedValue+"</label><br/>");
		}else{
			out.println("<label>"+showValue+":null</label><br/>");
		}
		
	}

%>

			<label>请输入交易密码：</label>
			<br/>
			<input type='password' name='password' isRandomPass='true' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
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
		}else if("LevFlg".equals(type)){
			if("1".equals(value)){
				return "直接缴款";
			}else if("3".equals(value)){
				return "集中汇缴";
			}else{
				return value;
			}			
		}else if("DitCod".equals(type)){
			if("440192".equals(value)){return "广州南沙经济技术开发区";
			}else if("440100".equals(value)){return "广州市";
			}else if("440103".equals(value)){return "荔湾区";
			}else if("440104".equals(value)){return "越秀区";
			}else if("440105".equals(value)){return "海珠区";
			}else if("440112".equals(value)){return "黄埔区";
			}else if("440116".equals(value)){return "萝岗区";
			}else if("440184".equals(value)){return "从化市";
			}else if("440191".equals(value)){return "广州经济技术开发区";
			}else if("440183".equals(value)){return "增城市";
			}else if("440113".equals(value)){return "番禺区";
			}else if("440111".equals(value)){return "白云区";
			}else if("440106".equals(value)){return "天河区";
			}else if("440115".equals(value)){return "南沙区";
			}else if("440114".equals(value)){return "花都区";
			}else{return value;}
		}else if("AgtFlg".equals(type)){
			if("0".equals(value)){
				return "全部非税收入";
			}else if("1".equals(value)){
				return "部分代收款项";
			}else{
				return value;
			}			
		}else if("RgnFlg".equals(type)){
			if("0".equals(value)){
				return "区县级";
			}else if("1".equals(value)){
				return "市级";
			}else{
				return value;
			}			
		}else{
			return value;
		}

	}
	
%>