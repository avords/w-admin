package com.handpay.ibenefit.news.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.news.entity.Advert;
import com.handpay.ibenefit.news.entity.AdvertReject;
import com.handpay.ibenefit.news.service.IAdvertManager;
import com.handpay.ibenefit.news.service.IAdvertRejectManager;

@Controller
@RequestMapping("/advertReject")
public class AdvertRejectController extends PageController<AdvertReject>{
	private static final String BASE_DIR = "news/";
	
	@Reference(version = "1.0")
	private IAdvertRejectManager advertRejectManager;
	
	@Reference(version = "1.0")
	private IAdvertManager advertManager;
	
	@Override
	public Manager<AdvertReject> getEntityManager() {
		return advertRejectManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handleSaveToPage(HttpServletRequest request, ModelMap modelMap,
			AdvertReject t) throws Exception {
		String advertId=request.getParameter("id");
		
		Advert advert=advertManager.getByObjectId(Long.parseLong(advertId));
		
		advert.setStatus(4);
		advert.setCheckDate(new Date());
		advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
		advertManager.save(advert);
		
		t.setAdvertId(Long.parseLong(advertId));
		t.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
		getManager().save(t);
		
		PageSearch pageSearch = super.preparePage(request);
		pageSearch.setEntityClass(Advert.class);
		pageSearch = advertManager.find(pageSearch);
		afterPage(request, pageSearch, IS_NOT_BACK);
		request.setAttribute("action", "page");
		
		return "news/listAdvert";
	}
	
}
