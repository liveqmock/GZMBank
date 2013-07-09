package com.gdbocom.action.gds;

import java.io.IOException;
import java.net.UnknownHostException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.Map;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.gdbocom.util.communication.IcsServer;
import com.gdbocom.util.communication.Transation;
import com.gdbocom.util.communication.TransationFactory;
import com.gdbocom.util.communication.custom.gds.GdsPubData;
import com.viatt.util.GzLog;


public class Add_469901 extends HttpServlet {

    
    /**
     * 
     */
    private static final long serialVersionUID = 1L;

    private GzLog gzLog = new GzLog("c:/gzLog_sj");

    public Add_469901() {
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

        //勾选了的签约交易
        String[] GdsBIds = request.getParameterValues("GdsBIds");
        StringBuffer signingBusiness = new StringBuffer();
        for(int i=0; i<GdsBIds.length; i++){
            signingBusiness.append(GdsBIds[i]);
        }
        //可以签约的交易列表
        Map business = GdsPubData.getSignBusiness();
        Iterator itBusiness = business.keySet().iterator();
        while (itBusiness.hasNext()) {

            String businessKey = (String) itBusiness.next();
            String businessName = (String) business.get(businessKey);
            //只显示有勾选的类型
            if(signingBusiness.indexOf(businessKey)!=-1){
                gzLog.Write("发送"+businessName+"签约交易");
                signSpecicalBusiness(request, businessKey);
            }
        }

        response.sendRedirect("Gds_Pub_Suc.jsp");

    }

    /**
     * @param request
     * @throws UnknownHostException
     * @throws IOException
     */
    private void signSpecicalBusiness(HttpServletRequest request,
            String businessType)
            throws UnknownHostException, IOException {
        //配置发送参数
        Map requestSt = new HashMap();
        // 报文头字段
        requestSt.put("TTxnCd", "469901");
        requestSt.put("FeCod", "469901");

        // 报文体GdsPub字段
        requestSt.put("Func", GdsPubData.functionAdd);
        requestSt.put("GdsBId", businessType);
        requestSt.put("ActNo", (String)request.getParameter("CrdNo"));
        requestSt.put("ActNm", (String)request.getParameter("ActNm"));
        requestSt.put("BCusNo", (String)request.getParameter("BCusNo"));
        requestSt.put("BCusId", "");
        requestSt.put("IdNo", (String)request.getParameter("IdNo"));
        requestSt.put("MobTyp", GdsPubData.contactMobile);
        requestSt.put("MobTel", (String)request.getHeader("MBK_MOBILE"));
        requestSt.put("EMail", "");
        requestSt.put("Addr", "");


        // 特殊字段
        requestSt.put("BnkNo", GdsPubData.bankNo);
        requestSt.put("OrgCod", GdsPubData.getBCusId().get(businessType));
        requestSt.put("TBusTp", GdsPubData.getTBusTp().get(businessType));
        requestSt.put("TCusId",
                (String)request.getParameter("TCusId"+businessType));
        requestSt.put("TCusNm",
                (String)request.getParameter("TCusNm"+businessType));
        StringBuffer gdsAId = new StringBuffer().append("01")
                .append("5810")
                .append(GdsPubData.getBCusId().get(businessType))
                .append(GdsPubData.getTBusTp().get(businessType))
                .append("301")
                .append((String)request.getParameter("CrdNo"));
        requestSt.put("GdsAId", gdsAId.toString());

        SimpleDateFormat sf = new SimpleDateFormat("yyyyMMdd");
        requestSt.put("EffDat", sf.format(new Date()));

        Transation.exchangeData(IcsServer.getServer("@GDS"),
                requestSt, TransationFactory.GDS469901);
    }

    
    public void init() throws ServletException {
        // Put your code here
    }

}
