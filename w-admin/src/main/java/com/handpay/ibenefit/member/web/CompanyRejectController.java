package com.handpay.ibenefit.member.web;

import java.util.Date;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyReject;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ICompanyRejectManager;

@Controller
@RequestMapping("/companyReject")
public class CompanyRejectController extends PageController<CompanyReject>{
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private ICompanyRejectManager companyRejectManager;
	
	@Reference(version = "1.0")
	private ICompanyManager companyManager;
	
	@Override
	public Manager<CompanyReject> getEntityManager() {
		return companyRejectManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			CompanyReject t) throws Exception {
		String companyId=request.getParameter("id");
		if (StringUtils.isNotBlank(companyId)) {
			Company company=companyManager.getByObjectId(Long.parseLong(companyId));
			if(company.getVerifyStatus()==null || company.getVerifyStatus()!=2){
				company.setUpdatedOn(new Date());
				company.setVerifyStatus(2);
			}
			companyManager.save(company);
			t.setCompanyId(Long.parseLong(companyId));
			t.setCheckUserId(FrameworkContextUtils.getCurrentUserId());
			t.setCheckDate(new Date());
		}
		return super.handleSave(request, modelMap, t);
	}
	
}
