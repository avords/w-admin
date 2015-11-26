package com.handpay.ibenefit.report.web;

import java.util.Date;

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
@RequestMapping("custRunReport")
public class CustRunReportController extends PageController<Report>{
	
	private static final Logger LOGGER = Logger.getLogger(CustRunReportController.class);
	
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
			request.setAttribute("reportId", reportId);
		}
		return getFileBasePath() + "queryCustRunReport";
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
