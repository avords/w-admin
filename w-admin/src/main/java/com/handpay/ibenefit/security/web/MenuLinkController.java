package com.handpay.ibenefit.security.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.MenuLink;
import com.handpay.ibenefit.security.service.IMenuLinkManager;
@Controller
@RequestMapping("/menuLink")
public class MenuLinkController extends PageController<MenuLink>{
	private static final String BASE_DIR = "security/";
	@Reference(version="1.0")
	private IMenuLinkManager menuLinkManager;

	@RequestMapping("/addMenuLink/{menuId}")
	public String addMenuLink(ModelMap modelMap,@PathVariable Long menuId){
		List<MenuLink> menuLinks = menuLinkManager.getMenuLinksByMenuId(menuId);
		modelMap.addAttribute("menuLinks", menuLinks);
		modelMap.addAttribute("menuId", menuId);
		return BASE_DIR + "addMenuLink";
	}

	protected String handleSave(HttpServletRequest request, ModelMap modelMap, MenuLink t) throws Exception {
		getEntityManager().save(t);
		return "redirect:addMenuLink/" + t.getMenuId() + getMessage("common.base.success",request) + "&" + appendAjaxParameter(request);
	}

	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId) throws Exception {
		String menuId = request.getParameter("menuId");
		menuLinkManager.delete(objectId);
		return "redirect:../addMenuLink/" + menuId + getMessage("common.base.success",request) + "&" + appendAjaxParameter(request);
	}

	@Override
    public Manager<MenuLink> getEntityManager() {
	    return menuLinkManager;
    }

	@Override
    public String getFileBasePath() {
	    return BASE_DIR;
    }

}
