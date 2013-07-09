package com.gdbocom.action.gds;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.jsp.JspFactory;
import javax.servlet.jsp.PageContext;

import weblogic.utils.StringUtils;
import weblogic.utils.http.HttpParsing;

import com.gdbocom.util.communication.IcsServer;
import com.gdbocom.util.communication.Transation;
import com.gdbocom.util.communication.TransationFactory;
import com.gdbocom.util.communication.custom.gds.GdsPubData;
import com.viatt.util.GzLog;


public class Query_469901 extends HttpServlet {

    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private GzLog gzLog = new GzLog("c:/gzLog_sj");

    public Query_469901() {
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
        
        String uri = request.getRequestURI();
        String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
        gzLog.Write(sjNo+"进入["+uri+"]");

        //可以签约的交易列表
        StringBuffer signResult = new StringBuffer();
        Map business = GdsPubData.getSignBusiness();
        Iterator itBusiness = business.keySet().iterator();
        while (itBusiness.hasNext()) {

            String businessKey = (String) itBusiness.next();
            String businessName = (String) business.get(businessKey);
            //只显示有勾选的类型
            if(isSpecicalBusinessSigned(request, businessKey)){
                gzLog.Write(sjNo+"已签约"+businessName);
                signResult.append(businessKey);
            }
        }
        gzLog.Write(sjNo+"签约情况："+signResult.toString());

        PageContext pageContext = JspFactory.getDefaultFactory()
                .getPageContext(this, request, response, null, true,
                        8192, true);
            String forwardPage = "Gds_Pub_Menu.jsp";
            String[][] values = {
                    {"signResult",
                        StringUtils.valueOf(signResult.toString())}
                    };
            String encoding = (request.getCharacterEncoding() == null)
                    ? "ISO-8859-1" : request.getCharacterEncoding();
            forwardPage = HttpParsing
                    .makeURI(forwardPage, values, encoding);
            System.out.println(forwardPage);
            pageContext.forward(forwardPage);

    }

    /**
     * @param request
     * @throws UnknownHostException
     * @throws IOException
     */
    private boolean isSpecicalBusinessSigned(HttpServletRequest request,
            String businessType)
            throws UnknownHostException, IOException {
        //配置发送参数
        Map requestSt = new HashMap();
        // 报文头字段
        requestSt.put("TTxnCd", "469901");
        requestSt.put("FeCod", "469901");

        // 报文体GdsPub字段
        requestSt.put("Func", GdsPubData.functionQuery);
        requestSt.put("GdsBId", businessType);
        requestSt.put("ActNo", (String)request.getParameter("CrdNo"));

        // 特殊字段，无

        Map responseSt = Transation
                .exchangeData(IcsServer.getServer("@GDS"),
                requestSt, TransationFactory.GDS469901);
        return !"0 ".equals((String)responseSt.get("RecNum"));
    }

    
    public void init() throws ServletException {
        // Put your code here
    }

}
