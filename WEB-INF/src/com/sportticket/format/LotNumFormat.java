package com.sportticket.format;

/**
 * ���ڸ�ʽ��Ͷע����
 * @author ������
 *
 */
public class LotNumFormat {
	
	/**
	 * �������ֶβ��Ϊ������¼
	 * @param LotNum Ͷע���뷵���ֶ�
	 * @return ����Ͷע��¼
	 */
	public static String[] ReturnManyRecords(String LotNum){
		return LotNum.split(",");
	}
	
	/**
	 * ��ʽ��һ����ʽ��Ͷע����
	 * @param OneSingleRecord ��ʽͶע����
	 * @param LotTyp ��Ʊ����
	 * @return ��ʽ����ĵ�ʽͶע����
	 */
	public static String OneSimplexRecordFormat(String OneSingleRecord, String LotTyp){

		if("26".equals(LotTyp)||"27".equals(LotTyp)){
			return "<label>"+OneSimplexRecordFormat_DALETOU(OneSingleRecord)+"</label>";
		}else if("28".equals(LotTyp)){
			return "<label>"+RecordFormat_12xuan2(OneSingleRecord)+"</label>";
		}else{
			return "";
		}
	}
	
	/**
	 * ��ʽ��һ����ʽ�Ĵ���͸Ͷע����
	 * @param OneSingleRecord ��ʽͶע����
	 * @return ��ʽ����ĵ�ʽͶע����
	 */
	public static String OneSimplexRecordFormat_DALETOU(String OneSingleRecord){
		String[] tmpstr=OneSingleRecord.split("\\*");
		String formatedstr;
		formatedstr=  tmpstr[0]+","
					+tmpstr[1]+","
					+tmpstr[2]+","
					+tmpstr[3]+","
					+tmpstr[4]+"|"
					+tmpstr[5]+","
					+tmpstr[6];
		return formatedstr;
	}
	
	/**
	 * ��ʽ��һ����ʽ��12ѡ2Ͷע����
	 * @param OneSingleRecord ��ʽͶע����
	 * @return ��ʽ����ĵ�ʽͶע����
	 */
	public static String RecordFormat_12xuan2(String OneSingleRecord){
		String[] tmpstr=OneSingleRecord.split("\\*");
		String formatedstr="";
		for(int i=0;i<tmpstr.length;i++){
			formatedstr += tmpstr[i];
			if(i+1<tmpstr.length){
				formatedstr += ",";
			}
		}
		return formatedstr;
	}

	/**
	 * ��ʽ��һ����ʽ��Ͷע����
	 * @param OneSingleRecord ��ʽͶע����
	 * @param LotTyp ��Ʊ����
	 * @return ��ʽ����ĵ�ʽͶע����
	 */
	public static String OneMultipleRecordFormat(String MultipleRecord, String LotTyp){
		if("26".equals(LotTyp)||"27".equals(LotTyp)){
			return "<label>"+OneMultipleRecordFormat_DALETOU(MultipleRecord)+"</label>";
		}else if("28".equals(LotTyp)){
			return "<label>"+RecordFormat_12xuan2(MultipleRecord)+"</label>";
		}else{
			return "";
		}
	}
	
	/**
	 * ��ʽ��һ����ʽ��Ͷע����
	 * @param OneSingleRecord ��ʽ��Ͷע����
	 * @return ��ʽ����ĸ�ʽ��Ͷע����
	 */
	public static String OneMultipleRecordFormat_DALETOU(String MultipleRecord){
		String[] tmpstr=MultipleRecord.split("\\*");
		String forepart = tmpstr[0];
		String rear = tmpstr[1];
		String formatedstr="";
		for(int i=0;i<forepart.length();i=i+2){
			formatedstr += forepart.substring(i, i+2);
			if(i+2<forepart.length()){
				formatedstr += ",";
			}
		}
		formatedstr += "|";
		for(int i=0;i<rear.length();i=i+2){
			formatedstr += rear.substring(i, i+2);
			if(i+2<rear.length()){
				formatedstr += ",";
			}
		}
		return formatedstr;
	}
	
	/**
	 * ��Ͷע���뷵���ֶβ��Ϊ������¼����ʽ�����
	 * @param LotNum Ͷע���뷵���ֶ�
	 * @return ��ʽ�����
	 */
	public static String ReturnManyFormatedRecords(String LotNum, String LotTyp){
		String formatedstr="";
		String[] ManyIndependentRecords = ReturnManyRecords(LotNum);
		for(int i=0;i<ManyIndependentRecords.length&&i<5;i++){
			if(!ManyIndependentRecords[i].trim().equals("")){
				formatedstr += OneSimplexRecordFormat(ManyIndependentRecords[i], LotTyp);
				formatedstr += "<br/>";
			}
		}
		if(ManyIndependentRecords.length>5&&(!ManyIndependentRecords[5].trim().equals(""))){
			formatedstr += OneMultipleRecordFormat(ManyIndependentRecords[5], LotTyp);
			formatedstr += "<br/>";
		}
		return formatedstr;
	}

	public static void main(String[] args){
		//��ʽ
		//����͸
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02*03*04*05*07*08", "26"));
		//12ѡ2
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02", "28"));
		//��ʽ
		//����͸
		System.out.println(LotNumFormat.OneMultipleRecordFormat("010203040506*070809", "27"));
		//12ѡ2
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02*03*04*05*07*08", "28"));
		//�ۺ�
		System.out.println(LotNumFormat.ReturnManyFormatedRecords("01*02*03*04*05*07*08,01*02*03*04*05*09*10,01*02*03*04*05*07*08,01*02*03*04*05*01*02, ,010203040506*070809", "26"));
		System.out.println(LotNumFormat.ReturnManyFormatedRecords("02*06*11*16*17*08*12, , , , ,                           ", "26"));
		System.out.println(LotNumFormat.ReturnManyFormatedRecords("01*02*03*04*05*07*08,01*02*03*04*05*09*10,01*02*03*04*05*07*08,,,", "26"));
		/*String[] Nrecord = LotNumFormat.ReturnManyRecords("01*02*03*04*05*07*08,01*02*03*04*05*09*10,01*02*03*04*05*07*08,01*02*03*04*05*01*02,,010203040506*070809");
		for(int i=0;i<Nrecord.length&&i<5;i++){
			if(!Nrecord[i].equals("")){
				System.out.println(LotNumFormat.OneSimplexRecordFormat(Nrecord[i], "26"));
			}
		}
		if(Nrecord.length>5){
			System.out.println(LotNumFormat.MultipleRecordFormat(Nrecord[5]));
		}*/
		
	}
	
	
}
