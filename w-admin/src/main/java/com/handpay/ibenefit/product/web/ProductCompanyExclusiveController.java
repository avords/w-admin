package com.handpay.ibenefit.product.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.ProductCompanyExclusive;
import com.handpay.ibenefit.product.entity.ProductCompanyExclusiveForm;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.product.service.IProductCompanyExclusiveManager;
import com.handpay.ibenefit.product.service.IProductPublishManager;
import com.handpay.ibenefit.security.SecurityConstants;

@Controller
@RequestMapping("/productCompanyExclusive")
public class ProductCompanyExclusiveController extends PageController<ProductCompanyExclusive>{
    private static final String BASE_DIR = "product/";

    @Reference(version="1.0")
    private IProductCompanyExclusiveManager productCompanyExclusiveManager;

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;

    @Reference(version = "1.0")
    private ICompanyGoodsManager companyGoodsManager;

    @Reference(version = "1.0")
    private IProductPublishManager productPublishManager;

    @Override
    public Manager<ProductCompanyExclusive> getEntityManager() {
        return productCompanyExclusiveManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
        // 获取专属商品信息List
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"operatetime"});
            page.setSortOrders(new String[]{"desc nulls last"});
        }
    	PageSearch result  = productCompanyExclusiveManager.getExclusiveProductInfo(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		request.setAttribute("action", "/productCompanyExclusive/page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, ProductCompanyExclusive t) throws Exception {
    	ProductCompanyExclusiveForm t1 = t.getProductCompanyExclusiveForm();
    	Long userId = (Long) request.getSession().getAttribute(SecurityConstants.USER_ID);
    	if (null != t1) {
    		// 保存专属商品信息
    		for (Product product : t1.getProducts()) {
        		ProductCompanyExclusive tempProduct = new ProductCompanyExclusive();
        		tempProduct.setCompanyId(t.getProductCompanyExclusiveForm().getCompanyId());
        		tempProduct.setProductId(product.getObjectId());
        		tempProduct.setOperateUser(userId);
        		tempProduct.setOperateTime(new Date());
        		productCompanyExclusiveManager.save(tempProduct);
        		companyGoodsManager.updateByProductId(product.getObjectId());
    		}

    	}
        return "redirect:page" + getMessage("common.base.success", request);
    }

	@Override
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId) throws Exception {
		ProductCompanyExclusive exclusive = productCompanyExclusiveManager.getByObjectId(objectId);
		productCompanyExclusiveManager.delete(objectId);
		companyGoodsManager.updateByProductId(exclusive.getProductId());
		return "redirect:/productCompanyExclusive/page" + getMessage("common.base.success", request);
	}
}
