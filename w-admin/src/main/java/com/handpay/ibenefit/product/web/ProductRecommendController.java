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

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.entity.ProductRecommend;
import com.handpay.ibenefit.category.entity.ProductRecommentForm;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.category.service.IProductRecommendManager;
import com.handpay.ibenefit.framework.entity.ForeverEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;

/**
 * @Title: ProductRecommendRelevantController.java
 * @Package com.handpay.ibenefit.product.web
 * @Description: TODO Copyright: Copyright (c) 2015
 *
 * @author Mac.Yoon
 * @date 2015年5月19日 下午8:42:35
 * @version V1.0
 */
@Controller
@RequestMapping("productRecommend")
public class ProductRecommendController extends
		PageController<ProductRecommend> {

	@Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;

	@Reference(version = "1.0")
	private IProductRecommendManager productRecommendManager;

	@Override
	public Manager<ProductRecommend> getEntityManager() {
		return productRecommendManager;
	}

	@Override
	public String getFileBasePath() {
		return "product/";
	}

	/*
	@RequestMapping(value = "/page")
	public String page(HttpServletRequest request, ProductRecommend t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		String result = super.handlePage(request, page);
		afterPage(request, page,backPage);
		return result;
	}
	*/
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		if(ForeverEntity.class.isAssignableFrom(page.getEntityClass())){
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQI_deleted",ForeverEntity.DELETED_NO + ""));
		}
		 //所有的一级分类
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);

        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"createdOn"});
            page.setSortOrders(new String[]{"desc nulls last"});
        }
		PageSearch result = productRecommendManager.findList(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}

	@RequestMapping(value = "/deleteRecommends")
	public String deleteRecommends(HttpServletRequest request, ModelMap modelMap)
			throws Exception {
		String idStr = request.getParameter("ids");
		try {
			String[] ids = idStr.split(",");
			for (String id : ids) {
				productRecommendManager.delete(Long.valueOf(id));
			}
			modelMap.put("result", true);
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("result", false);
		}
		return "jsonView";
	}

	@RequestMapping(value = "/saveSortNos")
	public String saveSortNos(HttpServletRequest request, ModelMap modelMap)
			throws Exception {
		String idStr = request.getParameter("ids");
		String sortNoStr = request.getParameter("sortNos");
		try {
			String[] ids = idStr.split(",");
			String[] sortNos = sortNoStr.split(",");
			for (int i = 0; i < ids.length; i++) {
				if(Double.parseDouble(sortNos[i])>0){
					productRecommendManager.updateSortNoByObjectId(ids[i],
							sortNos[i]);
				}

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
			ModelMap modelMap, ProductRecommend t) throws Exception {
		List<ProductRecommentForm> productRecommentForms = t.getProductRecommentForms();
		if (productRecommentForms != null && productRecommentForms.size() > 0) {
			for (ProductRecommentForm productRecommentForm : productRecommentForms) {
				if(productRecommentForm.getProductId()!=null){
					t.setObjectId(null);
					t.setProductId(productRecommentForm.getProductId());
					t.setSortNo(productRecommentForm.getPriority());
					save(t);
				}

			}
		}

		List<ProductRecommentForm> welfarePackageRecommentForms = t.getWelfarePackageRecommentForms();
		if (welfarePackageRecommentForms != null && welfarePackageRecommentForms.size() > 0) {
			for (ProductRecommentForm productRecommentForm : welfarePackageRecommentForms) {
				if(productRecommentForm.getProductId()!=null){
					t.setObjectId(null);
					t.setProductId(productRecommentForm.getProductId());
					t.setSortNo(productRecommentForm.getPriority());
					save(t);
				}
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

}
