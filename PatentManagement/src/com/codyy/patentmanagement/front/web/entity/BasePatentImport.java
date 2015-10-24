package com.codyy.patentmanagement.front.web.entity;


import com.codyy.commons.annotation.ExcelColumn;
/**
 * 
 *  数据库表的所对应的字段
 * @author 李志伟
 *
 */

public class BasePatentImport {
	
	private Integer patentId;//id 自增长

	//申请号（唯一，由税务局给定）
	@ExcelColumn(columnName="申请号")
	private String applyNum;
	
	//发明名称
	@ExcelColumn(columnName="专利名")
	private String name;
	
	//申请日期
	@ExcelColumn(columnName="申请日期")
	private String applyDate;
	
	//缴费总额
	@ExcelColumn(columnName="缴费总额")
	private String totalPay;
	
	//授权通知日
	@ExcelColumn(columnName="授权通知日")
	private String grantDate;
	
	//授权日
	@ExcelColumn(columnName="授权日")
	private String grantFlagDate;
	
	//专利对应类型id
	@ExcelColumn(columnName="专利类型编号")
	private String patentTypeId;
	
	//提醒周期
	@ExcelColumn(columnName="提醒周期")
	private String remindType;
	
	//专利状态
	@ExcelColumn(columnName="专利状态")
	private String status;
	
	//缴费状态
	@ExcelColumn(columnName="已缴年数")
	private String payStatus;
	
	//优先权日
	@ExcelColumn(columnName="优先权日")
	private String priorityDate;
	
	//起止时间
	private String startTime;
		
	//专利的减缓利率
	private String disCount;

	//终止时间
	private String endTime;
	
	//每一年应交年费
	private Integer perYearPay;
	
	//第几年度
	private Integer haveYear;
	
	private Integer grantYearNum;//授权后第几年
	
	//专利的相差的期限
	public String yearNum;
	
	
	
	public String getGrantFlagDate() {
		return grantFlagDate;
	}
	public void setGrantFlagDate(String grantFlagDate) {
		this.grantFlagDate = grantFlagDate;
	}
	public Integer getGrantYearNum() {
		return grantYearNum;
	}
	public void setGrantYearNum(Integer grantYearNum) {
		this.grantYearNum = grantYearNum;
	}
	public Integer getPatentId() {
		return patentId;
	}
	public void setPatentId(Integer patentId) {
		this.patentId = patentId;
	}
	public String getYearNum() {
		return yearNum;
	}
	public void setYearNum(String yearNum) {
		this.yearNum = yearNum;
	}
	public Integer getPerYearPay() {
		return perYearPay;
	}
	public void setPerYearPay(Integer perYearPay) {
		this.perYearPay = perYearPay;
	}
	public Integer getHaveYear() {
		return haveYear;
	}
	public void setHaveYear(Integer haveYear) {
		this.haveYear = haveYear;
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
	public String getTotalPay() {
		return totalPay;
	}
	public void setTotalPay(String totalPay) {
		this.totalPay = totalPay;
	}
	public String getGrantDate() {
		return grantDate;
	}
	public void setGrantDate(String grantDate) {
		this.grantDate = grantDate;
	}
	public String getPatentTypeId() {
		return patentTypeId;
	}
	public void setPatentTypeId(String patentTypeId) {
		this.patentTypeId = patentTypeId;
	}
	public String getRemindType() {
		return remindType;
	}
	public void setRemindType(String remindType) {
		this.remindType = remindType;
	}
	public String getStatus() {
		return status;
	}
	public void setStatus(String status) {
		this.status = status;
	}
	public String getPayStatus() {
		return payStatus;
	}
	public void setPayStatus(String payStatus) {
		this.payStatus = payStatus;
	}
	public String getPriorityDate() {
		return priorityDate;
	}
	public void setPriorityDate(String priorityDate) {
		this.priorityDate = priorityDate;
	}
	public String getStartTime() {
		return startTime;
	}
	public void setStartTime(String startTime) {
		this.startTime = startTime;
	}
	public String getDisCount() {
		return disCount;
	}
	public void setDisCount(String disCount) {
		this.disCount = disCount;
	}
	public String getEndTime() {
		return endTime;
	}
	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}
	
	
}

