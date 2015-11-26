package com.handpay.ibenefit.order.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.grantWelfare.service.IGrantWelfareManager;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.CardCreInfoSubOrder;
import com.handpay.ibenefit.order.entity.ChangeOrder;
import com.handpay.ibenefit.order.entity.ChangeOrderExpla;
import com.handpay.ibenefit.order.entity.ChangeOrderSku;
import com.handpay.ibenefit.order.entity.ChangeOrderTimeInfo;
import com.handpay.ibenefit.order.entity.ChnaOrderCard;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.entity.SubOrderTimeInfo;
import com.handpay.ibenefit.order.service.ICardCreInfoSubOrderManager;
import com.handpay.ibenefit.order.service.IChangeOrderExplaManager;
import com.handpay.ibenefit.order.service.IChangeOrderManager;
import com.handpay.ibenefit.order.service.IChangeOrderSkuManager;
import com.handpay.ibenefit.order.service.IChangeOrderTimeInfoManager;
import com.handpay.ibenefit.order.service.IChnaOrderCardManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.IOrderSkuManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.order.service.ISubOrderTimeInfoManager;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IPointOperateManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.security.service.OperationType;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWpRelationManager;

/**
 * @desc 订单管理-退换货订单列表&新增退货单&退货单详情
 * @author huyuanyuan
 * @date
 */
@Controller
@RequestMapping("/changeOrder")
public class ChangeOrderController extends PageController<ChangeOrder> {

	private static final Logger logger = Logger.getLogger(ChangeOrderController.class);

	private static final String BASE_DIR = "order/";

	@Reference(version = "1.0")
	private IChangeOrderManager changeOrderManager;

	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private IOrderProductManager orderProductManager;

	@Reference(version = "1.0")
	private IOrderManager orderManager;

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
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IOrderSkuManager orderSkuManager;

	@Reference(version = "1.0")
	private ISkuManager skuManager;

	@Reference(version = "1.0")
	private IChnaOrderCardManager  chnaOrderCardManager;
	
	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;
	@Reference(version = "1.0")
	private IPointOperateManager pointOperateManager;
	
	@Reference(version = "1.0")
	private ICardCreInfoSubOrderManager cardCreInfoSubOrderManager;
	
	@Reference(version = "1.0")
	private IGrantWelfareManager grantWelfareManager;

	@Reference(version = "1.0")
	private ISubOrderTimeInfoManager subOrderTimeInfoManager;
	
	@Reference(version = "1.0")
	private IChangeOrderTimeInfoManager changeOrderTimeInfoManager;
	
	@Override
	public Manager<ChangeOrder> getEntityManager() {
		return changeOrderManager;
	}

	@Override
	public String getFileBasePath() {

		return BASE_DIR;
	}

	/**
	 * 退换货订单管理-确认退款
	 *
	 * @throws IOException
	 *
	 */
	@RequestMapping(value = "/confirm/{objectId}")
	public String confirmRefund(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId){
		logger.info("======确认退款开始================");
		ChangeOrder changeOrder = changeOrderManager.getByObjectId(objectId);
		if (changeOrder != null) {
			SubOrder subOrderL = subOrderManager.getByObjectId(changeOrder.getSubOrderId());
			// 若子订单不是待发货的
			if (subOrderL.getSubOrderState() != IBSConstants.ORDER_TO_BE_SHIPPED) {
				Map<String, Object> map = new HashMap<String, Object>();
				map.put("objectId", objectId);
				map.put("orderStatus", IBSConstants.CHANGE_ORDER_REFUNDED);
				changeOrderManager.updateOrderStatus(map);
				  //插入退换货操作日志表
	 			ChangeOrderTimeInfo changeTime=new ChangeOrderTimeInfo();
	 			changeTime.setChangeOrderId(changeOrder.getObjectId());
	 			changeTime.setChangeOrderState(IBSConstants.CHANGE_ORDER_REFUNDED);
	 			changeTime.setOperationTime(new Date());
	 			changeTime.setUserId(FrameworkContextUtils.getCurrentUserId());
	 			changeOrderTimeInfoManager.save(changeTime);
				// 得到退货商品信息
				List<ChangeOrderSku> changeOrderSku = changeOrderSkuManager.getByChangeOrderId(changeOrder.getObjectId());
				if (changeOrderSku.size() > 0) {
					SubOrder subOrder = subOrderManager.getSubOrderBySubOrderId(changeOrder.getSubOrderId());
					if (subOrder != null) {
						// 若是积分购买的订单类型则将积分退给相应账户
						if (subOrder.getOrderType() == IBSConstants.ORDER_TYPE_POINT_BUY) {
							logger.info("======积分购买退账户积分开始================");
							returnPointToAccount(subOrder, changeOrder);
						}
						// 若购买的是ibs体检电子兑换券和福利兑换券则退货后将卡密作废
						if (changeOrderSku.get(0).getProductType() == IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE
								|| changeOrderSku.get(0).getProductType() == IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL) {
							ChnaOrderCard chnaOrderCard = new ChnaOrderCard();
							chnaOrderCard.setSubOrderId(subOrder.getObjectId());
							chnaOrderCard.setProductId(changeOrderSku.get(0).getSkuId());
							List<ChnaOrderCard> chnaOrderCardList = chnaOrderCardManager.getBySample(chnaOrderCard);
							for (ChnaOrderCard card : chnaOrderCardList) {
								CardInfo cardInfo = new CardInfo();
								cardInfo.setObjectId(card.getCardId());
								cardInfo.setCardStatus(IBSConstants.CARD_VOID);
								cardInfoManager.save(cardInfo);
							}
							
							//查看这批卡是不是退的数量和发的数量相同，若相同则将订单状态更掉
							//计算购买的数量
							Long totalCount = grantWelfareManager.getSubOrderTotalCount(subOrder.getObjectId(),null);
							//计算已发放份数
							Long sendedCount = grantWelfareManager.getSubOrderByGranted(subOrder.getObjectId()) ;
							//计算退的数量
							Long changedCount = changeOrderSkuManager.getChangeCountBySubIdAndProdID(subOrder.getObjectId(),changeOrderSku.get(0).getSkuId());
                            if(sendedCount!=0 && sendedCount+changedCount==totalCount){
                            	subOrderL.setSubOrderState(IBSConstants.ORDER_ISSUED_IN_KIND);
                				subOrderManager.save(subOrderL);
                				payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_ISSUED_IN_KIND);
                				
                            }else if(sendedCount==0 && changedCount==totalCount){
                            	
                            	subOrderL.setSubOrderState(IBSConstants.ORDER_RETURN);
                				subOrderManager.save(subOrderL);
                				payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_RETURN);
                				
                            }			
							
						}
						if (subOrder.getSubOrderState() != IBSConstants.ORDER_TO_BE_SHIPPED) {
							// 若该订单已经退货完成了则将订单状态改为退货否则为原来状态
							updateOrderToReturn(subOrder, changeOrderSku,changeOrder);
						}
					}
				}
			} else if (subOrderL.getSubOrderState() == IBSConstants.ORDER_TO_BE_SHIPPED){
				ChangeOrder cha = new ChangeOrder();
				cha.setSubOrderId(subOrderL.getObjectId());
				List<ChangeOrder> chas = changeOrderManager.getBySample(cha);
				for (ChangeOrder change : chas) {
					change.setOrderStatus(IBSConstants.CHANGE_ORDER_REFUNDED);
					changeOrderManager.save(change);
					  //插入退换货操作日志表
		 			ChangeOrderTimeInfo changeTime=new ChangeOrderTimeInfo();
		 			changeTime.setChangeOrderId(change.getObjectId());
		 			changeTime.setChangeOrderState(IBSConstants.CHANGE_ORDER_REFUNDED);
		 			changeTime.setOperationTime(new Date());
		 			changeTime.setUserId(FrameworkContextUtils.getCurrentUserId());
		 			changeOrderTimeInfoManager.save(changeTime);
				}
				// 修改子订单状态并将积分退回
				subOrderL.setSubOrderState(IBSConstants.ORDER_RETURN);
				subOrderManager.save(subOrderL);
				payAndUpdateOrderTimeInfo(subOrderL.getObjectId(), IBSConstants.ORDER_RETURN);

				if (subOrderL.getOrderType() == IBSConstants.ORDER_TYPE_POINT_BUY) {
					Long currentId = FrameworkContextUtils.getCurrentUserId();
					Order order = orderManager.getByObjectId(subOrderL.getGeneralOrderId());
					if (order != null) {
						Long pointObjectId = pointOperateManager.operate(order.getUserId(), currentId, subOrderL.getActuallyIntegral(),OperationType.RETURN_POINT, "退款积分", subOrderL.getObjectId().toString());
						if (pointObjectId == null) {
							logger.info("======积分购买退账户积分失败=============");
						} else {
							logger.info("======积分购买退账户积分成功==============");
						}
					}
				}
			}
		}

		return "redirect:/changeOrder/return";
	}



	private void returnPointToAccount(SubOrder subOrder, ChangeOrder changeOrder) {
	   Long currentId=FrameworkContextUtils.getCurrentUserId();
	   Order order=orderManager.getByObjectId(subOrder.getGeneralOrderId());
	   if(order!=null && subOrder.getOrderType()==IBSConstants.ORDER_TYPE_POINT_BUY){		   
		 Long objectId= pointOperateManager.operate(order.getUserId(), currentId, changeOrder.getRefundaMount(), OperationType.RETURN_POINT, "退款积分", subOrder.getObjectId().toString());		   
	     if(objectId==null){
	    	logger.info("======积分购买退账户积分失败============="); 
	     }else{
	    	 logger.info("======积分购买退账户积分成功==============");  
	     }
	   }		
	}


	private void updateOrderToReturn(SubOrder subOrder,List<ChangeOrderSku> changeOrderSku, ChangeOrder changeOrder) {
		Long allBuyCounts = 0L;// 该退货单对应的子订单购买的所有数量
		Long allChangeCounts = 0L;// 该退货单对应的子订单所有退货数量
		Long otherBuyCount = 0L;// 该退货单对应的子订单购买的其他商品购买数量
		Long otherChangeCount = 0L;// 该退货单对应的子订单购买的其他商品退货数量
		Order order = orderManager.getByObjectId(subOrder.getGeneralOrderId());
		OrderSku orderSku = new OrderSku();
		orderSku.setSubOrderId(subOrder.getObjectId());
		List<OrderSku> list = orderSkuManager.getBySample(orderSku);
		if (list.size() > 0){
			for(OrderSku sku : list){
				//得到总的购买数量
				allBuyCounts += sku.getProductCount();
				if (!sku.getProductId().equals(changeOrderSku.get(0).getSkuId())) {
					// 得到该退货商品对应的子订单购买的其他商品退货单
					Long buyCount = orderSkuManager.getBuyCountBySubIdAndProdID(subOrder.getObjectId(), sku.getProductId());
					otherBuyCount += buyCount == null ? 0 : buyCount;
					// 该退货商品对应的子订单购买的其他商品的已经退货的数量
					Long changedCount=changeOrderSkuManager.getChangeCountBySubIdAndProdID(subOrder.getObjectId(),sku.getProductId());
	 				otherChangeCount+=changedCount==null?0:changedCount;  
				}
			}
		}
		// 该退货商品原本的购买数量
		Long buyCount = orderSkuManager.getBuyCountBySubIdAndProdID(subOrder.getObjectId(), changeOrderSku.get(0).getSkuId());
		// 该退货商品已经退货的数量
		Long changedCount = changeOrderSkuManager.getChangeCountBySubIdAndProdID(subOrder.getObjectId(),changeOrderSku.get(0).getSkuId());
		if (changedCount != null) {
			allChangeCounts = otherChangeCount + changedCount;
		}else{
			allChangeCounts = otherChangeCount;
		}
		// 若是现金购买并且购买的数量和退货的数量相同则修改子订单状态
		if (order != null) {
			if (buyCount.equals(changedCount) && allBuyCounts.equals(allChangeCounts)
					&& subOrder.getOrderType() == IBSConstants.ORDER_TYPE_CASH_BUY) {
				Map<String, Object> subOrderPrama = new HashMap<String, Object>();
				subOrderPrama.put("subOrderState", IBSConstants.ORDER_RETURN);
				subOrderPrama.put("objectId", subOrder.getObjectId());
				subOrderManager.updSubOrder(subOrderPrama);
				payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_RETURN);

			} else if (subOrder.getOrderType() == IBSConstants.ORDER_TYPE_POINT_BUY) {
				if (buyCount.equals(changedCount) && allBuyCounts.equals(allChangeCounts)) {
					// 若购买的和退的数量一致则修改子订单状态
					Map<String, Object> subOrderPrama = new HashMap<String, Object>();
					subOrderPrama.put("subOrderState",IBSConstants.ORDER_RETURN);
					subOrderPrama.put("objectId", subOrder.getObjectId());
					subOrderManager.updSubOrder(subOrderPrama);
					payAndUpdateOrderTimeInfo(subOrder.getObjectId(), IBSConstants.ORDER_RETURN);

				}
			}
		}
	}

	/**
	 * 点击退货单号超链接-退货单详情
	 *
	 * @throws IOException
	 *
	 */
	@RequestMapping(value = "/return/{objectId}")
	public String returnDetails(HttpServletRequest request,
			HttpServletResponse response, @PathVariable Long objectId) {

		if(objectId != null) {
			ChangeOrder changeOrder = changeOrderManager.getByObjectId(objectId);
			if (changeOrder != null) {
				User user = userManager.getByObjectId(changeOrder.getUserId());
				List<ChangeOrderExpla> changeOrderExplas = changeOrderExplaManager.getByChangerId(changeOrder.getObjectId());
				List<ChangeOrderSku> changeOrderSkus = changeOrderSkuManager.getCOSkuByCId(changeOrder.getObjectId());
				 double changeMount = 0;
				if(changeOrderSkus!=null){
				for (ChangeOrderSku changeOrderSku : changeOrderSkus) {
					changeMount += changeOrderSku.getChangeMount()==null?0:changeOrderSku.getChangeMount();
				}
				}
				SubOrder subOrder = subOrderManager.getSubOrderBySubOrderId(changeOrder.getSubOrderId());
				if (subOrder != null) {
					Order order = orderManager.getOrderByOrderId(subOrder.getGeneralOrderId());
					Supplier supplier = supplierManager.getByObjectId(subOrder.getSupplierId());
					request.setAttribute("order", order);
					request.setAttribute("supplier", supplier);
				}
				request.setAttribute("subOrder", subOrder);
				request.setAttribute("changeOrderExplas", changeOrderExplas);
				request.setAttribute("changeOrderSkus", changeOrderSkus);
				request.setAttribute("user", user);
				request.setAttribute("changeMount", changeMount);
			}
			request.setAttribute("changeOrder", changeOrder);
		}
		return "order/returnDetailsOrder";
	}

	/**
	 * 退换货订单列表
	 *
	 * @throws IOException
	 *
	 */
	@RequestMapping(value = "/return")
	public String returnOrder(HttpServletRequest request, ChangeOrder t) {
		PageSearch page = preparePage(request);
		PageSearch result = changeOrderManager.findReturnOrder(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.getSession().setAttribute("action", "/changeOrder/return");
		return "order/listReturnOrder";

	}

	/**
	 * 代理退换货列表-编辑按钮
	 *
	 * @throws IOException
	 *
	 */
	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		if (objectId != null) {
			ChangeOrder changeOrder = changeOrderManager.getByObjectId(objectId);
			if (changeOrder != null) {
				List<ChangeOrderExpla> changeOrderExplas = changeOrderExplaManager.getByChangerId(changeOrder.getObjectId());
				List<ChangeOrderSku> changeOrderSkus = changeOrderSkuManager.getCOSkuByCId(changeOrder.getObjectId());
			//编辑时得到card的ids
				if(changeOrderSkus!=null){
					ChnaOrderCard chnaOrderCard = new ChnaOrderCard();
					Long subOrderId=changeOrder.getSubOrderId();
					String ids="";
					for(ChangeOrderSku changeOrderSku : changeOrderSkus){
						Long skuId= changeOrderSku.getSkuId();
						chnaOrderCard.setProductId(skuId);
						chnaOrderCard.setSubOrderId(subOrderId);
						List<ChnaOrderCard> chnaOrderCards=chnaOrderCardManager.getBySample(chnaOrderCard);
						for(ChnaOrderCard chnaOrderCardL:chnaOrderCards){
							ids+=chnaOrderCardL.getCardId();
							ids+=",";
						}
					}
					request.setAttribute("ids", ids);
				}
				//编辑时得到card的ids end
				// 得到退过货的数量
				SubOrder subOrderL = subOrderManager.getByObjectId(changeOrder
						.getSubOrderId());
				if(changeOrderSkus!=null){
				for (ChangeOrderSku changeOrderSku : changeOrderSkus) {
					Integer lockCount = changeOrderManager
							.queryLockCountBySubOrderNoAndOrderSkuId(subOrderL.getObjectId(),changeOrderSku.getSkuId());
					changeOrderSku.setReturnQuantity(lockCount);
				}
				}
				if (subOrderL != null) {
					Order order = orderManager.getOrderByOrderId(subOrderL.getGeneralOrderId());
					request.setAttribute("order", order);
				}
				request.setAttribute("changeOrderExplas", changeOrderExplas);
				request.setAttribute("changeOrderSkus", changeOrderSkus);
				request.setAttribute("subOrder", subOrderL);
			}
			request.setAttribute("entity", changeOrder);
		}
		return getFileBasePath() + "edit"
				+ getActualArgumentType().getSimpleName();
	}

	/*
	 * 判断改订单是否存在待审核的订单，如果存在则不能再次退货
	**/
	@RequestMapping(value = "/PendChangeOrder")
	private String PendChangeOrder(HttpServletRequest request,
			HttpServletResponse response, ModelMap modelMap) {
		boolean flag = false;
		String subOrderIdL = request.getParameter("subOrderId");
		String changeNo=request.getParameter("changeNo");
		if (subOrderIdL != null && StringUtils.isBlank(changeNo)) {
			Long subOrderId = Long.parseLong(subOrderIdL);
			List<OrderSku> orderSkus = orderProductManager
					.getOrderProductBySubOrderId(subOrderId);
			if (orderSkus.size() > 0) {
				for (OrderSku orderSku : orderSkus) {
					Integer isPending = changeOrderManager
							.getChangeNumByBySubOrderNoAndOrderSkuId(
									subOrderId, orderSku.getProductId());
					if (isPending !=null && isPending > 0 ) {
						flag = true;
					}
				}
			}
		}
		modelMap.addAttribute("result", flag);
		return "jsonView";
	}




	/**
	 * 代理退换货列表界面
	 *
	 * @throws IOException
	 *
	 */
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		PageSearch result = changeOrderManager.findChangeOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		request.getSession().setAttribute("action", "/changeOrder/page");
		return getFileBasePath() + "listChangeOrder";
	}

	/**
	 * 代理退换货界面-新增按钮
	 *
	 * @throws IOException
	 *
	 */
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			ChangeOrder t) throws Exception {
		Long subOrderId = Long.parseLong(request.getParameter("subOrderId"));
		SubOrder subOrder=subOrderManager.getByObjectId(subOrderId);
		Integer changeType = Integer.parseInt(request.getParameter("changeType"));
		Long userId = FrameworkContextUtils.getCurrentUserId();
		t.setUserId(userId);
		t.setSubOrderId(subOrderId);
		t.setChangeDate(new Date());
		t.setChangeType(changeType);
		t.setOrderStatus(IBSConstants.CHANGE_ORDER_PENDING);		
		List<ChangeOrderSku> changeOrderSkus = t.getChangeOrderSkus();
		if (changeOrderSkus.size() > 0) {
			for (ChangeOrderSku changeOrderSku : changeOrderSkus) {
				Double refundaMount = 0.0;
					if (changeOrderSku.getChangeNum() != null && changeOrderSku.getChangeNum() > 0) {
						if("".equals(request.getParameter("objectId"))){
							String changeNo = sequenceManager.getNextNo("F_SEQUENCE", "R", 10);
							t.setChangeNo(changeNo);
						}
						OrderSku orderSku = orderProductManager.getByProduct( changeOrderSku.getSkuId(), subOrderId);
						if(orderSku!=null){

						  if(orderSku.getAttribute1()!=null && orderSku.getAttribute2()!=null){
						    String Attribute ="颜色："+ orderSku.getAttribute2()
								+",尺寸：" +orderSku.getAttribute1();
						    changeOrderSku.setAttribute(Attribute);
						}else if(orderSku.getAttribute1()!=null && orderSku.getAttribute2()==null){
							String Attribute ="尺寸：" +orderSku.getAttribute1();
							    changeOrderSku.setAttribute(Attribute);
						}else if(orderSku.getAttribute1()==null && orderSku.getAttribute2()!=null){
							  String Attribute ="颜色："+ orderSku.getAttribute2();
								    changeOrderSku.setAttribute(Attribute);
						}
						changeOrderSku.setIntergral(orderSku.getIntergral());
						changeOrderSku.setMount(orderSku.getMount());
						changeOrderSku.setName(orderSku.getName());
						changeOrderSku.setProductCount(orderSku.getProductCount());
						changeOrderSku.setProductNo(orderSku.getProductNo());
						changeOrderSku.setProductPrice(orderSku.getProductPrice());
						changeOrderSku.setProductType(orderSku.getProductType());
						changeOrderSku.setSkuId(orderSku.getProductId());
						// 退换货数量
						changeOrderSku.setChangeNum(changeOrderSku.getChangeNum());
						if(subOrder.getOrderType()==IBSConstants.ORDER_TYPE_EXCHANGE_WELFARE){
						
						}else{
							
							Double changeMount = orderSku.getProductPrice()* changeOrderSku.getChangeNum();
							changeOrderSku.setChangeMount(changeMount);
							refundaMount += changeMount;
						}
						List<ChangeOrderSku> list = new ArrayList<ChangeOrderSku>();
						list.add(changeOrderSku);
						t.setChangeOrderSkus(list);
						t.setRefundaMount(refundaMount);
						ChangeOrder tl = changeOrderManager.save(t);
						changeOrderSku.setChangeOrderId(tl.getObjectId());
						// 判断退货的商品是否是电子兑换券
						if (orderSku.getProductType()==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL|| orderSku.getProductType()==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE) {
							String ids = request.getParameter("ids");
							String[] arr = ids.split(",");
							for (int i = 0; i < arr.length; i++) {
								if (arr[i] != null && !("").equals(arr[i])) {
									ChnaOrderCard chnaOrderCard = new ChnaOrderCard();
									Long cardId = Long.parseLong(arr[i]);
									//ChnaOrderCard chaOrderCard=new ChnaOrderCard();
									//chaOrderCard.setCardId(cardId);
									//List<ChnaOrderCard> chnaOrderCardLs=chnaOrderCardManager.getBySample(chaOrderCard);
									//if(chnaOrderCardLs.size()>0){

							        //}else{
									chnaOrderCard.setSubOrderId(subOrderId);
									chnaOrderCard.setCardId(cardId);
									chnaOrderCard.setProductId(orderSku.getProductId());
									chnaOrderCard.setChangeOrderId(tl.getObjectId());
									chnaOrderCardManager.save(chnaOrderCard);
									
								}
							}
						}
						changeOrderSkuManager.save(changeOrderSku);
						Long changeOrderId = tl.getObjectId();
						Long subOrId = tl.getSubOrderId();
						saveCHangeOrderPic(request, changeOrderId, subOrId);
						}
					}
			}
		}
		return "redirect:/changeOrder/page";

	}

	/**
	 * saveCHangeOrderPic(退换货图证上传)
	 *
	 * @Title: saveCHangeOrderPic
	 * @Description: TODO
	 * @param @param request
	 * @param @param changeOrderId
	 * @param @param subOrId 设定文件
	 * @return void 返回类型
	 * @throws
	 */
	private void saveCHangeOrderPic(HttpServletRequest request,
			Long changeOrderId, Long subOrId) {
		String subPicture = request.getParameter("subPicture");
		if (StringUtils.isNotBlank(subPicture) ){
			String[] productSubPic = subPicture.split(",");
			for (String filePath : productSubPic) {
				ChangeOrderExpla changeOrderExpla=new ChangeOrderExpla();
				changeOrderExpla.setChangeOrderId(changeOrderId);
				changeOrderExpla.setImagId(filePath);
				changeOrderExpla.setSubOrderId(subOrId);
				
				if (changeOrderId != null && StringUtils.isNotBlank(filePath)) {
					changeOrderExplaManager.save(changeOrderExpla);
				}
			}
		}
	}

	/**
	 * determine(新增退换货订单-确定按钮)
	 *
	 * @throws
	 */
	@RequestMapping(value = "/determine")
	public String determine(HttpServletRequest request) throws Exception {
		String subOrderNo = request.getParameter("subOrderNo");
		Integer changeType = Integer.parseInt(request
				.getParameter("changeType"));
		ChangeOrder entity = new ChangeOrder();
		entity.setChangeType(changeType);
		request.setAttribute("entity", entity);
		if (changeType == null) {
			return "redirect:/changeOrder/create";
		} else if (changeType.equals(IBSConstants.ORDER_PRODUCT_EXCHANGE)) {
			// 换货原则
			request.setAttribute("ORDER_PRODUCT_EXCHANGE", true);
			SubOrder subOrder = subOrderManager.getBySubOrderNo(subOrderNo.trim());
			if (subOrder != null) {
				Integer subOrderSate = subOrder.getSubOrderState();
				List<OrderSku> orderSkus = orderProductManager
						.getOrderProductBySubOrderId(subOrder.getObjectId());
				// 查看这个skuid是否退换货
				for (OrderSku ordersku : orderSkus) {
					Integer lockCount = changeOrderManager.queryLockCountBySubOrderNoAndOrderSkuId(subOrder.getObjectId(),
									ordersku.getProductId());
					ordersku.setReturnQuantity(lockCount);
				}
				Order order = orderManager.getByObjectId(subOrder.getGeneralOrderId());
				Integer orderSource = order.getOrderSource();
				// hr
				if (orderSource==IBSConstants.ORDER_SOURCE_HR) {
					for (OrderSku orderSku : orderSkus) {
						Integer productType = orderSku.getProductType();
						request.setAttribute("productType", productType);
						// hr实体
						if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
							if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND
									|| subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND
									|| subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS) {
								orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							}
						} else {// 其他
							orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
						}
					}
					// 员工
				} else if (orderSource==IBSConstants.ORDER_SOURCE_STAFF||orderSource==IBSConstants.ORDER_SOURCE_WEIXIN) {
					for (OrderSku orderSku : orderSkus) {
						Integer productType = orderSku.getProductType();
						request.setAttribute("productType", productType);
						if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
							if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND) {
								orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							}
						} else {
							orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
						}
					}
				} else if (orderSource==IBSConstants.ORDER_SOURCE_HOME) {
					for (OrderSku orderSku : orderSkus) {
						Integer productType = orderSku.getProductType();
						request.setAttribute("productType", productType);
						if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
							if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND) {
								orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							}
						} else {
							orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
						}
					}
				}else if(orderSource==IBSConstants.ORDER_SOURCE_ADMIN){
					for (OrderSku orderSku : orderSkus) {
						Integer productType = orderSku.getProductType();
						request.setAttribute("productType", productType);
						if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
							if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND) {
								orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							}
						} else {
							orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
						}
					}					
				}
				subOrder.setOrderProductList(orderSkus);
				request.setAttribute("subOrderNo", subOrderNo);
				request.setAttribute("order", order);
				request.setAttribute("subOrder", subOrder);
				request.setAttribute("changeType", changeType);
			}
		} else if (changeType.equals(IBSConstants.ORDER_PRODUCT_RETURN)) {
			request.setAttribute("ORDER_PRODUCT_RETURN", true);
			// 退货原则
			SubOrder subOrder = subOrderManager.getBySubOrderNo(subOrderNo.trim());
			if (subOrder != null) {
				Integer subOrderSate = subOrder.getSubOrderState();
				List<OrderSku> orderSkus = orderProductManager
						.getOrderProductBySubOrderId(subOrder.getObjectId());
				// 查看这个skuid是否退换货
				for (OrderSku ordersku : orderSkus) {
					Integer lockCount = changeOrderManager
							.queryLockCountBySubOrderNoAndOrderSkuId(subOrder.getObjectId(),ordersku.getProductId());
					ordersku.setReturnQuantity(lockCount);
				}
				Order order = orderManager.getByObjectId(subOrder.getGeneralOrderId());
				if (order != null) {
					Integer orderSource = order.getOrderSource();
					Integer orderType = subOrder.getOrderType();
					if (orderSource.equals(IBSConstants.ORDER_SOURCE_HR)) {
						for (OrderSku orderSku : orderSkus) {
							Integer productType = orderSku.getProductType();
							request.setAttribute("productType", productType);
							Sku sku=new Sku();
						  if(productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_SKU||productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_CARD_RELL|| productType==IBSConstants.PRODUCT_TYPE_ELECTRON_CARD_RELL){
				    	      sku=skuManager.getByObjectId(orderSku.getProductId());
						    }
					      if(sku!=null && new Integer(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS).equals(sku.getReturnGoods())){
							 orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);						   
						  }else{
							// hr实体的
							if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND
										|| subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND
										|| subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS) {
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
									
								}
								// hr虚拟（IBS实体兑换券）
							} else if(productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_EXCHANGE_RELL) {
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND || subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS ||subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND) {
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
									
								}
								// hr虚拟（IBS电子兑换券）	
							}else if(productType==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL) {
						      if (subOrderSate==IBSConstants.ORDER_TO_BE_ISSUED_VIRTUAL|| subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS||subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND) {
						     	orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
						        
						      }						
		           			// hr第三方
						    } else if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_CARD
									|| productType==ProductConstants.PRODUCT_TYPE_ELECTRONICS_CARD) {
								orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
								
								// hr体检商品
							} else if (productType==IBSConstants.PHYSICAL_MATERIAL_EXCHANGE) {
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND || subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS ||subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND){
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);								
								}
							}else if(productType==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE){
								if (subOrderSate==IBSConstants.ORDER_TO_BE_ISSUED_VIRTUAL|| subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS||subOrderSate==IBSConstants.ORDER_ISSUED_IN_KIND) {
							     	orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							  }			
						   }
						}
					  }
					} else if (orderSource==IBSConstants.ORDER_SOURCE_STAFF||orderSource==IBSConstants.ORDER_SOURCE_WEIXIN) {
						for (OrderSku orderSku : orderSkus) {
							Integer productType = orderSku.getProductType();
							request.setAttribute("productType", productType);
							 Sku sku=new Sku();
							if(productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_SKU||productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_CARD_RELL|| productType==IBSConstants.PRODUCT_TYPE_ELECTRON_CARD_RELL){
					    	      sku=skuManager.getByObjectId(orderSku.getProductId());
							    }						 
							 if(sku!=null && new Integer(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS).equals(sku.getReturnGoods())){
									 orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
							  }
							 else{
							// 员工实体
							if ((productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT)&&(orderType==IBSConstants.ORDER_TYPE_POINT_BUY||orderType==IBSConstants.ORDER_TYPE_CASH_BUY)) {
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND
										|| subOrderSate==IBSConstants.ORDER_TO_BE_SHIPPED) {
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
									
								}
								// 员工虚拟（IBS福利）
							 }else if (productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_EXCHANGE_RELL
									|| productType==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL) {
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND || subOrderSate==IBSConstants.ORDER_SHIPPED_VIRTUAL || subOrderSate==IBSConstants.ORDER_TO_BE_SHIPPED) {
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							   }
								//体检
							} else if(orderType==IBSConstants.ORDER_TYPE_POINT_BUY && 
									(productType==IBSConstants.PHYSICAL_MATERIAL_EXCHANGE
									|| productType==IBSConstants.PHYSICAL_ELECTRONICS_EXCHANGE)){
								if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND || subOrderSate==IBSConstants.ORDER_SHIPPED_VIRTUAL || subOrderSate==IBSConstants.ORDER_TO_BE_SHIPPED){
									orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);
							   }		
							}// 第三方
							 else if(productType==ProductConstants.PRODUCT_TYPE_MATERIAL_CARD
									|| productType==ProductConstants.PRODUCT_TYPE_ELECTRONICS_CARD
									||(orderType==IBSConstants.ORDER_TYPE_EXCHANGE_WELFARE && productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT)){
								orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
							}
						 }
					  }
					}else if (orderSource==IBSConstants.ORDER_SOURCE_HOME){
						for (OrderSku orderSku : orderSkus) {
							Integer productType = orderSku.getProductType();
							request.setAttribute("productType", productType);
							Sku sku=new Sku();
						    if(productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_SKU||productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_CARD_RELL|| productType==IBSConstants.PRODUCT_TYPE_ELECTRON_CARD_RELL){
						    	  sku=skuManager.getByObjectId(orderSku.getProductId());
							 }
							if(sku!=null && new Integer(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS).equals(sku.getReturnGoods())){
								 orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
							}else
							 {
							// 官网福利兑换
							if (orderType==IBSConstants.ORDER_TYPE_EXCHANGE_WELFARE){
								 // 其他
									orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);			
							} else {// 非福利兑换
									// 实体
								if (productType==ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT) {
									if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND) {
										orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);										
									}
									//ibs
								} else if (productType==IBSConstants.PRODUCT_TYPE_PHYSICAL_EXCHANGE_RELL
										|| productType==IBSConstants.PRODUCT_TYPE_ELECTRON_EXCHANGE_RELL) {
									if (subOrderSate==IBSConstants.ORDER_SHIPPED_IN_KIND
											|| subOrderSate==IBSConstants.ORDER_TRADING_SUCCESS || subOrderSate==IBSConstants.ORDER_SHIPPED_VIRTUAL) {
										orderSku.setIsChangeProduct(IBSConstants.ORDER_RETURN_EXCHANGE_GOODS);										
									}
								}
								// 其他
								else {
									orderSku.setIsChangeProduct(IBSConstants.ORDER_NO_RETURN_EXCHANGE_GOODS);
								}
							}
						}
					  }
					}
					subOrder.setOrderProductList(orderSkus);
					request.setAttribute("subOrderNo", subOrderNo);
					request.setAttribute("order", order);
					request.setAttribute("subOrder", subOrder);
					request.setAttribute("changeType", changeType);
				}
			}
		}
		return "/order/editChangeOrder";
	}

	/**
	 * 退换货卡号信息
	 *
	 * @throws
	 */
	@RequestMapping(value = "/cardInfo")
	public String cardInfo(HttpServletRequest request, ChangeOrder t,
			Integer backPage) throws Exception {
		Long productId = Long.parseLong(request.getParameter("productId"));
		Long subOrderId = Long.parseLong(request.getParameter("subOrderId"));
		if(productId!=null && subOrderId!=null){
		CardCreInfoSubOrder cardCreInfoSubOrder =new CardCreInfoSubOrder();
		cardCreInfoSubOrder.setSubOrderId(subOrderId);
		List<CardCreInfoSubOrder>  cardObjectId =cardCreInfoSubOrderManager.getBySample(cardCreInfoSubOrder);
		if(cardObjectId.size()>0){
			String createInfoId = cardObjectId.get(0).getCardCreateId().toString();
			String changeNo = request.getParameter("changeNo")==null?"":request.getParameter("changeNo");
			return "redirect:/cardInfo/card/" + createInfoId + "?ajax=1&changeNo="+changeNo+"&index="+request.getParameter("num.index");
		}
		}
		return null;
	}

  @RequestMapping(value = "/getChangeOrderStatus")
  public String getChangeOrderStatus(HttpServletRequest request,ModelMap modelMap){
	  String changeId= request.getParameter("changeId");
		boolean flag  = false;
        ChangeOrder changeOrder=changeOrderManager.getByObjectId(Long.valueOf(changeId));
		if(changeOrder!=null){
			if(changeOrder.getOrderStatus()==IBSConstants.CHANGE_ORDER_REFUNDED){
				flag  = false;
			}
			else{
				flag  = true;
			}	  
			
		}
	    modelMap.addAttribute("result", flag);
		return "jsonView";
		}

	
    public void payAndUpdateOrderTimeInfo (Long subOrderId,Integer subOrderStatus){
    	SubOrderTimeInfo subOrderTimeInfo = new SubOrderTimeInfo();
		subOrderTimeInfo.setOperationTime(new Date());
		subOrderTimeInfo.setSubOrderId(subOrderId);
		subOrderTimeInfo.setSubOrderState(subOrderStatus);
		subOrderTimeInfo.setUserId(FrameworkContextUtils.getCurrentUserId());
		subOrderTimeInfoManager.save(subOrderTimeInfo);
    }
  
  
  
}
