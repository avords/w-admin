/**    
 * 文件名：PhysicalAuditedController.java    
 * 版本信息：    
 * 日期：2015-5-18    
 * Copyright Corporation 2015     
 * 版权所有    IBS
 *    
 */
package com.handpay.ibenefit.physical.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.beans.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.news.entity.Advert;
import com.handpay.ibenefit.physical.entity.PhysicalAudited;
import com.handpay.ibenefit.physical.entity.PhysicalPrice;
import com.handpay.ibenefit.physical.entity.PhysicalPricePublished;
import com.handpay.ibenefit.physical.service.IPhysicalAuditedManager;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPriceManager;
import com.handpay.ibenefit.physical.service.IPhysicalPricePublishedManager;
import com.handpay.ibenefit.security.SecurityConstants;

/**    
 *     
 * 项目名称：w-admin    
 * 类名称：PhysicalAuditedController    
 * 类描述：    
 * 创建人：liran    
 * 创建时间：2015-5-18 上午11:28:33    
 * 修改人：liran    
 * 修改时间：2015-5-18 上午11:28:33    
 * 修改备注：    
 * @version     
 *     
 */
@Controller
@RequestMapping("/physicalAudited")
public class PhysicalAuditedController extends PageController<PhysicalAudited>{
	
	private static final String BASE_DIR = "physical/";
	
	@Reference(version = "1.0")
	private IPhysicalAuditedManager physicalAuditedManager;
	
	@Reference(version = "1.0")
	private IPhysicalPriceManager physicalPriceManager;
	
	@Reference(version = "1.0")
	private IPhysicalPricePublishedManager physicalPricePublishedManager;
	
	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Override
	public Manager<PhysicalAudited> getEntityManager() {
		return physicalAuditedManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	
	
	/**
	 * 体检项目报价审核page
	 * @param request
	 * @param t
	 * @param backPage 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auditedPage")
	public String auditedPage(HttpServletRequest request, PhysicalPrice t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter("PhysicalPrice", "NEI_exclusiveAuditStatus", "2"));
		page = physicalPriceManager.queryForPhysicalPricePage(page);
		request.setAttribute("action", "page");
		afterPage(request, page,backPage);
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("supplierList", supplierList);
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
	
	/**
	 *  审核报价，并返回到审核page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/auditedToPage/{auditedStatus}")
	public String auditedToPage(HttpServletRequest request, @PathVariable int auditedStatus) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		Map<String, Object> param = new HashMap<String, Object>();
			//批处理更新审核状态
			for (int i = 0; i < objectIdArray.length; i++) {
				if(objectIdArray[i]!=null && ! ("").equals(objectIdArray[i])){
					param.put("objectId", objectIdArray[i]);
					param.put("auditedStatus", auditedStatus);
					//需求改变为：审核不通过时，状态改为无效。
					if(auditedStatus==3){
						param.put("status",2 );
					}
					
				}
				physicalPriceManager.updateColumn(param);
				PhysicalAudited physicalAudited = new PhysicalAudited();
				physicalAudited.setPriceId(Long.parseLong(objectIdArray[i]));
				physicalAudited.setAuditedTime(new Date());
				physicalAudited.setIsPassed(auditedStatus);
				physicalAudited.setAuditedPerson(Long.parseLong((request.getSession().getAttribute(SecurityConstants.USER_ID).toString())));
				//如果审核通过，插入报价信息发布表
				if(auditedStatus==2){
					PhysicalPrice physicalPrice =  physicalPriceManager.getByObjectId(Long.parseLong(objectIdArray[i]));
					PhysicalPricePublished entity = new PhysicalPricePublished();
					BeanUtils.copyProperties(physicalPrice, entity);
					entity.setFirstItemName(physicalItemManager.getByObjectId(entity.getSubItemId()).getFirstItemName());
					entity.setSecondItemName(physicalItemManager.getByObjectId(entity.getSubItemId()).getSecondItemName());
					entity.setSupplierName(supplierManager.getByObjectId(entity.getSupplierId()).getSupplierName());
					//如果申请通过，无效变成有效
					entity.setStatus(1);
					physicalPricePublishedManager.deleteBySample(entity);
					physicalPricePublishedManager.save(entity);
					//同步更新IBS_PHYSICAL_PRICE
					Map<String,Object> map = new HashMap<String,Object>();
					map.put("status", 1);
					map.put("objectId", objectIdArray[i]);
					physicalPriceManager.updateColumn(map);
					
				}else if(auditedStatus==3){
					physicalAudited.setRejectReason(request.getParameter("rejectReason"));//审核不通过，插入不通过原因
				}
				physicalAuditedManager.save(physicalAudited);//保存审核记录
			}
			return "redirect:../auditedPage"  + getMessage("common.base.success", request);
	}
	
	@RequestMapping("getStatus")
	public String getStatus(HttpServletRequest request, HttpServletResponse response,ModelMap map) {
        String objectIds  =  request.getParameter("objectIds");
        int flag  = 1;
        if(StringUtils.isNotBlank("objectIds")){
        	String[]  objectIdArray = objectIds.split(",");
        	for (int i = 0; i < objectIdArray.length; i++) {
        		Long objectId = Long.parseLong(objectIdArray[i]);
        		PhysicalPrice price =  physicalPriceManager.getByObjectId(objectId);
        		if(price.getAuditStatus()!=1){
        			flag = 0;
        		}
        	}
        }
        map.put("flag", flag);
        return "jsonView";
    }
	
	
}
