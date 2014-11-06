package com.gdbocom.util.format;

public class FormatterFactory {

	public static String getFormattedValue(FormatterInterface formaterName,
			String value,
			int FormaterType){
		return formaterName.getFormattedValue(value, FormaterType);

	}

}
