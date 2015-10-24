package com.codyy.patentmanagement.front.web.dao.impl;


import java.math.BigDecimal;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.sql.Statement;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.GregorianCalendar;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import org.springframework.jdbc.core.JdbcTemplate;
import org.springframework.jdbc.core.PreparedStatementCreator;
import org.springframework.jdbc.support.GeneratedKeyHolder;
import org.springframework.jdbc.support.KeyHolder;
import org.springframework.stereotype.Repository;
import org.springframework.util.StringUtils;

import com.codyy.commons.utils.PatentPage;
import com.codyy.patentmanagement.front.web.dao.PatentDao;
import com.codyy.patentmanagement.front.web.entity.BasePatent;
import com.codyy.patentmanagement.front.web.entity.BaseSQL;

@Repository
public class PatentDaoImpl implements PatentDao {
	
	@Resource
	private JdbcTemplate jdbcTemplate;

	// 向数据库中新加一个专利
	@Override
	public int addNewPatent(final BasePatent basePatent) {
		final String sql = "insert into patent(APPLY_NUM,NAME,APPLY_DATE,TOTAL_PAY,GRANT_DATE,PATENT_TYPE_ID,PAY_STATUS,STATUS,PRIORITY_DATE,GRANT_FLAG_DATE) values(?,?,?,?,?,?,?,?,?,?)";
	
		
		final KeyHolder key = new GeneratedKeyHolder();
		
		
		jdbcTemplate.update(new PreparedStatementCreator() {
			
			@Override
			public PreparedStatement createPreparedStatement(Connection conn)
					throws SQLException {
				PreparedStatement ps = conn.prepareStatement(sql, Statement.RETURN_GENERATED_KEYS);
				ps.setString(1, basePatent.getApplyNum());
				ps.setString(2, basePatent.getName());
				ps.setDate(3, new java.sql.Date(basePatent.getApplyDate().getTime()));
				ps.setFloat(4, basePatent.getTotalPay());
				ps.setDate(5, new java.sql.Date(basePatent.getGrantDate().getTime()));
				ps.setInt(6, basePatent.getPatentTypeId());
				ps.setInt(7, basePatent.getPayStatus());
				ps.setInt(8, basePatent.getStatus());
				
				
				if(basePatent.getPriorityDate() == null) {
					ps.setDate(9,  null);
				} else {
					ps.setDate(9,  new java.sql.Date(basePatent.getPriorityDate().getTime()));
				}
				
				Date grantFlagDate = basePatent.getGrantFlagDate();
				
				if(grantFlagDate == null) {
					ps.setDate(10, null);
				} else {
					ps.setDate(10, new java.sql.Date(grantFlagDate.getTime()));
				}
				
				return ps;
			}
		}, key);
		
		return key.getKey().intValue();
		
	}

	public Boolean checkId(String applyNum) {
		Integer num = (Integer) jdbcTemplate.queryForObject(
				"SELECT count(*) FROM patent WHERE APPLY_NUM = ?",
				new Object[] { applyNum }, Integer.class);
		boolean flag = true;
		if (num == 0) {
			flag = true;
		} else {
			flag = false;
		}
		return flag;
	}

	// 修改其中的某条专利的记录
	@Override
	public int setOnePatent(BasePatent basePatent) {
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String applyDate = sdf.format(basePatent.getApplyDate());
		String grantDate = sdf.format(basePatent.getGrantDate());
		
		
		String name = basePatent.getName();
		System.out.println(name);
		/*String new_name = null;
		try {
			 new_name = new String(name= new String(name.getBytes("iso-8859-1"), "utf-8"));
		} catch (UnsupportedEncodingException e) {
			e.printStackTrace();
		}*/
		String priorityDate = null;
		if (basePatent.getPriorityDate() != null) {
			priorityDate = sdf.format(basePatent.getPriorityDate());
		}
		
		String grantFlagDate = null;
		if (basePatent.getGrantFlagDate() != null) {
			grantFlagDate = sdf.format(basePatent.getGrantFlagDate());
		}
		String sql = "update patent p set p.apply_num = ?, p.patent_type_id = ?, p.name= ?, p.apply_date = ? ,"
				+ "p.grant_date = ?,p.grant_flag_date = ? ,p.remind_type = ? ,p.priority_date = ?, p.total_pay = ?, p.status= ?, p.pay_status = ? where patent_id = ? ";
		Object[] obj = new Object[] {basePatent.getApplyNum(), basePatent.getPatentTypeId(), name, applyDate,
				grantDate,grantFlagDate, basePatent.getRemindType(), priorityDate,basePatent.getTotalPay(), basePatent.getStatus(), basePatent.getPayStatus(),
				basePatent.getPatentId()};
		int i = jdbcTemplate.update(sql, obj);
		return i;
	}

	// 删除某条专利的记录
	@Override
	public void delOnePatent(String applyNum) {
		String sql = "delete from patent where apply_num = ?";
		System.out.println(applyNum);
		jdbcTemplate.update(sql, applyNum);
	}

	// 对专利的缴费的记录进行更新
	public int updOnePatent(BasePatent basePatent) {
		BasePatent base = new BasePatent();
		base.setPayStatus(basePatent.getPayStatus() + 1);
		base.setTotalPay(basePatent.getTotalPay() + basePatent.getPerYearPay());
		String sql = "update patent p set p.pay_status = ? ,p.total_pay = ? where p.apply_num =?";
		Object[] obj = new Object[] { base.getPayStatus(), base.getTotalPay(),
				basePatent.getApplyNum() };
		int i = jdbcTemplate.update(sql, obj);
		return i;

	}

	@Override
	public List<BasePatent> getOnePatent(String applyNum,Integer yearNum) {
		List<BasePatent> list = new ArrayList<BasePatent>();
		String sql = "SELECT\n"
				+ "	p.apply_num applyNum,\n"
				+ "	p. patent_id patentId,\n"
				+ "	p. NAME name,\n"
				+ "	p.apply_date applyDate,\n"
				+ "	p.grant_flag_date grantFlagDate,\n"
				+ "	p.total_pay totalPay,\n"
				+ "	p.grant_date grantDate,\n"
				+ "	p.patent_type_id patentTypeId,\n"
				+ "	pt.remind_type remindType,\n"
				+ "	p.pay_status payStatus,\n"
				+ "	p. STATUS status,\n"
				+ "	pf.fee  perYearPay,\n"
				+ "	p.priority_date priorityDate,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 haveYear,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, p.GRANT_DATE) applyToGrantYear,\n"
				+ "	pf.YEAR_NUM yearNum,\n"
				+ "	pt.pay_discount payDisCount\n"
				+ "FROM\n"
				+ "	(patent p ,patent_type pt)\n"
				+ "LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n"
				+ "AND pf.YEAR_NUM = ?\n"
				+ "where pt.PATENT_TYPE_ID = p.PATENT_TYPE_ID and p.apply_Num=?";
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		List<Map<String, Object>> lists = jdbcTemplate.queryForList(sql,yearNum,applyNum);
		for (int i = 0; i < lists.size(); i++) {
			BasePatent basePatent = new BasePatent();
			// 拿到这个专利的类型是什么，以及这个专利的缴费几个年度了
			basePatent.setApplyNum(lists.get(i).get("applyNum") + "");// 设置申请号
			basePatent.setName(lists.get(i).get("name") + "");// 设置申请专利的名字的类别
			basePatent.setPatentId((Integer)(lists.get(i).get("patentId")));
			basePatent.setYearNum(yearNum+"");
			try {
				basePatent.setApplyDate(sdf.parse(lists.get(i).get("applyDate")
						+ ""));
			} catch (ParseException e) {
				e.printStackTrace();
			}// 设置申请日期
				// System.out.println(lists.get(i).get("applyNum")+"");
			basePatent.setTotalPay(Float.parseFloat(lists.get(i).get("totalPay") + ""));// 设置总的缴费
			try {

				basePatent.setGrantDate(sdf.parse(lists.get(i).get("grantDate")
						+ ""));
			} catch (ParseException e) {
				e.printStackTrace();
			}
			try {
				Object grantFlagDate = lists.get(i).get("grantFlagDate");
				if(!StringUtils.isEmpty(grantFlagDate)) {
					basePatent.setGrantFlagDate(sdf.parse(grantFlagDate+""));
				}
			} catch (ParseException e) {
				e.printStackTrace();
			}
			basePatent.setPatentTypeId(Integer.parseInt(lists.get(i).get(
					"patentTypeId")
					+ ""));
			// 设置提醒类型
			basePatent.setRemindType(lists.get(i).get("remindType") + "");
			// 设置专利提醒日
			basePatent.setPayStatus(Integer.parseInt(lists.get(i).get(
					"payStatus")
					+ ""));
			// 设置状态
			basePatent.setStatus(Integer.parseInt(lists.get(i).get("status")
					+ ""));
			// 取得减缓率
			basePatent.setDisCount(Float.parseFloat(lists.get(i).get(
					"payDisCount")
					+ ""));
			
			// 设置这个是第几年的
			basePatent.setHaveYear((int) (Double.parseDouble((lists.get(i).get(
					"haveYear") + ""))));
			
			final long applyToGrantYear = (Long)lists.get(i).get("applyToGrantYear");
			
			// 设置及当年的年费
			if (lists.get(i).get("perYearPay") == null) {
				basePatent.setPerYearPay(0);
			} else {
				float discount = basePatent.getDisCount();
				float total = Float
						.parseFloat((lists.get(i).get("perYearPay") + ""));
				
				if(basePatent.getPayStatus() + 1 - applyToGrantYear > 3) {
					basePatent.setPerYearPay((int) (total));
				} else {
					basePatent.setPerYearPay((int) (discount * total));
				}
			}
			
			// 设置已经缴费总额
			basePatent.setTotalPay(Float.parseFloat(lists.get(i)
					.get("totalPay") + ""));
			
			// 设置优先权日了
			if (lists.get(i).get("priorityDate") != null) {
				try {

					basePatent.setPriorityDate(sdf.parse(lists.get(i).get(
							"priorityDate")
							+ ""));

				} catch (ParseException e) {
					e.printStackTrace();
				}

			} else {
				try {
					basePatent.setPriorityDate(null);
				} catch (Exception e) {
					e.printStackTrace();
				}

			}
			// 设置专利的是否已经过期
			/*if (lists.get(i).get("yearNum") != null) {
				basePatent.setYearNum("success");
			} else {
				basePatent.setYearNum("fail");
			}*/
			list.add(basePatent);
		}

		return list;
	}

	@Override
	public PatentPage<Map<String, Object>> getFuzzyPageList(int start, int end,
			BasePatent basePatent) {

		String sql = BaseSQL.getSql(basePatent);
		PatentPage<Map<String, Object>> pagePatent = new PatentPage<Map<String, Object>>();
		String tolSql = BaseSQL.getTotal(basePatent);
		long sum = jdbcTemplate.queryForLong(tolSql);
		List<Map<String, Object>> pageList = jdbcTemplate.queryForList(sql,
				start, end);
		pagePatent.setTotal(sum);
		pagePatent.setData(pageList);
		return pagePatent;
	}

	@Override
	public PatentPage<Map<String, Object>> getPageList(int start, int end) {
		PatentPage<Map<String, Object>> pagePatent = new PatentPage<Map<String, Object>>();
		String sql = "select count(*) sum from PATENT";
		long total = jdbcTemplate.queryForLong(sql);
		String listSql = "SELECT\n"
				+ "	p.apply_num applyNum,\n"
				+ "	p.patent_id patentId,\n"
				+ "	p.name name,\n"
				+ "	p.apply_date applyDate,\n"
				+ "	p.total_pay totalPay,\n"
				+ "	p.grant_date grantDate,\n"
				+ "	p.patent_type_id patentTypeId,\n"
				+ "	pt.remind_type remindType,\n"
				+ "	p.pay_status payStatus,\n"
				+ "	p. STATUS status,\n"
				+ "	pf.fee perYearPay,\n"
				+ "	p.priority_date priorityDate,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 haveYear,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, p.GRANT_DATE) + 1 applyToGrantYear,\n"
				+ "	pf.YEAR_NUM yearNum,\n"
				+ "	pt.pay_discount disCount\n"
				+ "FROM\n"
				+ "	(patent p ,patent_type pt)\n"
				+ "LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n"
				+ "AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (YEAR_NUM -1)\n"
				+ "where pt.PATENT_TYPE_ID = p.PATENT_TYPE_ID\n" + "ORDER BY\n"
				+ "	applyDate DESC,grantDate desc " + "limit ?,?";
		List<Map<String, Object>> pageList = jdbcTemplate.queryForList(listSql,
				start, end);
		pagePatent.setTotal(total);
		pagePatent.setData(pageList);
		return pagePatent;
	}

	// 获得专利的一些参数
	@Override
	public List<Map<String, Object>> getPayPatentParameter() {

		String sql = "SELECT\n"
				+ "	p.apply_num applyNum,\n"
				+ "	p.apply_date applyDate,\n"
				+ "	p.pay_status payStatus,\n"
				+ "	pt.remind_type remindType,\n"
				+ "	p.status status,\n"
				+ "	pf.year_num yearNum\n"
				+ "FROM\n"
				+ "	(patent p, patent_type pt)\n"
				+ "LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n"
				+ "AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (YEAR_NUM - 1)\n"
				+ "WHERE\n" + "	pt.PATENT_TYPE_ID = p.PATENT_TYPE_ID\n"
				+ "ORDER BY\n" + "	yearNum DESC";
		return jdbcTemplate.queryForList(sql);
	}

	// 返回需要缴费的专利信息
	@Override
	public Map<String, Object> getPayPatent(String applyNum) {

		String sql = "SELECT\n" +
				"	p.apply_num applyNum,\n" +
				"	p. NAME name,\n" +
				"	p.apply_date applyDate,\n" +
				"	p.total_pay totalPay,\n" +
				"	p.grant_date grantDate,\n" +
				"	p.patent_type_id patentTypeId,\n" +
				"	pt.remind_type remindType,\n" +
				"	p.pay_status payStatus,\n" +
				"	p. STATUS STATUS,\n" +
				"	pf.fee perYearPay,\n" +
				"	p.priority_date priorityDate,\n" +
				"	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 haveYear,\n" +
				"	pf.YEAR_NUM yearNum,\n" +
				"	pt.pay_discount disCount\n" +
				"FROM\n" +
				"	(patent p, patent_type pt)\n" +
				"LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n" +
				"AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (YEAR_NUM - 1)\n" +
				"WHERE\n" +
				"	pt.PATENT_TYPE_ID = p.PATENT_TYPE_ID\n" +
				"AND p.apply_Num = ?";

		return jdbcTemplate.queryForMap(sql, applyNum);
	}

	//查询专利的配置参数
	@Override
	public List<Map<String, Object>> getPatentParameter() {
		String sql="SELECT\n" +
				"	patent_type_id AS patentTypeId,\n" +
				"	patent_type_name AS patentTypeName,\n" +
				"	REMIND_TYPE AS remindType,\n" +
				"	pay_discount*100 AS payDiscount\n" +
				"FROM\n" +
				"	patent_type;";
		return jdbcTemplate.queryForList(sql.toString());
	}

	//更新专利的配置参数
	@Override
	public int updateParameters(float payDiscount, int patentTypeId, String remindType) {
		String sql="update patent_type set pay_discount = ?, remind_type = ? where patent_type_id = ?";
		return jdbcTemplate.update(sql, payDiscount,remindType,patentTypeId);
	}
	

	/**
	 * 根据id查询专利明细
	 */
	public List<Map<String, Object>> getPatentDetailById(Integer patentId) {
		String sql = "select d.*, t.PAY_DISCOUNT, t.REMIND_TYPE, b.FEE " +  
						"from patent p " +
						"left JOIN patent_type t on p.PATENT_TYPE_ID = t.PATENT_TYPE_ID " +
						"left join patent_detail d on p.PATENT_ID = d.patent_id " +
						"left join base_fee b on t.PATENT_TYPE_ID = b.PATENT_TYPE_ID and b.YEAR_NUM = d.year_num " +
						"where p.PATENT_ID = ?";
		
		return jdbcTemplate.queryForList(sql, patentId);
	}
	
	/**
	 * 根据id查询专利
	 */
	@Override
	public Map<String, Object> getBasePatentById(Integer patentId) {
		String sql = "select * " +
					 "from patent p " +
					 "left JOIN patent_type t on p.PATENT_TYPE_ID = t.PATENT_TYPE_ID " +
					 "where p.PATENT_ID = ?";
		return jdbcTemplate.queryForMap(sql, patentId);
	}
	
	// 向数据库中新加一个专利
	@Override
	public void addPatentDetail(BasePatent basePatent) {
		final Map<String, Object> map = getPatentTypeById(basePatent.getPatentTypeId());
		final Integer validYears = (Integer)map.get("VALID_YEARS");
		String sql = "insert into patent_detail (patent_id, year_num, pay_flag) values ";
		
		Object[] obj = new Object[validYears*3];
		int paramIndex = 0;
		Integer payStatus = basePatent.getPayStatus() == null ? 0 : basePatent.getPayStatus();
		
		for(int i = 1; i <= validYears; i ++) {
			if(i != 1) {
				sql += ",";
			}
			sql += "(?,?,?)";
			obj[paramIndex] = basePatent.getPatentId();
			paramIndex++;
			obj[paramIndex] = i;
			paramIndex++;
			
			if(i <= payStatus) {
				obj[paramIndex] = "Y";
			} else {
				obj[paramIndex] = "N";
			}
			paramIndex++;
		}
	
		jdbcTemplate.update(sql, obj);
		
	}
	
	
	public void updatePayFlag(Integer patentId, Integer payStatus) {
		String sql1 = "update patent_detail set pay_flag = ? where year_num > ? and patent_id = ? ";
		String sql2 = "update patent_detail set pay_flag = ? where year_num <= ? and patent_id = ? ";
		
		jdbcTemplate.update(sql1, "N", payStatus, patentId);
		jdbcTemplate.update(sql2, "Y", payStatus, patentId);
	}
	
	public void delPatentDetailByPatentId(String patentId) {
		String sql = "delete from patent_detail where patent_id = ?";
		jdbcTemplate.update(sql, patentId);
	}
	
	private Map<String, Object> getPatentTypeById(int patentTypeId) {
		String sql  = "select * from patent_type where patent_type_id = ?";
		return jdbcTemplate.queryForMap(sql,patentTypeId);
	}
	
	@Override
	public PatentPage<Map<String, Object>> searchPatentList(String applyFromTime,String applyToTime,String status,String applyNum,String applyName,String orderType,
			String authorityFromTime,String authorityToTime,String fromDeadline,String toDeadline,String unpaidStatus,String liveStatus,String grantFlagDateFrom, String grantFlagDateTo,int start,int end) {
		
		String listSql = "SELECT\n"
				+ "	p.apply_num applyNum,\n"
				+ "	p.patent_id patentId,\n"
				+ "	p.name name,\n"
				+ "	p.apply_date applyDate,\n"
				+ "	p.total_pay totalPay,\n"
				+ "	p.grant_date grantDate,\n"
				+ "	p.grant_flag_date grantFlagDate,\n"
				+ "	p.patent_type_id patentTypeId,\n"
				+ "	pt.remind_type remindType,\n"
				+ "	p.pay_status payStatus,\n"
				+ "	p.STATUS status,\n"
				+ "	pf.fee perYearPay,\n"
				+ "	p.priority_date priorityDate,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 haveYear,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.APPLY_DATE, p.GRANT_DATE) + 1 applyToGrantYear,\n"
				+ "	TIMESTAMPDIFF(YEAR, p.GRANT_DATE, NOW()) + 1 grantToNowYear,\n"
				+ "	TIMESTAMPDIFF(MONTH, p.GRANT_DATE, NOW()) + 1 grantToNowMonth,\n"
				+ "	pf.YEAR_NUM yearNum,\n"
				+ "	pt.pay_discount disCount\n"
				+ "FROM\n"
				+ "patent p left join patent_type pt on pt.PATENT_TYPE_ID = p.PATENT_TYPE_ID \n"
				+ "LEFT JOIN base_fee pf ON p.patent_type_id = pf.patent_type_id\n"
				+ "AND TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) = (pf.YEAR_NUM -1) " +
				"where 1 = 1 ";
		
		final List<Object> paramList = new ArrayList<Object>();
		
		SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd"); 
		if(!StringUtils.isEmpty(applyFromTime)) {
			try {
				Date dFromTime = formatter.parse(applyFromTime);
				listSql += "and p.apply_date >= ? ";
				paramList.add(dFromTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(applyToTime)) {
			try {
				Date dToTime = formatter.parse(applyToTime);
				listSql += "and p.apply_date <= ? ";
				paramList.add(dToTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(authorityFromTime)) {
			try {
				Date dFromTime = formatter.parse(authorityFromTime);
				listSql += "and p.GRANT_DATE >= ? ";
				paramList.add(dFromTime);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(authorityToTime)) {
			try {
				Date dToTime = formatter.parse(authorityToTime);
				listSql += "and p.GRANT_DATE <= ? ";
				paramList.add(dToTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(grantFlagDateFrom)) {
			try {
				Date dFromTime = formatter.parse(grantFlagDateFrom);
				listSql += "and p.GRANT_FLAG_DATE >= ? ";
				paramList.add(dFromTime);
				
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(grantFlagDateTo)) {
			try {
				Date dToTime = formatter.parse(grantFlagDateTo);
				listSql += "and p.GRANT_FLAG_DATE <= ? ";
				paramList.add(dToTime);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		
		if(!StringUtils.isEmpty(applyNum)) {
			listSql += "and p.apply_num like ? ";
			paramList.add("%"+applyNum+"%");
		}
		
		if(!StringUtils.isEmpty(applyName)) {
			listSql += "and p.name like ? ";
			paramList.add("%"+applyName+"%");
		}
		
		if(!StringUtils.isEmpty(liveStatus)) {
			listSql += "and p.STATUS = ? ";
			paramList.add(liveStatus);
		}
		
		if(!StringUtils.isEmpty(status)) {
			if("1".equals(status)) {
				listSql += "and p.pay_status >= TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 ";
			} else {
				listSql += "and p.pay_status < TIMESTAMPDIFF(YEAR, p.APPLY_DATE, NOW()) + 1 ";
			}
		}
		
		if("1".equals(orderType)) {
			listSql += "ORDER BY p.apply_date desc ";//申请日降序
		} else if ("2".equals(orderType)) {
			listSql += "ORDER BY p.apply_date ";//申请日升序
		} else if ("3".equals(orderType)) {
			listSql += "ORDER BY p.grant_date desc ";//授权日降序
		} else if ("4".equals(orderType)) {
			listSql += "ORDER BY p.grant_date ";//授权日升序
		}
		
		List<Map<String, Object>> pageList = jdbcTemplate.queryForList(listSql,
				paramList.toArray());
		
		if(pageList != null && pageList.size() > 0) {
			Iterator<Map<String, Object>> it = pageList.iterator();
			while(it.hasNext()) {
				Map<String, Object> map = it.next();
				Integer payStatus = (Integer)map.get("payStatus");
				Long grantToNowMonth = (Long)map.get("grantToNowMonth");
				//Long grantToNowYear = (Long)map.get("grantToNowYear");
				Long haveYear = (Long)map.get("haveYear");
				Long applyToGrantYear = (Long)map.get("applyToGrantYear");
				String remindType = (String)map.get("remindType");
				Date applyDate = (Date)map.get("applyDate");
				Date grantDate = (Date)map.get("grantDate");
				
				String curYearPayFlag = "N";
				String warningFlag = "N";
				String expiredFlag = "N";
				Long shouldPayYear = 0l;
				Date expiredDate;
				
				Date firstTimeDeadLine = addOrMinusDate(applyDate,applyToGrantYear,0,0);
				
				/*if(!new Date().after(firstTimeDeadLine)) {
					expiredDate = addOrMinusDate(grantDate,0,3,0);//首次付款,三个月过期
					if(firstTimeDeadLine.before(expiredDate)) {
						expiredDate = firstTimeDeadLine;
					}
					shouldPayYear = payStatus != null && payStatus != 0 ? payStatus + 1 : applyToGrantYear;
					
					if(payStatus > applyToGrantYear) {
						curYearPayFlag = "Y";
					}
					
					if(grantToNowMonth > 3 && !"Y".equals(curYearPayFlag))  {
						expiredFlag = "Y";
					}
				} else {
					shouldPayYear = payStatus != null && payStatus != 0 ? payStatus + 1 : applyToGrantYear;
					if(payStatus > haveYear) {
						curYearPayFlag = "Y";
					} else if(payStatus < haveYear) {
						expiredFlag = "Y";
					}
					expiredDate = addOrMinusDate(applyDate,haveYear,0,0);
				}*/
				
				if(payStatus >= haveYear) {
					curYearPayFlag = "Y";
				}
				
				expiredDate = addOrMinusDate(applyDate,haveYear - 1,6,0);
				
				shouldPayYear = payStatus + 1l;
				
				
				
				if("N".equals(curYearPayFlag)) {
					
					int monthAdd = 0;
					int dayAdd = 0;
					
					if(!StringUtils.isEmpty(remindType)) {
						if(remindType.endsWith("M")) {
							monthAdd -= Integer.parseInt(remindType.substring(0, remindType.indexOf("M")));
						} else if(remindType.endsWith("D")) {
							dayAdd -= Integer.parseInt(remindType.substring(0, remindType.indexOf("D")));
						}
					}
					
					Date warningDate = addOrMinusDate(expiredDate, 0, monthAdd, dayAdd);
					
					if(!expiredDate.after(new Date())) {
						expiredFlag = "Y";
					}else if(warningDate.before(new Date())) {
						warningFlag = "Y";
					}
				}
				
				map.put("curYearPayFlag", curYearPayFlag);
				map.put("warningFlag", warningFlag);
				map.put("expiredFlag", expiredFlag);
				map.put("shouldPayYear", shouldPayYear+"");
				
				SimpleDateFormat  sdf=new SimpleDateFormat("yyyy-MM-dd");
				
				map.put("expiredDate", sdf.format(expiredDate));
			}
		}
		
		//pagePatent.setTotal(total);
		//pagePatent.setData(pageList);
		//return pagePatent;
		return filterPageList(pageList,start,end,fromDeadline,toDeadline,unpaidStatus,orderType);
	}
	
	/*
	 * 增加或减少年月日
	 * @param date
	 * @param yearAdd
	 * @param monthAdd
	 * @param dayAdd
	 * @return
	 */
	private Date addOrMinusDate(Date date, long yearAdd, int monthAdd, int dayAdd) {
		GregorianCalendar gc=new GregorianCalendar();
		gc.setTime(date);
		gc.add(1,(int)yearAdd);//表示年加yearAdd
		gc.add(2,monthAdd);//表示月加monthAdd
		gc.add(5,dayAdd);//表示周加dayAdd
		return gc.getTime();
	}
	
	/*
	 * 过滤查询结果
	 */
	private PatentPage<Map<String, Object>> filterPageList(final List<Map<String, Object>> pageList, final int start, final int end, final String fromDeadline, final String toDeadline, final String unpaidStatus, final String orderType ) {
		final PatentPage<Map<String, Object>>  page = new PatentPage<Map<String,Object>>();
		if(pageList == null || pageList.size() <= 0) {
			page.setData(pageList);
			page.setTotal(0);
			return page;
		}
		final SimpleDateFormat  sdf=new SimpleDateFormat("yyyy-MM-dd");
		Iterator<Map<String,Object>> it = pageList.iterator();
		while(it.hasNext()) {
			final Map<String,Object> map = it.next();
			if(!StringUtils.isEmpty(unpaidStatus)) {
				final String warningFlag = (String)map.get("warningFlag");
				final String expiredFlag = (String)map.get("expiredFlag");
				if("1".equals(unpaidStatus)) {
					if(!"Y".equals(warningFlag)) {
						it.remove();
						continue;
					}
				} else if ("2".equals(unpaidStatus)) {
					if(!"Y".equals(expiredFlag)) {
						it.remove();
						continue;
					}
				} else if ("3".equals(unpaidStatus)) {
					if(!"Y".equals(expiredFlag) && !"Y".equals(warningFlag)) {
						it.remove();
						continue;
					}
				}
			}
			if(!StringUtils.isEmpty(toDeadline)) {
				final String sExpiredDate = (String)map.get("expiredDate");
				try {
					final Date toDate = sdf.parse(toDeadline);
					final Date expiredDate = sdf.parse(sExpiredDate);
					if(toDate.before(expiredDate)) {
						it.remove();
						continue;
					}
					
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
			if(!StringUtils.isEmpty(fromDeadline)) {
				final String sExpiredDate = (String)map.get("expiredDate");
				try {
					final Date fromDate = sdf.parse(fromDeadline);
					final Date expiredDate = sdf.parse(sExpiredDate);
					if(fromDate.after(expiredDate)) {
						it.remove();
						continue;
					}
				} catch (ParseException e) {
					e.printStackTrace();
				}
			}
		}
		
		if("5".equals(orderType)) {
			Collections.sort(pageList, new MyMap(false));
		} else if ("6".equals(orderType)) {
			Collections.sort(pageList, new MyMap(true));
		}
		
		final List<Map<String, Object>> tempList = new ArrayList<Map<String,Object>>();
		it = pageList.iterator();
		int index = 0;
		while(it.hasNext()) {
			final Map<String,Object> map = it.next();
			if(index >= start && index <= end || start < 0) {
				tempList.add(map);
			}
			index ++;
		}
		page.setData(tempList);
		page.setTotal(pageList.size());
		return page;
	}
	
	/*
	 * map按照自定义规则排序
	 */
	private class MyMap implements Comparator<Map<String, Object>>{
		
		private boolean asc;
		
		public MyMap(boolean asc) {
			this.asc = asc;
		}

		@Override
		public int compare(Map<String, Object> a, Map<String, Object> b) {
			
			if(a == null || b == null) {
				return 0;
			}
			
			final String aExpiredDate = (String)a.get("expiredDate");
			final String bExpiredDate = (String)b.get("expiredDate");
			
			if(aExpiredDate == null || bExpiredDate == null) {
				return 0;
			}
			
			Date aDate = null;
			Date bDate = null;
			final SimpleDateFormat  sdf=new SimpleDateFormat("yyyy-MM-dd");
			
			try {
				aDate = sdf.parse(aExpiredDate);
				bDate = sdf.parse(bExpiredDate);
			} catch (ParseException e) {
				e.printStackTrace();
				return 0;
			}
			
			if(aDate.equals(bDate)) {
				return 0;
			}
			
			if(aDate.before(bDate)) {
				return asc ? -1 : 1;
			} else {
				return asc ? 1 : -1;
			}
			
		}
		
	}
	
	/**
	 * 计算已付总额
	 * @param patentId
	 * @return
	 */
	public double getTotalPay(int patentId) {
		String sql = "select fee.YEAR_NUM, fee.FEE, type.PAY_DISCOUNT from patent p " +
					"left join patent_type type on p.PATENT_TYPE_ID = type.PATENT_TYPE_ID " +
					"left join patent_detail detail on p.PATENT_ID = detail.PATENT_ID and detail.PAY_FLAG = 'Y' " +
					"left join base_fee fee on fee.patent_type_ID = type.PATENT_TYPE_ID and fee.YEAR_NUM = detail.YEAR_NUM " +
					"WHERE p.PATENT_ID = ? ORDER BY fee.YEAR_NUM ";
		
		double totalPay = 0d;
		
		final List<Map<String, Object>> payList = jdbcTemplate.queryForList(sql, patentId);
		
		if(payList != null &&  payList.size() > 0) {
			final Iterator<Map<String, Object>> it = payList.iterator();
			
			int year = 1;
			while(it.hasNext()) {
				final Map<String, Object> map = it.next();
				final double payDiscount = ((BigDecimal)map.get("PAY_DISCOUNT")).doubleValue();
				final double fee = ((BigDecimal)map.get("FEE")).doubleValue();
				
				double curPay = fee;
				
				if(year <= 3) {
					curPay = curPay * payDiscount;
				}
				
				totalPay += curPay;
				
				year ++;
				
			}
		}
		
		return totalPay;
	}
	
	/**
	 * 更新付款总额
	 */
	public void updateTotalPay(int patentId, double totalPay) {
		String sql = "update patent set TOTAL_PAY = ? where PATENT_ID = ?";
		jdbcTemplate.update(sql, totalPay, patentId);
	}
	
	
}
