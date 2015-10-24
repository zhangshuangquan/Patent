package com.codyy.commons.utils;

import java.util.List;
import java.util.Map;

/**
 * 
 * 分页所要的bean
 * @author lizhiwei
 * 参数： 数据库总的数据记录，返回的list的类型 
 *
 */
public class PatentPage<T> {
	private long total;
	private List<T> data;
	public long getTotal() {
		return total;
	}
	public void setTotal(long total) {
		this.total = total;
	}
	public List<T> getData() {
		return data;
	}
	public void setData(List<T> data) {
		this.data = data;
	}
	
	
}
