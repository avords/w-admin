package com.handpay.ibenefit.member.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.entity.BaseTree;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.member.service.ICompanyDepartmentManager;
import com.handpay.ibenefit.member.service.ICompanyManager;

@Controller
@RequestMapping("companyDepartment")
public class CompanyDepartmentController extends PageController<CompanyDepartment>{

	@Reference(version="1.0")
	private ICompanyDepartmentManager companyDepartmentManager;
	
	@Reference(version="1.0")
	private ICompanyManager companyManager;

	@Override
	public Manager<CompanyDepartment> getEntityManager() {
		return companyDepartmentManager;
	}
	
	/**
	 * 编辑
	 * 
	 * **/
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId) throws Exception {
		Long companyId = null;
		if(objectId==null){
			companyId = Long.parseLong(request.getParameter("companyId"));
		}else{
			CompanyDepartment companyDepartment = companyDepartmentManager.getByObjectId(objectId);
			companyId = companyDepartment.getCompanyId();
		}
		List<CompanyDepartment> departments = companyDepartmentManager.getCompanyDepartmentsByCompanyId(companyId);
		if(objectId!=null){
			CompanyDepartment self = new CompanyDepartment();
			self.setObjectId(objectId);
			departments.remove(self);
		}
		request.setAttribute("company", companyManager.getByObjectId(companyId));
		request.setAttribute("departments", departments);
		return super.handleEdit(request, response, objectId);
	}
	
	/**
	 * 保存
	 * 
	 * **/
	protected String handleSaveToPage(HttpServletRequest request, ModelMap modelMap, CompanyDepartment t) throws Exception {
		String companyId=request.getParameter("search_EQL_companyId");
		if (StringUtils.isNotBlank(companyId)) {
			t.setCompanyId(Long.parseLong(companyId));
		}
		if(t.getParentId()==null){
			t.setParentId(BaseTree.ROOT);
		}
		if(t.getHeadCount()==null){
			t.setHeadCount(0L);
		}
		if (t.getObjectId()==null) {
			t.setCreatedOn(new Date());
			t.setCreatedBy(FrameworkContextUtils.getCurrentUserId());
			t.setDeleted(0);
		}
		getEntityManager().save(t);
		return "redirect:/companyDepartment/page" + getMessage("common.base.success",request) + "&search_EQL_companyId="+companyId;
	}
	
	/**
	 * 列表
	 * 
	 * **/
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		Company company=new Company();
		company.setVerifyStatus(3);
		List<Company> companies=companyManager.getBySample(company);
		request.setAttribute("companys", companies);
		String companyId=request.getParameter("search_EQL_companyId");
		if (StringUtils.isNotBlank(companyId)) {
			page.getFilters().add(new PropertyFilter(CompanyDepartment.class.getName(), "EQI_companyId", companyId));
		}
		if(page.getSortProperty().equals("objectId")){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
		}
		return super.handlePage(request, page);
	}
	
	/*
	  * <p>删除</p>
	  * <p>Description: </p>
	  * @param request
	  * @param response
	  * @param objectId
	  * @return
	  * @throws Exception
	  * @see com.handpay.ibenefit.framework.web.BaseController#handleDelete(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Long)
	  */
	
	
	@Override
	protected String handleDelete(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		String companyId=request.getParameter("search_EQL_companyId");
		request.setAttribute("search_EQL_companyId", companyId);
		delete(objectId);
		return "redirect:../page" + getMessage("common.base.deleted", request) + "&search_EQL_companyId=" + companyId;
	}
	
	@Override
	public String getFileBasePath() {
		return "member/";
	}
	
	/**
	 * 
	  * 检查部门名称
	  *
	  * @Title: checkDepartmentName
	  * @Description: TODO
	  * @param @param request
	  * @param @param modelMap
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/checkDepartmentName")
	public String checkDepartmentName(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String companyId=request.getParameter("companyId");
		String parentId=request.getParameter("parentId");
		String name=request.getParameter("name");
		String objectId = request.getParameter("objectId");
		CompanyDepartment companyDepartment = new CompanyDepartment();
		companyDepartment.setName(name);
		if (StringUtils.isNotBlank(companyId)) {
			companyDepartment.setCompanyId(Long.parseLong(companyId));
		}
		if (StringUtils.isNotBlank(parentId)) {
			companyDepartment.setParentId(Long.parseLong(parentId));
		}
		if (StringUtils.isNotEmpty(objectId)) {
			companyDepartment.setObjectId(Long.parseLong(objectId));
		}
		companyDepartment.setDeleted(IBSConstants.STATUS_NO);
		boolean ret = companyDepartmentManager.isUnique(companyDepartment);
		modelMap.addAttribute("ret",ret);
		return "jsonView";
	}
}
