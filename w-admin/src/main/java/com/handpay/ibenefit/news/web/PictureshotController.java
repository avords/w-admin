package com.handpay.ibenefit.news.web;

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
import com.handpay.ibenefit.news.entity.AdvertCategory;
import com.handpay.ibenefit.news.service.IAdvertCategoryManager;

@Controller
@RequestMapping("/advert/picture")
public class PictureshotController {

    @Reference(version="1.0")
    private IFileManager fileManager;
    
    @Reference(version="1.0")
    private IAdvertCategoryManager advertCategoryManager;
    
    protected static final String TMP_DIR = GlobalConfig.getTempDir();

    @RequestMapping("/advertCrop")
    public String crop(HttpServletRequest request,HttpServletResponse response){
        String filePath = request.getParameter("filePath");
        String width = request.getParameter("width");
        String height = request.getParameter("height");
        String Sheight = request.getParameter("Sheight");
        String Swidth = request.getParameter("Swidth");
        request.setAttribute("filePath", filePath.trim());
        request.setAttribute("width", width);
        request.setAttribute("height", height);
        request.setAttribute("Sheight", Sheight);
        request.setAttribute("Swidth", Swidth);
        return "news/crop/advertCrop";
        
    }

    @RequestMapping("/saveCrop")
    public String saveCrop(HttpServletRequest request,HttpServletResponse response,ModelMap map) throws Exception {
        String srcFilePath = request.getParameter("srcFilePath");
        byte[] fileData = fileManager.getFile(srcFilePath);
        String oldPath = TMP_DIR + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
        String newPath = TMP_DIR + "cut" + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
        FileUtils.writeByteArrayToFile(new File(oldPath), fileData);
        // 图片在页面上的宽高
        int imageH = (int) Double.parseDouble(request.getParameter("imageH"));
        int imageW = (int) Double.parseDouble(request.getParameter("imageW"));
        // 图片距离编辑窗口的距离
        int imageX = (int) Double.parseDouble(request.getParameter("imageX"));
        int imageY = (int) Double.parseDouble(request.getParameter("imageY"));
        // 图片选择框的座标和高宽
        int selectorH = (int) Double.parseDouble(request.getParameter("selectorH"));
        int selectorW = (int) Double.parseDouble(request.getParameter("selectorW"));
        int selectorX = (int) Double.parseDouble(request.getParameter("selectorX"));
        int selectorY = (int) Double.parseDouble(request.getParameter("selectorY"));
        // Resize
        ImageUtils.scaleImage(oldPath, newPath, (int)imageW, (int)imageH);
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
        String filePath = fileManager.saveAdvertFile(fileData, srcFilePath.substring(srcFilePath.lastIndexOf("/")+1));
        //删除原上传文件
        fileManager.deleteFile(srcFilePath);
        //情况临时文件
        request.setAttribute("filePath", filePath);
        map.addAttribute("filePath", filePath);
        return "jsonView";
    }
    
    @RequestMapping("/uploadAdvert")
    @ResponseBody
    public String uploadAndDownload(HttpServletRequest request, HttpServletResponse response) throws Exception {
    	
    	String position = request.getParameter("position");
    	AdvertCategory ac=advertCategoryManager.getAdvertCategoryByp(position);
    	
        Map<String,Object> map = new HashMap<String,Object>();
        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile");
        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        String filePath = fileManager.saveAdvertFile(fileData, uploadFile.getFileName());
        BufferedImage image = ImageUtils.readImage(uploadFile.getFile().getAbsolutePath());
        map.put("width",2000+"");
        map.put("height",image.getHeight()+"");
        map.put("result", "true");
        map.put("filePath", filePath.trim());
        map.put("Sheight", ac.getLength()+"");
        map.put("Swidth", ac.getWidth()+"");
        AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
    }
    
      //直接上传广告图片
  	  @RequestMapping("/directUploadAdvert")
      @ResponseBody
      public String directUploadAdvert(HttpServletRequest request, HttpServletResponse response) throws Exception {
		Map<String, Object> map = new HashMap<String, Object>();
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request,"uploadFile");
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		String filePath = fileManager.saveAdvertFile(fileData,uploadFile.getFileName());
		map.put("result", true);
		map.put("filePath", filePath.trim());
		AjaxUtils.doAjaxResponseOfMap(response, map);
		return null;
      }
}
