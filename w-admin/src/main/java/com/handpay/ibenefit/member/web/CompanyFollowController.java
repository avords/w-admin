package com.handpay.ibenefit.member.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyFollow;
import com.handpay.ibenefit.member.service.ICompanyFollowManager;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/companyFollow")
public class CompanyFollowController extends PageController<CompanyFollow>{
	
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private ICompanyFollowManager companyFollowManager;
	@Reference(version = "1.0")
	private IUserManager userManager;
	@Reference(version = "1.0")
	private ICompanyManager companyManager;
	
	@Override
	public Manager<CompanyFollow> getEntityManager() {
		return companyFollowManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		User user=userManager.getByObjectId(FrameworkContextUtils.getCurrentUserId());
		request.setAttribute("userName", user.getUserName());
		request.setAttribute("followTime", (new Date()));
		Long companyId = null;
		if(objectId!=null){
			CompanyFollow companyFollow = companyFollowManager.getByObjectId(objectId);
			companyId = companyFollow.getCompanyId();
		}else{
			companyId = Long.parseLong(request.getParameter("id"));
		}
		request.setAttribute("companyId", companyId);
		List<CompanyFollow> companyFollows=companyFollowManager.getCompanyFollowsByCompanyId(companyId);
		request.setAttribute("items", companyFollows);
		List<User> users = userManager.getUserByUserType(IBSConstants.USER_TYPE_IBS_OPERATOR);
		request.setAttribute("users", users);
		return super.handleEdit(request, response, objectId);
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			CompanyFollow t) throws Exception {
		if (t.getCompanyId()!=null) {
			Company company=companyManager.getByObjectId(t.getCompanyId());
			List<CompanyFollow> companyFollows=companyFollowManager.getCompanyFollowsByCompanyId(t.getCompanyId());
			company.setFollowSum(companyFollows.size()+1);
			companyManager.save(company);
		}
		t.setManagerId(FrameworkContextUtils.getCurrentUserId());
		t.setFollowTime(new Date());
		return super.handleSave(request, modelMap, t);
	}
}
