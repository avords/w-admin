package com.handpay.ibenefit.news.web;

import java.util.Date;
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
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.news.entity.NewsNotify;
import com.handpay.ibenefit.news.entity.NewsReject;
import com.handpay.ibenefit.news.service.IAdvertManager;
import com.handpay.ibenefit.news.service.INewsNotifyManager;
import com.handpay.ibenefit.news.service.INewsRejectManager;

@Controller
@RequestMapping("/newsnotify")
public class NewsNotifyController extends PageController<NewsNotify> {

	private static final String BASE_DIR = "news/";
	
	@Reference(version = "1.0")
	private INewsNotifyManager newsNotifyManager;
	
	@Reference(version = "1.0")
	private IAdvertManager  advertManager;
	
	@Reference(version = "1.0")
	private IAreaManager  areaManager;

	@Reference(version = "1.0")
	private INewsRejectManager newsRejectManager;

	@Override
	public Manager<NewsNotify> getEntityManager() {
		return newsNotifyManager;
	}
	
	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		getManager().delete(objectId);
		return "redirect:../page";
	}
	
	@Override
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		if (null != objectId){
			NewsNotify entity = newsNotifyManager.getByObjectId(objectId);
			 Long newsId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("newsId", newsId);
	        List<String> selectedSellArea = advertManager.getNewsArea(map3);
	        String sellAreas = "";
	        String sellAreaNames = "";
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
	        request.setAttribute("selectedSellArea", selectedSellArea);
           request.setAttribute("sellAreas", sellAreas);
           request.setAttribute("sellAreaNames", sellAreaNames);
		}
       
		return super.handleEdit(request, response, objectId);
		
	}
	
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,NewsNotify t) throws Exception {
		 //区分保存和提交审核的动作
		String verify=request.getParameter("verify");
		if(t.getObjectId() != null){
			t.setUpdateDate(new Date());
			t.setUpdateUserId(FrameworkContextUtils.getCurrentLoginName());
		}
		else{
			 t.setCreateUserId(FrameworkContextUtils.getCurrentLoginName());
			 t.setCreateDate(new Date());
		}
		
		if(verify.equals("1")){ //提交审核
			t.setStatus(3);
		}
		else{
			t.setStatus(1);
		}
		if(t.getPriority() < 0){
			t.setPriority(0F);
		}
		t.setIsDeleted(0);
		t = save(t); 
		saveSellArea(request,t.getObjectId());
		return "redirect:page"+ getMessage("common.base.success", request);
	}
	
	@RequestMapping(value = "/detail/{objectId}")
	public String detail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			NewsNotify entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			
		}
		NewsReject newsReject = new NewsReject();
		newsReject.setNewsId(objectId);
		List<NewsReject> newsRejects = newsRejectManager.getBySample(newsReject);
		if(newsRejects.size()>0){
			newsReject = newsRejects.get(newsRejects.size()-1);
		}
		String remark  = newsReject.getRemark();
		if (null != objectId){
			NewsNotify entity = getManager().getByObjectId(objectId);
			Long newsId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("newsId", newsId);
	        List<String> selectedSellArea = advertManager.getNewsArea(map3);
	        String sellAreas = "";
	        String sellAreaNames = "";
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
	       request.setAttribute("selectedSellArea", selectedSellArea);
          request.setAttribute("sellAreas", sellAreas);
          request.setAttribute("sellAreaNames", sellAreaNames);
		}
		request.setAttribute("remark", remark);
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"Detail";
	}
	
	@RequestMapping(value = "/verifyDetail/{objectId}")
	public String verifyDetail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			NewsNotify entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			
		}
		if (null != objectId){
			NewsNotify entity = getManager().getByObjectId(objectId);
			Long newsId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("newsId", newsId);
	        List<String> selectedSellArea = advertManager.getNewsArea(map3);
	        String sellAreas = "";
	        String sellAreaNames = "";
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
	       request.setAttribute("selectedSellArea", selectedSellArea);
          request.setAttribute("sellAreas", sellAreas);
          request.setAttribute("sellAreaNames", sellAreaNames);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"VerifyDetail";
	}
	
	/*
	 * 撤销发布
	 */
	@RequestMapping(value = "/cancel/{objectId}")
	public String advertCancel(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			NewsNotify entity = getManager().getByObjectId(objectId);
			entity.setStatus(1);
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
			area.setDeepLevel(1);
			List<Area> firstArea = areaManager.getBySample(area);
			request.setAttribute("firstArea", firstArea);
			PageSearch result = newsNotifyManager.getNews(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			//return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/newsnotify/page";
	}
	
	/*
	 * 发布
	 */
	@RequestMapping(value = "/publish/{objectId}")
	public String advertPublish(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			NewsNotify entity = getManager().getByObjectId(objectId);
			entity.setStatus(2);
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
			area.setDeepLevel(1);
			List<Area> firstArea = areaManager.getBySample(area);
			request.setAttribute("firstArea", firstArea);
			PageSearch result = newsNotifyManager.getNews(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			//return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/newsnotify/page";
	}
	/*
	 * 
	 * 下线
	 */
	@RequestMapping(value = "/down/{objectId}")
	public String downAdvert(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			NewsNotify entity = getManager().getByObjectId(objectId);
			entity.setStatus(6);
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
			area.setDeepLevel(1);
			List<Area> firstArea = areaManager.getBySample(area);
			request.setAttribute("firstArea", firstArea);
			PageSearch result = newsNotifyManager.getNews(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			//return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/newsnotify/page";
	}
	
	
	/*
	 * 
	 * 提交审核
	 */
	@RequestMapping(value = "/toCheck/{objectId}")
	public String toCheck(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			NewsNotify entity = getManager().getByObjectId(objectId);
			entity.setStatus(3);
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
			area.setDeepLevel(1);
			List<Area> firstArea = areaManager.getBySample(area);
			request.setAttribute("firstArea", firstArea);
			PageSearch result = newsNotifyManager.getNews(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			//return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/newsnotify/page";
	}
	
	
	
	/*
	 * 广告审核功能
	 */
	@RequestMapping(value = "/check")
	public String ckeckAdvert(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		/* *checkPass = 1  ---审核通过
		 *  checkPass = 1  ---审核不通过
		 *  release = 1    ----立即发布
		 *  release = 2    ----延迟发布
		 */
		NewsNotify newsNotify  =  null;
		Date nowDate = new Date();
		String objectId = request.getParameter("objectId"); 
		String checkPass = request.getParameter("check");  //是否通过审核
		String release  = request.getParameter("release"); //是否立即发布
		request.setAttribute("objectId", objectId);
		if(null != objectId){
			newsNotify  = newsNotifyManager.getByObjectId(Long.parseLong(objectId));
		}
		//通过审核的情况下
		if(checkPass.equals("1")){
			//立即发布
			if(release.equals("1")){
				//结束时间在当前时间之后，统一置为已发布
				if(newsNotify.getEndDate().after(nowDate)){
					newsNotify.setStartDate(nowDate);
					newsNotify.setStatus(2);
					newsNotify.setCheckDate(new Date());
					newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
				}
				//否则审核不通过
				else{
					newsNotify.setStatus(4);
					newsNotify.setCheckDate(new Date());
					newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
					NewsReject  newsReject = new NewsReject();
				    newsReject.setNewsId(newsNotify.getObjectId());
				    List<NewsReject> newsRejects = newsRejectManager.getBySample(newsReject);
				    if(newsRejects.size()>0){
				        	newsReject = newsRejects.get(0);
				        	newsReject.setNewsId(newsNotify.getObjectId());
				        	newsReject.setCheckDate(new Date());
				        	newsReject.setRemark("有效期已过！");
				        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	newsRejectManager.save(newsReject);
				        }
				        else{
				        	newsReject.setNewsId(newsNotify.getObjectId());
				        	newsReject.setCheckDate(new Date());
				        	newsReject.setRemark("有效期已过！");
				        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	newsRejectManager.save(newsReject);
				        }
				}
				
			}
			//延迟发布
			else{
				//系统时间在开始时间之前置为待发布
				if(nowDate.before(newsNotify.getStartDate())){
					newsNotify.setStatus(5);
					newsNotify.setCheckDate(new Date());
					newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
				}
				//系统时间在开始时间和结束时间中间置为已发布
				else if(newsNotify.getStartDate().before(nowDate)&&newsNotify.getEndDate().after(nowDate)){
					newsNotify.setStartDate(nowDate);
					newsNotify.setStatus(2);
					newsNotify.setCheckDate(new Date());
					newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
				}
				////系统时间在结束时间之后，置为审核不通过
				else{
					newsNotify.setStatus(4);
					newsNotify.setCheckDate(new Date());
					newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
					NewsReject  newsReject = new NewsReject();
				    newsReject.setNewsId(newsNotify.getObjectId());
				    List<NewsReject> newsRejects = newsRejectManager.getBySample(newsReject);
				    if(newsRejects.size()>0){
				        	newsReject = newsRejects.get(0);
				        	newsReject.setNewsId(newsNotify.getObjectId());
				        	newsReject.setCheckDate(new Date());
				        	newsReject.setRemark("有效期已过！");
				        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	newsRejectManager.save(newsReject);
				        }
				        else{
				        	newsReject.setNewsId(newsNotify.getObjectId());
				        	newsReject.setCheckDate(new Date());
				        	newsReject.setRemark("有效期已过！");
				        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	newsRejectManager.save(newsReject);
				        }
				}
				
			}
			getManager().save(newsNotify);
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		    PageSearch page  = preparePage(request);
		    PageSearch result = newsNotifyManager.getVerityNewsNotify(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			return getFileBasePath() + "listVerifyNewsNotify";
		}
		//审核不通过
		else{
			request.setAttribute("objectId", objectId);
			return "news/checkNewsReject";
		}
	}
	
	@RequestMapping("/verify")
	public String verifyAdvert(HttpServletRequest request) {
		String province = request.getParameter("search_LIKES_province");
		String city = request.getParameter("search_LIKES_city");
		request.setAttribute("province", province);
		request.setAttribute("city", city);
		Area area = new Area();
	    area.setDeepLevel(1);
	    List<Area> firstArea = areaManager.getBySample(area);
	    request.setAttribute("firstArea", firstArea);
	    PageSearch page  = preparePage(request);
	    PageSearch result = newsNotifyManager.getVerityNewsNotify(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "news/listVerifyNewsNotify";
	}
	
	public void saveSellArea(HttpServletRequest request, Long newsId){
        //根据状态和商品id情况数据
        Map<String,Object> m = new HashMap<String,Object>();
        m.put("newsId", newsId);
        advertManager.deleteNewsArea(m);
        
        String sellAreas = request.getParameter("sellAreas");
        if(sellAreas.length()>0){
        	if(StringUtils.isNotBlank(sellAreas)){
                String[] sellAreaCodes = sellAreas.split(",");
                for(String areaCode:sellAreaCodes){
                    Map<String,Object> map = new HashMap<String,Object>();
                    map.put("newsId", newsId);
                    map.put("areaCode", areaCode);
                    if(newsId!=null&&StringUtils.isNotBlank(areaCode)){
                    	advertManager.saveNewsArea(map);
                    }
                }
            }
        }
        else{
        	Map<String,Object> map = new HashMap<String,Object>();
            map.put("newsId", newsId);
            map.put("areaCode", 1);
            advertManager.saveNewsArea(map);
        }
        
    }
	
	@RequestMapping(value = "/todetail/{objectId}")
	public String todetail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			NewsNotify entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			
		}
		if (null != objectId){
			NewsNotify entity = getManager().getByObjectId(objectId);
			Long newsId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("newsId", newsId);
	        List<String> selectedSellArea = advertManager.getNewsArea(map3);
	        String sellAreas = "";
	        String sellAreaNames = "";
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
	      request.setAttribute("selectedSellArea", selectedSellArea);
          request.setAttribute("sellAreas", sellAreas);
          request.setAttribute("sellAreaNames", sellAreaNames);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"Check";
	}
	@RequestMapping(value = "/saveCheckReason")
    public String saveCheckReason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String message = "保存成功!";
		String haha = request.getParameter("objectId");
	 	Long objectId = Long.parseLong(request.getParameter("objectId"));
	 	NewsNotify newsNotify = newsNotifyManager.getByObjectId(objectId);
		newsNotify.setStatus(4);
		newsNotify.setCheckDate(new Date());
		newsNotify.setCheckPerson(FrameworkContextUtils.getCurrentLoginName());
		getManager().save(newsNotify);
        String remark = request.getParameter("remark");
        NewsReject  newsReject = new NewsReject();
        newsReject.setNewsId(objectId);
        List<NewsReject> newsRejects = newsRejectManager.getBySample(newsReject);
        if(newsRejects.size()>0){
        	newsReject = newsRejects.get(0);
        	newsReject.setNewsId(objectId);
        	newsReject.setCheckDate(new Date());
        	newsReject.setRemark(remark);
        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
        	newsRejectManager.save(newsReject);
        }
        else{
        	newsReject.setNewsId(objectId);
        	newsReject.setCheckDate(new Date());
        	newsReject.setRemark(remark);
        	newsReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
        	newsRejectManager.save(newsReject);
        }
        request.setAttribute("message", message);
        return "news/checkNewsReject";
    }
	
	@RequestMapping("getCity/{provinceId}")
	public String getCity(HttpServletRequest request, HttpServletResponse response,ModelMap map,@PathVariable Long provinceId) {
        boolean result = false;
	    Area area = new Area();
        area.setDeepLevel(2);
        area.setParentId(provinceId);
        List<Area> citys = areaManager.getBySample(area);
        result = true;
        map.put("result", result);
        map.put("citys", citys);
        return "jsonView";
    }
	
	@Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
		 String province = request.getParameter("search_LIKES_province");
		 String city = request.getParameter("search_LIKES_city");
		 request.setAttribute("province", province);
		 request.setAttribute("city", city);
		 Area area = new Area();
		 area.setDeepLevel(1);
		 List<Area> firstArea = areaManager.getBySample(area);
		 request.setAttribute("firstArea", firstArea);
		
		 PageSearch result = newsNotifyManager.getNews(page);
		 page.setTotalCount(result.getTotalCount());
		 page.setList(result.getList());
		 afterPage(request, page, PageUtils.IS_NOT_BACK);
		 return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	    }
	 @RequestMapping(value = "/top/{objectId}")
     public String top(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
		            throws Exception {
		 //缃�鐨勪负闆�
		 Map<String,Object> param = new HashMap<String,Object>();
		        param.put("isTopWhere", 1);
		        param.put("isTopValue", 0);
		        newsNotifyManager.updateIsTopByParam(param);
		        //
		        Map<String,Object> param1 = new HashMap<String,Object>();
		        param1.put("objectId", objectId);
		        param1.put("isTopValue", 1);
		        newsNotifyManager.updateIsTopByParam(param1);
		        return "redirect:/newsnotify/page";
		    }
	 	@RequestMapping(value = "/toDelete/{objectId}")
		public String toDelete(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
				throws Exception {
				NewsNotify entity = getManager().getByObjectId(objectId);
				entity.setIsDeleted(1);
				getManager().save(entity);
				PageSearch page  = preparePage(request);
				Area area = new Area();
				area.setDeepLevel(1);
				List<Area> firstArea = areaManager.getBySample(area);
				request.setAttribute("firstArea", firstArea);
				PageSearch result = newsNotifyManager.getNews(page);
				page.setTotalCount(result.getTotalCount());
				page.setList(result.getList());
				afterPage(request, page, PageUtils.IS_NOT_BACK);
				//return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
				return "redirect:/newsnotify/page";
		} 
}
