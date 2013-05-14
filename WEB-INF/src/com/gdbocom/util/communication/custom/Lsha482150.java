package com.gdbocom.util.communication.custom;

import java.util.HashMap;
import java.util.Map;

import com.gdbocom.util.communication.FieldSource;
import com.gdbocom.util.communication.IcsServer;
import com.gdbocom.util.communication.ConfigProps;
import com.gdbocom.util.communication.Transation;
import com.gdbocom.util.communication.TransationFactory;

public class Lsha482150 extends Transation {

    @Override
    protected String buildRequestBody(Map<String, String> request) {
        /*
         *  key:关键字, 
         *  String.format{String} eg:%6c ：输出格式, 
         *  [FieldSource|value]：来源或值, 
         */
        Object[][] format = {
                {"TxnDat", "%-8s", FieldSource.VAR},
                {"AppNm", "%-8s", FieldSource.VAR},
                {"PrtFlg", "%-1s", FieldSource.VAR}
        };
        return Transation.packetSequence(request, format);
    }

    public static void main(String[] args) throws Exception{
        Map<String, String> request = new HashMap<String, String>();
        request.put("TTxnCd", "482150");
        request.put("FeCod", "482150");
        request.put("TxnSrc", "MB441");
        request.put("TxnDat", "20140320");
        request.put("AppNm", "GZ_UNC中发动机看");
        request.put("PrtFlg", "1");
        
        Transation.exchangeData(IcsServer.getServer("@LSHA"),
                request,
                TransationFactory.LSHA482150);
    }

    @Override
    protected Map<String, String> parseNormalResponseBody(String response) {
        // TODO Auto-generated method stub
        return new HashMap<String, String>();
    }
}
