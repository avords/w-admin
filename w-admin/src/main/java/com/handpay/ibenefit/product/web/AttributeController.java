package com.handpay.ibenefit.product.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.entity.BaseTree;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Attribute;
import com.handpay.ibenefit.product.entity.AttributeValue;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.service.IAttributeManager;
import com.handpay.ibenefit.product.service.IAttributeValueManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/attribute")
public class AttributeController extends PageController<Attribute>{

    private static final Logger LOGGER = Logger.getLogger(AttributeController.class);

    @Reference(version="1.0")
    private IAttributeManager attributeManager;
    @Reference(version="1.0")
    private IAttributeValueManager attributeValueManager;
    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;
    @Reference(version="1.0")
    private IUserManager userManager;
    @Reference(version="1.0")
    private ISkuManager skuManager;
    @Override
    public Manager<Attribute> getEntityManager() {
        return attributeManager;
    }

    @Override
    public String getFileBasePath() {
        return "product/";
    }

    @RequestMapping("/editAttr/{thirdId}")
    public String editAttr(HttpServletRequest request, HttpServletResponse response, @PathVariable String thirdId)
            throws Exception {
        if (null != thirdId) {
          //通过categoryId得到分类的一二三级
            ProductCategory thirdCategory = productCategoryManager.getThirdCategoryByThirdId(thirdId);
            request.setAttribute("thirdCategory", thirdCategory);
            //得到属性和属性值
            List<Attribute> list = attributeManager.getByCategoryId(thirdCategory.getObjectId());
            for(int i=0;i<list.size();i++){
                request.setAttribute("attribute"+(i+1), list.get(i));
                //获取属性值
                List<AttributeValue> avs =
                        attributeValueManager.getByAttributeId(list.get(i).getObjectId());
                request.setAttribute("attributeValue"+(i+1), avs);
            }
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("categoryId", thirdCategory.getObjectId());
        }
        return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, Attribute t) throws Exception {
        boolean result = false;
        //分类
        Long categoryId = Long.parseLong(request.getParameter("categoryId"));
        Long thirdId = Long.parseLong(request.getParameter("thirdId"));
        //属性
        String attributeObjectId1 = request.getParameter("attributeObjectId1");
        String name1 = request.getParameter("name1");
        String attributeObjectId2 = request.getParameter("attributeObjectId2");
        String name2 = request.getParameter("name2");

        String[] objectId1s = request.getParameterValues("objectId1");
        String[] attributeValue1s = request.getParameterValues("attributeValue1");
        String[] sortNo1s = request.getParameterValues("sortNo1");

        String[] objectId2s = request.getParameterValues("objectId2");
        String[] attributeValue2s = request.getParameterValues("attributeValue2");
        String[] sortNo2s = request.getParameterValues("sortNo2");

        Map<String,Object> param = new HashMap<String,Object>();
        param.put("categoryId", categoryId);
        param.put("thirdId", thirdId);

        param.put("attributeObjectId1", attributeObjectId1);
        param.put("name1", name1);
        param.put("attributeObjectId2", attributeObjectId2);
        param.put("name2", name2);

        param.put("objectId1s", objectId1s);
        param.put("attributeValue1s", attributeValue1s);
        param.put("sortNo1s", sortNo1s);
        param.put("objectId2s", objectId2s);
        param.put("attributeValue2s", attributeValue2s);
        param.put("sortNo2s", sortNo2s);

        attributeValueManager.save(param);
        result = true;
        return "redirect:editAttr/" + thirdId + getMessage("common.base.success", request)
                + "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action")+"&result="+result;
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        PageSearch result = productCategoryManager.findAllThirdCategory(page);
        page.setTotalCount(result.getTotalCount());
        List<ProductCategory> list = result.getList();
        //根据三级查询属性
        for(ProductCategory cat:list){
            Long categoryId = cat.getObjectId();
            List<Attribute> atts = attributeManager.getByCategoryId(categoryId);
            String content = "";
            for(Attribute att:atts){
                content = content+att.getName()+"、";
            }
            if(atts.size()>0){
                content = content.substring(0,content.length()-1);
            }
            cat.setProperties(content);
        }
        page.setList(list);
        request.setAttribute("action", "page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }
    @RequestMapping("/getAttrs/{categoryId}")
    public String getAttrs(HttpServletRequest request,HttpServletResponse response,@PathVariable Long categoryId,ModelMap map){
        List<Attribute> attrs = attributeManager.getByCategoryId(categoryId);
        for(Attribute attr:attrs){
            List<AttributeValue> attVals = attributeValueManager.getByAttributeId(attr.getObjectId());
            attr.setAttributeValues(attVals);
        }
        map.put("attributes", attrs);
        return "jsonView";
    }
    @RequestMapping("/distributePage")
    public String distributePage(HttpServletRequest request,HttpServletResponse response){
        //通过角色找到所有的用户,角色代码为SPSH
        List<User> users = userManager.getUsersByRoleCode(ProductConstants.PRODUCT_CHECK_ROLE_CODE);
        request.setAttribute("users", users);
        //得到商品分类的树
        ProductCategory p = new ProductCategory();
        p.setStatus(IBSConstants.STATUS_YES);
        List<ProductCategory> categories = productCategoryManager.getBySample(p);
        request.setAttribute("nodes", buildNodes(categories));
        return getFileBasePath() + "checkDistributePage";
    }

    private String buildNodes(List<ProductCategory> productCategories) {
        StringBuilder leftNodes = new StringBuilder();
        leftNodes.append("[");
        for (ProductCategory productCategory1 : productCategories) {
            if (productCategory1.getLayer() == 1) {
                leftNodes.append("{id:" + productCategory1.getFirstId() + ", pId:" + BaseTree.ROOT + ", name:'" + productCategory1.getName()+ "', open:true,'layer':'1'},");
                for (ProductCategory productCategory2 : productCategories) {
                    if (productCategory2.getLayer() == 2 && productCategory2.getFirstId().equals(productCategory1.getFirstId())) {
                        leftNodes.append("{id:" + productCategory2.getSecondId() + ", pId:" + productCategory2.getFirstId() + ", name:'" + productCategory2.getName()+ "', open:true,'layer':'2'},");
                        for (ProductCategory productCategory3 : productCategories) {
                            if (productCategory3.getLayer() == 3 && productCategory3.getSecondId().equals(productCategory2.getSecondId()) &&
                                    productCategory3.getFirstId().equals(productCategory1.getFirstId())) {
                                leftNodes.append("{id:" + productCategory3.getThirdId() + ", pId:" + productCategory3.getSecondId() + ", name:'" + productCategory3.getName()+ "','layer':'3'},");
                            }
                        }
                    }
                }
            }
        }
        if(leftNodes.length()>1){
            return leftNodes.subSequence(0, leftNodes.length()-1)+ "]";
        }else{
            return leftNodes + "]";
        }
    }


    @RequestMapping("/saveDistribute")
    public String saveDistribute(HttpServletRequest request,HttpServletResponse response){
        String userIdStr = request.getParameter("userId");
        String categoryIdsStr = request.getParameter("categoryIds");
        String message = "增加成功";
        if(StringUtils.isNotBlank(userIdStr)&&StringUtils.isNotBlank(categoryIdsStr)){
            Long userId = Long.parseLong(userIdStr);
            String[] categoryIds = categoryIdsStr.split(",");
            try{
                attributeManager.savePM(categoryIds,userId);
            }catch(Exception e){
                LOGGER.error("save PM have a error\n"+e);
                message = "保存失败，请稍后重试";
            }
        }else{
            message = "保存失败，商品运营分类或者审核人不能为空";
        }
        return "redirect:/attribute/page"+getMessage(message, request)+ "&" + appendAjaxParameter(request);
    }
    @RequestMapping("/deleteValue/{attributeValueId}")
    public String deleteValue(HttpServletRequest request,HttpServletResponse response,@PathVariable Long attributeValueId,ModelMap map){
        boolean result = false;
        String message = "删除成功";
        Sku sku1 = new Sku();
        sku1.setAttributeId1(attributeValueId);
        sku1.setDeleted(0);
        Long count1 = skuManager.getObjectCount(sku1);

        Sku sku2 = new Sku();
        sku2.setAttributeId2(attributeValueId);
        sku2.setDeleted(0);
        Long count2 = skuManager.getObjectCount(sku2);
        if(count1.equals(0L)&&count2.equals(0L)){
            //删除
            AttributeValue attVal = new AttributeValue();
            attVal.setObjectId(attributeValueId);
            attributeValueManager.deleteBySample(attVal);
            result  = true;
        }else{
            message = "删除失败，已绑定有商品";
        }
        map.put("result", result);
        map.put("message", message);
        return "jsonView";
    }
}
