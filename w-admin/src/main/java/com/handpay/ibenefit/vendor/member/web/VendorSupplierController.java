/**
 * @Title: SupplierController.java
 * @Package com.handpay.ibenefit.vendor.member.web
 * @Description: TODO
 * Copyright: Copyright (c) 2015
 * 
 * @author Mac.Yoon
 * @date 2015年5月18日 下午8:51:33
 * @version V1.0
 */
package com.handpay.ibenefit.vendor.member.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierAttach;
import com.handpay.ibenefit.member.entity.SupplierBrand;
import com.handpay.ibenefit.member.entity.SupplierDispatchArea;
import com.handpay.ibenefit.member.entity.SupplierTypes;
import com.handpay.ibenefit.member.service.ISupplierAttachManager;
import com.handpay.ibenefit.member.service.ISupplierBrandManager;
import com.handpay.ibenefit.member.service.ISupplierDispatchAreaManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierTypesManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.service.IUserManager;

/**
 * @Title: SupplierController.java
 * @Package com.handpay.ibenefit.vendor.member.web
 * @Description: TODO Copyright: Copyright (c) 2015
 * 
 * @author Mac.Yoon
 * @date 2015年5月18日 下午8:51:33
 * @version V1.0
 */
@Controller
@RequestMapping("vendorSupplier")
public class VendorSupplierController extends PageController<Supplier> {
	private static final String BASE_DIR = "vendorMember/";

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IUserManager userManager;
	
	@Reference(version = "1.0")
	private ISupplierBrandManager supplierBrandManager;

	@Reference(version = "1.0")
	private ISupplierTypesManager supplierTypesManager;

	@Reference(version = "1.0")
	private ISupplierDispatchAreaManager supplierDispatchAreaManager;
	
	@Reference(version = "1.0")
	private ISupplierAttachManager supplierAttachManager;



	@Override
	public Manager<Supplier> getEntityManager() {
		return supplierManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	/**
	 * 供应商信息维护
	 * 
	 * @param request
	 * @return
	 */
	@RequestMapping("/viewSupplierInfo")
	public String viewCompanyInfo(HttpServletRequest request) {
		Long companyId = (Long) request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID);
		if (null != companyId) {
			Supplier entity = supplierManager.getByObjectId(companyId);
			request.setAttribute("entity", entity);
			
			SupplierTypes supplierType=new SupplierTypes();
			supplierType.setSupplierId(companyId);
			List<SupplierTypes> supplierTypes=supplierTypesManager.getBySample(supplierType);
			if (supplierTypes.size()!=0) {
				String typeIds = "";
				for(SupplierTypes suTypes:supplierTypes){
					typeIds += suTypes.getTypeId() + ",";
				}
				request.setAttribute("typeIds", typeIds);
			}
			
			SupplierBrand supplierBrand=new SupplierBrand();
			supplierBrand.setSupplierId(companyId);
			List<SupplierBrand> supplierBrands=supplierBrandManager.getBySample(supplierBrand);
			request.setAttribute("supplierBrands", supplierBrands);
			
			SupplierDispatchArea supplierDispatchArea=new SupplierDispatchArea();
			supplierDispatchArea.setSupplierId(companyId);
			List<SupplierDispatchArea> supplierDispatchAreas=supplierDispatchAreaManager.getBySample(supplierDispatchArea);
			request.setAttribute("supplierDispatchAreas", supplierDispatchAreas);
			
			SupplierAttach supplierAttach=new SupplierAttach();
			supplierAttach.setSupplierId(companyId);
			List<SupplierAttach> supplierAttachs=supplierAttachManager.getBySample(supplierAttach);
			request.setAttribute("supplierAttachs", supplierAttachs);
		}
		
		
		
		return BASE_DIR+"viewSupplierInfo";
	}
}
