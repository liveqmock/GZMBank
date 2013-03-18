package com.sportticket.format;

public class SigDupFormat implements FieldFormat {
	public String CtoN(String SigDup){
		String SigDup_num="0";
		if("单式".equals(SigDup)){
			SigDup_num="1";
		}else if("复式".equals(SigDup)){
			SigDup_num="2";
		}else if("胆拖".equals(SigDup)){
			SigDup_num="3";
		}else if("包位".equals(SigDup)){
			SigDup_num="5";
		}else if("包段".equals(SigDup)){
			SigDup_num="6";
		}else if("和值".equals(SigDup)){
			SigDup_num="7";
		}else if("包胆".equals(SigDup)){
			SigDup_num="8";
		}else if("包串".equals(SigDup)){
			SigDup_num="9";
		}else if("包奇偶".equals(SigDup)){
			SigDup_num="10";
		}else if("包对".equals(SigDup)){
			SigDup_num="11";
		}else{
			SigDup_num="0";
		}
		return SigDup_num;
	}
	public String NtoC(String SigDup_num){
		String SigDup="无意义";
		if("1".equals(SigDup_num)){
			SigDup="单式";
		}else if("2".equals(SigDup_num)){
			SigDup="复式";
		}else if("3".equals(SigDup_num)){
			SigDup="胆拖";
		}else if("5".equals(SigDup_num)){
			SigDup="包位";
		}else if("6".equals(SigDup_num)){
			SigDup="包段";
		}else if("7".equals(SigDup_num)){
			SigDup="和值";
		}else if("8".equals(SigDup_num)){
			SigDup="包胆";
		}else if("9".equals(SigDup_num)){
			SigDup="包串";
		}else if("10".equals(SigDup_num)){
			SigDup="包奇偶";
		}else if("11".equals(SigDup_num)){
			SigDup="包对";
		}else{
			SigDup="无意义";
		}
		return SigDup;
	}
}
