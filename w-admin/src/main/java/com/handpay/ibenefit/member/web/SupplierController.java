package com.handpay.ibenefit.member.web;

import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierAttach;
import com.handpay.ibenefit.member.entity.SupplierBrand;
import com.handpay.ibenefit.member.entity.SupplierDispatchArea;
import com.handpay.ibenefit.member.entity.SupplierInnerCompany;
import com.handpay.ibenefit.member.entity.SupplierLiquidation;
import com.handpay.ibenefit.member.entity.SupplierTypes;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ISupplierAttachManager;
import com.handpay.ibenefit.member.service.ISupplierBrandManager;
import com.handpay.ibenefit.member.service.ISupplierDispatchAreaManager;
import com.handpay.ibenefit.member.service.ISupplierInnerCompanyManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierTypesManager;
import com.handpay.ibenefit.member.service.ISupplierliquidationManager;
import com.handpay.ibenefit.news.service.IContractManager;
import com.handpay.ibenefit.product.entity.Brand;
import com.handpay.ibenefit.product.service.IBrandManager;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/supplier")
public class SupplierController extends PageController<Supplier>{
	private static final String BASE_DIR = "member/";

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private ICompanyManager companyManager;

	@Reference(version = "1.0")
	private ISupplierTypesManager supplierTypesManager;

	@Reference(version = "1.0")
	private ISupplierBrandManager supplierBrandManager;

	@Reference(version = "1.0")
	private ISupplierDispatchAreaManager supplierDispatchAreaManager;

	@Reference(version = "1.0")
	private ISupplierAttachManager supplierAttachManager;

	@Reference(version = "1.0")
	private ISupplierliquidationManager supplierliquidationManager;
	
	@Reference(version = "1.0")
	private ISupplierInnerCompanyManager supplierInnerCompanyManager;

	@Reference(version = "1.0")
	private IBrandManager brandManager;

	@Reference(version = "1.0")
	private IProductCategoryManager productCategoryManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private IContractManager contractManager;

	@Reference(version = "1.0")
	private static IAreaManager areaManager;
	
	@Reference(version="1.0")
	private ICompanyGoodsManager companyGoodsManager;

	@Override
	public Manager<Supplier> getEntityManager() {
		return supplierManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch pSearch=preparePage(request);
		PageSearch result=supplierManager.findSuppliers(pSearch);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		request.setAttribute("action", "page");
		Brand brand=new Brand();
		brand.setStatus(IBSConstants.EFFECTIVE);
		List<Brand> brands=brandManager.getBySample(brand);
		request.setAttribute("brands", brands);
		return getFileBasePath() + "listSupplier";
	}

	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		request.setAttribute("view", 1);
		String result = super.handleView(request, response, objectId);
		if (null != objectId) {
			Supplier entity = getManager().getByObjectId(objectId);
			SupplierTypes supplierType=new SupplierTypes();
			supplierType.setSupplierId(objectId);
			List<SupplierTypes> supplierTypeList = supplierTypesManager.getBySample(supplierType);
			String code = entity.getAreaId();
			String areaName = "";
			String province = "";
			String city = "";
			String district = "";
			if (StringUtils.isNotBlank(code)) {
				Long areaId = Long.parseLong(code);
				if(areaId!=null){
					if(areaId>=100000){
						district = areaManager.getByObjectId(areaId).getName();
					}
					if(areaId >= 1000){
						Long id = areaId/100;
						city = areaManager.getByObjectId(id).getName();
						city = city.replace("市辖区", "");
						city = city.replace("县", "");
						areaName += city;
					}
					if(areaId>= 0){
						Area  area = areaManager.getByObjectId(areaId/10000);
						if(area!=null){
							province = area.getName();
						}
					}
				}
				areaName = province+city+district;
			}
			request.setAttribute("areaName", areaName);
			if (supplierTypeList!=null && supplierTypeList.size()>0) {
				request.setAttribute("supplierTypeList", supplierTypeList);
			}else{
				request.setAttribute("supplierTypeList", null);
			}

		}
		return result;
	}

	@RequestMapping("/viewDetail/{objectId}")
	protected String viewDetail(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId) throws Exception {
		request.setAttribute("view", 1);
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		return BASE_DIR + "viewDetailSupplier";
	}

	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		PageSearch pageSearch = new PageSearch();
		pageSearch.setEntityClass(Brand.class);
		pageSearch.getFilters().add(new PropertyFilter(Brand.class.getName(),"EQI_status",IBSConstants.EFFECTIVE + ""));
		pageSearch.getFilters().add(new PropertyFilter(Brand.class.getName(),"EQI_deleted",IBSConstants.NOT_DELETE + ""));
		pageSearch.setPageSize(Integer.MAX_VALUE);
		pageSearch.setSortProperty("chineseName");
		pageSearch.setSortOrder("asc");
		request.setAttribute("brands", brandManager.find(pageSearch).getList());
		//一级分类
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
		if (objectId!=null) {
			Supplier supplier=getEntityManager().getByObjectId(objectId);
			if (supplier.getApplyId()!=null) {
				request.setAttribute("applierName", userManager.getByObjectId(supplier.getApplyId()).getUserName());
			}
			SupplierTypes supplierType=new SupplierTypes();
			supplierType.setSupplierId(objectId);
			List<SupplierTypes> supplierTypes=supplierTypesManager.getBySample(supplierType);
			if (supplierTypes.size()!=0) {
				String typeIds = "";
				for(SupplierTypes suTypes:supplierTypes){
					typeIds += suTypes.getTypeId() + ",";
				}
				request.setAttribute("typeIds", typeIds);
			}
			//内卖企业
			SupplierInnerCompany sic=new SupplierInnerCompany();
			sic.setSupplierId(objectId);
			List<SupplierInnerCompany> sics=supplierInnerCompanyManager.getBySample(sic);
			String companyNames="";
			if (sics.size()!=0) {
				for(SupplierInnerCompany ss:sics){
					if (ss.getCompanyId()!=null) {
						Company company=companyManager.getByObjectId(ss.getCompanyId());
						if (company!=null) {
							if (StringUtils.isNotBlank(company.getCompanyName())) {
								if (ss==sics.get(0)) {
									companyNames=companyNames.concat(company.getCompanyName());
								}else {
									companyNames=companyNames.concat(",");
									companyNames=companyNames.concat(company.getCompanyName());
								}
							}
						}
					}
				}
			}
			request.setAttribute("companyName", companyNames);
			//清算信息
			SupplierLiquidation supplierLiquidation=supplierliquidationManager.getBySupplierId(objectId);
			request.setAttribute("liquid", supplierLiquidation);

			//代理品牌
			List<SupplierBrand> supplierBrands=supplierBrandManager.getSupplierBrands(objectId);
			if (supplierBrands.size()!=0) {
				Iterator<SupplierBrand> it=supplierBrands.iterator();
				while (it.hasNext()) {
					SupplierBrand ss = (SupplierBrand) it.next();
					if (ss.getIsPublished()==IBSConstants.STATUS_NO) {
						supplierBrandManager.delete(ss.getObjectId());
						it.remove();
					}
				}
			}
			request.setAttribute("supplierBrands", supplierBrands);

			//配送区域
			SupplierDispatchArea supplierDispatchArea=new SupplierDispatchArea();
			supplierDispatchArea.setSupplierId(objectId);
			List<SupplierDispatchArea> supplierDispatchAreas=supplierDispatchAreaManager.getBySample(supplierDispatchArea);
			if (supplierDispatchAreas.size()!=0) {
				Iterator<SupplierDispatchArea> it=supplierDispatchAreas.iterator();
				while (it.hasNext()) {
					SupplierDispatchArea ss = (SupplierDispatchArea) it.next();
					if (ss.getIsPublished()==IBSConstants.STATUS_NO) {
						supplierDispatchAreaManager.delete(ss.getObjectId());
						it.remove();
					}
				}
			}
			request.setAttribute("supplierDispatchAreas", supplierDispatchAreas);

			//附件
			SupplierAttach supplierAttach=new SupplierAttach();
			supplierAttach.setSupplierId(objectId);
			List<SupplierAttach> supplierAttachs=supplierAttachManager.getBySample(supplierAttach);
			if (supplierAttachs.size()!=0) {
				Iterator<SupplierAttach> it=supplierAttachs.iterator();
				while (it.hasNext()) {
					SupplierAttach ss = (SupplierAttach) it.next();
					if (ss.getIsPublished()==IBSConstants.STATUS_NO) {
						supplierAttachManager.delete(ss.getObjectId());
						it.remove();
					}
				}
			}
			request.setAttribute("supplierAttachs", supplierAttachs);
			request.setAttribute("supplierAttachsSize", supplierAttachs.size());
		}else {
			request.setAttribute("supplierBrands", null);
		}

		return super.handleEdit(request, response, objectId);
	}

	/***
	 * 基本信息保存
	 */
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			Supplier t) throws Exception {
		request.setCharacterEncoding("utf-8");
		Supplier temp=null;
		String areaId=request.getParameter("areaId1");
		if (StringUtils.isNotBlank(areaId)) {
			t.setAreaId(areaId);
		}
		if (t.getObjectId()==null) {
			t.setCreatedBy(FrameworkContextUtils.getCurrentUserId());
			t.setCreatedOn(new Date());
			t.setUpdatedOn(new Date());
			t.setDeleted(IBSConstants.STATUS_NO);
			t.setSupplierStatus(IBSConstants.STATUS_NO);
			t.setStatus(IBSConstants.VERIFY_STATUS_DRAFT);
		}
		
		Supplier ss=new Supplier();
		ss.setSupplierName(t.getSupplierName());
		List<Supplier> suppliers=getEntityManager().getBySample(ss);
		//新增
		if (t.getObjectId()==null) {
			if (suppliers.size()==0) {
				t=getEntityManager().save(t);
				//默认配送区域
				SupplierDispatchArea first=new SupplierDispatchArea();
				first.setSupplierId(t.getObjectId());
				first.setAreaId("-1");
				first.setProvName("全国");
				first.setCityName("全国");
				first.setAreaName("全国");
				first.setDistributionTime("7");
				first.setDistributionPrice(0D);
				first.setIsPublished(IBSConstants.STATUS_YES);
				supplierDispatchAreaManager.save(first);
				modelMap.addAttribute("firArea",first);
			}
		}else {//修改
			temp=getEntityManager().getByObjectId(t.getObjectId());
			t.setCreatedBy(temp.getCreatedBy());
			t.setCreatedOn(temp.getCreatedOn());
			t.setUpdatedOn(temp.getUpdatedOn());
			t.setDeleted(temp.getDeleted());
			t.setSupplierStatus(temp.getSupplierStatus());
			t.setStatus(temp.getStatus());
			boolean flag = StringUtils.isNotBlank(temp.getSupplierName()) && StringUtils.isNotBlank(t.getSupplierName());
			if (flag) {
				if (temp.getSupplierName().equals(t.getSupplierName())) {
					if (suppliers.size()==1) {
						t=getEntityManager().save(t);
					}
				}else {
					if (suppliers.size()==0) {
						t=getEntityManager().save(t);
					}
				}
			}
		}
		if (t!=null && t.getObjectId()!=null) {
			modelMap.addAttribute("supId",t.getObjectId().toString());
			t=supplierliquidationManager.setLiquidation(t, temp);
			//供应商编号
			t.setSupplierNo(t.getObjectId());
			t.setStatus(IBSConstants.VERIFY_STATUS_DRAFT);
			temp=getEntityManager().save(t);
			//保存关联类型
			SupplierTypes supplierTypes=new SupplierTypes();
			supplierTypes.setSupplierId(temp.getObjectId());
			supplierTypesManager.deleteBySample(supplierTypes);
			String typeIds=request.getParameter("types");
			if (StringUtils.isNotBlank(typeIds)) {
				String[] ids=typeIds.split(",");
				SupplierTypes supplierType=new SupplierTypes();
				supplierType.setSupplierId(temp.getObjectId());
				for (int i = 0; i < ids.length; i++) {
					supplierType.setTypeId(Integer.parseInt(ids[i]));
					supplierTypesManager.save(supplierType);
				}
			}else {
				modelMap.addAttribute("result",false);
			}

			//内卖企业
			SupplierInnerCompany sic=new SupplierInnerCompany();
			sic.setSupplierId(temp.getObjectId());
			supplierInnerCompanyManager.deleteBySample(sic);
			String companyIds=request.getParameter("companyId");
			String companyNames=request.getParameter("companyName");
			if (StringUtils.isNotBlank(companyNames) && StringUtils.isNotBlank(companyIds)) {
				String[] idss=companyIds.split(",");
				SupplierInnerCompany supplierInnerCompany=new SupplierInnerCompany();
				supplierInnerCompany.setSupplierId(temp.getObjectId());
				for (int i = 0; i < idss.length; i++) {
					supplierInnerCompany.setCompanyId(Long.parseLong(idss[i]));
					supplierInnerCompanyManager.save(supplierInnerCompany);
				}
			}
			//是否仅供内卖
			String isInSelling=request.getParameter("isSelf");
			if (StringUtils.isNotBlank(isInSelling)) {
				temp.setIsInSelling(Integer.parseInt(isInSelling));
			}else {
				temp.setIsInSelling(IBSConstants.STATUS_NO);
			}
			supplierManager.save(temp);
		}
		modelMap.addAttribute("result",true);
		return "jsonView";
	}

	/**
	 * 申请保存/提交审核
	 * @param request
	 * @return
	 */
	@RequestMapping("/allSave")
	public String allSave(HttpServletRequest request) {
		String supplierId=request.getParameter("id");
		String verify=request.getParameter("verify");
		if (StringUtils.isNotBlank(supplierId)) {
			Supplier supplier=getEntityManager().getByObjectId(Long.parseLong(supplierId));
			if (supplier!=null) {
				//保存品牌
				SupplierBrand sb=new SupplierBrand();
				sb.setSupplierId(supplier.getObjectId());
				List<SupplierBrand> sBrands=supplierBrandManager.getBySample(sb);
				if (sBrands.size()!=0) {
					for(SupplierBrand sBrand:sBrands){
						//改临时变正式
						if (sBrand.getIsPublished()==IBSConstants.STATUS_NO) {
							sBrand.setIsPublished(IBSConstants.STATUS_YES);
							supplierBrandManager.save(sBrand);
						}
					}
				}
				//保存区域
				SupplierDispatchArea sda=new SupplierDispatchArea();
				sda.setSupplierId(supplier.getObjectId());
				List<SupplierDispatchArea> sdas=supplierDispatchAreaManager.getBySample(sda);
				if (sdas.size()!=0) {
					for(SupplierDispatchArea sArea:sdas){
						//改临时变正式
						if (sArea.getIsPublished()==IBSConstants.STATUS_NO) {
							sArea.setIsPublished(IBSConstants.STATUS_YES);
							supplierDispatchAreaManager.save(sArea);
						}
					}
				}
				//保存附件
				SupplierAttach sAttach=new SupplierAttach();
				sAttach.setSupplierId(supplier.getObjectId());
				List<SupplierAttach> saAttachs=supplierAttachManager.getBySample(sAttach);
				if (saAttachs.size()!=0) {
					for(SupplierAttach sa:saAttachs){
						if(sa.getIsPublished()==IBSConstants.STATUS_NO){
							sa.setIsPublished(IBSConstants.STATUS_YES);
							supplierAttachManager.save(sa);
						}
					}
				}
			}
			//保存审核状态
			if ("0".equals(verify)) {
				if (supplier.getStatus()==null || supplier.getStatus()!=1) {
					supplier.setUpdatedOn(new Date());
					supplier.setStatus(IBSConstants.VERIFY_STATUS_DRAFT);
				}
			}else if("1".equals(verify)){
				if (supplier.getStatus()==null || supplier.getStatus()!=0) {
					supplier.setUpdatedOn(new Date());
					supplier.setStatus(IBSConstants.VERIFY_STATUS_ING);
				}
			}
			supplier.setSupplierStatus(IBSConstants.STATUS_NO);
			if (supplier.getApplyId()==null) {
				supplier.setApplyId(FrameworkContextUtils.getCurrentUserId());
				supplier.setApplyTime(new Date());
			}
			getEntityManager().save(supplier);
		}
		return "redirect:/supplier/page" + getMessage("common.base.success", request);
	}

	/**
	  * supplierTemplate(供应商选择模版，单选)
	  *
	  * @Title: supplierTemplate
	  * @Description: TODO
	  * @param @param request
	  * @param @param t
	  * @param @param backPage
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/supplierTemplate")
	public String supplierTemplate(HttpServletRequest request,Supplier t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(Supplier.class.getName(),"EQI_status","3"));
		page.getFilters().add(new PropertyFilter(Supplier.class.getName(),"EQI_supplierStatus","1"));
		super.handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		String functionName = request.getParameter("functionName");
		request.setAttribute("functionName", functionName==null||"".equals(functionName)?"exception":request.getParameter("functionName"));
		return BASE_DIR + "listSupplierTemplate";
	}

	/**
	  * suppliersTemplate(供应商选择模版，多选)
	  *
	  * @Title: suppliersTemplate
	  * @Description: TODO
	  * @param @param request
	  * @param @param t
	  * @param @param backPage
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value = "/suppliersTemplate")
	public String suppliersTemplate(HttpServletRequest request,Supplier t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(Supplier.class.getName(),"EQI_status","3"));
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listSuppliersTemplate";
	}

	/**
	 * 供应商入驻审核
	 * @param request
	 * @return
	 */
	@RequestMapping("/verify")
	public String verifySupplier(HttpServletRequest request,PageSearch page) {
		PageSearch pSearch=preparePage(request);
		pSearch.getFilters().add(new PropertyFilter(Company.class.getName(), "NEI_neStatus", "1"));
		PageSearch result=supplierManager.findSuppliers(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		request.setAttribute("action", "verify");
		Brand brand=new Brand();
		brand.setStatus(IBSConstants.EFFECTIVE);
		List<Brand> brands=brandManager.getBySample(brand);
		request.setAttribute("brands", brands);
		return BASE_DIR +"listVerifySupplier";
	}


	/**
	 * 审核通过
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/verifySuccess")
	public String verifySuccess(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String supplierId=request.getParameter("id");
		if (StringUtils.isNotBlank(supplierId) ) {
			Supplier supplier=supplierManager.getByObjectId(Long.parseLong(supplierId));
			if(supplier.getStatus() == IBSConstants.VERIFY_STATUS_ING){
				supplier.setStatus(IBSConstants.VERIFY_STATUS_SUCCESS);
				supplier.setUpdatedOn(new Date());
				supplier.setSupplierStatus(IBSConstants.EFFECTIVE);
				supplierManager.save(supplier);
				//事务的问题，审核通过，需要单独调一次
				companyGoodsManager.updateBySupplierId(supplier.getObjectId());
				modelMap.addAttribute("result", true);
			}else{
				modelMap.addAttribute("result", false);
				modelMap.addAttribute("message", "供应商信息已发生变更");
			}
			
		}
		return "jsonView";
	}

	/**
	 * 审核不通过
	 * @param request
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/verifyFail/{reasons}")
	public String verifyFail(HttpServletRequest request,@PathVariable String reasons,ModelMap map) throws Exception {
		String supplierId=request.getParameter("id");
		if (StringUtils.isNotBlank(supplierId) ) {
			Supplier supplier=supplierManager.getByObjectId(Long.parseLong(supplierId));
			if(supplier.getStatus() == IBSConstants.VERIFY_STATUS_ING){
				supplier.setStatus(2);
				supplier.setUpdatedOn(new Date());
				supplier.setSupplierStatus(0);
				supplier.setReasons(reasons);
				supplierManager.save(supplier);
				map.addAttribute("result", true);
			}else{
				map.addAttribute("result", false);
				map.addAttribute("message", "供应商信息已发生变更");
			}
			
		}
		
		return "jsonView";
	}


	/**
	 * 供应商信息查询
	 * @param request
	 * @return
	 */
	@RequestMapping("/viewInfo")
	public String viewCompanyInfo(HttpServletRequest request) {
		PageSearch pSearch=preparePage(request);
		pSearch.getFilters().add(new PropertyFilter(Company.class.getName(), "EQI_status", "3"));
		PageSearch result=supplierManager.findSuppliers(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		request.setAttribute("action", "viewInfo");
		Brand brand=new Brand();
		brand.setStatus(IBSConstants.EFFECTIVE);
		List<Brand> brands=brandManager.getBySample(brand);
		request.setAttribute("brands", brands);
		return BASE_DIR +"listCheckViewSupplier";
	}

	/**
	 * 与合同相关的供应商信息查询
	 * @param request
	 * @return
	 */
	@RequestMapping("/viewInfoContract")
	public String viewInfoContract(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		Integer status=3;
		page.getFilters().add(new PropertyFilter(Supplier.class.getName(), "EQI_status", status.toString()));
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		return "/news/listCheckViewSupplier";
	}

	/**
	 * 与合同相关的供应商信息查询
	 * @param request
	 * @return
	 */
	@RequestMapping("/getSupplierInfo")
	public String getSupplierInfo(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		Integer status=3;
		page.getFilters().add(new PropertyFilter(Supplier.class.getName(), "EQI_status", status.toString()));
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		return "/news/listCheckViewSupplier";
	}

	/**
	 * 置为无效
	 * @param request
	 * @param ids
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/onInvalid/{ids}")
	public String onInvalid(HttpServletRequest request,@PathVariable String ids,ModelMap map) throws Exception {
		String[] array=ids.split(",");
		for (int i = 0; i < array.length; i++) {
			Supplier supplier=getEntityManager().getByObjectId(Long.parseLong(array[i]));
			supplier.setSupplierStatus(0);
			supplierManager.save(supplier);
			companyGoodsManager.updateBySupplierId(supplier.getObjectId());
		}
		map.addAttribute("result", true);
		return "jsonView";
	}

	/**
	 * 置为有效
	 * @param request
	 * @param ids
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/onValid/{ids}")
	public String onValid(HttpServletRequest request,@PathVariable String ids,ModelMap map) throws Exception {
		String[] array=ids.split(",");
		for (int i = 0; i < array.length; i++) {
			Supplier supplier=getEntityManager().getByObjectId(Long.parseLong(array[i]));
			supplier.setSupplierStatus(1);
			supplierManager.save(supplier);
			companyGoodsManager.updateBySupplierId(supplier.getObjectId());
		}
		map.addAttribute("result", true);
		return "jsonView";
	}
	
	/**
	  * 获得内卖企业
	  * getInnerCompany(这里用一句话描述这个方法的作用)
	  *
	  * @Title: getInnerCompany
	  * @Description: TODO
	  * @param @param request
	  * @param @param ids
	  * @param @param map
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/getInnerCompany/{ids}")
	public String getInnerCompany(HttpServletRequest request,@PathVariable String ids,ModelMap map) throws Exception {
		String[] array=ids.split(",");
		String names="";
		for (int i = 0; i < array.length; i++) {
			Company company=companyManager.getByObjectId(Long.parseLong(array[i]));
			if (company!=null) {
				if (StringUtils.isNotBlank(company.getCompanyName())) {
					if (i==0) {
						names=names.concat(company.getCompanyName());
					}else {
						names=names.concat(",");
						names=names.concat(company.getCompanyName());
					}
				}
			}
		}
		map.addAttribute("result", names);
		return "jsonView";
	}
}
