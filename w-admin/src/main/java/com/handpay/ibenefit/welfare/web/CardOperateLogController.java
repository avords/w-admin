/**
 * 
 */
package com.handpay.ibenefit.welfare.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.welfare.entity.CardOperateLog;
import com.handpay.ibenefit.welfare.service.ICardOperateLogManager;

/**
 * @author liran
 *
 */
@Controller
@RequestMapping("/cardOperateLog")
public class CardOperateLogController  extends PageController<CardOperateLog>{
	
	private static final String BASE_DIR = "welfare/";
	
	@Reference(version = "1.0")
	private ICardOperateLogManager cardOperateLogManager;

	@Override
	public Manager<CardOperateLog> getEntityManager() {
		return cardOperateLogManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	/**
	 * 查看全部卡密操作日志
	 * @param request
	 * @param t
	 * @param backPage 
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cardOperateAllLogPage/{createInfoId}")
	public String cardOperateAllLogPage(HttpServletRequest request,@PathVariable String createInfoId){
		List<CardOperateLog> cardOperateLogList = cardOperateLogManager.getCardOperateLogByCreateInfoId(Long.parseLong(createInfoId));
		request.setAttribute("logitems", cardOperateLogList);
		request.setAttribute("createInfoId", createInfoId);
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}
}
