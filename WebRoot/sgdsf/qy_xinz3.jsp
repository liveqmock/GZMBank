<%@ page language="java" import="java.util.*" pageEncoding="UTF-8"%>
<%@ page import="java.net.*" %>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.Map" %>
<%@ page import="com.gdbocom.util.format.*" %>

<%
	//System.out.println("==============================");
	request.setCharacterEncoding("UTF-8");
 	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	String AREANUM = request.getParameter("AREANUM");
	String ENTERID = request.getParameter("ENTERID");
	String FENLEI = request.getParameter("FENLEI");
	String BUSCLA = request.getParameter("BUSCLA");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
//	String yewufenlei = request.getParameter("yewufenlei");
//	System.out.print("业务分类："+yewufenlei);
	gzLog.Write("进入["+uri+"]");
	
	String errPage = "";
//	request.setAttribute("BUSCLA", "05");
 //	pageContext.setAttribute("BUSCLA", "02", PageContext.SESSION_SCOPE);
 //	pageContext.setAttribute("AREANUM", AREANUM.substring(0, 2).trim(), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("ENTERID", ENTERID.substring(0, 6), PageContext.SESSION_SCOPE);
 	pageContext.setAttribute("JYFLG", "1", PageContext.SESSION_SCOPE);
 	Map responseValues = new HashMap();
	try{
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466671","@SGD_A",TransationFactory.SGD466671)
	);
		//System.out.println("responseValu111es:"+responseValues);
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		//gzLog.Write("["+uri+"]MGID不正确");

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
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/qy_xinz4.jsp"%>' >
			
			<input type="hidden" value="01" name="buscla"/><!-- 税务01 -->
		<br/>	
		<%	
			//System.out.println("responseValu ==============="+responseValues.get("RspCod"));
			if(responseValues.get("MsgTyp").equals("N")){
		
		 %>
		 <label>客户证件号：<%=CLI_IDENTITY_CARD %></label>
		  <br/>
		 <label>业务分类：<%=FENLEI %></label>
		  <br/>
		<label>区域: <%=AREANUM %></label>
		 <br/>
		<label>收费企业:<%=ENTERID %></label>
		<br/>
		<table>
		<tr>
		<td><label>业务种类：</label></td>
		 <td><select name="BUSTYPE">	
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
      </select>
      </td>
      </tr>
      <tr>
		<td><label>缴费标识：</label></td>
		<td><input type="text" name="PAYFLG" style="-wap-input-format: 'Y'; -wap-input-required: 'true'"  maxlength="18"/>
		</td>
		</tr>
		</table>
		<input type='hidden' name='AREANUM'  value='<%=AREANUM %>'/>
		<input type='hidden' name='ENTERID'  value='<%=ENTERID %>'/>
		<input type='hidden' name='BUSCLA'  value='<%=BUSCLA %>'/>
		<input type='hidden' name='FENLEI'  value='<%=FENLEI %>'/>
		<input type='hidden' name='CLI_IDENTITY_CARD'  value='<%=CLI_IDENTITY_CARD %>'/>
		<br/>
		<input type='submit' value='查询' />
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