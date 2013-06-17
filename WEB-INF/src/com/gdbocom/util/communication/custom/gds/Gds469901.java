package com.gdbocom.util.communication.custom.gds;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import com.gdbocom.util.communication.FieldSource;
import com.gdbocom.util.communication.FieldTypes;
import com.gdbocom.util.communication.IcsServer;
import com.gdbocom.util.communication.Transation;
import com.gdbocom.util.communication.TransationFactory;

public class Gds469901 extends Transation {

    /* 银行类型 */
    protected static String bankAdd    = "0";
    protected static String bankUpdate = "1";
    protected static String bankQuery  = "2";
    protected static String bankDel    = "3";
    protected static String bankBrow   = "4";

    /* 协议状态 */
    protected static String statusTrue  = "0";
    protected static String statusFalse = "1";

    private String Func = "";

    /**
     * 469901交易时，功能为新增和变更与其他交易的报文不一样，分别调用
     * buildAddOrUpdateRequestBody和buildQueryRequestBody方法
     */
    @Override
    protected byte[] buildRequestBody(Map<String, String> request)
            throws UnsupportedEncodingException {

        byte[] pubData = new GdsPubData().buildRequestBody(request);
        byte[] body;
        this.Func = request.get("Func");
 
        if(GdsPubData.functionAdd==this.Func
                ||GdsPubData.functionUpdate==this.Func){
            body = buildAddOrUpdateRequestBody(request);
        }else{
            body = buildQueryRequestBody(request);
        }
        return Transation.mergeByte(pubData, body);

    }

    /**
     * 由于新增和变更的时候，只有TOA报文头，因此返回空集Map对象
     */
    @Override
    protected Map<String, String> parseNormalResponseBody(byte[] response)
            throws UnsupportedEncodingException {

        if(this.Func.equals(GdsPubData.functionQuery)){
            return parseQueryResponseBody(response);
        }else if(this.Func.equals(GdsPubData.functionAdd)
                ||this.Func.equals(GdsPubData.functionUpdate)){
            return new HashMap<String, String>();
        }else{
            throw new IllegalArgumentException();
        }
 
    }

    /**
     * 解析查询返回报文
     * @param response
     * @return
     * @throws UnsupportedEncodingException
     */
    private Map<String, String> parseQueryResponseBody(byte[] response)
            throws UnsupportedEncodingException {
        Object[][] format = {
                {"TmpDat","4",FieldTypes.STATIC},
                {"ApCode","2",FieldTypes.STATIC},
                {"OFmtCd","3",FieldTypes.STATIC},
                {"RecNum","2",FieldTypes.STATIC},
        };
        return Transation.unpacketsSequence(response, format);
    }

    /**
     * 新增和变更交易时需要额外报文PrvDatReq：私有数据请求
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    private byte[] buildAddOrUpdateRequestBody(Map<String, String> request)
            throws UnsupportedEncodingException {

        Object[][] format = {
                {"BnkTyp", "%-2s", "16"}, //银行类型,客户输入：bank*
                {"BnkNo", "%-12s", FieldSource.VAR}, //银行行号,客户输入
                {"InNum", "%-2s", "1"}, //笔数,固定签约一笔
                {"SubSts", "%-1s", "0"}, //状态,0:有效
                {"OrgCod", "%-12s", FieldSource.VAR}, //代收单位编码,469997返回
                {"TBusTp", "%-5s", FieldSource.VAR}, //业务类型,469997返回
                {"TCusId", "%-20s", FieldSource.VAR}, //用户标识,客户输入
                {"TCusNm", "%-60s", FieldSource.VAR}, //用户名称，客户输入
                //协议号，规则：
                //01+469997CityCd+469997OrgCod+469997TBusTp+301+卡号
                {"GdsAId", "%-55s", FieldSource.VAR}, 
                {"EffDat", "%-8s", FieldSource.VAR}, //生效日期
                {"IvdDat", "%-8s", "99991231"}, //失效日期
        };
        return Transation.packetSequence(request, format);
    }

    /**
     * 查询交易时，额外报文“PrvDatReq：私有数据请求”为空字符（不能省略）
     * @param request
     * @return
     * @throws UnsupportedEncodingException
     */
    private byte[] buildQueryRequestBody(Map<String, String> request)
            throws UnsupportedEncodingException {

        return " ".getBytes();
    }

    public static void main(String[] args) throws UnknownHostException, IOException{
        Map<String, String> request = new HashMap<String, String>();
        //报文头字段
        request.put("TTxnCd", "469901");
        request.put("FeCod", "469901");
        request.put("TxnSrc", "MB441");
        //报文体GdsPub字段
        //request.put("Func", GdsPubData.functionAdd);
        request.put("Func", GdsPubData.functionQuery);
        request.put("GdsBId", String.valueOf(GdsPubData.businessOfProvTv));
        request.put("ActNo", "6222600710007815865");
        //request.put("ActTyp", ); //账户性质已经写死太平洋卡4
        /*request.put("ActNm", "顾启明");
        //request.put("VchTyp", ); //账户性质已经写死太平洋卡4
        //request.put("VchNo", ); //账户性质已经写死太平洋卡4
        //request.put("BokSeq", ); //账户性质已经写死太平洋卡4
        request.put("BCusNo", "4419021551084");
        //request.put("PfaSub",   );
        //request.put("BCusId", );
        //request.put("IdType",   );
        request.put("IdNo", "44010419850301501X");*/
        /*request.put("TelTyp", "");
        request.put("TelNo", "");
        request.put("MobTyp", String.valueOf(GdsPubData.contactMobile));
        request.put("MobTel", "13570959854");
        request.put("EMail", "");
        request.put("Addr", "");*/
        //request.put("IExtFg", );
        //水费44101I字段
        /*request.put("BnkNo", "441118");
        request.put("OrgCod", "726482280");
        request.put("TBusTp", "00505");
        request.put("TCusId", "123456");
        request.put("TCusNm", "顾启明");
        request.put("GdsAId", "015810190426853002013016222600710007815865");
        request.put("EffDat", "20130615");*/
        

        Map<String, String> test = Transation
                .exchangeData(IcsServer.getServer("@GDS"),
                request,
                TransationFactory.GDS469901);
        System.out.println(test);
//        Gds469901 test = new Gds469901();
//        for(int i=130; i<199; i++){
//            System.out.println(i+":"+test.telNum2telType(i+"70959854"));
//
//        }

    }

}
