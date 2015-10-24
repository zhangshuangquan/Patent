package com.codyy.patentmanagement.front.web.entity;

import java.util.Date;

/**
 * 
 * 
 * @author lizhiwei
 * return 模糊的查询语句SQL
 */
public class BaseSQL {
	//得到模糊查询的sql的语句
		public static String getSql(BasePatent basePatent){
			String s = "p.apply_num applyNum,\n" +
					"	p.PATENT_ID patentId,\n" +
					"	p.NAME name,\n" +
					"	p.apply_date applyDate,\n" +
					"	p.total_pay totalPay,\n" +
					"	p.grant_date grantDate,\n" +
					"	p.patent_type_id patentTypeId,\n" +
					"	pt.remind_type remindType,\n" +
					"	p.pay_status payStatus,\n" +
					"	p.STATUS status,\n" +
					"	pf.fee perYearPay,\n" +
					"	p.priority_date priorityDate,\n" +
					"	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW())+1 haveYear,\n" +
					"	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, p.GRANT_DATE) applyToGrantYear,\n" +
					"	pt.pay_discount disCount\n" +
					"FROM\n" +
					"	(patent p, patent_type pt)\n" +
					"LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n" +
					"AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (YEAR_NUM - 1)";
			StringBuffer s1 = new StringBuffer(s);
			StringBuffer sql = new StringBuffer("select "+s1+" where 1 = 1 and pt.patent_type_id = p.patent_type_id");
			System.out.println("aa");
			if(basePatent.getStartTime() != null && basePatent.getStartTime().length()>0){
				sql.append(" and apply_date between'"+basePatent.getStartTime()+"'");
			}
			if(basePatent.getEndTime() != null && basePatent.getEndTime().length()>0){
				sql.append(" and '"+basePatent.getEndTime()+"'");
			}
			if(basePatent.getApplyNum() != null && basePatent.getApplyNum().length()>0){
				sql.append(" and apply_num like '"+basePatent.getApplyNum().trim()+"%'");
			}
			if(basePatent.getName() != null && basePatent.getName().length()>0 ){
				sql.append(" and name like '%"+basePatent.getName().trim()+"%'");
			}
			if(basePatent.getStatus() != null ){
				sql.append(" and status = "+basePatent.getStatus()+"");
			}
			sql.append(" order by applyDate DESC,grantDate desc limit ?,?");
			String strSql = sql.toString();
			return strSql;
		}
		//得到模糊查询总共的满足条件的个数
		public static String getTotal(BasePatent basePatent){
			String s = "count(*) sum"+
					" FROM\n" +
					"patent p \n" +
					"LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n" +
					"AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (YEAR_NUM - 1)";
			StringBuffer s1 = new StringBuffer(s);
			StringBuffer sql = new StringBuffer("select "+s1+" where 1 = 1");
			System.out.println("aa");
			if(basePatent.getStartTime() != null && basePatent.getStartTime().length()>0){
				sql.append(" and apply_date between '"+basePatent.getStartTime()+"'");
			}
			if(basePatent.getEndTime() != null && basePatent.getEndTime().length()>0){
				sql.append(" and '"+basePatent.getEndTime()+"'");
			}
			if(basePatent.getApplyNum() != null && basePatent.getApplyNum().length()>0){
				sql.append(" and apply_num like '"+basePatent.getApplyNum()+"%'");
			}
			if(basePatent.getName() != null && basePatent.getName().length()>0 ){
				sql.append(" and name like '%"+basePatent.getName()+"%'");
			}
			if(basePatent.getStatus() != null ){
				sql.append(" and status = "+basePatent.getStatus()+"");
			}
			String strSql = sql.toString();
			return strSql;
		}
}
