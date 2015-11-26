package com.handpay.ibenefit.welfare.web;

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
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.welfare.entity.WelfareCompanyPrice;
import com.handpay.ibenefit.welfare.entity.WelfareCompanyPriceForm;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.service.IWelfareCompanyPriceManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("/welfareCompanyPrice")
public class WelfareCompanyPriceController extends PageController<WelfareCompanyPrice>{
    private static final String BASE_DIR = "welfare/";

    @Reference(version="1.0")
    private IWelfareCompanyPriceManager welfareCompanyPriceManager;

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;

    @Reference(version="1.0")
    private ICompanyManager companyManager;

    @Reference(version="1.0")
    private IWelfarePackageManager welfarePackageManager;

    @Reference(version="1.0")
    private ICompanyGoodsManager companyGoodsManager;

    @Override
    public Manager<WelfareCompanyPrice> getEntityManager() {
        return welfareCompanyPriceManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedate"});
            page.setSortOrders(new String[]{"desc nulls last"});
        }
        PageSearch result = welfareCompanyPriceManager.getCompanyPriceInfo(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, WelfareCompanyPrice t) throws Exception {
        WelfareCompanyPriceForm t1 = t.getWelfareCompanyPriceForm();
    	Long userId = (Long) request.getSession().getAttribute(SecurityConstants.USER_ID);
    	String[] packageIds = request.getParameterValues("packageId");
    	String[] companyPrices = request.getParameterValues("companyPrice");
    	String[] familyPrices = request.getParameterValues("familyPrice");
    	Long objectId = t.getObjectId();
    	if (null != t1) {
    		// 保存面向企业价格信息
    		List<Long> companyIds = new ArrayList<Long>();
    		for (Company company : t1.getCompanies()) {
    			companyIds.add(company.getObjectId());
    			for (int i = 0; i < packageIds.length; i++) {
    				Double companyPrice = 0D;
    				Double familyPrice = 0D;
    				Long packageId = Long.parseLong(packageIds[i]);
    				if (StringUtils.isNotBlank(companyPrices[i])) {
    					companyPrice = Double.parseDouble(companyPrices[i]);
    				}
    				if (StringUtils.isNotBlank(familyPrices[i])) {
                        familyPrice = Double.parseDouble(familyPrices[i]);
                    }
    				WelfareCompanyPrice temp = new WelfareCompanyPrice();
    				temp.setCompanyId(company.getObjectId());
    				temp.setPackageId(packageId);
    				temp.setCompanyPrice(companyPrice);
    				temp.setFamilyPrice(familyPrice);
    				temp.setUpdateUserId(userId);
    				temp.setUpdateDate(new Date());
    				if(objectId!=null){
    				    temp.setObjectId(objectId);
    				}
    				welfareCompanyPriceManager.save(temp);
    			}
    		}
    		//更新所选企业的SKU价格为最新价格
    		companyGoodsManager.updateCompanyPackagePrice(companyIds);
    	}
        return "redirect:page" + getMessage("common.base.success", request);
    }

    @Override
    public String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception {
        if (null != objectId) {
            WelfareCompanyPrice entity = getManager().getByObjectId(objectId);
            Long companyId = entity.getCompanyId();
            Long packageId = entity.getPackageId();
            Company company = companyManager.getByObjectId(companyId);
            WelfarePackage welfarePackage = welfarePackageManager.getByObjectId(packageId);
            request.setAttribute("company", company);
            request.setAttribute("welfarePackage", welfarePackage);
            request.setAttribute("entity", entity);
        }
        return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
    }
}
