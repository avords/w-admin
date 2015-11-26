package com.handpay.ibenefit.insure.web;

import java.io.Writer;
import java.util.HashMap;
import java.util.List;
import java.util.Locale;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.util.LocaleUtils;
import com.handpay.ibenefit.framework.util.MessageUtils;
import com.handpay.ibenefit.insure.entity.InsureRange;
import com.handpay.ibenefit.insure.entity.PastDisease;
import com.handpay.ibenefit.insure.entity.SpecUsing;
import com.handpay.ibenefit.insure.service.IInsureRangeManager;
import com.handpay.ibenefit.insure.service.IPastDiseaseManager;
import com.handpay.ibenefit.insure.service.ISpecUsingManager;

@Controller
@RequestMapping("/insureSpec")
public class InsureSpecController {
    private static final String BASE_DIR = "insure/";
    private static final String FIRST_CATEGORY_NAME="i保险";
    @Reference(version = "1.0")
    private IProductCategoryManager productCategoryManager;
    @Reference(version = "1.0")
    private IDictionaryManager dictionaryManager;
    @Reference(version = "1.0")
    private ISpecUsingManager specUsingManager;
    @Reference(version = "1.0")
    private IInsureRangeManager insureRangeManager;
    @Reference(version = "1.0")
    private IPastDiseaseManager pastDiseaseManager;
    @RequestMapping("/setPage")
    public String setPage(HttpServletRequest request,HttpServletResponse response) throws Exception{
        ProductCategory firstCategory = new ProductCategory();
        firstCategory.setName(FIRST_CATEGORY_NAME);
        firstCategory.setLayer(1);
        firstCategory.setStatus(IBSConstants.STATUS_YES);
        List<ProductCategory> pcs = productCategoryManager.getBySample(firstCategory);
        if(pcs.size()>0){
            firstCategory = pcs.get(0);
        }else{
            firstCategory = null;
        }
        if(firstCategory==null){
            Writer writer = response.getWriter();
            writer.write("请建立名字为"+FIRST_CATEGORY_NAME+"的分类");
            writer.flush();
            writer.close();
            return null;
        }else{
            //得到所有的二级分类
            Map<String,Object> map = new HashMap<String,Object>();
            map.put("firstId", firstCategory.getFirstId());
            List<ProductCategory> secondCategorys = productCategoryManager.getSecondCategoryByParam(map);
            request.setAttribute("firstCategory", firstCategory);
            request.setAttribute("secondCategorys", secondCategorys);
        }
        return BASE_DIR+"insureSpec";
    }
    @RequestMapping("/editAttributeValue/{attributeValueId}")
    public String editAttributeValue(HttpServletRequest request,HttpServletResponse response,@PathVariable Long attributeValueId){
        //启用参数的字典查询
        List<Dictionary> usingPara = dictionaryManager.getDictionariesByDictionaryId(3000);
        //查询启用参数的情况
        SpecUsing specUsing = specUsingManager.getByAttributeValueId(attributeValueId);
        //年龄阶段字典
        List<Dictionary> ageDictionary = dictionaryManager.getDictionariesByDictionaryId(3001);
        //年龄阶段别名和单选情况
        InsureRange ageRange = insureRangeManager.getByAttributeValueIdAndType(attributeValueId,InsureRange.AGE);
        //年龄阶段选择情况
        List<Integer> ageUsing = insureRangeManager.getRangeItemByAttributeValueIdAndType(attributeValueId,InsureRange.AGE);
        //职业类型字典
        List<Dictionary> jobDictionary = dictionaryManager.getDictionariesByDictionaryId(3002);
        //职业类别别名和单选情况
        InsureRange jobRange = insureRangeManager.getByAttributeValueIdAndType(attributeValueId,InsureRange.JOB);
        //职业类型选择情况
        List<Integer> jobUsing = insureRangeManager.getRangeItemByAttributeValueIdAndType(attributeValueId,InsureRange.JOB);
        //社保类型字典
        List<Dictionary> socialDictionary = dictionaryManager.getDictionariesByDictionaryId(3003);
        //社保类型别名和单选情况
        InsureRange socialRange = insureRangeManager.getByAttributeValueIdAndType(attributeValueId,InsureRange.SOCIAL);
        //社保类型选择情况
        List<Integer> socialUsing = insureRangeManager.getRangeItemByAttributeValueIdAndType(attributeValueId,InsureRange.SOCIAL);
        //无参保病史读取
        PastDisease pastDisease = new PastDisease();
        pastDisease.setDeleted(IBSConstants.STATUS_NO);
        List<PastDisease> pastDiseaseList = pastDiseaseManager.getBySample(pastDisease);
        //午餐包病史别名和单选情况
        InsureRange pastDiseaseRange = insureRangeManager.getByAttributeValueIdAndType(attributeValueId,InsureRange.DISEASE);
        //无参保病史选择情况
        List<Integer> pastDiseaseUsing = insureRangeManager.getRangeItemByAttributeValueIdAndType(attributeValueId,InsureRange.DISEASE);

        request.setAttribute("usingPara", usingPara);
        request.setAttribute("specUsing", specUsing);

        request.setAttribute("ageDictionary", ageDictionary);
        request.setAttribute("ageRange", ageRange);
        request.setAttribute("ageUsing", ageUsing);

        request.setAttribute("jobDictionary", jobDictionary);
        request.setAttribute("jobRange", jobRange);
        request.setAttribute("jobUsing", jobUsing);

        request.setAttribute("socialDictionary", socialDictionary);
        request.setAttribute("socialRange", socialRange);
        request.setAttribute("socialUsing", socialUsing);

        request.setAttribute("pastDiseaseList", pastDiseaseList);
        request.setAttribute("pastDiseaseRange", pastDiseaseRange);
        request.setAttribute("pastDiseaseUsing", pastDiseaseUsing);
        request.setAttribute("attributeValueId", attributeValueId);
        return BASE_DIR+"editAttributeValue";
    }

    @RequestMapping("/saveAttributeValue/{attributeValueId}")
    public String saveAttributeValue(HttpServletRequest request,HttpServletResponse response,@PathVariable Long attributeValueId){
        //启用参数选择情况
        String message = "保存成功";
        String[] usingParam = request.getParameterValues("useParam_item");
        SpecUsing specUsing = new SpecUsing();
        specUsing.setAttributeValueId(attributeValueId);
        for(String typeStr:usingParam){
            Integer type = Integer.parseInt(typeStr);
            if(type==InsureRange.AGE){
                saveRangeItem(attributeValueId, type, "age_", request);
                specUsing.setIsAge(IBSConstants.STATUS_YES);
            }else if(type==InsureRange.JOB){
                saveRangeItem(attributeValueId, type, "job_", request);
                specUsing.setIsJob(IBSConstants.STATUS_YES);
            }else if(type==InsureRange.SOCIAL){
                saveRangeItem(attributeValueId, type, "social_", request);
                specUsing.setIsSocial(IBSConstants.STATUS_YES);
            }else if(type==InsureRange.DISEASE){
                saveRangeItem(attributeValueId, type, "disease_", request);
                specUsing.setIsDisease(IBSConstants.STATUS_YES);
            }
        }
        //先清空没有启用的range
        InsureRange deleteInsureRange = new InsureRange();
        deleteInsureRange.setAttributeValueId(attributeValueId);
        if(specUsing.getIsAge()==null||specUsing.getIsAge()==IBSConstants.STATUS_NO){
            deleteInsureRange.setType(InsureRange.AGE);
            insureRangeManager.deleteBySample(deleteInsureRange);
        }else if(specUsing.getIsJob()==null||specUsing.getIsJob()==IBSConstants.STATUS_NO){
            deleteInsureRange.setType(InsureRange.JOB);
            insureRangeManager.deleteBySample(deleteInsureRange);
        }else if(specUsing.getIsSocial()==null||specUsing.getIsSocial()==IBSConstants.STATUS_NO){
            deleteInsureRange.setType(InsureRange.SOCIAL);
            insureRangeManager.deleteBySample(deleteInsureRange);
        }else if(specUsing.getIsDisease()==null||specUsing.getIsDisease()==IBSConstants.STATUS_NO){
            deleteInsureRange.setType(InsureRange.DISEASE);
            insureRangeManager.deleteBySample(deleteInsureRange);
        }
        SpecUsing deleteSpec = new SpecUsing();
        deleteSpec.setAttributeValueId(attributeValueId);
        specUsingManager.deleteBySample(deleteSpec);
        specUsingManager.save(specUsing);
        //清空没有启用的range里面的值
        return "redirect:/insureSpec/editAttributeValue/"+attributeValueId+getMessage(message, request)+"&ajax=1";
    }

    private void saveRangeItem(Long attributeValueId,Integer type,String prefix,HttpServletRequest request){
        String objectIdStr = request.getParameter(prefix+"objectId");
        Long objectId = null;
        if(StringUtils.isNotBlank(objectIdStr)){
            objectId = Long.parseLong(objectIdStr);
        }
        String alias = request.getParameter(prefix+"alias");
        Integer isRadio = Integer.parseInt(request.getParameter(prefix+"option"));
        InsureRange insureRange = new InsureRange();
        insureRange.setObjectId(objectId);
        insureRange.setAttributeValueId(attributeValueId);
        insureRange.setAlias(alias);
        insureRange.setIsRadio(isRadio);
        insureRange.setType(type);
        insureRange = insureRangeManager.save(insureRange);

        //清空item
        Long rangeId = insureRange.getObjectId();
        insureRangeManager.deleteRangeItemByRangeId(rangeId);
        String[] items = request.getParameterValues(prefix+"item");
        for(String item:items){
            //插入item
            Integer itemId = Integer.parseInt(item);
            insureRangeManager.saveRangeItem(rangeId,itemId);
        }
    }

    protected String getMessage(String message, HttpServletRequest request) {
        Locale locale = LocaleUtils.getLocale(request);
        return com.handpay.ibenefit.framework.web.MessageUtils.getMessage(MessageUtils.getMessage(message, locale));
    }
}
