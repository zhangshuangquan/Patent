package com.codyy.commons.utils;

import java.util.Date;

public class CalculatePayStatus {
	private Date applyDate;
	private Date grentDate;
	public CalculatePayStatus(){}
	public CalculatePayStatus(Date applyDate,Date grentDate){
		this.applyDate=applyDate;
		this.grentDate=grentDate;
		
	
	}                                                                                                                                              
	public CalculatePayStatus(Date applyDate){
		this.applyDate=applyDate;
		this.grentDate=new Date();
		
	}
	public  int calculateYear(){
		
		int year=0;
		
		
		int preY=applyDate.getYear();
		int preM=applyDate.getMonth()+1;
		int preD=applyDate.getDay();
		/*Calendar a=Calendar.getInstance(Locale.CHINA);*/
		
		int nowY=grentDate.getYear();
		int nowM=grentDate.getMonth()+1;
		int nowD=grentDate.getDay();
		System.out.println(nowM);
		if(preY<=nowY){
			year=nowY-preY;
			if(preM>nowM){
				year-=1;
			}else if(preM==nowM){
				if(preD>=nowD){
					year-=1;
				}
			}else{
				
			}
		}else{
			return -1;
		}
		
		return year;
	}
}
