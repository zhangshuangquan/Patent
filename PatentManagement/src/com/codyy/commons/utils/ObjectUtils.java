package com.codyy.commons.utils;

import java.util.Random;

public class ObjectUtils {

	/**
	 * 随机生成6位数字
	 * 
	 * @Date:2014年8月4日 下午3:37:37
	 * @Author:wangqiqi
	 * @return
	 * @throws
	 */
	public static String getRandomPwd() {
		Random random = new Random();
		String result = "";
		for (int i = 0; i < 6; i++) {
			result += random.nextInt(10);
		}
		return result;
	}
}