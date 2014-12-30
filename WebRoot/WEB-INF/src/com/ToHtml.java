package com;
import java.io.ByteArrayOutputStream;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpServletResponseWrapper;
   
 public class ToHtml extends HttpServlet {   
   public void service(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {   
   
     String url="";   
     String name="";   
     ServletContext sc = getServletContext();   
   
     url=request.getParameter("url");
     //url = "/WelLot/Wel_hTen_numSeleSingle.jsp";   
   
      //这是生成的html文件名,如index.htm.      
     name="/htmlOutput/a.html";  
     name = getServletContext().getRealPath(name);
     
     RequestDispatcher rd = sc.getRequestDispatcher(url);   
     final ByteArrayOutputStream os = new ByteArrayOutputStream();   
   
       final ServletOutputStream stream = new ServletOutputStream() {   
         public void write(byte[] data, int offset, int length) {   
           os.write(data, offset, length);   
         }   
         public void write(int b) throws IOException {   
            os.write(b);   
         }   
       };   
       final PrintWriter pw = new PrintWriter(new OutputStreamWriter(os));   
   
       HttpServletResponse rep = new HttpServletResponseWrapper(response) {   
         public ServletOutputStream getOutputStream() {   
           return stream;   
         }   
         public PrintWriter getWriter() {   
           return pw;   
         }   
       };   
   
       rd.include(request, rep);   
       pw.flush();          
   
       //把jsp输出的内容写到xxx.htm  
       File file = new File(name);
       if (!file.exists()) {
           file.createNewFile();
           
       }
       System.out.println(name);
       FileOutputStream fos = new FileOutputStream(file);    
   
       os.writeTo(fos);   
       fos.close();   
   
       response.setContentType("text/html;charset=gbk");
       PrintWriter out=response.getWriter();   
       out.print("<p align=center><font size=3 color=red>首页已经成功生成！Andrew</font></p>");   
       }   
 }