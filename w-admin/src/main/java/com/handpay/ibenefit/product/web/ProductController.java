package com.handpay.ibenefit.product.web;

import java.io.IOException;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.entity.ProductMallCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.category.service.IProductMallCategoryManager;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.entity.ForeverEntity;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierBrand;
import com.handpay.ibenefit.member.entity.SupplierDispatchArea;
import com.handpay.ibenefit.member.service.ISupplierBrandManager;
import com.handpay.ibenefit.member.service.ISupplierDispatchAreaManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.product.entity.Attribute;
import com.handpay.ibenefit.product.entity.AttributeValue;
import com.handpay.ibenefit.product.entity.Brand;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.ProductPublish;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.entity.SkuCheck;
import com.handpay.ibenefit.product.service.IAttributeManager;
import com.handpay.ibenefit.product.service.IAttributeValueManager;
import com.handpay.ibenefit.product.service.IBrandManager;
import com.handpay.ibenefit.product.service.IElectronicCardManager;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.product.service.IProductPublishHistoryManager;
import com.handpay.ibenefit.product.service.IProductPublishManager;
import com.handpay.ibenefit.product.service.ISkuCheckManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.product.service.ISkuPriceHistoryManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.StaffGradeScore;
import com.handpay.ibenefit.security.service.IStaffGradeScoreManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.service.IWelfareManager;

@Controller
@RequestMapping("/product")
public class ProductController extends PageController<Product>{
    private static final String PORTAL_DIR = "product/";

    @Reference(version="1.0")
    private IProductManager productManager;
    @Reference(version="1.0")
    private IProductPublishManager productPublishManager;
    @Reference(version="1.0")
    private IBrandManager brandManager;
    @Reference(version="1.0")
    private IDictionaryManager dictionaryManager;
    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;
    @Reference(version="1.0")
    private IWelfareManager welfareManager;
    @Reference(version="1.0")
    private ISupplierManager supplierManager;
    @Reference(version="1.0")
    private ISkuManager skuManager;
    @Reference(version="1.0")
    private ISkuPublishManager skuPublishManager;
    @Reference(version="1.0")
    private IAreaManager areaManager;
    @Reference(version="1.0")
    private IProductPublishHistoryManager productPublishHistoryManager;
    @Reference(version="1.0")
    private IAttributeManager attributeManager;
    @Reference(version="1.0")
    private IAttributeValueManager attributeValueManager;
    @Reference(version="1.0")
    private IUserManager userManager;
    @Reference(version="1.0")
    private ISkuCheckManager skuCheckManager;
    @Reference(version="1.0")
    private IProductMallCategoryManager productMallCategoryManager;
    @Reference(version="1.0")
    private ISkuPriceHistoryManager skuPriceHistoryManager;
    @Reference(version="1.0")
    private ISupplierBrandManager supplierBrandManager;
    @Reference(version="1.0")
    private ISupplierDispatchAreaManager supplierDispatchAreaManager;
    @Reference(version="1.0")
    private IStaffGradeScoreManager staffGradeScoreManager;
    @Reference(version="1.0")
    private IElectronicCardManager electronicCardManager;
    @Reference(version="1.0")
    private IFileManager fileManager;

    @Override
    public Manager<Product> getEntityManager() {
        return productManager;
    }

    @Override
    public String getFileBasePath() {
        return PORTAL_DIR;
    }

    @Override
    public String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception{
        //一级分类
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
        //得到员工等级
        List<StaffGradeScore> staffGrades = staffGradeScoreManager.getAll();
        request.setAttribute("staffGrades", staffGrades);
        //三级福利
        //得到二级福利
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("itemType", 1);
        param.put("itemGrade", 1);
        param.put("status", 1);
        List<WelfareItem> welfareItems = welfareManager.getItemByParam(param);
        for(WelfareItem item:welfareItems){
            param = new HashMap<String,Object>();
            param.put("itemType", 1);
            param.put("itemGrade", 2);
            param.put("status", 1);
            param.put("parentItemId", item.getObjectId());
            List<WelfareItem> welfares = welfareManager.getItemByParam(param);
            item.setSubWelfareItem(welfares);
        }
        request.setAttribute("welfareItems", welfareItems);
        //得到商品类型的字段
        List<Dictionary> productTypes = dictionaryManager.getDictionariesByDictionaryId(1101);
        request.setAttribute("productTypeList", productTypes);
        if (null != objectId) {
        	return editProduct(request,objectId);
        }
        String productType = request.getParameter("productType");
        if("insure".equals(productType)){
            productTypes = dictionaryManager.getDictionariesByDictionaryId(1102);
            request.setAttribute("productTypeList", productTypes);
            return getFileBasePath() + "createProductInsure";
        }
        return getFileBasePath() + "create" + getActualArgumentType().getSimpleName();
    }

    private String editProduct(HttpServletRequest request,Long objectId) {

        Product entity = productManager.getByObjectId(objectId);
        //创建人和更新人的设置
        if(entity.getUpdatedBy()!=null){
           entity.setUpdateUserName(userManager.getByObjectId(entity.getUpdatedBy()).getUserName());
        }
        if(entity.getCreatedBy()!=null){
           entity.setCreateUserName(userManager.getByObjectId(entity.getCreatedBy()).getUserName());
        }
      //得到所有的品牌
//        List<SupplierBrand> supplierBrands = supplierBrandManager.getWithBrandCommission(entity.getSupplierId());
//        List<Brand> brands = new ArrayList<Brand>();
//        for(SupplierBrand s:supplierBrands){
//            Brand brand = brandManager.getByObjectId(s.getBrandId());
//            if(brand!=null){
//                brands.add(brand);
//            }
//        }
//        request.setAttribute("brands", brands);
        Brand brand = brandManager.getByObjectId(entity.getBrandId());
        request.setAttribute("brand", brand);
        Long productId = entity.getObjectId();
        //得到供应商名字
        Supplier sup = supplierManager.getByObjectId(entity.getSupplierId());
        if(sup!=null){
            String supplierName = supplierManager.getByObjectId(entity.getSupplierId()).getSupplierName();
            request.setAttribute("supplierName", supplierName);
        }
        //得到选择的分类
        ProductCategory category = productCategoryManager.getByObjectId(entity.getCategoryId());
        request.setAttribute("category", category);
        //得到选择的福利
        Map<String,Object> map1 = new HashMap<String,Object>();
        map1.put("productId", productId);
        map1.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
        List<Long> selectedWelfare = productManager.getWelfare(map1);
        String welfareIds = "";
        for(Long l:selectedWelfare){
            welfareIds = welfareIds+l.toString()+",";
        }
        if(selectedWelfare.size()>1){
            welfareIds = welfareIds.substring(0,welfareIds.length()-1);
        }
        //得到选择的商品类型
        Map<String,Object> map2 = new HashMap<String,Object>();
        map2.put("productId", productId);
        map2.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
        List<Integer> selectedProductType = productManager.getProductType(map2);
        //得到可销售区域
        Map<String,Object> map3 = new HashMap<String,Object>();
        map3.put("productId", productId);
        map3.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
        //判断是否选择了全国
        String sellAreas = "";
        String sellAreaNames = "";
        boolean isSelect = productManager.isSelectCountrywide(productId);
        if(isSelect){
            sellAreaNames = "全国";
            entity.setIsCountrywide(1);
        }else{
            List<String> selectedSellArea = productManager.getSellArea(map3);
            for(String a:selectedSellArea){
                sellAreas = sellAreas+a+",";
                Area area = new Area();
                area.setAreaCode(a);
                List<Area> areas = areaManager.getBySample(area);
                if(areas.size()>0){
                    sellAreaNames = sellAreaNames+areas.get(0).getName().trim()+",";
                }
            }
            if(selectedSellArea.size()>1){
                sellAreas = sellAreas.substring(0,sellAreas.length()-1);
                sellAreaNames = sellAreaNames.substring(0,sellAreaNames.length()-1);
            }
        }

        //得到商品副图
        Map<String,Object> map4 = new HashMap<String,Object>();
        map4.put("productId", productId);
        map4.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
        List<String> selectedProductPicture = productManager.getProductPicture(map4);
        String subPicture = "";
        for(String u:selectedProductPicture){
            subPicture = subPicture+u+",";
        }
        if(selectedProductPicture.size()>1){
            subPicture = subPicture.substring(0,subPicture.length()-1);
        }
        List<Attribute> attrs = attributeManager.getByCategoryId(entity.getCategoryId());
        for(Attribute attr:attrs){
            List<AttributeValue> attVals = attributeValueManager.getByAttributeId(attr.getObjectId());
            attr.setAttributeValues(attVals);

            //得到聚合展示
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("productId", productId);
            map.put("attributeId", attr.getObjectId());
            map.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
            List<Integer> selectedProductTogetherShow = productManager.getProductTogetherShow(map);
            if(selectedProductTogetherShow.size()>0){
                attr.setIsTogeter(selectedProductTogetherShow.get(0));
            }
        }
        request.setAttribute("attrs", attrs);

        request.setAttribute("selectedWelfare", selectedWelfare);
        request.setAttribute("welfareIds", welfareIds);

        request.setAttribute("selectedProductType", selectedProductType);
        request.setAttribute("sellAreas", sellAreas);
        request.setAttribute("sellAreaNames", sellAreaNames);

        request.setAttribute("selectedProductPicture", selectedProductPicture);
        request.setAttribute("subPicture", subPicture);
        //得到sku的信息
        Sku sku = new Sku();
        sku.setProductId(productId);
        List<Sku> skus = skuManager.getBySample(sku);
        request.setAttribute("skus", skus);
        request.setAttribute("entity", entity);
        //判断是否整组审核通过,得到未通过审核的sku
        Sku s = new Sku();
        s.setProductId(productId);
        s.setCheckStatus(ProductConstants.PRODUCT_STATUS_CHECK_NOT);
        List<Sku> sk = skuManager.getBySample(s);
        SkuCheck sc = null;
        if(sk.size()>0){
          //取出最近一条审核记录
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("productId", productId);
            map.put("skuId", sk.get(0).getObjectId());
            sc = skuCheckManager.getLatelyCheckRecord(map);
            if(sc!=null){
                sc.setUserName(userManager.getByObjectId(sc.getExamineUserId()).getUserName());
            }
        }else{
            //得到最后一次的审核日期
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("productId", productId);
            sc = skuCheckManager.getLatelyCheckRecord(map);
            if(sc!=null){
                sc.setUserName(userManager.getByObjectId(sc.getExamineUserId()).getUserName());
            }
        }
        request.setAttribute("skuCheck", sc);
        Integer type = skus.get(0).getType();
        if(type!=null&&(type.equals(ProductConstants.PRODUCT_TYPE_PERSONAL_INSURE)||type.equals(ProductConstants.PRODUCT_TYPE_GROUP_INSURE))){
            List<Dictionary> productTypes = dictionaryManager.getDictionariesByDictionaryId(1102);
            request.setAttribute("productTypeList", productTypes);
            return getFileBasePath() + "editProductInsure";
        }else{
            List<Dictionary> productTypes = dictionaryManager.getDictionariesByDictionaryId(1101);
            request.setAttribute("productTypeList", productTypes);
            return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
        }
	}

	@Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, Product product) throws Exception {
        String checkStatusStr = request.getParameter("checkStatus");
        Integer checkStatus = null;
        //如果立即发布，则状态为已审核通过
        if(StringUtils.isNotBlank(checkStatusStr)){
            checkStatus = Integer.parseInt(checkStatusStr);
        }
        //得到福利主题
        String welfareIdsStr = request.getParameter("welfareIds");
        //得到商品类型
        String[] productTypesStr = request.getParameterValues("productTypes");
        //得到商品可销售区域
        String sellAreas = request.getParameter("sellAreas");
        //得到商品副图
        String subPicture = request.getParameter("subPicture");
        //得到聚合展示参数
        Map<String,String> togetherShowParam = getTogetherShowMap(request);
        //得到sku参数
        Map<String,String[]> skuParam = getSkuParam(request);
        Long userId = FrameworkContextUtils.getCurrentUserId();


        Map<String,Object> productParam = new HashMap<String,Object>();
        productParam.put("product", product);
        productParam.put("welfareIds", welfareIdsStr);
        productParam.put("productTypes", productTypesStr);
        productParam.put("sellAreas", sellAreas);
        productParam.put("subPicture", subPicture);
        productParam.put("togetherShowMap", togetherShowParam);
        productParam.put("skuMap", skuParam);
        productParam.put("userId", userId);
        productParam.put("checkStatus", checkStatus);
        productParam.put("publishStatus", ProductConstants.PRODUCT_NO_PUBLISH);
        productParam.put("platform", ProductConstants.RELEASE_PLATFORM_AGENT);
        //保存商品
        productManager.saveProduct(productParam);
        return "redirect:/sku/page"+ getMessage("common.base.success", request)
                + "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
    }
    public Map<String,String> getTogetherShowMap(HttpServletRequest request){
        //根据状态和商品id情况数据
        String attribute1Show = request.getParameter("attribute1Show");
        String attribute2Show = request.getParameter("attribute2Show");
        String attributeId1 = request.getParameter("attributeId1");
        String attributeId2 = request.getParameter("attributeId2");

        Map<String,String> m = new HashMap<String,String>();
        m.put("attribute1Show", attribute1Show);
        m.put("attribute2Show", attribute2Show);
        m.put("attributeId1", attributeId1);
        m.put("attributeId2", attributeId2);
        return m;
    }
    public Map<String,String[]> getSkuParam(HttpServletRequest request){
      //读取sku值
        String[] skuName = request.getParameterValues("skuName");
        String[] skuObjectId = request.getParameterValues("skuObjectId");
        String[] skuReturnGoods = request.getParameterValues("skuReturnGoods");
        String[] skuNo = request.getParameterValues("skuNo");
        String[] skuProductType = request.getParameterValues("skuProductType");
        String[] attributeValueId1 = request.getParameterValues("attributeValueId1");
        String[] attributeValueId2 = request.getParameterValues("attributeValueId2");
        String[] attributeValue1 = request.getParameterValues("attributeValue1");
        String[] attributeValue2 = request.getParameterValues("attributeValue2");
        String[] skuProductNo = request.getParameterValues("skuProductNo");
        String[] skuProductModel = request.getParameterValues("skuProductModel");
        String[] skuSupplyPrice = request.getParameterValues("skuSupplyPrice");
        String[] skuMarketPrice = request.getParameterValues("skuMarketPrice");
        String[] skuSellPrice = request.getParameterValues("skuSellPrice");
        String[] skuStock = request.getParameterValues("skuStock");
        String[] skuSafetyStock = request.getParameterValues("skuSafetyStock");
        String[] skuIfInvoice = request.getParameterValues("skuIfInvoice");

        Map<String,String[]> map = new HashMap<String,String[]>();
        map.put("skuName", skuName);
        map.put("skuObjectId", skuObjectId);
        map.put("skuReturnGoods", skuReturnGoods);
        map.put("skuNo", skuNo);
        map.put("skuProductType",skuProductType);

        map.put("attributeValueId1", attributeValueId1);
        map.put("attributeValueId2", attributeValueId2);
        map.put("attributeValue1", attributeValue1);
        map.put("attributeValue2", attributeValue2);
        map.put("skuProductNo",skuProductNo);

        map.put("skuProductModel", skuProductModel);
        map.put("skuSupplyPrice", skuSupplyPrice);
        map.put("skuMarketPrice", skuMarketPrice);
        map.put("skuSellPrice", skuSellPrice);
        map.put("skuStock",skuStock);

        map.put("skuSafetyStock", skuSafetyStock);
        map.put("skuIfInvoice",skuIfInvoice);

        return map;
    }

    @RequestMapping(value = "/check/{productId}")
    public String checkProduct(HttpServletRequest request, HttpServletResponse response, @PathVariable Long productId) throws Exception{
        String result =  this.handleEdit(request, response, productId);
        result = getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"Check";
        return result;
    }
    @RequestMapping(value = "/checkPass/{productId}")
    public String checkPass(HttpServletRequest request, HttpServletResponse response, @PathVariable Long productId,ModelMap map) throws Exception {
        boolean result = true;
        String message = "整组操作成功!";
        //记录sku审核记录
        Sku skuCheck = new Sku();
        skuCheck.setProductId(productId);
        List<Sku> skusCheck = skuManager.getBySample(skuCheck);
        List<Long> skuIds = new ArrayList<Long>();
        for(Sku sk:skusCheck){
            if(!sk.getCheckStatus().equals(ProductConstants.PRODUCT_STATUS_WAIT_CHECK)){
                message = "一些商品审核失败，不在待审核状态!";
                result = false;
                break;
            }
            SkuCheck sc = new SkuCheck();
            sc.setExamineDate(new Date());
            sc.setExamineUserId(FrameworkContextUtils.getCurrentUserId());
            sc.setProductId(productId);
            sc.setSkuId(sk.getObjectId());
            skuManager.executeCheck(sk.getObjectId(),ProductConstants.PRODUCT_STATUS_WAIT_SALE,sc);
           //判断是否是否为立即发布，如果为立即发布则上架
            if(sk.getImmediateRelease().equals(IBSConstants.STATUS_YES)){
                if(sk.getStock()>0){
                	skuIds.add(sk.getObjectId());
                }
            }
        }
        //上架
        if(skuIds.size()>0){
        	skuManager.upProducts(skuIds);
        }
        map.addAttribute("result", result);
        map.addAttribute("message",message);
        return "jsonView";
    }
    @RequestMapping(value = "/checkNotPass/{productId}")
    public String checkNotPass(HttpServletRequest request, HttpServletResponse response, @PathVariable Long productId,Product t) throws Exception {
        request.setAttribute("productId", productId);
        return getFileBasePath()+"checkProduct";
    }
    @RequestMapping(value = "/saveCheckReason")
    public String saveCheckReason(HttpServletRequest request, HttpServletResponse response) throws Exception {
        boolean result = true;
        String message = "整组操作成功!";
        Long productId = Long.parseLong(request.getParameter("productId"));
        String remark = request.getParameter("remark");
      //记录sku审核记录
        Sku sku = new Sku();
        sku.setProductId(productId);
        List<Sku> skus = skuManager.getBySample(sku);
        for(Sku sk:skus){
            if(!sk.getCheckStatus().equals(ProductConstants.PRODUCT_STATUS_WAIT_CHECK)){
                message = "一些商品审核失败，不在待审核状态!";
                result = false;
                break;
            }
            SkuCheck sc = new SkuCheck();
            sc.setExamineDate(new Date());
            sc.setExamineUserId(FrameworkContextUtils.getCurrentUserId());
            sc.setProductId(productId);
            sc.setSkuId(sk.getObjectId());
            sc.setCheckReason(remark);
            skuManager.executeCheck(sk.getObjectId(), ProductConstants.PRODUCT_STATUS_CHECK_NOT, sc);
        }
        return "redirect:/product/checkNotPass/"+productId+getMessage(message, request)
                + "&" + appendAjaxParameter(request)+"&result="+result;
    }
    @RequestMapping(value = "/viewMallCategory/{categoryId}")
    public String viewMallCategory(HttpServletRequest request, HttpServletResponse response, @PathVariable Long categoryId) throws Exception {
        ProductCategory pc = productCategoryManager.getByObjectId(categoryId);
        Map<String,Object> map = new HashMap<String,Object>();
        map.put("productThirdId", pc.getObjectId());
        List<ProductMallCategory> list = productMallCategoryManager.getAllThirdCategoryByProductThirdId(map);
        request.setAttribute("items", list);
        return getFileBasePath()+"viewFrontCategory";
    }



    protected void handleNoInSellingFind(PageSearch page){
        if(ForeverEntity.class.isAssignableFrom(page.getEntityClass())){
            page.getFilters().add(new PropertyFilter(getEntityName(),"EQI_deleted",ForeverEntity.DELETED_NO + ""));
        }
        PageSearch result = productPublishManager.findNoInSellingPublishProduct(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
    }

	 @RequestMapping("getSellArea")
	    public String getSellArea(HttpServletRequest request,HttpServletResponse response, ModelMap map){
	   //供应商ID
	        boolean result = false;
	        boolean isHaveCountrywide = false;
	        String supplierIdStr=request.getParameter("supplierId");
	        String areaIds = "";
	        if (StringUtils.isNotBlank(supplierIdStr)) {
	            Long supplierId = Long.parseLong(supplierIdStr);
	            isHaveCountrywide = supplierDispatchAreaManager.isHaveCountrywide(supplierId);
	            if(isHaveCountrywide){
	                //得到全国所有的市
	                Area area = new Area();
	                area.setDeepLevel(2);
	                area.setStatus(1);
	                List<Area> areas = areaManager.getBySample(area);
	                for(Area a:areas){
                        areaIds = areaIds+a.getAreaCode()+",";
                   }
                   if(areas.size()>=1){
                       areaIds = areaIds.substring(0,areaIds.length()-1);
                   }
	            }else{
	                SupplierDispatchArea supb = new SupplierDispatchArea();
	                supb.setSupplierId(supplierId);
	                List<SupplierDispatchArea> supbs = supplierDispatchAreaManager.getBySample(supb);
	                Set<Area> areas = new HashSet<Area>();
	                for(SupplierDispatchArea s:supbs){
	                    if(StringUtils.isNotBlank(s.getAreaId())&&s.getAreaId().equals("-1")){
	                        isHaveCountrywide = true;
	                        break;
	                    }
	                    Long areaId = Long.parseLong(s.getAreaId());
	                    Area area = areaManager.getByObjectId(areaId);
	                    if(area!=null){
	                        Area parentArea = areaManager.getByObjectId(area.getParentId());
	                        if(parentArea!=null){
	                            areas.add(parentArea);
	                        }
	                    }
	                }
	                for(Area a:areas){
	                     areaIds = areaIds+a.getAreaCode()+",";
	                }
	                if(areas.size()>=1){
	                    areaIds = areaIds.substring(0,areaIds.length()-1);
	                }
	            }
	        }

	        result = true;
            map.addAttribute("areaIds", areaIds);
	        map.addAttribute("result",result);
	        map.addAttribute("isHaveCountrywide", isHaveCountrywide);
	        return "jsonView";
	    }

	    @RequestMapping("getBrand")
	    public String getBrand(HttpServletRequest request,HttpServletResponse response, ModelMap map){
	        //供应商ID
	        boolean result = false;
	        String supplierIdStr=request.getParameter("supplierId");
	        if (StringUtils.isNotBlank(supplierIdStr)) {
	            Long supplierId = Long.parseLong(supplierIdStr);
	            //得到有效期内的代理品牌
	            List<SupplierBrand> supbs = supplierBrandManager.getWithBrandCommission(supplierId);
	            Set<Brand> brandSet = new HashSet<Brand>();
	            for(SupplierBrand s:supbs){
	                Brand brand = brandManager.getByObjectId(s.getBrandId());
	                if(brand!=null){
	                    brandSet.add(brand);
	                }
	            }
	            List<Brand> brands = new ArrayList<Brand>(brandSet);
	            map.addAttribute("brands",brands);
	            result = true;
	        }
	        map.addAttribute("result",result);
	        return "jsonView";
	    }

	    @RequestMapping("getThirdCategory")
        public String getThirdCategory(HttpServletRequest request,HttpServletResponse response, ModelMap map){
            //供应商ID
            String supplierIdStr=request.getParameter("supplierId");
            String brandIdStr=request.getParameter("brandId");
            Long supplierId = null;
            Long brandId = null;
            if (StringUtils.isNotBlank(supplierIdStr)) {
                supplierId = Long.parseLong(supplierIdStr);
            }
            if (StringUtils.isNotBlank(brandIdStr)) {
                brandId = Long.parseLong(brandIdStr);
            }
            //通过供应商id和品牌id得到一级分类
            List<SupplierBrand> SupplierBrands =  supplierBrandManager.getThirdCategory(supplierId,brandId);
            Set<Long> categoryIdSet = new HashSet<Long>();
            for(SupplierBrand s:SupplierBrands){
                if(s!=null&&StringUtils.isNotBlank(s.getCategoryId())){
                    categoryIdSet.add(Long.parseLong(s.getCategoryId()));
                }
            }
            List<Long> categoryIds = new ArrayList<Long>(categoryIdSet);
            List<ProductCategory> productCategories = productCategoryManager.getThirdCategory(categoryIds);
            map.addAttribute("result",true);
            map.addAttribute("thirdCategory", productCategories);
            return "jsonView";
        }


	    @RequestMapping("/detail/{productId}")
	    public String detail(HttpServletRequest request,HttpServletResponse response,@PathVariable Long productId) throws IOException{

	        Product product = productManager.getByObjectId(productId);
	        List<Sku> skus = skuManager.getSkusByProductId(productId);
	        Sku sk = null;
	        if(skus.size()>0){
	            sk = skus.get(0);
	        }
	        if(sk==null){
	            response.getWriter().write("没有添加sku");
	            return null;
	        }
	        //为了确认是否聚合，将attributeId1和attributeId2传回前端
	        request.setAttribute("attributeId1", sk.getAttributeId1());
	        request.setAttribute("attributeValue1", sk.getAttributeValue1());
	        request.setAttribute("attributeId2", sk.getAttributeId2());
	        request.setAttribute("attributeValue2", sk.getAttributeValue2());

	        Map<String,Object> map = new HashMap<String,Object>();
	        map.put("productId", productId);
	        map.put("status", ProductConstants.PRODUCT_NO_PUBLISH);

	        //得到商品福利标签
	        Map<String,Object> map1 = new HashMap<String,Object>();
	        map1.put("productId", productId);
	        map1.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
	        List<Long> selectedWelfare = productManager.getWelfare(map1);
	        String welfares = "";
	        for(Long id:selectedWelfare){
	            WelfareItem w =welfareManager.getByObjectId(id);
	            if(w!=null){
	                welfares = welfares+w.getItemName()+",";
	            }
	        }
	        if(selectedWelfare.size()>1){
	            welfares = welfares.substring(0,welfares.length()-1);
	        }
	        request.setAttribute("welfares", welfares);
	        //得到子图
	        List<String> subPics = productManager.getProductPicture(map);
	        //得到所有的属性1和属性2
	        List<AttributeValue> att1 = skuManager.getAllAttribute1(productId);
	        List<AttributeValue> att2 = skuManager.getAllAttribute2(productId);
	        List<Attribute> attrs = new ArrayList<Attribute>();
	        if(att1.size()>0&&att1.get(0)!=null){
	            Long attributeId = att1.get(0).getAttributeId();
	            Attribute att = attributeManager.getByObjectId(attributeId);
	            att.setAttributeValues(att1);
	            attrs.add(att);
	        }

	        if(att2.size()>0&&att2.get(0)!=null){
	            Long attributeId = att2.get(0).getAttributeId();
	            Attribute att = attributeManager.getByObjectId(attributeId);
	            att.setAttributeValues(att2);
	            attrs.add(att);
	        }
	       //判断属性1和2是否聚合展示
	        for(Attribute attr:attrs){
	          //得到聚合展示
	            Map<String,Object> param = new HashMap<String,Object>();
	            param.put("productId", productId);
	            param.put("attributeId", attr.getObjectId());
	            param.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
	            List<Integer> selectedProductTogetherShow = productManager.getProductTogetherShow(param);
	            if(selectedProductTogetherShow.size()>0){
	                attr.setIsTogeter(selectedProductTogetherShow.get(0));
	            }
	        }
	        request.setAttribute("product", product);
	        request.setAttribute("attrs", attrs);
	        request.setAttribute("subPics", subPics);
	        return PORTAL_DIR+"detail";
	    }

	    @RequestMapping(value = "/importStockPage")
        public String importStockPage(HttpServletRequest request,HttpServletResponse response){
	        Long skuId = Long.parseLong(request.getParameter("skuId"));
	        Sku sku = skuManager.getByObjectId(skuId);
	        request.setAttribute("stockSource",sku.getStockSource());
	        return PORTAL_DIR + "importStock";
        }

	    @RequestMapping(value = "/importStock")
        public String importStock(HttpServletRequest request,HttpServletResponse response)throws Exception{
	        Long skuId = Long.parseLong(request.getParameter("skuId"));
	        String source = request.getParameter("source");
	        String message = "操作成功";
	        if(StringUtils.isNotBlank(source)&&source.equals("1")){
	            //调用三方库存
	            Sku sku = skuManager.getByObjectId(skuId);
	            if(StringUtils.isNotBlank(sku.getProductNo())){
	                Map<String,Object> map = new HashMap<String,Object>();
	                map.put("stockSource", source);
	                map.put("stock", 99999L);
	                map.put("objectId", skuId);
	                skuManager.updateSku(map);
	            }else{
	                message = "ICS卡券必须填写商品货号";
	            }
	        }else if(StringUtils.isNotBlank(source)&&source.equals("2")){
	            //导入
	            UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
	            byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
	            message = electronicCardManager.importStock(fileData, skuId, Integer.parseInt(source));

	        }
            return "redirect:importStockPage?message="+URLEncoder.encode(message,"utf-8")+"&result=true&ajax=1&skuId="+skuId;
        }

	    /**
	      * productRecommentTemplate(选择推荐商品)
	      *
	      * @Title: productRecommentTemplate
	      * @Description: TODO
	      * @param @param request
	      * @param @param t
	      * @param @param backPage
	      * @param @return
	      * @param @throws Exception    设定文件
	      * @return String    返回类型
	      * @throws
	     */
	    @RequestMapping(value = "/productRecommentsTemplate")
	    public String productRecommentTemplate(HttpServletRequest request,Company t, Integer backPage) throws Exception {
	        String secondId = request.getParameter("secondId");
	        String categoryId = request.getParameter("search_EQL_categoryId");
	        request.setAttribute("secondId", secondId);
	        request.setAttribute("categoryId", categoryId);
	        //所有的一级分类
	        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
	        request.setAttribute("firstCategory", firstCategory);
	        PageSearch page  = preparePage(request);
	        page.setSortOrder("createdOn");
	        page.setSortProperty("desc");
	        PageSearch result = productManager.queryProductOnshelves(page);
	        page.setList(result.getList());
	        page.setTotalCount(result.getTotalCount());
//	        handlePage(request, page);
	        List<Product> products = page.getList();
	        for(Product p:products){
	              Supplier sup = supplierManager.getByObjectId(p.getSupplierId());
	              if(sup!=null){
	               p.setSupplierName(sup.getSupplierName());
	              }else{
	                  p.setSupplierName("");
	              }
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return PORTAL_DIR + "listProductRecommentsTemplate";
	    }


	    /**
	      * productRelevanceTemplate(选择推荐商品主商品)
	      *
	      * @Title: productRelevanceTemplate
	      * @Description: TODO
	      * @param @param request
	      * @param @param t
	      * @param @param backPage
	      * @param @return
	      * @param @throws Exception    设定文件
	      * @return String    返回类型
	      * @throws
	     */
	    @RequestMapping(value = "/productRelevanceTemplate")
	    public String productRelevanceTemplate(HttpServletRequest request,Company t, Integer backPage) throws Exception {
	     //所有的一级分类
	        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
	        request.setAttribute("firstCategory", firstCategory);
	        PageSearch page  = preparePage(request);
	        handlePage(request, page);
	        List<Product> products = page.getList();
	        for(Product p:products){
	              Supplier sup = supplierManager.getByObjectId(p.getSupplierId());
	              if(sup!=null){
	               p.setSupplierName(sup.getSupplierName());
	              }else{
	                  p.setSupplierName("");
	              }
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return PORTAL_DIR + "listProductRelevanceTemplate";
	    }

	    /**
	     *
	      * productCompanyPriceTemplate(面向企业价格设置选择模版)
	      *
	      * @Title: productCompanyPriceTemplate
	      * @Description: TODO
	      * @param @param request
	      * @param @param t
	      * @param @param backPage
	      * @param @return
	      * @param @throws Exception    设定文件
	      * @return String    返回类型
	      * @throws
	     */
	    @RequestMapping(value = "/productCompanyPriceTemplate")
	    public String productCompanyPriceTemplate(HttpServletRequest request,Company t, Integer backPage) throws Exception {
	        PageSearch page  = preparePage(request);
	        handlePage(request, page);
	        List<Product> list = page.getList();
	        for(Product p:list){
	            Supplier supp = supplierManager.getByObjectId(p.getSupplierId());
	            if(supp!=null){
	              p.setSupplierName(supp.getSupplierName());
	            }
	            ProductCategory pc = productCategoryManager.getByObjectId(p.getCategoryId());
	            pc = productCategoryManager.getThirdCategoryByThirdId(pc.getThirdId());
	            p.setCategory(pc);
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return PORTAL_DIR + "listProductCompanyPriceTemplate";
	    }

	    /**
	      * productRelevancesTemplate(选择推荐商品关联商品)
	      *
	      * @Title: productRelevancesTemplate
	      * @Description: TODO
	      * @param @param request
	      * @param @param t
	      * @param @param backPage
	      * @param @return
	      * @param @throws Exception    设定文件
	      * @return String    返回类型
	      * @throws
	     */
	    @RequestMapping(value = "/productRelevancesTemplate")
	    public String productRelevancesTemplate(HttpServletRequest request,Company t, Integer backPage) throws Exception {
	         //所有的一级分类
	        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
	        request.setAttribute("firstCategory", firstCategory);
	        PageSearch page  = preparePage(request);
	        handlePage(request, page);
	        List<Product> products = page.getList();
	        for(Product p:products){
	              Supplier sup = supplierManager.getByObjectId(p.getSupplierId());
	              if(sup!=null){
	               p.setSupplierName(sup.getSupplierName());
	              }else{
	                  p.setSupplierName("");
	              }
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return PORTAL_DIR + "listProductRelevancesTemplate";
	    }

	    @RequestMapping(value = "/productTemplate")
	    public String productTemplate(HttpServletRequest request, Product t, Integer backPage) throws Exception {
	        PageSearch page  = preparePage(request);
	        handlePage(request, page);
	        List<Product> list = page.getList();
	        for(Product p:list){
	            Supplier supp = supplierManager.getByObjectId(p.getSupplierId());
	            if(supp!=null){
	              p.setSupplierName(supp.getSupplierName());
	            }
	            ProductCategory pc = productCategoryManager.getByObjectId(p.getCategoryId());
	            pc = productCategoryManager.getThirdCategoryByThirdId(pc.getThirdId());
	            p.setCategory(pc);
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return "product/" + "listProductTemplate";
	    }

	    @RequestMapping(value = "/productCompanyExclusiveTemplate")
	    public String productCompanyExclusiveTemplate(HttpServletRequest request, Product t, Integer backPage) throws Exception {
	        PageSearch page  = preparePage(request);
	        handleNoInSellingFind(page);
	        List<ProductPublish> list = page.getList();
	        for(ProductPublish p:list){
	            Supplier supp = supplierManager.getByObjectId(p.getSupplierId());
	            if(supp!=null){
	              p.setSupplierName(supp.getSupplierName());
	            }
	            ProductCategory pc = productCategoryManager.getByObjectId(p.getCategoryId());
	            pc = productCategoryManager.getThirdCategoryByThirdId(pc.getThirdId());
	            p.setCategory(pc);
	        }
	        afterPage(request, page,backPage);
	        request.setAttribute("inputName", request.getParameter("inputName"));
	        return "product/" + "listProductCompanyExclusiveTemplate";
	    }

	    @RequestMapping(value = "/welfarePlan/{welfareId}")
        public String welfarePlan(HttpServletRequest request, HttpServletResponse response,@PathVariable Long welfareId){
            request.setAttribute("welfareId", welfareId);
            //所有的一级分类
            List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
            request.setAttribute("firstCategory", firstCategory);
            PageSearch page  = preparePage(request);
            page.getFilters().add(new PropertyFilter(ProductPublish.class.getName(),"EQL_welfareId",welfareId + ""));
            PageSearch result = productPublishManager.getWelfarePlanProduct(page);
            page.setList(result.getList());
            page.setTotalCount(result.getTotalCount());
            List<ProductPublish> products = result.getList();
            for(ProductPublish s:products){
                Long categoryId = s.getCategoryId();
                ProductCategory p = productCategoryManager.getByObjectId(categoryId);
                if(p!=null){
                    p = productCategoryManager.getThirdCategoryByThirdId(p.getThirdId());
                    s.setCategory(p);
                }
            }
            PageUtils.afterPage(request, page, PageUtils.IS_NOT_BACK);
            request.getSession().setAttribute("action", "/product/welfarePlan/"+welfareId);
            return "product/itemProductSetPage";
        }
        @RequestMapping("/setWelfarePlan")
        public String setWelfarePlan(HttpServletRequest request,HttpServletResponse response){
            //只有状态为带上架或者已下架的商品才能上架
            String message = "操作成功";
            String productIds = request.getParameter("itemIds");
            Integer value = Integer.parseInt(request.getParameter("value"));
            Long welfareId = Long.parseLong(request.getParameter("welfareId"));
            if(StringUtils.isNotBlank(productIds)){
                String[] ids = productIds.split(",");
                for(String id:ids){
                    Long productId = Long.parseLong(id);
                    Map<String,Object> map = new HashMap<String,Object>();
                    map.put("isWelfarePlan", value);
                    map.put("productId", productId);
                    map.put("welfareId", welfareId);
                    productManager.updateWelfare(map);
                }
            }else{
                message = "操作失败，你没有选择任何项目";
            }
            return "redirect:/product/welfarePlan/"+welfareId+getMessage(message, request);
        }
        @RequestMapping("/deleteWelfarePlan")
        public String deleteWelfarePlan(HttpServletRequest request,HttpServletResponse response){
            //只有状态为带上架或者已下架的商品才能上架
            String message = "操作成功";
            String productIds = request.getParameter("itemIds");
            Long welfareId = Long.parseLong(request.getParameter("welfareId"));
            if(StringUtils.isNotBlank(productIds)){
                String[] ids = productIds.split(",");
                for(String id:ids){
                    Long productId = Long.parseLong(id);
                    Map<String,Object> map = new HashMap<String,Object>();
                    map.put("productId", productId);
                    map.put("welfareId", welfareId);
                    productManager.deleteWelfare(map);
                }
            }else{
                message = "操作失败，你没有选择任何项目";
            }
            return "redirect:/product/welfarePlan/"+welfareId+getMessage(message, request);
        }

        @RequestMapping(value = "/addWelfarePlanPage")
        public String addWelfarePlanPage(HttpServletRequest request, Product t, Integer backPage) throws Exception {
            PageSearch page  = preparePage(request);
            handleNoInSellingFind(page);
            List<ProductPublish> list = page.getList();
            for(ProductPublish p:list){
                Supplier supp = supplierManager.getByObjectId(p.getSupplierId());
                if(supp!=null){
                  p.setSupplierName(supp.getSupplierName());
                }
                ProductCategory pc = productCategoryManager.getByObjectId(p.getCategoryId());
                pc = productCategoryManager.getThirdCategoryByThirdId(pc.getThirdId());
                p.setCategory(pc);
            }
            afterPage(request, page,backPage);
            request.setAttribute("welfareId", request.getParameter("welfareId"));
            return "product/addWelfarePlanPage";
        }

        @RequestMapping("/addWelfarePlan")
        public String addWelfarePlan(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
            //只有状态为带上架或者已下架的商品才能上架
            boolean result = true;
            String message = "操作成功";
            String productIds = request.getParameter("itemIds");
            Long welfareId = Long.parseLong(request.getParameter("welfareId"));
            Integer value = Integer.parseInt(request.getParameter("value"));
            if(StringUtils.isNotBlank(productIds)){
                String[] ids = productIds.split(",");
                for(String id:ids){
                    Long productId = Long.parseLong(id);
                    Map<String,Object> map = new HashMap<String,Object>();
                    map.put("productId", productId);
                    map.put("welfareId", welfareId);
                    productManager.deleteWelfare(map);

                    map.put("status", ProductConstants.PRODUCT_YES_PUBLISH);
                    map.put("isWelfarePlan", value);
                    productManager.saveWelfare(map);

                    map.put("status", ProductConstants.PRODUCT_NO_PUBLISH);
                    productManager.saveWelfare(map);
                }
            }else{
                result = false;
                message = "操作失败，你没有选择任何项目";
            }
            modelMap.addAttribute("reuslt", result);
            modelMap.addAttribute("message", message);
            return "jsonView";
        }

        @RequestMapping(value = "/editAdditional/{productId}")
        public String editAdditional(HttpServletRequest request, HttpServletResponse response, @PathVariable Long productId) throws Exception{
            Product entity = productManager.getByObjectId(productId);
            request.setAttribute("entity", entity);
            editProduct(request,productId);

          //得到选择的分类
            ProductCategory category = productCategoryManager.getByObjectId(entity.getCategoryId());
            category = productCategoryManager.getThirdCategoryByThirdId(category.getThirdId());
            request.setAttribute("category", category);

          //得到二级福利
            Map<String,Object> param = new HashMap<String,Object>();
            param.put("itemType", 1);
            param.put("itemGrade", 1);
            param.put("status", 1);
            List<WelfareItem> welfareItems = welfareManager.getItemByParam(param);
            for(WelfareItem item:welfareItems){
                param = new HashMap<String,Object>();
                param.put("itemType", 1);
                param.put("itemGrade", 2);
                param.put("status", 1);
                param.put("parentItemId", item.getObjectId());
                List<WelfareItem> welfares = welfareManager.getItemByParam(param);
                item.setSubWelfareItem(welfares);
            }
            request.setAttribute("welfareItems", welfareItems);

            List<Attribute> attrs = attributeManager.getByCategoryId(entity.getCategoryId());
            for(Attribute attr:attrs){
                List<AttributeValue> attVals = attributeValueManager.getByAttributeId(attr.getObjectId());
                for(AttributeValue attrVal:attVals){
                    String specPicUrl = productManager.getSpecPic(productId, attrVal.getObjectId());
                    attrVal.setSpecPicUrl(specPicUrl);
                }
                attr.setAttributeValues(attVals);
            }
            request.setAttribute("attributes", attrs);
            String result = getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"Additional";
            return result;
        }
        @RequestMapping("/deleteSpecPic")
        public String deleteSpecPic(HttpServletRequest request, HttpServletResponse response,ModelMap modelMap){
            boolean result = false;
            Long productId = Long.parseLong(request.getParameter("productId"));
            Long attributeValueId = Long.parseLong(request.getParameter("attrValId"));
            productManager.deleteSpecPic(productId, attributeValueId);
            result = true;
            modelMap.addAttribute("result", result);
            return "jsonView";
        }

        @RequestMapping("/uploadEnclosure")
        public String uploadEnclosure(HttpServletRequest request, HttpServletResponse response,ModelMap map) throws Exception{
            String result = "false";
            Long productId = Long.parseLong(request.getParameter("productId"));
            UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile");
            String fileName = uploadFile.getFileName();
            if (StringUtils.isNotBlank(fileName)) {
                byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
                String filePath = fileManager.saveContentFile(fileData, uploadFile.getFileName());
                //保存规格属性图片
                productManager.uploadEnclosure(productId,filePath.trim(),fileName);
                productPublishManager.uploadEnclosure(productId,filePath.trim(),fileName);
                result = "true";
                map.put("filePath", filePath.trim());
                map.put("fileName", fileName);
            } else {
                map.put("message", "图片格式必须为.jpg");
            }
            map.addAttribute("result", result);
            return "jsonView";
        }
}
