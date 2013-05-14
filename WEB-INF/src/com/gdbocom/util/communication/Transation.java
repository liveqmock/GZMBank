package com.gdbocom.util.communication;

import java.io.IOException;
import java.net.UnknownHostException;
import java.util.Map;
import java.util.HashMap;

/**
 * 
 * @author qm
 *
 */
public abstract class Transation {
//TODO 由于IcsServer方法使用byte【】进行返回，需要将相关报文拼拆包文件进行相应处理，
//使用字节数组是报文拼拆包按字节的方式更加简单。
    /**
     * Ics通讯接口适配器，通过接收表单项后按照具体的实现类
     * @param server IcsServer类
     * @param request 请求项
     * @param transationFactoryType TransationFactory类中登记的签约报文类型，
     * eg:TransationFactory.GDS469901
     * @return ICS返回项
     * @throws UnknownHostException
     * @throws IOException
     */
    /* 
     * 由于java的encoding默认使用unicode编码，而ICS默认使用的是GBK编码，
     * 因此在使用OutputStream之前与InputStream之后先进行编码转换，避免
     * 乱码的出现。
     */

    public static Map<String, String> exchangeData(
            IcsServer server,
            Map<String, String> request,
            int transationFactoryType
            )throws UnknownHostException, IOException{

        //实例化具体报文实现类
        Transation ts = TransationFactory
                .createTransation(transationFactoryType);
        //通过表单项获取通讯报文
        byte[] requestPacket = ts.getRequestPacket(request);
        System.out.println(new String(requestPacket, "GBK"));

        System.out.println("---------------------");
        //通讯
        byte[] responsePacket = server.send(requestPacket);
        System.out.println(new String(responsePacket, "GBK"));

        //通过通讯返回报文得到Map值
        Map<String, String> response = ts.getResponseMap(responsePacket);
        System.out.println(response);
        return null;
    }

    /**
     * 获取通讯报文，通讯报文=报文头+报文体，报文头统一使用TIA头，报文体为特色。
     * @param request 表单项
     * @return 通讯报文
     */
    private byte[] getRequestPacket(Map<String, String> request){
        byte[] requestPacket;
        buildTiaHead(request, requestPacket);
        buildRequestBody(request, requestPacket);
        return requestPacket;
    }

    /**
     * 获取返回报文字段，
     * 返回报文有正常报文与错误报文两种，他们具有同样的TOA报文头，通过判断返回字段
     * MsgTyp是否为N。
     * @param 返回报文
     * @return 返回Map值，MsgTyp不为N，即为错误报文
     */
    private Map<String, String> getResponseMap(String response){
        Map<String, String> responseData = new HashMap<String, String>();

        //处理报文头
        Map<String, String> toaData = parseToaHead(response);
        responseData.putAll(toaData);
        String responseBody = response.substring(114);//除去TOA头114字节

        System.out.println(responseBody);
        if(responseData.containsKey("MsgTyp")){
            if( "N".equals(responseData.get("MsgTyp")) ){//ICS返回Normal
                Map<String, String> bodyData =
                        parseNormalResponseBody(responseBody);

                responseData.putAll(bodyData);
                return responseData;
                
            }else if( "E".equals(responseData.get("MsgTyp")) ){//ICS返回Error
                Map<String, String> bodyData =
                        parseErrorResponseBody(responseBody);

                responseData.putAll(bodyData);
                return responseData;
                
            }
        }
        //ICS异常返回
        updateMsgTyp(responseData, "E");

        return responseData;

    }

    private void updateMsgTyp(Map<String, String> map, String value){
        if(!map.containsKey("MsgTyp")){//不存在，直接赋值
            map.put("MsgTyp", value);
            return;
        }
        if(!value.equals(map.get("MsgTyp"))){//存在，不同，删除后赋值
            map.remove("MsgTyp");
            map.put("MsgTyp", value);
        }
    } 

    /**
     * 添加TIA公共报文头
     * @param request 表单项
     * @return 报文头
     */
    private void buildTiaHead(Map<String, String> request, byte[] dist) {
        /*
         *  key:关键字, 
         *  String.format{String} eg:%6c ：输出格式, 
         *  [FieldSource|value]：来源或值, 
         */
        Object[][] format = {
                {"CCSCod", "%-4s","TLU6"},
                {"TTxnCd", "%-6s",FieldSource.VAR},
                {"FeCod", "%-6s",FieldSource.VAR},
                {"TrmNo", "%-7s",FieldSource.PROPS},
                {"TxnSrc", "%-5s",FieldSource.VAR},
                {"NodTrc", "%-15s","0"},
                {"TlrId", "%-7s",FieldSource.PROPS},
                {"TIATyp", "%-1s","T"},
                {"AthLvl", "%-2s","00"},
                {"Sup1Id", "%-7s",""},
                {"Sup2Id", "%-7s",""},
                {"Sup1Pw", "%-6s",""},
                {"Sup2Pw", "%-6s",""},
                {"Sup1Dv", "%-1s",""},
                {"Sup2Dv", "%-1s",""},
                {"AthTbl", "%-60s",""},
                {"AthLog", "%-1s",""},
                {"HLogNo", "%-9s",""},
                {"CprInd", "%-1s","0"},
                {"EnpInd", "%-1s","0"},
                {"NodNo", "%-6s",FieldSource.PROPS},
                {"OprLvl", "%-1s",""},
                {"TrmVer", "%-8s","v0000001"},
                {"OutSys", "%-1s",""},
                {"Fil", "%-2s",""}
        };
        Transation.packetSequence(request, format, dist));

    }

    /**
     * 添加TOA公共报文头
     * @param response 返回报文
     * @return 报文头字段
     */
    private Map<String, String> parseToaHead(String response) {
        /*
         *  key:关键字, 
         *  字段长度, 
         *  [FieldTypes]：字段类型, 
         */
        Object[][] format = {
                {"Fil1","3",FieldTypes.STATIC},
                {"MsgTyp","1",FieldTypes.STATIC},
                {"RspCod","6",FieldTypes.STATIC},
                {"ErrFld","4",FieldTypes.STATIC},
                {"TrmNo","7",FieldTypes.STATIC},
                {"TrmSqn","6",FieldTypes.STATIC},
                {"STxnCd","4",FieldTypes.STATIC},
                {"SAplCd","2",FieldTypes.STATIC},
                {"TxnSym","3",FieldTypes.STATIC},
                {"TxnDat","8",FieldTypes.STATIC},
                {"TxnTm","6",FieldTypes.STATIC},
                {"ActDat","8",FieldTypes.STATIC},
                {"HLogNo","9",FieldTypes.STATIC},
                {"TckNo","11",FieldTypes.STATIC},
                {"PagId","1",FieldTypes.STATIC},
                {"CprInd","1",FieldTypes.STATIC},
                {"EnpInd","1",FieldTypes.STATIC},
                {"NodNo","6",FieldTypes.STATIC},
                {"AthLog","1",FieldTypes.STATIC},
                {"FinFlg","1",FieldTypes.STATIC},
                {"AthLvl","2",FieldTypes.STATIC},
                {"Sup1Id","7",FieldTypes.STATIC},
                {"Sup2Id","7",FieldTypes.STATIC},
                {"Fil2","5",FieldTypes.STATIC},
                {"DatLen","4",FieldTypes.STATIC}
        };
        return Transation.unpacketsSequence(response, format);
    }

    /**
     * 添加请求报文体
     * @return 报文体
     */
    protected abstract String buildRequestBody(Map<String, String> request);

    /**
     * 添加返回报文体
     * @return 报文体
     */
    protected abstract Map<String, String> parseNormalResponseBody(String response);

    private Map<String, String> parseErrorResponseBody(String response){
        /*
         *  key:关键字, 
         *  字段长度, 
         *  [FieldTypes]：字段类型, 
         */
        Object[][] format = {
                {"TmpDat","4",FieldTypes.STATIC},
                {"ApCode","2",FieldTypes.STATIC},
                {"OFmtCd","3",FieldTypes.STATIC},
                {"RspCod","6",FieldTypes.STATIC},
                {"InPos","4",FieldTypes.STATIC},
                {"RspMsg","56",FieldTypes.STATIC}
        };
        return Transation.unpacketsSequence(response, format);
    }
    /**
     * 定长报文拼包通用方法
     * @param request 表单项
     * @param format 表单格式
     * @return 报文
     */
    protected static String packetSequence(
            Map<String, String> request, Object[][] format){

        StringBuffer head = new StringBuffer();
        String value = "";

        for(int i=0; i<format.length; i++){
            if(String.class==format[i][2].getClass()){//固定值
                value = (String)format[i][2];

            }else if(FieldSource.VAR==format[i][2]){//变量，从表单中获取
                value = request.get((String)format[i][0]);

            }else if(FieldSource.PROPS==format[i][2]){//变量，从配置文件获取
                value = ConfigProps.getInstance().getProperty((String)format[i][0]);

            }else{//未定义类型扔出运行时错误
                throw new IllegalArgumentException();
            }
            value = (null==value?
                    "":
                    String.format((String)format[i][1], value));
            head.append(value);

        }
        return head.toString();
        
    }

    /**
     * 定长报文解包通用方法，由于有可能返回包包括中文，因此需要先转码成GBK然后按照
     * 字节进行拆包
     * @param response
     * @param format
     * @return
     */
    protected static Map<String, String> unpacketsSequence(String response,
            Object[][] format) {
        Map<String, String> responseData = new HashMap<String, String>();

        int offset = 0;
        for(int i=0; i<format.length; i++){
            if(FieldTypes.STATIC==format[i][2]){
                int len = Integer.valueOf((String)format[i][1]);
                responseData.put((String)format[i][0],
                        response.substring(offset, offset+len));
                offset += len;

            }else{//未定义类型扔出运行时错误
                throw new IllegalArgumentException();
            }

        }
        return responseData;
    }


}
