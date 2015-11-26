package com.handpay.ibenefit.other.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.MessageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.other.entity.Message;
import com.handpay.ibenefit.other.service.ISendMsgManager;

@Controller
@RequestMapping("other")
public class SendMsgManagerController extends PageController<Message>  {
	
	private static Logger logger = Logger.getLogger(SendMsgManagerController.class);
	
	@Reference(version = "1.0")
	private ISendMsgManager sendMsgManager;

	@Override
	public String getFileBasePath() {
		return "other/";
	}

	@Override
	public Manager<Message> getEntityManager() {
		return sendMsgManager;
	}

	/**
	 * 短信推送中心列表
	 * @param request
	 * @param backPage
	 * @return
	 */
	@RequestMapping(value = "/SendMsgList")
	public String SendMsgList(HttpServletRequest request, Message msg) throws Exception{
		logger.info("加载短信推送中心列表数据！");
		request.setCharacterEncoding("UTF-8");
		PageSearch page  = preparePage(request);
		
		page.setSortProperty("sendTime");
		page.setSortOrder("desc");
		
		handlePage(request, page);
		afterPage(request, page, 0);
		
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
	
	@RequestMapping(value = "/deleteSendMsg/{objectId}")
	public String deleteSendMsg(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId) throws Exception {
		
		delete(objectId);
		return "redirect:/other/SendMsgList" + getMessage("common.base.deleted", request) + "&" + appendAjaxParameter(request);
	}
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, ModelMap modelMap, @Valid Message msg, BindingResult result) throws Exception {
		msg.setDeleted(0);
		return this.handleSave(request, modelMap, msg);
	}
	
	protected String handleSave(HttpServletRequest request, ModelMap modelMap, Message t) throws Exception {
		save(t);
		return "redirect:SendMsgList?message=" + MessageUtils.urlEncodeWithUtf8("操作成功");
	}
}
