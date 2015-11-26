package com.handpay.ibenefit.order.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.ImageUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.service.IOrderManager;

@Controller
@RequestMapping("/order/picture")
public class UploadPictureController {

	  @Reference(version="1.0")
	  private IFileManager fileManager;
	  @Reference(version="1.0")
	  private IOrderManager orderManager;
	  protected static final String TMP_DIR = GlobalConfig.getTempDir();

	  
	  @RequestMapping("/saveCrop")
	    public String saveCrop(HttpServletRequest request,HttpServletResponse response,ModelMap map) throws Exception {
	        String srcFilePath = request.getParameter("srcFilePath");
	        byte[] fileData = fileManager.getFile(srcFilePath);
	        String oldPath = TMP_DIR + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
	        String newPath = TMP_DIR + "cut" + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
	        FileUtils.writeByteArrayToFile(new File(oldPath), fileData);
	        // 图片在页面上的宽高
	        int imageH = (int)Double.parseDouble(request.getParameter("imageH"));
	        int imageW = (int)Double.parseDouble(request.getParameter("imageW"));
	        // 图片距离编辑窗口的距离
	        int imageX = (int)Double.parseDouble(request.getParameter("imageX"));
	        int imageY = (int)Double.parseDouble(request.getParameter("imageY"));
	        // 图片旋转的角度
	        int angle = (int)Double.parseDouble(request.getParameter("imageRotate"));
	        String imageSource = request.getParameter("imageSource");
	        // 图片选择框的座标和高宽
	        int selectorH = (int)Double.parseDouble(request.getParameter("selectorH"));
	        int selectorW = (int)Double.parseDouble(request.getParameter("selectorW"));
	        int selectorX = (int)Double.parseDouble(request.getParameter("selectorX"));
	        int selectorY = (int)Double.parseDouble(request.getParameter("selectorY"));
	        // 编辑窗口的大小
	        int viewPortH = Integer.parseInt(request.getParameter("viewPortH"));
	        int viewPortW = Integer.parseInt(request.getParameter("viewPortW"));
	        // Resize// 图片在页面上的宽高
	      
	        ImageUtils.scaleImage(oldPath, newPath, imageW, imageH);
	        // BufferedImage image = ImageUtils.readImage(oldpath);
	        // ImageUtils.rotateImage(image, (int)angle);
	        int x = selectorX - imageX;
	        if (x < 0) {
	            x = 0;
	        }
	        int y = selectorY - imageY;
	        if (y < 0) {
	            y = 0;
	        }
	        ImageUtils.cutImage(x, y, selectorW, selectorH, newPath, newPath);
	        fileData = FileUpDownUtils.getFileContent(new File(newPath));
	        String filePath = fileManager.saveContentFile(fileData, srcFilePath.substring(srcFilePath.lastIndexOf("/")+1));
	        //删除原上传文件
	        fileManager.deleteFile(srcFilePath);
	        //情况临时文件
	        request.setAttribute("filePath", filePath);
	        map.addAttribute("filePath", filePath);
	        return "jsonView";
	    }
	  
	 @RequestMapping("/uploadProduct")
	    @ResponseBody
	    public String uploadProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        Map<String,Object> map = new HashMap<String,Object>();
	        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile");
	        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
	        String filePath = fileManager.saveContentFile(fileData, uploadFile.getFileName());
	        BufferedImage image = ImageUtils.readImage(uploadFile.getFile().getAbsolutePath());
	        map.put("width",image.getWidth()+"");
	        map.put("height",image.getHeight()+"");
	        map.put("result", "true");
	        map.put("filePath", filePath.trim());
	        AjaxUtils.doAjaxResponseOfMap(response, map);
		    return null;
	    }
	 
	 @RequestMapping("/productCrop")
	    public String productCrop(HttpServletRequest request,HttpServletResponse response){
	        String filePath = request.getParameter("filePath");
	        String width = request.getParameter("width");
	        String height = request.getParameter("height");
	        request.setAttribute("filePath", filePath.trim());
	        request.setAttribute("width", width);
	        request.setAttribute("height", height);
	        request.setAttribute("type", request.getParameter("type"));
	        return "order/crop/orderCrop";
	    }
	 
	    @RequestMapping("/uploadFile")
	    @ResponseBody
	    public String uploadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
	        Long objectId = Long.parseLong(request.getParameter("objectId"));
	        Map<String,Object> map = new HashMap<String,Object>();
	        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile");
	        String fileName = uploadFile.getFileName();
	        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
	        String filePath = fileManager.savePhysicalReport(fileData, fileName);
	        //保存文件到数据库
	        Order order = orderManager.getByObjectId(objectId);
	        order.setTotalRepport(filePath);
	        order.setTotalFileName(fileName);
	        orderManager.save(order);
	        map.put("filePath", filePath.trim());
	        map.put("fileName", fileName);
	        map.put("result", "true");
	        AjaxUtils.doAjaxResponseOfMap(response, map);
		    return null;
	    }
	    
	    
	    @RequestMapping("/deletePicture")
	    public String deletePicture(HttpServletRequest request, HttpServletResponse response,ModelMap map) throws Exception {
	        String filePath = request.getParameter("filePath");
	        boolean result = fileManager.deleteFile(filePath);
	        
	        map.addAttribute("result", result);
	        return "jsonView";
	    }
	
}
