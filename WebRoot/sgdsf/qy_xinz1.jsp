<?xml version="1.0" encoding="utf-8"?>
<%@ page language="java" pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.util.communication.*" %>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.gdbocom.util.format.*" %>
<!-- 分行特色业务频道列表 -->
<%
	/****************************/
	request.setCharacterEncoding("UTF-8");
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String uri = request.getRequestURI();
	String CrdNo = request.getHeader("MBK_ACCOUNT");  //银行账户
	//System.out.println("CrdNo===========:"+CrdNo);
	String sjNo = request.getHeader("MBK_MOBILE");  //手机号码
	
	String BusCla = request.getParameter("BusCla");
	String BUSCLA = request.getParameter("BUSCLA");
	String CLI_IDENTITY_CARD = request.getParameter("CLI_IDENTITY_CARD");
	gzLog.Write("进入["+uri+"]");
	String errPage = "";
	//request.setAttribute("BUSCLA", "05");
 	pageContext.setAttribute("BUSCLA", BUSCLA, PageContext.SESSION_SCOPE);
 	//System.out.println(pageContext.getAttribute("BUSCLA"));
 	Map responseValues = new HashMap();
	try{
		 responseValues.putAll(
		Transation.createMapSend(pageContext,"466670","@SGD_A",TransationFactory.SGD466670)
	);
	}catch(Exception e){
		String RspCod = "LOT999";
		String RspMsg = "通讯故障"; 
		//gzLog.Write("["+uri+"]MGID不正确");
		StringBuffer forwardString = new StringBuffer();
		forwardString.append(errPage).append("?");
		forwardString.append("RspCod").append("=").append(RspCod);
		forwardString.append("&");
		forwardString.append("RspMsg").append("=").append(RspMsg);
	}
%>
<res>
	<content>
       <form method='post' action='<%=request.getContextPath() + "/sgdsf/qy_xinz2.jsp"%>' >
			<label>客户证件号：<%=CLI_IDENTITY_CARD %></label>
			<br/>
			<label>业务分类: <%=BusCla %></label>
		    <br/>
		    <%	
			if(responseValues.get("MsgTyp").equals("N")){
		
		    %>
		   <table>
		   <tr>
		   <td><label>区域：</label></td>
	      <td><select name="AREANUM">
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
		<input type='hidden' name='FENLEI'  value="<%=BusCla %>"/>
		<input type='hidden' name='BUSCLA'  value="<%=BUSCLA %>"/>
		<input type='hidden' name='CLI_IDENTITY_CARD'  value="<%=CLI_IDENTITY_CARD %>"/>
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
