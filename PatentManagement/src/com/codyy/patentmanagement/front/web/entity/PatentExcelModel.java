package com.codyy.patentmanagement.front.web.entity;

import com.codyy.commons.utils.ExcelDataMapper;

public class PatentExcelModel {
	@ExcelDataMapper(column="申请号")
	private String applyNum;
	
	@ExcelDataMapper(column="发明名称")
	private String name;
	
	@ExcelDataMapper(column="申请日")
	private String applyDate;
	
	@ExcelDataMapper(column="优先权日")
	private String priorityDate;// 优先权日
	
	@ExcelDataMapper(column="授权通知日")
	private String grantDate;
	
	@ExcelDataMapper(column="授权日")
	private String grantFlagDate;
	
	@ExcelDataMapper(column="缴纳总额")
	private String totalPay;
	
	@ExcelDataMapper(column="年费金额")
	private String PayYear;// 年度应交费用
	
	@ExcelDataMapper(column="缴纳年度")
	private  String  PayAnual;//缴纳年度
	
	@ExcelDataMapper(column="缴纳绝限")
	private String payLimit;// 缴纳绝限
	
	@ExcelDataMapper(column="状态")
	private  String  status;//状态
	
	@ExcelDataMapper(column="缴纳状态")
	private  String   PatentStatus;//缴纳状态

	@ExcelDataMapper(column="提醒周期")
	private String remindDate;

	
	private  String  patentTypeId;//专利类型
	private String warningFlag;//警告标志
	private String expiredFlag;//超过绝限标志
	private String curYearPayFlag;//当前年是否已付款标志
	private String shouldPayYear;//接下来应该付哪年标志
	
	
	public String getTotalPay() {
		return totalPay;
	}

	public void setTotalPay(String totalPay) {
		this.totalPay = totalPay;
	}

	public String getGrantFlagDate() {
		return grantFlagDate;
	}

	public void setGrantFlagDate(String grantFlagDate) {
		this.grantFlagDate = grantFlagDate;
	}

	public String getShouldPayYear() {
		return shouldPayYear;
	}

	public void setShouldPayYear(String shouldPayYear) {
		this.shouldPayYear = shouldPayYear;
	}

	public String getCurYearPayFlag() {
		return curYearPayFlag;
	}

	public void setCurYearPayFlag(String curYearPayFlag) {
		this.curYearPayFlag = curYearPayFlag;
	}

	public String getWarningFlag() {
		return warningFlag;
	}

	public void setWarningFlag(String warningFlag) {
		this.warningFlag = warningFlag;
	}

	public String getExpiredFlag() {
		return expiredFlag;
	}

	public void setExpiredFlag(String expiredFlag) {
		this.expiredFlag = expiredFlag;
	}

	public String getPatentTypeId() {
		return patentTypeId;
	}

	public void setPatentTypeId(String patentTypeId) {
		this.patentTypeId = patentTypeId;
	}

	public String getStatus() {
		return status;
	}

	public void setStatus(String status) {
		this.status = status;
	}

	private  String  PayStatus;//已交年度
	
	public String getPatentStatus() {
		return PatentStatus;
	}

	public void setPatentStatus(String patentStatus) {
		PatentStatus = patentStatus;
	}

	public String getPayAnual() {
		return PayAnual;
	}

	public void setPayAnual(String payAnual) {
		PayAnual = payAnual;
	}

	public String getApplyNum() {
		return applyNum;
	}

	public void setApplyNum(String applyNum) {
		this.applyNum = applyNum;
	}

	public String getName() {
		return name;
	}

	public void setName(String name) {
		this.name = name;
	}

	public String getApplyDate() {
		return applyDate;
	}

	public void setApplyDate(String applyDate) {
		this.applyDate = applyDate;
	}

	public String getGrantDate() {
		return grantDate;
	}

	public void setGrantDate(String grantDate) {
		this.grantDate = grantDate;
	}

	public String getRemindDate() {
		return remindDate;
	}

	public void setRemindDate(String remindDate) {
		this.remindDate = remindDate;
	}

	public String getPayYear() {
		return PayYear;
	}

	public void setPayYear(String payYear) {
		PayYear = payYear;
	}

	public String getPriorityDate() {
		return priorityDate;
	}

	public void setPriorityDate(String priorityDate) {
		this.priorityDate = priorityDate;
	}

	public String getPayLimit() {
		return payLimit;
	}

	public void setPayLimit(String payLimit) {
		this.payLimit = payLimit;
	}

	public String getPayStatus() {
		return PayStatus;
	}

	public void setPayStatus(String payStatus) {
		PayStatus = payStatus;
	}
	
}
