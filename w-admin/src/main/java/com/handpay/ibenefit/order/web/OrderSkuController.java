package com.handpay.ibenefit.order.web;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IOrderSkuManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;

/**
 * @Title: OrderSkuController.java
 * @Package 
 * @Description: TODO
 * Copyright: Copyright (c) 2011 
 * 
 * @author Mac.Yoon
 * @date 2015-6-26 上午8:45:37
 * @version V1.0
 */

/**
 * @ClassName: OrderSkuController
 * @Description: TODO
 * @author Mac.Yoon
 * @date 2015-6-26 上午8:45:37
 *
 */
@Controller
@RequestMapping("orderSku")
public class OrderSkuController extends PageController<OrderSku>{

	@Reference(version="1.0")
	private IOrderSkuManager orderSkuManager;
	@Reference(version="1.0")
	private ISubOrderManager subOrderManager;
	
	@Override
	public Manager<OrderSku> getEntityManager() {
		return orderSkuManager;
	}
	
	@Override
	public String getFileBasePath() {
		return null;
	}

	
	@RequestMapping("getOrderSkusBySubOrderNo/{subOrderNo}")
	public String getOrderSkusBySubOrderNo(HttpServletRequest request,@PathVariable String subOrderNo,ModelMap modelMap){
		SubOrder subOrder = subOrderManager.getBySubOrderNo(subOrderNo);
		if(subOrder==null){
			modelMap.put("message", "请检查订单号是否有误");
			modelMap.put("result", false);
		}else{
			OrderSku orderSku = new OrderSku();
			orderSku.setSubOrderId(subOrder.getObjectId());
			List<OrderSku> orderSkus = orderSkuManager.getBySample(orderSku);
			modelMap.put("generalOrderId", subOrder.getGeneralOrderId());
			modelMap.put("supplierId", subOrder.getSupplierId());
			modelMap.put("orderSkus", orderSkus);
			modelMap.put("orderId", subOrder.getObjectId());
			modelMap.put("result", true);
		}
		return "jsonView";
	}
}
