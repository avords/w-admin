package com.handpay.ibenefit.order.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.common.service.IGameCard;
import com.handpay.ibenefit.common.service.IMobileRecharge;
import com.handpay.ibenefit.common.service.ISendSmsService;
import com.handpay.ibenefit.common.service.alipay.IAlipayService;
import com.handpay.ibenefit.common.vo.OrderSendVO;
import com.handpay.ibenefit.common.vo.OrderSendVO.Card;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.FreemarkerUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.CardCreInfoSubOrder;
import com.handpay.ibenefit.order.entity.ChangeOrder;
import com.handpay.ibenefit.order.entity.ExceptionOrder;
import com.handpay.ibenefit.order.entity.LogisticsCompany;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderChaAddr;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.entity.SubOrderTimeInfo;
import com.handpay.ibenefit.order.service.ICardCreInfoSubOrderManager;
import com.handpay.ibenefit.order.service.IExceptionOrderManager;
import com.handpay.ibenefit.order.service.ILifeServiceLogManager;
import com.handpay.ibenefit.order.service.ILogisticsCompanyManager;
import com.handpay.ibenefit.order.service.IOrderChaAddrManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.IOrderSkuManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.order.service.ISubOrderTimeInfoManager;
import com.handpay.ibenefit.other.entity.MessageTemplate;
import com.handpay.ibenefit.other.service.IMessageTemplateManager;
import com.handpay.ibenefit.physical.entity.PhysicalSubscribe;
import com.handpay.ibenefit.physical.service.IPhysicalSubscribeManager;
import com.handpay.ibenefit.product.entity.ElectronicCard;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.IElectronicCardManager;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IPointOperateManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.security.service.OperationType;
import com.handpay.ibenefit.virtualCardInfo.VirtualCardInfo;
import com.handpay.ibenefit.virtualCardInfo.service.IVirtualCardInfoManager;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWpRelationManager;

/**
 * @desc 订单管理-订单查询&订单详情&线下付款订单
 * @author huyuanyuan
 * @date
 */
@Controller
@RequestMapping("/order")
public class OrderController extends PageController<Order> {

	Logger logger = Logger.getLogger(OrderController.class);

	private static final String BASE_DIR = "order/";

	@Reference(version = "1.0")
	private IOrderManager orderManager;

	@Reference(version = "1.0")
	private IPointOperateManager pointOperateManager;

	@Reference(version = "1.0",timeout=360000000)
	private ICardCreateInfoManager cardCreateInfoManager;

	@Reference(version = "1.0")
	private IProductManager productManager;

	@Reference(version = "1.0", check = false)
	private ISkuPublishManager skuPublishManager;

	@Reference(version = "1.0")
	private IAlipayService alipayServiceImpl;

	@Reference(version = "1.0")
	private IWpRelationManager wpRelationManager;

	@Reference(version = "1.0")
	private IOrderProductManager productOrderManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private ISkuManager skuManager;

	@Reference(version = "1.0")
	private IOrderChaAddrManager orderChaAddrManager;

	@Reference(version = "1.0")
	private ICardCreInfoSubOrderManager cardCreInfoSubOrderManager;

	@Reference(version = "1.0")
	private ILogisticsCompanyManager  logisticsCompanyManager;

	@Reference(version = "1.0")
	private ISubOrderTimeInfoManager subOrderTimeInfoManager ;

	@Reference(version = "1.0")
	private IOrderSkuManager orderSkuManager;

	@Reference(version = "1.0")
	private IExceptionOrderManager exceptionOrderManager;

	@Reference(version = "1.0")
	private IVirtualCardInfoManager virtualCardInfoManager;

	@Reference(version = "1.0",async=true)
	private IGameCard gameCard;

	@Reference (version="1.0",async=true)
	private IMobileRecharge mobileRecharge;

	@Reference(version = "1.0")
	private IPhysicalSubscribeManager physicalSubscribeManager;
	@Reference (version="1.0",async=true)
	private IGameCard gameCardService;
	@Reference (version="1.0")
	private ILifeServiceLogManager lifeServiceLogManager;
	@Reference(version = "1.0")
	private ICardInfoManager cardInfoManager;
	@Reference(version = "1.0")
	private IMessageTemplateManager messageTemplateManager;
	@Reference(version = "1.0",async=true)
	private ISendSmsService sendSmsService;
	@Reference(version = "1.0")
	private IElectronicCardManager electronicCardManager;


	@Override
	public Manager<Order> getEntityManager() {

		return orderManager;
	}

	@Override
	public String getFileBasePath() {

		return BASE_DIR;
	}

	/**
	 * 跳转到新建订单页面
	 *
	 */
	@RequestMapping(value = "/createNewOrder")
	public String createNewOrder(HttpServletRequest request,
			HttpServletResponse response) {
		return getFileBasePath() + "editNewOrder";

	}

	/**
	 * 点击总订单和子订单编号到订单详情页面
	 *
	 * @throws IOException
	 *
	 */
	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		// 得到总订单和子订单信息
		Order order = orderManager.getByObjectId(objectId);
		if (order != null) {
			if (order.getUserId() != null && !order.getUserId().toString().startsWith("-")) {
				User user = userManager.getByObjectId(order.getUserId());
				if (user != null) {
					String loginName = user.getLoginName();
					if (loginName.indexOf("@") != -1) {
						String preStart = loginName.substring(0,loginName.indexOf("@") + 1);
						String preEnd = loginName.substring(loginName.lastIndexOf("."), loginName.length());
						String prefix = loginName.substring(loginName.indexOf("@") + 1,loginName.lastIndexOf("."));
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
			}else {
				request.setAttribute("loginName", order.getUserName());
			}
			List<SubOrder> subOrders = subOrderManager.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
			for(SubOrder subOrder : subOrders){
				LogisticsCompany  logisticsCompany =logisticsCompanyManager.getByObjectId(subOrder.getLogisticsCompany());
				if(logisticsCompany!=null){
				 subOrder.setCompanyName(logisticsCompany.getCompanyName());
				}
			}
			order.setSubOrderList(subOrders);
			// 得到商品关联表中商品信息和供应商的信息
			Double alllActuallyAmount = 0.0;
			if (subOrders.size() > 0){
				for (SubOrder subOrder : subOrders) {
					Long productId=0L;
					// 得到实付金额和积分
					alllActuallyAmount += subOrder.getPayableAmount() == null ? 0
							:subOrder.getPayableAmount();
					List<OrderSku> orderProducts = productOrderManager
							.getOrderProductBySubOrderId(subOrder.getObjectId());
					if (orderProducts.size() > 0){
						subOrder.setOrderProductList(orderProducts);
						productId=orderProducts.get(0).getProductId();
					 }
					Supplier suppliers = supplierManager.getByObjectId(subOrder.getSupplierId());
					if (suppliers != null) {
					 	subOrder.setSuppliers(suppliers);
					 }
				    //根据子订单号得到体检预约套餐数据start
					PhysicalSubscribe physicalSubscribe=new PhysicalSubscribe();
					physicalSubscribe.setOrderId(subOrder.getObjectId());
					List<PhysicalSubscribe> listPhysical=physicalSubscribeManager.getBySample(physicalSubscribe);
					if(listPhysical.size()>0){
						request.setAttribute("packageId", listPhysical.get(0).getPackageId());
						request.setAttribute("upPackageId", listPhysical.get(0).getUpPackageId());
						request.setAttribute("addPackageId", listPhysical.get(0).getAddPackageId());
					}else{
						request.setAttribute("packageId",productId);
					}
					//根据子订单号得到体检套餐数据end
				}
				request.setAttribute("alllActuallyAmount", alllActuallyAmount);

			}
			request.setAttribute("orderstu", order.getOrderStatus());
			request.setAttribute("order", order);
			request.setAttribute("view", 1);
		}

		return super.handleView(request, response, objectId);

	}

	/**
	 * 若商品为电子兑换券点击查看到卡密界面
	 *
	 * @throws IOException
	 *
	 */

	@RequestMapping(value = "/cardInfo")
	public String cardInfo(HttpServletRequest request, ChangeOrder t,
			Integer backPage) throws Exception {
		// productId套餐的id
		Long productId = Long.parseLong(request.getParameter("productId"));
		Long subOrderId = Long.parseLong(request.getParameter("subOrderId"));
		if (productId != null && subOrderId != null) {
			OrderSku orderSku = productOrderManager.getByProduct(productId,subOrderId);
			Long productCount = orderSku.getProductCount();
			//
			CardCreInfoSubOrder cardCreInfoSubOrder =new CardCreInfoSubOrder();
			cardCreInfoSubOrder.setSubOrderId(subOrderId);
			List<CardCreInfoSubOrder>  cardObjectId =cardCreInfoSubOrderManager.getBySample(cardCreInfoSubOrder);
			if(cardObjectId.size()>0){
			CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(cardObjectId.get(0).getCardCreateId());
			if(cardCreateInfo!=null){
			String createInfoId = cardCreateInfo.getObjectId().toString();
			return "redirect:/cardInfo/orderCard?createInfoId=" + createInfoId
					+ "&subOrderId=" + subOrderId + "&productCount="
					+ productCount + "&productId=" + productId + "&ajax=1";
		  }else{
			  return "redirect:/cardInfo/orderCard?createInfoId=" + 1
						+ "&subOrderId=" + 1 + "&productCount="
						+ 1 + "&productId=" + 1 + "&ajax=1";
		  }
		}
		}
		return "redirect:/cardInfo/orderCard?createInfoId=" + 1
				+ "&subOrderId=" + 1 + "&productCount="
				+ 1 + "&productId=" + 1 + "&ajax=1";
	}

	/*
	 *
	 * 订单查询 列表页面(重写父类的page)
	 */
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {

		PageSearch page1 = preparePage(request);
		PageSearch result = orderManager.findOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listOrder";
	}



	/**
	 * 点击更新为已付款弹出窗口
	 *
	 */
	@RequestMapping("/underLinePay/{objectId}")
	public String underLinePay(HttpServletRequest request,@PathVariable Long objectId){
		//查出总订单下面所有的子订单（除了已经支付和取消的订单）
  		if(objectId!=null){
		  SubOrder	subOrder=subOrderManager.getByObjectId(objectId);
		  if(subOrder!=null){
			 Order order=orderManager.getByObjectId(subOrder.getGeneralOrderId());
			 request.setAttribute("order", order);
		     request.setAttribute("allPayableMount",subOrder.getPayableAmount());
		     request.setAttribute("subOrderNos",subOrder.getSubOrderNo());
		     request.setAttribute("subOrder",subOrder);
		  }
		}
		return "order/editLinePayOrder";
	}

	/**
	 * 支付核对页面点击提交
	 *
	 */
	@RequestMapping("/updateToPage")
	public String updateToPage(HttpServletRequest request, ModelMap modelMap) {
		Long payUserId = FrameworkContextUtils.getCurrentUserId();
		String paymentAmount=request.getParameter("paymentAmount");
		String orderId=request.getParameter("orderId");
		   //修改订单状态和付款时间等的信息
			if (orderId != null && !("").equals(orderId)) {
				SubOrder subOrder=subOrderManager.getByObjectId(Long.parseLong(orderId));
				//校验订单是否已经付款
				if(subOrder!=null && subOrder.getSubOrderState()!=IBSConstants.ORDER_TO_BE_PAID){
					modelMap.addAttribute("result", false);
					modelMap.addAttribute("resultReason", "该订单已经付款，不能再更新为已付款");
					return "jsonView";
				}
			    if(subOrder!=null){
			    	/*if(Float.parseFloat(paymentAmount)!=Double.parseFloat(subOrder.getPayableAmount())){
			    		modelMap.addAttribute("result", false);
						modelMap.addAttribute("resultReason", "应付金额和实付金额不一致！");
						return "jsonView";
			         }
			         */
			      Order	order=orderManager.getByObjectId(subOrder.getGeneralOrderId());
			      orderManager.updateOrderToPaid(order, subOrder,payUserId);

			    }
		  }
		modelMap.addAttribute("result", true);
		return "jsonView";
	}





	/**
	  * sendMessage(员工端或官网购买成功发送卡密短息)
	  * @Description: TODO
	  * @param @param order    设定文件
	  * @return void    返回类型
	  * @throws
	  */
	private void sendMessage(Order order,Long cardCreateInfoId,Long OTOCard,SubOrder subOrder) {
		 SimpleDateFormat sdf  = new SimpleDateFormat("yyyy年MM月dd日");
		 if(cardCreateInfoId!=null && cardCreateInfoId!=0L){
			MessageTemplate messageTemplate = messageTemplateManager.getTemplateByCode(IBSConstants.SMS_MOBILE_CREATE_ORDER_CARD);
			 Map<String, Object> model = new HashMap<String, Object>();
			 CardInfo cardInfo = new CardInfo();
			 cardInfo.setCreateInfoId(cardCreateInfoId);
			 StringBuffer cardContent = new StringBuffer("");
			 CardCreateInfo createInfo=cardCreateInfoManager.getByObjectId(cardCreateInfoId);
			 List<CardInfo> cardInfoList=cardInfoManager.getBySample(cardInfo);
		    if(cardInfoList!=null && cardInfoList.size()>0 && createInfo!=null){
			  try {
				 for(CardInfo card:cardInfoList){
					cardContent.append(",");
					cardContent.append("卡号");
					cardContent.append(card.getCardNo()) ;
					cardContent.append(", 密码") ;
					cardContent.append(card.getPassWord()) ;
				 }
				model.put("subOrderNo", subOrder.getSubOrderNo());
				model.put("cardContent", cardContent.substring(1).toString()) ;//截取第一位逗号
				model.put("date", sdf.format(createInfo.getEndDate()));
				String cotent = FreemarkerUtils.parseTemplate(messageTemplate.getMessageContent(), model);
				sendSmsService.send(order.getReceiptMoblie().toString(),cotent);

				} catch (Exception e) {
					e.printStackTrace();
			}
		}
	  }else if(OTOCard!=null && OTOCard!=0L){
		  MessageTemplate messageTemplate = messageTemplateManager.getTemplateByCode(IBSConstants.SMS_THIRD_OTO_ELECTRONIC);
		  OrderSku orderSku=new OrderSku();
		  orderSku.setSubOrderId(subOrder.getObjectId());
		  List<OrderSku> list=orderSkuManager.getBySample(orderSku);
		  if(list.size()>0){
		    Map<String, Object> model = new HashMap<String, Object>();
		    StringBuffer cardContent = new StringBuffer("");
		    List<ElectronicCard> electronicCards=electronicCardManager.getCardByCount(list.get(0).getProductCount(),list.get(0).getProductId());
		    try{
		    for(ElectronicCard eleCard:electronicCards){
		    	CardCreInfoSubOrder cardCreInfoSubOrder = new CardCreInfoSubOrder();
				 cardCreInfoSubOrder.setSubOrderId(subOrder.getObjectId());
				 cardCreInfoSubOrder.setCardCreateId(eleCard.getObjectId());
				 cardCreInfoSubOrder.setType(Long.valueOf(IBSConstants.PRODUCT_STOCK_SOURCE_THIRD_OTO));
				 cardCreInfoSubOrderManager.save(cardCreInfoSubOrder);

				 cardContent.append("卡号");
				 cardContent.append(eleCard.getCardNo()) ;
				 cardContent.append(", 密码");
				 cardContent.append(eleCard.getCardPassword()) ;
				//修改OTO卡状态
				eleCard.setStatus(IBSConstants.CARD_USED);
				electronicCardManager.save(eleCard);
			 }
			 model.put("subOrderNo", subOrder.getSubOrderNo());
			 model.put("cardContent", cardContent.substring(1).toString()) ;//截取第一位逗号
			 String cotent = FreemarkerUtils.parseTemplate(messageTemplate.getMessageContent(), model);
			 sendSmsService.send(order.getReceiptMoblie().toString(),cotent);
		    } catch (Exception e){
				e.printStackTrace();
		   }
		 }
	  }
	}



	private void insertVirtualCard(OrderSendVO orderSendVO, User user,
			SubOrder subOrder, Order order, String settleDate) {
		try{
		if (orderSendVO != null && orderSendVO.getCards() != null) {
			for (Card card : orderSendVO.getCards()) {
				VirtualCardInfo virtualCardInfo = new VirtualCardInfo();
				virtualCardInfo.setCardNo(card.getCardNo());
				virtualCardInfo.setCardPassword(card.getCardPws());
				virtualCardInfo.setCreateDate(new Date());
				if (user != null) {
					virtualCardInfo.setCreateUser(user.getUserName());
					virtualCardInfo.setCreateUserId(user.getObjectId());
				}
				virtualCardInfo.setGameId(orderSendVO.getGameId());
				virtualCardInfo.setNum(Long.valueOf(1));
				virtualCardInfo.setPhone(order.getReceiptMoblie());
				virtualCardInfo.setSubOrderId(subOrder.getObjectId());
				virtualCardInfo.setSubOrderNo(subOrder.getSubOrderNo());
				virtualCardInfo.setSettleDate(settleDate);
				virtualCardInfo.setHyOrderId(orderSendVO.getHyOrderId());
				SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");
				virtualCardInfo.setExpireDate(sdf.parse(card.getExpireDate()));
				virtualCardInfoManager.save(virtualCardInfo);
			}
		}
		}catch (Exception e) {
			e.printStackTrace();
		}

	}


	/**
	 * 点击商品编号跳转商品详情页面
	 *
	 *
	 */
	@RequestMapping("/productDetails")
	public String productDetails(HttpServletRequest request) {
		if (request.getParameter("objectId") != null
				&& request.getParameter("productId") != null) {
			Long objectId = Long.parseLong(request.getParameter("objectId"));
			Long skuId = Long.parseLong(request.getParameter("productId"));
			SkuPublish sku = skuPublishManager.getByObjectId(skuId);
			Long productid = sku.getProductId();
			request.getSession().setAttribute("action",
					"/order/view/" + objectId);
			return "redirect:/product/view/" + productid;
		}
		return null;
	}

	/*
	 * @desc 客服管理-订单更改服务
	 *
	 * @author huyuanyuan
	 */
	@RequestMapping("/orderChange")
	protected String orderChange(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		page1.getFilters().add(new PropertyFilter(Order.class.getName(), "EQL_orderStatus", String.valueOf(IBSConstants.ORDER_PAID)));
		PageSearch result = orderManager.getConsumerOrderChange(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "service/listServiceOrderChange";
	}

	/**
	 * 更改订单服务-更改页面
	 *
	 * @author huyuanyuan
	 *
	 *
	 */
	@RequestMapping("/changeOrderAddress/{objectId}")
	public String editChangeOrder(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		Order order = orderManager.getByObjectId(objectId);

		//OrderChaAddr chanAddr = new OrderChaAddr();
		//chanAddr.setOrderId(order.getObjectId());
		//List<OrderChaAddr> chanAddrlist = orderChaAddrManager.getBySample(chanAddr);
		//Date a = null;
		//if(null!=chanAddrlist && chanAddrlist.size() > 0){
		//	for(OrderChaAddr temp: chanAddrlist){
			//	if(a == null){
			//		a = temp.getChangeTime();
			//		order.setReceiptAddress(temp.getFinalreceiptAddress());
			//		order.setReceiptContacts(temp.getFinalReceiptContacts());
			//		order.setReceiptMoblie(Long.parseLong(temp.getFinalReceiptTelephone()));
			//		order.setReceiptZipcode(temp.getFinalreceiptZipcode());
			//	}else{
				//	if(a.compareTo(temp.getChangeTime()) > 0){
				//		a = temp.getChangeTime();
				//		order.setReceiptAddress(temp.getFinalreceiptAddress());
				//		order.setReceiptContacts(temp.getFinalReceiptContacts());
				//		order.setReceiptMoblie(Long.parseLong(temp.getFinalReceiptTelephone()));
				//		order.setReceiptZipcode(temp.getFinalreceiptZipcode());
				//	}
				//}
			//}
		//}

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
			List<SubOrder> subOrders = subOrderManager
					.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
			order.setSubOrderList(subOrders);
			// 得到商品关联表中商品信息和供应商的信息
			Double ActuallyAmount = 0.0;
			Double ActuallyIntegral = 0.0;
			if (subOrders.size() > 0) {
				for (SubOrder subOrder : subOrders) {
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
				}
				request.setAttribute("ActuallyAmount", ActuallyAmount);
				request.setAttribute("ActuallyIntegral", ActuallyIntegral);
			}
			request.setAttribute("orderstu", order.getOrderStatus());
			request.setAttribute("order", order);
			request.setAttribute("view", 1);
		}
		Object entity = getManager().getByObjectId(objectId);
		request.setAttribute("entity", entity);
		return "service/viewChangeOrder";

	}

	/**
	 * 更改订单服务-更改页面
	 *
	 * @author 点击提交保存更改信息
	 */
	@RequestMapping("/saveChangeOrder")
	public String saveChangeOrder(HttpServletRequest request,
			ModelMap modelMap, Order t) throws Exception {
		OrderChaAddr orderChaAddr = new OrderChaAddr();
		List<SubOrder> list = subOrderManager.getSubOrderNoByGeneralOrderID(t.getObjectId());
		Order orderL=orderManager.getByObjectId(t.getObjectId());
		for (SubOrder subOrder : list){
		  //orderChaAddr.setSubOrderId(subOrder.getObjectId());
            //List<OrderChaAddr> orderChaAddrs = orderChaAddrManager.getBySample(orderChaAddr);
            //if (orderChaAddrs.size() > 0) {
            //  orderChaAddr = orderChaAddrs.get(0);
                //orderChaAddr.setFinalReceiptContacts(t.getReceiptContacts());
            //  orderChaAddr.setFinalreceiptAddress(t.getReceiptAddress());
            //  orderChaAddr.setFinalreceiptZipcode(t.getReceiptZipcode());
            //  orderChaAddr.setFinalReceiptTelephone(t.getReceiptMoblie().toString());
            //  orderChaAddr.setChangeTime(new Date());
            //  orderChaAddrManager.save(orderChaAddr);
            //  subOrder.setOrderEditState(IBSConstants.CHANGE_ORDER_RECEIVE_ADDRESS);
            //  subOrderManager.save(subOrder);
            //} else {
                subOrder.setOrderEditState(IBSConstants.CHANGE_ORDER_RECEIVE_ADDRESS);
                subOrderManager.save(subOrder);

                orderChaAddr.setFinalReceiptContacts(orderL.getReceiptContacts());
                orderChaAddr.setFinalreceiptAddress(orderL.getReceiptAddress());
                orderChaAddr.setFinalreceiptZipcode(orderL.getReceiptZipcode());
                orderChaAddr.setFinalReceiptTelephone(orderL.getReceiptMoblie()==null?orderL.getReceiptTelephone():orderL.getReceiptMoblie().toString());
                orderChaAddr.setSubOrderId(subOrder.getObjectId());
                orderChaAddr.setOrderId(orderL.getObjectId());
                orderChaAddr.setChangeTime(new Date());
                orderChaAddrManager.save(orderChaAddr);

                orderL.setReceiptContacts(t.getReceiptContacts());
                orderL.setReceiptAddress(t.getReceiptAddress());
                orderL.setReceiptEmail(t.getReceiptEmail());
                orderL.setReceiptMoblie(t.getReceiptMoblie());
                orderL.setReceiptTelephone(t.getReceiptTelephone());
                orderL.setReceiptZipcode(t.getReceiptZipcode());
                orderManager.save(orderL);
		}
		//维护总订单的修改状态
		Order order =orderManager.getByObjectId(t.getObjectId());
		order.setEditUserId(FrameworkContextUtils.getCurrentUserId());
		order.setOrderEditState(IBSConstants.CHANGE_ORDER_RECEIVE_ADDRESS);
		order.setOrderEditTime(new Date());
		orderManager.save(order);

		return "redirect:orderChange"
				+ getMessage("common.base.success", request);
	}


	/**
	  * paysuccessUpdateOrderStatus(支付成功之后修改订单状态)
	  * @Title: paysuccessUpdateOrderStatus
	  * @Description: TODO
	  * @param @param order
	  * @param @param subOrder    设定文件
	  * @return void    返回类型
	  * @throws
	  */
	private void paysuccessUpdateOrderStatus(Order order, SubOrder subOrder,Long userId) {
		OrderSku orderSku =new OrderSku();
		orderSku.setSubOrderId(subOrder.getObjectId());
		List<OrderSku>  list=orderSkuManager.getBySample(orderSku);
		if(list.size()>0){
		    if(subOrder.getOrderType() == IBSConstants.ORDER_TYPE_YEARS_WELFARE&&order.getOrderSource() == IBSConstants.ORDER_SOURCE_HR){//年度福利订单
                payedUpdateSuborder(subOrder, IBSConstants.ORDER_TRADING_SUCCESS, userId);
                payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_TRADING_SUCCESS, userId);
		    }else if (order.getOrderSource() == IBSConstants.ORDER_SOURCE_HR && (subOrder.getOrderType() == IBSConstants.ORDER_TYPE_BUY_POINT
                    || (subOrder.getOrderType() == IBSConstants.ORDER_TYPE_YEARS_WELFARE) && subOrder.getOrderProdType()==IBSConstants.ORDER_PRODUCT_TYPE_POINTS
                    || (subOrder.getOrderType() == IBSConstants.ORDER_TYPE_YEARS_WELFARE) && subOrder.getOrderProdType()==IBSConstants.ORDER_PRODUCT_TYPE_GRANT_POINTS)) {
                // 修改子订单状态和付款事件和操作人
                payedUpdateSuborder(subOrder, IBSConstants.ORDER_TRADING_SUCCESS, userId);
                // 给用户加积分
                //pointOperateManager.operate(userId, userId, subOrder.getPayableAmount(), OperationType.BUY_POINT, "购买积分", subOrder.getObjectId().toString());
                // 插入时间戳
                payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_TRADING_SUCCESS, userId);
            }else if (
				 (order.getOrderSource()==IBSConstants.ORDER_SOURCE_HR||order.getOrderSource()==IBSConstants.ORDER_SOURCE_STAFF||order.getOrderSource()==IBSConstants.ORDER_SOURCE_HOME)
				  && (subOrder.getOrderType()==IBSConstants.ORDER_TYPE_POINT_BUY|| subOrder.getOrderType()==IBSConstants.ORDER_TYPE_CASH_BUY||subOrder.getOrderType() == IBSConstants.ORDER_TYPE_YEARS_WELFARE)
				  && (list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_PHYSICAL_SKU
				  ||list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_PHYSICAL_CARD_RELL)) {

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TO_BE_SHIPPED,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TO_BE_SHIPPED,userId);


		}else if((order.getOrderSource()==IBSConstants.ORDER_SOURCE_HR||order.getOrderSource()==IBSConstants.ORDER_SOURCE_STAFF||order.getOrderSource()==IBSConstants.ORDER_SOURCE_HOME)
				&& (subOrder.getOrderType()==IBSConstants.ORDER_TYPE_POINT_BUY||subOrder.getOrderType()==IBSConstants.ORDER_TYPE_CASH_BUY||subOrder.getOrderType() == IBSConstants.ORDER_TYPE_YEARS_WELFARE) && list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_ELECTRON_CARD_RELL){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);


		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_HR && (list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_PHYSICAL_EXCHANGE_RELL||list.get(0).getProductType()==IBSConstants.PHYSICAL_MATERIAL_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TO_BE_SHIPPED,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TO_BE_SHIPPED,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_HR && (list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL||list.get(0).getProductType()==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TO_BE_ISSUED_VIRTUAL,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TO_BE_ISSUED_VIRTUAL,userId);


		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_HOME
				&& subOrder.getOrderType()==IBSConstants.ORDER_TYPE_CASH_BUY
				&& (list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_PHYSICAL_EXCHANGE_RELL||list.get(0).getProductType()==IBSConstants.PHYSICAL_MATERIAL_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TO_BE_SHIPPED,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TO_BE_SHIPPED,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_HOME
				&& subOrder.getOrderType()==IBSConstants.ORDER_TYPE_CASH_BUY
				&& (list.get(0).getProductType()==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL||list.get(0).getProductType()==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_STAFF && subOrder.getOrderType()==IBSConstants.ORDER_TYPE_CASH_BUY
				&& (list.get(0).getBuyForFamily()==IBSConstants.STATUS_YES|| list.get(0).getAddedPhysicalPay()==IBSConstants.STATUS_YES || list.get(0).getAddedPhysicalPay()==IBSConstants.STATUS_NO)
				&& (list.get(0).getProductType()==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_PENDING_APPOINTMENT,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_PENDING_APPOINTMENT,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_STAFF && subOrder.getOrderType()==IBSConstants.ORDER_TYPE_POINT_BUY
				&& (list.get(0).getBuyForFamily()==IBSConstants.STATUS_NO|| list.get(0).getAddedPhysicalPay()==IBSConstants.STATUS_NO)
				&& (list.get(0).getProductType()==IBSConstants.PHYSICAL_MATERIAL_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TO_BE_SHIPPED,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TO_BE_SHIPPED,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_STAFF && subOrder.getOrderType()==IBSConstants.ORDER_TYPE_POINT_BUY
				&& (list.get(0).getBuyForFamily()==IBSConstants.STATUS_NO|| list.get(0).getAddedPhysicalPay()==IBSConstants.STATUS_NO)
				&& (list.get(0).getProductType()==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE)){

			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_SHIPPED_VIRTUAL,userId);

		}else if(order.getOrderSource()==IBSConstants.ORDER_SOURCE_HR && subOrder.getOrderType()==IBSConstants.ORDER_TYPE_BUY_POINT ){
			//修改子订单状态和付款事件和操作人
			payedUpdateSuborder(subOrder,IBSConstants.ORDER_TRADING_SUCCESS,userId);
			//插入时间戳
			payAndUpdateOrderTimeInfo(subOrder.getObjectId(),IBSConstants.ORDER_TRADING_SUCCESS,userId);

		}
	   if (order.getOrderStatus() == IBSConstants.ORDER_TO_BE_PAID) {
			order.setPaymentDate(new Date());
			order.setPayUserId(userId);
			order.setOrderStatus(IBSConstants.ORDER_PAID);
			this.save(order);
		}

	  }

	}


	/**
	  * payedUpdateSuborder(修改子订单状态和付款时间和操作人)
	  * @param @param subOrder
	  * @param @param subOrderStatus订单状态
	  * @param @param userId 付款用户id
	  */
	private void payedUpdateSuborder(SubOrder subOrder, int subOrderStatus,
			Long userId) {
		subOrder.setSubOrderState(subOrderStatus);
		subOrder.setPayUserId(userId);
		subOrder.setPaymentDate(new Date());
		subOrderManager.save(subOrder);

	}


	/**
	  * payAndUpdateOrderTimeInfo(支付后和更改订单状态是加时间戳)
	  * @param @param subOrderId
	  * @param @param subOrderStatus
	  * @param @param userId    设定文件
	  */
	private void payAndUpdateOrderTimeInfo(Long subOrderId,
			Integer subOrderStatus, Long userId) {
		SubOrderTimeInfo subOrderTimeInfo=new SubOrderTimeInfo();
		subOrderTimeInfo.setOperationTime(new Date());
		subOrderTimeInfo.setSubOrderId(subOrderId);
		subOrderTimeInfo.setSubOrderState(subOrderStatus);
		subOrderTimeInfo.setUserId(userId);
		subOrderTimeInfoManager.save(subOrderTimeInfo);

	}



	@RequestMapping(value = "/getSubOrderStatus")
	public String cancelAndSubscribe(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String generalOrderNo = request.getParameter("generalOrderNo");
		boolean flag  = false;
		Order order = new Order();
		order.setGeneralOrderNo(generalOrderNo);
		List<Order> orders = orderManager.getBySample(order);
		if(orders.size()>0){
			order  = orders.get(0);
		}
		SubOrder subOrder = new SubOrder();
		subOrder.setGeneralOrderId(order.getObjectId());
		List<SubOrder> subOrders  = subOrderManager.getBySample(subOrder);
		for(SubOrder so :subOrders){
			int  ss = so.getSubOrderState();
			if(ss == (IBSConstants.ORDER_SHIPPED_IN_KIND)){
				flag  = false;
				break;
			}
			else{
				flag  = true;
			}
		}
		modelMap.addAttribute("result", flag);
		return "jsonView";
	}


	/**
	 * 线下付款订单列表界面
	 *
	 *
	 */
	@RequestMapping(value = "/linePay")
	public String linePayOrder(HttpServletRequest request, HttpServletResponse response) {
		// 查询所有线下付款的订单
		PageSearch   page =  PageUtils.preparePage(request, SubOrder.class, true);
		PageSearch result = subOrderManager.findLineOrder(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.getSession().setAttribute("action", "/order/linePay");
		return "order/listLinePayOrder";
	}

	/**
	 * 点击更新为已付款弹出窗口
	 *
	 */
	@RequestMapping("/underLinePayByOrder/{objectId}")
	public String underLinePayByOrder(HttpServletRequest request,@PathVariable Long objectId){
		//查出总订单下面所有的子订单（除了已经支付和取消的订单）
  		if(objectId!=null){
  			Order order=orderManager.getByObjectId(objectId);
  			Double payA = 0D;
			 if(order!=null){
			 List<SubOrder> subOrderList=subOrderManager.getSubOrderObjectIdByGeneralOrderID(objectId);
			 if (subOrderList!=null && subOrderList.size()>0) {
				 for (SubOrder subOrder : subOrderList) {
					 if (subOrder.getPayableAmount()!=null) {
						 payA = payA + subOrder.getPayableAmount();
					 }
				}
			 }
			 request.setAttribute("order", order);
		     request.setAttribute("allPayableMount",payA);
		  }
		}
		return "order/editLinePayOrderByPlan";
	}

	/**
	 * 支付核对页面点击提交
	 *
	 */
	@RequestMapping("/updateToPageByPlan")
	public String updateToPageByPlan(HttpServletRequest request, ModelMap modelMap) {
		Long payUserId = FrameworkContextUtils.getCurrentUserId();
		String orderId=request.getParameter("orderId");
		String linePayRemark=request.getParameter("linePayRemark");
		   //修改订单状态和付款时间等的信息
			if (orderId != null && !("").equals(orderId)) {
				Order order=orderManager.getByObjectId(Long.parseLong(orderId));
				if (order!=null) {
					order.setLinePayRemark(linePayRemark);
					List<SubOrder> subOrderList=subOrderManager.getSubOrderObjectIdByGeneralOrderID(Long.parseLong(orderId));
					 if (subOrderList!=null && subOrderList.size()>0) {
						 for (SubOrder subOrder : subOrderList) {
							 //校验订单是否已经付款
							 if(subOrder!=null && subOrder.getSubOrderState()!=IBSConstants.ORDER_TO_BE_PAID){
								 modelMap.addAttribute("result", false);
								 modelMap.addAttribute("resultReason", "该订单已经付款，不能再更新为已付款");
								 return "jsonView";
							 }
						}
					 }
					 orderManager.updateOrderToPaidList(order, payUserId);
				}
		  }
		modelMap.addAttribute("result", true);
		return "jsonView";
	}

}
