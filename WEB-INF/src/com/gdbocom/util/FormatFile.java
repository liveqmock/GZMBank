package com.gdbocom.util;

import com.gdbocom.util.communication.FieldSource;

public abstract class FormatFile {

    //* file format: key, length, source, value
    private String keySet = "CCSCOD,TTXNCD,FECOD,TRMNO,TXNSRC,NODTRC," +
            "TLRID,TIATYP,ATHLVL,SUP1ID,SUP2ID,SUP1PW," +
            "SUP2PW,SUP1DV,SUP2DV,ATHTBL,ATHLOG,HLOGNO," +
            "CPRIND,ENPIND12qwaszx" +
            ",NODNO,OPRLVL,TRMVER,OUTSYS,FIL";
    private String[] keys = keySet.split(",");

    private int[] keyLength;
    
    private FieldSource[] fieldType = {};

    private String[] fieldValue = {};

    public String[] getKeys(){
        return this.keys;
    }
    public int length(){
        return keys.length;
    }
}
