package com.handpay.ibenefit.order.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;
import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderChaAddr;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IOrderChaAddrManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;


@Controller
@RequestMapping("/supplierOrder")
public class VendorSupplierOrderController extends PageController<SubOrder> {
	private static final String BASE_DIR = "order/";
	
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;
	
	@Reference(version = "1.0")
	private IOrderProductManager orderProductManager ;
	
	@Reference(version = "1.0")
	private IOrderChaAddrManager orderChaAddrManager ;
	
	
	@Reference(version = "1.0")
	private IOrderManager orderManager  ;
		
	@Reference(version = "1.0")
	private IUserManager userManager  ;
	
	@Override
	public Manager<SubOrder> getEntityManager() {		
		return subOrderManager;
	}
	
	@Override
	public String getFileBasePath() {	
		return BASE_DIR;
	}

	//供应商端查询订单信息
	@RequestMapping(value = "/query")
	public String linePayOrder(HttpServletRequest request, SubOrder t) {
		Long userId = FrameworkContextUtils.getCurrentUserId();
	    User user=userManager.getByObjectId(userId);		
	if( user.getPlatform()==IBSConstants.PLATEFORM_SUPPLIER){
		 String supplierId=user.getCompanyId().toString();
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter(SubOrder.class.getName(), "EQL_supplierId",supplierId));
		PageSearch 	result = subOrderManager.findOrder(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		}
		return "order/listSupplierOrder";
	}
	

	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {		
		   if(objectId!=null){			 
			   SubOrder suborder=subOrderManager.getByObjectId(objectId);
			   if(suborder!=null){
				  List<OrderSku> orderSkus=orderProductManager.getOrderProductBySubOrderId(suborder.getObjectId());
				  request.setAttribute("orderSkus",orderSkus );				 				  
				  Order order=orderManager.getByObjectId(suborder.getGeneralOrderId());			   
				  request.setAttribute("order",order );
			   }
				//得到更改的地址记录信息
			   OrderChaAddr orderChaAddr=orderChaAddrManager.getAddrBySubOrderId(objectId);			   
			   request.setAttribute("orderChaAddr",orderChaAddr );				   			  	
			   request.setAttribute("suborder",suborder );
			   request.setAttribute("objectId",objectId );
			   
		 }		   
		   
		return "order/editSupplierOrder";
	}
	
	
	@RequestMapping(value = "/saveOrder")
	public String saveOrder(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap){	
		Long logisticsCompany=Long.parseLong(request.getParameter("logisticsCompany"));		
		String logisticsNo=request.getParameter("logisticsNo");
	    Long object= Long.parseLong(request.getParameter("subOrderId"));
	    Map<String, Object> param = new HashMap<String, Object>();
	       param.put("subOrderState", IBSConstants.ORDER_SHIPPED_IN_KIND);
	       param.put("logisticsNo", logisticsNo);
	       param.put("logisticsCompany", logisticsCompany);
	       param.put("object", object);	       
	    subOrderManager.updateSubOrder(param);	    
	    modelMap.addAttribute("result", true);
		return "jsonView";
		
	}  
	
	@RequestMapping(value = "/handleChangeOrder")
	public String handleChangeOrder(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap){
		
		Long subOrderId= Long.parseLong(request.getParameter("subOrderId"));
		  Map<String, Object> param = new HashMap<String, Object>();
		  param.put("subOrderId", subOrderId);	
		  param.put("orderEditState", IBSConstants.CHANGE_ORDER_RECEIVE_ADDRESS_HANDLED);	
		  subOrderManager.handleChangeOrder(param);
		  modelMap.addAttribute("result", true);
		return "jsonView";
		
	}
	
	
}
