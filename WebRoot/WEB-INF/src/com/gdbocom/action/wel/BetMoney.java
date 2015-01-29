/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.gdbocom.action.wel;

import com.gdbocom.Transactions.WelLot;

/**
 * 计算投注金额
 * 
 * @author cry
 */
public class BetMoney {

    public static final int betMode_Single = 1;  //单式
    public static final int betMode_Multiple = 12; //复式
    public static final int betMode_Bravery = 13; //胆拖
    public static final int playID_N2_LinkLine = 4; //选二连直
    public static final int playID_N3_BeforLine = 7; //选三前直
    
    /**
     * 计算单式金额 如果返回金额值为0表示异常
     *
     * @param betMode:投注方式
     * @param stakes:单式注数
     * @param multiple:投注倍数
     * @param stakesPrice:单注金额
     * @return 投注金额:double类型值
     */
    public double createSingleMoney(int betMode, int stakes, int multiple, double stakesPrice) {
        double money = 0;

        if (betMode != betMode_Single) {
            return money;
        }

        money = stakes * multiple * stakesPrice;
        return money;
    }

    /**
     * 计算KENO类游戏的复式和胆拖金额 如果返回金额值为0表示异常
     *
     * @param playID:玩法编号
     * @param betMode:投注模式
     * @param baseNum:胆个数
     * @param tailNum:拖个数(复式个数)
     * @param betNum:应投注号码个数
     * @param multiple:投注倍数
     * @param stakesPrice:单注金额
     * @return 投注金额:double类型值
     *
     */
    public double createNDoubleMoney(int playID, int betMode, int baseNum, int tailNum, int betNum, int multiple, double stakesPrice) {
        int stakes = 0;
        
        if (betMode == betMode_Multiple) {
            if ((playID == playID_N2_LinkLine) || (playID == playID_N3_BeforLine)) {
                stakes = PCFormula.getStakesNum(tailNum, betNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(betNum, betNum, PCFormula.PERMUT_FLAG);
            } else {
                stakes = PCFormula.getStakesNum(tailNum, betNum, PCFormula.COMBINATE_FLAG);
            }
        } else if (betMode == betMode_Bravery) {
            if ((playID == playID_N2_LinkLine) || (playID == playID_N3_BeforLine)) {
                stakes = PCFormula.getStakesNum(tailNum, betNum - baseNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(betNum, betNum, PCFormula.PERMUT_FLAG);
            } else {
                stakes = PCFormula.getStakesNum(tailNum, betNum - baseNum, PCFormula.COMBINATE_FLAG);
            }
        }
        
        double money = stakes * multiple * stakesPrice;
        return money;
    }
    
    /**
     * 计算双色球的投注金额 如果返回金额值为0表示异常
     *
     * @param betMode 投注模式
     * @param multiple 投注倍数
     * @param price 单注投注金额
     * @param section 单式投注注数
     * @param betRedNum 应投注红球号码个数
     * @param betBlueNum 应投注蓝球号码个数
     * @param redBaseNum 实际投注红球胆号码个数
     * @param redTailNum 实际投注红球托号码个数(复式实际投注号码个数)
     * @param blueNum 实际投注蓝球号码个数
     * @return 投注金额:double类型值
     */
    public double CalculateBMoney(int betMode, int multiple,
    		double price, int section, int betRedNum,
    		int betBlueNum, int redBaseNum, int redTailNum, int blueNum) {
        double money = 0;
        int stakes = 0;
        switch (betMode) {
            case betMode_Single:
                stakes = section;
                break;
            case betMode_Multiple:
                stakes = PCFormula.getStakesNum(redTailNum, betRedNum, PCFormula.COMBINATE_FLAG)
                	* PCFormula.getStakesNum(blueNum, betBlueNum, PCFormula.COMBINATE_FLAG);
                break;
            case betMode_Bravery:
                stakes = PCFormula.getStakesNum(redTailNum, betRedNum - redBaseNum, PCFormula.COMBINATE_FLAG) * PCFormula.getStakesNum(blueNum, betBlueNum, PCFormula.COMBINATE_FLAG);
                break;
            default:
        }
        
        money = stakes * multiple * price;
        return money;
    }

    /**
     * 计算KENO的投注金额 如果返回金额值为0表示异常
     *
     * @param playID:玩法编号
     * @param betMode:投注模式
     * @param multiple:投注倍数
     * @param price 单注投注金额
     * @param section 单式投注注数
     * @param betNum 应投注号码个数
     * @param baseNum 实际投注胆号码个数
     * @param tailNum 实际投注托号码个数(复式实际投注号码个数)
     * @return 投注金额:double类型值
     */
    public double CalculateNMoney(int playID, int betMode, int multiple, double price, int section, int betNum, int baseNum, int tailNum) {
        double money = 0;

        switch (betMode) {
            case 1:
                money = createSingleMoney(betMode, section, multiple, price);
                break;
            case 12:
                money = createNDoubleMoney(playID, betMode, 0, tailNum, betNum, multiple, price);
                break;
            case 13:
                money = createNDoubleMoney(playID, betMode, baseNum, tailNum, betNum, multiple, price);
                break;
            default:

        }
        
        return money;
    }
    
    public static void main(String[] args){
//    	//单式
//    	int betMode = BetMoney.betMode_Single;//单复式
//    	int multiple = 1;//投注倍数
//    	double price = 2;//单注投注金额
//    	int section = 1;//单式投注注数
//    	int betRedNum = 0;//选择红球号码个数,单式无意义
//		int redTailNum = 0;//投注号码红球总个数,单式无意义
//		int betBlueNum = 0;//应投注蓝球号码个数,单式无意义
//		int redBaseNum = 0;//实际投注红球胆号码个数,单式无意义
//		int blueNum = 0;//实际投注蓝球号码个数,单式无意义
//    	System.out.println(new BetMoney().CalculateBMoney(betMode, multiple,
//        		price, section, betRedNum,
//        		betBlueNum, redBaseNum, redTailNum, blueNum));
//    	
//    	//复式
//    	betMode = BetMoney.betMode_Multiple;//单复式
//    	multiple = 1;//投注倍数
//    	price = 2;//单注投注金额
//    	section = 0;//单式投注注数,复式无意义
//    	betRedNum = 6;//单注红球号码个数
//		redTailNum = 7;//选择红球号码个数
//		betBlueNum = 1;//单注蓝球号码个数
//		blueNum = 1;//选择蓝球号码个数
//		redBaseNum = 0;//实际投注红球胆号码个数，复式无意义
//    	System.out.println(new BetMoney().CalculateBMoney(betMode, multiple,
//        		price, section, betRedNum,
//        		betBlueNum, redBaseNum, redTailNum, blueNum));
    	
    	
        int playID=WelLot.HpTenBuy.THREE_GROUP;//玩法编号
        int betMode=BetMoney.betMode_Single;//投注模式
        int multiple=1;//投注倍数
        double price=2;//单注投注金额
        int section=1; //单式投注注数
        int betNum=3; //应投注号码个数
        int baseNum=0;//实际投注胆号码个数
        int tailNum=1;//实际投注托号码个数(复式实际投注号码个数)
        double rs=new BetMoney().CalculateNMoney(playID, betMode, multiple, price, section, betNum, baseNum, tailNum);
        System.out.println(rs);
        
        playID=WelLot.HpTenBuy.THREE_GROUP;//玩法编号
        betMode=BetMoney.betMode_Multiple;//投注模式
        multiple=1;//投注倍数
        price=2;//单注投注金额
        section=1; //单式投注注数
        betNum=3; //应投注号码个数
        baseNum=0;//实际投注胆号码个数
        tailNum=20;//实际投注托号码个数(复式实际投注号码个数)
        rs=new BetMoney().CalculateNMoney(playID, betMode, multiple, price, section, betNum, baseNum, tailNum);
        System.out.println(rs);
    }

}
