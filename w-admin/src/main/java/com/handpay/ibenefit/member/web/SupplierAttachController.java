package com.handpay.ibenefit.member.web;

import java.io.IOException;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.SupplierAttach;
import com.handpay.ibenefit.member.service.ISupplierAttachManager;

@Controller
@RequestMapping("/supplierAttach")
public class SupplierAttachController extends PageController<SupplierAttach>{
	private static final String BASE_DIR = "member/";
	private static final Logger LOGGER = Logger.getLogger(SupplierAttachController.class);
	
	@Reference(version = "1.0")
	private ISupplierAttachManager supplierAttachManager;
	
	@Reference(version="1.0")
	private IFileManager fileManager;
	
	@Override
	public Manager<SupplierAttach> getEntityManager() {
		return supplierAttachManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@RequestMapping("/uploadAttach")
    @ResponseBody
	protected String uploadAttach(HttpServletRequest request, HttpServletResponse response) throws Exception {
		//供应商ID
		String supplierId=request.getParameter("supplierIDDD");
		Map<String,Object> map = new HashMap<String,Object>();
		if (StringUtils.isBlank(supplierId)) {
			LOGGER.error("supplierId can not null");
		}else {
			SupplierAttach t=new SupplierAttach();
			UploadFile uploadFile = null;
	        try {
	        	uploadFile = FileUpDownUtils.getUploadFile(request, "attachName");
	        	if (uploadFile!=null) {
	        		t.setAttachName(uploadFile.getFileName());
		    		map.put("name",uploadFile.getFileName());
					byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		    		String filePath = fileManager.saveContractFile(fileData,uploadFile.getFileName());
		    		map.put("path", filePath.trim());
		    		t.setAttachRoute(filePath);
				}
	        } catch (IOException e1) {
	        	LOGGER.error(e1);
	        }
	        t.setSupplierId(Long.parseLong(supplierId));
	        t.setIsPublished(IBSConstants.STATUS_NO);
			t=getEntityManager().save(t);
			map.put("id", t.getObjectId().toString());
		}
		AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
	}
	
	@RequestMapping("/deleteAttach/{objectId}")
	protected String deleteAttach(HttpServletRequest request,
			HttpServletResponse response,@PathVariable Long objectId,ModelMap modelMap) throws Exception {
		supplierAttachManager.delete(objectId);
		modelMap.addAttribute("result", true);
		return "jsonView";
	}
	
}
