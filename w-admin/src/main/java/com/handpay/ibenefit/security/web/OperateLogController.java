package com.handpay.ibenefit.security.web;

import java.util.List;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Menu;
import com.handpay.ibenefit.log.entity.OperateLog;
import com.handpay.ibenefit.security.service.IMenuManager;
import com.handpay.ibenefit.log.service.IOperateLogManager;

@Controller
@RequestMapping("/operateLog")
public class OperateLogController  extends PageController<OperateLog>{

	@Reference(version="1.0")
	private IOperateLogManager operateLogManager;
	@Reference(version="1.0")
	private IMenuManager  menuManager;
	
	@Override
	public Manager<OperateLog> getEntityManager() {
		return operateLogManager;
	}

	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch pSearch=preparePage(request);
		PageSearch result= operateLogManager.find(pSearch);
		 
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		request.setAttribute("action", "page");
		
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		
		Menu menu = new Menu();
		menu.setType(1);//一级菜单
		List<Menu> firstMenuList = menuManager.getBySample(menu);
		request.setAttribute("firstMenuList", firstMenuList);
		
		menu.setType(2);//二级菜单
		List<Menu> secondMenuList = menuManager.getBySample(menu);
		request.setAttribute("secondMenuList", secondMenuList);
		
		return getFileBasePath() + "listOperateLog";
	}
	
	@Override
	public String getFileBasePath() {
		return "security/";
	}

}
