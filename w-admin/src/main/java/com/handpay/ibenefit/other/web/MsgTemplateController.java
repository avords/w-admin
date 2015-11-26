package com.handpay.ibenefit.other.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.AbstractEntity;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.other.entity.MessageTemplate;
import com.handpay.ibenefit.other.service.IMessageTemplateManager;

/**
 * @desc   短信通知模版 web层
 * @author mwu
 * @date   2015年5月18日
 */
@Controller
@RequestMapping("/other/msgTemplate")
public class MsgTemplateController  extends PageController<MessageTemplate>{
	
	private static Logger logger = Logger.getLogger(MsgTemplateController.class);

	@Reference(version="1.0")
    private IMessageTemplateManager  messageTemplateManager;
	
	@Override
	public Manager<MessageTemplate> getEntityManager() {
		return messageTemplateManager;
	}

	@Override
	public String getFileBasePath() {
		return "other/";
	}
	
	/**
	 * 加载短信通知模版列表信息
	 * @param request
	 * @param backPage
	 * @return
	 */
	@RequestMapping(value = "/queryMsgList")
	public String queryMsgTemplateList(HttpServletRequest request, Integer backPage){
		try{
			logger.info("加载短信模版数据！");
			String messageType = "2";     //2 表示 短信通知模版类型
			PageSearch page  = preparePage(request);
			page.getFilters().add(new PropertyFilter("MessageTemplate","EQI_messageType",messageType));
			page = messageTemplateManager.findMessageTemplate(page);
			page.setTotalCount(page.getTotalCount());
			afterPage(request, page, backPage);
			request.setAttribute("action", "queryMsgList");
			afterPage(request, page,backPage);
		}catch(Exception e){
			e.printStackTrace();
		}
		return getFileBasePath() + "listMsgTemplate";
	}
	/**
	 * 逻辑删除短信通知模版数据 并加载最新数据列表
	 * @param request
	 * @param response
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/deleteMsg/{objectId}")
	public String deleteMsg(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId){
		try{
			delete(objectId);
		}catch(Exception e){
			e.printStackTrace();
		}
		return "redirect:/other/msgTemplate/queryMsgList" + getMessage("common.base.deleted", request) + "&" + appendAjaxParameter(request);
	}
	/**
	 * 新增短信通知模版
	 * @param request
	 * @param response
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/createMsg")
	public String createMsg(HttpServletRequest request, HttpServletResponse response){
		return getFileBasePath() + "editMsgTemplate";
	}
	/**
	 * 修改短信通知模版
	 */
	@RequestMapping(value = "/edit/{objectId}")
	public String edit(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId){
		try {
			String str = request.getParameter("str");
			if (null != objectId) {
				Object entity = getManager().getByObjectId(objectId);
				request.setAttribute("entity", entity);
				request.setAttribute("str", str);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return getFileBasePath() + "editMsgTemplate";
	}
	/**
	 * 根据模版编号校验数据唯一性
	 * @param request
	 * @param response
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/isUniqueTemplate")
	public String isUniqueTemplate(HttpServletRequest request, HttpServletResponse response, Long objectId,String messageCode,Integer deleted){
		logger.info(objectId+"******"+messageCode+"******"+deleted);
		boolean result = false;
		try {
			MessageTemplate msgTemplate = new MessageTemplate();
			msgTemplate.setObjectId(objectId);
			msgTemplate.setMessageCode(messageCode);
			//msgTemplate.setDeleted(deleted);
			List<MessageTemplate> msgTemplateList = messageTemplateManager.getBySample(msgTemplate);
			if(msgTemplateList != null && msgTemplateList.size() == 1){
				result =  true;
			}
			response.getWriter().print(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 保存邮件通知模版
	 * @param request
	 * @param response
	 * @param messageTemplate
	 * @param str
	 * @return
	 */
	@RequestMapping(value = "/saveMsg")
	public String saveMsg(HttpServletRequest request, HttpServletResponse response,MessageTemplate messageTemplate){
		String str = request.getParameter("str");
		save(messageTemplate);
		return "redirect:queryMsgList" + getMessage("common.base.success", request)
				+ "&" + appendAjaxParameter(request) +"&str=" + str + "&action=" + request.getParameter("action");
	}
}
