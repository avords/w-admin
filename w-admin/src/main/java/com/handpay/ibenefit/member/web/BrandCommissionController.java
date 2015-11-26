package com.handpay.ibenefit.member.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.BrandCommission;
import com.handpay.ibenefit.member.entity.SupplierBrand;
import com.handpay.ibenefit.member.service.IBrandCommssionManager;
import com.handpay.ibenefit.member.service.ISupplierBrandManager;

/**
 * 佣金设置
 * @author yazhou.li
 * @version 1.0 2015-5-29
 *
 */
@Controller
@RequestMapping("/brandCommission")
public class BrandCommissionController extends PageController<BrandCommission>{
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private IBrandCommssionManager brandCommssionManager;
	
	@Reference(version = "1.0")
	private ISupplierBrandManager supplierBrandManager;
	
	@Override
	public Manager<BrandCommission> getEntityManager() {
		return brandCommssionManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	public String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		if (objectId!=null) {
			request.setAttribute("supplierBrandId", objectId);
			SupplierBrand supplierBrand=supplierBrandManager.getByObjectId(objectId);
			if (supplierBrand.getCommissionWay()!=null) {
				if (supplierBrand.getCommissionWay()==1) {
					BrandCommission brandCommission=new BrandCommission();
					brandCommission.setBrandId(objectId);
					List<BrandCommission> brandCommissions=getEntityManager().getBySample(brandCommission);
					if (brandCommissions.size()!=0) {
						request.setAttribute("brandCommissions", brandCommissions);
					}
					request.setAttribute("commissionWay", "1");
				}else if (supplierBrand.getCommissionWay()==2 && supplierBrand.getMoneyper()!=null) {
					request.setAttribute("moneyper", supplierBrand.getMoneyper());
					request.setAttribute("commissionWay","2");
				}
			}else {
				request.setAttribute("commissionWay", null);
			}
			request.setAttribute("entity", supplierBrand);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}
	
	@Override
	public String handleSaveToPage(HttpServletRequest request, ModelMap modelMap,
			BrandCommission t) throws Exception {
		String supplierBrandId=request.getParameter("supplierBrandId");
		String supplierId=request.getParameter("supplierId");
		if (StringUtils.isNotBlank(supplierBrandId)) {
			t.setBrandId(Long.parseLong(supplierBrandId));
			SupplierBrand supplierBrand=supplierBrandManager.getByObjectId(Long.parseLong(supplierBrandId));
			String commissionWay=request.getParameter("commissionWay");
			if ("1".equals(commissionWay)) {//按订单总额
				supplierBrand.setCommissionWay(1);
				supplierBrand.setMoneyper(null);
				String[] commissionIds=request.getParameterValues("commissionId");
				String[] starts=request.getParameterValues("moneyStart");
				String[] ends=request.getParameterValues("moneyStop");
				String[] percents=request.getParameterValues("percent");
				for (int i = 0; i < commissionIds.length; i++) {
					BrandCommission temp=new BrandCommission();
					Long objectId = null;
	                if(StringUtils.isNotBlank(commissionIds[i])){
	                    objectId = Long.parseLong(commissionIds[i]);
	                    temp.setObjectId(objectId);
	                }
					if (StringUtils.isNotBlank(starts[i]) && StringUtils.isNotBlank(ends[i]) && StringUtils.isNotBlank(percents[i])) {
						temp.setBrandId(Long.parseLong(supplierBrandId));
						temp.setMoneyStart(Double.parseDouble(starts[i]));
						temp.setMoneyStop(Double.parseDouble(ends[i]));
						temp.setPercent(Double.parseDouble(percents[i]));
						getEntityManager().save(temp);
					}
				}
			}else if ("2".equals(commissionWay)) {//按订单数量
				BrandCommission brandCommission=new BrandCommission();
				brandCommission.setBrandId(Long.parseLong(supplierBrandId));
				getEntityManager().deleteBySample(brandCommission);
				String perMoney=request.getParameter("moneyper");
				supplierBrand.setMoneyper(Double.parseDouble(perMoney));
				supplierBrand.setCommissionWay(2);
			}
			supplierBrandManager.save(supplierBrand);
		}
		if (StringUtils.isNotBlank(supplierId)) {
			modelMap.addAttribute("result", true);
		}else {
			modelMap.addAttribute("result", false);
		}
		return "jsonView";
	}
}
