<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = request.getHeader("MBK_ACCOUNT");
	String sjNo = request.getHeader("MBK_MOBILE");

	String TikMod = request.getParameter("TikMod");
	String LotTyp = request.getParameter("LotTyp");
	String MulTip = request.getParameter("MulTip");
	String ExtNum = request.getParameter("ExtNum");
	String ErrMsg = request.getParameter("ErrMsg")==null?"":request.getParameter("ErrMsg");
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n体育彩票购买步骤41：TikMod:"+TikMod
				+"|LotTyp:"+LotTyp
				+"|MulTip:"+MulTip
				+"|ExtNum:"+ExtNum
				+"|");
%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
	<form method='post' action='/GZMBank/SportsTicket/TicketSaleA4.jsp'>
		<label>大乐透</label><br/>
		<%
		if(!ErrMsg.equals(""))
		{
		%>
		<label><%=ErrMsg%></label>
		<%
		}
		%>
		<label>请选择前区号码(请任意选择5个或以上号码)</label>
    
   
    <%
        for(int i=0; i<7; i++){
    %>
       
            <%
                for(int j=1;j<=5;j++){
									int tmp = i*5+j;
            %>
			          <input type='checkbox' name='forepart<%=tmp%>' value='<%=this.formatnumber(tmp)%>'></input>
			          <label><%=tmp%></label>
						<%				
						    }
						%>
        
		<%				
			}
		%>
   


		<label>*******************************</label>
		<label>请选择后区号码(请任意选择2个或以上号码)</label>

   
    <%
        for(int i=0; i<2; i++){
    %>
        
            <%
                for(int j=1;j<=6;j++){
									int tmp = i*6+j;
            %>
			            <input type='checkbox' name='rear<%=tmp%>' value='<%=this.formatnumber(tmp)%>'></input>
			            <label><%=tmp%></label>
						<%				
						    }
						%>
       
		<%				
			}
		%>
    

		<!--购票方式-->
		<input type='hidden' name='TikMod' value='<%=TikMod%>'></input><br/>
		<!--彩票类型-->
		<input type='hidden' name='LotTyp' value='<%=LotTyp%>'></input><br/>
		<!--倍数-->
		<input type='hidden' name='MulTip' value='<%=MulTip%>'></input><br/>
		<!--扩展号码-->
		<input type='hidden' name='ExtNum' value='<%=ExtNum%>'></input><br/>
		<!-- 控制流程 -->
		<input type='hidden' name='workflow' value='A41'></input><br/>
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
