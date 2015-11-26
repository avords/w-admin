package com.handpay.ibenefit.security.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Operation;
import com.handpay.ibenefit.security.service.IOperationManager;
@Controller
@RequestMapping("/opera")
public class OperationController extends PageController<Operation>{
	@Reference(version="1.0")
	private IOperationManager operationManager;

	@Override
    public Manager<Operation> getEntityManager() {
	    return operationManager;
    }

	@Override
    public String getFileBasePath() {
	    return "security/";
    }

}
