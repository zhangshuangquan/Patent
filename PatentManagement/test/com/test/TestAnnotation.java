package com.test;

import java.lang.reflect.Field;

import com.codyy.commons.utils.ExcelDataMapper;
import com.codyy.patentmanagement.front.web.entity.BasePatent;

public class TestAnnotation {
	public static void main(String[] args) {
		Field[] fields=BasePatent.class.getDeclaredFields();
		for(Field field :fields){
			
			ExcelDataMapper edm=field.getAnnotation(ExcelDataMapper.class);
			System.out.println(edm.column());
		}
	}
}
