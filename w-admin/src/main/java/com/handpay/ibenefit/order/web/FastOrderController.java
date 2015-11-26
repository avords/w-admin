package com.handpay.ibenefit.order.web;

import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.IOException;
import java.io.InputStream;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.CellRangeAddressList;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.order.entity.LogisticsCompany;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IFastDeliveryManager;
import com.handpay.ibenefit.order.service.ILogisticsCompanyManager;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.Department;

/** 
 * @desc 订单管理-快捷发货处理
 * @author ylan  
 * @date 创建时间：2015年5月18日
 */
@Controller
@RequestMapping("/fastOrder")
public class FastOrderController extends PageController<SubOrder> {
	
	private static final String BASE_DIR = "order/";
	
	@Reference(version = "1.0")
	private IFastDeliveryManager fastDeliveryManager;
	
	@Reference(version = "1.0")
	private ILogisticsCompanyManager logisticsCompanyManager;

	@Override
	public Manager<SubOrder> getEntityManager() {
		return fastDeliveryManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	
	/*
	 * 
	 * 快捷发货 列表页面(重写父类的page)
	 */
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		//登陆人id----（只查询当前登陆人的子订单信息）
		PropertyFilter vendorIdFilter = new PropertyFilter();
		vendorIdFilter.setPropertyName("supplierId");
		Long companyId = (Long)request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID) ;
		vendorIdFilter.setPropertyValue(companyId);
		page.getFilters().add(vendorIdFilter);
		//订单状态----(订单状态1待支付; 2未发货; 3已发货-实物)
		PropertyFilter subOrderStateFilter = new PropertyFilter();
		subOrderStateFilter.setPropertyName("subOrderState");
		subOrderStateFilter.setPropertyValue(2);
		page.getFilters().add(subOrderStateFilter);
		//子订单类型----(子订单类型    实物1：SUB_ORDER_TYPE_PHYSICAL; 虚拟2：SUB_ORDER_TYPE_ELECTRON)
		PropertyFilter subOrderTypeFilter = new PropertyFilter();
		subOrderTypeFilter.setPropertyName("subOrderType");
		subOrderTypeFilter.setPropertyValue(IBSConstants.SUB_ORDER_TYPE_PHYSICAL);
		page.getFilters().add(subOrderTypeFilter) ;
		page.setSortProperty("a.booking_date");
		page.setSortOrder("desc");	
		
		//查询物流公司
		List<LogisticsCompany> companyList = logisticsCompanyManager.queryCompanyList() ;
		request.setAttribute("companyList", companyList);
		
		PageSearch result =  fastDeliveryManager.findVendorOrder(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listFastOrder";
	}
	
	
	/**
	 * 点击确认发货，更新物流信息
	 * @throws IOException 
	 * 
	 */
	@RequestMapping(value = "/updateLogisticsInfo")
	public String updateLogisticsInfo(HttpServletRequest request,HttpServletResponse response,ModelMap map) throws IOException {
		//当前登录人 
		Long userId = 0l;
		if(request.getSession().getAttribute(SecurityConstants.USER_ID)!=null){
			userId = (Long)request.getSession().getAttribute(SecurityConstants.USER_ID);
		}
		
		boolean flag = false ;
 		String subOrderId = request.getParameter("subOrderId") ;//子订单id 
		String company= request.getParameter("logisticsCompany") ;//物流公司
		String no= request.getParameter("logisticsNo") ;//物流编号
		String remark = request.getParameter("remark") ;//备注
		flag = fastDeliveryManager.saveLogisticsInfo(Long.parseLong(subOrderId), company, no, remark, userId) ;
		String success = flag ? "1" : "0" ;
		map.addAttribute("result", success);
		return "jsonView";
	}

	
	
	/**
	 * 导出快捷发货查询的订单
	 * @throws IOException 
	 * 
	 */
//	@RequestMapping(value = "/exportFast")
//	public void exportFast(HttpServletRequest request,
//			HttpServletResponse response) throws IOException {
//		PageSearch page = preparePage(request) ; 
//		//登陆人id----（只查询当前登陆人的子订单信息）
//		PropertyFilter vendorIdFilter = new PropertyFilter();
//		vendorIdFilter.setPropertyName("supplierId");
//		Long companyId = (Long)request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID) ;
//		vendorIdFilter.setPropertyValue(companyId);
//		page.getFilters().add(vendorIdFilter);
//		//订单状态----(订单状态1待支付; 2未发货; 3已发货-实物)
//		PropertyFilter subOrderStateFilter = new PropertyFilter();
//		subOrderStateFilter.setPropertyName("subOrderState");
//		subOrderStateFilter.setPropertyValue(2);
//		page.getFilters().add(subOrderStateFilter);
//		//子订单类型----(子订单类型    实物1：SUB_ORDER_TYPE_PHYSICAL; 虚拟2：SUB_ORDER_TYPE_ELECTRON)
//		PropertyFilter subOrderTypeFilter = new PropertyFilter();
//		subOrderTypeFilter.setPropertyName("subOrderType");
//		subOrderTypeFilter.setPropertyValue(IBSConstants.SUB_ORDER_TYPE_PHYSICAL);
//		page.getFilters().add(subOrderTypeFilter) ;
//		page.setSortProperty("a.booking_date");
//		page.setSortOrder("desc");	
//		//查询物流公司
//		List<LogisticsCompany> logisticsCompanyLists = logisticsCompanyManager.queryCompanyList() ;
//
//		String tempPath = GlobalConfig.getTempDir();
//		File file = fastDeliveryManager.exportSubOrderInfo(page, tempPath, "exportLogisticsInfo.csv","gbk",logisticsCompanyLists) ;
//		try {
//				response.setHeader("content-disposition", "attachment; filename="+ URLEncoder.encode("exportLogisticsInfo", "UTF-8") + ".csv");
//				response.setContentType("application/csv");
//				FileUpDownUtils.downloadFile(file, response);
//		} catch (Exception e) {
//			e.printStackTrace();
//		}
//	}
	
	
	/**
	 * 打开 "导入已发货单号"界面
	 * @param request
	 * @param companyId
	 * @return
	 */
	@RequestMapping("/importOrderDialog")
	public String importOrderDialog(HttpServletRequest request) {
		return getFileBasePath() + "importFastOrder";
	}
	
	
	/**
	 * 导出物流单下载模板
	 * @param request
	 * @param response
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exportTemplate")
	public String exportTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HSSFWorkbook wb = this.makeExportTemplate();
        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("importLogisticsInfo", "UTF-8")+".xls");
		response.setContentType("application/x-msdownload");
        wb.write(response.getOutputStream());
		return null;
	}
	
	
	/**
	 * 
	 * @Title: exportTemplate 
	 * @Description: 物流单导入模板
	 * @param @return
	 * @param @throws Exception     
	 * @return HSSFWorkbook    
	 * @throws 
	 * @author 陈传洞
	 */
	private  HSSFWorkbook makeExportTemplate(){
		//物流公司下拉选择
 		List<LogisticsCompany> logisticsCompanyLists = logisticsCompanyManager.queryCompanyList() ;
 		List<String> dictionaryNames = new ArrayList<String>(logisticsCompanyLists.size());
 		for(LogisticsCompany dic : logisticsCompanyLists){
 			fillFull(dic, logisticsCompanyLists) ;
 			dictionaryNames.add(dic.getCompanyName()+ "[" + dic.getObjectId() + "]");
 		}

		HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
        HSSFSheet sheet=wb.createSheet("物流单批量导入模板");
        CellStyle style = getStyle(wb);
        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 3);
        sheet.addMergedRegion(range);
        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
        cell00.setCellStyle(style);
        cell00.setCellValue("说明：‘订单编号’ ‘物流公司’ ‘物流编号’为必填项，‘备注’为选填项，其他字段可为空");
        sheet.autoSizeColumn(0);
        
        Row row1 = sheet.createRow(3);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("订单编号");
        sheet.setColumnWidth(0, 6000);
        
        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("付款时间");
        sheet.setColumnWidth(1, 6000);
        
        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("商品名称");
        sheet.setColumnWidth(2, 6000);
        
        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("规格");
        sheet.setColumnWidth(3, 6000);
   
        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
        cell4.setCellStyle(style);
        cell4.setCellValue("收货信息");
        sheet.setColumnWidth(4, 6000);
 
        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
        cell5.setCellStyle(style);
        cell5.setCellValue("物流公司");
        sheet.setColumnWidth(5, 6000);
        
        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
        cell6.setCellStyle(style);
        cell6.setCellValue("物流编号");
        sheet.setColumnWidth(6, 6000);
        
        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
        cell7.setCellStyle(style);
        cell7.setCellValue("备注");
        sheet.setColumnWidth(7, 6000);
        
        String[] names = new String[dictionaryNames.size()];
        dictionaryNames.toArray(names);
        HSSFDataValidation dataValidation = setDataValidationList((short)4, (short)32767, (short)5, names );
        sheet.addValidationData(dataValidation);
		return wb;
	}
	
	private void fillFull(LogisticsCompany dic, List<LogisticsCompany> logisticsCompanyLists) {
		if (null != dic) { 
			dic.setCompanyName(Department.PATH_SEPARATOR + dic.getCompanyName());
		}
	}
	

	private CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 设置单元格字体
		Font headerFont = workbook.createFont(); // 字体
		headerFont.setFontHeightInPoints((short) 14);
		headerFont.setColor(HSSFColor.BLACK.index);
		headerFont.setFontName("宋体");
		style.setFont(headerFont);
		style.setWrapText(true);

		// 设置单元格边框及颜色
		style.setBorderBottom((short) 1);
		style.setBorderLeft((short) 1);
		style.setBorderRight((short) 1);
		style.setBorderTop((short) 1);
		style.setWrapText(true);
		return style;
	}
	
	public static HSSFDataValidation setDataValidationList(short firstRow,short endRow, short col, String[] textList){  
        //加载下拉列表内容  
        DVConstraint constraint= DVConstraint.createExplicitListConstraint(textList);  
        //设置数据有效性加载在哪个单元格上。  
          
        //四个参数分别是：起始行、终止行、起始列、终止列  
        CellRangeAddressList regions=new CellRangeAddressList(firstRow,endRow,col,col);  
        //数据有效性对象  
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);  
        return dataValidation;  
    } 
	
	/**
	 * 导入已发货物流单入数据库
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadFastOrder")
	public String uploadFastOrder(HttpServletRequest request) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		Long companyId = (Long)request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID) ;
		//获取数据字典中物流公司数据
 		List<LogisticsCompany> logisticsCompanyLists = logisticsCompanyManager.queryCompanyList() ;
		//当前登录人 
		Long userId = 0l;
		if(request.getSession().getAttribute(SecurityConstants.USER_ID)!=null){
			userId = (Long)request.getSession().getAttribute(SecurityConstants.USER_ID);
		}

		String result = fastDeliveryManager.importLogisticsInfo(fileData, companyId, logisticsCompanyLists,userId) ;
		request.setAttribute("result", result);
		return getFileBasePath() + "importResult";
	}
	
}
