package com.handpay.ibenefit.report.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.ExcelUtil;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.report.entity.Report;
import com.handpay.ibenefit.report.entity.ReportData;
import com.handpay.ibenefit.report.service.IReportDataManager;
import com.handpay.ibenefit.report.service.IReportManager;

@Controller
@RequestMapping("report")
public class ReportController extends PageController<Report>{
	
	private static final Logger LOGGER = Logger.getLogger(ReportController.class);
	
	@Reference(version="1.0",timeout=3600000)
	private IReportManager reportManager;
	
	@Reference(version = "1.0")
	private IReportDataManager reportDataManager;
	
	@Reference(version = "1.0")
	private IFileManager fileManager;
	
	@RequestMapping("runReport")
	public String runReport(HttpServletRequest request, ModelMap modelMap, Date reportDate,Date endDate) throws Exception {
		String reportIds = request.getParameter("reportIds");
		String result = "";
		if(StringUtils.isNotBlank(reportIds) && reportDate !=null){
			String[] ids = reportIds.split(",");
			for(String id : ids){
				try{
					result += reportManager.generateReport(Long.parseLong(id), reportDate,endDate);
				}catch(Exception e){
					LOGGER.error("runReport" + id, e);
				}
			}
		}
		modelMap.put("result", result);
		return "jsonView";
	}
	
	@RequestMapping("downloadReport/{dataId}")
	public String downloadReport(HttpServletRequest request, HttpServletResponse response, @PathVariable Long dataId) throws Exception {
		ReportData reportData = reportDataManager.getByObjectId(dataId);
		if(reportData!=null){
			String fileName = FileUpDownUtils.encodeDownloadFileName(request, reportData.getReportName());
			FileUpDownUtils.setDownloadResponseHeaders(response, fileName);
			byte[] fileData = fileManager.getFile(reportData.getFilePath());
			response.getOutputStream().write(fileData,0,fileData.length);
			response.getOutputStream().flush();
			response.getOutputStream().close();
		}
		return null;
	}
	
	@RequestMapping("queryReport/{reportId}")
	public String queryReport(HttpServletRequest request, HttpServletResponse response, @PathVariable Long reportId) throws Exception {
		if(reportId!=null){
			Report report = reportManager.getByObjectId(reportId);
			if(report!=null){
				PageSearch pageSearch = PageUtils.preparePageWithoutSort(request, ReportData.class);
				pageSearch.getFilters().add(new PropertyFilter("ReportData","EQL_reportId", reportId + ""));
				if(pageSearch.getSortProperty()==null){
					pageSearch.setSortProperty("reportDate");
					pageSearch.setSortOrder("desc");
				}
				pageSearch = reportDataManager.find(pageSearch);
				PageUtils.afterPage(request, pageSearch, PageUtils.IS_NOT_BACK);
			}else{
				report = new Report();
				report.setObjectId(reportId);
				report.setReportName("报表未定义");
			}
			request.setAttribute("report", report);
		}
		return getFileBasePath() + "queryReport";
	}
	
	
	
	
	
	
	/**
	 * 年节订单汇总表
	 * @author zhliu
	 * @date 2015年10月12日
	 * @parm
	 * @param beginDate :下单开始时间
	 * @param endDate	:下单结束时间
	 * @param remark ：卡密备注
	 * @param packageNo ：套餐编号
	 * @return
	 * @throws Exception 
	 * @throws IOException 
	 */
	@RequestMapping("queryReportExOrder")
	public String queryReportExOrder(HttpServletRequest request, HttpServletResponse response,String beginDate,String endDate,String remark,String packageNo) throws IOException, Exception{
		
		
		System.out.println("-----------");
		
		return getFileBasePath() + "queryReportExOrder";
	}
	
	
	
	/**
	 * 导出 年节订单汇总表
	 * @author zhliu
	 * @date 2015年10月12日
	 * @param beginDate :下单开始时间
	 * @param endDate	:下单结束时间
	 * @param remark ：卡密备注
	 * @param packageNo ：套餐编号
	 */
	@RequestMapping("downExOrder")
	public String downExOrder(HttpServletRequest request, HttpServletResponse response,String beginDate,String endDate,String remark,String packageNo) throws IOException, Exception{
		List<Object[]> datas = new ArrayList<Object[]>();
		String[] titles = {"订单来源","订单号","卡号","套餐编号","供应商编号","供应商名称","商品编号","商品名称","数量","商品类型","收货人","企业名称","部门名称","工号","员工姓名","身份证号","手机号码","收货详细地址","下单时间","物流公司","物流编号","订单状态","物流状态","卡密备注","结算状态","付款方式"};
		String exportName = "年节订单汇总表.xls";
		
		exportName =FileUpDownUtils.encodeDownloadFileName(request, exportName);
				
				
				
		Map map = new HashMap();
		map.put("beginDate", beginDate);
		map.put("endDate", endDate);
		if(StringUtils.isNotBlank(remark)){
			map.put("remark", remark);
		}
		map.put("packageNo", packageNo);
		List<Map> list = reportManager.queryReportExOrder(map);
		
		
		for (Map mapTemp : list) {
			Object[] arr = new Object[titles.length];
			if (mapTemp.get("ORDER_SOURCE")!=null) {
				arr[0] = mapTemp.get("ORDER_SOURCE").toString();
			}
			if (mapTemp.get("SUB_ORDER_NO")!=null) {
				arr[1] = mapTemp.get("SUB_ORDER_NO").toString();
			}
			if (mapTemp.get("CASH_CARD")!=null) {
				arr[2] = mapTemp.get("CASH_CARD").toString();
			}
			if (mapTemp.get("PACKAGE_NO")!=null) {
				arr[3] = mapTemp.get("PACKAGE_NO").toString();
			}
			if (mapTemp.get("SUPPLIER_NO")!=null) {
				arr[4] = mapTemp.get("SUPPLIER_NO").toString();
			}
			if (mapTemp.get("SUPPLIER_NAME")!=null) {
				arr[5] = mapTemp.get("SUPPLIER_NAME").toString();
			}
			if (mapTemp.get("SKU_NO")!=null) {
				arr[6] = mapTemp.get("SKU_NO").toString();
			}
			if (mapTemp.get("PRODUCT_NAME")!=null) {
				arr[7] = mapTemp.get("PRODUCT_NAME").toString();
			}
			if (mapTemp.get("PRODUCT_COUNT")!=null) {
				arr[8] = mapTemp.get("PRODUCT_COUNT").toString();
			}
			
			if (mapTemp.get("PRODUCT_TYPE")!=null) {
				arr[9] = mapTemp.get("PRODUCT_TYPE").toString();
			}
			if (mapTemp.get("RECEIPT_CONTACTS")!=null) {
				arr[10] = mapTemp.get("RECEIPT_CONTACTS").toString();
			}
			if (mapTemp.get("COMPANY_NAME")!=null) {
				arr[11] = mapTemp.get("COMPANY_NAME").toString();
			}
			if (mapTemp.get("NAME")!=null) {
				arr[12] = mapTemp.get("NAME").toString();
			}
			if (mapTemp.get("WORK_NO")!=null) {
				arr[13] = mapTemp.get("WORK_NO").toString();
			}
			if (mapTemp.get("USER_NAME")!=null) {
				arr[14] = mapTemp.get("USER_NAME").toString();
			}
			if (mapTemp.get("ID_NUM")!=null) {
				arr[15] = mapTemp.get("ID_NUM").toString();
			}
			if (mapTemp.get("RECEIPT_MOBLIE")!=null) {
				arr[16] = mapTemp.get("RECEIPT_MOBLIE").toString();
			}
			if (mapTemp.get("RECEIPT_ADDRESS")!=null) {
				arr[17] = mapTemp.get("RECEIPT_ADDRESS").toString();
			}
			
			if (mapTemp.get("BOOKING_DATE")!=null) {
				arr[18] = mapTemp.get("BOOKING_DATE").toString();
			}
			if (mapTemp.get("LC_COMPANY_NAME")!=null) {
				arr[19] = mapTemp.get("LC_COMPANY_NAME").toString();
			}
			if (mapTemp.get("LOGISTICS_NO")!=null) {
				arr[20] = mapTemp.get("LOGISTICS_NO").toString();
			}
			if (mapTemp.get("SUB_ORDER_STATE")!=null) {
				arr[21] = mapTemp.get("SUB_ORDER_STATE").toString();
			}
			if (mapTemp.get("LOGISTICS_STATE")!=null) {
				arr[22] = mapTemp.get("LOGISTICS_STATE").toString();
			}
			if (mapTemp.get("REMARK")!=null) {
				arr[23] = mapTemp.get("REMARK").toString();
			}
			if (mapTemp.get("SETTLEMENT_STATE")!=null) {
				arr[24] = mapTemp.get("SETTLEMENT_STATE").toString();
			}
			if (mapTemp.get("PAYMENT_WAY")!=null) {
				arr[25] = mapTemp.get("PAYMENT_WAY").toString();
			}
			datas.add(arr);
		}
		

		ExcelUtil excelUtil = new ExcelUtil();
		excelUtil.exportExcel(response, datas, titles, exportName);
		
		
		return null;
	}
	
	
	
	
	
	
	
	
	
	
	

	@Override
	public Manager<Report> getEntityManager() {
		return reportManager;
	}

	@Override
	public String getFileBasePath() {
		return "report/";
	}

}
