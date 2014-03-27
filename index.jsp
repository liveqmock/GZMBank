<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<!-- 分行特色业务频道列表 -->
<%
	System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));
%>
<res>
	
  <!--channel>
      <id>441015</id>
      <title>我要抽奖</title>
      <url>/GZMBank/lottdraw/lottdraw1.jsp</url>
  </channel-->
 
   
  
  <channel>
      <id>441013</id>
      <title>新客户0元抽奖</title>
      <url>/GZMBank/lottdraw/lottdraw_new1.jsp</url>
  </channel>
  
 <channel>
      <id>441016</id>
      <title>老客户0元抽奖</title>
      <url>/GZMBank/lottdraw/lottdraw_old1.jsp</url>
  </channel>
  
  <channel>
      <id>441025</id>
      <title>缴费一站通</title>
      <url>/GZMBank/SignAtOne/Gds_Pub_Agree.jsp</url>
  </channel>
 <channel>
		<id>441021</id>
		<title>移动随心充</title>
		<url>/GZMBank/yiDongCharge/yiDongCharge0.jsp</url>
  </channel>
  <channel>
      <id>441010</id>
      <title>话费充值</title>
      <url>/GZMBank/ChongZhi/ChongZhi1.jsp</url>
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
      <title>羊城通自动充值</title>
      <url>/GZMBank/yctKZCZ/yctKZCZ1.jsp</url>
  </channel>
  <channel>
      <id>441004</id>
      <title>交费易</title>
      <url>/GZMBank/JiaoFei/JiaoFei1.jsp</url>
  </channel>
  <channel>
      <id>441008</id>
      <title>购买体育彩票</title>
      <url>/GZMBank/SportsTicket/TicketSale1.jsp</url>
      <!--
      因为体彩的平台升级，所以暂停使用手机银行的体彩功能
      <url>/GZMBank/SportsTicket/pause.jsp</url>
      -->
  </channel>
  <channel>
      <id>441009</id>
      <title>查询体彩投注情况</title>
      <url>/GZMBank/SportsTicket/TicketQuery1.jsp</url>
  </channel>
  <channel>
		<id>441017</id>
		<title>电费缴纳</title>
		<url>/GZMBank/ElectronicBill/BillPayment1.jsp</url>
  </channel>
 
</res>