/**
 * 
 */
package com.handpay.ibenefit.welfare.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.ExcelUtil;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.entity.WelfarePackageItem;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWelfareManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageCategoryManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

/**
 * @author liran  
 */
@Controller
@RequestMapping("/cardCreateInfo")
public class CardCreateInfoController extends PageController<CardCreateInfo> {
	
	private static final String BASE_DIR = "welfare/";
	
	@Reference(version = "1.0",timeout=10000)
	private ICardCreateInfoManager cardCreateInfoManager;
	
	@Reference(version = "1.0")
	private IWelfareManager welfareManager;
	
	@Reference(version = "1.0")
	private IWelfarePackageManager wePackageManager;
	
	@Reference(version = "1.0")
	private IWelfarePackageCategoryManager welfarePackageCategoryManager;
	
	
	@Reference(version = "1.0",timeout = 20000)
	private ICardInfoManager cardInfoManager;
	
	@Reference(version = "1.0")
	private IDictionaryManager dictionaryManager; 
	
	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager; 
	

	@Override
	public Manager<CardCreateInfo> getEntityManager() {
		return cardCreateInfoManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	//根据itemIds获取package列表
 
//	@RequestMapping(value = "/packageLists")
//	public String packageList(HttpServletRequest request,ModelMap modelMap,Integer backPage) throws Exception {
//		
//		//获取项目大类下拉框		
//		Map<String , Object> param = new HashMap<String, Object>();
//		param.put("itemType", 1);
//		param.put("itemGrade",1);
//		param.put("status", 1);
//		List<WelfareItem> bigItems =  welfareManager.getItemByParam(param);	
//		request.setAttribute("bigItemList", bigItems);	
//		//end 
//		
//		PageSearch page = preparePage(request);
//		page.setEntityClass(WelfarePackageItem.class);
//		String bigItemId = request.getParameter("bigItemId");
//		String subItemId = request.getParameter("subItemId");
//		if(bigItemId!=null&&!("-1").equals(bigItemId)){
//			page.getFilters().add(new PropertyFilter("WelfarePackageItem", "EQL_bigItemId",bigItemId));
//		}
//		if(subItemId!=null&&!("-1").equals(subItemId)){
//			page.getFilters().add(new PropertyFilter("WelfarePackageItem", "EQL_subItemId",subItemId));
//		}
//		PageSearch result = welfarePackageManager.getPackageByItemIDs(page);
//		page.setTotalCount(result.getTotalCount());
//		page.setList(result.getList());
//		//request.setAttribute("action", "packageLists");
//		afterPage(request, page, backPage);
//		return BASE_DIR + "listWelfarePackageItemTemplate";
//	}

	
	@RequestMapping(value = "/queryPackageList")
	public String queryPackageList(HttpServletRequest request,ModelMap modelMap,Integer backPage) throws Exception {
		
		//获取项目大类下拉框		
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("itemType", 1);
		param.put("itemGrade",1);
		param.put("status", 1);
		List<WelfareItem> bigItems =  welfareManager.getItemByParam(param);	
		request.setAttribute("bigItemList", bigItems);	
		//end 
		
		PageSearch page = preparePage(request);
		page.setEntityClass(WelfarePackageItem.class);
 		
		String bigItemId = request.getParameter("bigItemId");
		String subItemId = request.getParameter("subItemId");
		if(bigItemId!=null&&!("-1").equals(bigItemId)){
			page.getFilters().add(new PropertyFilter("WelfarePackageItem", "EQL_bigItemId",bigItemId));
		}
		if(subItemId!=null&&!("-1").equals(subItemId)){
			page.getFilters().add(new PropertyFilter("WelfarePackageItem", "EQL_subItemId",subItemId));
		}
		page.getFilters().add(new PropertyFilter("WelfarePackageItem","GTD_endDate",DateUtils.getCurrentDate()));
		PageSearch result = welfarePackageManager.getPackageByItemIDs(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		
		
		request.setAttribute("action", "queryPackageList?ajax=1&init=1&bigItemId="+bigItemId+"&subItemId="+subItemId);
		afterPage(request, page, backPage);
		return BASE_DIR + "listWelfarePackageItemTemplate";
	}

	@RequestMapping(value = "/queryResidueCardNum")
	public String queryResidueCardNum(HttpServletRequest request,ModelMap modelMap,String packageNo) throws Exception {
		Integer residueCardNum = cardCreateInfoManager.countResidueCard(packageNo);
		modelMap.addAttribute("residueCardNum", residueCardNum);
		return "jsonView";
	}
	
	 protected String handPagePublish(HttpServletRequest request, PageSearch page) {
	        PageSearch pSearch=preparePage(request);
	        if(page.getFilters().size()>0){
	            pSearch.getFilters().add(new PropertyFilter(Company.class.getName(),"EQL_objectId",Company.ROOT.getObjectId().toString()));
	        }else{
	        	pSearch.getFilters().add(new PropertyFilter(Company.class.getName(),"EQL_neObjectId",Company.ROOT.getObjectId().toString()));
	        }
	       /// PageSearch result=companyPublishedManager.findCompanys(pSearch);
	        //page.setTotalCount(result.getTotalCount());
	       // page.setList(result.getList());
	        afterPage(request, page, PageUtils.IS_NOT_BACK);
	        return getFileBasePath() + "listCompany";
	    }

	
	/**
	 * Save the submit,and return to query page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveToPage")
	public String saveToPage(HttpServletRequest request, ModelMap modelMap, CardCreateInfo cardCreateInfo) throws Exception {
		String currentLoginName = FrameworkContextUtils.getCurrentLoginName();
		//Long packageId = t.getPackageId();
		Long cardCreateInfoId = cardCreateInfoManager.createCards(cardCreateInfo,currentLoginName,null);
		request.setAttribute("count", cardCreateInfo.getCardAmount());
		request.setAttribute("createInfoId",cardCreateInfoId);
		return getFileBasePath()+"cardEnd";
	}
	
	/**
	 * Go into the list page
	 * @param request
	 * @param t
	 * @param backPage 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardCreateInfopage")
	public String cardCreateInfopage(HttpServletRequest request, CardCreateInfo t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentTime = sdf.format(date);
		if(("1").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "LTD_endDate", currentTime));
			request.setAttribute("expireStatus", "1");
		}else if(("0").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "GTD_endDate", currentTime));
			request.setAttribute("expireStatus", "0");
		}
		page = cardCreateInfoManager.findCardCreateInfo(page);
		request.setAttribute("action", "cardCreateInfopage");
		afterPage(request, page,backPage);
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
	
	
	@RequestMapping(value = "/cardCreateInfopageToCount")
	public String cardCreateInfopageToCount(HttpServletRequest request, CardCreateInfo t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentTime = sdf.format(date);
		if(("1").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "LTD_endDate", currentTime));
			request.setAttribute("expireStatus", "1");
		}else if(("0").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "GTD_endDate", currentTime));
			request.setAttribute("expireStatus", "0");
		}
		page = cardCreateInfoManager.findCardCreateInfo(page);
		request.setAttribute("action", "cardCreateInfopageToCount");
		afterPage(request, page,backPage);
		return getFileBasePath() + "listCardCreateInfoToCount" ;//+ getActualArgumentType().getSimpleName();
	}
	
	/**
	 * Go into the create page
	 * 选择一级菜单
	 * @param request
	 * @param response
	 * @param WelfareItem
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/createCard")
	public String cardInfoCreate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("itemType", 1);
		param.put("itemGrade",1);
		param.put("status", 1);
		List<WelfareItem> bigItems =  welfareManager.getItemByParam(param);	
		request.setAttribute("bigItems", bigItems);
		return getFileBasePath()+"createCard";
	}
	
	/*
	//选择二级菜单
	@RequestMapping(value = "/getSecondMenu/{parentItemId}")
	public String getSecondMenu(HttpServletRequest request, HttpServletResponse response,@PathVariable Long parentItemId,ModelMap modelMap) throws Exception {
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("itemType", 1);
		param.put("itemGrade",2);
		param.put("status", 1);
		param.put("parentItemId",parentItemId == -1?null:parentItemId);		
		List<WelfareItem> secondItems =  welfareManager.getItemByParam(param);	
		modelMap.addAttribute("secondItems", secondItems); 
		return "jsonView";
	} 
	*/
	
	//选择二级菜单
	@RequestMapping(value = "/getSecondMenu2")
	public String getSecondMenu2(HttpServletRequest request, HttpServletResponse response,Long parentItemId,ModelMap modelMap) throws Exception {
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("itemType", 1);
		param.put("itemGrade",2);
		param.put("status", 1);
		param.put("parentItemId",parentItemId == null ? null:parentItemId);		
		List<WelfareItem> secondItems =  welfareManager.getItemByParam(param);	
		modelMap.addAttribute("secondItems", secondItems); 
		return "jsonView";
	} 
	
	
	
//	@RequestMapping("getItems/{parentItemId}")
//	public String getItem( ModelMap modelMap ,@PathVariable String parentItemId){
//		if( parentItemId!=null){
//			Map<String , Object> param = new HashMap<String, Object>();
//			param.put("itemType", 1);
//			param.put("parentItemId",parentItemId);		
//			param.put("status", 1);
//			List<WelfareItem>   items = welfareManager.getItemByParam(param);	
//			modelMap.addAttribute("items", items);
//		}
//		return "jsonView";
//	}
	
	//选择BigItem时获取welfarePackage
	@RequestMapping("selectBigItem/{bigItemId}")
	public String selectBigItem( ModelMap modelMap ,@PathVariable Long bigItemId,ModelMap map){
//		WelfarePackage pck = new WelfarePackage();
//		pck.setBigItemId(bigItemId);
//		List<WelfarePackage> welfareList = 	welfarePackageManager.getBySample(pck);
//		map.addAttribute("welfareList", welfareList);
//		return "jsonView"; 
//		
//		List<WelfareItem>   items = welfareManager.getItemByParam(param);	
//		modelMap.addAttribute("items", items);
		 
		return "jsonView";
	}
	
	//查询剩余卡密库存
	@RequestMapping("countResidueCard")
	public String countResidueCard( ModelMap modelMap,String packageNO){
		Integer c = cardCreateInfoManager.countResidueCard(packageNO);
		modelMap.addAttribute("packageNO", c);
		return "jsonView";
	}
	
	
	
	
	@RequestMapping("exportAll/{createInfoId}")
	public String exportAll(HttpServletRequest request, HttpServletResponse response,@PathVariable String createInfoId) throws Exception {
		String[] titles={"序号","卡号","密码","卡号状态","有效时间范围"};
		CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(Long.parseLong(createInfoId));
		List<Dictionary> dictionaries = dictionaryManager.getDictionariesByDictionaryId(1604);
		Map<Integer,String> valid = new HashMap<Integer,String>();
		for(Dictionary dictionary : dictionaries){
			if(dictionary.getStatus()!=null && dictionary.getStatus()){
				valid.put(dictionary.getValue(), dictionary.getName());
			}
		}
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("createInfoId",createInfoId);
		List<CardInfo> cardInfoList = cardInfoManager.getCardInfoByParam(param);
		List<Object[]> datas = new ArrayList<Object[]>();
		for (int i=0;i<cardInfoList.size();i++) {
			CardInfo cardInfo = cardInfoList.get(i);
			Object[] arr = new Object[5];
			arr[0] = i+1;
			arr[1] = cardInfo.getCardNo();
			arr[2] = cardInfo.getPassWord();
			arr[3] = valid.get(cardInfo.getCardStatus());
			String startDate = "";
			String endDate = "";
			if (cardCreateInfo!=null) {
				startDate = DateUtils.getDateFormat(DateUtils.FORMAT_YYYY_MM_DD).format(cardCreateInfo.getStartDate());
				endDate = DateUtils.getDateFormat(DateUtils.FORMAT_YYYY_MM_DD).format(cardCreateInfo.getEndDate());
			}
			arr[4] = startDate+" - "+endDate;
			datas.add(arr);
		}
		
		String exportName = "";
		if (cardCreateInfo!=null) {
			exportName = FileUpDownUtils.encodeDownloadFileName(request, cardCreateInfo.getPackageName()+"_"+cardCreateInfo.getCardAmount()+"卡密.xls");
		}else{
			exportName = FileUpDownUtils.encodeDownloadFileName(request, "_"+cardInfoList.size()+".xls");
		}
		ExcelUtil excelUtil=new ExcelUtil();
		excelUtil.exportExcel(response, datas, titles, exportName);
		//return "redirect:cardCreateInfopage";
		return null;
	}
	
	
}
