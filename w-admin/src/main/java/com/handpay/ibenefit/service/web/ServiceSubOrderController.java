package com.handpay.ibenefit.service.web;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ISubOrderManager;

/** 
 * @desc 订单管理-子订单查询&订单详情
 * @author huyuanyuan  
 * @date 
 */

@Controller
@RequestMapping("/serviceSubOrder")
public class ServiceSubOrderController extends PageController<SubOrder>{

	private static final String BASE_DIR = "service/";
	
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;
	
	@Override
	public Manager<SubOrder> getEntityManager() {
		return subOrderManager;
	}


	
	@Override
	public String getFileBasePath() {		
		return BASE_DIR;
	}

	
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		if(page1.getFilters().size()==0){
			page.setTotalCount(0);
			page.setList(new ArrayList<SubOrder>());
		}else{
			PageSearch result = subOrderManager.findSubOrder(page1);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
		}
		
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		request.getSession().setAttribute("action", "/subOrder/page");
		return getFileBasePath() + "listServiceSubOrder";
	}

	
	
}
