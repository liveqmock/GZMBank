<%@page pageEncoding="UTF-8"%>
<%@ page language="java" contentType="text/xml; charset=UTF-8" %>
<%request.setCharacterEncoding("UTF-8");%>
<%@ page import="com.viatt.util.GzLog" %>
<%@ page import="com.viatt.util.*"%>
<?xml version="1.0" encoding="utf-8"?>
<res>
	<content>
		<label>abc</label>
<%
	for(int i=1;i<=35;i++){
		if(request.getParameter("forepart"+i)!=null){
			out.println(request.getParameter("forepart"+i)+"<br/>");
		}
	}
	
	for(int i=1;i<=12;i++){
		if(request.getParameter("rear"+i)!=null){
			out.println(request.getParameter("rear"+i)+"<br/>");
		}
	}
//	String[] forepart = request.getParameterValues("forepart");
	//out.println("checkbox个数为:"+forepart.length+"<br/>");
	//for(int i=0;i<forepart.length;i++){
//		out.println("checkbox控件第"+(i+1)+"个值为:"+forepart[i]+"<br/>");
//	}
//	String outputString = request.getQueryString();
//	out.println(outputString);
%>
	</content>
</res>