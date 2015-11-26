package com.handpay.ibenefit.order.web;

import java.text.SimpleDateFormat;
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
import com.handpay.ibenefit.common.service.IGameCard;
import com.handpay.ibenefit.common.service.ISendSmsService;
import com.handpay.ibenefit.common.vo.OrderSendVO;
import com.handpay.ibenefit.common.vo.OrderSendVO.Card;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.CardCreInfoSubOrder;
import com.handpay.ibenefit.order.entity.ExceptionOrder;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ICardCreInfoSubOrderManager;
import com.handpay.ibenefit.order.service.IExceptionOrderManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.physical.entity.PhysicalSubscribe;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.virtualCardInfo.VirtualCardInfo;
import com.handpay.ibenefit.virtualCardInfo.service.IVirtualCardInfoManager;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;

@Controller
@RequestMapping("/exceptionOrder")
public class ExceptionOrderController extends PageController<ExceptionOrder> {

	private static final String BASE_DIR = "order/";

	@Reference(version = "1.0")
	private IExceptionOrderManager exceptionOrderManager;

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

	@Reference(version = "1.0",async=true)
	private ISendSmsService sendSmsService;

	@Reference(version = "1.0")
	private ICardCreateInfoManager cardCreateInfoManager;

	@Reference(version = "1.0")
	private ICardInfoManager cardInfoManager;
	
	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;
	
	@Reference(version = "1.0")
	private ICardCreInfoSubOrderManager cardCreInfoSubOrderManager;
	
	@Override
	public Manager<ExceptionOrder> getEntityManager() {

		return exceptionOrderManager;
	}

	@Override
	public String getFileBasePath() {

		return BASE_DIR;
	}

	/*
	 * 异常订单订单详情
	 */
	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		// 得到总订单和子订单信息
		ExceptionOrder exceptionOrder = new ExceptionOrder();
		exceptionOrder.setGeneralOrderId(objectId);
		List<ExceptionOrder> exceptionOrderList = exceptionOrderManager.getBySample(exceptionOrder);
		Order order = orderManager.getByObjectId(objectId);
		if (order != null) {
			if (order.getUserId() != null && order.getUserId() > 0) {
				// 格式化登录名
				User user = userManager.getByObjectId(order.getUserId());
				if (user != null) {
					String loginName = user.getLoginName();
					if (loginName.indexOf("@") != -1) {
						String preStart = loginName.substring(0,
								loginName.indexOf("@") + 1);
						String preEnd = loginName.substring(
								loginName.lastIndexOf("."), loginName.length());
						String prefix = loginName.substring(
								loginName.indexOf("@") + 1,
								loginName.lastIndexOf("."));
						StringBuffer sb = new StringBuffer();
						for (int i = 0; i < prefix.length(); i++) {
							sb = sb.append("*");
						}
						loginName = preStart + sb.toString() + preEnd;
					} else {
						loginName = loginName.substring(0,
								loginName.length() - 4);
						StringBuffer sb = new StringBuffer();
						for (int i = 0; i < 4; i++) {
							sb = sb.append("*");
						}
						loginName += sb.toString();
					}
					request.setAttribute("loginName", loginName);
				}
			} else {
				request.setAttribute("loginName", "游客");
			}
			// 得到商品关联表中商品信息和供应商的信息
			List<SubOrder> subOrders = subOrderManager.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
			Double alllActuallyAmount = 0.0;
			if (subOrders.size() > 0){
				for (SubOrder subOrder : subOrders) {
					// 得到实付金额和积分
					alllActuallyAmount += subOrder.getPayableAmount() == null ? 0
							:subOrder.getPayableAmount();					
				}
				
			}
			request.setAttribute("alllActuallyAmount", alllActuallyAmount);
			request.setAttribute("orderstu", order.getOrderStatus());
			request.setAttribute("order", order);
		}
		if (exceptionOrderList != null && exceptionOrderList.size()>0) {
			List<SubOrder> subOrders = new ArrayList<SubOrder>();
			for (ExceptionOrder eo : exceptionOrderList) {
				SubOrder subOrder = subOrderManager.getByObjectId(eo.getSubOrderId());
				// 得到商品关联表中商品信息和供应商的信息
				List<OrderSku> orderProducts = productOrderManager
						.getOrderProductBySubOrderId(subOrder.getObjectId());
				if (orderProducts.size() > 0) {
					subOrder.setOrderProductList(orderProducts);
				}
				Supplier suppliers = supplierManager.getByObjectId(subOrder
						.getSupplierId());
				if (suppliers != null) {
					subOrder.setSuppliers(suppliers);
				}
				subOrders.add(subOrder);
			}
			order.setSubOrderList(subOrders);
		}
		request.setAttribute("order", order);
		request.setAttribute("view", 1);
		return super.handleView(request, response, objectId);
		// return "jsonView";
	}

	/*
	 * 异常订单订单详情
	 */
	@RequestMapping(value = "/viewBySubOrder/{objectId}")
	protected String handleViewBySubOrder(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId) throws Exception {
		// 得到总订单和子订单信息
		SubOrder subOrder = subOrderManager.getByObjectId(objectId);
		Order order = orderManager.getByObjectId(subOrder.getGeneralOrderId());
		if (order != null) {
			if (order.getUserId() != null && order.getUserId() > 0) {
				// 格式化登录名
				User user = userManager.getByObjectId(order.getUserId());
				if (user != null) {
					String loginName = user.getLoginName();
					if (loginName.indexOf("@") != -1) {
						String preStart = loginName.substring(0,
								loginName.indexOf("@") + 1);
						String preEnd = loginName.substring(
								loginName.lastIndexOf("."), loginName.length());
						String prefix = loginName.substring(
								loginName.indexOf("@") + 1,
								loginName.lastIndexOf("."));
						StringBuffer sb = new StringBuffer();
						for (int i = 0; i < prefix.length(); i++) {
							sb = sb.append("*");
						}
						loginName = preStart + sb.toString() + preEnd;
					} else {
						loginName = loginName.substring(0,
								loginName.length() - 4);
						StringBuffer sb = new StringBuffer();
						for (int i = 0; i < 4; i++) {
							sb = sb.append("*");
						}
						loginName += sb.toString();
					}
					request.setAttribute("loginName", loginName);
				}
			} else {
				request.setAttribute("loginName", "游客");
			}
			// 得到商品关联表中商品信息和供应商的信息
			List<SubOrder> subOrders = subOrderManager.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
			Double alllActuallyAmount = 0.0;
			if (subOrders.size() > 0){
				for (SubOrder subO : subOrders) {
					// 得到实付金额和积分
					alllActuallyAmount += subO.getPayableAmount() == null ? 0
							:subO.getPayableAmount();					
				}
				
			}
			request.setAttribute("alllActuallyAmount", alllActuallyAmount);
			Double ActuallyAmount = 0.0;
			Double ActuallyIntegral = 0.0;
			// 得到实付金额和积分
			ActuallyAmount += subOrder.getActuallyAmount() == null ? 0
					: subOrder.getActuallyAmount();
			ActuallyIntegral += subOrder.getActuallyIntegral() == null ? 0
					: subOrder.getActuallyIntegral();

			List<OrderSku> orderProducts = productOrderManager
					.getOrderProductBySubOrderId(subOrder.getObjectId());
			if (orderProducts.size() > 0) {
				subOrder.setOrderProductList(orderProducts);
			}
			Supplier suppliers = supplierManager.getByObjectId(subOrder
					.getSupplierId());
			if (suppliers != null) {
				subOrder.setSuppliers(suppliers);
			}
			request.setAttribute("ActuallyAmount", ActuallyAmount);
			request.setAttribute("ActuallyIntegral", ActuallyIntegral);
			request.setAttribute("orderstu", order.getOrderStatus());
			request.setAttribute("order", order);
		}
		ExceptionOrder exceptionOrder = exceptionOrderManager.getBySubObjectId(objectId);
		List<SubOrder> subOrders = new ArrayList<SubOrder>();
		subOrders.add(subOrder);
		order.setSubOrderList(subOrders);
		// 得到商品关联表中商品信息和供应商的信息
		List<OrderSku> orderProducts = productOrderManager
				.getOrderProductBySubOrderId(subOrder.getObjectId());
		if (orderProducts.size() > 0) {
			subOrder.setOrderProductList(orderProducts);
		}
		Supplier suppliers = supplierManager.getByObjectId(subOrder.getSupplierId());
		if (suppliers != null) {
			subOrder.setSuppliers(suppliers);
		}
		request.setAttribute("exceptionOrder", exceptionOrder);
		request.setAttribute("subOrder", subOrder);
		request.setAttribute("view", 1);
		return super.handleView(request, response, objectId);
		// return "jsonView";
	}

	// 查看卡号信息

	@RequestMapping(value = "/productCard")
	public String productCard(HttpServletRequest request,Order t) {
		PageSearch page = preparePage(request);
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		return "/order/editProductCard";

	}


	/*
	 *
	 * 订单查询界面列表显示
	 */
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {

		PageSearch page1 = preparePage(request);
		PageSearch result = exceptionOrderManager.findExceptionOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listExceptionOrder";
	}

	@RequestMapping("/resetSend/{id}")
	public String resetSend(HttpServletRequest request,
			@PathVariable Long id, ModelMap modelMap) {
		ExceptionOrder exceptionOrder = exceptionOrderManager.getByObjectId(id);
		String key = exceptionOrder.getExceptionKey();
		String centent = exceptionOrder.getExceptionCentent();
		int status = exceptionOrder.getExceptionStatus();
		String reasonType = exceptionOrder.getExceptionReason();
		boolean ret = false;
		//第三方卡密短信发送失败
		if (IBSConstants.EXCEPTION_STATUS_SMS_ERROR==status) {
			ret = sendSmsService.send(key,centent);
		}
		//卡密生成失败电子凭证失败
		if (IBSConstants.EXCEPTION_REASON_CARDSEND==status) {

		}
		//生活服务充值失败
		if (IBSConstants.EXCEPTION_REASON_ADDCARD==status) {

		}
		modelMap.addAttribute("result", ret);
		return "jsonView";
	}

	/**
	 * 重新发送
	 * @param request
	 * @param ids
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/resetSends/{ids}")
	public String resetSends(HttpServletRequest request,
			@PathVariable String ids, ModelMap modelMap) {
		User user = (User) request.getSession().getAttribute(SecurityConstants.SESSION_USER);
		String[] arr = ids.split(",");
		boolean ret = false;
		List<String> msg = new ArrayList<String>();
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] != null && !("").equals(arr[i])) {
				Long id = Long.parseLong(arr[i]);
				ExceptionOrder exceptionOrder = exceptionOrderManager.getByObjectId(id);
//				String key = exceptionOrder.getExceptionKey();
//				String centent = exceptionOrder.getExceptionCentent();
				int status = exceptionOrder.getExceptionStatus();
				Order order = orderManager.getByObjectId(exceptionOrder.getGeneralOrderId());
				SubOrder subOrder = subOrderManager.getByObjectId(exceptionOrder.getSubOrderId());
				if (order == null) {
					msg.add("订单获取失败！");
					modelMap.addAttribute("msg", msg);
					return "jsonView";
				}
				//待发货状态
				if (subOrder.getSubOrderState()==IBSConstants.ORDER_TO_BE_SHIPPED) {
					//第三方卡密短信发送失败
					if (IBSConstants.EXCEPTION_STATUS_SMS_ERROR==status) {
						String m = exceptionOrderManager.gameCardSend(user, subOrder, order);
						msg.add(m);
					}
					//生活服务充值失败
					if (IBSConstants.EXCEPTION_STATUS_RECHARGE_ERROR==status) {
						subOrder.setOrderStatus(IBSConstants.ORDER_TO_BE_PAID);
						subOrderManager.save(subOrder);
						msg.add("退回积分失败！");
					}
					//卡密生成失败
					if (IBSConstants.EXCEPTION_STATUS_ELECTRONIC_DOCUMENT==status) {
						List<OrderSku> orderSkuList =  productOrderManager.getOrderProductBySubOrderId(subOrder.getObjectId());
						if (orderSkuList != null && orderSkuList.size()>0) {
							OrderSku orderSku = orderSkuList.get(0);
							String m = exceptionOrderManager.electronicDocument(user,subOrder, order,orderSku);
							msg.add(m);
						}
					}
				}else{
					msg.add("订单不可重新发送！");
				}
			}
		}
		modelMap.addAttribute("msg", msg);
		modelMap.addAttribute("result", ret);
		return "jsonView";
	}

	/**
	 * 已处理操作
	 * @param request
	 * @param ids
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/doChange/{ids}")
	public String doChange(HttpServletRequest request,
			@PathVariable String ids, ModelMap modelMap) {
		String[] arr = ids.split(",");
		boolean ret = false;
		List<String> msg = new ArrayList<String>();
		for (int i = 0; i < arr.length; i++) {
			if (arr[i] != null && !("").equals(arr[i])) {
				Long id = Long.parseLong(arr[i]);
				ExceptionOrder exceptionOrder = exceptionOrderManager.getByObjectId(id);
				int status = exceptionOrder.getExceptionStatus();
				if (IBSConstants.EXCEPTION_STATUS_PROCESSED!=status) {
					exceptionOrder.setExceptionStatus(IBSConstants.EXCEPTION_STATUS_PROCESSED);
					exceptionOrderManager.save(exceptionOrder);
					msg.add("信息处理成功！");
				}else {
					msg.add("该信息已处理！");
				}
			}
		}
		modelMap.addAttribute("msg", msg);
		modelMap.addAttribute("result", ret);
		return "jsonView";
	}

	/**
	 * 补发电子凭证
	 * @param request
	 * @param ids
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("/replacement/{objectId}/{productId}")
	public String replacement(HttpServletRequest request,
			@PathVariable Long objectId,@PathVariable Long productId, ModelMap modelMap) {
		User user = (User) request.getSession().getAttribute(SecurityConstants.SESSION_USER);
		boolean ret = false;
		String msg = "";
		ExceptionOrder exceptionOrder = exceptionOrderManager.getBySubObjectId(objectId);
		Order order = orderManager.getByObjectId(exceptionOrder.getGeneralOrderId());
		SubOrder subOrder = subOrderManager.getByObjectId(exceptionOrder.getSubOrderId());
		int status = exceptionOrder.getExceptionStatus();
//		String key = exceptionOrder.getExceptionKey();
//		String centent = exceptionOrder.getExceptionCentent();
		//第三方卡密发送失败
		if (IBSConstants.EXCEPTION_STATUS_SMS_ERROR==status) {
			msg = exceptionOrderManager.gameCardSend(user, subOrder, order);
		}
		//卡密生成失败
		if (IBSConstants.EXCEPTION_STATUS_ELECTRONIC_DOCUMENT==status) {
			OrderSku os = new OrderSku();
			os.setSubOrderId(objectId);
			os.setProductId(productId);
			List<OrderSku> orderSkuList =  productOrderManager.getBySample(os);
			if (orderSkuList != null && orderSkuList.size()>0) {
				OrderSku orderSku = orderSkuList.get(0);
				msg = exceptionOrderManager.electronicDocument(user,subOrder, order,orderSku);
			}

		}
		modelMap.addAttribute("result", ret);
		modelMap.addAttribute("msg", msg);
		return "jsonView";
	}
}
