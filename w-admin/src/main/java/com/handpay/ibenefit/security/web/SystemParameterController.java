package com.handpay.ibenefit.security.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.security.entity.SystemParameter;
import com.handpay.ibenefit.security.service.ISystemParameterManager;

@Controller
@RequestMapping("/systemParameter")
public class SystemParameterController {
	private static final String BASE_DIR = "security/";
	private static final Logger LOG = Logger.getLogger(SystemParameterController.class);
    private final String  editPage = BASE_DIR+ "editSystemParameter";
	
	@Reference(version="1.0")
	private ISystemParameterManager systemParameterManager;
	
	@RequestMapping("/edit")
	public String editSystemParameter(ModelMap modelMap){
		List<SystemParameter> systemParameters = systemParameterManager.getSystemParameter();
		
		modelMap.put("systemParameters", systemParameters);
		return editPage;
	}
	
	@RequestMapping("/save")
	public String handleSave(HttpServletRequest request, ModelMap modelMap, SystemParameter parameter){
		String[] objectIds = request.getParameterValues("objectId");
		String[] names = request.getParameterValues("name");
		String[] values = request.getParameterValues("value");
		
		List<SystemParameter> systemParameters = new ArrayList<SystemParameter>();
		
		if (null == values || values.length == 0 || null == names || names.length ==0) {
			
			return editPage;
		}
		
		int count = values.length;
		for (int i = 0; i < count; i++) {
			SystemParameter systemParameter = new SystemParameter();
			
			if(StringUtils.isNotBlank(objectIds[i])) {
				systemParameter.setObjectId(Long.parseLong(objectIds[i]));
			}
			
			if (StringUtils.isNotBlank(values[i]) && StringUtils.isNotBlank(names[i])) {
				systemParameter.setValue(values[i]);
				systemParameter.setName(names[i]);
				systemParameters.add(systemParameter);
			}  
		}
		
		systemParameterManager.saveOrUpdate(systemParameters);
		return "redirect:edit/";
	}
}
