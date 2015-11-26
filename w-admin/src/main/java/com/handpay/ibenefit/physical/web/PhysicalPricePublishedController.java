/**    
 * 文件名：PhysicalPricePublishedController.java    
 * 版本信息：    
 * 日期：2015-5-19    
 * Copyright Corporation 2015     
 * 版权所有    IBS
 *    
 */
package com.handpay.ibenefit.physical.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.physical.entity.PhysicalPricePublished;
import com.handpay.ibenefit.physical.service.IPhysicalPricePublishedManager;

/**    
 *     
 * 项目名称：w-admin    
 * 类名称：PhysicalPricePublishedController    
 * 类描述：    
 * 创建人：liran    
 * 创建时间：2015-5-19 上午11:02:35    
 * 修改人：liran    
 * 修改时间：2015-5-19 上午11:02:35    
 * 修改备注：    
 * @version     
 *     
 */
@Controller
@RequestMapping("/physicalPricePublished")
public class PhysicalPricePublishedController extends PageController<PhysicalPricePublished> {
	
	private static final String BASE_DIR = "physical/";
	
	@Reference(version = "1.0")
	private IPhysicalPricePublishedManager physicalPricePublishedManager;
	
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Override
	public Manager<PhysicalPricePublished> getEntityManager() {
		return physicalPricePublishedManager;
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
	public String page(HttpServletRequest request, PhysicalPricePublished t, Integer backPage) throws Exception {
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("supplierList", supplierList); 
		//按照特定列排序
		PageSearch page  = PageUtils.preparePageWithoutSort(request,PhysicalPricePublished.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("updatedOn");
			page.setSortOrder("asc");
		}
		handleFind(page);
		super.afterPage(request, page,backPage);		
		return super.handlePage(request, page);
	}

}
