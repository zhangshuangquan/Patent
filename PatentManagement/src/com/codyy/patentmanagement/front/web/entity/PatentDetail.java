package com.codyy.patentmanagement.front.web.entity;

/**
 * 专利缴费明细
 * @author Administrator
 *
 */
public class PatentDetail {
	private int patentDetailId;
	private int patentId;
	private String payFlag;
	private double shouldPayMoney;
	private int yearNum;
	public int getPatentDetailId() {
		return patentDetailId;
	}
	public void setPatentDetailId(int patentDetailId) {
		this.patentDetailId = patentDetailId;
	}
	public int getPatentId() {
		return patentId;
	}
	public void setPatentId(int patentId) {
		this.patentId = patentId;
	}
	
	public String getPayFlag() {
		return payFlag;
	}
	public void setPayFlag(String payFlag) {
		this.payFlag = payFlag;
	}
	public double getShouldPayMoney() {
		return shouldPayMoney;
	}
	public void setShouldPayMoney(double shouldPayMoney) {
		this.shouldPayMoney = shouldPayMoney;
	}
	public int getYearNum() {
		return yearNum;
	}
	public void setYearNum(int yearNum) {
		this.yearNum = yearNum;
	}
	
	
}
