package com.gdbocom.action.gds;


import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;


public class Hello extends HttpServlet {

    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    public void doPost(HttpServletRequest request,
            HttpServletResponse response){
        this.doGet(request, response);
    }

  public void doGet(HttpServletRequest request,
          HttpServletResponse response){
    System.out.println("enter Hello...");

    PageContext pageContext = JspFactory.getDefaultFactory()
        .getPageContext(this, request, response, null, true, 8192, true);
    String forwardPage = "Hello.jsp";
    Map test = new HashMap();
    test.put("1", "a");
    test.put("2", "b");
    test.put("3", "c");
    pageContext.setAttribute("test", test, PageContext.SESSION_SCOPE);
//    String[][] values = {{"servletName", StringUtils.valueOf("servletToJsp")}};
//    String encoding = (request.getCharacterEncoding() == null)
//            ? "ISO-8859-1" : request.getCharacterEncoding();
//    forwardPage = HttpParsing.makeURI(forwardPage, values, encoding);
    System.out.println(forwardPage);



    //跳转页面
    try {
        pageContext.forward(forwardPage);
    } catch (ServletException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    } catch (IOException e) {
        // TODO Auto-generated catch block
        e.printStackTrace();
    }
  }

}