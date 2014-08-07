package com.gdbocom.action.gds;

import java.io.IOException;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.gdbocom.util.communication.custom.gds.GdsPubData;
import com.viatt.util.GzLog;


public class Gds_GdsBIds extends HttpServlet {

    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;


    public Gds_GdsBIds() {
        super();
    }

    public void destroy() {
        super.destroy(); 
    }

    
    public void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        this.doPost(request, response);

    }

    
    public void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        response.setContentType("text/html;charset=utf-8");
        request.setCharacterEncoding("utf-8");

        PageContext pageContext = JspFactory.getDefaultFactory()
                .getPageContext(this, request, response, null, true,
                        8192, true);

        GzLog gzLog = new GzLog("c:/gzLog_sj");
        String uri = request.getRequestURI();
        String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
        gzLog.Write(sjNo+"进入["+uri+"]");


        /*处理checkbox表单项，通过轮循GdsBid440**，生成GdsBids，格式为：
         * 44101,44102... 可以通过下列两种方式进行判断是否勾选了对应项：
         *1、gdsBIdsBuffer.indexOf(businessKey)!=-1
         *2、通过split(",")方法获取业务代码数组进行遍历
         */
        StringBuffer gdsBIdsBuffer = new StringBuffer();
        Map business = GdsPubData.getSignBusiness();
        Iterator itBusiness = business.keySet().iterator();
        while (itBusiness.hasNext()) {

            String businessId = (String) itBusiness.next();
            String businessKey = "GdsBId" + businessId;

            if(null!=request.getParameter(businessKey)){
                gdsBIdsBuffer.append(businessId).append(",");
            }

        }

        //如果没有勾选签约项，返回选择菜单
        if("".equals(gdsBIdsBuffer.toString())){
            pageContext.forward("Gds_Pub_Menu.jsp");
        }else{
            pageContext.setAttribute("Gds_GdsBIds",
                    gdsBIdsBuffer.toString(),
                    PageContext.SESSION_SCOPE);
            pageContext.forward("Gds_Spe_Data.jsp");
        }
    }

    
    public void init() throws ServletException {
        // Put your code here
    }

}
