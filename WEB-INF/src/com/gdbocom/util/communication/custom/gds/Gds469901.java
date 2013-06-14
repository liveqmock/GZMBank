package com.gdbocom.util.communication.custom.gds;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.util.HashMap;
import java.util.Map;

import com.gdbocom.util.communication.FieldSource;
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

    @Override
    protected byte[] buildRequestBody(Map<String, String> request)
            throws UnsupportedEncodingException {

        byte[] pubData = new GdsPubData().buildRequestBody(request);
        Object[][] format = {
                {"BnkTyp", "%-2s", "16"}, //银行类型,客户输入：bank*
                {"BnkNo", "%-12s", FieldSource.VAR}, //银行行号,客户输入
                {"InNum", "%-2s", "1"}, //笔数,固定签约一笔
                {"SubSts", "%-1s", FieldSource.VAR}, //状态
                {"OrgCod", "%-12s", }, //代收单位编码
                {"TBusTp", "%-5s", }, //业务类型
                {"TCusId", "%-10s", }, //用户标识
                {"TCusNm", "%-60s", }, //用户名称
                {"GdsAId", "%-55s", }, //协议号
                {"EffDat", "%-8s", }, //生效日期
                {"IvdDat", "%-8s", }, //失效日期
        };
        byte[] body = Transation.packetSequence(request, format);
        return Transation.mergeByte(pubData, body);
    }

    @Override
    protected Map<String, String> parseNormalResponseBody(byte[] response)
            throws UnsupportedEncodingException {
        // TODO Auto-generated method stub
        return null;
    }

    public static void main(String[] args) throws UnknownHostException, IOException{
        /*Map<String, String> request = new HashMap<String, String>();
        //报文头字段
        request.put("TTxnCd", "469901");
        request.put("FeCod", "469901");
        request.put("TxnSrc", "MB441");
        //报文体字段
        request.put("Func", GdsPubData.functionQuery);
        request.put("GdsBId", GdsPubData.businessOfWater);
        request.put("ActNo", "6222600710007815865");
        //request.put("ActTyp", ); //账户性质已经写死太平洋卡4
        request.put("ActNm", "顾启明");
        //request.put("VchTyp", ); //账户性质已经写死太平洋卡4
        //request.put("VchNo", ); //账户性质已经写死太平洋卡4
        //request.put("BokSeq", ); //账户性质已经写死太平洋卡4
        request.put("BCusNo", );
        request.put("PfaSub",   );
        request.put("BCusId", );
        request.put("IdType",   );
        request.put("IdNo", );
        request.put("TelTyp",   );
        request.put("TelNo", );
        request.put("MobTyp",   );
        request.put("MobTel", );
        request.put("EMail", );
        request.put("Addr", );
        request.put("IExtFg", );

        Transation.exchangeData(IcsServer.getServer("@GDS"),
                request,
                TransationFactory.GDS469901);*/
        Gds469901 test = new Gds469901();
        for(int i=130; i<199; i++){
            System.out.println(i+":"+test.telNum2telType(i+"70959854"));

        }

    }

}
