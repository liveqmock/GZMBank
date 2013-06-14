package com.gdbocom.util.communication.custom.gds;

import java.io.UnsupportedEncodingException;
import java.util.HashMap;
import java.util.Map;

import com.gdbocom.util.communication.FieldSource;
import com.gdbocom.util.communication.Transation;

public class GdsPubData extends Transation {

    /* 功能选择项 */
    public static String functionAdd    = "0";
    public static String functionUpdate = "1";
    public static String functionQuery  = "2";
    public static String functionDelete = "3";
    public static String functionBrow   = "4";

    /* 企业种类 */
    public static int businessOfWater       = 44101;
    public static int businessOfMobile      = 44102;
    public static int businessOfUnicom      = 44103;
    public static int businessOfTele        = 44104;
    public static int businessOfGas         = 44105;
    public static int businessOfElectricity = 44106;
    public static int businessOfProvTv      = 44107;
    public static int businessOfCityTv      = 44108;

    /* 固话类型 */
    public static String contactNone   = "0";
    public static String contactMobile = "1";
    public static String contactUnicom = "2";
    public static String contactFixTel = "3";
    public static String contactPHS    = "4";
    public static String contactTianyi = "5";

    @Override
    protected byte[] buildRequestBody(Map<String, String> request)
            throws UnsupportedEncodingException {
        /*
         *  key:关键字, 
         *  String.format{String} eg:%6c ：输出格式, 
         *  [FieldSource|value]：来源或值, 
         */
        Object[][] format = {

                {"Func", "%-1s",  FieldSource.VAR}, //功能选择:function*
                {"GdsBId", "%-5s",  FieldSource.VAR}, //业务标识|企业种类：businessOf*
                {"ActNo", "%-21s",  FieldSource.VAR}, //签约账号,客户输入
                {"ActTyp", "%-1s",  "4"}, //账户性质,4:太平洋卡
                {"ActNm", "%-60s",  FieldSource.VAR}, //签约账户，469998交易
                {"VchTyp", "%-3s",  ""}, //凭证种类,太平洋卡时为空
                {"VchNo", "%-8s",  ""}, //凭证号码,太平洋卡时为空
                {"BokSeq", "%-5s",  ""}, //一本通序号,太平洋卡时为空
                {"BCusNo", "%-13s",  FieldSource.VAR}, //客户号，469998交易
                {"Pin", "%-20s",  FieldSource.VAR}, //密码
                {"PfaSub", "%-3s",  ""}, //财政代码,太平洋卡时为空
                {"BCusId", "%-30s", ""}, //单位编码,太平洋卡时为空
                {"IdType", "%-2s",  "15"}, //证件类型,15：居民身份证
                {"IdNo", "%-30s",  FieldSource.VAR}, //证件号码，469998交易
                {"TelTyp", "%-1s",  FieldSource.VAR}, //固话类型,contact*,
                {"TelNo", "%-30s",  FieldSource.VAR}, //固话号码,客户输入
                {"MobTyp", "%-1s",  FieldSource.VAR}, //移话类型,contact*
                {"MobTel", "%-30s",  FieldSource.VAR}, //移话号码
                {"EMail", "%-60s",  FieldSource.VAR}, //电子邮件,客户输入
                {"Addr", "%-120s",  FieldSource.VAR}, //地址,客户输入
                {"IExtFg", "%-1s",  "Y"}, //私有数据标识
        };
        return Transation.packetSequence(request, format);
        //return "20140320GZ_UNC  1";
    }

    @Override
    protected Map<String, String> parseNormalResponseBody(byte[] response)
            throws UnsupportedEncodingException {

        return new HashMap<String, String>();
    }

    /**
     * 通过手机号码匹配运营商类型
     * @param telNum 手机号码
     * @return 运营商类型
     */
    public static String telNum2telType(String telNum){

        if(11!=telNum.length()){
            return GdsPubData.contactNone;
        }
        //移动：2G号段（GSM）：134、135、136、137、138、139、150、151、152、158、
        //159；3G号段（TD-SCDMA，G3)：157、187、188、147（上网本）.
        //联通：2G号段(GSM)：130、131、132、155、156；3G号段(WCDMA，沃-WO)：185、
        //186.
        //电信：2G号段(CDMA)：133、153；3G号段(CDMA2000，天翼)：180、189.
        if(telNum.matches("1((3[4-9])|47|(5[0-27-9])|(8[78]))\\d{8}")){//移动
            return GdsPubData.contactMobile;
        }else if(telNum.matches("1((3[0-2])|(5[56])|(8[56]))\\d{8}")){//联通
            return GdsPubData.contactUnicom;
        }else if(telNum.matches("1(([35]3)|(8[09]))\\d{8}")){//电信
            return GdsPubData.contactTianyi;
        }else{
            return GdsPubData.contactNone;
        }
    }
}
