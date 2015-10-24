package com.codyy.commons.utils;

public class MD5 {

	/**
	 * 获取MD5后的参数的值
	 * 
	 * @param String
	 * @return String
	 */
	public static String md5(String strtomd5) {
		String s = null;
		try {
			byte[] source = strtomd5.getBytes("utf-8");

			char hexDigits[] = { '0', '1', '2', '3', '4', '5', '6', '7', '8', '9', 'a', 'b', 'c', 'd', 'e', 'f' };// 用来将字节转换成16进制表示的字符

			java.security.MessageDigest md = java.security.MessageDigest.getInstance("MD5");
			md.update(source);
			byte tmp[] = md.digest();
			char str[] = new char[16 * 2];
			int k = 0;
			for (int i = 0; i < 16; i++) {
				// 进制字符的转换
				byte byte0 = tmp[i];
				str[k++] = hexDigits[byte0 >>> 4 & 0xf];
				str[k++] = hexDigits[byte0 & 0xf];
			}
			s = new String(str);// 换后的结果转换为字符串
		} catch (Exception e) {
			e.printStackTrace();
		}
		return s;
	}
}
