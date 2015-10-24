package com.codyy.commons.utils;




import java.io.IOException;
import java.io.InputStream;
import java.lang.reflect.Field;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import org.apache.poi.openxml4j.exceptions.InvalidFormatException;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.usermodel.WorkbookFactory;
import com.codyy.commons.utils.ExcelDataMapper;

public class ImportExcel<T> {
	private T clazz;
	private List<T> list;
	private Workbook book;
	private Sheet sheet;
	private Row row;
	private Cell cell;

	/**
	 * 
	 * importData:(excel数据的解析生成list)
	 *
	 * @param in
	 * @param claz
	 * @return
	 * @throws InvalidFormatException
	 * @throws IOException
	 * @throws InstantiationException
	 * @throws IllegalAccessException
	 * @throws NoSuchFieldException
	 * @throws SecurityException
	 * @throws ClassNotFoundException
	 * @author 鲁勇
	 */
	public List<T> importData(InputStream in,Class<?> claz) throws InvalidFormatException, IOException, InstantiationException, IllegalAccessException, NoSuchFieldException, SecurityException, ClassNotFoundException{
		//==============生成工作簿==============//
		book = WorkbookFactory.create(in);
		sheet = book.getSheetAt(0);
		list = new ArrayList<T>();
		//============获取总行数================//
		int numRow = sheet.getLastRowNum();
		
		//================获取第一行============//
		Row firstRow = sheet.getRow(1);
		//=====获取第一行单元格数（即一行的列数）=====//
		int numCell = firstRow.getLastCellNum();
	
		Map<String,Integer> map = new HashMap<String,Integer>(); 
		//==========得到claz的属性数组==========//
		Field[] fields = claz.getDeclaredFields();
	
		/**
		 * 找到注解和第一行中单元格名字相同的，再获取第一行同名单元格的索引
		 * 用于将clazBean中带有注解的属性名                   excel中的列的索引值
		 *         fieldName1 ---------------------2
		 *         fieldName2 ---------------------1
		 *         fieldName3 ---------------------3
		 *         map.put(fieldName1,2)
		 * 在一个Row中通过fieldName1找到excel中索引为2的单元格，方便获取他的值
		**/
		for(Field field:fields){
			
			String fieldMapperName=null;
			if(field.isAnnotationPresent(ExcelDataMapper.class)){
				
				ExcelDataMapper fieldMapper =field.getAnnotation(ExcelDataMapper.class);
				fieldMapperName = fieldMapper.column().trim();
				
				for(int i = 0;i<numCell;i++){
					
					String cellName = firstRow.getCell(i).getStringCellValue();
					if(cellName.equals(fieldMapperName+" *")){
						
						map.put(field.getName(),i);
						break;
					}
				}
			}
		}
		
		/*
		 * 用于将excel中的每一行数据插入到对象中，并添加到list
		 * 
		 * 
		 */
		
		for(int j = 2;j<numRow;j++){
			row = sheet.getRow(j);
			//=======通过反射生成对象========//
			clazz = (T)(claz.newInstance());				
			Iterator<String> iterator =  map.keySet().iterator();
			
				while(iterator.hasNext()){
					
					String fieldName=iterator.next();
					Field field = claz.getDeclaredField(fieldName);
					int index = map.get(fieldName);
					field.setAccessible(true);
					cell = row.getCell(index);
					
					//======判断对象属性类型，再进行类型匹配======//
					
						if(field.getType()==int.class||field.getType()==Integer.class){
							try {
								field.set(clazz,Integer.valueOf(cell.getStringCellValue().trim()));
							} catch (Exception e) {
								field.set(clazz,0);
							}
						}	
							
						if(field.getType()==double.class||field.getType()==Double.class){
							try {
								field.set(clazz,Double.parseDouble(cell.getStringCellValue().trim()));
							} catch (Exception e) {
								field.set(clazz,0);
							}
						}
							
						
						if(field.getType()==float.class||field.getType()==Float.class){
							try {
								field.set(clazz,Float.valueOf(cell.getStringCellValue().trim()));
							} catch (Exception e) {
								field.set(clazz,0f);
							}
						}
							
						
						if(field.getType()==char.class||field.getType()==Character.class){
							try {
								field.set(clazz,cell.getStringCellValue().trim().charAt(0));
							} catch (Exception e) {
								field.set(clazz,'?');
							}
						}
							
						
						if(field.getType()==byte.class){
							try {
								field.set(clazz,cell.getStringCellValue().trim());
							} catch (Exception e) {
								field.set(clazz,0);
							}
						}
							
						if(field.getType()==String.class){
							
							try {
								field.set(clazz,cell.getStringCellValue().trim());
							} catch (Exception e) {
								field.set(clazz,null);
							}
							
						}
						
						if(field.getType()==Date.class){
							//========用于各种表达式的日期类型=======//
							String[] pattern = {"yyyy/MM/dd","yyyy.MM.dd","yyyy-MM-dd","yyyyMMdd"};
							SimpleDateFormat sdf = new SimpleDateFormat();
							Date date = null;
							//========遍历寻找合适的类型匹配=========//
							for(int i=0;i<pattern.length;i++){
								sdf.applyPattern(pattern[i]);
								if(cell==null){
									field.set(clazz,null);
								}else{
									try {
										date = sdf.parse(cell.getStringCellValue().trim());
										field.set(clazz,date);
										//========找到匹配的转换格式跳出=======//
										break;
									} catch (ParseException e) {
										
										continue;
									}
								}
								
							}
							
						}
					}
					
					list.add(clazz);
				}
				
		
		in.close();
		
		return list;
	}
	
}
