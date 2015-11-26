package com.handpay.ibenefit.base.web;

import java.io.PrintWriter;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.util.DomainUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.UploadFile;

@Controller
@RequestMapping("connector")
public class ConnectorController {
	
	@Reference(version="1.0")
    private IFileManager fileManager;
	
	@RequestMapping("uploadContentFile")
	public  String uploadContentFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "upload");
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        String filePath = fileManager.saveContentFile(fileData, uploadFile.getFileName());
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		StringBuilder sb = new StringBuilder(400);
		sb.append("<script type=\"text/javascript\">\n");
		sb.append("window.parent.CKEDITOR.tools.callFunction("  +  request.getParameter("CKEditorFuncNum") + ", '"  + GlobalConfig.getAdminStaticDomain() + filePath.trim() + "','');");
		sb.append("</script>");
		out.print(sb.toString());
		out.flush();
		out.close();
		return null;
	}
	
	@RequestMapping("uploadProduct")
	public  String upload(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "upload");
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        String filePath = fileManager.saveProductImage(fileData, uploadFile.getFileName());
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		StringBuilder sb = new StringBuilder(400);
		sb.append("<script type=\"text/javascript\">\n");
		sb.append("window.parent.CKEDITOR.tools.callFunction("  +  request.getParameter("CKEditorFuncNum") + ", '"  + GlobalConfig.getAdminStaticDomain() + filePath.trim() + "','');");
		sb.append("</script>");
		out.print(sb.toString());
		out.flush();
		out.close();
		return null;
	}
	
	
	@RequestMapping("uploadNewsNotify")
	public  String uploadNews(HttpServletRequest request, HttpServletResponse response) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "upload");
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        String filePath = fileManager.saveNewsFile(fileData, uploadFile.getFileName());
		response.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");
		response.setHeader("Cache-Control", "no-cache");
		PrintWriter out = response.getWriter();
		StringBuilder sb = new StringBuilder(400);
		sb.append("<script type=\"text/javascript\">\n");
		sb.append("window.parent.CKEDITOR.tools.callFunction("  +  request.getParameter("CKEditorFuncNum") + ", '"  + GlobalConfig.getAdminStaticDomain() + filePath.trim() + "','');");
		sb.append("</script>");
		out.print(sb.toString());
		out.flush();
		out.close();
		return null;
	}
	
}
