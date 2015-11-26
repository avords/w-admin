package com.handpay.ibenefit.security.web;


import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.point.entity.PointDistrubuteStaff;
import com.handpay.ibenefit.point.service.IPointDistrubuteStaffManager;
import com.handpay.ibenefit.security.entity.PointOperateLog;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IPointOperateManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("balance")
public class BalanceController {
	
	private static final Logger LOGGER = Logger.getLogger(BalanceController.class);
	
	@Reference(version = "1.0")
	private IUserManager userManager;
	
	@Reference(version = "1.0")
	private IPointOperateManager pointOperateManager;
	
	@Reference(version = "1.0")
	private IPointDistrubuteStaffManager pointDistrubuteStaffManager;
	
	@RequestMapping("index")
	public String index(HttpServletRequest request) throws Exception {
		PageSearch pageSearch = PageUtils.preparePage(request, User.class, true);
		pageSearch = userManager.getMismatchBalanceUsers(pageSearch);
		PageUtils.afterPage(request, pageSearch, PageUtils.IS_NOT_BACK);
		return "security/listBalance";
	}
	
	@RequestMapping("update")
	public String update(HttpServletRequest request) throws Exception {
		String userIds = request.getParameter("userIds");
		String balances = request.getParameter("balances");
		if(StringUtils.isNotBlank(userIds) && StringUtils.isNotBlank(balances)){
			String[] ids = userIds.split(",");
			String[] point = balances.split(",");
			if(ids.length>0 && ids.length == point.length){
				for(int i=0;i<point.length;i++) {
					try{
						Long userId = Long.parseLong(ids[i]);
						User user = userManager.getByObjectId(userId);
						if(user!=null){
							userManager.updateBalance(userId, Double.parseDouble(point[i]));
							LOGGER.info(FrameworkContextUtils.getCurrentUser().getObjectId() + "调整用户" + user.getUserName() 
									+ "[" + user.getObjectId() + "]的积分为：" + point[i] + "(原积分为：" + user.getAccountBalance() + ")");
						}
					}catch (Exception e){
						LOGGER.error("index",e);
					}
				}
			}
		}
		return "redirect:index";
	}
	
	@RequestMapping("detail/{userId}")
	public String index(HttpServletRequest request,@PathVariable Long userId) throws Exception {
		PageSearch pageSearch = PageUtils.preparePage(request, PointOperateLog.class, false);
		pageSearch.getFilters().add(new PropertyFilter(PointOperateLog.class.getName(), "EQL_userId", userId + ""));
		if(pageSearch.getSortProperty()==null){
			pageSearch.setSortProperty("createDate");
			pageSearch.setSortOrder("desc");
		}
		pageSearch = pointOperateManager.loadOperateLogs(pageSearch);
		request.setAttribute("pageSearch", pageSearch);
		PageUtils.afterPage(request, pageSearch, PageUtils.IS_NOT_BACK);
		request.setAttribute("user", userManager.getByObjectId(userId));
		return "security/listBalanceDetail";
	}
	
	@RequestMapping("grantDetail/{userId}")
	public String grantDetail(HttpServletRequest request,@PathVariable Long userId) throws Exception {
		PageSearch pageSearch = PageUtils.preparePage(request, PointOperateLog.class, false);
		pageSearch.getFilters().add(new PropertyFilter(PointOperateLog.class.getName(), "EQL_userId", userId + ""));
		pageSearch.setPageSize(1000);
		pageSearch = pointDistrubuteStaffManager.selectPointStaff(pageSearch);
		request.setAttribute("user", userManager.getByObjectId(userId));
		request.setAttribute("items", pageSearch.getList());
		return "security/listGrantDetail";
	}
	
}
