package com.handpay.ibenefit.portal.web;

import java.io.IOException;
import java.util.Date;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.google.code.kaptcha.Constants;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.FrameworkConstants;
import com.handpay.ibenefit.framework.cache.ICacheManager;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.util.CookieUtils;
import com.handpay.ibenefit.framework.util.IpUtils;
import com.handpay.ibenefit.framework.web.FrameworkFilter;
import com.handpay.ibenefit.portal.service.ILoginErrorManager;
import com.handpay.ibenefit.portal.service.ILoginManager;
import com.handpay.ibenefit.portal.service.IThemeManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.AuthenticationResult;
import com.handpay.ibenefit.security.entity.LoginLog;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.ILoginLogManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/login")
public class AdminLoginController {

	private static final Logger LOGGER = Logger.getLogger(AdminLoginController.class);
	@Reference(version="1.0")
	private ILoginManager loginManager;
	@Reference(version="1.0")
	private IThemeManager themeManager;
	@Reference(version="1.0")
	private ILoginErrorManager loginErrorManager;
	@Reference(version="1.0")
	private ILoginLogManager loginLogManager;
	@Reference(version="1.0")
	private ICacheManager cacheManager;
	@Reference(version="1.0")
	private IUserManager userManager;

	@RequestMapping(value = "in")
	public String index(HttpServletRequest request, HttpServletResponse response, User user) throws IOException {
		String message = "";
		String ipAddress = IpUtils.getRealIp(request);
		String sessionId = request.getSession().getId();
		if (null != request.getSession().getAttribute(SecurityConstants.USER_PLATFORM)) {
			return "redirect:" + GlobalConfig.getDynamicDomain() + "/index";
		}		
		if (null != user && null != user.getLoginName()) {
			// 验证码check
			if (!validateAuthCode(request)) {
				message = "验证码输入有误";
			// user check
			} else {
				user.setPlatform(IBSConstants.PLATEFORM_ADMIN);
				user.setType(IBSConstants.USER_TYPE_IBS_OPERATOR);
				AuthenticationResult result = loginManager.authenticateUser(user, ipAddress, sessionId);
				// login success
				if (result.isSuccess()) {
					user.setLoginName(result.getUser().getLoginName());
					loginSuccess(request, response, user);
					return "redirect:" + GlobalConfig.getDynamicDomain() + "/index";
				}else{
					message = result.getMessage();
				}							
			}			
		}
		String skin = CookieUtils.getCookieByName(request.getCookies(), FrameworkConstants.SKIN);
		if (StringUtils.isBlank(skin)) {
			skin = FrameworkConstants.DEFAULT_SKIN;
		}
		request.getSession().setAttribute(FrameworkConstants.SKIN, skin);
		request.setAttribute("message", message);
		return "portal/login";
	}
	
	/**
	 * validate the authentication code
	 * @param request 
	 * 
	 */	
	private boolean validateAuthCode(HttpServletRequest request) {
		HttpSession session = request.getSession();  
	    String authcode = (String)session.getAttribute(Constants.KAPTCHA_SESSION_KEY);
	    String submitAuthCode = (String)request.getParameter("authcode");
	    return submitAuthCode.equals(authcode);
	}

	private void loginSuccess(HttpServletRequest request, HttpServletResponse response, User user) {
		LoginLog loginLog = new LoginLog();
		loginLog.setLoginName(user.getLoginName());
		loginLog.setBeginDate(new Date());
		loginLog.setResult(LoginLog.LOGIN_RESULT_SUCCESS);
		User realUser = userManager.getUserByLoginName(user.getLoginName());
		user.setObjectId(realUser.getObjectId());
		loginLog.setUserId(realUser.getObjectId());
		loginErrorManager.deleteLoginLog(loginLog.getIp(),realUser.getLoginName());
		FrameworkFilter.setUserToSession(request, response, realUser.getLoginName());
		createLog(loginLog);
	}

	private void createLog(LoginLog loginLog) {
		loginLog.setEndDate(new Date());
		loginLog.setStatus(LoginLog.STATUS_ONLINE);
		loginLog.setSpendTime((int) (loginLog.getEndDate().getTime() - loginLog.getBeginDate().getTime()));
		String message = loginLog.getMessage();
		if(message!=null&&message.length()>255){
			loginLog.setMessage(message.substring(0,255));
		}
		loginLogManager.save(loginLog);		
	}

	@RequestMapping(value = "in/out")
	public String loginOut(HttpServletRequest request,HttpServletResponse response) throws Exception {
		Integer logoutFrom = null;
		if(request.getParameter("logoutFrom")!=null){
			try{
				logoutFrom = Integer.parseInt(request.getParameter("logoutFrom"));
			}catch ( Exception e){
			}
		}
		if(logoutFrom==null){
			logoutFrom = LoginLog.LOGOUT_BY_MANUAL;
		}
		CookieUtils.deleteCookie(response, GlobalConfig.getSessionName());
        cacheManager.delete(request.getSession().getId());
		request.getSession().invalidate();
		return "redirect:" + GlobalConfig.getLoginUrl();
	}
	

}
