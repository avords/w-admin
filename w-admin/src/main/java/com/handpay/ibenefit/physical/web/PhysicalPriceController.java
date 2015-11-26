/**    
 * 文件名：PhysicalPriceController.java    
 * 版本信息：    
 * 日期：2015-5-15    
 * Copyright Corporation 2015     
 * 版权所有    IBS
 *    
 */
package com.handpay.ibenefit.physical.web;

import java.text.Collator;
import java.util.Collections;
import java.util.Comparator;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.physical.entity.PhysicalAudited;
import com.handpay.ibenefit.physical.entity.PhysicalItem;
import com.handpay.ibenefit.physical.entity.PhysicalPrice;
import com.handpay.ibenefit.physical.entity.PhysicalPriceForm;
import com.handpay.ibenefit.physical.entity.PhysicalShopRelation;
import com.handpay.ibenefit.physical.service.IPhysicalAuditedManager;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPriceManager;
import com.handpay.ibenefit.physical.service.IPhysicalShopRelationManager;

/**    
 *     
 * 项目名称：w-admin    
 * 类名称：PhysicalPriceController    
 * 类描述：    
 * 创建人：liran    
 * 创建时间：2015-5-15 下午6:32:02    
 * 修改人：liran    
 * 修改时间：2015-5-15 下午6:32:02    
 * 修改备注：    
 * @version     
 *     
 */
@Controller
@RequestMapping("/physicalPrice")
public class PhysicalPriceController extends PageController<PhysicalPrice> {
	
	private static final String BASE_DIR = "physical/";

	@Reference(version = "1.0")
	private IPhysicalPriceManager physicalPriceManager;
	
	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private IPhysicalShopRelationManager physicalShopRelationManager;
	
	@Reference(version = "1.0")
	private IPhysicalAuditedManager physicalAuditedManager;
	
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
		page = physicalPriceManager.queryForPhysicalPricePage(page);
		request.setAttribute("action", "page");
		afterPage(request, page,backPage);
		
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("supplierList", supplierList);
		
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
	
	
	@RequestMapping(value = "/getPhysicalItemsBySupplier/{supplierId}")
	public String getPhysicalItemsBySupplier(HttpServletRequest request,  @PathVariable Long supplierId ,ModelMap map) throws Exception {
		//PhysicalItem physicalItem = new PhysicalItem();
		//physicalItem.setItemType(2);
		Map <String, Object>param = new HashMap<String, Object>();
		param.put("supplierId", supplierId);
		List<PhysicalItem> physicalItemList = physicalItemManager.queryPurePhysicalItemBySupplier(param) ;  
		//request.setAttribute("physicalItemList", physicalItemList);
		map.addAttribute("result", true);
		map.addAttribute(physicalItemList);
		return "jsonView";
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
		/*
		
		Supplier supplier = new Supplier();
		supplier.setCompanyType(5);
		//取得体检类型供应商列表
		List<Supplier> supplierList = supplierManager.getBySample(supplier);
		Collections.sort(supplierList, new Comparator<Supplier>() {
			@Override
			public int compare(Supplier s1, Supplier s2) {
				return Collator.getInstance(Locale.CHINESE).compare(s1.getSupplierName(), s2.getSupplierName());
			}
		});
		PhysicalItem physicalItem = new PhysicalItem();
		physicalItem.setItemType(2);
		//取得体检二级项目列表
		List<PhysicalItem> physicalItemList = physicalItemManager.getBySample(physicalItem);
		request.setAttribute("supplierList", supplierList);
		request.setAttribute("physicalItemList", physicalItemList);
		
		*/
		
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		Collections.sort(supplierList, new Comparator<Supplier>() {
			@Override
			public int compare(Supplier s1, Supplier s2) {
				return Collator.getInstance(Locale.CHINESE).compare(s1.getSupplierName(), s2.getSupplierName());
			}
		});
		request.setAttribute("supplierList", supplierList);
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
	@RequestMapping(value = "/saveToPageList")
	public String saveToPageList(HttpServletRequest request, ModelMap modelMap, PhysicalPriceForm ts) throws Exception {
		String shopIds = request.getParameter("shopIdArray");
		String shopNames = request.getParameter("shopNameArray");
		String supplierId = request.getParameter("supplierId");
		
		String[]  shopNameArray = shopNames.split(",");
		
		for(PhysicalPrice t : ts.getPhysicalPrices()){
			t.setAuditStatus(1);
			t.setStatus(1);
			t.setSupplierId(Long.parseLong(supplierId));
			//添加申请人和申请时间
			t.setApplyPeople(FrameworkContextUtils.getCurrentUserName());
			t.setApplyTime(new Date());
			
			PhysicalPrice physicalPrice = save(t);
			if (StringUtils.isNotEmpty(shopIds)) {
				String[]  shopIdArray = shopIds.split(",");
				if (shopIdArray !=null && shopIdArray.length>0) {
					for(int j=0;j<shopIdArray.length;j++){
						PhysicalShopRelation physicalShopRelation = new PhysicalShopRelation();
						physicalShopRelation.setPriceId(physicalPrice.getObjectId());
						physicalShopRelation.setShopId(Long.parseLong(shopIdArray[j]));
						physicalShopRelation.setShopName(shopNameArray[j]);
						physicalShopRelationManager.save(physicalShopRelation);
					}
				}
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
		String shopIds = request.getParameter("shopIdArray");
		String shopNames = request.getParameter("shopNameArray");
		String[]  shopNameArray = shopNames.split(",");
		PhysicalShopRelation physicalShopRelation = new PhysicalShopRelation();
		physicalShopRelation.setPriceId(t.getObjectId());
		physicalShopRelationManager.deleteBySample(physicalShopRelation);
		if (StringUtils.isNotEmpty(shopIds)) {
			String[]  shopIdArray = shopIds.split(",");
			if (shopIdArray !=null && shopIdArray.length>0) {
				for(int j=0;j<shopIdArray.length;j++){
					physicalShopRelation.setPriceId(t.getObjectId());
					physicalShopRelation.setShopId(Long.parseLong(shopIdArray[j]));
					physicalShopRelation.setShopName(shopNameArray[j]);
					physicalShopRelationManager.save(physicalShopRelation);
				}
			}
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
			PhysicalShopRelation physicalShopRelation = new PhysicalShopRelation();
			physicalShopRelation.setPriceId(objectId);
			List<PhysicalShopRelation> psrList =  physicalShopRelationManager.getBySample(physicalShopRelation);
			request.setAttribute("physicalAudited", physicalAudited);
			request.setAttribute("supplierName", supplierName);
			request.setAttribute("firstItemName", firstItemName);
			request.setAttribute("secondItemName", secondItemName);
			request.setAttribute("entity", entity);
			if (psrList!=null && psrList.size()>0) {
				request.setAttribute("psrList", psrList);
			}else{
				request.setAttribute("psrList", "");
			}
		}
		String readonly = request.getParameter("readonly");
		if(readonly!=null && "1".equals(readonly)){
			return getFileBasePath() + "view" + getActualArgumentType().getSimpleName();
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}
	
	@RequestMapping(value = "/editValidStatus")
	public String editValidStatus(HttpServletRequest request, ModelMap modelMap, PhysicalPrice t) throws Exception {
		//t.setStatus(1); //1有效，2无效
		//physicalPriceManager.save(t);
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("status", 1);
		param.put("objectId", t.getObjectId());
		physicalPriceManager.updateColumn(param);
		return "redirect:page" + getMessage("common.base.success", request);
	}
	 

}

