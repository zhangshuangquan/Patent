package com.codyy.patentmanagement.front.web.entity;

public class JsonResult {
	
	private boolean result;
	private String message;
	
	public JsonResult(boolean result) {
		super();
		this.result = result;
	}
	
	public JsonResult(boolean result, String message) {
		super();
		this.result = result;
		this.message = message;
	}
	public boolean isResult() {
		return result;
	}
	public void setResult(boolean result) {
		this.result = result;
	}
	public String getMessage() {
		return message;
	}
	public void setMessage(String message) {
		this.message = message;
	}
	
	
}
