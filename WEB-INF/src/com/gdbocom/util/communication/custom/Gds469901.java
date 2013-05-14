package com.gdbocom.util.communication.custom;

import java.util.HashMap;

import com.gdbocom.util.communication.FieldSource;
import com.gdbocom.util.communication.ConfigProps;
import com.gdbocom.util.communication.Transation;

public class Gds469901 extends Transation {

    @Override
    protected String addBody() {
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
        return Transation.sequencePackets(request, format);
        //return "20140320GZ_UNC  1";
    }

}
