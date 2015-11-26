package com.handpay.ibenefit.insure.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.insure.entity.PastDisease;
import com.handpay.ibenefit.insure.service.IPastDiseaseManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/pastDisease")
public class PastDiseaseController extends PageController<PastDisease>{
    private static final String BASE_DIR = "insure/";

    @Reference(version = "1.0")
    private IPastDiseaseManager pastDiseaseManager;
    @Reference(version = "1.0")
    private IUserManager userManager;
    @Override
    public Manager<PastDisease> getEntityManager() {
        return pastDiseaseManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @RequestMapping("/deletePastDisease")
    public String deletePastDisease(HttpServletRequest request,HttpServletResponse response,ModelMap map){
        boolean result = false;
        String objectIds = request.getParameter("objectIds");
        if(StringUtils.isNotBlank(objectIds)){
           String[] ids = objectIds.split(",");
           for(String idStr:ids){
               Long objectId = Long.parseLong(idStr);
               delete(objectId);
           }
           result = true;
        }
        map.put("result", result);
        return "jsonView";
    }

    @Override
    protected String handlePage(HttpServletRequest request, PageSearch page) {
        if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"sortNo","objectId"});
            page.setSortOrders(new String[]{"asc nulls last","desc"});
        }
        handleFind(page);
        List<PastDisease> list = page.getList();
        for(PastDisease p:list){
            User user = userManager.getByObjectId(p.getCreatedBy());
            if(user!=null){
                p.setCreator(user.getUserName());
            }
        }
        request.setAttribute("action", "page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }
}
