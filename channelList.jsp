<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<!-- 分行特色业务频道列表 -->
<%
	System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	String cdno = request.getHeader("MBK_ACCOUNT");
	String version = request.getHeader("MBK_VERSION");
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));
%>

<res>
<% 
	if ( version.equals("MBK_CLIENT") ) {
%>
  <channel>
      <id>441006</id>
      <title>联通缴费</title>
      <url>/GZMBank/txLTong/LTongJF1.jsp</url>
  </channel>
  <channel>
      <id>441010</id>
      <title>天讯电信缴费</title>
      <url>/GZMBank/txDianXin/txDianXin1.jsp</url>
  </channel>
  <channel>
      <id>441001</id>
      <title>银旅通电子门票</title>
      <url>/GZMBank/yinLvTong/yinLvTongMPYD1.jsp</url>
  </channel>
  
  <channel>
      <id>441002</id>
      <title>银旅通旅游缴费</title>
      <url>/GZMBank/yinLvTong/yinLvTongJF1.jsp</url>
  </channel>
  
  <channel>
      <id>441003</id>
      <title>移动缴费</title>
      <url>/GZMBank/txYiDong/yiDongJF1.jsp</url>
  </channel>

  <channel>
      <id>441004</id>
      <title>羊城通自动充值</title>
      <url>/GZMBank/yctKZCZ/yctKZCZ1.jsp</url>
  </channel>
  
  <channel>
      <id>441005</id>
      <title>营业网点搜索</title>
      <url>/GZMBank/siteSearch/siteSearch1.jsp</url>
  </channel>



  <channel>
      <id>441007</id>
      <title>测测你</title>
      <url>/GZMBank/test/xuantest.jsp</url>
  </channel>

  <channel>
      <id>441008</id>
      <title>测试</title>
      <url>/GZMBank/test2/test1.jsp</url>
  </channel>

  <channel>
      <id>441011</id>
      <title>购买体育彩票</title>
      <url>/GZMBank/SportsTicket/TicketSale1.jsp</url>
  </channel>

  <channel>
      <id>441012</id>
      <title>查询体彩投注情况</title>
      <url>/GZMBank/SportsTicket/TicketQuery1.jsp</url>
  </channel>

<%
} else if (version.equals("MBK_WAP_2")) {
%>
  <channel>
      <id>441009</id>
      <title>羊城通自动充值</title>
      <url>/GZMBank/yctKZCZ_WAP2/yctKZCZ1_WAP2.jsp</url>
  </channel>
<%
  }
%>
</res>
