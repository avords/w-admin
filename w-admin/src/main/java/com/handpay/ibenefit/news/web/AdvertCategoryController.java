package com.handpay.ibenefit.news.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.news.entity.AdvertCategory;
import com.handpay.ibenefit.news.service.IAdvertCategoryManager;

@Controller
@RequestMapping("/advert/category")
public class AdvertCategoryController extends PageController<AdvertCategory>{

    private static final String BASE_DIR = "news/";

    @Reference(version="1.0")
    private IAdvertCategoryManager advertCategoryManager;

    @Override
    public Manager<AdvertCategory> getEntityManager() {
        return advertCategoryManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

	@RequestMapping(value = "/secondCategory/{firstId}")
    public String getSecondCategoryByFirstId(HttpServletRequest request, HttpServletResponse response,@PathVariable String firstId,ModelMap map) throws Exception {
        Map<String,Object> param = new HashMap<String,Object>();
        String type  = request.getParameter("type");
        param.put("firstId", firstId);
        param.put("type", type);
	    List<AdvertCategory> secondCategory = advertCategoryManager.getSecondCategoryByParam(param);
	    map.put("secondCategory", secondCategory);
	    return "jsonView";
    }

	@RequestMapping(value = "/thirdCategory/{secondId}")
    public String getThirdCategoryByFirstId(HttpServletRequest request, HttpServletResponse response,@PathVariable String secondId,ModelMap map) throws Exception {
        Map<String,Object> param = new HashMap<String,Object>();
        String type  = request.getParameter("type");
        param.put("secondId", secondId);
        param.put("type", type);
        List<AdvertCategory> thirdCategory = advertCategoryManager.getThirdCategoryByParam(param);
        map.put("thirdCategory", thirdCategory);
        return "jsonView";
    }
	
	/*@RequestMapping(value = "/getCategory/{ThirdId}")
    public String getCategoryByThirdtId(HttpServletRequest request, HttpServletResponse response,@PathVariable String ThirdId,ModelMap map) throws Exception {
		page.getFilters().add(new PropertyFilter(getEntityName(),"EQI_status","3"));
	    map.put("secondCategory", secondCategory);
	    return "jsonView";
    }*/

}
