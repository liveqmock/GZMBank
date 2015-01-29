<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>

<%
	String TXNCNL="6";
	/**********************/
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	String AREANUM = request.getParameter("AREANUM");
	String FENLEI = request.getParameter("FENLEI");
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
 	pageContext.setAttribute("AREANUM", AREANUM.substring(0, 2), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("JYFLG", "2", PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("TXNCNL", TXNCNL, PageContext.SESSION_SCOPE);
 	Map responseValues = new HashMap();
	try{
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466605","@SGD_A",TransationFactory.SGD466605)
	);
		
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 

		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
        pageContext.forward(forwardString.toString());
	}
%>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/dsf_sheb2.jsp"%>' >
			<input type="hidden" value="01" name="buscla"/><!-- 税务01 -->
		<%	
			if(responseValues.get("MsgTyp").equals("N")){
		
		 %>
		 <label>业务分类：<%=FENLEI %></label>
		 <br/>
		<label>区        域: <%=AREANUM.substring(2).trim() %></label>
		 <br/>
		 <table>
		<tr>
		<td><label>收费企业:</label></td>
		 <td><select name="ENTERID">	
   	    <%
		List loopBody = (List)responseValues.get("LoopBody");
        String keyOrder[] = new String[]{"CODE"};
    	//设置需要显示的值的类型
    	Map keyType = new HashMap();
    	//设置循环体需要显示的值和名称,
    	Map loopShowKey = new HashMap();
    	loopShowKey.put("CODE", "地域");
    	keyType.put("BetLin", WelFormatter.getSingleton(WelFormatter.BETNUM));
        for(int recordIndex=0; recordIndex<loopBody.size(); recordIndex++){
        		Map oneRecord = (Map)loopBody.get(recordIndex);
        		for(int keyIndex=0; keyIndex<1; keyIndex++){
        			//英文值，类似"DrawId"
        			String key = keyOrder[keyIndex];
        			//显示的中文名字，类似"投注期号"
        			//String showName = (String)loopShowKey.get(key);
        			//使用的格式化对象，类似 WelFormatter.getSingleton(WelFormatter.BETNUM)
        			FormatterInterface type = (FormatterInterface)keyType.get(key);
        			//为格式化的值
        			String originValue = (String)oneRecord.get(key);
        			%>
        			    <option value="<%=originValue.trim() %>"><%=originValue.substring(2).trim() %></option>
        			<%
        		}
        }
		%>
      </select></td>
      </tr>
      </table>
 <br/>
		<input type='hidden' name='AREANUM'  value="<%=AREANUM %>"/>
		<input type='hidden' name='FENLEI'  value="<%=FENLEI %>"/>
		<br/>
		<input type='submit' value='下一步'/>
		<%
			}else{
			
			%>
				<label><%=responseValues.get("RspMsg") %></label>
			<%
			}
		 %>
		</form>
	</content>
</res>
