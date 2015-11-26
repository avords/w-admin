package com.handpay.ibenefit.member.web;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierLiquidation;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierliquidationManager;

@Controller
@RequestMapping("/supplierLiquidation")
public class SupplierLiquidationController  extends PageController<SupplierLiquidation>{
private static final String BASE_DIR = "member/";
	
 	@Reference(version = "1.0")
	private ISupplierliquidationManager supplierliquidationManager;
 	
 	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	

	@Override
	public Manager<SupplierLiquidation> getEntityManager() {
		return supplierliquidationManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		// TODO Auto-generated method stub
		return super.handlePage(request, page);
	}
	
	/*
		  * <p>Title: handleEdit</p>
		  * <p>Description: </p>
		  * @param request
		  * @param response
		  * @param objectId
		  * @return
		  * @throws Exception
		  * @see com.handpay.ibenefit.framework.web.BaseController#handleEdit(javax.servlet.http.HttpServletRequest, javax.servlet.http.HttpServletResponse, java.lang.Long)
		  */
		
		
		@Override
		protected String handleEdit(HttpServletRequest request,
				HttpServletResponse response, Long objectId) throws Exception {
			if (null != objectId) {
				SupplierLiquidation entity=supplierliquidationManager.getBySupplierId(objectId);
				request.setAttribute("liquid", entity);
			}
			return "redirect:/supplier/edit/" + objectId + getMessage("保存成功", request);
		}
	/*
		  * <p>Title: handleSave</p>
		  * <p>Description: </p>
		  * @param request
		  * @param modelMap
		  * @param t
		  * @return
		  * @throws Exception
		  * @see com.handpay.ibenefit.framework.web.BaseController#handleSave(javax.servlet.http.HttpServletRequest, org.springframework.ui.ModelMap, java.lang.Object)
		  */
		
		
		@Override
		protected String handleSave(HttpServletRequest request, ModelMap modelMap,
				SupplierLiquidation t) throws Exception {
			String supplierId=request.getParameter("supplierIDL");
			if (StringUtils.isNotBlank(supplierId)) {
				Supplier supplier = supplierManager.getByObjectId(Long.parseLong(supplierId));
				if (supplier!=null) {
					supplier.setStatus(IBSConstants.VERIFY_STATUS_DRAFT);
					String cooperations=request.getParameter("cooperations1");
					if (StringUtils.isNotBlank(cooperations)) {
						if (cooperations.equals("1")) {//平台自有
							supplier.setCooperations(1);
							supplier.setLiquidationName(t.getLiquidationName1());
							supplier.setLiquidationNum(t.getLiquidationNum1());
							supplier.setBank(t.getBank1());
							supplier.setBankAddress(t.getBankAddress1());
							supplier.setLinker(t.getLinker1());
							supplier.setLinkEmail(t.getLinkEmail1());
							supplier.setLinkTelephone(t.getLinkTelephone1());
							supplier.setMoneyTerm(t.getMoneyTerm1());
							supplier.setRealDay(t.getRealDay1());
							supplier.setRealWeek(t.getRealWeek1());
							supplier.setGuaranteeMoney(t.getGuaranteeMoney1());
							supplier.setGuaranteeMoneyStart(t.getGuaranteeMoneyStart1());
							supplier.setGuaranteeMoneyEnd(t.getGuaranteeMoneyEnd1());
							supplier.setAccountManager(t.getAccountManager1());
							supplier.setMobilephone(t.getMobilephone1());
						}else if (cooperations.equals("2")) {//企业自有
							supplier.setCooperations(2);
							supplier.setLiquidationName(null);
							supplier.setLiquidationNum(null);
							supplier.setBank(null);
							supplier.setBankAddress(null);
							supplier.setLinker(null);
							supplier.setLinkEmail(null);
							supplier.setLinkTelephone(null);
							supplier.setMoneyTerm(null);
							supplier.setRealDay(null);
							supplier.setRealWeek(null);
							supplier.setGuaranteeMoney(null);
							supplier.setGuaranteeMoneyStart(null);
							supplier.setGuaranteeMoneyEnd(null);
							supplier.setAccountManager(null);
							supplier.setMobilephone(null);
						}
						supplierManager.save(supplier);
						modelMap.addAttribute("result",true);
					}
				}
			}
			return "jsonView";
		}
}
