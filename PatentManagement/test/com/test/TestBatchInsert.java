package com.test;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Locale;

import org.joda.time.DateTime;

import com.codyy.commons.utils.ImportExcel;
import com.codyy.patentmanagement.front.web.entity.BasePatent;

public class TestBatchInsert {

	public static void main(String[] args) throws NoSuchFieldException, SecurityException, IllegalArgumentException, IllegalAccessException, IOException, ParseException {
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy.MM.dd");
		/*int year;
		int month;
		int day;
		Date date=sdf.parse("2014.01.02");
		Calendar calender =Calendar.getInstance(Locale.CHINA);
		calender.setTime(date);
	
		System.out.println(calender.get(Calendar.DAY_OF_MONTH));
		System.out.println(calender.get(Calendar.MONTH)+1);
		System.out.println(calender.get(Calendar.YEAR));*/
		
		Date date = new Date() ;
		
		DateTime dateTime = new DateTime(date.getTime()) ;
		dateTime = dateTime.plusMonths(1) ;
	
		date = new Date(dateTime.getMillis()) ;
		
		
		/*System.out.println(a.get(a.YEAR));
		System.out.println(a.get(a.MONTH)+1);
		System.out.println(a.get(a.DAY_OF_MONTH));*/
		
		
	}
}
