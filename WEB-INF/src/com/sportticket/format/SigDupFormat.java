package com.sportticket.format;

public class SigDupFormat implements FieldFormat {
	public String CtoN(String SigDup){
		String SigDup_num="0";
		if("��ʽ".equals(SigDup)){
			SigDup_num="1";
		}else if("��ʽ".equals(SigDup)){
			SigDup_num="2";
		}else if("����".equals(SigDup)){
			SigDup_num="3";
		}else if("��λ".equals(SigDup)){
			SigDup_num="5";
		}else if("����".equals(SigDup)){
			SigDup_num="6";
		}else if("��ֵ".equals(SigDup)){
			SigDup_num="7";
		}else if("����".equals(SigDup)){
			SigDup_num="8";
		}else if("����".equals(SigDup)){
			SigDup_num="9";
		}else if("����ż".equals(SigDup)){
			SigDup_num="10";
		}else if("����".equals(SigDup)){
			SigDup_num="11";
		}else{
			SigDup_num="0";
		}
		return SigDup_num;
	}
	public String NtoC(String SigDup_num){
		String SigDup="������";
		if("1".equals(SigDup_num)){
			SigDup="��ʽ";
		}else if("2".equals(SigDup_num)){
			SigDup="��ʽ";
		}else if("3".equals(SigDup_num)){
			SigDup="����";
		}else if("5".equals(SigDup_num)){
			SigDup="��λ";
		}else if("6".equals(SigDup_num)){
			SigDup="����";
		}else if("7".equals(SigDup_num)){
			SigDup="��ֵ";
		}else if("8".equals(SigDup_num)){
			SigDup="����";
		}else if("9".equals(SigDup_num)){
			SigDup="����";
		}else if("10".equals(SigDup_num)){
			SigDup="����ż";
		}else if("11".equals(SigDup_num)){
			SigDup="����";
		}else{
			SigDup="������";
		}
		return SigDup;
	}
}
