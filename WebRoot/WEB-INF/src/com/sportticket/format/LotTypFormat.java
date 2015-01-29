package com.sportticket.format;

public class LotTypFormat implements FieldFormat {
	public String CtoN(String LotTyp){
		String LotTyp_num="00";
		if("七星彩".equals(LotTyp)){
			LotTyp_num="05";
		}else if("排列3直选".equals(LotTyp)){
			LotTyp_num="11";
		}else if("排列3组选3".equals(LotTyp)){
			LotTyp_num="12";
		}else if("排列3组选6".equals(LotTyp)){
			LotTyp_num="13";
		}else if("排列5".equals(LotTyp)){
			LotTyp_num="14";
		}else if("排列3直选和值".equals(LotTyp)){
			LotTyp_num="15";
		}else if("排列3组选和值".equals(LotTyp)){
			LotTyp_num="16";
		}else if("排列3直选组合复式".equals(LotTyp)){
			LotTyp_num="17";
		}else if("排列3直选组合胆拖".equals(LotTyp)){
			LotTyp_num="18";
		}else if("体彩大乐透".equals(LotTyp)){
			LotTyp_num="26";
		}else if("体彩大乐透追加投注".equals(LotTyp)){
			LotTyp_num="27";
		}else if("体彩大乐透12选2".equals(LotTyp)){
			LotTyp_num="28";
		}else{
			LotTyp_num="00";
		}
		return LotTyp_num;
	}
	public String NtoC(String LotTyp_num){
		String LotTyp="无意义";
		if("05".equals(LotTyp_num)){
			LotTyp="七星彩";
		}else if("11".equals(LotTyp_num)){
			LotTyp="排列3直选";
		}else if("12".equals(LotTyp_num)){
			LotTyp="排列3组选3";
		}else if("13".equals(LotTyp_num)){
			LotTyp="排列3组选6";
		}else if("14".equals(LotTyp_num)){
			LotTyp="排列5";
		}else if("15".equals(LotTyp_num)){
			LotTyp="排列3直选和值";
		}else if("16".equals(LotTyp_num)){
			LotTyp="排列3组选和值";
		}else if("17".equals(LotTyp_num)){
			LotTyp="排列3直选组合复式";
		}else if("18".equals(LotTyp_num)){
			LotTyp="排列3直选组合胆拖";
		}else if("26".equals(LotTyp_num)){
			LotTyp="体彩大乐透";
		}else if("27".equals(LotTyp_num)){
			LotTyp="体彩大乐透追加投注";
		}else if("28".equals(LotTyp_num)){
			LotTyp="体彩大乐透12选2";
		}else{
			LotTyp="无意义";
		}
		return LotTyp;
	}
}
