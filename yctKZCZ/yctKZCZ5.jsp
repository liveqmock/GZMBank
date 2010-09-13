<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>

<%
   //System.out.println("羊城通自动充值yctKZCZ5.....");
   String sParam2  = MessManTool.changeChar(request.getParameter("param1"));
   String sInfo[] = sParam2.split("#:>");
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
       <form method='post' action='/GZMBank/yctKZCZ/yctKZCZ6.jsp'>
       <h4>签约信息确认</h4>
       
       <table>
          <tr>
             <td>用户姓名:</td>    <td><%=sInfo[0].trim()%></td>
          </tr>
          <tr>
             <td>身份证号码:</td>  <td><%=sInfo[1].trim()%></td>
          </tr>
          <tr>
             <td>性别:</td>        <td><%=sInfo[2].trim().equals("0")?"男":"女"%></td>
          </tr>
          <tr>
             <td>羊城通卡号:</td>  <td><%=sInfo[3].trim()%></td>
          </tr>
       </table>
       
		   <h4>请输入交易密码:</h4>
       <br/>
       
       <input type='password' name='password' style="-wap-input-required: 'true'" minleng='6' maxleng='6' encrypt/>
       <input type='hidden' name='MBK_SECURITY_PASSWORD'  value='password'></input>
       <input type='hidden' name='param2' value='<%=sParam2%>'></input>
       <table>
          <tr>
             <td>
               <input type="submit" value="确定"/>
             </td>
             <td>
                <input type='button' name='cancel' value="取消"/>
             </td>
          </tr>
       </table>
       </form>

	</content>
</res>