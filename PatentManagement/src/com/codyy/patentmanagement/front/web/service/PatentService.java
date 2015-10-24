package com.codyy.patentmanagement.front.web.service;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.StringUtils;

import com.codyy.commons.utils.PatentPage;
import com.codyy.patentmanagement.front.web.dao.PatentDao;
import com.codyy.patentmanagement.front.web.entity.BasePatent;
import com.codyy.patentmanagement.front.web.entity.PatentExcelModel;

@Service
public class PatentService {
	@Autowired
	private PatentDao patentDao;
	
	/**
	 * 批量新增
	 * @param list
	 * @return
	 * @throws NoSuchFieldException
	 * @throws SecurityException
	 * @throws IllegalArgumentException
	 * @throws IllegalAccessException
	 * @throws IOException
	 * @throws ParseException
	 */
	@Transactional
	public List<Integer> queryInsert(List<BasePatent> list) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException, IOException, ParseException{
		
		int i = 0;
		final List<Integer> errorRow = new ArrayList<Integer>();
		BasePatent basebp;
		if(list.size()==0){
			errorRow.add(0);
			return errorRow;
		}
		Iterator<BasePatent> iterator = list.iterator();

		while (iterator.hasNext()) {
			++i;
			basebp = iterator.next();
			String ApplyNum = basebp.getApplyNum();

			if (getOnePatent(ApplyNum, null).size() > 0) {

				errorRow.add(i+2);
			}
		}

		if (errorRow.size() == 0) {
			//batchInsert(list);
			if(list != null && list.size() > 0) {
				final Iterator<BasePatent> it = list.iterator();
				while(it.hasNext()) {
					final BasePatent basePatent = it.next();
					int patentId = patentDao.addNewPatent(basePatent);
					basePatent.setPatentId(patentId);
					patentDao.addPatentDetail(basePatent);
					
					double totalPay = patentDao.getTotalPay(patentId);
					patentDao.updateTotalPay(patentId, totalPay);
				}
			}
		}

		return errorRow;
	}
	
	/**
	 * 获得导出模板
	 * @param applyFromTime
	 * @param applyToTime
	 * @param status
	 * @param applyNum
	 * @param applyName
	 * @param orderType
	 * @param authorityFromTime
	 * @param authorityToTime
	 * @param fromDeadline
	 * @param toDeadline
	 * @param unpaidStatus
	 * @param start
	 * @param end
	 * @return
	 */
	public List<PatentExcelModel> getExcelModelList(String applyFromTime,String applyToTime,String status,String applyNum,String applyName,String orderType,String authorityFromTime,String authorityToTime,String fromDeadline,String toDeadline,String unpaidStatus,String liveStatus,String grantFlagDateFrom, String grantFlagDateTo,int start,int end) {
		
		final List<PatentExcelModel> modelList = new ArrayList<PatentExcelModel>();
		
		final PatentPage<Map<String, Object>> page = patentDao.searchPatentList(applyFromTime, applyToTime, status, applyNum, applyName, orderType, authorityFromTime, authorityToTime, fromDeadline, toDeadline, unpaidStatus,liveStatus,grantFlagDateFrom, grantFlagDateTo, start, end);
		
		final List<Map<String,Object>> pageList = page.getData();
		
		if(pageList != null && pageList.size() > 0) {
			final Iterator<Map<String,Object>> it = pageList.iterator();
			while(it.hasNext()) {
				final Map<String,Object> map = it.next();
				
				final Date applyDate = (Date)map.get("applyDate");
				final Date grantDate = (Date)map.get("grantDate");
				final Date grantFlagDate = (Date)map.get("grantFlagDate");
				final Date priorityDate = StringUtils.isEmpty(map.get("priorityDate")) ? null : (Date)map.get("priorityDate");
				
				final PatentExcelModel patent = new PatentExcelModel();
				patent.setApplyNum((String)map.get("applyNum"));// 申请编号
				patent.setName((String)map.get("name"));// 专利名称
				patent.setApplyDate(formatDateToString(applyDate));// 申请日期
				patent.setGrantDate(formatDateToString(grantDate));
				patent.setGrantFlagDate(formatDateToString(grantFlagDate));
				patent.setPriorityDate(formatDateToString(priorityDate));// 优先权日
				patent.setRemindDate((String)map.get("remindType"));// 提醒周期
				
				final Long haveYear = (Long)map.get("haveYear");
				final Long applyToGrantYear = (Long)map.get("applyToGrantYear");
				final BigDecimal disCount = (BigDecimal)map.get("disCount");
				final BigDecimal perYearPay = (BigDecimal)map.get("perYearPay");
				
				BigDecimal realPay = perYearPay;
				if(haveYear + 1 - applyToGrantYear <= 3) {
					realPay = realPay.multiply(disCount);
				}
				
				patent.setPayYear(realPay + "");// 年度缴费
			
				patent.setPayAnual((Long)map.get("haveYear") + "");//该交年度
				patent.setPayStatus((Integer)map.get("payStatus") + "");//已交年度
				patent.setPatentTypeId((Integer)map.get("patentTypeId") + "");
				patent.setStatus((Integer)map.get("status")+"");
				patent.setPayLimit((String)map.get("expiredDate"));// 缴纳绝限
				
				patent.setWarningFlag((String)map.get("warningFlag"));
				patent.setExpiredFlag((String)map.get("expiredFlag"));
				patent.setCurYearPayFlag((String)map.get("curYearPayFlag"));
				patent.setShouldPayYear((String)map.get("shouldPayYear"));
				patent.setTotalPay((BigDecimal)map.get("totalPay") + "");
				
				modelList.add(patent);
			}
		}
		
		return modelList;
		
	
	}
	
	private String formatDateToString(Date date) {
		if(date == null) {
			return "";
		}
		SimpleDateFormat  sdf=new SimpleDateFormat("yyyy-MM-dd");
		return sdf.format(date);
	}

/**
 * 
 * addNewPatent:向数据库添加数据
 * @author bingshaowen 
 * @param basePatent
 */
	@Transactional
	public void addNewPatent(BasePatent basePatent) {
		int patentId = patentDao.addNewPatent(basePatent);
		basePatent.setPatentId(patentId);
		patentDao.addPatentDetail(basePatent);
		
		double totalPay = patentDao.getTotalPay(patentId);
		patentDao.updateTotalPay(patentId, totalPay);
	}

	public Boolean checkId(String applyNum) {
		return patentDao.checkId(applyNum);
	}
	
	/**
	 * 根据专利号删除某条记录
	 * 
	 */
	@Transactional
	public void delOnePatent(String applyNum, String patentId){
		patentDao.delPatentDetailByPatentId(patentId);
		patentDao.delOnePatent(applyNum);
	}
	
	/**
	 *  根据条件来进行模糊的查询
	 * 
	 */
	
	public PatentPage<Map<String, Object>> getFuzzyListPage(int start,int end,BasePatent basePatent){
		return patentDao.getFuzzyPageList(start,end, basePatent);
	}
	/*public List<BasePatent> seletPatentByCondition(BasePatent basePatent){
		return patentDao.seletPatentByCondition(basePatent);
	}*/
	/**
	 * 
	 * 根据条件来进行对一个数据的更改
	 */
	@Transactional
	public int  setOnePatent(BasePatent basePatent){
		patentDao.updatePayFlag(basePatent.getPatentId(), basePatent.getPayStatus());
		double totalPay = patentDao.getTotalPay(basePatent.getPatentId());
		basePatent.setTotalPay((float)totalPay);
		//patentDao.updateTotalPay(patentId, totalPay);
		 return patentDao.setOnePatent(basePatent);
		 }
	/** 
	 *根据缴费的专利的状态进行设置
	 */
	@Transactional
	public int  updOnePatent(BasePatent basePatent){
		patentDao.updatePayFlag(basePatent.getPatentId(), basePatent.getPayStatus() + 1);
		return	patentDao.updOnePatent(basePatent);
	}
	
	/**
	 * 根据某个id查出专利的信息
	 * 
	 */
	public List<BasePatent> getOnePatent(String applyNum,Integer yearNum){
		return patentDao.getOnePatent(applyNum,yearNum);
	}
	/**
	 * 
	 * 
	 * @功能：分页
	 * @
	 */
	public PatentPage<Map<String, Object>> getListPage(int start,int end){
		
		return patentDao.getPageList(start, end);
	}
	
	/**
	 * 
	 * 
	 * @功能：分页
	 * @
	 */
	public PatentPage<Map<String, Object>> searchPatentList(String applyFromTime,String applyToTime,String status,String applyNum,String applyName,String orderType,
			String authorityFromTime,String authorityToTime,String fromDeadline,String toDeadline,String unpaidStatus,String liveStatus,String grantFlagDateFrom, String grantFlagDateTo,int start,int end){
		
		return patentDao.searchPatentList(applyFromTime, applyToTime, status, applyNum, applyName, orderType, authorityFromTime, authorityToTime, fromDeadline, toDeadline, unpaidStatus,liveStatus,grantFlagDateFrom, grantFlagDateTo, start, end);
	}
	/**
	 * 
	 * 
	 * @功能：找到需要缴费的专利
	 * @
	 */
	public PatentPage<Map<String, Object>> getPagePayPatentList(int start,int end){
		
		List<Map<String, Object>> patentParameterList = patentDao.getPayPatentParameter();
		List<Map<String, Object>> payPatentList = new ArrayList<Map<String,Object>>();	
		List<Map<String, Object>> returnPayPatentList = new ArrayList<Map<String,Object>>();
		PatentPage<Map<String,Object>> payPatent = new PatentPage<Map<String,Object>>();
		for(int i=0,j=patentParameterList.size();i<j;i++){
			if(patentParameterList.get(i).get("yearNum") != null && ((Integer)patentParameterList.get(i).get("status") == 1)){
				int remindTime = 0;
				Calendar firstCalendar = Calendar.getInstance();
				Calendar endCalendar = Calendar.getInstance();
				Calendar deadlineCalendar = Calendar.getInstance();
				Calendar currentCalendar = Calendar.getInstance();
				currentCalendar.setTime(new Date());
				Date applyDate = (Date) patentParameterList.get(i).get("applyDate");
				int yearNum = (Integer) patentParameterList.get(i).get("yearNum");
				int payStatus = (Integer) patentParameterList.get(i).get("payStatus");
				int status = (Integer) patentParameterList.get(i).get("status");
				String applyNum = (String) patentParameterList.get(i).get("applyNum");
				String remindType = (String) patentParameterList.get(i).get("remindType");
				firstCalendar.setTime(applyDate);
				firstCalendar.add(Calendar.YEAR, yearNum);
				firstCalendar.add(Calendar.DAY_OF_MONTH,-1);
				deadlineCalendar.setTime(applyDate);
				deadlineCalendar.add(Calendar.YEAR, (payStatus+1));
				deadlineCalendar.add(Calendar.DAY_OF_MONTH, -1);
				endCalendar.setTime(new Date());
				if(remindType.endsWith("D")){
					remindType = remindType.substring(0, remindType.length()-1);
					remindTime = Integer.parseInt(remindType);
					endCalendar.add(Calendar.DAY_OF_YEAR, remindTime);
				}else{
					remindType = remindType.substring(0, remindType.length()-1);
					remindTime = Integer.parseInt(remindType);
					endCalendar.add(Calendar.MONTH, remindTime);
				}
				/*Date first = firstCalendar.getTime();
				Date end1 = endCalendar.getTime();*/
	
				if(firstCalendar.before(endCalendar) && (payStatus < yearNum) && (status == 1) || deadlineCalendar.before(endCalendar)){
					payPatentList.add(patentDao.getPayPatent(applyNum));
				
				}
			}
		}
		for(int i=0;i<payPatentList.size();i++){
			if(i>=start && i<=end){
				returnPayPatentList.add(payPatentList.get(i));
			}
		}
		payPatent.setTotal(payPatentList.size());
		payPatent.setData(returnPayPatentList);
		return payPatent;
	}
	/**
	 * getPatentParameter:查询专利的配置参数
	 * @author wuJiaWen
	 * 
	 * */
	public List<Map<String, Object>> getPatentParameter(){
		
		final List<Map<String, Object>> pList = patentDao.getPatentParameter();
		if(pList != null && pList.size() > 0) {
			Iterator<Map<String,Object>> it = pList.iterator();
			while(it.hasNext()) {
				Map<String,Object> map = it.next();
				String remindType = (String)map.get("remindType");
				if(!StringUtils.isEmpty(remindType)) {
					String remindTypeNum = remindType.substring(0,remindType.length() - 1);
					String remindTypeUnit = remindType.substring(remindType.length() - 1,remindType.length());
					map.put("remindTypeNum", remindTypeNum);
					map.put("remindTypeUnit", remindTypeUnit);
				}
			}
		}
		return pList;
	}
	
	
	/**
	 * getPatentParameter:更新专利的配置参数
	 * @author wuJiaWen
	 * 
	 * */
	public int updateParameters(float payDiscount, int patentTypeId, String remindType){
		float realPayDiscount = payDiscount/100;
		return patentDao.updateParameters(realPayDiscount, patentTypeId, remindType);
	}
	
	/**
	 * 根据id获取专利
	 * @param patentId
	 * @return
	 */
	public Map<String, Object> getBasePatentById(Integer patentId) {
		return patentDao.getBasePatentById(patentId);
	}
	
	/**
	 * 根据id获取专利明细
	 * @param patentId
	 * @return
	 */
	public List<Map<String, Object>> getPatentDetailById(Integer patentId) {
		return patentDao.getPatentDetailById(patentId);
	}
}
