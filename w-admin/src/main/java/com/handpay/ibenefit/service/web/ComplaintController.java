/**
 * @Title: ComplaintController.java
 * @Package com.handpay.ibenefit.service.web
 * @Description: TODO
 * Copyright: Copyright (c) 2011 
 * 
 * @author Mac.Yoon
 * @date 2015-6-25 下午3:04:16
 * @version V1.0
 */

package com.handpay.ibenefit.service.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.service.IOrderSkuManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.supplier.entity.Complaint;
import com.handpay.ibenefit.supplier.entity.ComplaintDetail;
import com.handpay.ibenefit.supplier.entity.ComplaintDetailUserVO;
import com.handpay.ibenefit.supplier.service.IComplaintDetailManager;
import com.handpay.ibenefit.supplier.service.IComplaintManager;
/**
 * @ClassName: ComplaintController
 * @Description: TODO
 * @author Mac.Yoon
 * @date 2015-6-25 下午3:04:16
 * 
 */
@Controller
@RequestMapping("complaint")
public class ComplaintController extends PageController<Complaint> {

	@Reference(version = "1.0")
	private IComplaintManager complaintManager;

	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IComplaintDetailManager complaintDetailManager;
	
	@Reference(version="1.0")
	private IOrderSkuManager orderSkuManager;
	

	@Override
	public Manager<Complaint> getEntityManager() {
		return complaintManager;
	}

	@Override
	public String getFileBasePath() {
		return "service/";
	}

	@RequestMapping(value = "/followUp")
	public String followUp(HttpServletRequest request,
			ComplaintDetail complaintDetail, String closed) {
		try {
			Long userId = (Long) request.getSession().getAttribute(SecurityConstants.USER_ID);
			complaintDetail.setDealPersonid(userId);
			// 设置 投诉订单状态
			Complaint complaint = new Complaint();
			complaint.setObjectId(complaintDetail.getComplaintId());
			if (closed != null) {
				complaint.setDealStatus(IBSConstants.COMPLAINT_STATUS_CLOSE);
			} else {
				complaint.setDealStatus(IBSConstants.COMPLAINT_STATUS_DISPOSE);
			}
			complaintManager.save(complaint);
			complaintDetail.setDealTime(new Date());
			complaintDetail.setDealPersonid(userId);
			complaintDetailManager.save(complaintDetail);
		} catch (Exception e) {
			e.printStackTrace();
			return "redirect:page" + getMessage("系统异常", request);
		}
		return "redirect:page" + getMessage("提交成功", request);
	}
	
	

	@Override
	protected String handleSaveToPage(HttpServletRequest request,
			ModelMap modelMap, Complaint t) throws Exception {
		Long userId = (Long) request.getSession().getAttribute(SecurityConstants.USER_ID);
		t.setDealStatus(IBSConstants.COMPLAINT_STATUS_OPEN);
		Supplier supplier = supplierManager.getByObjectId(t.getSupplierId());
		if(supplier != null){
			t.setSupplierContact(supplier.getContractNo());
			t.setSupplierName(supplier.getSupplierName());	
		}
		t.setRecordDate(new Date());
		t.setRecordPersonid(userId);
		complaintManager.save(t);
		return "redirect:page" + getMessage("common.base.success", request);
	}

	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		if (null != objectId) {
			Complaint entity = complaintManager.getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		return getFileBasePath() + "editComplaint";
	}

	@RequestMapping(value = "/complaintDetail/{objectId}")
	public String complaintDetailPage(HttpServletRequest request,
			@PathVariable Long objectId) {
		try {
			List<ComplaintDetailUserVO> ComplaintDetailUserVOes = new ArrayList<ComplaintDetailUserVO>();// 投诉跟进详细
			// 投诉信息详细信息
			Complaint complaint = complaintManager.selectComplaintUser(objectId);
			// 订单 关联商品 信息
			if (complaint != null) {
				request.setAttribute("complaintId", objectId);
				request.setAttribute("orderId", complaint);
				request.setAttribute("complaint", complaint);
				
				OrderSku orderSku = new OrderSku();
				orderSku.setSubOrderId(complaint.getOrderId());
				List<OrderSku> orderSkus = orderSkuManager.getBySample(orderSku);
				request.setAttribute("orderSkus", orderSkus);
				// 跟进信息列表
				ComplaintDetail complaintDetail = new ComplaintDetail();
				complaintDetail.setComplaintId(complaint.getObjectId());
				ComplaintDetailUserVOes = complaintDetailManager.findComplaintDetailUser(complaintDetail);
			}
			
			request.setAttribute("ComplaintDetailUserVOes",
					ComplaintDetailUserVOes);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "service/complaintDetail";
	}

	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		
		PageSearch page1 = preparePage(request);
		PageSearch result = complaintManager.queryComplaintInfo(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "service/listComplaint";
	}

}
