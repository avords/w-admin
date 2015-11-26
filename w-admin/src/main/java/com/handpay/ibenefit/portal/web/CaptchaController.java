package com.handpay.ibenefit.portal.web;

import java.awt.image.BufferedImage;  
import javax.imageio.ImageIO;  

import javax.servlet.ServletOutputStream;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.log4j.Logger;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.servlet.ModelAndView;

import com.google.code.kaptcha.Producer;
import com.google.code.kaptcha.Constants;

@Controller
@RequestMapping("/kaptcha")
public class CaptchaController {
	
	private static final Logger LOGGER = Logger.getLogger(CaptchaController.class);
	
	@Autowired
	private Producer captchaProducer = null;
	
	@RequestMapping(value = "captcha-image")
	public ModelAndView getKaptchaImage(HttpServletRequest request, HttpServletResponse response) throws Exception {  
		HttpSession session = request.getSession();  
		response.setDateHeader("Expires", 0);  
		response.setHeader("Cache-Control", "no-store, no-cache, must-revalidate");  
		response.addHeader("Cache-Control", "post-check=0, pre-check=0");  
		response.setHeader("Pragma", "no-cache");  
		response.setContentType("image/jpeg");  
		 
		String capText = captchaProducer.createText();  
		session.setAttribute(Constants.KAPTCHA_SESSION_KEY, capText);  
		 
		BufferedImage bi = captchaProducer.createImage(capText);  
		ServletOutputStream out = response.getOutputStream();  
		ImageIO.write(bi, "jpg", out);  
		try {  
			out.flush();  
		} finally {  
			out.close();  
		}  
		return null;  
    }
}
