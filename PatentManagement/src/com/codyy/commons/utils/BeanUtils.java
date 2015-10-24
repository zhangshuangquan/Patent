package com.codyy.commons.utils;

import java.lang.reflect.InvocationTargetException;
import java.lang.reflect.Method;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.apache.commons.collections.CollectionUtils;
import org.apache.commons.lang.StringUtils;
/**
 * 
 * ClassName:BeanUtils
 * Function: jdbcTemplate框架专用
 * 		Bean  Map映射工具类
 * @author   zhangtian
 * @Date	 2015	Mar 9, 2015		10:10:44 AM
 *
 */
public class BeanUtils {
	
	/**
	 * 
	 * bean2Map:(反射将map映射到bean)
	 *
	 * @param object
	 * @param params
	 * @author zhangtian
	 */
	public static void map2Bean(Object object, Map<String, ? extends Object> params) {
		
			Method[] methods = object.getClass().getDeclaredMethods();
			for (Method method : methods) {
				if (StringUtils.startsWith(method.getName(), "set")) {
					String tempStr = method.getName().substring(3, method.getName().length());
					if (params != null) {
						for (Map.Entry<String, ? extends Object> entry : params.entrySet()) {
							if (StringUtils.equals(StringUtils.lowerCase(tempStr), StringUtils.lowerCase(entry.getKey()))) {
								try {
									method.invoke(object, entry.getValue());
								} catch (IllegalArgumentException e) {
									e.printStackTrace();
								} catch (IllegalAccessException e) {
									e.printStackTrace();
								} catch (InvocationTargetException e) {
									e.printStackTrace();
								}
							}
						}
					}
				}
			}
	}
	
	/**
	 * 
	 * map2Bean:(map转化为bean,置于list)
	 *
	 * @param clazz
	 * @param params
	 * @return
	 * @author zhangtian
	 */
	public static List<?> map2Bean(Class<?> clazz, List<Map<String, Object>> params) {
		
		Object lists = null ;
		try {
			lists = ArrayList.class.newInstance();
			if (CollectionUtils.isNotEmpty(params)) {
				for (Map<String, ? extends Object> maps : params) {
					Object object = clazz.newInstance();
					Method[] methods = object.getClass().getDeclaredMethods();
					for (Method method : methods) {
						if (StringUtils.startsWith(method.getName(), "set")) {
							String tempStr = method.getName().substring(3, method.getName().length());
							if (params != null) {
								for (Map.Entry<String, ? extends Object> entry : maps.entrySet()) {
									if (StringUtils.equals(StringUtils.lowerCase(tempStr), StringUtils.lowerCase(entry.getKey()))) {
										method.invoke(object, entry.getValue());
									}
								}
							}
						}
					}
					
					Method method = lists.getClass().getMethod("add", Object.class) ;
					method.invoke(lists, object) ;
				}
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return (List<?>)lists ;
	}

}
