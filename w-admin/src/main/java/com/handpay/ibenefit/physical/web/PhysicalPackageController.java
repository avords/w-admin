package com.handpay.ibenefit.physical.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.entity.ForeverEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierShopManager;
import com.handpay.ibenefit.physical.entity.PhysicalItem;
import com.handpay.ibenefit.physical.entity.PhysicalPackage;
import com.handpay.ibenefit.physical.entity.PhysicalPkgItem;
import com.handpay.ibenefit.physical.entity.PhysicalPrice;
import com.handpay.ibenefit.physical.entity.PhysicalSupply;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPkgItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPriceManager;
import com.handpay.ibenefit.physical.service.IPhysicalSupplyManager;
import com.handpay.ibenefit.physical.service.IPhysicalWelfareManager;
import com.handpay.ibenefit.physical.vo.PhysicalItemVo;
import com.handpay.ibenefit.physical.vo.PhysicalSupplyVo;
import com.handpay.ibenefit.physical.vo.SupplyDisplayPriceVo;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.search.service.ISolrIndexUpdateManager;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("/physicalPackage")
public class PhysicalPackageController extends PageController<WelfarePackage> {
    private static final Logger LOGGER = Logger.getLogger(PhysicalPackageController.class);
	private static final String BASE_DIR = "physical/";
	private static final String SIMPLE_NAME = "PhysicalPackage";

	@Reference(version = "1.0")
	private IPhysicalWelfareManager physicalWelfareManager;
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IPhysicalPkgItemManager physicalPkgItemManager;
	@Reference(version = "1.0")
	private IPhysicalSupplyManager physicalSupplyManager;
	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;
	@Reference(version = "1.0")
	private IPhysicalPriceManager physicalPriceManager;

	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager;
	@Reference(version = "1.0")
    private ICompanyGoodsManager companyGoodsManager;
    @Reference(version = "1.0")
    private ISolrIndexUpdateManager solrIndexUpdateManager;

    @Reference(version = "1.0")
    private ISupplierShopManager supplierShopManager;
    
    
	@Override
	public Manager<WelfarePackage> getEntityManager() {
		return physicalWelfareManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}


	/**
	  * physicalPackageRecommendTemplate(选择体检套餐模版)
	  *
	  * @Title: physicalPackageRecommendTemplate
	  * @Description: TODO
	  * @param @param request
	  * @param @param t
	  * @param @param backPage
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/physicalPackageRecommendTemplate")
	public String physicalPackageRecommendTemplate(HttpServletRequest request,
			PhysicalPackage t, Integer backPage) throws Exception {
	    List<Supplier> suppliers = supplierManager.getAll();
	    request.setAttribute("suppliers", suppliers);
		PageSearch page = preparePage(request);
		handlePage(request, page);
		afterPage(request, page, backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listPhysicalPackageRecommendTemplate";
	}

	/**
	 * 查询体检套餐
	 */
	@Override
    @RequestMapping(value = "/page")
	public String page(HttpServletRequest request, WelfarePackage t,Integer backPage) throws Exception {
		PageSearch page = preparePage(request);
		page = physicalWelfareManager.queryForPhysicalPackagePage(page);
		List<WelfarePackage> pkgList = page.getList();
		List<PhysicalSupply> physicalSupplyList = new ArrayList<PhysicalSupply>();
		if (pkgList != null && pkgList.size() > 0) {
			List<Long> pkgIds = new ArrayList<Long>();
			Map<String, Object> pkgIdsmap = new HashMap<String, Object>();
			for (WelfarePackage pkg : pkgList) {
				pkgIds.add(pkg.getObjectId());
			}
			pkgIdsmap.put("pkgIds", pkgIds);
			physicalSupplyList = physicalSupplyManager.queryPhysicalSupplyByPkgIdList(pkgIdsmap);
		}
		request.setAttribute("action", "page");
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("physicalSupplyList", physicalSupplyList);
		request.setAttribute("supplierList", supplierList);
		afterPage(request, page, backPage);
		return getFileBasePath() + "list"+ SIMPLE_NAME;
	}

	/**
	  * mainPackageRecommendTemplate(主套餐/加项选择模版)
	  *
	 */
	@RequestMapping(value = "/physicalPackageAddtionalTemplate")
	public String mainPackageRecommendTemplate(HttpServletRequest request,
			WelfarePackage t, Integer backPage) throws Exception {
		String packageType = request.getParameter("packageType");

		PageSearch page = preparePage(request);
		
		//加项套餐
		if ("1".equals(packageType)) {
			page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.EFFECTIVE+""));
		} else {
		    page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
		}
		
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_welfareType",IBSConstants.WELFARE_PACKAGE_TYPE_PHYSICAL+""));

		if (StringUtils.isNotBlank(packageType)) {
		  page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_packageType", packageType));
		}

		handlePage(request, page);
		afterPage(request, page, backPage);

		request.setAttribute("inputName", request.getParameter("inputName"));
		request.setAttribute("packageType", request.getParameter("packageType"));
		return BASE_DIR + "listPhysicalPackageAddtionalTemplate";
	}


	/**
	 * 体检套餐状态更新，上架 下架
	 *
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request) throws Exception {
		String[] objectIdArray = request.getParameter("objectIdArray").split(
				",");
		String status = request.getParameter("status");
		Map<String, Object> param = new HashMap<String, Object>();
		boolean flag = true;
		if (objectIdArray != null && objectIdArray.length > 0) {
			for (int i = 0; i < objectIdArray.length; i++) {
				Long packageId = null;
				if (StringUtils.isNotBlank(objectIdArray[i])) {
					packageId = Long.parseLong(objectIdArray[i].trim());
					param.put("objectId", objectIdArray[i]);
					param.put("status", status);
					Date now = new Date();
					param.put("updatedOn", now);
				}
				physicalWelfareManager.updatePhysicalPackage(param);
				if(status!=null){
					int s = Integer.parseInt(status);
                    if(s == IBSConstants.SHELVES_ING){
                        companyGoodsManager.upPackage(welfarePackageManager.getByObjectId(packageId));

                    }else if (s == IBSConstants.SHELF_OFF){
                        flag  = false;
                        companyGoodsManager.downPackage(packageId);
                    }
                    if(flag){
					    try{
					        //更新索引文档
					    	  solrIndexUpdateManager.addPackage(packageId);
					        }catch(Exception e){
					            LOGGER.error("update solr index by skuId have a error!\n"+e);
					        }
					}else{
						try{
			                solrIndexUpdateManager.deletePackageDocById(packageId.toString());
			            }catch(Exception e){
			                LOGGER.error("delete solr index by skuId have a error!\n"+e);
			            }
					}
                }
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

	/**
	 * 删除体检套餐
	 */
	@Override
    @RequestMapping(value = "/delPhy")
	protected String handleDelete(HttpServletRequest request,
			HttpServletResponse response, Long objectId) {
		//只有状态为带上架或者已下架的商品才能上架
        String message = "删除套餐成功";

		String[] objectIdArray = request.getParameter("objectIdArray").split(",");
		Map<String, Object> param = new HashMap<String, Object>();
		if (objectIdArray != null && objectIdArray.length > 0) {
			for (int i = 0; i < objectIdArray.length; i++) {
				if (objectIdArray[i] != null && !("").equals(objectIdArray[i])) {
					param.put("objectId", objectIdArray[i]);
					param.put("isDeleted", ForeverEntity.DELETED_YES);
					WelfarePackage welfarePackage = physicalWelfareManager.getByObjectId(Long.valueOf(objectIdArray[i]));
					 if(welfarePackage != null && welfarePackage.getStatus() != null ){
							 if(welfarePackage.getPackageType().intValue() == IBSConstants.MAIN_PACKAGE_TYPE){
								 if(welfarePackage.getStatus() != IBSConstants.SHELVES_ING){
									 physicalWelfareManager.updatePhysicalPackage(param);
								 }else{
									 message = "删除失败，套餐【"+welfarePackage.getPackageName()+"】为上架状态中，不能删除";
									 break;
								 }
							 }else if(welfarePackage.getPackageType().intValue() == IBSConstants.ADDTIONAL_PACKAGE_TYPE){
								 if(welfarePackage.getStatus().intValue() == IBSConstants.INVALID){
									 physicalWelfareManager.updatePhysicalPackage(param);
								 }else{
									 message = "删除失败，套餐【"+welfarePackage.getPackageName()+"】为有效状态中，不能删除";
									 break;
								 }
							 }
						 }
					}
				}
		}else{
            message = "删除失败，你未选择任何套餐";
        }
        return  "redirect:page" +getMessage(message, request);
	}

	/**
	 * 新增体检套餐
	 */
	@Override
    @RequestMapping(value = "/create")
	public String create(HttpServletRequest request,HttpServletResponse response, WelfarePackage physicalPackage)
			throws Exception {
		JSONArray selPhysicalItemStrInfo = new JSONArray();
		
		request.setAttribute("selPhysicalItemStrInfo", selPhysicalItemStrInfo);
		// 供应商信息
		List<PhysicalSupply> psList = new ArrayList<PhysicalSupply>();
		List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("psList", psList);
		request.setAttribute("supplierList", supplierList);
		request.setAttribute("physicalSupplyVoJson", JSONArray.fromObject(new ArrayList<PhysicalSupplyVo>()));
		return getFileBasePath() + "create"
				+ SIMPLE_NAME;
	}

	/**
	 *
	 * @param request
	 * @param physicalPackage
	 *            套餐信息
	 * @param physicalSupplyInfos
	 *            供应商信息 格式为：供应商名称_供应商ID_套餐编号&供应商名称_供应商ID_套餐编号
	 * @param packageEntityStock
	 *            实体兑换券 数目
	 * @param packageElecStock
	 *            电子兑换券 数目
	 * @param pkgItem
	 *            套餐细项
	 * @return
	 */
	@RequestMapping(value = "/savephysicalPackage")
	public String savephysicalPackage(HttpServletRequest request,
			WelfarePackage physicalPackage, String physicalSupplyInfos,
			String packageEntityStock, String packageElecStock, String pkgItem) {

		// 新增套餐
		if (physicalPackage.getObjectId() == null) {
			// 待上架
			physicalPackage.setStatus(1);
			// 0 正常 1 删除
			physicalPackage.setDeleted(ForeverEntity.DELETED_NO);
			// 创建人
			physicalPackage.setCreatedBy(FrameworkContextUtils.getCurrentUserId());
			// 创建时间
			physicalPackage.setCreatedOn(new Date());
			physicalPackage.setUpdatedOn(new Date());

		}
		// 修改套餐
		else {
			physicalPackage.setUpdatedBy(FrameworkContextUtils.getCurrentUserId());
			physicalPackage.setUpdatedOn(new Date());
		}
		//判断是否立即生效
		if(physicalPackage.getImmediatelyEffect() != null){
			if(physicalPackage.getImmediatelyEffect() == IBSConstants.STATUS_YES){
				if(physicalPackage.getPackageType() == IBSConstants.MAIN_PACKAGE_TYPE){
					physicalPackage.setStatus(IBSConstants.SHELVES_ING);
				}else{
					physicalPackage.setStatus(IBSConstants.EFFECTIVE);
				}
				physicalPackage.setStartDate(new Date());
			}else{
				if(physicalPackage.getPackageType() == IBSConstants.ADDTIONAL_PACKAGE_TYPE){
					physicalPackage.setStatus(IBSConstants.INVALID);
				}
			}
		}
		

		/**
		 * 由于涉及多表的操作，会用到事务
		 */
		List<WelfarePackage> savedPhysicalPackages = physicalWelfareManager.savephysicalPackage(physicalPackage,
				physicalSupplyInfos, packageEntityStock, packageElecStock,
				pkgItem);
		if (savedPhysicalPackages!=null && savedPhysicalPackages.size()>0) {
			physicalPackage = savedPhysicalPackages.get(0);
		}
		for (WelfarePackage welfarePackage : savedPhysicalPackages) {
			if(welfarePackage.getStatus() == IBSConstants.SHELVES_ING){
				companyGoodsManager.upPackage(welfarePackageManager.getByObjectId(welfarePackage.getObjectId()));
				try{
					//更新索引文档
					solrIndexUpdateManager.addPackage(welfarePackage.getObjectId());
				}catch(Exception e){
					LOGGER.error("update solr index by physicalPackageId have a error!", e);
				}
			}else if(welfarePackage.getStatus() == IBSConstants.SHELF_OFF){
				try{
					Long packageId  = welfarePackage.getObjectId();
					solrIndexUpdateManager.deletePackageDocById(packageId.toString());
				}catch(Exception e){
					LOGGER.error("delete solr index by physicalPackageId have a error!", e);
				}
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

	/**
	 * 编辑体检套餐
	 */
	@Override
    @RequestMapping(value = "/edit/{objectId}")
	public String edit(HttpServletRequest request,HttpServletResponse response, @PathVariable Long objectId)throws Exception {
		if (null != objectId) {
			WelfarePackage physicalPackage = physicalWelfareManager.getByObjectId(objectId);
			List<Supplier> supplierList = supplierManager.querySupplierByType(1);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("packageId", objectId);
			List<PhysicalItemVo> piVoList = physicalItemManager.queryPhysicalItemByPkgId(param);
			// 供应商信息
			List<PhysicalSupply> psList = physicalSupplyManager.queryPhysicalSupplyByPkgId(param);
			// 体检套餐关联项
			List<PhysicalPkgItem> ppiList = physicalPkgItemManager.queryPhysicalPkgItemByPkg(param);
			List<Long> physicalPriceIds = new ArrayList<Long>();
			if (ppiList != null && ppiList.size() > 0) {
				for (PhysicalPkgItem pkgItem : ppiList) {
					physicalPriceIds.add(pkgItem.getPhysicalPriceId());
				}
			}
		
			List<PhysicalSupplyVo> physicalSupplyVos = physicalSupplyManager.paramPhysicalSupplyToVo(psList);
			
			List<SupplyDisplayPriceVo> spList = physicalItemManager.makeSupplyDisplayPriceVo(physicalSupplyVos, physicalPriceIds);
			
			List<Long> physicalItemIds = this.getPhysicalItemIds(piVoList);
			List<Long> physicalSupplyIds = this.getPhysicalSupplyIds(psList);
			List<PhysicalItem> physicalItems = physicalItemManager.queryItemAndSetSupplyPriceInfos(physicalItemIds, physicalSupplyIds);
			JSONArray selPhysicalItemStrInfo = this.makeSelPhysicalItemStrInfo(physicalItems);
			
			request.setAttribute("selPhysicalItemStrInfo", selPhysicalItemStrInfo);
			
			// 供应商编号List
			request.setAttribute("physicalSupplyVoJson", JSONArray.fromObject(physicalSupplyVos));
			// 套餐信息
			request.setAttribute("entity", physicalPackage);
			// 所有供应商信息
			request.setAttribute("supplierList", supplierList);
			// 套餐对应的供应商信息
			request.setAttribute("psList", psList);
			// 体检细项信息
			request.setAttribute("piVoList", piVoList);
			// 供应商价格信息
			request.setAttribute("spList", spList);
		}
		return getFileBasePath() + "create"+ SIMPLE_NAME;
	}
	
	
	private JSONArray makeSelPhysicalItemStrInfo(List<PhysicalItem> physicalItems){
		List<String> strInfos = new ArrayList<String>();

		if(physicalItems != null && physicalItems.size()>0){
			for (PhysicalItem item : physicalItems) {
				StringBuilder sb = new StringBuilder("");
				sb.append(item.getObjectId());
				sb.append("_");
				sb.append(item.getParentItemId());
				sb.append("_");
				sb.append(item.getFirstItemName());
				sb.append("_");
				sb.append(item.getSecondItemName());
				sb.append("_");
				sb.append(item.getIsMan());
				sb.append("_");
				sb.append(item.getIsWomanMarried());
				sb.append("_");
				sb.append(item.getIsWomanUnmarried());
				sb.append("_");
				sb.append(item.getSupplyPriceInfo());
				strInfos.add(sb.toString());
			}
		}
		
		JSONArray physicalItemStrInfosJson = JSONArray.fromObject(strInfos);
		
		return physicalItemStrInfosJson;
	}
	
	private List<Long> getPhysicalItemIds(List<PhysicalItemVo> piVoList){
		List<Long> items = new ArrayList<Long>();
		if(piVoList != null && piVoList.size()>0){
			for (PhysicalItemVo physicalItemVo : piVoList) {
				if(physicalItemVo.getPhysicalItemId() != null){
					items.add(physicalItemVo.getPhysicalItemId());
				}
			}
		}
		return items;
	}
	
	
	private List<Long> getPhysicalSupplyIds(List<PhysicalSupply> psList){
		List<Long>  physicalSupplyIds = new ArrayList<Long>();
		for (PhysicalSupply physicalSupply : psList) {
			if(physicalSupply.getSupplierId() != null){
				if(!physicalSupplyIds.contains(physicalSupply.getSupplierId())){
					physicalSupplyIds.add(physicalSupply.getSupplierId());
				}
			}
		}
		return physicalSupplyIds;
	}
	

	/**
	 * 选中供应商，加载相应的体检细项
	 *
	 * @param request
	 * @param tjOrgs
	 *            供应商信息 格式为 供应商ID,供应商ID
	 * @return
	 */
	@RequestMapping(value = "selectItem")
	public String selectItem(HttpServletRequest request, String tjOrgs,String choosedItemIds) {
		List<PhysicalItem> physicalItems = new ArrayList<PhysicalItem>();
		Map<String, Object> map = new HashMap<String, Object>();
		List<Long> tjOrgList = new ArrayList<Long>();
		if (!"".equals(tjOrgs) && tjOrgs != null) {
			String[] tjOrg = tjOrgs.split(",");
			if (tjOrg != null && tjOrg.length > 0) {
				for (String org : tjOrg) {
					tjOrgList.add(Long.parseLong(org));
				}
			}
		}
		List<List<Long>> itemIdArrays = new ArrayList<List<Long>>();
		if (tjOrgList != null && tjOrgList.size() > 0) {
			for (int i = 0; i < tjOrgList.size(); i++) {
				map.put("supplierId", tjOrgList.get(i));
				List<PhysicalPrice> ppList = physicalPriceManager.queryPhysicalPriceBySupplyId(map);
				List<Long> itemIdArray = new ArrayList<Long>();
				for (PhysicalPrice physicalPrice : ppList) {
					if(physicalPrice.getObjectId() != null){
						if(!itemIdArray.contains(physicalPrice.getSubItemId())){
							itemIdArray.add(physicalPrice.getSubItemId());
						}
					}
				}
				itemIdArrays.add(itemIdArray);
			}
		}
		List<Long> itemNos = this.findSameElem(itemIdArrays);
		//剔除已选择 体检项目
		if(choosedItemIds != null && !choosedItemIds.trim().equals("")){
			String[] choosedItemIdArray = choosedItemIds.split(",");
			for (String choosedItemId : choosedItemIdArray) {
				if(choosedItemId != null && !choosedItemId.trim().equals("")){
					itemNos.remove(Long.valueOf(choosedItemId));
				}
			}
		}
		physicalItems = physicalItemManager.queryItemAndSetSupplyPriceInfos(itemNos, tjOrgList);
		request.setAttribute("physicalItems", physicalItems);
		return getFileBasePath() + "selectPhysicalItem";
	}

	@RequestMapping(value = "/physicalPackageTemplate")
	public String physicalPackageTemplate(HttpServletRequest request, PhysicalPackage t, Integer backPage)
			throws Exception {
		PageSearch page  = preparePage(request);
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "physical/" + "listPhysicalPackageTemplate";
	}
	
	/**
	 * 
	 * @Title: findSameElem 
	 * @Description: 找出List 中 相同 项
	 * @param lists
	 * @return
	 * @throws 
	 * @author 陈传洞
	 */
	private  List<Long> findSameElem(List<List<Long>> lists) {
        if(lists.size()==0)return Collections.emptyList();
        List<Long> tmpList = new ArrayList<Long>(lists.get(0));
        for (int i=1;i<lists.size();i++) {
            List<Long> aList=lists.get(i);
            tmpList.retainAll(aList);
        }
        return tmpList;
    }

	//体检套餐升级包中新增编辑使用
	@RequestMapping(value = "/physicalPackageoneTemplate")
	public String physicalPackageoneTemplate(HttpServletRequest request, PhysicalPackage t, Integer backPage)
			throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_welfareType",IBSConstants.WELFARE_PACKAGE_TYPE_PHYSICAL+""));
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(), "EQL_packageType", "0"));
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "physical/" + "listPhysicalPackageoneTemplate";
	}

	@RequestMapping(value = "/physicalPackagePromoteTemplate")
	public String physicalPackageCommonTemplate(HttpServletRequest request, PhysicalPackage t, Integer backPage)
			throws Exception {

		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_status",IBSConstants.SHELVES_ING+""));
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(),"EQI_welfareType",IBSConstants.WELFARE_PACKAGE_TYPE_PHYSICAL+""));
		page.getFilters().add(new PropertyFilter(WelfarePackage.class.getName(), "EQL_packageType", "0"));

		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return "physical/" + "listPhysicalPackagePromoteTemplate";
	}

	@Override
	@RequestMapping(value = "/view/{objectId}")
	public String view(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			WelfarePackage physicalPackage = physicalWelfareManager.getByObjectId(objectId);
			List<Supplier> supplierList = supplierManager.querySupplierByType(1);
			Map<String, Object> param = new HashMap<String, Object>();
			param.put("packageId", objectId);
			List<PhysicalItemVo> piVoList = physicalItemManager.queryPhysicalItemByPkgId(param);
			// 供应商信息
			List<PhysicalSupply> psList = physicalSupplyManager.queryPhysicalSupplyByPkgId(param);
			// 体检套餐关联项
			List<PhysicalPkgItem> ppiList = physicalPkgItemManager.queryPhysicalPkgItemByPkg(param);
			List<Long> physicalPriceIds = new ArrayList<Long>();
			if (ppiList != null && ppiList.size() > 0) {
				for (PhysicalPkgItem pkgItem : ppiList) {
					physicalPriceIds.add(pkgItem.getPhysicalPriceId());
				}
			}
		
			List<PhysicalSupplyVo> physicalSupplyVos = physicalSupplyManager.paramPhysicalSupplyToVo(psList);
			
			List<SupplyDisplayPriceVo> spList = physicalItemManager.makeSupplyDisplayPriceVo(physicalSupplyVos, physicalPriceIds);
			
			// 供应商编号List
			request.setAttribute("physicalSupplyVoJson", JSONArray.fromObject(physicalSupplyVos));
			// 套餐信息
			request.setAttribute("entity", physicalPackage);
			// 所有供应商信息
			request.setAttribute("supplierList", supplierList);
			// 套餐对应的供应商信息
			request.setAttribute("psList", psList);
			// 体检细项信息
			request.setAttribute("piVoList", piVoList);
			// 供应商价格信息
			request.setAttribute("spList", spList);
		}
		return getFileBasePath() + "view"
				+ SIMPLE_NAME;
	}
	
	@RequestMapping(value = "/showSupInfo")
	public String showSupInfo(HttpServletRequest request,HttpServletResponse response){
		String supIds = request.getParameter("supIds");
		Map<String, List<SupplierShop>> supplierMaps = supplierShopManager.getBySupplierId(supIds);
		request.setAttribute("supplierMaps", supplierMaps);
		return getFileBasePath() + "viewSupInfo";
	}
}
