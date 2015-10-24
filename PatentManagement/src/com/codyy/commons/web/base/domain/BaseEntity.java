package com.codyy.commons.web.base.domain;

import java.io.Serializable;

/**
 * 
 * ClassName:BaseEntity
 * Function: domain Bean公有部分
 *
 * @author   zhangtian
 * @Date	 2015	Mar 9, 2015		8:51:43 AM
 *
 */
public class BaseEntity implements Serializable {
	
	private static final long serialVersionUID = 1L;
	private String id ;

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}
}