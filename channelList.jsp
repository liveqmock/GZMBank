<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%@ page import="java.sql.*"%>
<%@ page import="java.net.*"%>
<%@ page import="java.io.*"%>
<%@ page import="com.viatt.util.*"%>
<!-- 分行特色业务频道列表 -->
<%
	GzLog log = new GzLog("c:/gzLog_sj");
	
	
	log.Write("=================Mobile Phone channelList.jsp======================begin==========");

	String cdno = request.getHeader("MBK_ACCOUNT");
	int crdLength = cdno.length();
	String cardNumber = cdno;
	//如果卡号的长度小于21位 则需要在右侧补空格，补成21bit长
	if(crdLength<21){
		for (int i=crdLength; i<21; i++){
		 	cardNumber=cardNumber+" ";
		}
	}
	
	String version = request.getHeader("MBK_VERSION");
	
	//Initial Definition
	
	char errorFlag;
	String willInsert="NO";
	boolean hasAgree=false;
	
	willInsert=request.getParameter("willInsert");
	if(willInsert==null){
		willInsert="NO";
	}
	
	
	
	log.Write("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	log.Write("MBK_ACCOUNT=cdno:"+request.getHeader("MBK_ACCOUNT"));
	log.Write("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	log.Write("MBK_POI:"+request.getHeader("MBK_POI"));
	log.Write("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	log.Write("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	
	log.Write("SessionId："+session.getAttribute("id"));
	log.Write("INITIAL hasAgree:"+hasAgree);
	log.Write("INITIAL willInsert:"+willInsert);
	
	


	
	String testIp="182.53.15.200";
	int testPort=35850;
	
	String businessIp="182.53.1.6";
	int businessPort=35850;
	
	
	//下端会被调用
	String ipAdress = testIp;
	int portNo = testPort;
	

	
	//############################查询是否签约#################################


%>


<res>

  <channel>
      <id>441025</id>
      <title>缴费一站通</title>
      <url>/GZMBank/SignAtOne/Gds_Pub_Agree.jsp</url>
  </channel>

  <channel>
      <id>441026</id>
      <title>内置变量测试</title>
      <url>/GZMBank/SignAtOne/Hello</url>
  </channel>

  <channel>
      <id>441027</id>
      <title>内置变量测试</title>
      <url>/GZMBank/SignAtOne/Hello.jsp</url>
  </channel>

  <channel>
      <id>441005</id>
      <title>非税业务</title>
      <url>/GZMBank/Feishui/feishui0.jsp</url>
  </channel>


 <channel>
		<id>441023</id>
		<title>通讯类缴费业务</title>
		<url>/GZMBank/JiaoFei/JiaoFei1.jsp</url>
  </channel>

  <channel>
		<id>441022</id>
		<title>通讯类充值业务</title>
		<url>/GZMBank/ChongZhi/ChongZhi1.jsp</url>
  </channel>


  <channel>
		<id>441021</id>
		<title>移动全品牌划扣签约</title>
		<url>/GZMBank/yiDongCharge/yiDongCharge0.jsp</url>
  </channel>
  
   <channel>
		<id>441024</id>
		<title>银旅通旅游门票业务</title>
		<url>/GZMBank/yinLvTong/yinLvTong1.jsp</url>
  </channel>

  <channel>
		<id>441024</id>
		<title>体彩业务</title>
		<url>/GZMBank/SportsTicket/sportsTicket1.jsp</url>
  </channel>

  <channel>
		<id>441017</id>
		<title>电费缴纳</title>
		<url>/GZMBank/ElectronicBill/BillPayment1.jsp</url>
  </channel>
  
  <channel>
      <id>441004</id>
      <title>羊城通自动充值</title>
      <url>/GZMBank/yctKZCZ/yctKZCZ1.jsp</url>
  </channel>

  <!--channel>
      <id>441013</id>
      <title>我要抽奖</title>
      <url>/GZMBank/lottdraw/lottdraw1.jsp</url>
  </channel-->

  <!--channel>
      <id>441014</id>
      <title>兑奖登记</title>
      <url>/GZMBank/lottdraw/AccptAward1.jsp</url>
  </channel-->
  <!--channel>
      <id>441006</id>
      <title>联通缴费</title>
      <url>/GZMBank/txLTong/LTongJF1.jsp</url>
  </channel-->
  <!--channel>
      <id>441010</id>
      <title>天讯电信缴费</title>
      <url>/GZMBank/txDianXin/txDianXin1.jsp</url>
  </channel-->
  <!--channel>
      <id>441001</id>
      <title>银旅通电子门票</title>
      <url>/GZMBank/yinLvTong/yinLvTongMPYD1.jsp</url>
  </channel-->
  
  <!--channel>
      <id>441002</id>
      <title>银旅通旅游缴费</title>
      <url>/GZMBank/yinLvTong/yinLvTongJF1.jsp</url>
  </channel-->
  
  <!--channel>
      <id>441003</id>
      <title>移动缴费</title>
      <url>/GZMBank/txYiDong/yiDongJF1.jsp</url>
  </channel-->

  
  
  <!--channel>
      <id>441005</id>
      <title>营业网点搜索</title>
      <url>/GZMBank/siteSearch/siteSearch1.jsp</url>
  </channel-->



  <!--channel>
      <id>441007</id>
      <title>测测你</title>
      <url>/GZMBank/test/xuantest.jsp</url>
  </channel-->

  <!--channel>
      <id>441008</id>
      <title>测试</title>
      <url>/GZMBank/test2/test1.jsp</url>
  </channel-->

  <!--channel>
      <id>441011</id>
      <title>购买体育彩票</title>
      <url>/GZMBank/SportsTicket/TicketSale1.jsp</url>
  </channel-->

  <!--channel>
      <id>441012</id>
      <title>查询体彩投注情况</title>
      <url>/GZMBank/SportsTicket/TicketQuery1.jsp</url>
  </channel-->
  



</res>
