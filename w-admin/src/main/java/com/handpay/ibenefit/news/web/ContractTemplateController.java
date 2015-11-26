package com.handpay.ibenefit.news.web;

import java.io.IOException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.news.entity.ContractTemplate;
import com.handpay.ibenefit.news.service.IContractTemplateManager;

@Controller
@RequestMapping("/contracttemplate")
public class ContractTemplateController extends PageController<ContractTemplate> {

	private static final String BASE_DIR = "news/";
	
	@Reference(version = "1.0")
	private IContractTemplateManager contractTemplateManager;
	
	@Reference(version="1.0")
	private IFileManager fileManager;

	@Override
	public Manager<ContractTemplate> getEntityManager() {
		return contractTemplateManager;
	}
	
	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		getManager().delete(objectId);
		return "redirect:../page";
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,ContractTemplate t) throws Exception {
		contractTemplateManager.deleteAllInfo();
		UploadFile uploadFile = null;
        try {
        	uploadFile = FileUpDownUtils.getUploadFile(request, "contractTemPath");
        	byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
    		String filePath = fileManager.saveContractFile(fileData,uploadFile.getFileName());
    		t.setContractTemPath(filePath);
        } catch (IOException e1) {
        	
        }
		return super.handleSave(request, modelMap, t);
	}
	@Override
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		return "news/editContractTemplate";
		
	}
	
}
