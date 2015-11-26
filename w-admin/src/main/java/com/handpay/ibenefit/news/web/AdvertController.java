package com.handpay.ibenefit.news.web;

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
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.entity.AbstractEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.news.entity.Advert;
import com.handpay.ibenefit.news.entity.AdvertReject;
import com.handpay.ibenefit.news.service.IAdvertCategoryManager;
import com.handpay.ibenefit.news.service.IAdvertManager;
import com.handpay.ibenefit.news.service.IAdvertRejectManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/advert")
public class AdvertController extends PageController<Advert> {

	private static final String BASE_DIR = "news/";
	
	@Reference(version = "1.0")
	private IAdvertManager advertManager;
	
	@Reference(version="1.0")
	private IFileManager fileManager;
	
	@Reference(version="1.0")
	private IAdvertCategoryManager advertCategoryManager;
	
	@Reference(version="1.0")
	private IUserManager userManager;
	
	@Reference(version="1.0")
    private IAreaManager areaManager;
	
	@Reference(version="1.0")
    private IAdvertRejectManager  advertRejectManager;

	@Override
	public Manager<Advert> getEntityManager() {
		return advertManager;
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
		
		 //得到广告区域
		if (null != objectId){
			 Advert entity = advertManager.getByObjectId(objectId);
			 Long AdvertId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("AdvertId", AdvertId);
	        List<String> selectedSellArea = advertManager.getAdvertArea(map3);
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
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,Advert t) throws Exception {
		if(t.getObjectId()!=null){
	            Long objectId = t.getObjectId();
	            t.setUpdateUser(FrameworkContextUtils.getCurrentLoginName());
	            t.setUpdateUserId(FrameworkContextUtils.getCurrentUserId());
	            t.setUpdateDate(new Date());
	            Advert advert = advertManager.getByObjectId(objectId);
	            if(StringUtils.isNotBlank(t.getPicturePath())&&!t.getPicturePath().equals(advert.getPicturePath())){
	                fileManager.deleteFile(advert.getPicturePath());
	            }else if(StringUtils.isBlank(t.getPicturePath())&&StringUtils.isNotBlank(advert.getPicturePath())){
	                fileManager.deleteFile(advert.getPicturePath());
	            }
	        }
		else{
			t.setCreateUserId(FrameworkContextUtils.getCurrentUserId());
	        t.setCreateUser(FrameworkContextUtils.getCurrentLoginName());
			t.setCreateDate(new Date());
			t.setUpdateDate(new Date());
		}
		 //区分保存和提交审核的动作
		String verify=request.getParameter("verifyInput");
		
		if(verify!=null && verify.equals("1")){ //提交审核
			t.setStatus(3);
		} else {
			t.setStatus(1);
		}
		if(t.getPriority() < 0){
			t.setPriority(0F);
		}
		t.setIsDeleted(0); 
		t = save(t); 
		if(Integer.parseInt(t.getRecommendPlatform()) != 2){
			saveSellArea(request,t.getObjectId());
		}
		
		return "redirect:page";
	}
	
	@RequestMapping(value = "/detail/{objectId}")
	public String detail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			Advert entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			
		}
		AdvertReject advertReject = new AdvertReject();
		advertReject.setAdvertId(objectId);
		List<AdvertReject> advertRejects = advertRejectManager.getBySample(advertReject);
		if(advertRejects.size() > 0){
			advertReject = advertRejects.get(advertRejects.size()-1);
		}
		String remark = advertReject.getRejectContent();
		if (null != objectId){
			 Advert entity = advertManager.getByObjectId(objectId);
			 Long AdvertId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("AdvertId", AdvertId);
	        List<String> selectedSellArea = advertManager.getAdvertArea(map3);
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
           request.setAttribute("remark", remark);
		}
		
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName()+"Detail";
	}
	
	@RequestMapping(value = "/verifyDetail/{objectId}")
	public String verifyDetail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			Advert entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			
		}
		if (null != objectId){
			 Advert entity = advertManager.getByObjectId(objectId);
			 Long AdvertId = entity.getObjectId();
			Map<String,Object> map3 = new HashMap<String,Object>();
	        map3.put("AdvertId", AdvertId);
	        List<String> selectedSellArea = advertManager.getAdvertArea(map3);
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
			Advert entity = getManager().getByObjectId(objectId);
			entity.setStatus(1);
			entity.setUpdateDate(new Date());
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		 	PageSearch result = advertManager.getAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
	     //   return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/advert/page";
	}
	
	/*
	 * 发布
	 */
	@RequestMapping(value = "/publish/{objectId}")
	public String advertPublish(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			Advert entity = getManager().getByObjectId(objectId);
			entity.setStatus(2);
			entity.setUpdateDate(new Date());
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		 	PageSearch result = advertManager.getAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
	       // return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/advert/page";
	}
	/*
	 * 
	 * 下线
	 */
	@RequestMapping(value = "/down/{objectId}")
	public String downAdvert(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			Advert entity = getManager().getByObjectId(objectId);
			entity.setStatus(6);
			entity.setUpdateDate(new Date());
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		 	PageSearch result = advertManager.getAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
	       // return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
			return "redirect:/advert/page";
	}
	
	
	/*
	 * 
	 * 提交审核
	 */
	@RequestMapping(value = "/toCheck/{objectId}")
	public String toCheck(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
			Advert entity = getManager().getByObjectId(objectId);
			entity.setStatus(3);
			entity.setUpdateDate(new Date());
			getManager().save(entity);
			PageSearch page  = preparePage(request);
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		 	PageSearch result = advertManager.getAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
	       // return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	        return "redirect:/advert/page";
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
	    PageSearch result = advertManager.getVerityAdvert(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "news/listVerifyAdvert";
	}
	
	
	/*
	 * 广告审核功能
	 */
	@RequestMapping(value = "/check")
	public String ckeckAdvert(HttpServletRequest request, HttpServletResponse response)
			throws Exception {
		
		/* *  checkPass = 1  ---审核通过
		 *  checkPass = 1  ---审核不通过
		 *  release = 1    ----立即发布
		 *  release = 2    ----延迟发布
		 */
		Advert advert  =  null;
		Date nowDate = new Date();
		String objectId = request.getParameter("objectId"); 
		String checkPass = request.getParameter("check");  //是否通过审核
		String release  = request.getParameter("release"); //是否立即发布
		request.setAttribute("objectId", objectId);
		if(null != objectId){
			 advert  = advertManager.getByObjectId(Long.parseLong(objectId));
		}
		//通过审核的情况下
		if(checkPass.equals("1")){
			//立即发布
			if(release.equals("1")){
				//系统时间在结束时间之后，置为已发布
				if(advert.getEndDate().after(nowDate)){
					advert.setStartDate(nowDate);
					advert.setStatus(2);
					advert.setCheckDate(new Date());
					advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
					advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
				}
				//结束时间在系统时间之前，置为审核不通过
				else {
					advert.setStatus(4);
					advert.setCheckDate(new Date());
					advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
					advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
					AdvertReject  advertReject = new AdvertReject();
				    advertReject.setAdvertId(advert.getObjectId());
				    List<AdvertReject> advertRejects = advertRejectManager.getBySample(advertReject);
				    if(advertRejects.size()>0){
				        	advertReject = advertRejects.get(0);
				        	advertReject.setAdvertId(advert.getObjectId());
				        	advertReject.setCheckDate(new Date());
				        	advertReject.setRejectContent("有效期已过");
				        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	advertRejectManager.save(advertReject);
				        }
				        else{
				        	advertReject.setAdvertId(advert.getObjectId());
				        	advertReject.setCheckDate(new Date());
				        	advertReject.setRejectContent("有效期已过！");
				        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	advertRejectManager.save(advertReject);
				        }
				}
				
			}
			//延迟发布
			else{
				//系统时间在开始时间之前，置为待发布
				if(nowDate.before(advert.getStartDate())){
					advert.setStatus(5);
					advert.setCheckDate(new Date());
					advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
					advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
				}
				//系统时间在开始时间和结束时间之间,置为已发布
				else if(advert.getStartDate().before(nowDate)&&advert.getEndDate().after(nowDate)){
					advert.setStartDate(nowDate);
					advert.setStatus(2);
					advert.setCheckDate(new Date());
					advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
					advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
				}
				//系统时间在结束时间之后，置为审核不通过
				else if(nowDate.after(advert.getEndDate())){
					advert.setStatus(4);
					advert.setCheckDate(new Date());
					advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
					advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
					AdvertReject  advertReject = new AdvertReject();
				    advertReject.setAdvertId(advert.getObjectId());
				    List<AdvertReject> advertRejects = advertRejectManager.getBySample(advertReject);
				    if(advertRejects.size()>0){
				        	advertReject = advertRejects.get(0);
				        	advertReject.setAdvertId(advert.getObjectId());
				        	advertReject.setCheckDate(new Date());
				        	advertReject.setRejectContent("有效期已过");
				        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	advertRejectManager.save(advertReject);
				        }
				        else{
				        	advertReject.setAdvertId(advert.getObjectId());
				        	advertReject.setCheckDate(new Date());
				        	advertReject.setRejectContent("有效期已过！");
				        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
				        	advertRejectManager.save(advertReject);
				        }
				}
				
				

			}
			getManager().save(advert);
			
			Area area = new Area();
		    area.setDeepLevel(1);
		    List<Area> firstArea = areaManager.getBySample(area);
		    request.setAttribute("firstArea", firstArea);
		    PageSearch page  = preparePage(request);
		    PageSearch result = advertManager.getVerityAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			return "news/listVerifyAdvert";
			
		}
		//审核不通过
		else{
			
			return "news/checkAdvertReject";
		}
	}
	
	
	
	public void saveSellArea(HttpServletRequest request, Long AdvertId){
        Map<String,Object> m = new HashMap<String,Object>();
        m.put("AdvertId", AdvertId);
        advertManager.deleteAdvertArea(m);

        String sellAreas = request.getParameter("sellAreas");
        if(sellAreas.length()>0){
        	 if(StringUtils.isNotBlank(sellAreas)){
                 String[] sellAreaCodes = sellAreas.split(",");
                 for(String areaCode:sellAreaCodes){
                     Map<String,Object> map = new HashMap<String,Object>();
                     map.put("AdvertId", AdvertId);
                     map.put("areaCode", areaCode);
                     if(AdvertId!=null&&StringUtils.isNotBlank(areaCode)){
                     	advertManager.saveAdvertArea(map);
                     }
                 }
             }
        }
        else{
        		 Map<String,Object> map = new HashMap<String,Object>();
                 map.put("AdvertId", AdvertId);
                 map.put("areaCode",1);
                 advertManager.saveAdvertArea(map);
        }
       
    }
	 @RequestMapping(value = "/saveCheckReason")
	    public String saveCheckReason(HttpServletRequest request, HttpServletResponse response) throws Exception {
		 	String message = "保存成功!";
		 	Long objectId = Long.parseLong(request.getParameter("objectId"));
		 	Advert advert = advertManager.getByObjectId(objectId);
		 	advert.setStatus(4);
			advert.setCheckDate(new Date());
			advert.setCheckPerson(FrameworkContextUtils.getCurrentUserId());
			advert.setCheckPersonName(FrameworkContextUtils.getCurrentLoginName());
			getManager().save(advert);
		 	
	        String remark = request.getParameter("remark");
	        AdvertReject  advertReject = new AdvertReject();
	        advertReject.setAdvertId(objectId);
	        List<AdvertReject> advertRejects = advertRejectManager.getBySample(advertReject);
	        if(advertRejects.size()>0){
	        	advertReject = advertRejects.get(0);
	        	advertReject.setAdvertId(objectId);
	        	advertReject.setCheckDate(new Date());
	        	advertReject.setRejectContent(remark);
	        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
	        	advertRejectManager.save(advertReject);
	        }
	        else{
	        	advertReject.setAdvertId(objectId);
	        	advertReject.setCheckDate(new Date());
	        	advertReject.setRejectContent(remark);
	        	advertReject.setCheckUserId(FrameworkContextUtils.getCurrentLoginName());
	        	advertRejectManager.save(advertReject);
	        }
	        request.setAttribute("message", message);
	        //request.setAttribute("remark", remark);
	        return "redirect:/advert/verify";
	    }
	 //点击审核页面
	 @RequestMapping(value = "/todetail/{objectId}")
		public String todetail(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
				throws Exception {
			if (null != objectId) {
				Advert entity = getManager().getByObjectId(objectId);
				request.setAttribute("entity", entity);
			}
			if (null != objectId){
				 Advert entity = advertManager.getByObjectId(objectId);
				 Long AdvertId = entity.getObjectId();
				Map<String,Object> map3 = new HashMap<String,Object>();
		        map3.put("AdvertId", AdvertId);
		        List<String> selectedSellArea = advertManager.getAdvertArea(map3);
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
		 	PageSearch result = advertManager.getAdvert(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
	        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
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
		@RequestMapping("getDistrict/{cityId}")
		public String getDistrict(HttpServletRequest request, HttpServletResponse response,ModelMap map,@PathVariable Long cityId) {
	        boolean result = false;
		    Area area = new Area();
	        area.setDeepLevel(3);
	        area.setParentId(cityId);
	        List<Area> districts = areaManager.getBySample(area);
	        result = true;
	        map.put("result", result);
	        map.put("districts", districts);
	        return "jsonView";
	    }
		
		@RequestMapping(value = "/toDelete/{objectId}")
		public String toDelete(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
				throws Exception {
				Advert entity = getManager().getByObjectId(objectId);
				entity.setIsDeleted(1);
				getManager().save(entity);
				PageSearch page  = preparePage(request);
				Area area = new Area();
			    area.setDeepLevel(1);
			    List<Area> firstArea = areaManager.getBySample(area);
			    request.setAttribute("firstArea", firstArea);
			 	PageSearch result = advertManager.getAdvert(page);
				page.setTotalCount(result.getTotalCount());
				page.setList(result.getList());
				afterPage(request, page, PageUtils.IS_NOT_BACK);
		      //  return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
				return "redirect:/advert/page";
		}
		
		@RequestMapping("getAdvertStatus")
		public String getAdvertStatus(HttpServletRequest request, HttpServletResponse response,ModelMap map) {
	        long objectId  = Long.parseLong(request.getParameter("objectId"));
	        Advert advert  = advertManager.getByObjectId(objectId);
	        int status  = advert.getStatus();
	        map.put("result", status);
	        return "jsonView";
	    }
		
}
