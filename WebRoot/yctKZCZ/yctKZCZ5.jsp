<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>

<%
		GzLog gzLog = new GzLog("c:/gzLog_sj");
		gzLog.Write("羊城通自动充值yctKZCZ5.....");
    String sParam2  = MessManTool.changeChar(request.getParameter("param1"));
		gzLog.Write(sParam2);
    String sInfo[] = sParam2.split("\\|");
   
		gzLog.Write(String.valueOf(sInfo.length));
    for(int i=0; i<sInfo.length; i++){
      gzLog.Write(i+":"+sInfo[i]);
    }
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
       <form method='post' action='/GZMBank/yctKZCZ/yctKZCZ6.jsp'>
         <label>签约信息确认</label>
       
       
         <label>用户姓名:<%=sInfo[0].trim()%></label>
         
         <label>身份证号码:<%=sInfo[1].trim()%></label>
          
         <label>性别:<%=sInfo[2].trim().equals("0")?"男":"女"%></label>
          
         <label>羊城通卡号:<%=sInfo[3].trim()%></label>
       
		     <label>请输入交易密码:</label>
       
         <input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
         <input type='hidden' name='MBK_BOCOMACC_PASSWORD'  value='password'></input>
         <input type='hidden'  name='MBK_VERIFY' value='true'></input>
       <%
        //更改加密方式此段程序封闭20110419
       //<input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
       %>
       <input type='hidden' name='param2' value='<%=sParam2%>'></input>
       <% //iphone
       //<table>
       //   <tr>
       //      <td>
       //        <input type="submit" value="确定"/>
       //      </td>
       //      <td>
       //         <input type='button' name='cancel' value="取消"/>
       //      </td>
       //   </tr>
       //</table>
       %>
         <input type="submit" value="确定"/>
         <input type='button' name='cancel' value="取消"/>
       </form>

	</content>
</res>