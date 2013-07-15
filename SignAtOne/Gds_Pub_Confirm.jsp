<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%request.setCharacterEncoding("utf-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%@ page import="weblogic.utils.StringUtils" %>
<%@ page import="com.gdbocom.util.communication.custom.gds.*" %>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
    String crdNo = request.getHeader("MBK_ACCOUNT"); //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
	gzLog.Write(sjNo+"进入["+uri+"]");
	
    //设置需要显示的值和名称
    boolean isNull = false;
    //设置需要显示的值、名称和来源，
    //    格式：CrdNo,签约卡号,[reqHead|request|session]
    //String showKey = request.getParameter("showKey");

%>
<?xml version = "1.0" encoding = "utf-8"?>
<res>
	<content>	
		<form method='post' action='/GZMBank/SignAtOne/Query_469998'>
			<label>请确认充值信息:</label><br/>
<%

	/*
	 *设置需要显示的来源、关键字、子关键字（一般Map类型才有）、类型、中文名称
	 *    格式：[reqHead|request|session],
	 *         <关键字>,
	 *         <子关键字>,
     *         [String,Map],
     *         签约卡号
	 */
	StringBuffer showKeyBuffer = new StringBuffer();
	showKeyBuffer.append("reqHead,CrdNo,,String,签约卡号").append("|");


	//设置需要显示的缴费号和缴费名
    String gds_GdsBIds = (String)pageContext
            .getAttribute("Gds_GdsBIds", PageContext.SESSION_SCOPE);


    String[] gdsBids = gds_GdsBIds.split(",");
    Map business = GdsPubData.getSignBusiness();
    for(int i=0; i<gdsBids.length; i++){
        if( null!=gdsBids[i] && (!"".equals(gdsBids[i])) ){
            String businessId = gdsBids[i];
            String businessName = (String) business.get(businessId);

            //添加showKey
            showKeyBuffer.append("session").append(",")
                .append("Gds_TCusId").append(",")
                .append(businessId).append(",")
                .append("Map").append(",")
                .append(businessName).append("缴费号")
                .append("|");

            showKeyBuffer.append("session").append(",")
	            .append("Gds_TCusNm").append(",")
	            .append(businessId).append(",")
	            .append("Map").append(",")
	            .append(businessName).append("缴费号")
	            .append("|");
        }
    }

	//显示确认值
	String[] showKeys = showKeyBuffer.toString().split("\\|");
	for(int pairsIndex=0;pairsIndex<showKeys.length;pairsIndex++){
		String[] params = showKeys[pairsIndex].split(",");
        String source = params[0];//来源
		String key = params[1];//关键字
        String subkey = params[2];//子关键字（一般Map类型才有）
        String type = params[3];//类型
		String name = params[4];//中文名称
        String value = "";

        if(source.equals("reqHead")){
            value = StringUtils.valueOf(request.getHeader(key)).trim();

        }else if(source.equals("request")){
            value = StringUtils.valueOf(request.getParameter(key)).trim();

        }else if(source.equals("session")){
            if("String".equals(type)){
                value = StringUtils.valueOf(pageContext
                        .getAttribute(key, PageContext.SESSION_SCOPE)).trim();
            }else if("Map".equals(type)){
                value = (String)((Map)pageContext
                        .getAttribute(key, PageContext.SESSION_SCOPE))
                        .get(subkey);
            }else{
                throw new IllegalArgumentException();
            }
        }else if(isNull){
            value = "null";
        }
		out.println("<label>"+name+":"+value+"</label><br/>");
	}

%>

			<label>请输入交易密码：</label>
			<br/>
			<input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
			<input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>

			<input type='submit' value='确定'/><br/>
		</form>
	</content>
</res>
