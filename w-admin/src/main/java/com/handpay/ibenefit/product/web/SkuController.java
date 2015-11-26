package com.handpay.ibenefit.product.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.ss.formula.functions.T;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.entity.SkuCheck;
import com.handpay.ibenefit.product.entity.SkuPriceHistory;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.product.service.IProductPublishManager;
import com.handpay.ibenefit.product.service.ISkuCheckManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.product.service.ISkuPriceHistoryManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.SecurityConstants;

@Controller
@RequestMapping("/sku")
public class SkuController extends PageController<Sku>{

    @Reference(version="1.0")
    private ISkuManager skuManager;
    @Reference(version="1.0")
    private ISkuPublishManager skuPublishManager;
    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;
    @Reference(version="1.0")
    private ISkuCheckManager skuCheckManager;
    @Reference(version="1.0")
    private ISkuPriceHistoryManager skuPriceHistoryManager;
    @Reference(version="1.0")
    private IProductManager productManager;
    @Reference(version="1.0")
    private IProductPublishManager productPublishManager;

    @Override
    public Manager<Sku> getEntityManager() {
        return skuManager;
    }

    @Override
    public String getFileBasePath() {
        return "product/";
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        //所有的一级分类
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
        //链接供应商表
        //链接商品主表
        String isGroup = request.getParameter("isGroup");
        PageSearch result = null;
        page.getFilters().add(new PropertyFilter(Sku.class.getName(),"EQI_platform","1"));
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(null);
            page.setSortOrders(null);
        }
        if(StringUtils.isNotBlank(isGroup)){
            //查询整组
            result = skuManager.findSkuByGroup(page);
        }{
            //直接查询sku
            result = skuManager.findSkuDirect(page);
        }
        page.setTotalCount(result.getTotalCount());
        List<Sku> skus = result.getList();
        for(Sku s:skus){
            Long categoryId = s.getCategoryId();
            ProductCategory p = productCategoryManager.getByObjectId(categoryId);
            p = productCategoryManager.getThirdCategoryByThirdId(p.getThirdId());
            s.setCategory(p);
        }
        page.setList(skus);
        request.setAttribute("action", "page");
        request.getSession().setAttribute("action", "/sku/page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }
    @RequestMapping("/returnGoods")
    public String returnGoodsPage(HttpServletRequest request, T t, Integer backPage){
        PageSearch page  = preparePage(request);
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
        String result = handlePage(request, page);
        result = getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"ReturnGoods";
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/returnGoods");
        return result;
    }

    @RequestMapping("/setReturnGoods")
    public String setReturnGoods(HttpServletRequest request, HttpServletResponse response){
        String message = "操作成功";
        String valueStr = request.getParameter("value");
        String skuIdsStr = request.getParameter("skuIds");
        if(StringUtils.isNotBlank(valueStr)&&StringUtils.isNotBlank(skuIdsStr)){
            Integer value = Integer.parseInt(valueStr);
            String[] skuIds = skuIdsStr.split(",");
            for(String skuId:skuIds){
                Long objectId = Long.parseLong(skuId);
                Map<String,Object> map = new HashMap<String,Object>();
                map.put("returnGoods", value);
                map.put("objectId", objectId);
                Sku sku = skuManager.getByObjectId(objectId);
                if((sku.getType().equals(ProductConstants.PRODUCT_TYPE_ELECTRONICS_CARD))&&value.equals(IBSConstants.STATUS_YES)){
                    message = "一部分商品操作失败,虚拟商品不能退换货";
                    break;
                }else if(sku.getCheckStatus()<ProductConstants.PRODUCT_STATUS_WAIT_SALE){
                    message = "审核未通过的商品不能退换货";
                    break;
                }
                skuManager.updateSku(map);
            }
        }else{
            message = "操作失败，你没有选择任何商品";
        }
        return "redirect:/sku/returnGoods"+getMessage(message, request)
                + "&" + appendAjaxParameter(request);
    }

    @RequestMapping("/checkPage")
    public String checkPage(HttpServletRequest request, T t, Integer backPage){
        PageSearch page  = preparePage(request);
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
//        String checkStatus = request.getParameter("search_EQI_checkStatus");
//        if(StringUtils.isBlank(checkStatus)){
//            page.getFilters().add(new PropertyFilter(Sku.class.getName(),"EQI_checkStatus",ProductConstants.PRODUCT_STATUS_WAIT_CHECK+""));
//            request.setAttribute("search_EQI_checkStatus", ProductConstants.PRODUCT_STATUS_WAIT_CHECK);
//
//        }
        String isSearch = request.getParameter("isSearch");
        //查询商品审核PM表得到list
        if(!SecurityConstants.SUPER_MANAGER.equals(FrameworkContextUtils.getCurrentLoginName())){
            page.getFilters().add(new PropertyFilter(Sku.class.getName(),"EQI_auditorId",FrameworkContextUtils.getCurrentUserId().toString()));
        }
        if(StringUtils.isBlank(isSearch)){
            isSearch = "2";
        }
        if("2".equals(isSearch)){
            page.getFilters().add(new PropertyFilter(Sku.class.getName(),"EQI_checkStatus","2"));
            request.setAttribute("search_EQI_checkStatus", ProductConstants.PRODUCT_STATUS_WAIT_CHECK);
        }
        request.setAttribute("isSearch", isSearch);
        String result = handlePage(request, page);
        result = getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"Check";
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/checkPage");
        return result;
    }

    @RequestMapping("/upProduct")
    public String upProduct(HttpServletRequest request, HttpServletResponse response){
        //只有状态为带上架或者已下架的商品才能上架
        String message = "上架成功";
        String skuIdsStr = request.getParameter("skuIds");
        if(StringUtils.isNotBlank(skuIdsStr)){
            String[] skuIds = skuIdsStr.split(",");
            List<Long> ids = new ArrayList<Long>();
            for(String id:skuIds){
                Long objectId = Long.parseLong(id);
                Sku sku = skuManager.getByObjectId(objectId);
                Integer status = sku.getCheckStatus();
                if(sku.getStock().longValue()<=0){
                    message = "上架失败，必须有库存才能进行上架操作";
                    break;
                }else if( status.equals(ProductConstants.PRODUCT_STATUS_WAIT_SALE)|| status.equals(ProductConstants.PRODUCT_STATUS_NOT_SALE)){
                	ids.add(objectId);
                }else {
                    message = "上架失败，只有状态为待上架和已下架的商品才能上架";
                    break;
                }
            }
            //上架
            if(ids.size()>0){
            	skuManager.upProducts(ids);
            }
        }else{
            message = "上架失败，你未选择任何商品";
        }
        return "redirect:"+request.getSession().getAttribute("action")+getMessage(message, request);
    }

    @RequestMapping("/downProduct")
    public String downProduct(HttpServletRequest request, HttpServletResponse response){
        //只有状态为带上架或者已下架的商品才能上架
        String message = "下架成功";
        String skuIdsStr = request.getParameter("skuIds");
        if(StringUtils.isNotBlank(skuIdsStr)){
            String[] skuIds = skuIdsStr.split(",");
            List<Long> ids = new ArrayList<Long>();
            for(String id:skuIds){
                Long objectId = Long.parseLong(id);
                Sku sku = skuManager.getByObjectId(objectId);
                Integer status = sku.getCheckStatus();
                if(status.equals(ProductConstants.PRODUCT_STATUS_IN_SALE)){
                    ids.add(objectId);
                }else{
                    message = "下架失败，只有状态为已上架的商品才能下架";
                    break;
                }
            }
            //下架
            if(ids.size()>0){
            	 skuManager.executeDownProducts(ids);
            }
        }else{
            message = "下架失败，你未选择任何商品";
        }
        return "redirect:"+request.getSession().getAttribute("action")+getMessage(message, request);
    }

    @RequestMapping("/deleteProduct")
    public String deleteProduct(HttpServletRequest request, HttpServletResponse response){
        //只有状态为带上架或者已下架的商品才能上架
        String message = "删除成功";
        String skuIdsStr = request.getParameter("skuIds");
        if(StringUtils.isNotBlank(skuIdsStr)){
            String[] skuIds = skuIdsStr.split(",");
            for(String id:skuIds){
                Long objectId = Long.parseLong(id);
                Sku sku = skuManager.getByObjectId(objectId);
                Integer status = sku.getCheckStatus();
                if(status.equals(ProductConstants.PRODUCT_STATUS_DRAFT)){
                    delete(objectId);
                }else{
                    message = "删除失败，只有为草稿状态才能删除";
                    break;
                }
            }
        }else{
            message = "删除失败，你未选择任何商品";
        }
        return "redirect:"+request.getSession().getAttribute("action")+getMessage(message, request);
    }

    @RequestMapping(value = "/checkPass/{skuId}")
    public String checkPass(HttpServletRequest request, HttpServletResponse response, @PathVariable Long skuId,ModelMap map) throws Exception {
        boolean result = true;
        String message = "操作成功!";
        //更改sku状态
        Sku sku = skuManager.getByObjectId(skuId);
        if(!sku.getCheckStatus().equals(ProductConstants.PRODUCT_STATUS_WAIT_CHECK)){
            message = "操作失败，不在待审核状态!";
            result = false;
        }else{
            //记录sku审核历史
            SkuCheck sc = new SkuCheck();
            sc.setProductId(sku.getProductId());
            sc.setSkuId(skuId);
            sc.setExamineDate(new Date());
            sc.setExamineUserId(FrameworkContextUtils.getCurrentUserId());
            skuManager.executeCheck(skuId, ProductConstants.PRODUCT_STATUS_WAIT_SALE, sc);
            //判断是否为立即发布，如果为立即发布，则上架
            Product product = productManager.getByObjectId(sku.getProductId());
            if(product.getImmediateRelease().equals(IBSConstants.STATUS_YES)){
                if(sku.getStock()>0){
                	List<Long> skuIds = new ArrayList<Long>();
                	skuIds.add(skuId);
                	skuManager.upProducts(skuIds);
                }
            }
        }
        map.put("result", result);
        map.put("message", message);
        return "jsonView";
    }
    @RequestMapping(value = "/checkNotPass/{skuId}")
    public String checkNotPass(HttpServletRequest request, HttpServletResponse response,@PathVariable Long skuId) throws Exception {
        request.setAttribute("skuId", skuId);
        return getFileBasePath()+"checkSku";
    }

    @RequestMapping(value = "/saveCheckReason")
    public String saveCheckReason(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = false;
        Long skuId = Long.parseLong(request.getParameter("skuId"));
        String remark = request.getParameter("remark");
        String message = "操作成功!";
        //更改sku表的状态
        Sku sku = skuManager.getByObjectId(skuId);
        if(!sku.getCheckStatus().equals(ProductConstants.PRODUCT_STATUS_WAIT_CHECK)){
            message = "操作失败，不在待审核状态!";
        }else{
            //记录sku审核历史
            SkuCheck sc = new SkuCheck();
            sc.setProductId(sku.getProductId());
            sc.setSkuId(skuId);
            sc.setExamineDate(new Date());
            sc.setExamineUserId(FrameworkContextUtils.getCurrentUserId());
            sc.setCheckReason(remark);
            skuManager.executeCheck(skuId, ProductConstants.PRODUCT_STATUS_CHECK_NOT, sc);
            result = true;
        }
        request.setAttribute("result", result);
        return "redirect:/sku/checkNotPass/"+skuId+getMessage(message, request)
                + "&" + appendAjaxParameter(request)+"&result="+result;
    }

    @RequestMapping("/stockPage")
    public String stockPage(HttpServletRequest request, T t, Integer backPage){
        PageSearch page  = preparePage(request);

        String isSearchWarning = request.getParameter("isSearchWarning");
        if(StringUtils.isNotBlank(isSearchWarning)){
            //查询库存预警
            page.getFilters().add(new PropertyFilter(Sku.class.getName(),"EQI_warning","1"));
        }
        String result = handlePage(request, page);
        result = getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"Stock";
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/stockPage");
        return result;
    }

    @RequestMapping("/addStock")
    public String addStock(HttpServletRequest request, T t, Integer backPage){

        String stock = request.getParameter("addStocks");
        String objectIdst = request.getParameter("skuIds");
        String[] addStock = stock.split(",");
        String[] objectIds= objectIdst.split(",");
        for(int i = 0;i<objectIds.length;i++){
            Long id = Long.parseLong(objectIds[i]);
            Long addSk = 0L;
            if(StringUtils.isNotBlank(addStock[i])){
                addSk = Long.parseLong(addStock[i]);
            }
            if(!addSk.equals(0L)){
            	Sku sku = skuManager.getByObjectId(id);
            	if(addSk<0&&sku.getStock()>=Math.abs(addSk)){
            		Map<String,Object> map = new HashMap<String,Object>();
                    map.put("addStock", addSk);
                    map.put("objectId", id);
                    //更改临时表库存和更改正式表库存
                    skuManager.updateSku(map);
            	}else if(addSk>0){
            		Map<String,Object> map = new HashMap<String,Object>();
                    map.put("addStock", addSk);
                    map.put("objectId", id);
                    //更改临时表库存和更改正式表库存
                    skuManager.updateSku(map);
            	}else{
            		return "redirect:/sku/stockPage"+getMessage("库存不能小于0", request);
            	}
            }
        }
        return "redirect:/sku/stockPage"+getMessage("库存增加成功", request);
    }

    @RequestMapping("/skuPriceHistoryPage")
    public String skuPriceHistoryPage(HttpServletRequest request, T t, Integer backPage){
        PageSearch page  = preparePage(request);
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
        //所有的一级分类
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
        PageSearch result = skuPriceHistoryManager.findSkuPriceHistory(page);
        page.setTotalCount(result.getTotalCount());
        List<SkuPriceHistory> skuPrices = result.getList();
        for(SkuPriceHistory s:skuPrices){
            Sku sku = s.getSku();
            Long categoryId = sku.getCategoryId();
            ProductCategory p = productCategoryManager.getByObjectId(categoryId);
            p = productCategoryManager.getThirdCategoryByThirdId(p.getThirdId());
            sku.setCategory(p);
            s.setSku(sku);
        }
        page.setList(skuPrices);
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/skuPriceHistoryPage");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"PriceHistory";
    }

	@RequestMapping(value = "/skuTemplate")
	public String skuTemplate(HttpServletRequest request, Sku t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "product/" + "listSkuTemplate";
	}

    @RequestMapping("/search")
    public String search(HttpServletRequest request, HttpServletResponse response,Integer backPage){
        PageSearch page  = preparePage(request);
        String result = handlePage(request, page);
        result = getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"Search";
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/search");
        return result;
    }

    @RequestMapping(value = "/querySkus/{productId}")
    public String querySkus(HttpServletRequest request, HttpServletResponse response, @PathVariable Long productId,ModelMap map) throws Exception {
    	List<Sku> skus = skuManager.getSkusByProductId(productId);
        map.put("skus", skus);
        return "jsonView";
    }

    @RequestMapping("/searchStock")
    public String searchStock(HttpServletRequest request,HttpServletResponse response,ModelMap map){
        boolean result = false;
        Map<String,Object> param = new HashMap<String,Object>();
        Sku sku = new Sku();
        String attributeValueId1 = request.getParameter("attributeValueId1");
        String attributeValueId2 = request.getParameter("attributeValueId2");
        Long productId = Long.parseLong(request.getParameter("productId"));

        param.put("productId", productId);
        sku.setProductId(productId);
        if(StringUtils.isNotBlank(attributeValueId1)){
            Long attributeId1 = Long.parseLong(attributeValueId1);
            param.put("attributeId1", attributeId1);
            sku.setAttributeId1(attributeId1);
        }
        if(StringUtils.isNotBlank(attributeValueId2)){
            Long attributeId2 = Long.parseLong(attributeValueId2);
            param.put("attributeId2", attributeId2);
            sku.setAttributeId2(attributeId2);
        }

        //通过三个参数查询sku是否唯一，如果唯一则返回sku，否则返回库存
        List<Sku> skus = skuManager.getBySample(sku);
        if(skus.size()>1){
            //获取总库存
            Long totalStock = skuManager.getStock(param);
            map.addAttribute("totalStock", totalStock);
        }else{
            if(skus.size()==0){
                //没有查询到商品
                map.addAttribute("sku", null);
            }else{
                //返回唯一的sku
                Sku sku1 = skus.get(0);
                map.addAttribute("sku", sku1);
            }
        }
        result = true;
        map.addAttribute("result", result);
        return "jsonView";
    }

    @RequestMapping("/autoUp")
    public String autoUp(HttpServletRequest request,HttpServletResponse response){
        skuManager.exeAutoUpShelves();
        try {
            response.getWriter().write("操作成功");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }
    @RequestMapping("/autoDown")
    public String autoDown(HttpServletRequest request,HttpServletResponse response){
        skuManager.exeAutoDownShelves();
        try {
            response.getWriter().write("操作成功");
        } catch (IOException e) {
            e.printStackTrace();
        }
        return null;
    }

    @RequestMapping("/additionalPage")
    public String additionalPage(HttpServletRequest request, T t, Integer backPage){
        PageSearch page  = preparePage(request);
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
        String result = handlePage(request, page);
        result = getFileBasePath() + "list" + getActualArgumentType().getSimpleName()+"Additional";
        afterPage(request, page,backPage);
        request.getSession().setAttribute("action", "/sku/additionalPage");
        return result;
    }
}
