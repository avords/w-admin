package com.handpay.ibenefit.physical.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.physical.entity.PhysicalAddtionalPackage;
import com.handpay.ibenefit.physical.service.IPhysicalAddtionalPackageManager;

/**
 * 体检套餐加项包
 *
 */
@Controller
@RequestMapping("/physicalAddtional")
public class PhysicalAddtionalPackageController extends PageController<PhysicalAddtionalPackage>{

	private static final Logger LOG = Logger.getLogger(PhysicalAddtionalPackageController.class);
	private static final String BASE_DIR = "physical/";
	
	@Reference(version = "1.0")
	private IPhysicalAddtionalPackageManager physicalAddtionalPackageManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Override
	public Manager<PhysicalAddtionalPackage> getEntityManager() {
		 
		return physicalAddtionalPackageManager;
	}

	@Override
	public String getFileBasePath() {
		 
		return BASE_DIR;
	}
	
	@Override
	public String handlePage(HttpServletRequest request,  PageSearch page) {

		PageSearch pSearch =preparePage(request);
		pSearch = physicalAddtionalPackageManager.findAddtionalPackageList(pSearch);
		page.setTotalCount(pSearch.getTotalCount());
		page.setList(pSearch.getList());
		
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		
		return BASE_DIR + "/listPhysicalAddtionalPackage";
	}
	
	@Override
	@RequestMapping("/create")
	public String create(HttpServletRequest request, HttpServletResponse response, 
			PhysicalAddtionalPackage physicalAddtionalPackage){
		
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("supplierList", supplierList);
	   return BASE_DIR + "createPhysicalAddPackage";
	}
	
	
	@RequestMapping("/savePackage")
	public String savePackage(HttpServletRequest request, HttpServletResponse response, 
			PhysicalAddtionalPackage physicalAddtionalPackage){
		String companyType = request.getParameter("companyType");//0 所有公司，1 选择公司
		String status = request.getParameter("status");//0 失效，1有效
		String[] packageAttrs = request.getParameterValues("packageAttr");
		String[] supplierIds = request.getParameterValues("tjBrand");
		if (StringUtils.isBlank(companyType) && null == physicalAddtionalPackage.getCompanyForms() ) {
			LOG.error("未选择适用公司");
			return "redirect:create/";
		}
		
		if (null == physicalAddtionalPackage.getAddtionalWelfareForms()
				|| null == physicalAddtionalPackage.getMainWelfareForms()) {
			LOG.error("未选择套餐");
			return "redirect:create/";
		}
		
		if(StringUtils.isBlank(status)) {
			status = "1";
		}
		
		physicalAddtionalPackageManager.savePhysicalAddtionalPackage(physicalAddtionalPackage, 
				companyType, Integer.parseInt(status),supplierIds,packageAttrs);
		
	   return "redirect:page";
	}
	
	@RequestMapping("/delAddtional")
	public String deletePhysicalAddtionalPackage(HttpServletRequest request, HttpServletResponse response){
		String objectIds = request.getParameter("objectIdArray");
		 
		if (StringUtils.isNotBlank(objectIds)) {
			physicalAddtionalPackageManager.deletePackage(objectIds);
		}
		 
		return "redirect:page" + getMessage("common.base.success", request);
	}
	
	/**
	 * 体检套餐状态更新，上架 下架
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request) throws Exception {
		String objectIds = request.getParameter("objectIdArray");
		String status = request.getParameter("status");
		
		if (StringUtils.isBlank(status) 
				|| (!status.equals(IBSConstants.EFFECTIVE + "") 
						&& !status.equals(IBSConstants.INVALID + "") )) {
			status = IBSConstants.EFFECTIVE + "";//有效
		}
		
		if (StringUtils.isNotBlank(objectIds)) {
			physicalAddtionalPackageManager.updateStatus(objectIds, Integer.parseInt(status));
		}
		
		return "redirect:page" + getMessage("common.base.success", request);
	}
}
