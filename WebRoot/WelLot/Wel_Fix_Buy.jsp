<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.util.*" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");
	String uri = request.getRequestURI();
	gzLog.Write("进入["+uri+"]");

	//补充通讯字段
	pageContext.setAttribute("GameId", "5", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("PlayId", "1", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("GrpNum", "2", PageContext.SESSION_SCOPE);
	pageContext.setAttribute("CrdNo", cdno, PageContext.SESSION_SCOPE);
	
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<form method='post' action='/GZMBank/WelLot/Wel_Pck_Confirm.jsp'>
		<label>双色球</label><br/>
		<label>红色球（至少选择6个红球）</label>

		<table>
    <%
    	List lstFore = new ArrayList();
    	for(int i=1; i<34; i++){lstFore.add(i+"");}
        for(int i=0; i<7; i++){
    %>
			<tr>
            <%
                for(int j=1;j<=5;j++){
					int tmp = i*5+j;
            %>
				<td> 
			<%
					if(lstFore.contains(tmp+"")){
			%>
	        		<input type='checkbox' name='forepart<%=tmp%>' value='<%=this.formatnumber(tmp)%>'><%=this.formatnumber(tmp)%></input>
			<%
					}
			%>
				</td>
			<%				
			    }
			%>
			</tr>
	<%				
		}
	%>
		</table>



		<label>*******************************</label>
		<label>蓝色球（至少选择1个蓝球）</label>

		<table>
    <%
    	List lstRear = new ArrayList();
    	for(int i=1; i<17; i++){lstRear.add(i+"");}
        for(int i=0; i<4; i++){
    %>
			<tr>
            <%
                for(int j=1;j<=5;j++){
					int tmp = i*5+j;
            %>
				<td> 
			<%
					if(lstRear.contains(tmp+"")){
			%>
	        		<input type='checkbox' name='rear<%=tmp%>' value='<%=this.formatnumber(tmp)%>'><%=this.formatnumber(tmp)%></input>
			<%
					}
			%>
				</td>
			<%				
			    }
			%>
			</tr>
	<%				
		}
	%>
		</table>
   
   		<label>请填写倍数（倍数不超过100）：</label>
		<input type='text' name='BetMul' value='1'></input>
		<input type='hidden' name='preSaveKey' value='BetMul' />
		<input type='submit' value='下一步'></input>
    

	</form>
	</content>
</res>
<%!
	public String formatnumber(int inputstr){
		String outputstr;
		if(inputstr<=9){
			outputstr="0"+String.valueOf(inputstr);
		}else{
			outputstr = String.valueOf(inputstr);
		}
		return outputstr;
	}
%>
