package com.codyy.patentmanagement.front.web.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.propertyeditors.CustomDateEditor;
import org.springframework.http.HttpHeaders;
import org.springframework.http.HttpStatus;
import org.springframework.http.MediaType;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.util.StringUtils;
import org.springframework.web.bind.WebDataBinder;
import org.springframework.web.bind.annotation.InitBinder;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.multipart.commons.CommonsMultipartResolver;
import org.springframework.web.servlet.ModelAndView;
import com.codyy.commons.utils.ExcelUtils;
import com.codyy.commons.utils.PatentPage;
import com.codyy.commons.utils.ResultJson;
import com.codyy.patentmanagement.front.web.entity.BasePatent;
import com.codyy.patentmanagement.front.web.entity.BasePatentImport;
import com.codyy.patentmanagement.front.web.entity.JsonResult;
import com.codyy.patentmanagement.front.web.entity.PatentExcelModel;
import com.codyy.patentmanagement.front.web.service.PatentService;

@Controller
@RequestMapping("patent")
public class PatentController {
	@Autowired
	private PatentService patentService;
	
	/**
	 * 对前台传递的Date进行格式化规定
	 * 
	 * @param binder
	 */
	//对前台的数据时间数据做处理
	@InitBinder
	public void initBinder(WebDataBinder binder) {
		SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
		dateFormat.setLenient(false);
		binder.registerCustomEditor(Date.class, new CustomDateEditor(
				dateFormat, true));
	}
	// 得到所有的数据
	@ResponseBody
	@RequestMapping("getlistpage")
	public PatentPage<Map<String,Object>> getListPage(int start, int end) {
		return patentService.getListPage(start, end - start + 1);

	}
	//获取专利列表
	@ResponseBody
	@RequestMapping("searchPatentList")
	public PatentPage<Map<String,Object>> searchPatentList(String applyFromTime,String applyToTime,String status,String applyNum,String applyName,
			String orderType,String authorityFromTime,String authorityToTime,String fromDeadline,String toDeadline,String unpaidStatus, String liveStatus,
			String grantFlagDateFrom, String grantFlagDateTo, int start, int end) {
		return patentService.searchPatentList(applyFromTime, applyToTime, status, applyNum, applyName, orderType, authorityFromTime, authorityToTime, fromDeadline, toDeadline, unpaidStatus,liveStatus, grantFlagDateFrom, grantFlagDateTo, start, end);
		
	}
	
	// 得到所有的数据
	@RequestMapping("getallpatent")
	public String getData(HttpServletRequest request,
			HttpServletResponse response) {
		request.setAttribute("unpaidStatus", request.getSession().getAttribute("unpaidStatus"));
		request.getSession().removeAttribute("unpaidStatus");
		return "admin/dispalypatent";
	}
	
	// 显示专利明细页
	@RequestMapping("showPatentDetailPage")
	public String showPatentDetailPage(HttpServletRequest request, Integer patentId) {
		request.setAttribute("basePatentMap", patentService.getBasePatentById(patentId));
		return "admin/patentDetail";
	}
	
	// 获得专利明细列表
	@ResponseBody
	@RequestMapping("getPatentDetail")
	public List<Map<String, Object>> getPatentDetail(Integer patentId) {
		return patentService.getPatentDetailById(patentId);
	}

	@ResponseBody
	@RequestMapping("getfuzzylistpage")
	public PatentPage<Map<String,Object>> getFuzzyListPage(int start,int end,BasePatent basePatent)
			throws UnsupportedEncodingException {
		return patentService.getFuzzyListPage(start, end - start + 1,basePatent);
	}

	// 删除某条数据
	@ResponseBody
	@RequestMapping("delonepatent")
	public ResultJson delOnePatent(HttpServletRequest request) {
		String applyNum = request.getParameter("applyNum");
		String patentId = request.getParameter("patentId");
		patentService.delOnePatent(applyNum,patentId);
		return new ResultJson(true, "删除成功");
	}

	// 根据某一行编辑数据
	@ResponseBody
	@RequestMapping("editpatent")
	public ResultJson editPatentByCondition(BasePatent basePatent) {
		patentService.setOnePatent(basePatent);
		return new ResultJson(true, "编辑成功");
	}

	// 得到一个专利的信息
	@RequestMapping("getonepatent")
	public String getOnePantent(HttpServletRequest request) {
		String applyNum = request.getParameter("applyNum");
		Integer yearNum = Integer.parseInt(request.getParameter("yearNum"));
		List<BasePatent> list = patentService.getOnePatent(applyNum,yearNum);
		request.setAttribute("list", list);
		
		return "admin/editonepatent";
	}

	// 得到一个准备要缴费专利的信息
	@RequestMapping("getpaypatent")
	public String getPayPatent(HttpServletRequest request) {
		String applyNum = request.getParameter("applyNum");
		Integer yearNum = Integer.parseInt(request.getParameter("yearNum"));
		List<BasePatent> list = patentService.getOnePatent(applyNum,yearNum);
		request.setAttribute("list", list);
		return "admin/editpaypatent";

	}

	// 对缴费的专利进行修改
	@ResponseBody
	@RequestMapping("savepatent")
	public ResultJson updOnePatent(BasePatent basePatent) {
		patentService.updOnePatent(basePatent);
		return new ResultJson(true, "缴费成功");
	}

	// 欢迎页面
	@RequestMapping("welcome")
	public String welcome(HttpServletRequest request) {
		// final List<BaseUser> baseUserList = baseUserService.selectAllUsers();
		//long count = patentService.getPagePayPatentList(0, 5).getTotal();
		PatentPage<Map<String, Object>> page = patentService.searchPatentList(null, null, null, null, null, null, null, null, null, null, "3", "1",null,null, -1, -1);
		request.setAttribute("helloWorld", "欢迎来到专利管理页");
		request.setAttribute("count",page.getTotal()); 
		return "admin/welcome";
	}

	@RequestMapping("index")
	public String index(HttpServletRequest request, String unpaidStatus) {
		request.getSession().setAttribute("unpaidStatus", unpaidStatus);
		return "index";
	}
	
	@RequestMapping("toPayPatent")
	public String toPayPatent(HttpServletRequest request) {
		request.setAttribute("payPatentPageFlag", "pagPatent");
		return "index";
	}

	@RequestMapping("import")
	public String inExcel() {

		return "admin/importExcel";
	}

	// 批量导入功能
	@ResponseBody
	@RequestMapping("batchInsert")
	public ResponseEntity<ResultJson> BatchInsert(
			HttpServletResponse response, HttpServletRequest request)
			throws IOException {
		HttpHeaders headers = new HttpHeaders();  
	    headers.setContentType(MediaType.TEXT_PLAIN); 
		try {
			CommonsMultipartResolver resolver = new CommonsMultipartResolver();
			resolver.setDefaultEncoding("UTF-8");
			resolver.setMaxInMemorySize(1024*1024);
			resolver.setServletContext(request.getSession().getServletContext());
			MultipartHttpServletRequest multiRequest = resolver.resolveMultipart(request);
			Map<String, MultipartFile> filemap = multiRequest.getFileMap();
			
			MultipartFile multiFile = filemap.values().iterator().next();
			InputStream inputStream = multiFile.getInputStream() ;
			List<Object> objectList = new ExcelUtils().importExcelData(inputStream, BasePatentImport.class);
			
			List<BasePatent> patentList = transferObjectToPatent(objectList);
			
			patentService.queryInsert(patentList);
			
			return  new ResponseEntity<ResultJson>(new ResultJson(true),headers, HttpStatus.OK);
		}catch (PatentImportException ex){
			return new ResponseEntity<ResultJson>(new ResultJson(false, ex.getMessage()),headers, HttpStatus.OK);
		}catch (Exception ex){
			ex.printStackTrace();
			String error="导入的数据格式错误,请按照模板要求导入文件!";
			return new ResponseEntity<ResultJson>(new ResultJson(false, error),headers, HttpStatus.OK);
		}
	}
	
	/*
	 * 将导入数据封装到entity中,并验证数据的合法性
	 */
	private List<BasePatent> transferObjectToPatent(List<Object> objectList) throws PatentImportException {
		final List<BasePatent> patentList = new ArrayList<BasePatent>();
		
		if(objectList == null || objectList.size() <= 0) {
			return patentList;
		}
		
		int i = 3;
		
		final Iterator<Object> it = objectList.iterator();
		while(it.hasNext()) {
			
			final SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			
			final BasePatent patent = new BasePatent();
			final BasePatentImport importPatent = (BasePatentImport)it.next();
			final String applyNum = importPatent.getApplyNum();
			
			final  String name = importPatent.getName();
			final  String applyDate = importPatent.getApplyDate();
			
			//final  String totalPay = importPatent.getTotalPay();
			
			final  String grantDate = importPatent.getGrantDate();
			
			final  String grantFlagDate = importPatent.getGrantFlagDate();
			
			final  String patentTypeId = importPatent.getPatentTypeId();
			
			final  String status = importPatent.getStatus();
			
			final  String payStatus = importPatent.getPayStatus();
			
			final  String priorityDate = importPatent.getPriorityDate();
			
			if(StringUtils.isEmpty(applyNum)) {
				throw new PatentImportException("第"+i+"行:申请号不能为空");
			}
			
			if(!checkId(applyNum).isResult()) {
				throw new PatentImportException("第"+i+"行:该申请号已存在");
			}
			
			patent.setApplyNum(applyNum);
			
			if(StringUtils.isEmpty(name)) {
				throw new PatentImportException("第"+i+"行:专利名不能为空");
			}
			patent.setName(name);
			
			if(StringUtils.isEmpty(applyDate)) {
				throw new PatentImportException("第"+i+"行:申请日期不能为空");
			} else {
				try {
					final Date date = sdf.parse(applyDate);
					patent.setApplyDate(date);
				}catch(Exception e) {
					throw new PatentImportException("第"+i+"行:申请日期必须形如:yyyy-MM-dd");
				}
			}
			
			if(StringUtils.isEmpty(grantDate)) {
				throw new PatentImportException("第"+i+"行:授权通知日不能为空");
			} else {
				try {
					final Date date = sdf.parse(grantDate);
					patent.setGrantDate(date);
				}catch(Exception e) {
					throw new PatentImportException("第"+i+"行:授权通知日必须形如:yyyy-MM-dd");
				}
			}
			
			if(!StringUtils.isEmpty(grantFlagDate)) {
				try {
					final Date date = sdf.parse(grantFlagDate);
					patent.setGrantFlagDate(date);
				}catch(Exception e) {
					throw new PatentImportException("第"+i+"行:授权日必须形如:yyyy-MM-dd");
				}
			}
			
			if(StringUtils.isEmpty(patentTypeId)) {
				throw new PatentImportException("第"+i+"行:专利类型编号不能为空");
			} else if (!"1".equals(patentTypeId) && !"2".equals(patentTypeId) && !"3".equals(patentTypeId) ) {
				throw new PatentImportException("第"+i+"行:专利类型编号只能是1,2或3");
			}
			
			patent.setPatentTypeId(Integer.parseInt(patentTypeId));
			
			if(StringUtils.isEmpty(status)) {
				throw new PatentImportException("第"+i+"行:状态不能为空");
			} else {
				if(!"1".equals(status) && !"2".equals(status)) {
					throw new PatentImportException("第"+i+"行:状态必须是1或2");
				}
			}
			
			patent.setStatus(Integer.parseInt(status));
			
			if(StringUtils.isEmpty(payStatus)) {
				throw new PatentImportException("第"+i+"行:已交年数不能为空");
			} else {
				try {
					int intPayStatus = Integer.parseInt(payStatus);
					
					if("1".equals(patentTypeId)) {
						if(intPayStatus > 20) {
							throw new PatentImportException("第"+i+"行:已交年数不能超过20");
						}
					} else {
						if(intPayStatus > 10) {
							throw new PatentImportException("第"+i+"行:已交年数不能超过10");
						}
					}
					
					patent.setPayStatus(intPayStatus);
					
				}catch(NumberFormatException e) {
					throw new PatentImportException("第"+i+"行:已交年数必须是数字");
				}
			}
			
			
			if(!StringUtils.isEmpty(priorityDate)) {
				try {
					final Date date = sdf.parse(priorityDate);
					patent.setPriorityDate(date);
				}catch(Exception e) {
					throw new PatentImportException("第"+i+"行:优先权日必须形如:yyyy-MM-dd");
				}
			}
			/*if(StringUtils.isEmpty(totalPay)) {
				throw new PatentImportException("第"+i+"行:缴费总额不能为空");
			} else {
				try {
					float intTotalPay = Float.parseFloat(totalPay);
					patent.setTotalPay(intTotalPay);
				}catch(Exception e) {
					throw new PatentImportException("第"+i+"行:缴费总额必须是数字");
				}
			}*/
			patent.setTotalPay(0f);
			
			patentList.add(patent);
			
			i ++;
		}
		
		return patentList;
	}
	
	/*
	 * 自定义学校异常
	 */
	private class PatentImportException extends Exception {
		
		private static final long serialVersionUID = 1L;
		
		private String message;
		
		public PatentImportException(String message) {
			this.message = message;
		}

		@Override
		public String getMessage() {
			return message;
		}
		
	}
	
	// Excel导出功能
	@RequestMapping("/exportExcel")
	public ModelAndView viewExcel(HttpServletRequest request,
			HttpServletResponse response,
			@RequestParam("applyNum") String applyNum,
			@RequestParam("name") String name,
			@RequestParam("start") String start,
			@RequestParam("end") String end,
			String liveStatus,
			@RequestParam("status") String status,
			String authorityFromTime,
			String authorityToTime,
			String fromDeadline,
			String toDeadline,
			String unpaidStatus,
			String orderType,
			String grantFlagDateFrom, String grantFlagDateTo) throws Exception {
		/*List<PatentExcelModel> list = patentService.selectByType(applyNum,
				name, start, end, status);*/
		List<PatentExcelModel> list = patentService.getExcelModelList(start, end, status, applyNum, name, orderType, authorityFromTime, authorityToTime, fromDeadline, toDeadline, unpaidStatus, liveStatus, grantFlagDateFrom, grantFlagDateTo,-1, -1);
		Map<String,List<PatentExcelModel>> model = new HashMap<String,List<PatentExcelModel>>();
		model.put("list", list);
		String excelName = "条件查询专利信息表.xls";
		// 设置response方式,使执行此controller时候自动出现下载页面,而非直接使用excel打开
		response.addHeader("Content-Type", "text/html; charset=utf-8");
		response.setContentType("APPLICATION/OCTET-STREAM");
		excelName = new String(excelName.getBytes("gbk"), "iso8859-1");
		response.setHeader("Content-Disposition", "attachment; filename="
				+ excelName);

		return new ModelAndView(new PatentExcelView(), model);
	}
	
	/**
	 * addPatent:进入添加专利页面
	 * @author bingshaowen
	 * @param patentList
	 */
	@RequestMapping("addPatent")
	public String addNewLine() {
		return "admin/addPatent";
	}
	@SuppressWarnings("finally")
	@ResponseBody
	@RequestMapping("addNewPatent")
	public ResultJson addNewPatent(HttpServletRequest request,	BasePatent basePatent) throws java.text.ParseException {
		boolean flag = true;
		ResultJson result = new ResultJson(flag);
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		String applyDate = request.getParameter("applyDate");
		/*
		String name = basePatent.getName();
		try {
			String new_name = new String(name.getBytes("iso-8859-1"), "utf-8");
			basePatent.setName(new_name);
		} catch (UnsupportedEncodingException e1) {
			e1.printStackTrace();
		}*/
		
		Date applyDate1 = sdf.parse(applyDate);
		basePatent.setApplyDate(applyDate1);

		String priorityDate = request.getParameter("priorityDate");
		if (priorityDate.replaceAll(" ", "") != "") {
			Date priorityDate1 = sdf.parse(priorityDate);
			basePatent.setPriorityDate(priorityDate1);
		}
		String grantDate = request.getParameter("grantDate");
		Date grantDate1 = sdf.parse(grantDate);
		basePatent.setGrantDate(grantDate1);
		
		String grantFlagDate = request.getParameter("grantFlagDate");
		
		if(!StringUtils.isEmpty(grantFlagDate)) {
			basePatent.setGrantFlagDate(sdf.parse(grantFlagDate));
		}
		
		try {
			patentService.addNewPatent(basePatent);
		} catch (Exception e) {
			flag = false;
			e.printStackTrace();
		} finally {
			result.setResult(flag);
			if(!flag){
				result.setMessage("专利保存失败！");
			}
			return result;
		}
	}
	
	/**
	 * 检查专利号是否重复
	 * @param applyNum
	 * @return
	 */
	@SuppressWarnings("finally")
	@ResponseBody
	@RequestMapping("checkId")
	public ResultJson checkId(String applyNum) {
		boolean flag = true;
		try {
			flag = patentService.checkId(applyNum);
		} catch (Exception e) {
			flag = false;
		} finally {
			ResultJson result = new ResultJson(flag);
			if (flag == false) {
				String message = "申请号重复";
				result.setResult(flag);
				result.setMessage(message);
				return result;
			}
			return result;
		}
	}

	/**
	 * 
	 * getPagePayPatentList :返回需要缴费的专利信息
	 * @author wuJiaWen
	 * 
	 * */
	@RequestMapping("getPagePayPatentList")
	@ResponseBody
	public PatentPage<Map<String, Object>> getPagePayPatentList(int start,
			int end) {
		return patentService.getPagePayPatentList(start, end);
	}

	/**
	 * 
	 * getInPagePayPatentList:进入需交费专利页面
	 * @author wuJiaWen
	 * 
	 * */
	@RequestMapping("getInDispalyPayPatent")
	public String getIndispalyPayPatent() {
		return "admin/dispalyPayPatent";
	}
	
	/**
	 * getInParameters :进入参数配置页面	 
	 * @author wuJiaWen
	 * */

	@RequestMapping("getInParameters")
	public String getInParameters(HttpServletRequest request) {
		request.setAttribute("patentParameters", patentService.getPatentParameter());
		return "admin/parameters";
	}
	
	/**
	 * getPatentParameter:更新专利的配置参数
	 * @author wuJiaWen
	 * 
	 * */
	@RequestMapping("updateParameters")
	public String updateParameters1(HttpServletRequest req,HttpServletResponse resp){
		int a = 0;
		String payDiscountList[] = req.getParameterValues("payDiscount");
		String patentTypeIdList[] = req.getParameterValues("patentTypeId");
		//String remindTypeList[] = req.getParameterValues("remindType");
		String remindTypeNumList[] = req.getParameterValues("remindTypeNum");
		String remindTypeUnitList[] = req.getParameterValues("remindTypeUnit");
		for(int i=0,j=payDiscountList.length;i<j;i++){
			
			if(patentService.updateParameters(100 - Float.parseFloat(payDiscountList[i]), Integer.parseInt(patentTypeIdList[i]), remindTypeNumList[i]+remindTypeUnitList[i]) != 0){
				a++;
			}
		}
		if(a != 0){
			req.setAttribute("parameter", 1);
		}else{
			req.setAttribute("parameter", 0);
		} 
		
		req.setAttribute("patentParameters", patentService.getPatentParameter());
		return "admin/parameters";
	}
	
	@RequestMapping("importPatentPage")
	public String importPatentPage() {
		return "admin/patentUploadDialog";
	}
	
	@RequestMapping("pay")
	@ResponseBody
	public JsonResult pay(Integer patentId, Integer patentDetailId, Integer yearNum) {
		return new JsonResult(true);
	}
}
