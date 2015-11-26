/**
 * @Title: ProductRecommendRelevantController.java
 * @Package com.handpay.ibenefit.product.web
 * @Description: TODO
 * Copyright: Copyright (c) 2015
 * 
 * @author Mac.Yoon
 * @date 2015年5月19日 下午8:42:35
 * @version V1.0
 */
package com.handpay.ibenefit.product.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductRecommendRelevant;
import com.handpay.ibenefit.category.entity.ProductRecommendRelevantForm;
import com.handpay.ibenefit.category.service.IProductRecommendRelevantManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Product;

/**
 * @Title: ProductRecommendRelevantController.java
 * @Package com.handpay.ibenefit.product.web
 * @Description: TODO
 * Copyright: Copyright (c) 2015
 * 
 * @author Mac.Yoon
 * @date 2015年5月19日 下午8:42:35
 * @version V1.0
 */
@Controller
@RequestMapping("productRecommendRelevant")
public class ProductRecommendRelevantController extends PageController<ProductRecommendRelevant>{

	@Reference(version="1.0")
    private IProductRecommendRelevantManager productRecommendRelevantManager;
	
	@Override
	public Manager<ProductRecommendRelevant> getEntityManager() {
		return productRecommendRelevantManager;
	}
	
	@Override
	public String getFileBasePath() {
		return "product/";
	}
	
	@RequestMapping(value = "/deleteRelevances")
	public String deleteRelevances(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String idStr = request.getParameter("ids");
		try {
			String[] ids = idStr.split(",");
			for(String id:ids){
				productRecommendRelevantManager.delete(Long.valueOf(id));
			}
			modelMap.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("result", false);
		}
		return "jsonView";
	}
	
	
	@RequestMapping(value = "/saveProductPrioritys")
	public String saveProductPrioritys(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String idStr = request.getParameter("ids");
		String priorityStr = request.getParameter("prioritys");
		try {
			String[] ids = idStr.split(",");
			String[] prioritys = priorityStr.split(",");
			for(int i= 0; i < ids.length; i++){
				productRecommendRelevantManager.updatePriorityByObjectId(ids[i],prioritys[i]);
			}
			modelMap.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("result", false);
		}
		return "jsonView";
	}

	@Override
	protected String handleSaveToPage(HttpServletRequest request,
			ModelMap modelMap, ProductRecommendRelevant t) throws Exception {
		ProductRecommendRelevantForm productRecommendRelevantForm = t.getProductRecommendRelevantForm();
		if(productRecommendRelevantForm!=null){		
		//相互关联
		if(productRecommendRelevantForm.getIsRelevant()!=null&&ProductRecommendRelevantForm.CHECK_RELEVANCE.equals(productRecommendRelevantForm.getIsRelevant())){
			if(productRecommendRelevantForm.getProducts()!=null){
				for(Product relevanceProduct:productRecommendRelevantForm.getProducts()){
					ProductRecommendRelevant productRecommendRelevant = new ProductRecommendRelevant();
					productRecommendRelevant.setProductId(t.getProductId());
					productRecommendRelevant.setProductName(t.getProductName());
					productRecommendRelevant.setRelevantProductId(relevanceProduct.getObjectId());
					productRecommendRelevant.setRelevantProductName(relevanceProduct.getName());
					save(productRecommendRelevant);
				}
				for(Product relevanceProduct:productRecommendRelevantForm.getProducts()){
					ProductRecommendRelevant productRecommendRelevant = new ProductRecommendRelevant();
					productRecommendRelevant.setProductId(relevanceProduct.getObjectId());
					productRecommendRelevant.setProductName(relevanceProduct.getName());
					productRecommendRelevant.setRelevantProductId(t.getProductId());
					productRecommendRelevant.setRelevantProductName(t.getProductName());
					save(productRecommendRelevant);
				}
			}
		}else{
			//单项关联
			if(productRecommendRelevantForm.getProducts()!=null){
				for(Product relevanceProduct:productRecommendRelevantForm.getProducts()){
					ProductRecommendRelevant productRecommendRelevant = new ProductRecommendRelevant();
					productRecommendRelevant.setProductId(t.getProductId());
					productRecommendRelevant.setProductName(t.getProductName());
					productRecommendRelevant.setRelevantProductId(relevanceProduct.getObjectId());
					productRecommendRelevant.setRelevantProductName(relevanceProduct.getName());
					save(productRecommendRelevant);
				}
			}
		}
		}else{
			return "redirect:/productRecommendRelevant/create";
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

	
}
