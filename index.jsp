﻿<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<!-- 分行特色业务频道列表 -->
<%
	//System.out.println("MBK_ACCOUNT:"+request.getHeader("MBK_ACCOUNT"));
	//System.out.println("MBK_VERIFY_RESULT:"+request.getHeader("MBK_VERIFY_RESULT"));
	
	//System.out.println("MBK_MOBILE:"+request.getHeader("MBK_MOBILE"));
	//System.out.println("MBK_POI:"+request.getHeader("MBK_POI"));
	
	//System.out.println("MBK_SECURITY_PASSWORD:"+request.getHeader("MBK_SECURITY_PASSWORD"));
	//System.out.println("MBK_VERSION:"+request.getHeader("MBK_VERSION"));	

	//System.out.println("id："+session.getAttribute("id"));
%>
<res>
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
</res>