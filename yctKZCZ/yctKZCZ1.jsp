<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>


<%
	  GzLog gzLog = new GzLog("c:/gzLog_sj");
	  String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	  String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	  gzLog.Write("羊城通自动充值yctKZCZ1.....\n");
	  gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n");
   
%>

<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
    <form method='post' action='/GZMBank/yctKZCZ/yctKZCZ2.jsp'>
    <%
      //System.out.println("羊城通自动充值.....");
      String    tmpstr      = "";
      String    sCDNO       = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
      String    sendContext = "biz_id,25|i_biz_step_id,1|TXNSRC,MB441|CDNO,"+sCDNO+"|";
  	  gzLog.Write(">>>>>>"+sendContext);
      MidServer midServer   = new MidServer();
      BwResult  bwResult    = midServer.sendMessage(sendContext);
      String    recvContext = bwResult.getContext();
  	  gzLog.Write("<<<<<<"+recvContext);
      String    sMGID       = MessManTool.getValueByName(recvContext, "MGID");

      if ("000000".equals(sMGID)){
      	MessManTool messManTool = new MessManTool();
      	List        list        = new ArrayList();
      	//482149签约信息查询
        list = messManTool.kongZhongChongZhi1(recvContext);
       	int    total    = list.size();
        int    pageSize = 100;
        String sCurrpage1 = request.getParameter("page") != null ? request.getParameter("page") : "1";
        int    iCurrpage  = Integer.parseInt(sCurrpage1);
    %>		
		
		
				<label> 选择 </label>
				<label> 姓名 </label>
				<label> 羊城通卡号 </label>
				<label> 签约日期 </label>
		
	<%
	      for (int i = 0; i < total; i++) {
			    if ((i >= (iCurrpage - 1) * pageSize)
			      && (i < iCurrpage * pageSize)) {
			        HashMap map = (HashMap) list.get(i);
			             tmpstr = ((String) map.get("param15")).trim()          //客户姓名
			                        +"|"+ ((String) map.get("param22")).trim()  //羊城通卡号
			                        +"|"+ ((String) map.get("param28")).trim()  //签约日期
			                        +"|"+"TheEnd";   
/*
System.out.println("param1:"+((String) map.get("param1")).trim());
System.out.println("param2:"+((String) map.get("param2")).trim());
System.out.println("param3:"+((String) map.get("param3")).trim());
System.out.println("param4:"+((String) map.get("param4")).trim());
System.out.println("param5:"+((String) map.get("param5")).trim());
System.out.println("param6:"+((String) map.get("param6")).trim());
System.out.println("param7:"+((String) map.get("param7")).trim());
System.out.println("param8:"+((String) map.get("param8")).trim());
System.out.println("param9:"+((String) map.get("param9")).trim());
System.out.println("param10:"+((String) map.get("param10")).trim());
System.out.println("param11:"+((String) map.get("param11")).trim());
System.out.println("param12:"+((String) map.get("param12")).trim());
System.out.println("param13:"+((String) map.get("param13")).trim());
System.out.println("param14:"+((String) map.get("param14")).trim());
System.out.println("param15:"+((String) map.get("param15")).trim());
System.out.println("param16:"+((String) map.get("param16")).trim());
System.out.println("param17:"+((String) map.get("param17")).trim());
System.out.println("param18:"+((String) map.get("param18")).trim());
System.out.println("param19:"+((String) map.get("param19")).trim());
System.out.println("param20:"+((String) map.get("param20")).trim());
System.out.println("param21:"+((String) map.get("param21")).trim());
System.out.println("param22:"+((String) map.get("param22")).trim());
System.out.println("param23:"+((String) map.get("param23")).trim());
*/


	%>
			
				<input type="radio" value="<%=tmpstr%>" name="sightContext"/> 
				<label> <%=((String) map.get("param15")).trim()%> </label>
				<label> <%=((String) map.get("param22")).trim()%> </label>
				<label> <%=((String) map.get("param10")).trim().substring(0,4)+"年"+((String) map.get("param10")).trim().substring(4,6)+"月"+((String) map.get("param10")).trim().substring(6,8)+"日"%> </label>
			

    <%
          }
        }
    %>
   
    <%
      if (total==4) { 
    %>
       <label>温馨提示：一张太平洋卡只能和四张羊城通卡签约</label>
       <label>请选择:</label>
		  <select name='contract'>
		  	<option value="2">解约</option>
		  </select>     
    <%
      } else {
    %>
      <label>请选择:</label>
		  <select name='contract'>
		  	<option value="1">新增签约</option>
		  	<option value="2">解约</option>
		  </select>
	<%
	  }
	%>
    <%
    } else {
    %>

      <label>请选择:</label>
		  <select name='contract'>
		  	<option value="1">新增签约</option>
		  </select>
    <%
      }
    %>
		  <input type="submit" value="确定"/>
		</form>
	</content>
</res>