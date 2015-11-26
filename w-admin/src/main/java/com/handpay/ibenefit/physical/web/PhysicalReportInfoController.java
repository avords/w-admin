package com.handpay.ibenefit.physical.web;

import java.util.HashMap;
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
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.physical.entity.PhysicalReport;
import com.handpay.ibenefit.physical.entity.PhysicalReportInfo;
import com.handpay.ibenefit.physical.service.IPhysicalReportInfoManager;
import com.handpay.ibenefit.physical.service.IPhysicalReportManager;

@Controller
@RequestMapping("/physicalReportInfo")
public class PhysicalReportInfoController extends PageController<PhysicalReportInfo> {

	private static final String BASE_DIR = "physical/";
	
	@Reference(version = "1.0")
	private IPhysicalReportInfoManager physicalReportInfoManager;
	
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Override
	public Manager<PhysicalReportInfo> getEntityManager() {
		return physicalReportInfoManager;
	}
	
	@Override
	public String getFileBasePath() {
		return BASE_DIR;
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
	
	
	
}
