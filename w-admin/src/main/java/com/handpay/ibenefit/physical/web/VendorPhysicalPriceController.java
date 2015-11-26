/**    
 * 文件名：PhysicalPriceController.java    
 * 版本信息：    
 * 日期：2015-5-15    
 * Copyright Corporation 2015     
 * 版权所有    IBS
 *    
 */
package com.handpay.ibenefit.physical.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierShopManager;
import com.handpay.ibenefit.physical.entity.PhysicalAudited;
import com.handpay.ibenefit.physical.entity.PhysicalItem;
import com.handpay.ibenefit.physical.entity.PhysicalPrice;
import com.handpay.ibenefit.physical.entity.PhysicalShopRelation;
import com.handpay.ibenefit.physical.service.IPhysicalAuditedManager;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPriceManager;
import com.handpay.ibenefit.physical.service.IPhysicalShopRelationManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

/**    
 *     
 * 项目名称：w-admin    
 * 类名称：VendorPhysicalPriceController    
 * 类描述：    
 * 创建人：liran    
 * 创建时间：2015-5-22 上午9:32:02    
 * 修改人：liran    
 * 修改时间：2015-5-22 上午9:32:02      
 * 修改备注：    
 * @version     
 *     
 */
@Controller
@RequestMapping("/vendorPhysicalPrice")
public class VendorPhysicalPriceController extends PageController<PhysicalPrice> {
	
	private static final String BASE_DIR = "vendorPhysical/";

	@Reference(version = "1.0")
	private IPhysicalPriceManager physicalPriceManager;
	
	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private ISupplierShopManager supplierShopManager;
	
	@Reference(version = "1.0")
	private IPhysicalShopRelationManager physicalShopRelationManager;
	
	@Reference(version = "1.0")
	private IPhysicalAuditedManager physicalAuditedManager;
	
	@Reference(version = "1.0")
	private IUserManager userManager;
	
	@Override
	public Manager<PhysicalPrice> getEntityManager() {
		return physicalPriceManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	
	/**
	 * 体检项目报价page
	 * @param request
	 * @param t
	 * @param backPage 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/page")
	public String page(HttpServletRequest request, PhysicalPrice t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		String supplierId = request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID).toString();
		page.getFilters().add(new PropertyFilter("PhysicalPrice", "EQL_supplierId", supplierId));
		page = physicalPriceManager.queryForPhysicalPricePage(page);
		request.setAttribute("action", "page");
		afterPage(request, page,backPage);
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
	
	/**
	 * 
	 * create 重写create方法，进入报价新增页面
	 * @param   name    
	 * @param  @return    设定文件    
	 * @return String    DOM对象    
	 * @Exception 异常对象    
	 * @since  CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/create")
	public String create(HttpServletRequest request, HttpServletResponse response, PhysicalPrice t) throws Exception {
		String supplierId = request.getSession().getAttribute(SecurityConstants.USER_COMPANY_ID).toString(); 
		 Supplier supplier =  supplierManager.getByObjectId(Long.parseLong(supplierId));
		//取得体检类型供应商列表
		PhysicalItem physicalItem = new PhysicalItem();
		physicalItem.setItemType(2);
		//取得体检二级项目列表
		List<PhysicalItem> physicalItemList = physicalItemManager.getBySample(physicalItem);
		request.setAttribute("physicalItemList", physicalItemList);
		request.setAttribute("supplierId", supplierId);
		request.setAttribute("supplierName", supplier.getSupplierName());
		return getFileBasePath() + "create" + getActualArgumentType().getSimpleName();
	}
	
	/**
	 * 
	 * saveToPage(重写saveTopage，保存供应商报价信息后到报价列表page)    
	 * @param   name    
	 * @param  @return    设定文件    
	 * @return String    DOM对象    
	 * @Exception 异常对象    
	 * @since  CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/saveToPage")
	public String saveToPage(HttpServletRequest request, ModelMap modelMap, PhysicalPrice t) throws Exception {
		String[]  subItemIdArray = request.getParameter("subItemIdArray").split(",");
		String[]  marketPriceArray = request.getParameter("marketPriceArray").split(",");
		String[]  supplierPriceArray = request.getParameter("supplierPriceArray").split(",");
		String[]  shopIdArray = request.getParameter("shopIdArray").split(",");
		String[]  shopNameArray = request.getParameter("shopNameArray").split(",");
		for(int i=0;i<subItemIdArray.length;i++){
			t.setSubItemId(Long.parseLong(subItemIdArray[i]));
			t.setMarketPrice(Double.parseDouble(marketPriceArray[i]));
			t.setSupplierPrice(Double.parseDouble(supplierPriceArray[i]));
			t.setAuditStatus(1);
			t.setStatus(1);
			PhysicalPrice physicalPrice = save(t);
			for(int j=0;j<shopIdArray.length;j++){
				PhysicalShopRelation physicalShopRelation = new PhysicalShopRelation();
				physicalShopRelation.setPriceId(physicalPrice.getObjectId());
				physicalShopRelation.setShopId(Long.parseLong(shopIdArray[j]));
				physicalShopRelation.setShopName(shopNameArray[j]);
				physicalShopRelationManager.save(physicalShopRelation);
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}
	
	/**
	 * 
	 * saveToPage(重写saveTopage，保存供应商报价信息后到报价列表page)    
	 * @param   name    
	 * @param  @return    设定文件    
	 * @return String    DOM对象    
	 * @Exception 异常对象    
	 * @since  CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request, ModelMap modelMap, PhysicalPrice t) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		String[]  marketPriceArray = request.getParameter("marketPriceArray").split(",");
		String[]  supplierPriceArray = request.getParameter("supplierPriceArray").split(",");
		Map<String, Object> param = new HashMap<String, Object>();
		for(int i=0;i<objectIdArray.length;i++){
			param.put("objectId", objectIdArray[i]);
			param.put("marketPrice", marketPriceArray[i]);
			param.put("supplierPrice", supplierPriceArray[i]);
			param.put("auditedStatus", 1);
			physicalPriceManager.updateColumn(param);
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}
	
	/**
	 * 
	 * editToPage(单条编辑供应商报价信息后到报价列表page)    
	 * @param   name    
	 * @param  @return    设定文件    
	 * @return String    DOM对象    
	 * @Exception 异常对象    
	 * @since  CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/editToPage")
	public String editToPage(HttpServletRequest request, ModelMap modelMap, PhysicalPrice t) throws Exception {
		String[]  shopIdArray = request.getParameter("shopIdArray").split(",");
		String[]  shopNameArray = request.getParameter("shopNameArray").split(",");
		PhysicalShopRelation physicalShopRelation = new PhysicalShopRelation();
		physicalShopRelation.setPriceId(t.getObjectId());
		physicalShopRelationManager.deleteBySample(physicalShopRelation);
			for(int j=0;j<shopIdArray.length;j++){
				physicalShopRelation.setPriceId(t.getObjectId());
				physicalShopRelation.setShopId(Long.parseLong(shopIdArray[j]));
				physicalShopRelation.setShopName(shopNameArray[j]);
				physicalShopRelationManager.save(physicalShopRelation);
			}
		save(t);	
		return "redirect:page" + getMessage("common.base.success", request);
	}
	
	
	
	/**
	 * 
	 * edit(重写edit，到报价编辑页面进行编辑)    
	 * @param   name    
	 * @param  @return    设定文件    
	 * @return String    DOM对象    
	 * @Exception 异常对象    
	 * @since  CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/edit/{objectId}")
	public String edit(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			PhysicalPrice entity = physicalPriceManager.getByObjectId(objectId);
			String supplierName = supplierManager.getByObjectId(entity.getSupplierId()).getSupplierName();
			String firstItemName = physicalItemManager.getByObjectId(entity.getSubItemId()).getFirstItemName();
			String secondItemName = physicalItemManager.getByObjectId(entity.getSubItemId()).getSecondItemName();
			PhysicalAudited physicalAudited = new PhysicalAudited();
			physicalAudited.setPriceId(objectId);
			if(physicalAuditedManager.getBySample(physicalAudited).size()>0){
				physicalAudited = physicalAuditedManager.getBySample(physicalAudited).get(0);
			}
			request.setAttribute("physicalAudited", physicalAudited);
			request.setAttribute("supplierName", supplierName);
			request.setAttribute("firstItemName", firstItemName);
			request.setAttribute("secondItemName", secondItemName);
			request.setAttribute("entity", entity);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}
	
	 @RequestMapping(value = "/supplierShop")
		public String supplierShop(HttpServletRequest request,SupplierShop t, Integer backPage) throws Exception {
		 	
		 return "redirect:/supplierShop/getSupplierShop?ajax=1";
		}
	 	
}

