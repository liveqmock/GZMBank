package com.gdbocom.action.gds;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdbocom.util.communication.IcsServer;
import com.gdbocom.util.communication.Transation;
import com.gdbocom.util.communication.TransationFactory;
import com.viatt.util.GzLog;


public class Query_469998 extends HttpServlet {

    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;


    public Query_469998() {
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

        GzLog gzLog = new GzLog("c:/gzLog_sj");
        String uri = request.getRequestURI();
        String sjNo = request.getHeader("MBK_MOBILE");  //注册手机号码
        gzLog.Write(sjNo+"进入["+uri+"]");


        //配置发送参数
        Map requestSt = new HashMap();
        //报文头字段
        requestSt.put("TTxnCd", "469998");
        requestSt.put("FeCod", "469998");

        //报文体字段
        System.out.println((String)request.getParameter("CrdNo"));
        requestSt.put("ActNo", (String)request.getParameter("CrdNo"));

        Map responseMap = Transation
                .exchangeData(IcsServer.getServer("@GDS"),
                requestSt,
                TransationFactory.GDS469998);

        StringBuffer queryString = new StringBuffer();
        queryString.append("Add_469901?")
            .append("ActNm=").append(responseMap.get("TCusNm"))
            .append("&")
            .append("BCusNo=").append(responseMap.get("TCusId"))
            .append("&")
            .append("IdNo=").append(responseMap.get("IdNo"));

        System.out.println(queryString.toString());
        request.getRequestDispatcher(queryString.toString())
            .forward(request, response);

    }

    
    public void init() throws ServletException {
        // Put your code here
    }

}
