package com.handpay.ibenefit.physical.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.physical.entity.PhysicalMainAddtional;
import com.handpay.ibenefit.physical.service.IPhysicalMainAddtionalManager;

/**
 *主套餐和 （加项套餐的组合 ）操作类
 */
@Controller
@RequestMapping("/physicalMainAddtional")
public class PhysicalMainAddtionalController extends PageController<PhysicalMainAddtional>{

	private static final String BASE_DIR = "physical/";
	@Reference(version="1.0")
	private IPhysicalMainAddtionalManager physicalMainAddtionalManager;
	
	
	@Override
	public String handlePage(HttpServletRequest request,  PageSearch page) {
		PageSearch pageSearch = preparePage(request);
		pageSearch = physicalMainAddtionalManager.findPageList(pageSearch);
		
		page.setList(pageSearch.getList());
		page.setTotalCount(pageSearch.getTotalCount());
        afterPage(request, page, PageUtils.IS_NOT_BACK);
		
		return BASE_DIR + "/listPhysicalMainAddtional";
	}
	
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request){
		 
		String packageCodeArray = request.getParameter("packageCodeArray");
		
		if ( StringUtils.isBlank(packageCodeArray)) {
			return "redirect:page" + getMessage("common.base.fail", request);
		}
		
	
		String[] packageCodes = packageCodeArray.split(",");
		List<PhysicalMainAddtional> list = new ArrayList<PhysicalMainAddtional>();
		int idCount = packageCodes.length;
		
		for(int i=0; i<idCount; i++) {
			
			if (StringUtils.isNotBlank(packageCodes[i]))  {
				String[] idAndCode = packageCodes[i].split("-");
				PhysicalMainAddtional physicalMainAddtional = new PhysicalMainAddtional();
				physicalMainAddtional.setObjectId(Long.parseLong(idAndCode[0]));
				physicalMainAddtional.setPackageCode(idAndCode[1]);
				list.add(physicalMainAddtional);
			}
			
		}
		
		physicalMainAddtionalManager.savePackageCode(list);
		return "redirect:page" + getMessage("common.base.success", request);
	}
	 
	@Override
	public Manager<PhysicalMainAddtional> getEntityManager() {
		 
		return physicalMainAddtionalManager;
	}

	@Override
	public String getFileBasePath() {
		 
		return BASE_DIR;
	}

}
