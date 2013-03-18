package com.sportticket.format;

/**
 * 用于格式化投注号码
 * @author 顾启明
 *
 */
public class LotNumFormat {
	
	/**
	 * 将返回字段拆分为多条记录
	 * @param LotNum 投注号码返回字段
	 * @return 多条投注记录
	 */
	public static String[] ReturnManyRecords(String LotNum){
		return LotNum.split(",");
	}
	
	/**
	 * 格式化一条单式的投注号码
	 * @param OneSingleRecord 单式投注号码
	 * @param LotTyp 彩票类型
	 * @return 格式化后的单式投注号码
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
	 * 格式化一条单式的大乐透投注号码
	 * @param OneSingleRecord 单式投注号码
	 * @return 格式化后的单式投注号码
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
	 * 格式化一条单式的12选2投注号码
	 * @param OneSingleRecord 单式投注号码
	 * @return 格式化后的单式投注号码
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
	 * 格式化一条复式的投注号码
	 * @param OneSingleRecord 复式投注号码
	 * @param LotTyp 彩票类型
	 * @return 格式化后的单式投注号码
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
	 * 格式化一条复式的投注号码
	 * @param OneSingleRecord 复式的投注号码
	 * @return 格式化后的复式的投注号码
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
	 * 将投注号码返回字段拆分为多条记录并格式化输出
	 * @param LotNum 投注号码返回字段
	 * @return 格式化输出
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
		//单式
		//大乐透
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02*03*04*05*07*08", "26"));
		//12选2
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02", "28"));
		//复式
		//大乐透
		System.out.println(LotNumFormat.OneMultipleRecordFormat("010203040506*070809", "27"));
		//12选2
		System.out.println(LotNumFormat.OneSimplexRecordFormat("01*02*03*04*05*07*08", "28"));
		//综合
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
