/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package com.gdbocom.action.wel;

import java.math.BigInteger;

/**
 * 从n个不同元素中，任取m(m≤n)个元素并成一组，叫做从n个不同元素中取出m个元素的一个组合；
 * 从n个不同元素中取出m(m≤n)个元素的所有组合的个数，叫做从n个不同元素中取出m个元素的组合数.用符号c(n,m) 表示. c(n,m)=p(n,m)/m!=n!/((n-m)!*m!)
 * 从n个不同元素中，任取m(m≤n)个元素按照一定的顺序排成一列，叫做从n个不同元素中取出m个元素的一个排列；
 * 从n个不同元素中取出m(m≤n)个元素的所有排列的个数，叫做从n个不同元素中取出m个元素的排列数，用符号 p(n,m)表示. p(n,m)=n(n-1)(n-2)……(n-m+1)= n!/(n-m)!(规定0!=1). 
 * 
 * @author cry
 */
public class PCFormula {

	/** 组合数标识 */
    public static final int COMBINATE_FLAG = 1;
	/** 排列数标识 */
    public static final int PERMUT_FLAG = 2;

    /**
     * 计算阶乘
     * @param num
     * @return
     */
    public static BigInteger Factorial(int num) {
        if (num == 0) {
            return BigInteger.valueOf(1);
        } else {
        	BigInteger result = BigInteger.valueOf(1);
        	for(int ele=num;ele>1;ele--){
        		result = BigInteger.valueOf(ele).multiply(result);
        	}
            return result;
        }
    }

    /**
     * 计算从n中取m个数的组合的总数值
     * combin(n,m)=n(n-1)…(n-m+1)/1*2…m=n!/m!(n-m)!
     * 
     * @param n 集合数组的总长度
     * @param m 挑选的个数
     * @return 
     */
    private static BigInteger Combination_num(int n, int m) {
        return Factorial(n).divide(Factorial(m).multiply(Factorial(n - m)));
    }

    /**
     * 计算从n中取m个数的排列的总数值
     * p(n,m)=n(n-1)(n-2)……(n-m+1)= n!/(n-m)!(规定0!=1)
     * 
     * @param n 集合数组的总长度
     * @param m 挑选的个数
     * @return 
     */
    private static BigInteger permutation_num(int n, int m) {
        return Factorial(n).divide(Factorial(n - m));
    }

    /**
     * 计算投注的注数
     *
     * @param number 总号码个数
     * @param betnonum 选择投注号码个数
     * @param flag 是组合还是排列
     *  PCFormula.COMBINATE_FLAG组合
     *  PCFormula.PERMUT_FLAG排列
     * @return 计算结果
     */
    public static int getStakesNum(int number, int betnonum, int flag) {
        BigInteger stake_num = new BigInteger("0");
        
        if (flag == COMBINATE_FLAG) {
            stake_num = Combination_num(number, betnonum);
        } else if (flag == PERMUT_FLAG) {
            stake_num = permutation_num(number, betnonum);
        }        
        return stake_num.intValue();
    }

}
