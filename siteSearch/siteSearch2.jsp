<%@ page language="java" contentType="text/xml; charset=UTF-8"%>
<%@ page import="com.viatt.util.*"%>
<%@ page import="java.util.*"%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="java.sql.*"%>

<%
	GzLog gzLog = new GzLog("c:/gzLog_sj");
	String cdno = MessManTool.changeChar(request.getHeader("MBK_ACCOUNT"));
	String sjNo = MessManTool.changeChar(request.getHeader("MBK_MOBILE"));
	gzLog.Write("卡号："+cdno+"手机号："+sjNo+"\n营业网点搜索");
%>

<%  
   String city = request.getParameter("city");
   String sitename=MessManTool.changeChar(request.getParameter("sitename"));
   String dxButton=MessManTool.changeChar(request.getParameter("dxButton"));//从上页取初始值
   String tmp[] = dxButton.split(",");//建立数组
%>
<%

  int   send; //两个FORM的判定值
  int   intPageSize; //一页显示的记录数     
  int   intRowCount; //记录总数     
  int   intPageCount; //总页数     
  int   intPage; //待显示页码     
  String   strPage;     
  String   rsend;  
  int   i;     

  rsend = request.getParameter("send");
   if ( rsend == null)//表明如果rsend初始为null时，send为0
   {
	   send= 0;
       }
   else
   {
	   send = 1; 
       }
     
  intPageSize = 10; //设置一页显示的记录数    
 
strPage = request.getParameter("intPage"); //取得待显示页码
     
if(strPage == null)//表明如果intPage为null时，将显示第一页数据
  {     
  intPage = 1;     
       }  
  else
  {     
  
  intPage = Integer.parseInt(strPage); //将字符串转换成整型    
  if(intPage<1)   
  intPage = 1;     
       }   
  
%>
 
	
<%//连接数据库
Connection dbConn = null;
    try {
        dbConn = DriverManager.getConnection("jdbc:sybase:Tds:182.53.4.118:6006/pbbranchdb?CHARSET=cp936&amp;amp;LANGUAGE=en_US", "miduser", "miduser");
    } catch (SQLException ex) {

        gzLog.Write("db.connect:" + ex.getMessage());

    }
    
		Statement st = null;

		ResultSet rs = null;
		
		try
		{
	  
	    String sqlstr = "select * from sitemap where (cityName='"+city+"' and wdName like '%"+sitename+"%') or (cityName='"+city+"' and '"+sitename+"'='') ";
	   
	    System.out.println(sqlstr);
		//创建一个可以滚动的只读的sql语句对象
        st = dbConn.createStatement(java.sql.ResultSet.TYPE_SCROLL_INSENSITIVE,java.sql.ResultSet.CONCUR_READ_ONLY);
	    System.out.println(sitename);
        rs = st.executeQuery(sqlstr);
		rs.last();//光标转到最后一行
 
	   } catch (SQLException e) {
	        gzLog.Write("db.connect:" + e.getMessage());
	   }
   
		intRowCount = rs.getRow(); //计算出总行数
		
		intPageCount = (intRowCount+intPageSize-1) / intPageSize;//总页数 
		if(intPage>intPageCount) intPage = intPageCount;
	
%>


<?xml version="1.0" encoding="utf-8"?> 
<res>
	<content>
       <%if (send > 0)//判定，当send+1之后，执行form2，输出复选框提交之后的画面
	   {%>
       <form name='form2' method='post' action='/GZMBank/siteSearch/siteSearch3.jsp'>

       <table border="0">

   <input type="hidden" name="dxButton" value="<%=dxButton%>"/>
   
   <tr><td> <%=tmp[0]%>：</td></tr> 
  <tr><td>地址： <%=tmp[1]%></td></tr> 
  <tr><td>电话： <%=tmp[2]%></td></tr> 
 	

		
	  </table>

	   <%}else//当send+1没有执行之前，执行列表并实现分页处理
	   {%>
       <form name='form' method='post' action='/GZMBank/siteSearch/siteSearch2.jsp'>
		<table border="0">
		<%if (intPageCount>0){%>
			<tr><td>选择</td><td>营业网点</td></tr><%}%>

  <%if(intPageCount<1){//如果总行数小于1，既没有，显示以下错误信息
	out.println("没有查询到您要找的网点信息，请按“返回”键重新查找！");}%>
    

<%     
  if(intPageCount>0)
{     
       
  rs.absolute((intPage-1)*intPageSize + 1); //将记录指针定位到待显示页的第一条记录上   
      
  i = 0;     
  while(i<intPageSize && !rs.isAfterLast())//显示数据
{     
  
  	    String tmps1 =rs.getString("wdName")+",";
	    String tmps2 =rs.getString("address")+",";
		String tmps3 =rs.getString("phoneNo");%>
	   
 <% String tmpstr =tmps1+tmps2+tmps3;%>
	
  <tr>
    <td><input name="dxButton" type="radio" value="<%=tmpstr%>"/></td>
    <td><%=rs.getString("wdName")%></td>
  </tr>
  <tr>
    <td></td>
    <td>
       电话：<%=rs.getString("phoneNo")%>
    </td>
  </tr>
  <tr>
    <td></td>
    <td>
       地址：<%=rs.getString("address")%>
    </td>
  </tr>
  
  
      
  <%     
  rs.next();     
  i++;     
}     
     
  %>     
	
</table>
		  

		第<%=intPage%>页     共<%=intPageCount%>页	
		
<%if (intPageCount>1)	
{
%>	

<select name="intPage">
            <%
			if(intPage<intPageCount)
		    {
		    %>
  <option value="<%=intPage+1%>">下一页</option>
 
                <%
					}

   			if(intPage>1)
    		{
    		%>
  <option value="<%=intPage-1%>">上一页</option>
                <%}%>
   
</select>
<%}%>

    <input type="hidden" name="city"  value=<%=city%>></input>
    <input type="hidden" name="sitename"  value=<%=sitename%>></input>

<input name="send" type="checkbox" value="<%=send+1%>" >如需将选定的网点信息发送至手机，<p>请您在此选项前打勾！</p>

 <%}%>   

   
<%
}
%>

		<input type="submit" value="确定"></input>
	   </form>

	</content>
</res>

<%     
       
  rs.close(); //关闭结果集  
      
  st.close(); //关闭SQL语句对象    
     
  dbConn.close(); //关闭数据库    
 
  %>
  