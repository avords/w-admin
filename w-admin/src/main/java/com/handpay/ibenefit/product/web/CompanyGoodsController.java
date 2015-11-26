package com.handpay.ibenefit.product.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.member.entity.CompanyPublished;
import com.handpay.ibenefit.member.service.ICompanyPublishedManager;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("companyGoods")
public class CompanyGoodsController {
	
	@Reference(version="1.0")
	private ICompanyPublishedManager companyPublishedManager;
	
	@Reference(version="1.0")
	private IWelfarePackageManager welfarePackageManager;
	
	@Reference(version="1.0", timeout=60000)
	private ICompanyGoodsManager companyGoodsManager;

	@RequestMapping("shieldCompany/{companyId}")
	@ResponseBody
	public String shieldCompany(@PathVariable Long companyId){
		CompanyPublished company = companyPublishedManager.getByObjectId(companyId);
		if(company!=null){
			companyGoodsManager.updateByCompanyId(companyId);
			return "success";
		}
		return "fail";
	}
	
	@RequestMapping("updateAll")
	@ResponseBody
	public String updateAll(){
		companyGoodsManager.updateAll();
		return "success";
	}
}
