package com.handpay.ibenefit.product.web;

import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.entity.AbstractEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Brand;
import com.handpay.ibenefit.product.service.IBrandManager;
import com.handpay.ibenefit.product.service.IProductManager;
@Controller
@RequestMapping("/brand")
public class BrandController extends PageController<Brand>{
    @Reference(version="1.0")
    private IBrandManager brandManager;
    @Reference(version="1.0")
    private IFileManager fileManager;
    @Reference(version="1.0")
    private IProductManager productManager;
    @Override
    public Manager<Brand> getEntityManager() {
        return brandManager;
    }

    @Override
    public String getFileBasePath() {
        return "product/";
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, Brand t) throws Exception {
        boolean result = false;
        if(t.getObjectId()!=null){
            Long objectId = t.getObjectId();
            //判断该品牌是否关联有商品
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("brandId", objectId);
            map.put("deleted", 0);
            Long brandCount = productManager.queryCountByParam(map);
            if(brandCount>0&&t.getStatus().equals(IBSConstants.STATUS_NO)){
                return "redirect:edit/" + ((AbstractEntity) t).getObjectId() + getMessage("该品牌有关联的商品，不能置为无效状态", request)
                        + "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action")+"&result="+result;
            }
            Brand brand = brandManager.getByObjectId(objectId);
            if(StringUtils.isNotBlank(t.getLogo())&&!t.getLogo().equals(brand.getLogo())){
                fileManager.deleteFile(brand.getLogo());
            }else if(StringUtils.isBlank(t.getLogo())&&StringUtils.isNotBlank(brand.getLogo())){
                fileManager.deleteFile(brand.getLogo());
            }
        }
        t = save(t);
        result = true;
        return "redirect:edit/" + ((AbstractEntity) t).getObjectId() + getMessage("common.base.success", request)
                + "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action")+"&result="+result;
    }

	@RequestMapping(value = "/brandTemplate")
	public String brandTemplate(HttpServletRequest request,Brand t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(Brand.class.getName(),"EQI_status",IBSConstants.STATUS_YES+""));
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "product/" + "listBrandTemplate";
	}
    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
        handleFind(page);
        request.setAttribute("action", "page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }
    @Override
    public String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception {
        String message = "删除成功!";
      //判断该品牌是否关联有商品
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("brandId", objectId);
        map.put("deleted", 0);
        Long brandCount = productManager.queryCountByParam(map);
        if(brandCount>0){
            message = "该品牌有关联的商品，不能删除!";
        }else{
            delete(objectId);
        }
        return "redirect:../page" + getMessage(message, request) + "&" + appendAjaxParameter(request);
    }
}
