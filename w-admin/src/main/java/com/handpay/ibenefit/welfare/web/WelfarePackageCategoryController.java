/**
 * 
 */
package com.handpay.ibenefit.welfare.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.validation.Valid;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.entity.WelfarePackageCategory;
import com.handpay.ibenefit.welfare.service.IWelfarePackageCategoryManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

/**
 * @author liran
 *
 */
@Controller
@RequestMapping("/welfarePackageCategory")
public class WelfarePackageCategoryController extends PageController<WelfarePackageCategory>{
	
	private static final String BASE_DIR = "welfare/";
	
	@Reference(version="1.0",check=false)
	private IDictionaryManager dictionaryManager;
	
	@Reference(version = "1.0")
	private IWelfarePackageCategoryManager welfarePackageCategoryManager;
	
	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager;
	
	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	public Manager<WelfarePackageCategory> getEntityManager() {
		return welfarePackageCategoryManager;
	}
	
	/**
	 * 重写save方法，自动生成套餐类型编号保存
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, ModelMap modelMap, @Valid WelfarePackageCategory t, BindingResult result)
			throws Exception {
			if(t.getPackageNo()==null || "".equals(t.getPackageNo())){
				String no = sequenceManager.getNextNo("WP_SEQUENCE","WP", 8);
				t.setPackageNo(no);
			}
		return handleSave(request, modelMap, t);
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
	public String saveToPage(HttpServletRequest request, ModelMap modelMap, WelfarePackageCategory t) throws Exception {
		if(t.getPackageNo()==null || "".equals(t.getPackageNo())){
			String no = sequenceManager.getNextNo("WP_SEQUENCE","WP", 8);
			t.setPackageNo(no);
		}
		return handleSaveToPage(request, modelMap, t);
	}
	
	@RequestMapping(value = "/getWelfarePackageBudget/{wpCategoryId}")
	public String getWelfarePackageBudget(HttpServletRequest request, ModelMap modelMap,@PathVariable Long wpCategoryId)
			throws Exception {
		try {
			WelfarePackage  welfarePackage = welfarePackageManager.getByObjectId(wpCategoryId);
			modelMap.put("packageBudget", welfarePackage.getPackagePrice());
			/*
			WelfarePackageCategory welfarePackageCategory = welfarePackageCategoryManager.getByObjectId(wpCategoryId);
			if(welfarePackageCategory!=null){
				Dictionary sample = dictionaryManager.getDictionaryByDictionaryId(IBSConstants.PRODUCT_BUDGET_LEVEL);
				Dictionary dictionary = new Dictionary();
				dictionary.setValue(welfarePackageCategory.getPackageBudget());
				dictionary.setParentId(sample.getObjectId());
				List<Dictionary> dictionaries = dictionaryManager.getBySample(dictionary);
				if(dictionaries.size()>0){
					modelMap.put("packageBudget", dictionaries.get(0).getName());
				}else{
					modelMap.put("packageBudget", null);
				}
				request.setAttribute("packageBudget", welfarePackageCategory.getPackageBudget());
			}else{
				modelMap.put("packageBudget", null);
			}
			*/
		} catch (Exception e) {
			e.printStackTrace();
			modelMap.put("packageBudget", null);
		}
		modelMap.put("productName", request.getParameter("productName"));
		return "jsonView";
	}

	/**
	 * 重写saveToPage方法，保存排序，并返回到二级项目page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		Map<String, Object> param = new HashMap<String, Object>();
		if(("1").equals(request.getParameter("invalid"))){
			//置为无效
			for (int i = 0; i < objectIdArray.length; i++) {
				if(objectIdArray[i]!=null && ! ("").equals(objectIdArray[i])){
					param.put("objectId", objectIdArray[i]);
					param.put("status", 2);
				}
				welfarePackageCategoryManager.updateColumn(param);
			}
		}
			return "redirect:page"  + getMessage("common.base.success", request);
	}
}
