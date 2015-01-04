<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@page pageEncoding="utf-8"%>
<%@ page import="java.util.*" %>
<%@ page import="com.gdbocom.Transactions.WelLot" %>
<%@include file="/includeFiles/common.jsp" %>
<%
String buyMode=ReqParamUtil.getParamAttr(request,"buyMode");
HpTenBallCreater creater=new HpTenBallCreater(buyMode);
List selNumList=creater.getSelNumList();
HpTenBallCreater.HpTenParam param=creater.getParam();//获取配置参数
String buyModeName=param.name;
String selNum=String.valueOf(param.selNum);//需选择的号码个数
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<form method='post' action='/GZMBank/WelLot/Wel_hTen_Confirm.jsp'>
		<label><%=buyModeName%></label><br/>
		<label>请至少选择<%=selNum%>个号码</label>
		<table>
			<%
		        for(int i=0;i<selNumList.size(); i++){
		        	String obj=selNumList.get(i).toString();
		        	int val=Integer.parseInt(obj);
		        	
					if(i==0||val%5==1){
    					out.print("<tr>");
    				}
		    %>
						<td> 
			        		<input type='checkbox' name='1selNum<%=String.valueOf(i)%>' value='<%=obj%>'><%=obj%></input>
						</td>
			<%
	    		    //换行
	    			if(val%5==0||i==(selNumList.size()-1)){
	    				out.print("</tr>");
	    			}
				}
			%>
		</table>
		<input type='hidden' name='group' value='1'></input>
   		<label>倍数(不超过100)：</label>
		<input type='text' name='BetMul' value='1'></input>
		<%=
			ReqParamUtil.reqParamAttrToHtmlStr(request)
		%>
		<input type='submit' value='下一步'></input>
	</form>
	</content>
</res>