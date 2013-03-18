package com.viatt.util;

public class BwResult {
	private String code = "000";
	private String context;

	public BwResult() {
	}

	public BwResult(String code,String context) {
		this.code = code;
		this.context=context;
	} 

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public String getContext() {
		return context;
	}

	public void setContext(String context) {
		this.context = context;
	}

}
