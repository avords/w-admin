package com.handpay.ibenefit.member.web;

import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.entity.AreaInfo;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.cache.ICacheManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyFunction;
import com.handpay.ibenefit.member.entity.CompanyPublished;
import com.handpay.ibenefit.member.entity.CompanyReject;
import com.handpay.ibenefit.member.entity.Staff;
import com.handpay.ibenefit.member.service.ICompanyFollowManager;
import com.handpay.ibenefit.member.service.ICompanyFunctionManager;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ICompanyPublishedManager;
import com.handpay.ibenefit.member.service.ICompanyRejectManager;
import com.handpay.ibenefit.member.service.IStaffManager;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.product.service.IProductShieldManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IRoleManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.util.AreaUtils;

@Controller
@RequestMapping("/company")
public class CompanyController extends PageController<Company>{
	private static final String BASE_DIR = "member/";
	private static final Logger LOGGER = Logger.getLogger(CompanyController.class);

	@Reference(version = "1.0")
	private ICompanyManager companyManager;
	@Reference(version = "1.0")
	private ICompanyPublishedManager companyPublishedManager;

	@Reference(version="1.0")
	private IFileManager fileManager;
	@Reference(version = "1.0")
	private IUserManager userManager;
	@Reference(version = "1.0")
	private IRoleManager roleManager;
	@Reference(version = "1.0")
	private ICompanyFollowManager companyFollowManager;
	@Reference(version = "1.0")
	private ICompanyRejectManager companyRejectManager;
	@Reference(version = "1.0")
	private ICompanyFunctionManager companyFunctionManager;
	@Reference(version = "1.0")
	private IAreaManager areaManager;
	@Reference(version = "1.0")
	private ICacheManager cacheManager;
	@Reference(version = "1.0")
	private IStaffManager staffManager;
	@Reference(version = "1.0")
    private IProductShieldManager productShieldManager;
	@Reference(version = "1.0")
	private ICompanyGoodsManager companyGoodsManager;


	@Override
	public Manager<Company> getEntityManager() {
		return companyManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch pSearch=preparePage(request);
//		if(null != pSearch.getParamMap()){
//			if(null != pSearch.getParamMap().get("areaId") && "-1%".equals(pSearch.getParamMap().get("areaId"))){
//				Map<String, Object> filtermap = pSearch.getParamMap();
//			}
//		}
		if(null != pSearch.getFilters() && null != pSearch.getFilterValue("STARTS_areaId") && "-1".equals(pSearch.getFilterValue("STARTS_areaId"))){
			List<PropertyFilter> filter = pSearch.getFilters();
			for(int a = 0;a<filter.size();a++){
				if(filter.get(a).getFilterName().equals("STARTS_areaId")){
					filter.remove(a);
				}
			}
			pSearch.setFilters(filter);
		}
		PageSearch result=companyManager.findCompanys(pSearch);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listCompany";
	}

    protected String handPagePublish(HttpServletRequest request, PageSearch page) {
    	String companytype = request.getParameter("companytype");
        PageSearch pSearch=preparePage(request);
        if(companytype!= null){
            if(companytype.equals("1")){
                pSearch.getFilters().add(new PropertyFilter(Company.class.getName(),"EQL_objectId",Company.ROOT.getObjectId().toString()));
            }else{
            	pSearch.getFilters().add(new PropertyFilter(Company.class.getName(),"EQL_neObjectId",Company.ROOT.getObjectId().toString()));
            }
        }
        PageSearch result=companyPublishedManager.findCompanys(pSearch);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        afterPage(request, page, PageUtils.IS_NOT_BACK);
        request.setAttribute("companytype", companytype);
        return getFileBasePath() + "listCompany";
    }

    /**
	 * 内卖企业
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/innerCompany")
	public String innerCompany(HttpServletRequest request, Company t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		handPagePublish(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listCompanyInner";
	}

	/**
	 * 企业模板
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/companyTemplate")
	public String companyTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		handPagePublish(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listCompanyTemplate";
	}

	@RequestMapping(value = "/productShieldCompanyTemplate")
    public String productShieldCompanyTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
        PageSearch page  = preparePage(request);
        //查询productShield中的companyId，List<Long>
        String companyIds = "";
        List<Long> ids = productShieldManager.getAllCompanyId();
        for(Long id:ids){
            companyIds = companyIds+id.toString()+",";
        }
        if(ids.size()>=1){
            companyIds = companyIds.substring(0,companyIds.length()-1);
        }
        if(StringUtils.isNotBlank(companyIds)){
            page.getFilters().add(new PropertyFilter(CompanyPublished.class.getName(),"EQS_companyIds",companyIds));
        }
        findPagePublish(request, page);
        afterPage(request, page,backPage);
        request.setAttribute("inputName", request.getParameter("inputName"));
        return BASE_DIR + "listCompanyPublishTemplate";
    }

	protected String findPagePublish(HttpServletRequest request, PageSearch page) {
//        page.getFilters().add(new PropertyFilter(Company.class.getName(),"EQL_neObjectId",Company.ROOT.getObjectId().toString()));
        PageSearch result=companyPublishedManager.findCompanys(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        afterPage(request, page, PageUtils.IS_NOT_BACK);
        return getFileBasePath() + "listCompany";
    }

	@RequestMapping(value = "/companyPublishTemplate")
    public String companyPublishTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
        PageSearch page  = preparePage(request);
        findPagePublish(request, page);
        afterPage(request, page,backPage);
        request.setAttribute("inputName", request.getParameter("inputName"));
        return BASE_DIR + "listCompanyPublishTemplate";
    }

	@RequestMapping(value = "/multiCompanyTemplate")
	public String multiCompanyTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		findPagePublish(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listMultiCompanyTemplate";
	}

	@RequestMapping(value = "/multiWelfareCompanyTemplate")
    public String multiWelfareCompanyTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
        PageSearch page  = preparePage(request);
        findPagePublish(request, page);
        afterPage(request, page,backPage);
        request.setAttribute("inputName", request.getParameter("inputName"));
        return BASE_DIR + "listMultiWelfareCompanyTemplate";
    }

	//体检套餐升级包新增编辑使用
	@RequestMapping(value = "/multiCompanyforphypromoteTemplate")
	public String multiCompanyforphypromoteTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(CompanyPublished.class.getName(),"EQS_deleted", CompanyPublished.DELETED_NO + ""));
		page.getFilters().add(new PropertyFilter(CompanyPublished.class.getName(),"EQS_verifyStatus", IBSConstants.VERIFY_STATUS_SUCCESS + ""));
		 
		findPagePublish(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listMultiCompanyforphypromoteTemplate";
	}
	/**
	 * for physicalAddtionalPackage
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/listCompanysTemplate")
	public String listCompanysTemplate(HttpServletRequest request, Company t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(CompanyPublished.class.getName(),"EQS_deleted", CompanyPublished.DELETED_NO + ""));
		page.getFilters().add(new PropertyFilter(CompanyPublished.class.getName(),"EQS_verifyStatus", IBSConstants.VERIFY_STATUS_SUCCESS + ""));
		 
		findPagePublish(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("inputName", request.getParameter("inputName"));
		return BASE_DIR + "listCompanysTemplate";
	}

	private void fillAreaInfo(List<Company> list){
		List<Area> allAreas = (List<Area>)cacheManager.getObject(AreaUtils.CACHE_KEY_GET_ALL_AREA);
		if(allAreas==null){
			allAreas = areaManager.getAll();
			cacheManager.set(AreaUtils.CACHE_KEY_GET_ALL_AREA, allAreas);
		}
		for(Company company : list){
			AreaInfo areaInfo = new AreaInfo();
			if(StringUtils.isNotBlank(company.getAreaId())){
				areaInfo.setAreaCode(company.getAreaId());
				AreaUtils.setCity(areaInfo, allAreas);
				company.setAreaInfo(areaInfo);
			}
		}
	}

	/**
	 * 编辑
	 */
	@Override
	protected String handleEdit(HttpServletRequest request,HttpServletResponse response, Long objectId) throws Exception {
		if (null!=objectId) {
			Company company=companyManager.getByObjectId(objectId);
			CompanyFunction cf=new CompanyFunction();
			cf.setCompanyId(objectId);
			cf.setIsPublished(IBSConstants.STATUS_NO);
			List<CompanyFunction> companyFunctions=companyFunctionManager.getBySample(cf);
			request.setAttribute("companyFunctions", companyFunctions);
			if(companyFunctions.size()!=0){
				String functionIds = "";
				for(CompanyFunction companyFunction:companyFunctions){
					functionIds += companyFunction.getFunctionId() + ",";
				}
				request.setAttribute("functionIds", functionIds);
				request.setAttribute("viewFunctionIds", functionIds);
			}else {
				request.setAttribute("functionIds", null);
			}
			if (StringUtils.isNotBlank(company.getAttachment())) {
				String[] attachments=company.getAttachment().split(",");
				request.setAttribute("attachs", attachments);
			}
			if (company.getUpdatedBy()!=null) {
				User user=userManager.getByObjectId(company.getUpdatedBy());
				if (user!=null) {
					request.setAttribute("applierName", user.getUserName());
				}
			}else if (company.getOriginId()!=null) {
				if (company.getOriginId()==IBSConstants.APPLY_REGISTRATION || company.getOriginId()==IBSConstants.ONLINE_CONTRACT) {
					request.setAttribute("applierName", company.getLinker());
				}
			}
			if (company.getManagerId()!=null) {
				User user=userManager.getByObjectId(company.getManagerId());
				if (user!=null) {
					request.setAttribute("managerName", user.getUserName());
				}
			}
			if (company.getVerifyStatus()!=null && company.getVerifyStatus()==2) {
				CompanyReject companyReject=companyRejectManager.getNewRejectByCompanyId(objectId);
				if (companyReject!=null) {
					request.setAttribute("reject", companyReject.getRejectContent());
				}else{
					request.setAttribute("reject", "");
				}
			}
			request.setAttribute("entity", company);
			if (company.getAreaId()!=null && company.getAreaId().length()!=0) {
				String  areaName="";
				Area area=areaManager.getByObjectId(Long.parseLong(company.getAreaId()));
				if (area!=null) {
					if (area.getParentId()==-1 && area.getDeepLevel()==1) {//省
						areaName=areaName.concat(area.getName());
					}else if (area.getDeepLevel()==2) {//市
						Area province=areaManager.getByObjectId(area.getParentId());
						areaName=areaName.concat(province.getName());
						areaName=areaName.concat(area.getName());
					}else {//区
						Area cityaArea =areaManager.getByObjectId(area.getParentId());
						if(cityaArea.getParentId()!=null){
							Area proaArea=areaManager.getByObjectId(cityaArea.getParentId());
							areaName=areaName.concat(proaArea.getName());
							areaName=areaName.concat(cityaArea.getName());
							areaName=areaName.concat(areaManager.getAreaFullNameById(Long.parseLong(company.getAreaId())));
						}
					}
				}
				request.setAttribute("areaName", areaName);
			}else {
				request.setAttribute("areaName", "");
			}
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}

	/**
	 * 保存
	 */
	@Override
	protected String handleSaveToPage(HttpServletRequest request, ModelMap modelMap,Company t) throws Exception {
        String attachs=request.getParameter("attachment");
        t.setAttachment(attachs);
        Company temp=new Company();
		temp.setPhone(t.getPhone());
		temp.setTelephone(t.getTelephone());
		List<Company> companies=getEntityManager().getBySample(temp);
		Company tt=null;
		if(t.getObjectId()!=null){
			Company company=companyManager.getByObjectId(t.getObjectId());
			t.setManagerId(company.getManagerId());
			t.setOriginId(company.getOriginId());
			t.setApplyStatus(company.getApplyStatus());
			t.setApplyTime(company.getApplyTime());
			t.setApplicantId(company.getApplicantId());
			t.setUpdatedBy(company.getUpdatedBy());
			t.setCreatedBy(company.getCreatedBy());
			t.setCreatedOn(company.getCreatedOn());
			t.setDeleted(company.getDeleted());
			if (company.getVerifyStatus()!=null&&company.getVerifyStatus()==IBSConstants.VERIFY_STATUS_SUCCESS) {
				t.setCompanyName(company.getCompanyName());
			}
			if (StringUtils.isNotBlank(t.getPhone()) && StringUtils.isNotBlank(company.getPhone())
					&& StringUtils.isNotBlank(t.getTelephone()) && StringUtils.isNotBlank(company.getTelephone())) {
				if (t.getPhone().equals(company.getPhone()) && t.getTelephone().equals(company.getTelephone())) {
						tt=save(t);
				}else {
						tt=save(t);
				}
			}
			if (StringUtils.isNotBlank(company.getAttachment())) {
				String[] attachments=company.getAttachment().split(",");
				request.setAttribute("attachs", attachments);
			}
		}else{
			t.setCreatedBy(FrameworkContextUtils.getCurrentUserId());
			t.setCreatedOn(new Date());
			t.setDeleted(0);
			t.setIsAccountManager(2);
			t.setApplicantId(FrameworkContextUtils.getCurrentUserId());
			t.setApplyTime(new Date());
			t.setOriginId(3);
			tt=save(t);
		}
		String verify=request.getParameter("verify");
        if (StringUtils.isNotBlank(verify) && "1".equals(verify)) {
			if (tt.getVerifyStatus()==null || tt.getVerifyStatus()!=0) {
				tt.setUpdatedOn(new Date());
				tt.setVerifyStatus(IBSConstants.VERIFY_STATUS_ING);
			}
		}else {
			if (tt.getVerifyStatus()==null || tt.getVerifyStatus()!=1) {
				tt.setUpdatedOn(new Date());
				tt.setVerifyStatus(IBSConstants.VERIFY_STATUS_DRAFT);
			}
		}
        companyManager.save(tt);
		//关联开设功能
		String[] ss=request.getParameterValues("functions");
		companyFunctionManager.saveCompanyFunctionByCompanyId(tt.getObjectId(), ss);
		return "redirect:page" + getMessage("common.base.success", request);
	}

	/**
	 * 查看
	 */
	@Override
	protected String handleView(HttpServletRequest request,HttpServletResponse response, Long objectId) throws Exception {
		List<CompanyFunction> companyFunctions=companyFunctionManager.getCompanyFunctionsByCompanyId(objectId);
		request.setAttribute("companyFunctions", companyFunctions);
		request.setAttribute("view", 1);

		return super.handleView(request, response, objectId);
	}

	//自主申请企业
	@RequestMapping("/apply")
	public String applyCompany(HttpServletRequest request) {
		PageSearch pSearch=preparePage(request);
		pSearch.getFilters().add(new PropertyFilter(Company.class.getName(), "NEI_neOriginId", "3"));
		
		String search_STARTS_areaId = request.getParameter("search_STARTS_areaId");
		if(search_STARTS_areaId == null || search_STARTS_areaId.equals("-1")){
			pSearch.getFilters().add(new PropertyFilter(Company.class.getName(), "LIKES_areaId", null));
		}
		
		PageSearch result=companyManager.findCompanys(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		fillAreaInfo(pSearch.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		return "member/listApplyCompany";
	}

	//企业分配客户经理
	@RequestMapping("/callOn")
	public String callOnManager(HttpServletRequest request) {
		PageSearch pSearch=preparePage(request);
		pSearch.setEntityClass(User.class);
		pSearch.getFilters().add(new PropertyFilter(User.class.getName(),"LIKES_roleCode",IBSConstants.ROLE_CODE_AM));
		PageSearch result= userManager.getUsersForRoleCode(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		String ids=request.getParameter("ids");
		request.setAttribute("ids", ids);
		return "member/selectManager";
	}

	//保存客户经理到企业
	@RequestMapping("/saveManager2Company")
	public String saveManager2Company(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String managerId=request.getParameter("userId");
		String companyIds=request.getParameter("ids");
		String[] array=companyIds.split(",");
		for (int i = 0; i < array.length; i++) {
			Company company=companyManager.getByObjectId(Long.parseLong(array[i]));
			company.setManagerId(Long.parseLong(managerId));
			company.setApplyStatus(2);
			company.setIsAccountManager(1);
			companyManager.save(company);
			CompanyPublished companyPublished=companyPublishedManager.getByObjectId(company.getObjectId());
			if (companyPublished!=null) {
				companyPublished.setManagerId(Long.parseLong(managerId));
				companyPublished.setApplyStatus(2);
				companyPublished.setIsAccountManager(1);
				companyPublishedManager.save(companyPublished);
			}
		}
		modelMap.addAttribute("result", true);
		return "jsonView";
	}

	//客户经理跟进企业
	@RequestMapping("/manager")
	public String managerCompany(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		Long managerId=FrameworkContextUtils.getCurrentUserId();
		if (managerId!=0L) {
			page.getFilters().add(new PropertyFilter(Company.class.getName(),"EQI_managerId",managerId.toString()));
		}
		 
		String search_STARTS_areaId = request.getParameter("search_STARTS_areaId");
		if(search_STARTS_areaId == null || search_STARTS_areaId.equals("-1")){
			List<PropertyFilter> list = page.getFilters();
			for(int i=0;i<list.size();i++){
				if("STARTS_areaId".equals(list.get(i).getFilterName())){
					page.getFilters().remove(list.get(i)) ;
				}
			}
		}
		 
		
		PageSearch result=getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "member/listManagerCompany";
	}

	//企业入驻审核
	@RequestMapping("/verify")
	public String verifyCompany(HttpServletRequest request) {
		PageSearch pSearch=preparePage(request);
		
		if(null != pSearch.getFilters() && null != pSearch.getFilterValue("STARTS_areaId") && "-1".equals(pSearch.getFilterValue("STARTS_areaId"))){
			List<PropertyFilter> filter = pSearch.getFilters();
			for(int a = 0;a<filter.size();a++){
				if(filter.get(a).getFilterName().equals("STARTS_areaId")){
					filter.remove(a);
				}
			}
			pSearch.setFilters(filter);
		}
		
		pSearch.getFilters().add(new PropertyFilter(Company.class.getName(), "NEI_neVerifyStatus", "1"));
		PageSearch result=companyManager.findCompanys(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		return "member/listVerifyCompany";
	}

	//检查企业状态
	@RequestMapping("/checkCompanyStatus/{companyId}")
	public String verifySuccess(HttpServletRequest request,ModelMap modelMap,@PathVariable Long companyId) throws Exception {
		Company company = companyManager.getByObjectId(companyId);
		if(company!=null&&company.getVerifyStatus()==IBSConstants.VERIFY_STATUS_ING){
			modelMap.put("result", true);
		}else{
			modelMap.put("result", false);
		}
		return "jsonView";
	}
	//审核通过
	@RequestMapping("/verifySuccess")
	public String verifySuccess(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String companyId=request.getParameter("id");
		if (StringUtils.isNotBlank(companyId)) {
			Company company=companyManager.getByObjectId(Long.parseLong(companyId));
			company.setApplyStatus(3);
			if (company.getVerifyStatus()==null || company.getVerifyStatus()!=3) {
				company.setUpdatedOn(new Date());
				company.setVerifyStatus(3);
			}
			companyManager.save(company);
			//正式表
			CompanyPublished companyPublished=companyPublishedManager.getByObjectId(company.getObjectId());
			if (companyPublished!=null) {
				companyPublishedManager.delete(company.getObjectId());
			}
			companyManager.saveToCompanyPublished(company.getObjectId());
			//正式企业关联开设功能
			CompanyFunction companyFunction=new CompanyFunction();
			companyFunction.setCompanyId(company.getObjectId());
			//删除正是表数据
			CompanyFunction sample = new CompanyFunction();
			sample.setCompanyId(company.getObjectId());
			sample.setIsPublished(IBSConstants.STATUS_YES);
			companyFunctionManager.deleteBySample(sample);
			List<CompanyFunction> companyFunctions=companyFunctionManager.getBySample(companyFunction);
			if (companyFunctions.size()!=0) {
				for(CompanyFunction cf:companyFunctions){
					if(cf!=null){
						CompanyFunction temp=new CompanyFunction();
						temp.setCompanyId(cf.getCompanyId());
						temp.setFunctionId(cf.getFunctionId());
						temp.setIsPublished(IBSConstants.STATUS_YES);
						companyFunctionManager.save(temp);
					}
				}
			}
			companyGoodsManager.updateByCompanyId(company.getObjectId());
			//审核表
			CompanyReject companyReject=new CompanyReject();
			companyReject.setCompanyId(Long.parseLong(companyId));
			companyReject.setCheckDate(new Date());
			companyReject.setCheckUserId(FrameworkContextUtils.getCurrentUserId());
			companyReject.setVerifyStatus(3);
			companyRejectManager.save(companyReject);
		}
		return "redirect:verify";
	}

	//企业信息查询
	@RequestMapping("/viewInfo")
	public String viewCompanyInfo(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		
		if(null != page.getFilters() && null != page.getFilterValue("STARTS_areaId") && "-1".equals(page.getFilterValue("STARTS_areaId"))){
			List<PropertyFilter> filter = page.getFilters();
			for(int a = 0;a<filter.size();a++){
				if(filter.get(a).getFilterName().equals("STARTS_areaId")){
					filter.remove(a);
				}
			}
			page.setFilters(filter);
		}
		
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		for(Company company : (List<Company>)page.getList()){
			Staff staff=new Staff();
			staff.setCompanyId(company.getObjectId());
			List<Staff> staffs=staffManager.getBySample(staff);
			if(staffs.size()==0){
				company.setStaffs(0L);
			}else {
				company.setStaffs((long) staffs.size());
			}
		}
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		return "member/listCheckViewCompany";
	}

	//与合同相关的企业信息查询
	@RequestMapping("/getCompanyInfo")
	public String getCompanyInfo(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter(Company.class.getName(),"EQI_verifyStatus","3"));
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		for(Company company : (List<Company>)page.getList()){
			if(company.getStaffs()==null){
				company.setStaffs(0L);
			}
		}
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		return "news/listCheckViewCompany";
	}

	//与合同相关的列表企业信息查询
	@RequestMapping("/viewInfoContract")
	public String viewInfoContract(HttpServletRequest request) {
		PageSearch page = preparePage(request);
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		for(Company company : (List<Company>)page.getList()){
			if(company.getStaffs()==null){
				company.setStaffs(0L);
			}
		}
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		return "news/listCheckViewCompany";
	}

	@RequestMapping(value = "/getPlatform")
    public String getThirdCategoryByFirstId(HttpServletRequest request, HttpServletResponse response, Company t,ModelMap map) throws Exception {
        Map<String,Object> param = new HashMap<String,Object>();
        String companyName = t.ROOT.getCompanyName();
        String companyId  = t.ROOT.getObjectId().toString();
        map.put("companyName",companyName);
        map.put("companyId",companyId);
        return "jsonView";
    }

	//根据办公号码和手机验证企业
	@RequestMapping("/checkPhones")
	public String checkPhones(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String mob=request.getParameter("mob");
		String pho=request.getParameter("pho");
		String id=request.getParameter("id");
		if (StringUtils.isNotBlank(mob) && StringUtils.isNotBlank(pho)) {
			Company company=new Company();
			company.setPhone(pho);
			company.setTelephone(mob);
			List<Company> companies=companyManager.getBySample(company);
			if (StringUtils.isBlank(id)) {//新增
				if (companies.size()!=0) {
					modelMap.addAttribute("result", true);
				}else {
					modelMap.addAttribute("result", false);
				}
			}else {//修改
				Company temp=companyManager.getByObjectId(Long.parseLong(id));
				if (pho.equals(temp.getPhone()) && mob.equals(temp.getTelephone())) {
					if (companies.size()!=1) {
						modelMap.addAttribute("result", true);
					}else {
						modelMap.addAttribute("result", false);
					}
				}else {
					if (companies.size()!=0) {
						modelMap.addAttribute("result", true);
					}else {
						modelMap.addAttribute("result", false);
					}
				}
			}
		}
		return "jsonView";
	}
	
	
	//上传或更新公司LOGO
	@RequestMapping("/uploadCompanyLogo")
    @ResponseBody
    public String uploadCompanyLogo(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object> map = new HashMap<String,Object>();
        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile1");
        long fl = uploadFile.getFile().length();
        if(fl > 3*1024*1024){
        	map.put("result", false);
        	map.put("msg", "上传图片大小不可超过3MB");
        	AjaxUtils.doAjaxResponseOfMap(response, map);
    	    return null;
        }
        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        
        String filePath = fileManager.saveCompanyLogo(fileData, uploadFile.getFileName());
        map.put("result",true);
        map.put("filePath", filePath.trim());
        AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
    }
	
	//上传或更新公司附件
	@RequestMapping("/uploadCompanyAttach")
    @ResponseBody
    public String uploadCompanyAttach(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object> map = new HashMap<String,Object>();
        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile2");
        long fl = uploadFile.getFile().length();
        if(fl > 5*1024*1024){
        	map.put("result", false);
        	map.put("msg", "上传文件大小不可超过5MB");
        	AjaxUtils.doAjaxResponseOfMap(response, map);
    	    return null;
        }
        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        
        String filePath = fileManager.saveCompanyLogo(fileData, uploadFile.getFileName());
        map.put("result",true);
        map.put("filePath", filePath.trim());
        AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
    }
	
	//删除公司附件
	@RequestMapping("/deleteCompanyAttaach")
    public String deleteCompanyAttaach(HttpServletRequest request, HttpServletResponse response,ModelMap map) throws Exception {
        String filePath = request.getParameter("filePath");
        boolean result = fileManager.deleteFile(filePath);
        map.addAttribute("result", result);
        return "jsonView";
    }
}
