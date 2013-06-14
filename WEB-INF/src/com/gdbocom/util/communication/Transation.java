package com.gdbocom.util.communication;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.net.UnknownHostException;
import java.util.Arrays;
import java.util.Map;
import java.util.HashMap;

/**
 * 实现通讯报文与表单项之间的互相转换
 * @author qm
 *
 */
public abstract class Transation {

    /**
     * 通讯报文适配器，将完成发送表单项与通讯报文间的转换、通讯功能。
     * @param server 指定通讯的IcsServer类
     * @param request 请求表单项
     * @param transationFactoryType TransationFactory类中登记的签约报文类型，
     * eg:TransationFactory.GDS469901
     * @return 返回表单项，通过判断MsgTyp决定报文是否成功，N为成功，E为不成功报
     * 文，其他为异常
     * @throws UnknownHostException
     * @throws IOException
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
        byte[] requestPacket = ts.buildRequestPacket(request);
        System.out.println("---------------------");
        System.out.println("发送报文：" + new String(requestPacket, "GBK"));
        //通讯
        byte[] responsePacket = server.send(requestPacket);
        System.out.println("接收报文：" + new String(responsePacket, "GBK"));
        System.out.println("---------------------");

        //通过通讯返回报文得到Map值
        Map<String, String> response
            = ts.parseResponseMap(responsePacket);
        System.out.println(response);
        return null;
    }

    /**
     * 生成通讯报文，通讯报文=报文头+报文体，报文头统一使用TIA头，报文体为自定义。
     * @param request 表单项
     * @return 通讯报文
     * @throws UnsupportedEncodingException
     */
    private byte[] buildRequestPacket(Map<String, String> request)
            throws UnsupportedEncodingException{

        byte[] requestHead = buildTiaHead(request);
        byte[] requestBody = buildRequestBody(request);

        return Transation.mergeByte(requestHead, requestBody);
    }

    /**
     * 生成TIA公共报文头
     * @param request 表单项
     * @return TIA公共报文头
     * @throws UnsupportedEncodingException
     */
    private byte[] buildTiaHead(Map<String, String> request)
            throws UnsupportedEncodingException{

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
        return Transation.packetSequence(request, format);

    }

    /**
     * 生成自定义请求报文体
     * @param request 表单项
     * @return 报文体
     */
    protected abstract byte[] buildRequestBody(
            Map<String, String> request)
                    throws UnsupportedEncodingException;

    /**
     * 获取返回报文字段，
     * 返回报文有正常报文与错误报文两种，他们具有同样的TOA报文头，通过判断返回字段
     * MsgTyp是否为N可知。
     * @param 返回报文
     * @return 返回Map值，MsgTyp不为N，即为错误报文
     * @throws UnsupportedEncodingException
     */
    private Map<String, String> parseResponseMap(byte[] response)
            throws UnsupportedEncodingException{

        Map<String, String> responseData = new HashMap<String, String>();

        //处理报文头
        Map<String, String> toaData = parseToaHead(response);
        responseData.putAll(toaData);

        //截取报文体
        int toaLength = 114;
        byte[] responseBody = new byte[response.length - toaLength];
        System.arraycopy(
                response, toaLength, responseBody, 0, responseBody.length);

        //根据MsgTyp值对不同类型报文进行处理
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

    /**
     * 解析TOA公共报文头
     * @param response 返回报文
     * @return 报文头字段
     * @throws UnsupportedEncodingException
     */
    private Map<String, String> parseToaHead(byte[] response)
            throws UnsupportedEncodingException {

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
     * 解析自定义返回报文体
     * @return 报文体
     * @throws UnsupportedEncodingException
     */
    protected abstract Map<String, String> parseNormalResponseBody(
            byte[] response) throws UnsupportedEncodingException;

    /**
     * 解析错误返回报文体
     * @param response 返回报文
     * @return 报文体字段
     * @throws UnsupportedEncodingException
     */
    private Map<String, String> parseErrorResponseBody(byte[] response)
            throws UnsupportedEncodingException{

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
     * 定长报文生成通用方法，同时将编码转换成ICS的GBK编码
     * @param request 表单项
     * @param format 表单格式<br/>
     * 各字段意思：<br/>
     *  key:关键字,
     *  String.format{String} eg:%6c ：输出格式,
     *  [FieldSource|value]：来源或值,
     *
     * @throws UnsupportedEncodingException
     */
    protected static byte[] packetSequence(
            Map<String, String> request, Object[][] format)
                    throws UnsupportedEncodingException{

        StringBuffer buffer = new StringBuffer();
        String value = "";

        int fieldLength = 0;
        for(int i=0; i<format.length; i++){

            fieldLength = Integer.valueOf(
                    ((String)format[i][1]).replaceAll("[^\\d]+", ""));

            if(String.class==format[i][2].getClass()){//固定值
                value = (String)format[i][2];

            }else if(FieldSource.VAR==format[i][2]){//变量，从表单中获取
                value = request.get((String)format[i][0]);

            }else if(FieldSource.PROPS==format[i][2]){//变量，从配置文件获取
                value = ConfigProps.getInstance()
                        .getProperty((String)format[i][0]);

            }else{//未定义类型扔出运行时错误
                throw new IllegalArgumentException();
            }
            value = (null==value?
                    String.format((String)format[i][1], ""):
                    String.format((String)format[i][1], value));

            buffer.append(new String(
                    Arrays.copyOf(value.getBytes("GBK"), fieldLength),
                    "GBK"));

        }
        return buffer.toString().getBytes("GBK");

    }

   /**
     * 定长报文解析通用方法，同时将编码由ICS的GBK编码转换成Unicode编码
     * @param response 需解析报文
     * @param format 解析格式
     * 
     *  key:关键字,
     *  字段长度,
     *  [FieldTypes]：字段类型,
     * 
     * @return 报文项
     * @throws UnsupportedEncodingException
     */
    protected static Map<String, String> unpacketsSequence(
            byte[] response,
            Object[][] format) throws UnsupportedEncodingException {
        Map<String, String> responseData = new HashMap<String, String>();

        int offset = 0;
        byte[] field = new byte[0];
        for(int i=0; i<format.length; i++){
            if(FieldTypes.STATIC==format[i][2]){
                int len = Integer.valueOf((String)format[i][1]);
                field = new byte[len];
                System.arraycopy(response, offset, field, 0, len);
                responseData.put((String)format[i][0],
                        new String(field, "GBK"));
                offset += len;

            }else{//未定义类型扔出运行时错误
                throw new IllegalArgumentException();
            }

        }
        return responseData;
    }

    /**
     * 合并两个字节数组
     * @param byteFront 第一个数组
     * @param byteBehind 第二个数组
     * @return 合并后的新数组，长度为byteFront.length + byteBehind.length
     */
    protected static byte[] mergeByte(byte[] byteFront, byte[] byteBehind){
        byte[] byteMerged = new byte[byteFront.length + byteBehind.length];
        System.arraycopy(byteFront, 0, byteMerged, 0, byteFront.length);
        System.arraycopy(
                byteBehind, 0,
                byteMerged, byteFront.length,
                byteBehind.length);
        return byteMerged;

    }

    /**
     * 更新MsgTyp项的值
     * @param map 表单项
     * @param value 更新后的值
     */
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

}
