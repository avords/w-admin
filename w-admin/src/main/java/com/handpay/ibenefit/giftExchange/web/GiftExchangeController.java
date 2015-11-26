package com.handpay.ibenefit.giftExchange.web;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IExchangeManger;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.entity.WelfarePackageCategory;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageCategoryManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

/**
 * 运营端 - 礼券兑换
 * @author zhliu
 * @date 2015年6月8日
 * @parm
 */

@Controller
@RequestMapping("/giftExchange")
public class GiftExchangeController {

	Logger logger = Logger.getLogger(GiftExchangeController.class);
	
	@Reference(version="1.0")
	private IExchangeManger exchangeManger;
	@Reference(version="1.0")
	private IWelfarePackageManager welfarePackageManager;
	@Reference(version="1.0")
	private ISkuPublishManager skuPublishManager;
	@Reference(version="1.0")
	private ICardInfoManager cardInfoManager;
	@Reference(version="1.0")
	private IOrderManager orderManager;
	@Reference(version="1.0")
	private IWelfarePackageCategoryManager welfarePackageCategoryManager;
	@Reference(version="1.0")
	private ISubOrderManager subOrderManager;
	
	/**
	 * 礼券兑换 入口
	 * @author zhliu
	 * @date 2015年6月8日
	 * @parm
	 * @return
	 */
	
	@RequestMapping("/index")
	public String index(){
		return "giftExchange/giftExchangeIndex";
	}
	
	
	/**
	 * 兑换功能--卡号密码校验
	 * 卡密状态信息(0：待激活 1：激活 2：冻结 3：已过期 4：已使用 5：已作废 6：已删除)
	 * 
	 * @param request
	 * @param cardInfo
	 * @return
	 * @throws IOException 
	 */
	@RequestMapping(value = "/validateCard")
	public String validateCard(HttpServletRequest request,HttpServletResponse response, CardInfo cardInfo) throws IOException {
		logger.info("卡号密码校验!!!" + cardInfo.getCardNo() + "==" + cardInfo.getPassWord());
		try {
			/**
			 * 步骤一、卡号密码校验
			 */
			Map<String, String> map = exchangeManger.checkCard(cardInfo);
			String status = map.get("status"); // 卡状态
			String msg = map.get("msg"); // 卡状态描述
			String code = map.get("code"); // 卡密状态为1-待激活 code:套餐ID 卡密状态为4-已使用 code:子订单号
			List<SkuPublish> skuList = new ArrayList<SkuPublish>();
			// 激活状态
			if (!"".equals(status) && "1".equals(status)) {
				// 卡号密码校验通过之后，将登录信息存放到session，订单入库时使用
				request.getSession().setAttribute("cardNo",cardInfo.getCardNo());
				request.getSession().setAttribute("passWord",cardInfo.getPassWord());
				
				if(code !=null && !"".equals(code)){  //套餐ID
					logger.info("code==" + code);
					//查询套擦信息
					WelfarePackage welfarePackage = welfarePackageManager.getByObjectId(Long.valueOf(code));
					WelfarePackageCategory category = welfarePackageCategoryManager.getByObjectId(welfarePackage.getWpCategoryId());

					// 根据套餐ID查询出相关的商品信息
					Map parmmap = new HashMap();
					parmmap.put("packageId", code);
					skuList = skuPublishManager.findWelfarePackageSkuForPackageId(parmmap);
					
					request.setAttribute("skuList", skuList);
					request.setAttribute("welfarePackage", welfarePackage);
					request.setAttribute("category", category);
					
				}
			}else if (!"".equals(status) && "4".equals(status)) {// 已使用
				if(code !=null && !"".equals(code)){   //子订单号
					logger.info("code==" + code);
					//根据子订单号查询订单详细信息
					return this.subOrderDetail(request,code);
				}
			}else {// 其它状态不合法 则跳转到兑换登录页显示对应的错误提示
				request.setAttribute("msg", msg);
				return "giftExchange/giftExchangeIndex";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "系统异常");
			return "giftExchange/giftExchangeIndex";
		}
		// 跳转到兑换页面
		return "giftExchange/giftExchangeInfo";
	}
	
	
	
	
	
	/**
	 * 填写 收货信息； 及所选择商品信息
	 * @param request
	 * @param proSkuId : 商品ID
	 * @param stockType : 套餐库存类型(1：实体兑换券;2：电子兑换券)
	 * @param wpCategoryType : (套餐类型 1：弹性套餐2：固定套餐)
	 * @param welfarePackageId : 套餐Id
	 * @author zhliu
	 * @return
	 */
	@RequestMapping("/confirmExGoods")
	public String orderInfo(HttpServletRequest request,String proSkuIds,String welfarePackageId){
		
		try {
			List<Sku>  skuList= new ArrayList<Sku>();
			List<SkuPublish> skuPublishList = new ArrayList<SkuPublish>();
			int stockType = 1;//实体兑换券 需要填写 收货地址(1：实体兑换券2：电子兑换券) 
			
			
			WelfarePackage welfarePackage = new WelfarePackage();
			logger.info("所选商品Id："+proSkuIds);
			if(proSkuIds.endsWith(",")){
				proSkuIds= proSkuIds.substring(0, proSkuIds.lastIndexOf(","));
			}
			
			
			
			//查询所选的商品信息
			Map map = new HashMap();
			map.put("proSkuIds", proSkuIds);
			skuPublishList = skuPublishManager.findWelfarePackageSkuForPordIds(map);
			welfarePackage = welfarePackageManager.getByObjectId(Long.valueOf(welfarePackageId));
			WelfarePackageCategory category = welfarePackageCategoryManager.getByObjectId(welfarePackage.getWpCategoryId());
			if(welfarePackage.getWpCategoryType()==2){//套餐类型为"固定套餐":收货信息 同 "套餐库存类型"一致（套餐库存类型(1：实体兑换券2：电子兑换券)
				for (SkuPublish sku : skuPublishList) {
					if(sku.getType() == ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT||sku.getType()==ProductConstants.PRODUCT_TYPE_MATERIAL_CARD){
						stockType = 1;
						break;
					}else{
						stockType = 2;
					}
				}
			}else{//否则 ：收货信息 同 "商品类型"一致
				if(skuPublishList != null && skuPublishList.size() >0){
					stockType = skuPublishList.get(0).getType();
					if(stockType == ProductConstants.PRODUCT_TYPE_MATERIAL_OBJECT||stockType==ProductConstants.PRODUCT_TYPE_MATERIAL_CARD){
						stockType = 1;
					}else{
						stockType = 2;
					}
				}
			}
			request.setAttribute("skuPublishList", skuPublishList);
			request.setAttribute("proSkuIds", proSkuIds);
			request.setAttribute("welfarePackage", welfarePackage);
			request.setAttribute("stockType", stockType);
			request.setAttribute("category", category);
		} catch (Exception e) {
			e.printStackTrace();
		}
		
		return "giftExchange/confirmExGoods";
	}
	
	
	
	/**
	 * 创建 礼品兑换 子订单
	 * @param response
	 * @param request
	 * @param order
	 * @param proSkuIds :所选中的 商品Id
	 * @param welfarePackageId : 福利套餐ID
	 * @author zhliu
	 * @return
	 */
	@RequestMapping("/createSubOrder")
	public String createSubOrder (HttpServletRequest request,Order order,String proSkuIds,String welfarePackageId){
		Map resultMap = new HashMap();
		Order resultOrder = null;
		
		String province = request.getParameter("province");//省份
		String city = request.getParameter("city");//市
		String area = request.getParameter("county");//区
		try {
			order.setReceiptAddress(province+" "+city+" "+area+" "+order.getReceiptAddress());
			String cardNo = (String) request.getSession().getAttribute("cardNo");
			String passWord = (String) request.getSession().getAttribute("passWord");
			User user = (User) request.getSession().getAttribute("s_user");	
			//生成订单
			order.setOrderSource(IBSConstants.ORDER_SOURCE_ADMIN);
			resultMap = exchangeManger.createSubOrder(order,proSkuIds,cardNo,passWord,welfarePackageId,user);
			
			if(resultMap.get("code")!=null && resultMap.get("code").toString().equals("0")){
				resultOrder = (Order) resultMap.get("resultOrder");
				return "redirect:createSubOrderSuc/"+resultOrder.getObjectId();
			}else{
				request.setAttribute("resultMap", resultMap);
				logger.error("卡号"+cardNo+"兑换失败");
				return "giftExchange/createSubOrderFailure";
			}
		} catch (Exception e) {
			e.printStackTrace();
			resultMap.put("msg", "系统异常");
		}
		request.setAttribute("resultMap", resultMap);
		return "giftExchange/createSubOrderFailure";
	}
	
	
	
	
	
	
	/**
	 * 礼品兑换成功
	 * @author zhliu
	 * @date 2015年6月29日
	 * @parm
	 * @param request
	 * @param ObjectId
	 * @return
	 */
	@RequestMapping("createSubOrderSuc/{ObjectId}")
	public String createSubOrderSuc(HttpServletRequest request,@PathVariable Long ObjectId){
		
		try {
			
			Order order = new Order();
			
			order = orderManager.getByObjectId(ObjectId);
			
			SubOrder sample = new SubOrder();
			sample.setGeneralOrderId(ObjectId);
			List<SubOrder> subOrderList= subOrderManager.getBySample(sample);
			
			
			request.setAttribute("subOrderList", subOrderList);
			request.setAttribute("order", order);
			
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "giftExchange/createSubOrderSuccess"; 
	}
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	
	/**
	 * 根据 子订单号查询订单详细
	 * @param subOrderNo :总订单号
	 * @param cardNo :卡号
	 * @author zhliu
	 * @return
	 */
	@RequestMapping("/subOrderDetail")
	public String subOrderDetail(HttpServletRequest request,String orderNo){
		try {
			
			List<SubOrder> subOrderes = new ArrayList<SubOrder>();
			Map parmmap = new HashMap();
			String iscancel = "1";//取消兑换按钮判断(1：是；2否)
			String isAllWaitSend = "1";//是否所有的子订单 为 待发货(1：是；2否)
			
			//根据 总订单号查询总订单信息
			Order order = new Order();
			order.setGeneralOrderNo(orderNo);
			List<Order> orderList = orderManager.getBySample(order);
			if(orderList.size()>0){
				order = orderList.get(0);
			}
			//查询订单信息
			if(StringUtils.isNotEmpty(orderNo)){
				parmmap.put("generalOrderNo", orderNo);
				subOrderes = exchangeManger.subOrderDetail(parmmap);
			}
			
			for (SubOrder sub:subOrderes) {
				if(sub.getSubOrderType() == IBSConstants.SUB_ORDER_TYPE_ELECTRON){//虚拟商品不可取消兑换
					iscancel = "2";
				}
				if(sub.getSubOrderState() != IBSConstants.ORDER_TO_BE_SHIPPED){
					isAllWaitSend="2";
				}
			}
			
			
			//查询卡号信息
			
			parmmap.put("cardNo", order.getCashCard());
			List<CardInfo> cardInfoList = cardInfoManager.findCardInfoAndPackageInfo(parmmap);
			
			
			
			request.setAttribute("subOrderes", subOrderes);
			request.setAttribute("cardInfoList", cardInfoList);
			request.setAttribute("order", order);
			request.setAttribute("iscancel", iscancel);
			request.setAttribute("isAllWaitSend", isAllWaitSend);
			
			
		} catch (Exception e) {
			logger.info("GiftExchangeController--subOrderDetail异常");
			e.printStackTrace();
		}
		
		return "giftExchange/subOrderDetail";
	}
	
	
	
	
	
	
	/**
	 * 取消兑换
	 * @author zhliu
	 * @date 2015年6月10日
	 * @param orderId ： 总订单ID
	 * @return
	 */
	@RequestMapping(value="/cancelOrder",method = RequestMethod.POST)
	public String cancelOrder(HttpServletRequest request,String orderId){
		
		Map resultMap = new HashMap();
		String msg = "";
		String code = "";
		
		
		User user = (User) request.getSession().getAttribute("s_user");	
		
		try {
			if(StringUtils.isNotEmpty(orderId)){
				//更新总订单状态
				Order order = orderManager.getByObjectId(Long.valueOf(orderId));
				if (order!=null) {
					order.setOrderStatus(IBSConstants.ORDER_CANCEL_EXCHANGE);
					orderManager.save(order);
					
					SubOrder subOrder = new SubOrder();
					subOrder.setGeneralOrderId(order.getObjectId());
					List<SubOrder> subOrderList = subOrderManager.getBySample(subOrder);
					for (SubOrder subOrderTemp:subOrderList) {
						orderManager.updateOrderStatus(subOrderTemp.getObjectId(),user.getObjectId(),IBSConstants.ORDER_CANCEL_EXCHANGE);
					}
					
					
					
					//更新卡密状态
					CardInfo cardInfo = new CardInfo();
					cardInfo.setCardNo(order.getCashCard());
					List<CardInfo> cardInfoList =  cardInfoManager.getBySample(cardInfo);
					for (CardInfo cardInfoTemp : cardInfoList) {
						cardInfoTemp.setCardStatus(1);
						cardInfoTemp.setUpdateUser(user.getUserName());
						cardInfoTemp.setStaffId(user.getObjectId());
						cardInfoManager.save(cardInfoTemp);
						logger.info("取消兑换--更新卡号信息");
					}
					
					msg = "取消兑换成功！";
					code = "1";
				}else{
					msg = "取消兑换失败，总订单不存在";
					code = "-1";
				}
				
			}else{
				msg = "取消兑换失败";
				code = "-1";
			}
			
			
		} catch (Exception e) {
			msg = "取消兑换失败";
			code = "-1";
			e.printStackTrace();
			logger.info("cancelOrder异常");
		}
		
		resultMap.put("msg", msg);
		resultMap.put("code", code);
		request.setAttribute("resultMap", resultMap);
		
		return "giftExchange/cancelOrderSuccess";
	}

	
	
	
	
	
	
	/**
	 * 根据商品子表的productId查询商品表里的商品详情
	 * 
	 * @param request
	 * @param productId
	 * @return
	 */
	@RequestMapping(value = "/queryProdInfo")
	public String queryProdInfo(HttpServletRequest request, long productId) {
		try {
			logger.info("查询商品表里的商品详情productId==" + productId);
			Product product = exchangeManger.queryProdInfo(productId);
			request.setAttribute("product", product);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return "giftExchange/productInfo";
	}
	
	
	
	
}
