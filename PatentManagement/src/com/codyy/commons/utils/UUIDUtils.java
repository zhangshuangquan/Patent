package com.codyy.commons.utils;

import java.util.UUID;

import org.apache.commons.lang.StringUtils;

/**
 * 
 * ClassName:UUIDUtils
 * Function: 获取UUID
 *
 * @author   zhangtian
 * @Date	 2015	Mar 9, 2015		12:35:37 PM
 *
 */
public class UUIDUtils {

	/**
	 * 
	 * getUUID:(获取UUID)
	 *
	 * @return
	 * @author zhangtian
	 */
	public static String getUUID() {
		
		return StringUtils.replace(UUID.randomUUID().toString(), "-", "") ;
	}
	
}
