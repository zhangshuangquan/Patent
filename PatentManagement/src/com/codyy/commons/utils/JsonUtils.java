package com.codyy.commons.utils;

import net.sf.json.JSONObject;

/**
 * 
 * ClassName:JsonUtils
 * Function: Json转换处理
 *
 * @author   zhangtian
 * @Date	 2015	Feb 7, 2015		4:14:52 PM
 *
 */
public class JsonUtils {

	/**
	 * 将传入的JAVA对象转换成JSON字符串
	 * 
	 * @param Object
	 *            oo
	 * @return String
	 */
	public static String obj2Json(Object oo) {
		
		return JSONObject.fromObject(oo).toString() ;
	}
}
