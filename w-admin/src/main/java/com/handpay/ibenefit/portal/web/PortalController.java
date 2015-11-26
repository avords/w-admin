package com.handpay.ibenefit.portal.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.swing.tree.DefaultMutableTreeNode;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.FrameworkConstants;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.log.entity.OperateLog;
import com.handpay.ibenefit.log.service.IOperateLogManager;
import com.handpay.ibenefit.portal.entity.Theme;
import com.handpay.ibenefit.portal.service.IMenuImageManager;
import com.handpay.ibenefit.portal.service.IThemeManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.Menu;
import com.handpay.ibenefit.security.entity.MenuLink;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.entity.UserMenus;
import com.handpay.ibenefit.security.service.IMenuLinkManager;
import com.handpay.ibenefit.security.service.IMenuManager;

@Controller
@RequestMapping("/")
public class PortalController {

	private static final Logger LOG =Logger.getLogger(PortalController.class);
	private static final String PORTAL_DIR = "portal/";

	@Reference(version = "1.0")
	private IMenuImageManager menuImageManager;
	@Reference(version = "1.0")
	private IThemeManager themeManager;
	@Reference(version="1.0")
	private IOperateLogManager operateLogManager;
	@Reference(version="1.0")
	private  IMenuLinkManager menuLinkManager;
	@Reference(version="1.0")
	private  IMenuManager menuManager;

	@RequestMapping(value = "decorator")
	public String decorator(HttpServletRequest request) throws Exception {
		// 设置1级菜单
		setFirstLevelMenu(request);
		Object currentModuleId = request.getSession().getAttribute(
				"currentModuleId");

		List<Menu> all = (List<Menu>) request.getSession().getAttribute(SecurityConstants.MENU_PERMISSION);
		request.setAttribute("currentModuleId", currentModuleId);

		// 设置2，3级菜单
		setSideMenu(request);

		String menuIdStr = request.getParameter("menuId");
		if (StringUtils.isNotBlank(menuIdStr)) {
			Long menuId = Long.parseLong(menuIdStr);
			Menu menu = MenuUtils.getByObjectId((List<Menu>) request.getSession().getAttribute( SecurityConstants.MENU_PERMISSION), menuId);
			List<Menu> tabMenus = new ArrayList<Menu>();
			MenuUtils.getParent(all, menu, tabMenus);
			request.setAttribute("currentMenu", menu);
			request.setAttribute("parentMenus", tabMenus);
			request.getSession().setAttribute("menuURL", menu.getFullUrl());
		}
		return PORTAL_DIR + "decorator";
	}

	@RequestMapping(value = "parentMenu")
	public String tabMenus(HttpServletRequest request, ModelMap map)
			throws Exception {
		boolean result = false;
		String menuIdStr = request.getParameter("menuId");
		Long menuId = null;
		if (StringUtils.isNotBlank(menuIdStr)) {
			menuId = Long.parseLong(menuIdStr);
		}
		List<Menu> all = (List<Menu>) request.getSession().getAttribute(SecurityConstants.MENU_PERMISSION);
		Menu menu = MenuUtils.getByObjectId(all, menuId);
		List<Menu> tabMenus = new ArrayList<Menu>();
		MenuUtils.getParent(all, menu, tabMenus);
		result = true;
		tabMenus.add(menu);
		map.addAttribute("result", result);
		map.addAttribute("tabMenus", tabMenus);
		map.addAttribute("menu", menu);
		return "jsonView";
	}

	@RequestMapping(value = "publicDecorator")
	public String publicDecorator(HttpServletRequest request) throws Exception {
		return PORTAL_DIR + "publicDecorator";
	}

	@RequestMapping(value = "index")
	public String index(HttpServletRequest request) throws Exception {
		Integer platform = (Integer) request.getSession().getAttribute(SecurityConstants.USER_PLATFORM);
		if(platform==null){
			return "redirect:" + GlobalConfig.getLoginUrl();
		}
		List<Menu> allPermissionMenus = (List<Menu>) request.getSession().getAttribute(SecurityConstants.MENU_PERMISSION);
		List<UserMenus> userMenus = new ArrayList<UserMenus>();
		for(Menu menu : allPermissionMenus){
			if(menu.getParentId() == Long.parseLong(String.valueOf(platform))){
				UserMenus userMenu = new UserMenus();
				userMenu.setFolderName(menu.getName());
				userMenu.setFolderId(menu.getObjectId());
				List<Menu> subMenus = new ArrayList<Menu>();
				for(Menu subMenu : allPermissionMenus){
					if(subMenu.getParentId().equals(menu.getObjectId())){
						subMenus.add(subMenu);
					}
				}
				if(subMenus.size()>0){
					userMenu.setMenus(subMenus);
					userMenus.add(userMenu);
				}
			}
		}
		request.getSession().setAttribute("userMenus", userMenus);
		setSideMenu(request);
		return PORTAL_DIR + "home";
	}

	@RequestMapping(value = "list")
	public String list(HttpServletRequest request) throws Exception {
		return PORTAL_DIR + "list";
	}

	@RequestMapping(value = "detail")
	public String detail(HttpServletRequest request) throws Exception {
		return PORTAL_DIR + "detail";
	}

	@RequestMapping(value = "main")
	public String main(HttpServletRequest request) throws Exception {
		return PORTAL_DIR + "main";
	}

	@RequestMapping(value = "main/{moduleId}")
	public String module(HttpServletRequest request, @PathVariable Long moduleId)
			throws Exception {
		request.getSession().setAttribute("currentModuleId", moduleId);
		return PORTAL_DIR + "sideMenu";
	}

	// 点击实际的菜单，计算顶级目录，找到位置
	@RequestMapping(value = "mainMenu/{menuId}")
	public String mainMenu(HttpServletRequest request, @PathVariable long menuId)
			throws Exception {
		List<Menu> all = (List<Menu>) request.getSession().getAttribute(
				SecurityConstants.MENU_PERMISSION);
		Menu top = MenuUtils.getTop(all, menuId);
		if (top != null) {
			request.getSession().setAttribute("currentModuleId",
					top.getObjectId());
			request.setAttribute("menuId", menuId);
		}

		return PORTAL_DIR + "sideMenu";
	}

	/**
	 * 设置2，3级菜单
	 * 
	 * @param request
	 */
	private void setSideMenu(HttpServletRequest request) {
		
		Integer platform = (Integer) request.getSession().getAttribute(SecurityConstants.USER_PLATFORM);
		List<Menu> allPermissionMenus = (List<Menu>) request.getSession().getAttribute(SecurityConstants.MENU_PERMISSION);
		Menu menu = null;
		if(platform==IBSConstants.PLATEFORM_HR){
			menu = Menu.ROOT_PLATEFORM_HR;
		}else if(platform==IBSConstants.PLATEFORM_SUPPLIER){
			menu = Menu.ROOT_PLATEFORM_SUPPLIER;
		}else if(platform==IBSConstants.PLATEFORM_ADMIN){
			menu = Menu.ROOT_PLATEFORM_ADMIN;
		}
		DefaultMutableTreeNode treeNode = MenuUtils.getMenuTree(menu,allPermissionMenus);
		StringBuilder treeHtml = new StringBuilder(500);
		// 根据传入的1级菜单ID遍历获取所有的子类的菜单(包括2，3，4。。。。级)
		MenuUtils.generateTreeHtml(treeNode, treeHtml, null);
		request.setAttribute("treeHtml", treeHtml.toString());
	}

	private void setFirstLevelMenu(HttpServletRequest request) {
		List<Menu> allPermissionMenus = (List<Menu>) request.getSession()
				.getAttribute(SecurityConstants.MENU_PERMISSION);
		List<Menu> menus = MenuUtils.getFirstLevelMenu(allPermissionMenus);
		HttpSession session = request.getSession();
		session.setAttribute("tops", menus);
	}

	@RequestMapping(value = "wait/{menuId}")
	public String wait(HttpServletRequest request, @PathVariable Integer menuId)
			throws Exception {
		if (null != menuId) {
			List<Menu> allPermissionMenus = (List<Menu>) request.getSession()
					.getAttribute(SecurityConstants.MENU_PERMISSION);
			Menu menu = getMenuByMenuId(allPermissionMenus, menuId);
			String forwardUrl = null;
			Menu top = MenuUtils.getTop(allPermissionMenus, menu);
			if (menu.getType() == Menu.TYPE_FOLDER) {
				forwardUrl = "../main/" + top.getObjectId();
				request.getSession().removeAttribute("currentMenuId");
			} else {
				forwardUrl = menu.getFullUrl();
				request.getSession().setAttribute("currentMenuId", menuId);
			}
			request.getSession().setAttribute("currentModuleId",
					top.getObjectId());
			request.setAttribute("forwardUrl", forwardUrl + "?ajax=1");
		}
		return PORTAL_DIR + "wait";
	}

	@RequestMapping("selectIcon")
	public String selectIcon() {
		return PORTAL_DIR + "selectIcon";
	}

	private Menu getMenuByMenuId(List<Menu> allPermissionMenus, long menuId) {
		for (Menu menu : allPermissionMenus) {
			if (menuId == menu.getObjectId()) {
				return menu;
			}
		}
		return null;
	}

	protected List<Menu> getMenusByModelName(List<Menu> allPermissionMenu,
			String modelName) {
		if (null == allPermissionMenu) {
			return new ArrayList<Menu>(0);
		}
		List<Menu> result = new ArrayList<Menu>();
		for (Menu menu : allPermissionMenu) {
			if (menu.getPath().startsWith(Menu.ROOT_CONTEXT + modelName)) {
				result.add(menu);
			}
		}
		return result;
	}

	@RequestMapping(value = "changeSkin/{color}")
	public String changeSkin(HttpServletRequest request,
			HttpServletResponse response, @PathVariable String color)
			throws Exception {
		if (color != null) {
			if ("d".equals(color) || "e".equals(color) || "f".equals(color)
					|| "g".equals(color)) {
				HttpSession session = request.getSession();
				Theme theme = new Theme();
				theme.setSkin(color);
				theme.setUserId((Long) session
						.getAttribute(SecurityConstants.USER_ID));
				themeManager.updateUserSkin(theme);
				session.setAttribute(FrameworkConstants.SKIN, color);
			}
		}
		return "redirect:../main";
	}

	@RequestMapping(value = "common/location/{menuId}")
	public String location(HttpServletRequest request,
			@PathVariable Long menuId, ModelMap modelMap) {
		List<Menu> allPermissionMenus = (List<Menu>) request.getSession()
				.getAttribute(SecurityConstants.MENU_PERMISSION);
		List<Menu> tree = new ArrayList<Menu>();
		Menu leaf = getMenuByMenuId(allPermissionMenus, menuId);
		MenuUtils.getParent(allPermissionMenus, leaf, tree);
		tree.add(leaf);
		StringBuilder location = new StringBuilder(tree.size() * 6);
		for (Menu menu : tree) {
			location.append(" ").append(menu.getName()).append(" >> ");
		}
		modelMap.addAttribute("location", location.toString());
		return "";
	}

	@RequestMapping("public/checkValidateCode")
	@ResponseBody
	public boolean checkUserRegisterCode(HttpServletRequest request,
			HttpServletResponse response) throws Exception {/*
		boolean result = true;
		String validateCode = request.getParameter("s_randomCode");
		if (null == validateCode
				|| !validateCode.equals(request.getSession().getAttribute(
						com.google.code.kaptcha.Constants.KAPTCHA_SESSION_KEY))) {
			result = false;
		}
		return result;
	*/	return true;
		}
	
	/**
	 * 记录菜单点击日志
	 * @param request
	 * @param response
	 */
	@RequestMapping("log")
	public void logMenuClick(HttpServletRequest request, HttpServletResponse response){
		OperateLog operateLog = new OperateLog();
		User user = FrameworkContextUtils.getCurrentUser();
		String menuId = request.getParameter("menuId");
		String menuName = request.getParameter("menuName");
		String parentId = request.getParameter("parentId");
		String parentName = request.getParameter("parentName");
		String url = request.getParameter("url");
		
		if (null == user) {
			return;
		}
		
		if (StringUtils.isBlank(menuId) || StringUtils.isBlank(menuName) 
				|| StringUtils.isBlank(parentId) || StringUtils.isBlank(parentName)
				|| StringUtils.isBlank(url)) {
			
			return;
		}
		
		operateLog.setBeginDate(new Date());
		operateLog.setMenuId(Long.parseLong(parentId));
		operateLog.setMenuName(parentName);
		operateLog.setSecondMenuId(Long.parseLong(menuId));
		operateLog.setSecondMenuName(menuName);
		operateLog.setUrl(url);
		operateLog.setUserId(user.getObjectId());
		operateLog.setUserName(user.getLoginName());
		operateLog.setPlatform(user.getPlatform());
		
		operateLogManager.save(operateLog);
	}
	
	/**
	 * 记录button 或超链接点击日志
	 */
    @RequestMapping("logOperation")
	public void logOperation(HttpServletRequest request, HttpServletResponse response){
    	OperateLog operateLog = null;
		String operationId = request.getParameter("operationId");
		User user = FrameworkContextUtils.getCurrentUser();
		
		if (null == user || StringUtils.isBlank(operationId)) {
		   return;
		}
		
		Long id = Long.MIN_VALUE;
		MenuLink menuLink = null;
		
		try {
			id = Long.parseLong(operationId);
		} catch (NumberFormatException e) {
			LOG.error("记录button 或超链接点击日志时，operationId转换错误", e);
			return;
		}
		
		menuLink= menuLinkManager.getByObjectId(id);
		if (null == menuLink) {
			LOG.error("根据operationId： " + operationId + " 查询不到menuLink" );
			return;
		}
		
		operateLog = populateMenuInfo(menuLink.getMenuId());
		if (null == operateLog) {
			return;
		}
		
		operateLog.setOperationId(id);
		operateLog.setOperationName(menuLink.getButtonName());
		operateLog.setUrl(menuLink.getMenuLink());
		operateLog.setUserId(user.getObjectId());
		operateLog.setUserName(user.getLoginName());
		operateLog.setPlatform(user.getPlatform());
		
		operateLogManager.save(operateLog);
	}
    
    /**
     * 根据二级菜单id 查询菜单信息，若出错返回null
     * @param menuId 二级菜单id
     * @return OperateLog
     */
    private OperateLog populateMenuInfo(Long menuId) {
    	OperateLog operateLog = null;
    	Menu menu = null;
		Menu parentMenu = null;
		menu =  menuManager.getByObjectId(menuId);
		
		if (null == menu) {
		    LOG.error("跟据MenuId：" + menuId + " 查询不到Menu");
		    return operateLog;
		}
		
		parentMenu = menuManager.getByObjectId(menu.getParentId());
		if (null == parentMenu) {
		    LOG.error("跟据MenuId：" + menu.getParentId() + " 查询不到Menu");
		    return operateLog;
		}
		
		operateLog = new OperateLog();
		operateLog.setBeginDate(new Date());
		operateLog.setMenuId(parentMenu.getObjectId());
		operateLog.setMenuName(parentMenu.getName());
		operateLog.setSecondMenuId(menuId);
		operateLog.setSecondMenuName(menu.getName());
		
		return operateLog;
    }
    
    @RequestMapping("500")
	public String error500(HttpServletRequest request,HttpServletResponse response){
		return "common/500";
	}
}
