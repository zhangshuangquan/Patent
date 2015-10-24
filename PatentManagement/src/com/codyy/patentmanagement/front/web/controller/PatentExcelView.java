package com.codyy.patentmanagement.front.web.controller;

import java.lang.reflect.Field; 
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import com.codyy.commons.utils.ExcelDataMapper;
import com.codyy.patentmanagement.front.web.entity.PatentExcelModel;

public class PatentExcelView extends AbstractExcelView {

	private static List<String> columnMap;
	private static Sheet sheet;

	/* (non-Javadoc)
	 * @see org.springframework.web.servlet.view.document.AbstractExcelView#buildExcelDocument(java.util.Map, org.apache.poi.hssf.usermodel.HSSFWorkbook, javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse)
	 */
	@Override
	protected void buildExcelDocument(Map<String, Object> map,
			HSSFWorkbook book, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		columnMap = new ArrayList<String>();
		// ======生成工作簿======//
		sheet = book.createSheet();
		// ======创建第一行=====//
		Row firstRow = sheet.createRow(0);
		// 设置背景色
		HSSFCellStyle setBorder = book.createCellStyle();
		// 设置居中
		setBorder.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
		// 设置字体
		HSSFFont font = book.createFont();
		font.setFontName("宋体");
		font.setFontHeightInPoints((short) 14);// 设置字体大小
		font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);//粗体显示
		setBorder.setFont(font);// 选择需要用到的字体格式
		
		HSSFCellStyle set = book.createCellStyle();
		HSSFFont font2 = book.createFont();
		font2.setFontName("宋体");
		font2.setFontHeightInPoints((short) 11);
		set.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
		set.setFont(font2);
		
		HSSFCellStyle set2 = book.createCellStyle();
		HSSFFont font3 = book.createFont();
		font3.setColor(HSSFColor.RED.index);
		font3.setFontName("宋体");
		font3.setFontHeightInPoints((short) 11);
		set2.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
		set2.setFont(font3);
		
		HSSFCellStyle set3 = book.createCellStyle();
		HSSFFont font4 = book.createFont();
		font4.setColor(HSSFColor.ORANGE.index);
		font4.setFontName("宋体");
		font4.setFontHeightInPoints((short) 11);
		set3.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
		set3.setFont(font4);
		
		HSSFCellStyle set4 = book.createCellStyle();
		HSSFFont font5 = book.createFont();
		font5.setColor(HSSFColor.GREEN.index);
		font5.setFontName("宋体");
		font5.setFontHeightInPoints((short) 11);
		set4.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 居中
		set4.setFont(font5);
		
		
		
		// ======遍历查询到的结果====//
		List<PatentExcelModel> list = (List<PatentExcelModel>) map.get("list");
		Field[] fields = PatentExcelModel.class.getDeclaredFields();// 取出Student1实体类中的所有属性方法
		int length = fields.length;// 得到列的总数
		//System.out.println(length);
		String annotationName;
		for (Field field : fields) {// 遍历属性方法
			// =====得到类中属性有注解的属性注解值
			if (field.isAnnotationPresent(ExcelDataMapper.class)) {
				ExcelDataMapper edm = field
						.getAnnotation(ExcelDataMapper.class);
				annotationName = edm.column().trim();
				columnMap.add(annotationName);
			}
		}
		// 把第一行标题赋进去
		for (int i = 0; i < columnMap.size(); i++) {
			Cell cell = firstRow.createCell(i);
			cell.setCellValue(columnMap.get(i));
			cell.setCellStyle(setBorder);
			sheet.setColumnWidth(i, 4500);
		}
		// =====数据存放对象中======//
		// 遍历Excel中标题下面的所有数据
		//System.out.println(list.size());
		for (int j = 0; j < list.size(); j++) {
			Row row = sheet.createRow(j + 1);
			// 创建每一行
			for (int a = 0; a < columnMap.size(); a++) {
				
			
				if (columnMap.get(a).equals("申请号")) {
					
					formCell(a, row, String.valueOf(list.get(j).getApplyNum()),set);
				} else if (columnMap.get(a).equals("发明名称")) {
					formCell(a, row, list.get(j).getName(),set);
				} else if (columnMap.get(a).equals("申请日")) {
					formCell(a, row, list.get(j).getApplyDate(),set);
				} else if (columnMap.get(a).equals("优先权日")) {
					if(list.get(j).getPriorityDate()==null){
						formCell(a, row,"",set);
					}else{
						formCell(a, row,String.valueOf(list.get(j).getPriorityDate()),set);
					}
				} else if (columnMap.get(a).equals("授权通知日")) {
					formCell(a, row, list.get(j).getGrantDate(),set);
				}else if (columnMap.get(a).equals("授权日")) {
					formCell(a, row, list.get(j).getGrantFlagDate(),set);
				}else if (columnMap.get(a).equals("年费金额")) {
					formCell(a, row,String.valueOf(list.get(j).getPayYear()),set);
				}else  if(columnMap.get(a).equals("缴纳年度")){
					String  status=list.get(j).getStatus();
					//if(status.equals("专利期间内")){
						formCell(a, row,"第"+(Integer.parseInt(list.get(j).getPayAnual()))+"年度",set);
					//}else{
						//formCell(a, row,"专利终止",set);
					//}
					
				}else  if(columnMap.get(a).equals("状态")){
					String  status=list.get(j).getStatus();
					if(status.equals("1")){
						formCell(a, row,"有权",set);
					}else{
						formCell(a, row,"失效",set);
					}
					
				}else if (columnMap.get(a).equals("缴纳绝限")) {
					formCell(a, row, String.valueOf(list.get(j).getPayLimit()),set);
				}else if (columnMap.get(a).equals("缴纳总额")) {
					formCell(a, row, String.valueOf(list.get(j).getTotalPay()),set);
				}else if (columnMap.get(a).equals("缴纳状态")) {
					Integer payStatus = Integer.parseInt(list.get(j).getPayStatus());//已交
					String patentTypeId = list.get(j).getPatentTypeId();//专利类型id
					boolean enablePay = true;
					
					if("1".equals(patentTypeId)) {
						if(payStatus >= 20) {
							enablePay = false;
						}
					} else if ("2".equals(patentTypeId) || "3".equals(patentTypeId)) {
						if(payStatus >= 10) {
							enablePay = false;
						}
					}
					
					
					if ("Y".equals(list.get(j).getCurYearPayFlag())){
						if(!enablePay) {
							formCell(a, row,"本年度已缴费",set4);
						} else {
							formCell(a, row,"本年度已缴费",set);
						}
					}else{
						
						if(!enablePay) {
							formCell(a, row,"本年度未缴费",set4);
						} else if("Y".equals(list.get(j).getExpiredFlag())){
							formCell(a, row,"本年度未缴费",set2);
						}else{
							if("Y".equals(list.get(j).getWarningFlag())){
							formCell(a, row,"本年度未缴费",set3);
							}else{
							formCell(a, row,"本年度未缴费",set);
							}
						}
					}	
				}else if (columnMap.get(a).equals("提醒周期")) {
							//提醒周期
					if (list.get(j).getRemindDate().endsWith("D")) {
						formCell(a,row,String.valueOf(list.get(j).getRemindDate().substring(0,list.get(j).getRemindDate().length() - 1))+ "天",set);
						} else if (list.get(j).getRemindDate().endsWith("M")) {
							formCell(a,row,String.valueOf(list.get(j).getRemindDate().substring(0,list.get(j).getRemindDate().length() - 1))+ "个月",set);
						} else {
							formCell(a, row, null,set);
						}
					}  else {
						formCell(a, row, null,set);
				}
			}
			 for (Cell cell : row) {  
		           if(cell.getCellStyle().equals(set3)){
		        	  for(Cell ce:row){
		        		  ce.setCellStyle(set3);
		        	  }
		           }
		           if(cell.getCellStyle().equals(set2)){
		        	   for(Cell ce:row){
			        		  ce.setCellStyle(set2);
			        	  }
		           }
		           if(cell.getCellStyle().equals(set4)){
		        	   for(Cell ce:row){
			        		  ce.setCellStyle(set4);
			        	  }
		           }
		        }
			
		}
		
		
	}
	private static Cell formCell(int index, Row row, String string, HSSFCellStyle set) {
		HSSFCell cell = (HSSFCell) row.createCell((short) index);// 给第一行填入数据
		cell.setCellValue(string);
		cell.setCellStyle(set);
		return cell;
	}
	
}
