package com.handpay.ibenefit.security.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Server;
import com.handpay.ibenefit.security.service.IServerManager;

@Controller
@RequestMapping("/server")
public class ServerController extends PageController<Server>{
	private static final String BASE_DIR = "security/";
	@Reference(version="1.0")
	private IServerManager serverManager;

	@Override
    public Manager getEntityManager() {
	    return serverManager;
    }

	@Override
    public String getFileBasePath() {
	    return BASE_DIR;
    }

	/*
	  * <p>Title: handleEdit</p>
	  * <p>Description: </p>
	  * @param request
	  * @param response
	  * @param objectId
	  * @return
	  * @throws Exception
	  * @see com.handpay.ibenefit.framework.web.BaseController#handleEdit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Long)
	  */
	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		return super.handleEdit(request, response, objectId);
	}
}
