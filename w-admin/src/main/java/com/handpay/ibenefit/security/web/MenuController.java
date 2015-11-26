package com.handpay.ibenefit.security.web;

import java.util.ArrayList;
import java.util.List;
import java.util.Locale;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.LocaleUtils;
import com.handpay.ibenefit.framework.util.MessageUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Menu;
import com.handpay.ibenefit.security.entity.MenuTree;
import com.handpay.ibenefit.security.entity.Server;
import com.handpay.ibenefit.security.service.IMenuManager;
import com.handpay.ibenefit.security.service.IServerManager;

@Controller
@RequestMapping("/menu")
public class MenuController extends PageController<Menu> {
	
	private static final Logger LOGGER = Logger.getLogger(MenuController.class);
	
	private static final String BASE_DIR = "security/";
	@Reference(version = "1.0")
	private IMenuManager menuManager;
	@Reference(version = "1.0")
	private IServerManager serverManager;

	@Override
	public Manager getEntityManager() {
		return menuManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@RequestMapping(value = "/saveToTree")
	public String saveToTree(HttpServletRequest request, ModelMap modelMap, Menu t) throws Exception {
		menuManager.save(t);
		return "redirect:menuTree/"+t.getPlatform()+getMessage("操作成功", request);
	}
	
	@RequestMapping(value = "/menuTree")
	public String menuTree(HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		String children = parseJsonTree(Menu.ROOT_PLATEFORM_ADMIN);
		request.setAttribute("platform", Menu.ROOT_PLATEFORM_ADMIN.getObjectId());
		request.setAttribute("root", children);
		return getFileBasePath() + "menuTree";
	}
	/**
	 * 
	 * menuTree(获取菜单树，并做菜单的增删改查操作)
	 *
	 * @Title: menuTree
	 * @Description: TODO
	 * @param @param request
	 * @param @param response
	 * @param @return
	 * @param @throws Exception 设定文件
	 * @return String 返回类型
	 * @throws
	 */
	@RequestMapping(value = "/menuTree/{platform}")
	public String menuTree(HttpServletRequest request,
			HttpServletResponse response,@PathVariable Long platform) throws Exception {
		Menu menu = null;
		if(IBSConstants.PLATEFORM_HR==platform){
			menu = Menu.ROOT_PLATEFORM_HR;
		}else if(IBSConstants.PLATEFORM_SUPPLIER==platform){
			menu = Menu.ROOT_PLATEFORM_SUPPLIER;
		}else{
			platform = Menu.ROOT_PLATEFORM_ADMIN.getObjectId();
			menu = Menu.ROOT_PLATEFORM_ADMIN;
		}
		request.setAttribute("platform", platform);
		String children = parseJsonTree(menu);
		request.setAttribute("root", children);
		return getFileBasePath() + "menuTree";
	}
	
	/**
	  * getChildren(异步获取子菜单)
	  *
	  * @Title: getChildren
	  * @Description: TODO
	  * @param @param request
	  * @param @param response
	  * @param @param id
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping(value="/getChildren")
	public String getChildren(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		Gson gson = new Gson();
		List<MenuTree> menuTrees = new ArrayList<MenuTree>();
		if(id==null){
			id = Menu.ROOT_PLATEFORM_ADMIN.getObjectId();
		}
		List<Menu> menus = menuManager.getMenusByParentId(id);
		for (Menu menu : menus) {
			MenuTree menuTree = new MenuTree();
			menuTree.setId(menu.getObjectId());
			menuTree.setpId(menu.getParentId());
			if(menu.getStatus().equals(Menu.MENU_STATUS_OFFLINE) ){
				menuTree.setName(menu.getName()+"[已下线]");
			}else if(menu.getStatus().equals(Menu.MENU_STATUS_DELETED) ){
				menuTree.setName(menu.getName()+"[已删除]");
			}else{
				menuTree.setName(menu.getName());
			}
			menuTree.setType(menu.getType());
			List<Menu> submenus = menuManager.getMenusByParentId(menu.getObjectId());
			if(menus==null||submenus.size()==0){
				menuTree.setCanDel(true);
			}else{
				menuTree.setCanDel(false);
			}
			if(menu.getType()!=Menu.TYPE_MENU){
				menuTree.setParent(true);
			}else{
				menuTree.setParent(false);
			}
			menuTrees.add(menuTree);
		}
		AjaxUtils.doAjaxResponse(response, gson.toJson(menuTrees));
		return null;
	}
	
	/**
	  * getCurrentMenu(获取当前菜单信息)
	  *
	  * @Title: getCurrentMenu
	  * @Description: TODO
	  * @param @param request
	  * @param @param modelMap
	  * @param @param currentNodeId
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return ModelAndView    返回类型
	  * @throws
	 */
	@RequestMapping(value="/getCurrentMenu/{currentNodeId}")
	public ModelAndView getCurrentMenu(HttpServletRequest request,ModelMap modelMap,@PathVariable Long currentNodeId) throws Exception {
		Menu menu = null;
		if(IBSConstants.PLATEFORM_HR==currentNodeId){
			menu = Menu.ROOT_PLATEFORM_HR;
		}else if(IBSConstants.PLATEFORM_SUPPLIER==currentNodeId){
			menu = Menu.ROOT_PLATEFORM_SUPPLIER;
		}else if(IBSConstants.PLATEFORM_ADMIN==currentNodeId){
			menu = Menu.ROOT_PLATEFORM_ADMIN;
		}else{
			menu = menuManager.getByObjectId(currentNodeId);
		}
		modelMap.addAttribute("node",menu);
		return new ModelAndView("jsonView");
	}
	
	
	@RequestMapping(value="/deleteCurrentMenu/{currentNodeId}")
	public ModelAndView deleteCurrentMenu(HttpServletRequest request,ModelMap modelMap,@PathVariable Long currentNodeId) throws Exception {
		try {
			Integer count = menuManager.queryMenuSubCount(currentNodeId);
			if(count>0){
				modelMap.addAttribute("node",false);
			}else{
				menuManager.updateMenuStatus(currentNodeId);
				modelMap.addAttribute("node",true);
			}
			
		} catch (Exception e) {
			LOGGER.error(e);
			modelMap.addAttribute("node",false);
		}
		return new ModelAndView("jsonView");
	}

	/**
	  * parseJsonTree(转换Json格式树形字符串)
	  *
	  * @Title: parseJsonTree
	  * @Description: TODO
	  * @param @param menus
	  * @param @return    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	private String parseJsonTree(Menu menuRoot) {
		Gson gson = new Gson();
		List<MenuTree> menuTrees = new ArrayList<MenuTree>();
		MenuTree menuRootTree = new MenuTree();
		menuRootTree.setId(menuRoot.getObjectId());
		menuRootTree.setpId(menuRoot.getParentId());
		menuRootTree.setName(menuRoot.getName());
		menuRootTree.setType(menuRoot.getType());
		List<Menu> menus = menuManager.getMenusByParentId(menuRoot.getObjectId());
		if(menus==null||menus.size()==0){
			menuRootTree.setCanDel(true);
		}else{
			menuRootTree.setCanDel(false);
		}
		if(menuRoot.getType()!=Menu.TYPE_MENU){
			menuRootTree.setParent(true);
		}else{
			menuRootTree.setParent(false);
		}
		menuTrees.add(menuRootTree);
		return gson.toJson(menuTrees);
	}

	public static final String interpret(String path, Locale locale) {
		if (StringUtils.isNotBlank(path)) {
			String[] paths = path.split("/");
			StringBuilder result = new StringBuilder(path.length() / 5);
			for (int i = 1; i < paths.length; i++) {
				result.append("/").append(
						MessageUtils.getMessage(paths[i], locale));
			}
			return result.toString();
		}
		return path;
	}

	protected String handlePage(HttpServletRequest request, PageSearch page) {
		handleFind(page);
		Locale locale = LocaleUtils.getLocale(request);
		for (Menu menu : (List<Menu>) page.getList()) {
			menu.setPath(interpret(menu.getPath(), locale));
		}
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}

	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		List<Server> servers = serverManager.getAll();
		request.setAttribute("servers", servers);
		List<Menu> pathes = menuManager.getAllFolder();
		Locale locale = LocaleUtils.getLocale(request);
		for (Menu menu : pathes) {
			menu.setPath(interpret(menu.getPath(), locale));
		}
		request.setAttribute("pathes", pathes);
		return super.handleEdit(request, response, objectId);
	}

	@Override
	@RequestMapping("isUnique")
	@ResponseBody
	public boolean isUnique(Menu t) {
		t.setStatus(1);
		t.setName(t.getName().trim());
		return super.isUnique(t);
	}
	
	
}
