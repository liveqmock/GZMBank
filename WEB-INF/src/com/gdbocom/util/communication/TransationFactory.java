package com.gdbocom.util.communication;

import com.gdbocom.util.communication.custom.*;

/**
 * Transation的工厂类，创建不同交易和交易码的拼包与解包Transation类，不同的
 * Transation类有自己的登记值。
 * @author qm
 *
 */
public class TransationFactory {
    /**
     * LSHA应用的482150交易的代号。
     */
    public static final int LSHA482150 = 1;

    /**
     * 根据不同的交易代号，返回不同的拼解包类。
     * @param transationCode 代号
     * @return 拼解包类，如不存在返回null
     */
    public static Transation createTransation(int transationCode){
        switch(transationCode){
            case TransationFactory.LSHA482150: return new Lsha482150();
            default: return null;
        }
    }
}
