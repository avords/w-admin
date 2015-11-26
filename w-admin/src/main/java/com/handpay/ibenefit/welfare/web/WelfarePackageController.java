/**
 *
 */
package com.handpay.ibenefit.welfare.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

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
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.framework.FrameworkConstants;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.ProductPublish;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.product.service.IProductPublishManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.search.service.ISolrIndexUpdateManager;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.entity.WelfarePackageCategory;
import com.handpay.ibenefit.welfare.entity.WpAreaRelation;
import com.handpay.ibenefit.welfare.entity.WpRelation;
import com.handpay.ibenefit.welfare.service.IWelfareItemManager;
import com.handpay.ibenefit.welfare.service.IWelfareManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageCategoryManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;
import com.handpay.ibenefit.welfare.service.IWpAreaRelationManager;
import com.handpay.ibenefit.welfare.service.IWpRelationManager;

/**
 * @author liran
 *
 */
@Controller
@RequestMapping("/welfarePackage")
public class WelfarePackageController extends PageController<WelfarePackage> {

    private static final Logger LOGGER = Logger.getLogger(WelfarePackageController.class);

    private static final String BASE_DIR = "welfare/";

	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager;

	@Reference(version = "1.0")
	private IWelfareManager welfareManager;

	@Reference(version = "1.0")
	private IWelfarePackageCategoryManager welfarePackageCategoryManager;

	@Reference(version = "1.0")
	private IDictionaryManager dictionaryManager;

	@Reference(version = "1.0")
	private ISkuPublishManager skuPublishManager;

	@Reference(version = "1.0")
	private IWpAreaRelationManager wpAreaRelationManager;

	@Reference(version = "1.0")
	private IWpRelationManager wpRelationManager;

	@Reference(version = "1.0")
	private IAreaManager areaManager;

	@Reference(version = "1.0")
	private IProductPublishManager productPublishManager;

	@Reference(version = "1.0")
	private ICompanyGoodsManager companyGoodsManager;

	@Reference(version = "1.0")
    private ISolrIndexUpdateManager solrIndexUpdateManager;

	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

	@Reference(version = "1.0")
    private IWelfareItemManager welfareItemManager;

	@Override
	public Manager<WelfarePackage> getEntityManager() {
		return welfarePackageManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}


	/**
	 * Go into the list page
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/page")
	public String page(HttpServletRequest request, WelfarePackage t, Integer backPage) throws Exception {
		String bigItemId = request.getParameter("search_EQI_bigItemId");
		String subItemId = request.getParameter("search_EQI_subItemId");
		request.setAttribute("bigItemId", bigItemId);
		request.setAttribute("subItemId", subItemId);
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter("WelfarePackage", "NEI_welfareType", ""+IBSConstants.WELFARE_PACKAGE_TYPE_PHYSICAL));
		if("objectId".equals(page.getSortProperty())){
            page.setSortProperties(new String[]{"updatedOn","objectId"});
            page.setSortOrders(new String[]{"desc nulls last","desc"});
        }
		String result = handlePage(request, page);
		afterPage(request, page,backPage);
		return result;
	}



	/**
	  * welfarePackageRecommendTemplate(福利套餐选择模版)
	  *
	  * @Title: welfarePackageRecommendTemplate
	  * @Description: TODO
	  * @param @param request
	  * @param @param t
	  * @param @param backPage
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/welfarePackageRecommendTemplate")
	public String welfarePackageRecommendTemplate(HttpServletRequest request,
			WelfarePackage t, Integer backPage) throws Exception {
		String bigItemId = request.getParameter("search_EQI_bigItemId");
		String subItemId = request.getParameter("search_EQI_subItemId");
		request.setAttribute("bigItemId", bigItemId);
		request.setAttribute("subItemId", subItemId);
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
		handlePage(request, page);
		afterPage(request, page, backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listWelfarePackageRecommendTemplate";
	}


	/**
	 * 重写saveToPage方法，返回推荐套餐page
	 *
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/saveToPage")
	public String saveToPage(HttpServletRequest request, ModelMap modelMap,WelfarePackage t) throws Exception {
		String[] sellAreaArray = null;
		String[] productIdArray = null;
		String[] reserveproductIdArray = null;
		String[] priorityTonoArray = null;
		String[] sPriorityTonoArray = null;
		sellAreaArray = request.getParameter("sellAreas").split(",");
		productIdArray = request.getParameter("productIdArray").split(",");
		priorityTonoArray = request.getParameter("priorityTonoArray").split(",");
		sPriorityTonoArray = request.getParameter("sPriorityTonoArray").split(",");
		String packageName  = t.getPackageName();
		boolean flag = true;
		if (request.getParameter("reserveproductIdArray") != null&&!("").equals(request.getParameter("reserveproductIdArray"))) {
			reserveproductIdArray = request.getParameter("reserveproductIdArray").split(",");
		}
		//编辑保存
		if(t.getObjectId()!=null){
			if(t.getStockType()==1){
				t.setPackageStock(Integer.parseInt(request.getParameter("realStock")));
			}else{
				t.setPackageStock(Integer.parseInt(request.getParameter("virtualStock")));
			}
			t.setImmediatelyEffect(Integer.parseInt(request.getParameter("immediatelyEffectStatus")));
			if(t.getImmediatelyEffect()==1){
				t.setStatus(IBSConstants.SHELVES_ING);
			}
			t = save(t);
			WpAreaRelation wpAreaRelation = new WpAreaRelation();
			wpAreaRelation.setPackageId(t.getObjectId());
			wpAreaRelationManager.deleteBySample(wpAreaRelation);
			for (int i = 0; i < sellAreaArray.length; i++) {
				wpAreaRelation.setAreaId(Long.parseLong(sellAreaArray[i]));
				wpAreaRelationManager.save(wpAreaRelation);
			}
			WpRelation wpRelation = new WpRelation();
			wpRelation.setPackageId(t.getObjectId());
			wpRelation.setProductType(1);
			wpRelationManager.deleteBySample(wpRelation);
			for (int i = 0; i < productIdArray.length; i++) {
				wpRelation.setProductId(Long.parseLong(productIdArray[i]));
				if(StringUtils.isNotBlank(priorityTonoArray[i])){
					wpRelation.setPriority(Double.parseDouble(priorityTonoArray[i]));
				}
				wpRelationManager.save(wpRelation);
			}
			flag = welfarePackageManager.updatePackageStatus(t.getObjectId(),t.getStatus());
			if(flag){
			    try{
			        //更新索引文档
			          solrIndexUpdateManager.addPackage(t.getObjectId());
			        }catch(Exception e){
			            LOGGER.error("update solr index by welfarePackageId have a error!", e);
			        }
			}else{
				try{
					Long packageId  = t.getObjectId();
	                solrIndexUpdateManager.deletePackageDocById(packageId.toString());
	            }catch(Exception e){
	                LOGGER.error("delete solr index by welfarePackageId have a error!", e);
	            }
			}

			wpRelation = new WpRelation();
			wpRelation.setPackageId(t.getObjectId());
			wpRelation.setProductType(2);
			wpRelationManager.deleteBySample(wpRelation);
			if(reserveproductIdArray!=null){
				for (int i = 0; i < reserveproductIdArray.length; i++) {
					wpRelation.setProductId(Long.parseLong(reserveproductIdArray[i]));
					wpRelation.setPriority(Double.parseDouble(sPriorityTonoArray[i]));
					wpRelationManager.save(wpRelation);
				}
			}
		//新增保存
		}else{
			if ("1".equals(request.getParameter("realStockType"))) {
				WelfarePackage realWp = new WelfarePackage();
				t.setItemName(request.getParameter("itemName"));
				t.setStockType(1);
				t.setPackageName(packageName);
				t.setPackageStock(Integer.parseInt(request.getParameter("realStock")));
				if (t.getPackageNo() == null || ("").equals(t.getPackageNo())) {
					t.setPackageNo(sequenceManager.getNextNo("WELFARE_PACKAGE_SQ", "FL", 5));
				}
				if (t.getImmediatelyEffect() == 1) {
					t.setStartDate(new Date());
					t.setStatus(IBSConstants.SHELVES_ING);// 上架中
				} else {
					t.setStatus(IBSConstants.SHELVES_WAIT);// 待上架
				}
				t.setWelfareType(IBSConstants.WELFARE_PACKAGE_TYPE_WELFARE);
				realWp = save(t);
				flag = welfarePackageManager.updatePackageStatus(realWp.getObjectId(),realWp.getStatus());
				try {
					// 更新索引文档
					solrIndexUpdateManager.addPackage(realWp.getObjectId());
				} catch (Exception e) {
					LOGGER.error("update solr index by welfarePackageId have a error!\n",e);
				}
				if(!flag){
					try{
		                solrIndexUpdateManager.deletePackageDocById(realWp.getObjectId().toString());
		            }catch(Exception e){
		                LOGGER.error("delete solr index by welfarePackageId have a error!\n", e);
		            }
				}
				WpAreaRelation wpAreaRelation = new WpAreaRelation();
				wpAreaRelation.setPackageId(realWp.getObjectId());
				wpAreaRelationManager.deleteBySample(wpAreaRelation);
				for (int i = 0; i < sellAreaArray.length; i++) {
					wpAreaRelation.setAreaId(Long.parseLong(sellAreaArray[i]));
					wpAreaRelationManager.save(wpAreaRelation);
				}
				WpRelation wpRelation = new WpRelation();
				wpRelation.setPackageId(realWp.getObjectId());
				wpRelation.setProductType(1);
				wpRelationManager.deleteBySample(wpRelation);
				for (int i = 0; i < productIdArray.length; i++) {
					wpRelation.setProductId(Long.parseLong(productIdArray[i]));
					/*if(StringUtils.isNotBlank(priorityTonoArray[i])){
						wpRelation.setPriority(Double.parseDouble(priorityTonoArray[i]));
					}*/
					wpRelation.setPriority(Double.parseDouble(priorityTonoArray[i]));
					wpRelationManager.save(wpRelation);
				}
				wpRelation = new WpRelation();
				wpRelation.setPackageId(realWp.getObjectId());
				wpRelation.setProductType(2);
				wpRelationManager.deleteBySample(wpRelation);
				if(reserveproductIdArray!=null){
					for (int i = 0; i < reserveproductIdArray.length; i++) {
						wpRelation.setProductId(Long.parseLong(reserveproductIdArray[i]));
						wpRelation.setPriority(Double.parseDouble(sPriorityTonoArray[i]));
						wpRelationManager.save(wpRelation);
					}
				}
			}
			if ("2".equals(request.getParameter("virtualStockType"))) {
				WelfarePackage virtualWp = new WelfarePackage();
				t.setObjectId(null);
				t.setPackageNo(null);
				t.setItemName(request.getParameter("itemName"));
				t.setStockType(2);
				t.setPackageName(packageName);
				t.setPackageStock(Integer.parseInt(request.getParameter("virtualStock")));
				if (t.getPackageNo() == null || ("").equals(t.getPackageNo())) {
					t.setPackageNo(sequenceManager.getNextNo("WELFARE_PACKAGE_SQ", "FL", 5));
				}
				if (t.getImmediatelyEffect() == 1) {
					t.setStartDate(new Date());
					t.setStatus(2);// 上架中
				} else {
					t.setStatus(1);// 待上架
				}
				t.setWelfareType(IBSConstants.WELFARE_PACKAGE_TYPE_WELFARE);
				virtualWp = save(t);
				flag = welfarePackageManager.updatePackageStatus(virtualWp.getObjectId(),virtualWp.getStatus());
				try {
					// 更新索引文档
					  solrIndexUpdateManager.addPackage(virtualWp.getObjectId());
				} catch (Exception e) {
					LOGGER.error("update solr index by skuId have a error!" ,e);
				}
				if(!flag){
					try{
		                solrIndexUpdateManager.deletePackageDocById(virtualWp.getObjectId().toString());
		            }catch(Exception e){
		                LOGGER.error("delete solr index by skuId have a error!\n"+e);
		            }
				}
				WpAreaRelation wpAreaRelation = new WpAreaRelation();
				wpAreaRelation.setPackageId(virtualWp.getObjectId());
				wpAreaRelationManager.deleteBySample(wpAreaRelation);
				for (int i = 0; i < sellAreaArray.length; i++) {
					wpAreaRelation.setAreaId(Long.parseLong(sellAreaArray[i]));
					wpAreaRelationManager.save(wpAreaRelation);
				}
				WpRelation wpRelation = new WpRelation();
				wpRelation.setPackageId(virtualWp.getObjectId());
				wpRelation.setProductType(1);
				wpRelationManager.deleteBySample(wpRelation);
				for (int i = 0; i < productIdArray.length; i++) {
					wpRelation.setProductId(Long.parseLong(productIdArray[i]));
					wpRelation.setPriority(Double.parseDouble(priorityTonoArray[i]));
					wpRelationManager.save(wpRelation);
				}
				wpRelation = new WpRelation();
				wpRelation.setPackageId(virtualWp.getObjectId());
				wpRelation.setProductType(2);
				wpRelationManager.deleteBySample(wpRelation);
				if(reserveproductIdArray!=null){
					for (int i = 0; i < reserveproductIdArray.length; i++) {
						wpRelation.setProductId(Long.parseLong(reserveproductIdArray[i]));
						wpRelation.setPriority(Double.parseDouble(sPriorityTonoArray[i]));
						wpRelationManager.save(wpRelation);
					}
				}
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}


	/**
	 * goto编辑套餐页面
	 *
	 * @param request
	 * @param response
	 * @param id
	 *            primary key
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/view/{objectId}")
	public String view(HttpServletRequest request,HttpServletResponse response, @PathVariable Long objectId)throws Exception {
		WpAreaRelation wpAreaRelation = new WpAreaRelation();
		wpAreaRelation.setPackageId(objectId);
		List<WpAreaRelation> wpAreaRelationList = wpAreaRelationManager.getBySample(wpAreaRelation);
		String sellAreas = "";
		String sellAreaNames = "";
		for (int i = 0; i < wpAreaRelationList.size(); i++) {
			if (sellAreas == "") {
				sellAreas += wpAreaRelationList.get(i).getAreaId();
				sellAreaNames += areaManager.getByObjectId(wpAreaRelationList.get(i).getAreaId()).getName();
			} else {
				sellAreas += "," + wpAreaRelationList.get(i).getAreaId();
				sellAreaNames += ","+ areaManager.getByObjectId(wpAreaRelationList.get(i).getAreaId()).getName();
			}
		}
		// 根据套餐id取得关联的推荐商品List
		String productIdArray = "";
		String reserveproductIdArray = "";
		WpRelation wpRelation = new WpRelation();
		wpRelation.setPackageId(objectId);
		wpRelation.setProductType(1);
		List<WpRelation> wpRelationList = wpRelationManager.getBySample(wpRelation);
		List<SkuPublish> products = new ArrayList<SkuPublish>();
		for (int i = 0; i < wpRelationList.size(); i++) {
			SkuPublish skuPublish = new SkuPublish();
			skuPublish = skuPublishManager.getByObjectId(wpRelationList.get(i).getProductId());
			ProductPublish  product = productPublishManager.getByObjectId(skuPublish.getProductId());
			skuPublish.setProduct(product);
			skuPublish.setPriority(wpRelationList.get(i).getPriority());
			products.add(skuPublish);
			if (productIdArray == "") {
				productIdArray += wpRelationList.get(i).getProductId();
			} else {
				productIdArray += "," + wpRelationList.get(i).getProductId();
			}
		}
		List<SkuPublish> reserveProducts = new ArrayList<SkuPublish>();
		wpRelation.setProductType(2);
		wpRelationList = wpRelationManager.getBySample(wpRelation);
		for (int i = 0; i < wpRelationList.size(); i++) {
			SkuPublish skuPublish = new SkuPublish();
			skuPublish = skuPublishManager.getByObjectId(wpRelationList.get(i).getProductId());
			ProductPublish  product = productPublishManager.getByObjectId(skuPublish.getProductId());
			skuPublish.setProduct(product);
			skuPublish.setPriority(wpRelationList.get(i).getPriority());
			reserveProducts.add(skuPublish);
			if (reserveproductIdArray == "") {
				reserveproductIdArray += wpRelationList.get(i).getProductId();
			} else {
				reserveproductIdArray += ","+ wpRelationList.get(i).getProductId();
			}
		}
		request.setAttribute("sellAreas", sellAreas);
		request.setAttribute("sellAreaNames", sellAreaNames);
		request.setAttribute("products", products);
		request.setAttribute("reserveProducts", reserveProducts);
		request.setAttribute("reserveproductIdArray", reserveproductIdArray);
		request.setAttribute("productIdArray", productIdArray);
		request.setAttribute(FrameworkConstants.VIEW, "1");
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		return getFileBasePath() + "welfarePackageDetails";
	}

	/**
	 * goto编辑套餐页面
	 *
	 * @param request
	 * @param response
	 * @param id
	 *            primary key
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/edit/{objectId}")
	public String edit(HttpServletRequest request,HttpServletResponse response, @PathVariable Long objectId)throws Exception {
		WpAreaRelation wpAreaRelation = new WpAreaRelation();
		wpAreaRelation.setPackageId(objectId);
		List<WpAreaRelation> wpAreaRelationList = wpAreaRelationManager.getBySample(wpAreaRelation);
		String sellAreas = "";
		String sellAreaNames = "";
		for (int i = 0; i < wpAreaRelationList.size(); i++) {
			if (sellAreas == "") {
				sellAreas += wpAreaRelationList.get(i).getAreaId();
				sellAreaNames += areaManager.getByObjectId(wpAreaRelationList.get(i).getAreaId()).getName();
			} else {
				sellAreas += "," + wpAreaRelationList.get(i).getAreaId();
				sellAreaNames += ","+ areaManager.getByObjectId(wpAreaRelationList.get(i).getAreaId()).getName();
			}
		}
		// 根据套餐id取得关联的推荐商品List
		String productIdArray = "";
		String reserveproductIdArray = "";
		WpRelation wpRelation = new WpRelation();
		wpRelation.setPackageId(objectId);
		wpRelation.setProductType(1);
		List<WpRelation> wpRelationList = wpRelationManager.getBySample(wpRelation);
		List<SkuPublish> products = new ArrayList<SkuPublish>();
		for (int i = 0; i < wpRelationList.size(); i++) {
			SkuPublish skuPublish = new SkuPublish();
			skuPublish = skuPublishManager.getByObjectId(wpRelationList.get(i).getProductId());
			ProductPublish  product = productPublishManager.getByObjectId(skuPublish.getProductId());
			skuPublish.setProduct(product);
			skuPublish.setPriority(wpRelationList.get(i).getPriority());
			products.add(skuPublish);
			if (productIdArray == "") {
				productIdArray += wpRelationList.get(i).getProductId();
			} else {
				productIdArray += "," + wpRelationList.get(i).getProductId();
			}
		}
		List<SkuPublish> reserveProducts = new ArrayList<SkuPublish>();
		wpRelation.setProductType(2);
		wpRelationList = wpRelationManager.getBySample(wpRelation);
		for (int i = 0; i < wpRelationList.size(); i++) {
			SkuPublish skuPublish = new SkuPublish();
			skuPublish = skuPublishManager.getByObjectId(wpRelationList.get(i).getProductId());
			ProductPublish  product = productPublishManager.getByObjectId(skuPublish.getProductId());
			skuPublish.setProduct(product);
			skuPublish.setPriority(wpRelationList.get(i).getPriority());
			reserveProducts.add(skuPublish);
			if (reserveproductIdArray == "") {
				reserveproductIdArray += wpRelationList.get(i).getProductId();
			} else {
				reserveproductIdArray += ","+ wpRelationList.get(i).getProductId();
			}
		}
		request.setAttribute("sellAreas", sellAreas);
		request.setAttribute("sellAreaNames", sellAreaNames);
		request.setAttribute("products", products);
		request.setAttribute("reserveProducts", reserveProducts);
		request.setAttribute("reserveproductIdArray", reserveproductIdArray);
		request.setAttribute("productIdArray", productIdArray);
		return handleEdit(request, response, objectId);
	}

	@RequestMapping("/getItems")
	public String getItem(ModelMap modelMap, HttpServletRequest request) {
		WelfareItem welfareItem = new WelfareItem();
		if (request.getParameter("itemGrade") != null && !("").equals(request.getParameter("itemGrade"))) {
			welfareItem.setItemGrade(Integer.parseInt(request.getParameter("itemGrade")));
		}
		if (request.getParameter("itemType") != null && !("").equals(request.getParameter("itemType"))) {
			welfareItem.setItemType(Integer.parseInt(request.getParameter("itemType")));
		}
		if (request.getParameter("bigItemId") != null && !("").equals(request.getParameter("bigItemId"))) {
			welfareItem.setParentItemId(Long.parseLong(request.getParameter("bigItemId")));
		}
		welfareItem.setStatus(1);
		List<WelfareItem> items = welfareManager.getBySample(welfareItem);
		modelMap.addAttribute("items", items);
		return "jsonView";
	}

	/**
	 *
	 *
	 * getWpCategoryItem(根据福利套餐类型联动下属的套餐选项)
	 *
	 * TODO(这里描述这个方法适用条件 – 可选)
	 *
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping("/getWpCategoryItem")
	public String getWpCategoryItem(ModelMap modelMap,
			HttpServletRequest request) {
		WelfarePackageCategory welfarePackageCategory = new WelfarePackageCategory();
		if (request.getParameter("wpCategoryType") != null
				&& !("").equals(request.getParameter("wpCategoryType"))) {
			welfarePackageCategory.setPackageType(Integer.parseInt(request.getParameter("wpCategoryType")));
		}
		welfarePackageCategory.setStatus(1);
		List<WelfarePackageCategory> items = welfarePackageCategoryManager.getBySample(welfarePackageCategory);
		Dictionary sample = dictionaryManager.getDictionaryByDictionaryId(IBSConstants.PRODUCT_BUDGET_LEVEL);
		for (int i = 0; i < items.size(); i++) {
			Dictionary dictionary = new Dictionary();
			dictionary.setParentId(sample.getObjectId());
			dictionary.setValue(items.get(i).getPackageBudget());
			dictionary = dictionaryManager.getBySample(dictionary).get(0);
			String wpCategoryItemName = dictionary.getName() + "元("+ items.get(i).getFirstParameter() + "选"+ items.get(i).getSecondParameter() + ")";
			items.get(i).setWpCategoryItemName(wpCategoryItemName);
		}
		modelMap.addAttribute("items", items);
		return "jsonView";
	}

	/**
	 *
	 *
	 * getRecommendCount(获取福利套餐推荐商品的数目参数，如3选2套餐则返回3)
	 *
	 * TODO(这里描述这个方法适用条件 – 可选)
	 *
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping("/getRecommendCount")
	public String getRecommendCount(ModelMap modelMap,
			HttpServletRequest request) {
		WelfarePackageCategory welfarePackageCategory = new WelfarePackageCategory();
		if (request.getParameter("wpCategoryId") != null
				&& !("").equals(request.getParameter("wpCategoryId"))) {
			welfarePackageCategory = welfarePackageCategoryManager
					.getByObjectId(Long.parseLong(request
							.getParameter("wpCategoryId")));
		}
		modelMap.addAttribute("welfarePackageCategory", welfarePackageCategory);
		return "jsonView";
	}

	/**
	 *
	 *
	 * wpProductAddTemplate(福利套餐选择商品模板页面)
	 *
	 *
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/wpProductAddTemplate")
	public String wpProductAddTemplate(HttpServletRequest request, SkuPublish t,Integer backPage) throws Exception {
		PageSearch page = preparePage(request);
		page.setEntityClass(Sku.class);
		PageSearch result = skuPublishManager.findWelfarePackageSku(page);
		page.setTotalCount(result.getTotalCount());

		List<Sku> list = result.getList();
		Sku sku  = null;
		ProductPublish proPublish = null;
		for(int i=0;i<list.size();i++){
			sku  = list.get(i);
			proPublish = productPublishManager.getByObjectId(sku.getProductId());
			sku.setProductPublish(proPublish);
		}
		page.setList(list);

		request.setAttribute("action", "page");
		request.setAttribute("recommendCount",request.getParameter("recommendCount"));
		request.setAttribute("reserveCount",request.getParameter("reserveCount"));
		afterPage(request, page, backPage);
		return BASE_DIR + "listWpProductAddTemplate";
	}


	@RequestMapping(value = "/welfarePackageTemplate")
	public String welfarePackageTemplate(HttpServletRequest request, WelfarePackage t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "welfare/" + "listWelfarePackageTemplate";
	}

	@RequestMapping(value = "/welfarePackagePriceTemplate")
    public String welfarePackagePriceTemplate(HttpServletRequest request, WelfarePackage t, Integer backPage) throws Exception {
        PageSearch page  = preparePage(request);
        page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
        //page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_welfareType",IBSConstants.WELFARE_PACKAGE_TYPE_PHYSICAL+""));
        handlePage(request, page);
        afterPage(request, page,backPage);
        request.setAttribute("inputName", request.getParameter("inputName"));
        return "welfare/" + "listWelfarePackagePriceTemplate";
    }


//	@RequestMapping(value = "/getWelfarePackageByItemId/{itemId}")
//	public String getWelfarePackageByItemId(HttpServletRequest request, @PathVariable Long itemId,ModelMap map) throws Exception {
//
//		WelfarePackage wfp = new WelfarePackage();
//		wfp.setSubItemId(itemId);
//		List<WelfarePackage> welfareList = 	welfarePackageManager.getBySample(wfp);
//		map.addAttribute("welfareList", welfareList);
//		 return "jsonView";
//	}

	@RequestMapping(value = "/getWelfarePackageByCondition")
	public String getWelfarePackageByCondition(HttpServletRequest request, WelfarePackage wfp,ModelMap map) throws Exception {
		List<WelfarePackage> welfareList = 	welfarePackageManager.getBySample(wfp);
		map.addAttribute("welfareList", welfareList);
		return "jsonView";
	}

	/**
	 * updateToPage，根据传入的status参数改写卡密状态，并返回到卡密信息页面
	 *
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request,ModelMap modelMap, WelfarePackage t,Integer status) throws Exception {
		String objectIds = request.getParameter("objectIdArray");
		String prioritys = request.getParameter("priorityArray");
		String[]  objectIdArray = objectIds.split(",");
		String[]  priorityArray = prioritys.split(",");
		Double priority = null;
		boolean flag = true;
		if(objectIdArray.length > 0){
			for(int i=0;i<objectIdArray.length;i++){
				Long packageId = Long.parseLong(objectIdArray[i].trim());
				if(priorityArray!=null && priorityArray.length == objectIdArray.length && priorityArray[i].length()>0){
					priority = Double.parseDouble(priorityArray[i].trim());
					welfarePackageManager.updatePackagePriority(packageId, priority);
				}
				if(status!=null){
					flag = welfarePackageManager.updatePackageStatus(packageId,status);
					if(flag){
					    try{
					        //更新索引文档
					    	  solrIndexUpdateManager.addPackage(packageId);
					        }catch(Exception e){
					            LOGGER.error("update solr index by welfarePackageId have a error!\n"+e);
					        }
					}else{
						try{
			                solrIndexUpdateManager.deletePackageDocById(packageId.toString());
			            }catch(Exception e){
			                LOGGER.error("delete solr index by welfarePackageId have a error!\n"+e);
			            }
					}
				}
			}
		}
		return "redirect:page/"+ getMessage("common.base.success", request);
	}

	@RequestMapping(value = "/welfarePlan/{welfareId}")
    public String welfarePlan(HttpServletRequest request, HttpServletResponse response,@PathVariable Long welfareId){
        request.setAttribute("welfareId", welfareId);
        PageSearch page  = preparePage(request);
        page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQL_subItemId",welfareId + ""));
        page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_packageType","0"));
        handlePage(request, page);
        PageUtils.afterPage(request, page, PageUtils.IS_NOT_BACK);
        request.getSession().setAttribute("action", "/welfarePackage/welfarePlan/"+welfareId);
        return "welfare/itemWelfarePackageSetPage";
    }

	@RequestMapping("/setWelfarePlan")
    public String setWelfarePlan(HttpServletRequest request,HttpServletResponse response){
        //只有状态为带上架或者已下架的商品才能上架
        String message = "操作成功";
        String welfarePackageIds = request.getParameter("itemIds");
        Integer value = Integer.parseInt(request.getParameter("value"));
        Long welfareId = Long.parseLong(request.getParameter("welfareId"));
        if(StringUtils.isNotBlank(welfarePackageIds)){
            String[] ids = welfarePackageIds.split(",");
            for(String id:ids){
                Long welfarePackageId = Long.parseLong(id);
                WelfarePackage wp = welfarePackageManager.getByObjectId(welfarePackageId);
                wp.setObjectId(welfarePackageId);
                wp.setIsWelfarePlan(value);
                welfarePackageManager.save(wp);
            }
        }else{
            message = "操作失败，你没有选择任何项目";
        }
        return "redirect:/welfarePackage/welfarePlan/"+welfareId+getMessage(message, request);
    }

	@RequestMapping(value = "/addWelfarePlanPage")
    public String addWelfarePlanPage(HttpServletRequest request, Product t, Integer backPage) throws Exception {
	    PageSearch page  = preparePage(request);
	    page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
	    page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_packageType","0"));
        handlePage(request, page);
        afterPage(request, page,backPage);
        request.setAttribute("welfareId", request.getParameter("welfareId"));
        return "welfare/addWelfarePlanPage";
    }

	@RequestMapping("/addWelfarePlan")
    public String addWelfarePlan(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
        //只有状态为带上架或者已下架的商品才能上架
        boolean result = true;
        String message = "操作成功";
        String welfarePackageIds = request.getParameter("itemIds");
        Long welfareId = Long.parseLong(request.getParameter("welfareId"));
        Integer value = Integer.parseInt(request.getParameter("value"));
        if(StringUtils.isNotBlank(welfarePackageIds)){
            String[] ids = welfarePackageIds.split(",");
            for(String id:ids){
                Long welfarePackageId = Long.parseLong(id);
                WelfareItem wi = welfareItemManager.getByObjectId(welfareId);
                WelfarePackage wp = welfarePackageManager.getByObjectId(welfarePackageId);
                wp.setObjectId(welfarePackageId);
                wp.setItemType(wi.getItemType());
                wp.setBigItemId(wi.getParentItemId());
                wp.setSubItemId(welfareId);
                wp.setIsWelfarePlan(value);
                Dictionary dictionary = dictionaryManager.getDictionaryByDictionaryIdAndValue(1600, wi.getItemType());
                String itemName = dictionary.getName()+"-"+
                welfareItemManager.getByObjectId(wi.getParentItemId()).getItemName()+
                "-"+wi.getItemName();
                wp.setItemName(itemName);
                welfarePackageManager.save(wp);
            }
        }else{
            result = false;
            message = "操作失败，你没有选择任何项目";
        }
        modelMap.addAttribute("reuslt", result);
        modelMap.addAttribute("message", message);
        return "jsonView";
    }
}
