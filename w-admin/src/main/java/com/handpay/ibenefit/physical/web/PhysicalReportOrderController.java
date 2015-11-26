package com.handpay.ibenefit.physical.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.common.service.IKuaiDi100Service;
import com.handpay.ibenefit.common.service.ISendEmailService;
import com.handpay.ibenefit.common.service.ISendSmsService;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.order.entity.LogisticsCompany;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ILogisticsCompanyManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.other.service.IMessageTemplateManager;
import com.handpay.ibenefit.physical.entity.PhysicalReportInfo;
import com.handpay.ibenefit.physical.service.IPhysicalReportManager;
import com.handpay.ibenefit.physical.service.IPhysicalSubscribeManager;


@Controller
@RequestMapping("/physicalReport")
public class PhysicalReportOrderController extends PageController<SubOrder> {
	
		private static final String BASE_DIR = "physical/";
		Logger logger = Logger.getLogger(PhysicalReportOrderController.class);
		@Reference(version = "1.0")
		private IOrderManager oderManager;
		
		@Reference(version = "1.0")
		private ISubOrderManager subOrderManager;
		
		@Reference(version = "1.0")
		private IPhysicalReportManager physicalReportManager;
		
		@Reference(version = "1.0")
		private IDictionaryManager dictionaryManager;
		
		@Reference(version = "1.0")
		private ILogisticsCompanyManager  logisticsCompanyManager;
		
		@Reference(version = "1.0") 
		private IMessageTemplateManager messageTemplateManager;
		
		@Reference(version = "1.0",async=true)
		private ISendSmsService sendSmsService;
		
		@Reference(version = "1.0",async=true)
		private ISendEmailService sendEmailService;
		
		@Reference(version = "1.0")
		private IPhysicalSubscribeManager physicalSubscribeManager;
		
		@Reference(version = "1.0", check = false,timeout=18000)
		private IOrderManager   orderManager;
		
		@Reference(version = "1.0")
		private IKuaiDi100Service kuaiDiService;
	
		@Override
		public Manager<SubOrder> getEntityManager() {
			return subOrderManager;
		}
	
		@Override
		public String getFileBasePath() {
			return BASE_DIR;
		}
		
		@Override
		protected String handlePage(HttpServletRequest request, PageSearch page) {
			PageSearch page1 = preparePage(request);
			PageSearch result = subOrderManager.findPhysicalReportOrder(page1);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			/*LogisticsCompany logisticsCompany = new LogisticsCompany();*/
		    List<LogisticsCompany> logisticsCompanys = logisticsCompanyManager.getAll();
		    request.setAttribute("logisticsCompanys", logisticsCompanys);
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			return getFileBasePath() + "listPhysicalReport";
		}
		
		@Override
		protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
				throws Exception {
			getManager().delete(objectId);
			return "redirect:../page";
		}
		

		@Override
		protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
				throws Exception {
			return super.handleEdit(request, response, objectId);
		
		}
		
		
		
		@RequestMapping("/importInfo")
		public String importInfo(HttpServletRequest request) {
			return getFileBasePath() + "importInfo";
		}
		
		/**
		 * 
		 * @Title: importPhysicalReport 
		 * @Description: 跳转到上传体检报告页面
		 * @return
		 * @throws 
		 * @author 陈传洞
		 */
		@RequestMapping("/importPhysicalReport")
		public String importPhysicalReport(HttpServletRequest request){
			String cardNum = request.getParameter("cardNum");
			String subOrderId = request.getParameter("subOrderId");
			request.setAttribute("cardNum", cardNum);
			request.setAttribute("subOrderId", subOrderId);
			
			return getFileBasePath() + "importPhysicalReport";
		}
		
		
		/**
		 * 
		 * @Title: uploadPhysicalReport 
		 * @Description: 上传体检报告
		 * @param request
		 * @return
		 * @throws Exception
		 * @throws 
		 * @author 陈传洞
		 */
		@RequestMapping("/uploadPhysicalReport")
		public String uploadPhysicalReport(HttpServletRequest request) throws Exception {
			//上传结果
			String resMsg = "";
			//卡号
			String cardNum = request.getParameter("cardNum");
			String subOrderId = request.getParameter("subOrderId");
			if(StringUtils.isNotBlank(cardNum) && StringUtils.isNotBlank(subOrderId)){
				UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
				byte[] reportFileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
				PhysicalReportInfo physicalReportInfo = physicalReportManager.uploadPhysicalReport(reportFileData, cardNum, uploadFile.getFileName(),Long.valueOf(subOrderId));
				
				if( physicalReportInfo.getObjectId() != null ){
					resMsg = "上传体检报告成功！";
				}
			}
			if(resMsg.length() == 0){
				resMsg = "上传体检报告失败！";
			}
			request.setAttribute("resMsg", resMsg);
			return getFileBasePath() + "importPhysicalReportResult";
		}
		
		@RequestMapping("/uploadInfos")
		public String uploadInfos(HttpServletRequest request) throws Exception {
			UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
			byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
			String result = physicalReportManager.importInfo(fileData,FrameworkContextUtils.getCurrentLoginName());
			request.setAttribute("result", result);
			return getFileBasePath() + "importResult";
		}
		
		/**
		 * 导入的模板
		 * @param request
		 * @param response
		 * @param companyId
		 * @return
		 * @throws Exception
		 */
		@RequestMapping("/exportTemplate")
		public String exportTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
			HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
	        HSSFSheet sheet=wb.createSheet("体检报告物流信息导入模板");
	        CellStyle style = getStyle(wb);
	        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 9);
	        sheet.addMergedRegion(range);
	        Row row0 = sheet.createRow(0);
	        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
	        cell00.setCellStyle(style);
	        cell00.setCellValue("说明：请正确填写如下信息，如‘HR订单账号’‘兑换子订单号’‘操作时间（2015/5/20）’");
	        sheet.autoSizeColumn(0);
	        
	        Row row1 = sheet.createRow(3);
	        
	       /* Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
	        cell0.setCellStyle(style);
	        cell0.setCellValue("物流面单号");
	        sheet.autoSizeColumn(0);*/
	        
	        Cell cell1 = row1.createCell(0, Cell.CELL_TYPE_STRING);
	        cell1.setCellStyle(style);
	        cell1.setCellValue("总订单号");
	        sheet.autoSizeColumn(0);
	        
	        Cell cell2 = row1.createCell(1, Cell.CELL_TYPE_STRING);
	        cell2.setCellStyle(style);
	        cell2.setCellValue("兑换子订单号*");
	        sheet.autoSizeColumn(1);
	        
	        Cell cell3 = row1.createCell(2, Cell.CELL_TYPE_STRING);
	        cell3.setCellStyle(style);
	        cell3.setCellValue("物流公司编号*");
	        sheet.autoSizeColumn(2);
	        
	        Cell cell4 = row1.createCell(3, Cell.CELL_TYPE_STRING);
	        cell4.setCellStyle(style);
	        cell4.setCellValue("物流编号*");
	        sheet.autoSizeColumn(3);
	        
	        
	        
	        
	        
	        Cell cell6 = row1.createCell(4, Cell.CELL_TYPE_STRING);
	        cell6.setCellStyle(style);
	        cell6.setCellValue("更新人");
	        sheet.autoSizeColumn(4);
	        
	        Cell cell7 = row1.createCell(5, Cell.CELL_TYPE_STRING);
	        cell7.setCellStyle(style);
	        cell7.setCellValue("更新时间");
	        sheet.autoSizeColumn(5);
	        
	        
	        Cell cell8 = row1.createCell(6, Cell.CELL_TYPE_STRING);
	        cell8.setCellStyle(style);
	        cell8.setCellValue("操作人");
	        sheet.autoSizeColumn(6);
	        
	        
	        Cell cell9 = row1.createCell(7, Cell.CELL_TYPE_STRING);
	        cell9.setCellStyle(style);
	        cell9.setCellValue("导入时间");
	        sheet.autoSizeColumn(7);
	        
	        String fileName = FileUpDownUtils.encodeDownloadFileName(request, "体检物流信息导入模板" + ".xls");
	        FileUpDownUtils.setDownloadResponseHeaders(response, fileName);
	        wb.write(response.getOutputStream());
			return null;
			
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
		
		@RequestMapping(value = "/updateToPage")
		public String updateToPage(HttpServletRequest request, ModelMap modelMap, SubOrder tt) throws Exception {
			String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
			String[]  logisticsCompanyArray = request.getParameter("logisticsCompanyArray").split(",");
			String[]  logisticsTonoArray = request.getParameter("logisticsTonoArray").split(",");
			if(objectIdArray.length > 0){
				for(int i=0;i<objectIdArray.length;i++){
					Long suborderId = Long.parseLong(objectIdArray[i].trim());
					long userId = FrameworkContextUtils.getCurrentUserId();
					String logisticsNo  = logisticsTonoArray[i].trim();
					String logisticsCompany  = logisticsCompanyArray[i].trim();
					//保存物流信息
					physicalReportManager.savePhysicalReportLogisticsInfo(suborderId, userId, logisticsNo, logisticsCompany);
				}
			}
			return "redirect:page" + getMessage("common.base.success", request);
		}
		
}
