package com.sportticket.format;

public class LotTypFormat implements FieldFormat {
	public String CtoN(String LotTyp){
		String LotTyp_num="00";
		if("���ǲ�".equals(LotTyp)){
			LotTyp_num="05";
		}else if("����3ֱѡ".equals(LotTyp)){
			LotTyp_num="11";
		}else if("����3��ѡ3".equals(LotTyp)){
			LotTyp_num="12";
		}else if("����3��ѡ6".equals(LotTyp)){
			LotTyp_num="13";
		}else if("����5".equals(LotTyp)){
			LotTyp_num="14";
		}else if("����3ֱѡ��ֵ".equals(LotTyp)){
			LotTyp_num="15";
		}else if("����3��ѡ��ֵ".equals(LotTyp)){
			LotTyp_num="16";
		}else if("����3ֱѡ��ϸ�ʽ".equals(LotTyp)){
			LotTyp_num="17";
		}else if("����3ֱѡ��ϵ���".equals(LotTyp)){
			LotTyp_num="18";
		}else if("��ʴ���͸".equals(LotTyp)){
			LotTyp_num="26";
		}else if("��ʴ���͸׷��Ͷע".equals(LotTyp)){
			LotTyp_num="27";
		}else if("��ʴ���͸12ѡ2".equals(LotTyp)){
			LotTyp_num="28";
		}else{
			LotTyp_num="00";
		}
		return LotTyp_num;
	}
	public String NtoC(String LotTyp_num){
		String LotTyp="������";
		if("05".equals(LotTyp_num)){
			LotTyp="���ǲ�";
		}else if("11".equals(LotTyp_num)){
			LotTyp="����3ֱѡ";
		}else if("12".equals(LotTyp_num)){
			LotTyp="����3��ѡ3";
		}else if("13".equals(LotTyp_num)){
			LotTyp="����3��ѡ6";
		}else if("14".equals(LotTyp_num)){
			LotTyp="����5";
		}else if("15".equals(LotTyp_num)){
			LotTyp="����3ֱѡ��ֵ";
		}else if("16".equals(LotTyp_num)){
			LotTyp="����3��ѡ��ֵ";
		}else if("17".equals(LotTyp_num)){
			LotTyp="����3ֱѡ��ϸ�ʽ";
		}else if("18".equals(LotTyp_num)){
			LotTyp="����3ֱѡ��ϵ���";
		}else if("26".equals(LotTyp_num)){
			LotTyp="��ʴ���͸";
		}else if("27".equals(LotTyp_num)){
			LotTyp="��ʴ���͸׷��Ͷע";
		}else if("28".equals(LotTyp_num)){
			LotTyp="��ʴ���͸12ѡ2";
		}else{
			LotTyp="������";
		}
		return LotTyp;
	}
}
