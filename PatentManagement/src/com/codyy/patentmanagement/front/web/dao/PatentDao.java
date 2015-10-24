package com.codyy.patentmanagement.front.web.dao;

import java.util.List;
import java.util.Map;
import com.codyy.commons.utils.PatentPage;
import com.codyy.patentmanagement.front.web.entity.BasePatent;

public interface PatentDao {
	
	
	/**
	 * 
	 * addNewPatent:向数据库添加数据
	
	 * 
	 * @author bingshaowen 
	 * @param basePatent
	 */
	
	//对一个专利进行编辑
	public int setOnePatent(BasePatent basePatent);
	
	//删除一个专利
	public void delOnePatent(String applyNum);
	
	//针对缴费的专利进行更新
	public int updOnePatent(BasePatent basePatent);
	
	//针对某些条件的模糊查询
	public PatentPage<Map<String,Object>> getFuzzyPageList(int start, int end,BasePatent basePatent);
	
	//根据id取得某个专利的信息
	List<BasePatent> getOnePatent(String applyNum,Integer yearNum);
	
	//获得分页的数据
	public PatentPage<Map<String,Object>> getPageList(int start, int end);

	public int addNewPatent(BasePatent basePatent);

	public Boolean checkId(String applyNum);
	
	//获得专利的一些参数
	public List<Map<String,Object>> getPayPatentParameter();
	
	//返回需要缴费的专利信息
	public Map<String,Object> getPayPatent(String applyNum);
	
	//查询专利的配置参数
	public List<Map<String,Object>> getPatentParameter();
	
	//更新专利的配置参数
	public int updateParameters(float payDiscount, int patentTypeId, String remindType);
	
	//根据id查询专利
	public Map<String, Object> getBasePatentById(Integer patendId);
	
	//根据id查询专利明细
	public List<Map<String, Object>> getPatentDetailById(Integer patentId);
	
	//添加专利明细
	public void addPatentDetail(BasePatent basePatent);
	
	//删除专利明细
	public void delPatentDetailByPatentId(String patentId);
	
	//更新支付标志
	public void updatePayFlag(Integer patentId, Integer payStatus);
	
	public PatentPage<Map<String, Object>> searchPatentList(String applyFromTime,String applyToTime,String status,String applyNum,String applyName,String orderType,String authorityFromTime,String authorityToTime,String fromDeadline,String toDeadline,String unpaidStatus,String liveStatus,String grantFlagDateFrom, String grantFlagDateTo,int start,int end);
	
	//计算已付总额
	public double getTotalPay(int patentId);
	
	//更新付款总额
	public void updateTotalPay(int patentId, double totalPay);
	
	
}