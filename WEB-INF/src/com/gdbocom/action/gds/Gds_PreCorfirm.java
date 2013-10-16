package com.gdbocom.action.gds;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import com.gdbocom.util.communication.custom.gds.GdsPubData;
import com.viatt.util.GzLog;


public class Gds_PreCorfirm extends HttpServlet {

    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;


    public Gds_PreCorfirm() {
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


        //用于在sesion中保存的属性
        Map gds_TCusId = new HashMap();
        Map gds_TCusNm = new HashMap();

        String gds_GdsBIds = (String)pageContext
                .getAttribute("Gds_GdsBIds", PageContext.SESSION_SCOPE);
        String[] gdsBids = gds_GdsBIds.split(",");
        Map business = GdsPubData.getSignBusiness();
        for(int i=0; i<gdsBids.length; i++){
            if( null==gdsBids[i] || ("".equals(gdsBids[i])) ){
                continue;
            }

            String businessId = gdsBids[i];
            String businessName = (String) business.get(businessId);
            if(businessId.equals(GdsPubData.businessOfMobile)){

                Map gdsMobile = new HashMap();
                String tAgtTp = request.getParameter("TAgtTp"+businessId);
                String mCusId = request.getParameter("MCusId"+businessId);
                String tCusId = request.getParameter("TCusId"+businessId);
                gdsMobile.put("tAgtTp", tAgtTp);
                gdsMobile.put("mCusId", mCusId);
                gdsMobile.put("tCusId", tCusId);
                pageContext.setAttribute("Gds_Mobile",
                        gdsMobile, PageContext.SESSION_SCOPE);

            }else{

                String tCusId = request.getParameter("TCusId"+businessId);
                String tCusNm = request.getParameter("TCusNm"+businessId);
                //添加缴费号和缴费户名到gds_TCusId和gds_TCusNm
                gds_TCusId.put(businessId, tCusId);
                gds_TCusNm.put(businessId, tCusNm);

                pageContext.setAttribute("Gds_TCusId",
                        gds_TCusId, PageContext.SESSION_SCOPE);
                pageContext.setAttribute("Gds_TCusNm",
                        gds_TCusNm, PageContext.SESSION_SCOPE);
            }
        }


        request.getRequestDispatcher("Gds_Pub_Confirm.jsp")
        .forward(request, response);
    }

    
    public void init() throws ServletException {
        // Put your code here
    }

}
