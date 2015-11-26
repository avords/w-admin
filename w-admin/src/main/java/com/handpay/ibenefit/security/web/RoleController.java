package com.handpay.ibenefit.security.web;

import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.ListUtils;
import com.handpay.ibenefit.framework.util.LocaleUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Menu;
import com.handpay.ibenefit.security.entity.Operation;
import com.handpay.ibenefit.security.entity.Role;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IDepartmentManager;
import com.handpay.ibenefit.security.service.IMenuManager;
import com.handpay.ibenefit.security.service.IOperationManager;
import com.handpay.ibenefit.security.service.IRoleManager;
import com.handpay.ibenefit.security.service.IRoleMenuManager;
import com.handpay.ibenefit.security.service.IRoleOperationManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.security.service.IUserRoleManager;

@Controller
@RequestMapping("/role")
public class RoleController extends PageController<Role> {
	private static final String BASE_DIR = "security/";
	@Reference(version="1.0")
	private IRoleManager roleManager;
	@Reference(version="1.0")
	private IMenuManager menuManager;
	@Reference(version="1.0")
	private IRoleMenuManager roleMenuManager;
	@Reference(version="1.0")
	private IUserManager userManager;
	@Reference(version="1.0")
	private IUserRoleManager userRoleManager;
	@Reference(version="1.0")
	private IDepartmentManager departmentManager;
	@Reference(version="1.0")
	private IOperationManager operationManager;
	@Reference(version="1.0")
	private IRoleOperationManager roleOperationManager;

	@Override
	public Manager getEntityManager() {
		return roleManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@RequestMapping("/editRoleMenu/{roleId}")
	public String editRoleMenu(ModelMap modelMap, HttpServletRequest request, @PathVariable Long roleId) {
		Role role = roleManager.getByObjectId(roleId);
		Locale locale = LocaleUtils.getLocale(request);
		List<Menu> haveMenus = menuManager.getMenusByRoleId(roleId);
		List<Menu> allMenus = menuManager.getAllByPlatform(role.getPlatform());
		List<Menu> notHaveMenus = ListUtils.filter(allMenus, haveMenus);
		for(Menu menu : haveMenus){
			menu.setPath(MenuController.interpret(menu.getPath(), locale));
		}
		for(Menu menu : notHaveMenus){
			menu.setPath(MenuController.interpret(menu.getPath(), locale));
		}
		modelMap.addAttribute("haveMenus", haveMenus);
		modelMap.addAttribute("notHaveMenus", notHaveMenus);
		modelMap.addAttribute("role", role);
		return BASE_DIR + "editRoleMenu";
	}
	
	

	@RequestMapping("/saveRoleMenu")
	public String saveRoleMenu(HttpServletRequest request, Long roleId) {
		String[] menuIds = request.getParameterValues("menuIds");
		roleMenuManager.saveRoleMenus(menuIds, roleId);
		return "redirect:/role/page" + getMessage("common.base.success",request) + "&" + appendAjaxParameter(request);
	}

	@RequestMapping("/editRoleUser/{roleId}")
	public String editRoleUser(ModelMap modelMap,@PathVariable Long roleId) {
		Role role = roleManager.getByObjectId(roleId);
		List<User> allUsers  = userManager.getAllByPlatform(role.getPlatform(),role.getCompanyId());
		List<User> haveUsers = userManager.getUsersByRoleId(roleId);
		List<User> notHaveUsers = ListUtils.filter(allUsers, haveUsers);
		modelMap.addAttribute("haveUsers", haveUsers);
		modelMap.addAttribute("notHaveUsers", notHaveUsers);
		modelMap.addAttribute("role", role);
		return BASE_DIR + "editRoleUser";
	}

	@RequestMapping("/editRoleOpera/{roleId}")
	public String editRoleOpera(ModelMap modelMap,@PathVariable Long roleId) {
		List<Operation> allMenus  = operationManager.getAll();
		List<Operation> haveMenus = operationManager.getOperationsByRoleId(roleId);
		List<Operation> notHaveMenus = ListUtils.filter(allMenus, haveMenus);
		modelMap.addAttribute("haveMenus", haveMenus);
		modelMap.addAttribute("notHaveMenus", notHaveMenus);
		modelMap.addAttribute("role", roleManager.getByObjectId(roleId));
		return BASE_DIR + "editRoleOpera";
	}

	@RequestMapping("/saveRoleOpera")
	public String saveRoleOpera(HttpServletRequest request, Long roleId) {
		String[] operationIds = request.getParameterValues("selected");
		roleOperationManager.saveRoleOperationByRoleId(operationIds, roleId);
		return "redirect:/role/editRoleOpera/" + roleId + getMessage("common.base.saveSuccess",request);
	}

	@RequestMapping("/saveRoleUser")
	public String saveRoleUser(HttpServletRequest request, Long roleId) {
		String[] userIds = request.getParameterValues("userIds");
		userRoleManager.saveUserRolesByRoleId(userIds, roleId);
		return "redirect:/role/page" + getMessage("common.base.saveSuccess",request) + "&" + appendAjaxParameter(request);
	}
	
	@RequestMapping(value = "/deleteRole/{roleId}", method = RequestMethod.POST)
	public String deleteRole(@PathVariable Long roleId, ModelMap modelMap) throws Exception {
		Integer count = roleManager.checkRoleUsers(roleId);
		if(count>0){
			modelMap.put("result", false);
		}else{
			modelMap.put("result", true);
			delete(roleId);
		}
		return "jsonView";
	}
}
