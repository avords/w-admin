package com.handpay.ibenefit.member.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.member.entity.Staff;
import com.handpay.ibenefit.member.service.ICompanyDepartmentManager;
import com.handpay.ibenefit.member.service.IStaffManager;

@Controller
@RequestMapping("/staff")
public class StaffController  extends PageController<Staff>{
private static final String BASE_DIR = "member/";
	
 	@Reference(version = "1.0")
	private IStaffManager staffManager;
	
 	@Reference(version = "1.0")
	private ICompanyDepartmentManager companyDepartmentManager;

	@Override
	public Manager<Staff> getEntityManager() {
		return staffManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		
		String companyId=request.getParameter("search_EQL_companyId");
		if (StringUtils.isNotBlank(companyId)) {
			request.setAttribute("search_EQL_companyId", companyId);
			CompanyDepartment companyDepartment=new CompanyDepartment();
			companyDepartment.setCompanyId(Long.parseLong(companyId));
			companyDepartment.setDeleted(IBSConstants.STATUS_NO);
			List<CompanyDepartment> cDepartments=companyDepartmentManager.getBySample(companyDepartment);
			request.setAttribute("departments", cDepartments);
		}
		PageSearch page1 = preparePage(request);
		PageSearch result = staffManager.queryCompanyStaffs(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "member/listStaff";
	}

}
