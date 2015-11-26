package com.handpay.ibenefit.security.web;

import java.io.IOException;
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
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.entity.AbstractEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.ListUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.portal.service.ILoginErrorManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.SecurityUtils;
import com.handpay.ibenefit.security.entity.Role;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.entity.UserRole;
import com.handpay.ibenefit.security.service.IDepartmentManager;
import com.handpay.ibenefit.security.service.IRoleManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.security.service.IUserRoleManager;

@Controller
@RequestMapping("/user")
public class UserController extends PageController<User> {
	
	private static final Logger LOGGER = Logger.getLogger(UserController.class);

	private static final String BASE_DIR = "security/";
	@Reference(version="1.0")
	private IUserManager userManager;
	@Reference(version="1.0")
	private IRoleManager roleManager;
	@Reference(version="1.0")
	private IUserRoleManager userRoleManager;
	@Reference(version="1.0")
	private IDepartmentManager departmentManager;
	@Reference(version="1.0")
	private ILoginErrorManager loginErrorManager;
	@Reference(version="1.0")
	private ICompanyManager companyManager;
	

	/**
	  * setEnterprise(获取用户企业信息)
	  *
	  * @Title: setEnterprise
	  * @Description: TODO
	  * @param @param request
	  * @param @param response
	  * @param @param platform
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/getEnterprise/{platform}")
	public String setEnterprise(HttpServletRequest request,HttpServletResponse response,@PathVariable Integer platform) {
		if(platform !=null&&platform.equals(IBSConstants.PLATEFORM_ADMIN)){
			return "redirect:/company/companyTemplate?ajax=1&inputName="+request.getParameter("inputName")+"&search_EQL_objectId="+Company.ROOT.getObjectId()+"&companytype=1";
		}else if(platform !=null&&platform.equals(IBSConstants.PLATEFORM_HR)){
			return "redirect:/company/companyTemplate?ajax=1&inputName="+request.getParameter("inputName")+"&companytype=4";
		}else if(platform !=null&&platform.equals(IBSConstants.PLATEFORM_SUPPLIER)){
			return "redirect:/supplier/supplierTemplate?ajax=1&inputName="+request.getParameter("inputName");
		}else{
			return null;
		}
	}
	
	
	/**
	  * editUserRole(编辑用户角色)
	  *
	  * @Title: editUserRole
	  * @Description: TODO
	  * @param @param modelMap
	  * @param @param userId
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/editUserRole/{userId}")
	public String editUserRole(ModelMap modelMap, @PathVariable Long userId) {
		User user = userManager.getByObjectId(userId);
		List<Role> allRoles = roleManager.getRolesByCompanyId(user.getCompanyId());
		List<Role> haveRoles = roleManager.getRolesByUserId(userId);
		List<Role> notHaveRoles = ListUtils.filter(allRoles, haveRoles);
		modelMap.addAttribute("notHaveRoles", notHaveRoles);
		modelMap.addAttribute("haveRoles", haveRoles);
		modelMap.addAttribute("user", user);
		return BASE_DIR + "editUserRole";
	}

	/**
	  * saveUserRole(保存用户角色)
	  *
	  * @Title: saveUserRole
	  * @Description: TODO
	  * @param @param request
	  * @param @param userId
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/saveUserRole")
	public String saveUserRole(HttpServletRequest request, Long userId) {
		String[] roleIds = request.getParameterValues("roleIds");
		if(roleIds!=null&&roleIds.length>1){
			return "redirect:/user/editUserRole/" + userId + getMessage("最多选择一个角色", request) + "&" + appendAjaxParameter(request);
		}
		if (roleIds == null || roleIds.length == 0) {
			userRoleManager.deleteUserRoleByUserId(userId);
		} else {
			List<UserRole> userRoles = new ArrayList<UserRole>(roleIds.length);
			for (String roleId : roleIds) {
				UserRole userRole = new UserRole();
				userRole.setRoleId(Long.valueOf(roleId));
				userRole.setUserId(userId);
				userRoles.add(userRole);
			}
			userRoleManager.saveUserRolesByUserId(userRoles, userId);
		}
		return "redirect:/user/editUserRole/" + userId + getMessage("common.base.success", request) + "&" + appendAjaxParameter(request);
	}

	@RequestMapping("/changePassword")
	public String changePassword() {
		return BASE_DIR + "changePassword";
	}

	@RequestMapping("/savePassword")
	public String savePassword(HttpServletRequest request, HttpServletResponse response) throws IOException {
		String oldPlainPassoed = request.getParameter("oldPassword");
		String newPlainPassword = request.getParameter("newPassword");
		String confirmPalinPassword = request.getParameter("confirmPassword");
		String resultMessage = "account.updatePassword.Failed";
		if (StringUtils.isNotBlank(newPlainPassword)) {
			if (newPlainPassword.equals(confirmPalinPassword)) {
				User user = userManager.getByObjectId((Long)request.getSession().getAttribute(SecurityConstants.USER_ID));
				if (null != user) {
					if (SecurityUtils.generatePassword(oldPlainPassoed).equals(user.getPassword())) {
						user.setPassword(SecurityUtils.generatePassword(newPlainPassword));
						userManager.updateUserByObjectId(user);
						resultMessage = "account.updatePaddword.Success";
					} else {
						resultMessage = "account.updatePaddword.oldPasswordWrong";
					}
				} else {
					resultMessage = "account.updatePaddword.accountNotExist";
				}
			} else {
				resultMessage = "account.updatePaddword.twoPasswordNotTheSame";
			}
		} else {
			resultMessage = "account.updatePaddword.newPasswordIsBlank";
		}
		return "redirect:changePassword" + getMessage(resultMessage, request) + "&" + appendAjaxParameter(request);
	}

	@RequestMapping("/resetPassword/{objectId}")
	public String resetPassword(HttpServletRequest request, @PathVariable Long objectId) {
		request.setAttribute("entity", userManager.getByObjectId(objectId));
		return BASE_DIR + "resetPassword";
	}

	@RequestMapping(value = "/saveReset", method = RequestMethod.POST)
	public String saveReset(HttpServletRequest request, User user) {
		String newPlainPassword = request.getParameter("newPassword");
		String message;
		if (StringUtils.isNotBlank(newPlainPassword)) {
			user.setPassword(SecurityUtils.generatePassword(newPlainPassword));
			userManager.updateUserByObjectId(user);
			message = "user.password.reset.success";
		} else {
			message = "user.password.reset.blank";
		}
		return "redirect:resetPassword/" + user.getObjectId() + getMessage(message, request) + "&"
				+ appendAjaxParameter(request);
	}

	@RequestMapping(value = "/unlock/{loginName}", method = RequestMethod.POST)
	public String unlock(@PathVariable String loginName, ModelMap modelMap) throws Exception {
		loginErrorManager.updateLoginErrorStatus(loginName);
		modelMap.put("result", true);
		return "jsonView";
	}
	
	@RequestMapping(value = "/lockUser/{userId}", method = RequestMethod.POST)
	public String unlock(@PathVariable Long userId, ModelMap modelMap) throws Exception {
		userManager.updateStatus(userId,IBSConstants.USER_STATUS_LOCKED);
		modelMap.put("result", true);
		return "jsonView";
	}
	
	@RequestMapping(value = "/unLockUser/{userId}", method = RequestMethod.POST)
	public String unLockUser(@PathVariable Long userId, ModelMap modelMap) throws Exception {
		userManager.updateStatus(userId,IBSConstants.USER_STATUS_ENABLED);
		modelMap.put("result", true);
		return "jsonView";
	}
	
	@RequestMapping(value = "/deleteUser/{userId}", method = RequestMethod.POST)
	public String deleteUser(@PathVariable Long userId, ModelMap modelMap) throws Exception {
		User user = userManager.getByObjectId(userId);
		if(user!=null&&user.getLastLoginTime()!=null){
			modelMap.put("message", "登录过系统的用户不能删除");
			modelMap.put("result", false);
		}else{
//			userManager.updateStatus(userId,IBSConstants.USER_STATUS_DELETED);
			userManager.unBindUser(userId,IBSConstants.USER_STATUS_DELETED);
			modelMap.put("result", true);
		}
		return "jsonView";
	}

	@RequestMapping(value = "/initUserPassword", method = RequestMethod.POST)
	public String initUserPassword(HttpServletRequest request, ModelMap modelMap) throws Exception {
		String userIdStr = request.getParameter("ids");
		String[] userIds = userIdStr.split(",");
		String message = userManager.resetUserPassword(userIds);
		modelMap.put("result", message);
		return "jsonView";
	}
	
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		return super.handleEdit(request, response, objectId);
	}
	
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		return super.handlePage(request, page);
	}
	
	@Override
	protected String handleSaveToPage(HttpServletRequest request,
			ModelMap modelMap, User t) throws Exception {
		if(IBSConstants.USER_TYPE_COMPANY_ADMIN == t.getType()){
			User companyAdmin = userManager.getUserByCompanyAdmin(t.getCompanyId(),t.getIsAgency());
			if(companyAdmin!=null&&!companyAdmin.getObjectId().equals(t.getObjectId())){
				if(t.getObjectId()!=null){
					request.setAttribute("entity", t);
				}
				return "redirect:create" + getMessage("该企业已有一名管理员", request)
						+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
			}
		}else if(IBSConstants.USER_TYPE_SUPPLIER_ADMIN == t.getType()){
			User supplierAdmin = userManager.getUserBySupplierAdmin(t.getCompanyId());
			if(supplierAdmin!=null&&!supplierAdmin.getObjectId().equals(t.getObjectId())){
				if(t.getObjectId()==null){
					return "redirect:create" + getMessage("该企业已有一名管理员", request)
						+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
				}else{
					request.setAttribute("entity", t);
					return "redirect:edit/" + t.getObjectId() + getMessage("该供应商已有一名管理员", request)
							+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
				}
			}
		}
		t.setCreateDate(new Date());
		t.setUserResources(IBSConstants.IBS_ADMIN_CREATED);
		return super.handleSaveToPage(request, modelMap, t);
	}

	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap, User t) throws Exception {
		if(IBSConstants.USER_TYPE_COMPANY_ADMIN == t.getType()){
			User companyAdmin = userManager.getUserByCompanyAdmin(t.getCompanyId(),t.getIsAgency());
			if(companyAdmin!=null&&companyAdmin.getObjectId().equals(t.getObjectId())){
				request.setAttribute("entity", t);
				return "redirect:edit/" + ((AbstractEntity) t).getObjectId() + getMessage("该企业已有一名管理员", request)
						+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
			}
		}else if(IBSConstants.USER_TYPE_SUPPLIER_ADMIN == t.getType()){
			User supplierAdmin = userManager.getUserBySupplierAdmin(t.getCompanyId());
			if(supplierAdmin!=null&&supplierAdmin.getObjectId().equals(t.getObjectId())){
				request.setAttribute("entity", t);
				return "redirect:edit/" + ((AbstractEntity) t).getObjectId() + getMessage("该供应商已有一名管理员", request)
						+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
			}
		}
		t.setCreateDate(new Date());
		t.setUserResources(IBSConstants.IBS_ADMIN_CREATED);
		t = save(t);
		return "redirect:edit/" + ((AbstractEntity) t).getObjectId() + getMessage("common.base.success", request)
				+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
	}
	
	protected PageSearch preparePage(HttpServletRequest request) {
		PageSearch pageSearch = super.preparePage(request);
		pageSearch.getRelationships().add("menu.objectId_roleMenu.menuId;roleId_userRole.roleId;userId_user.objectId");
		pageSearch.getRelationships().add("role.objectId_userRole.roleId;userId_user.objectId");
		return pageSearch;
	}
	
	@RequestMapping("departmentUser/{departmentId}")
	public String departmentUser(HttpServletRequest request, @PathVariable Long departmentId){
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(getEntityName(),"EQL_departmentId", departmentId +""));
		handlePage(request, page);
		afterPage(request, page, IS_NOT_BACK);
		return getFileBasePath() + "departmentUser";
	}
	
	@RequestMapping("selectSingle")
	public String select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PageSearch page = preparePage(request);
		handlePage(request, page);
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "selectSingle");
		request.setAttribute("departments", departmentManager.getAll());
		return getFileBasePath() + "selectSingleUser";
	}
	
	@Override
	public Manager getEntityManager() {
		return userManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}


	@Override
	@RequestMapping("isUnique")
	@ResponseBody
	public boolean isUnique(User t) {
		return super.isUnique(t);
	}
	
}
