package com.handpay.ibenefit.security.web;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.LoginLog;
import com.handpay.ibenefit.security.service.ILoginLogManager;
import com.handpay.ibenefit.security.service.IUserManager;
@Controller
@RequestMapping("loginLog")
public class LoginLogController extends PageController<LoginLog>{
	@Reference(version="1.0")
	private ILoginLogManager loginLogManager;
	
	@Reference(version="1.0")
	private IUserManager userManager;

	protected String handlePage(HttpServletRequest request, PageSearch page) {
		return super.handlePage(request, page);
	}
	
	@Override
	public Manager<LoginLog> getEntityManager() {
		return loginLogManager;
	}

	@Override
	public String getFileBasePath() {
		return "security/";
	}
	
}
