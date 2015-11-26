package com.handpay.ibenefit.product.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.ProductCompanyPrice;
import com.handpay.ibenefit.product.entity.ProductCompanyPriceForm;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.product.service.IProductCompanyPriceManager;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.security.SecurityConstants;

@Controller
@RequestMapping("/productCompanyPrice")
public class ProductCompanyPriceController extends PageController<ProductCompanyPrice>{
    private static final String BASE_DIR = "product/";

    @Reference(version="1.0")
    private IProductCompanyPriceManager productCompanyPriceManager;

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;

    @Reference(version="1.0")
    private ICompanyManager companyManager;

    @Reference(version="1.0")
    private ISkuManager skuManager;

    @Reference(version="1.0")
    private IProductManager productManager;

    @Reference(version="1.0")
    private ICompanyGoodsManager companyGoodsManager;

    @Override
    public Manager<ProductCompanyPrice> getEntityManager() {
        return productCompanyPriceManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);

        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedate"});
            page.setSortOrders(new String[]{"desc nulls last"});
        }
        PageSearch result = productCompanyPriceManager.getCompanyPriceInfo(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, ProductCompanyPrice t) throws Exception {
    	ProductCompanyPriceForm t1 = t.getProductCompanyPriceForm();
    	Long userId = (Long) request.getSession().getAttribute(SecurityConstants.USER_ID);
    	String[] skuIds = request.getParameterValues("skuId");
    	String[] skuCompanyPrices = request.getParameterValues("companyPrice");
    	String[] productIds = request.getParameterValues("productId");
    	Long objectId = t.getObjectId();
    	if ( null != t1) {
    		// 保存面向企业价格信息
    		List<Long> companyIds = new ArrayList<Long>();
    		for (Company company : t1.getCompanies()) {
    			ProductCompanyPrice tempCompany = new ProductCompanyPrice();
    			tempCompany.setCompanyId(company.getObjectId());
    			companyIds.add(company.getObjectId());
    			for (int i = 0; i < skuIds.length; i++) {
    				Double skuCompanyPrice = 0D;
    				Long productId = 0L;
    				Long skuId = Long.parseLong(skuIds[i]);
    				if (StringUtils.isNotBlank(skuCompanyPrices[i])) {
    					skuCompanyPrice = Double.parseDouble(skuCompanyPrices[i]);
    				}
    				if (StringUtils.isNotBlank(productIds[i])) {
    					productId = Long.parseLong(productIds[i]);
    				}
    				ProductCompanyPrice tempSku = new ProductCompanyPrice();
    				tempSku.setCompanyId(tempCompany.getCompanyId());
    				tempSku.setProductId(productId);
    				tempSku.setSkuId(skuId);
    				tempSku.setCompanyPrice(skuCompanyPrice);
    				tempSku.setUpdateUserId(userId);
    				tempSku.setUpdateDate(new Date());
    				if(objectId!=null){
    				    tempSku.setObjectId(objectId);
    				}
    				productCompanyPriceManager.save(tempSku);
    			}
    		}
    		//更新所选企业的SKU价格为最新价格
    		companyGoodsManager.updateCompanySkuPrice(companyIds);
    	}
        return "redirect:page" + getMessage("common.base.success", request);
    }

    @Override
    public String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception {
        if (null != objectId) {
            ProductCompanyPrice entity = getManager().getByObjectId(objectId);
            Long companyId = entity.getCompanyId();
            Long skuId = entity.getSkuId();
            Company company = companyManager.getByObjectId(companyId);
            Sku sku = skuManager.getByObjectId(skuId);
            Product product = productManager.getByObjectId(sku.getProductId());
            request.setAttribute("company", company);
            request.setAttribute("product", product);
            request.setAttribute("sku", sku);
            request.setAttribute("entity", entity);
        }
        return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
    }
}
