package com.handpay.ibenefit.vendor.member.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.entity.SupplierTypes;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierShopManager;
import com.handpay.ibenefit.member.service.ISupplierTypesManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/vendorSupplierShop")
public class VendorSupplierShopController extends PageController<SupplierShop>{
	private static final String BASE_DIR = "vendorMember/";
	
	@Reference(version = "1.0")
	private ISupplierShopManager supplierShopManager;
	
	@Reference(version = "1.0")
	private ISupplierTypesManager supplierTypesManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private IUserManager userManager;
	
	@Override
	public Manager<SupplierShop> getEntityManager() {
		return supplierShopManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			SupplierShop t) throws Exception {
		Long supplierId = (Long) request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID);
		t.setSupplierId(supplierId);
		t.setUpdatedBy(FrameworkContextUtils.getCurrentUserId());
		t.setUpdatedOn(new Date());
		return super.handleSave(request, modelMap, t);
	}
	
	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		Long supplierId = (Long) request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID);
		if (supplierId!=null) {
			Supplier supplier=supplierManager.getByObjectId(supplierId);
			request.setAttribute("supplierName", supplier.getSupplierName());
			SupplierTypes supplierTypes=new SupplierTypes();
			supplierTypes.setSupplierId(supplierId);
			List<SupplierTypes> supplierTypes2=supplierTypesManager.getBySample(supplierTypes);
			request.setAttribute("supplierTypes", supplierTypes2);
		}
		return super.handleEdit(request, response, objectId);
	}
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		Long supplierId = (Long) request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID);
		User user=new User();
		user.setStatus(IBSConstants.STATUS_YES);
		List<User> users=userManager.getBySample(user);
		request.setAttribute("users", users);
		page.getFilters().add(new PropertyFilter(SupplierShop.class.getName(), "EQL_supplierId", supplierId.toString()));
		return super.handlePage(request, page);
	}
	
	/**
	 * 根据供应商类型获得审核通过的供应商
	 * @param request
	 * @param typeId
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSuppliers/{typeId}")
	public String verifySuccess(HttpServletRequest request,@PathVariable String typeId,ModelMap modelMap) throws Exception {
		SupplierTypes supplierTypes=new SupplierTypes();
		supplierTypes.setTypeId(Integer.parseInt(typeId));
		List<SupplierTypes> supplierTypes2=supplierTypesManager.getBySample(supplierTypes);
		List<Supplier> suppliers=new ArrayList<Supplier>();
		for(SupplierTypes sTypes:supplierTypes2){
			Supplier supplier=supplierManager.getByObjectId(sTypes.getSupplierId());
			if (supplier!=null && supplier.getStatus()==3) {
				suppliers.add(supplier);
			}
		}
		modelMap.addAttribute("suppliers",suppliers);
		return "jsonView";
	}
	
	/**
	 * 批量删除门店
	 * @param request
	 * @param ids
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteAll/{ids}")
	public String deleteAll(HttpServletRequest request,@PathVariable String ids,ModelMap modelMap) throws Exception {
		if (ids!=null) {
			String[] array=ids.split(",");
			for (int i = 0; i < array.length; i++) {
				getEntityManager().delete(Long.parseLong(array[i]));
			}
		}
		modelMap.addAttribute("result",true);
		return "jsonView";
	}
	
}
