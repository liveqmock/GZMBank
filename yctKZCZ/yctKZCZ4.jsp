<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>

<%
   String sParam1 = MessManTool.changeChar(request.getParameter("param1"));
   //System.out.println("羊城通自动充值yctKZCZ4.....");

%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<form method='post' action='/GZMBank/yctKZCZ/yctKZCZ5.jsp'>

       <table>
          <tr>
             <td>1. 兹以上申明完全属实，本人确认无误，如填写资料有误所造成的损失由本人自行承担。</td>
          </tr> 
          <tr>
             <td>2. 不论申请批准与否，本人同意以上资料由羊城通有限公司和银行保留。</td>
          </tr> 
          <tr>
             <td>3. 本人已清楚了解并同意遵守该自动充值签约交易已申明的所有事项，对因违反规定所造成的损失和后果，本人愿意承担一切法律后果。</td>
          </tr> 
          <tr>
             <td>4. 本人同意并授权交通银行从自动充值签约交易所指定的银行帐户上划扣羊城通自动充值款项。</td>
          </tr> 		   
       </table>
       <input type='hidden' name='param1' value='<%=sParam1%>'></input>
       <input type="submit" value="确定"/>
		</form>

	</content>
</res>