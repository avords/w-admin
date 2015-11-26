package com.handpay.ibenefit.order.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.handpay.ibenefit.order.entity.ChangeOrder;
import com.handpay.ibenefit.order.entity.ChangeOrderExpla;
import com.handpay.ibenefit.order.entity.ChangeOrderSku;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IChangeOrderExplaManager;
import com.handpay.ibenefit.order.service.IChangeOrderManager;
import com.handpay.ibenefit.order.service.IChangeOrderSkuManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWpRelationManager;

@Controller
@RequestMapping("/vendorChangeOrder")
public class VendorChangeOrderController extends PageController<ChangeOrder> {

	private static final String BASE_DIR = "order/";

	@Reference(version = "1.0")
	private IChangeOrderManager changeOrderManager;

	@Reference(version = "1.0")
	private IOrderManager orderManager;

	@Reference(version = "1.0")
	private IOrderProductManager productOrderManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IOrderProductManager orderProductManager;

	@Reference(version = "1.0")
	private ICardInfoManager cardInfoManager;

	@Reference(version = "1.0")
	private IWpRelationManager wpRelationManager;

	@Reference(version = "1.0")
	private ICardCreateInfoManager cardCreateInfoManager;

	@Reference(version = "1.0")
	private IChangeOrderExplaManager changeOrderExplaManager;

	@Reference(version = "1.0")
	private IChangeOrderSkuManager changeOrderSkuManager;

	@Reference(version = "1.0")
	private ISkuManager skuManager;

	@Reference(version = "1.0")
	private ISkuPublishManager skuPublishManager;

	@Override
	public Manager<ChangeOrder> getEntityManager() {
		return changeOrderManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	/*
	 * 订单详情
	 */
	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		// 得到总订单和子订单信息
		Order order = orderManager.getByObjectId(objectId);
		List<SubOrder> subOrders = subOrderManager
				.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
		order.setSubOrderList(subOrders);
		// 得到商品关联表中商品信息和供应商的信息
		for (SubOrder subOrder : subOrders) {
			Long obid = subOrder.getObjectId();
			List<OrderSku> orderProducts = productOrderManager
					.getOrderProductBySubOrderId(subOrder.getObjectId());
			if (orderProducts.size() > 0) {
				subOrder.setOrderProductList(orderProducts);
			}
			Long obid2 = subOrder.getSupplierId();
			Supplier suppliers = supplierManager.getByObjectId(subOrder
					.getSupplierId());
			if (suppliers != null) {
				subOrder.setSuppliers(suppliers);
			}
		}
		request.setAttribute("order", order);
		request.setAttribute("view", 1);
		return super.handleView(request, response, objectId);
		// return "jsonView";
	}

	/*
	 *
	 * 订单查询界面列表显示
	 */
	@Override
    @RequestMapping(value = "/list")
	protected String handlePage(HttpServletRequest request,PageSearch page) {
		// 得到根据总订单id得到子订单编号
		String platform = request.getParameter("search_EQI_changeOrderStatusType");
		PageSearch page1 = preparePage(request);
		PageSearch result = changeOrderManager.findReturnOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		request.setAttribute("platform", platform);
		return getFileBasePath() + "listVendorChangeOrder";
	}

	//退货单详情
	@RequestMapping(value = "/return/{objectId}")
   public String  returnDetails(HttpServletRequest request,
			HttpServletResponse response,@PathVariable Long objectId){
		if(objectId!=null){
			ChangeOrder changeOrder=changeOrderManager.getByObjectId(objectId);
			if(changeOrder!=null){
				User user=userManager.getByObjectId(changeOrder.getUserId());
				List<ChangeOrderExpla> changeOrderExplas = changeOrderExplaManager
						.getByChangerId(changeOrder.getObjectId());
				List<ChangeOrderSku> changeOrderSkus = changeOrderSkuManager
						.getCOSkuByCId(changeOrder.getObjectId());
				SubOrder subOrder = subOrderManager
						.getSubOrderBySubOrderId(changeOrder.getSubOrderId());
				if(subOrder!=null){
					Order order = orderManager.getOrderByOrderId(subOrder
							.getGeneralOrderId());
				Supplier supplier = supplierManager.getByObjectId(subOrder
							.getSupplierId());
					request.setAttribute("order", order);
					request.setAttribute("supplier", supplier);
				}
			 request.setAttribute("subOrder", subOrder);
			 request.setAttribute("changeOrderExplas", changeOrderExplas);
			 request.setAttribute("changeOrderSkus", changeOrderSkus);
			 request.setAttribute("user", user);
			}
			request.setAttribute("changeOrder", changeOrder);
		}
	 return "order/returnVendorDetailsOrder";
	}

	@Override
    protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}

	/**
	 * 同意退换
	 * @param request
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/addSupplier/{objectId}")
	protected String addSupplier(HttpServletRequest request,@PathVariable Long objectId) {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_AGREE);
		}
		return "order/editAddSupplier";
	}

	/**
	 * 拒绝退换
	 * @param request
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/refuse/{objectId}")
	protected String refuse(HttpServletRequest request,@PathVariable Long objectId) {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_TYPE_INBOUND);
		}
		return "order/editRefuse";
	}

	/**
	 * 确认收货
	 * @param request
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/confirmReceipt/{objectId}")
	protected String confirmReceipt(HttpServletRequest request,@PathVariable Long objectId) {
		if (null != objectId) {
			ChangeOrder entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			if(entity.getChangeType().equals(IBSConstants.ORDER_PRODUCT_RETURN)){
				request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_REFUNDED);
			}else{
				request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_RECEIVED);
			}
		}
		return "order/editConfirReceipt";
	}

	/**
	 * 拒绝收货
	 * @param request
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/refuseReceipt/{objectId}")
	protected String refuseReceipt(HttpServletRequest request,@PathVariable Long objectId) {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_TYPE_INBOUND);
		}
		return "order/editRefuse";
	}

	/**
	 * 确认发货
	 * @param request
	 * @param objectId
	 * @return
	 */
	@RequestMapping(value = "/confirmShipped/{objectId}")
	protected String confirmShipped(HttpServletRequest request,@PathVariable Long objectId) {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
			request.setAttribute("orderStatus", IBSConstants.CHANGE_ORDER_SHIPPED);
		}
		return "redirect:/vendorChangeOrder/save";
	}

	// 保存信息
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			ChangeOrder t) throws Exception {
		//如果是确认收货
		if (t.getOrderStatus() != null) {
			if (t.getOrderStatus().equals(IBSConstants.CHANGE_ORDER_RECEIVED)) {
				String hasContiue = request.getParameter("hasContiue");
				int hasContiueInt = Integer.valueOf(hasContiue);
				//是否可继续销售，可以就产品库存+1
				Long coObjectId = t.getObjectId();
				if (hasContiueInt==IBSConstants.CHANGE_ORDER_CONTINUE_SELL) {
					List<ChangeOrderSku> changeOrderSkuList = changeOrderSkuManager.getCOSkuByCId(coObjectId);
					if (changeOrderSkuList != null && changeOrderSkuList.size()>0) {
						for (ChangeOrderSku changeOrderSku : changeOrderSkuList) {
							Map<String,Object> map = new HashMap<String,Object>();
							map.put("addStock", 1);
							map.put("objectId", changeOrderSku.getSkuId());
							//更改临时表库存和更改正式表库存
							skuManager.updateSku(map);
						}
					}
				}
			}
			/*if (t.getOrderStatus().equals(IBSConstants.CHANGE_ORDER_SHIPPED)) {
				Long logisticsCompany = t.getLogisticsCompany();
				String logisticsNO = t.getLogisticsNo();
				Long subOrderId = t.getSubOrderId();
				SubOrder subOrder = subOrderManager.getByObjectId(subOrderId);
				subOrder.setLogisticsCompany(logisticsCompany);
				subOrder.setLogisticsNo(logisticsNO);
				subOrderManager.save(subOrder);
			}*/
		}

		t = changeOrderManager.save(t);
		return "redirect:/vendorChangeOrder/return/"+t.getObjectId();

	}
}
