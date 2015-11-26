package com.handpay.ibenefit.physical.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.order.entity.LogisticsCompany;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ILogisticsCompanyManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.physical.entity.PhysicalReport;
import com.handpay.ibenefit.physical.service.IPhysicalReportManager;

@Controller
@RequestMapping("/physicalOrder")
public class PhysicalReportController extends PageController<PhysicalReport> {

	private static final String BASE_DIR = "physical/";
	
	@Reference(version = "1.0")
	private IPhysicalReportManager physicalReportManager;
	
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;
	
	@Reference(version = "1.0")
	private ILogisticsCompanyManager  logisticsCompanyManager;

	@Override
	public Manager<PhysicalReport> getEntityManager() {
		return physicalReportManager;
	}
	
	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		handleFind(page);
		request.setAttribute("action", "page");
		return getFileBasePath() + "listImportInfo";
	}
	
	@Override
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		getManager().delete(objectId);
		 List<LogisticsCompany> logisticsCompanys = logisticsCompanyManager.getAll();
		    request.setAttribute("logisticsCompanys", logisticsCompanys);
		return "redirect:../page";
	}
	

	@Override
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		return super.handleEdit(request, response, objectId);

	}
	
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request, ModelMap modelMap, PhysicalReport t) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		String[]  subOrderNoArray = request.getParameter("subOrderNoArray").split(",");
		String[]  logisticsTonoArray = request.getParameter("logisticsTonoArray").split(",");
		for(int i=0;i<objectIdArray.length;i++){
			SubOrder subOrder  = subOrderManager.getBySubOrderNo(subOrderNoArray[i].trim());
			if(subOrder != null){
				subOrder.setLogisticsNo(logisticsTonoArray[i].trim());
				subOrderManager.save(subOrder);
				t.setObjectId(Long.parseLong(objectIdArray[i].trim()));
				t.setLogisticsNo(logisticsTonoArray[i]);
				save(t);
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}
	
}
