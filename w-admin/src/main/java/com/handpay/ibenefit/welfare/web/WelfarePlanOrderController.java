package com.handpay.ibenefit.welfare.web;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.ExcelUtil;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.member.service.ICompanyDepartmentManager;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.plan.entity.WelfarePlan;
import com.handpay.ibenefit.plan.entity.WelfareSubPlan;
import com.handpay.ibenefit.plan.entity.WelfareSubPlanItem;
import com.handpay.ibenefit.plan.service.IWelfarePlanManager;
import com.handpay.ibenefit.plan.service.IWelfareSubPlanItemManager;
import com.handpay.ibenefit.plan.service.IWelfareSubPlanManager;
import com.handpay.ibenefit.plan.service.IWelfareSubPlanStaffItemManager;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.service.IWelfareItemManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("/welfarePlanOrder")
public class WelfarePlanOrderController extends PageController<WelfarePlan> {

	private static final String BASE_DIR = "welfarePlanOrder/";

	@Reference(version = "1.0")
	private IWelfarePlanManager welfarePlanManager;
	@Reference(version = "1.0")
	private IOrderManager orderManager;
	@Reference(version = "1.0")
	private IOrderProductManager productOrderManager;
	@Reference(version = "1.0")
	private IUserManager userManager;
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;
	@Reference(version = "1.0")
	private IWelfareSubPlanManager welfareSubPlanManager;
	@Reference(version = "1.0")
	private IWelfareItemManager welfareItemManager;
	@Reference(version = "1.0")
	private IWelfareSubPlanItemManager welfareSubPlanItemManager;
	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager;
	@Reference(version = "1.0")
	private ISkuPublishManager skuPublishManager;
	@Reference(version = "1.0")
	private IDictionaryManager dictionaryManager;
	@Reference(version = "1.0")
	private IWelfareSubPlanStaffItemManager welfareSubPlanStaffItemManager;
	@Reference(version ="1.0")
    private ICompanyDepartmentManager companyDepartmentManager;
	
	@Override
	public Manager<WelfarePlan> getEntityManager() {
		return welfarePlanManager;
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
		WelfarePlan welfarePlan = welfarePlanManager.getByObjectId(objectId);
		User user = userManager.getByObjectId(welfarePlan.getCreatedBy());
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
		Double allPayment = 0D;
		List<Order> orderList = new ArrayList<Order>();
		List<WelfareSubPlan> welfareSubPlanList = welfareSubPlanManager.getWelfareSubPlans(objectId);
		if (welfareSubPlanList!=null && welfareSubPlanList.size()>0) {
			for (WelfareSubPlan w : welfareSubPlanList) {
				WelfareItem wi = welfareItemManager.getByObjectId(w.getWelfareItemId());
        		if (wi != null) {
        			w.setWelfareItemName(wi.getItemName());
        		}
        		WelfareSubPlanItem wsi = new WelfareSubPlanItem();
        		wsi.setSubPlanId(w.getObjectId());
        		List<WelfareSubPlanItem> wsis = welfareSubPlanItemManager.getBySample(wsi);
        		if (wsis != null && wsis.size()>0) {
        			for(WelfareSubPlanItem ws:wsis){
        				if(ws.getType().equals((short)1)){
        					WelfarePackage wp = welfarePackageManager.getPackagePrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), ws.getGoodsId());
        					ws.setGoodsName(wp.getPackageName());
        				}else if(ws.getType().equals((short)3)){
        					SkuPublish sku = skuPublishManager.getSkuPublishPrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), ws.getGoodsId());
        					if (sku.getAttributeValue1()!=null && sku.getAttributeValue2() !=null) {
        						ws.setGoodsName(sku.getName()+"("+sku.getAttributeValue1()+"+"+sku.getAttributeValue2()+")");
        					}else if (sku.getAttributeValue1()!=null && sku.getAttributeValue2() ==null){
        						ws.setGoodsName(sku.getName()+"("+sku.getAttributeValue1()+")");
        					}else if (sku.getAttributeValue1()==null ){
        						ws.setGoodsName(sku.getName());
        					}
        				}else if(ws.getType().equals((short)5)){
    						ws.setGoodsName(ws.getName());
    					}
        				if (ws.getSubOrderId()!=null) {
        					SubOrder subOrderTemp = subOrderManager.getByObjectId(ws.getSubOrderId());
        					ws.setSubOrderState(subOrderTemp.getSubOrderState());
        				}
        				
        				if (ws.getIsDefault()) {
        					w.setHasDefault(true);
        				}
        			}
        			w.setWelfareSubPlanItems(wsis);
        		}else{
        			wsis = null;
        		}
        		//
        		Long orderId = w.getOrderId();
				if (orderId!=null) {
					Order order = orderManager.getByObjectId(orderId);
					orderList.add(order);
				}
				//
				List<SubOrder> subOrderList = subOrderManager.getSubOrderObjectIdByGeneralOrderID(orderId);
				if (subOrderList!=null && subOrderList.size()>0) {
					for (SubOrder subOrder : subOrderList) {
						Double actuallyAmount = subOrder.getActuallyAmount();
						Double actuallyIntegral = subOrder.getActuallyIntegral();
						if (actuallyAmount!= null) {
							allPayment = allPayment + actuallyAmount;
						}
						if (actuallyIntegral != null) {
							allPayment = allPayment + actuallyIntegral;
						}
					}
				}
			}
		}
		
		Set<Integer> payWayList = new HashSet<Integer>();
		if (orderList !=null && orderList.size()>0) {
			for (Order o : orderList) {
				if (o.getPaymentWay()!=null) {
					payWayList.add(o.getPaymentWay());
				}
			}
			request.setAttribute("payWayList", payWayList);
		}
		request.setAttribute("view", 1);
		request.setAttribute("welfarePlan", welfarePlan);
		request.setAttribute("welfareSubPlanList", welfareSubPlanList);
		request.setAttribute("orderList", orderList);
		request.setAttribute("allPayment", allPayment);
		return getFileBasePath() + "editWelfarePlanOrder";
	}

	/*
	 *
	 * 订单查询界面列表显示
	 */
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		PageSearch result = welfarePlanManager.getWelfarePlanOrderList(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listWelfarePlanOrder";
	}
	
	@RequestMapping("/editPolicy/{planId}")
	public String editPolicy(HttpServletRequest request,HttpServletResponse response,@PathVariable Long planId ){
		WelfarePlan welfarePlan = welfarePlanManager.getByObjectId(planId);
		request.setAttribute("welfarePlan", welfarePlan);
		return BASE_DIR+"editPolicy";
	}
	
	@RequestMapping("/savePolicy")
	public String savePolicy(HttpServletRequest request,HttpServletResponse response){
		String planId = request.getParameter("planId");
		String overplusStrategy = request.getParameter("overplusStrategy");
		WelfarePlan welfarePlan = welfarePlanManager.getByObjectId(Long.parseLong(planId));
		if (welfarePlan!=null) {
			welfarePlan.setOverplusStrategy(Short.parseShort(overplusStrategy));
			welfarePlan = this.save(welfarePlan);
		}
		return "redirect:/welfarePlanOrder/view/"+welfarePlan.getObjectId();
	}
	
	@RequestMapping("exportAll")
	public String exportAll(HttpServletRequest request, HttpServletResponse response,PageSearch page) throws Exception {
		String[] titles={"序号","计划状态","企业名称","年份","计划名称","支付方式","付款金额","付款积分","付款操作人"};
		PageSearch page1 = preparePage(request);
		page1.setPageSize(Integer.MAX_VALUE);
		PageSearch result = welfarePlanManager.getWelfarePlanOrderList(page1);
		page.setTotalCount(result.getTotalCount());
		List<WelfarePlan> list = result.getList();
		List<Dictionary> dictionaries = dictionaryManager.getDictionariesByDictionaryId(1610);
		Map<Integer,String> valid = new HashMap<Integer,String>();
		for(Dictionary dictionary : dictionaries){
			if(dictionary.getStatus()!=null && dictionary.getStatus()){
				valid.put(dictionary.getValue(), dictionary.getName());
			}
		}
		List<Dictionary> dictionariesPay = dictionaryManager.getDictionariesByDictionaryId(1403);
		Map<Integer,String> validPay = new HashMap<Integer,String>();
		for(Dictionary dictionary : dictionariesPay){
			if(dictionary.getStatus()!=null && dictionary.getStatus()){
				validPay.put(dictionary.getValue(), dictionary.getName());
			}
		}
		List<Object[]> datas = new ArrayList<Object[]>();
		for (int i=0;i<list.size();i++) {
			WelfarePlan welfarePlan = list.get(i);
			Object[] arr = new Object[9];
			arr[0] = i+1;
			arr[1] = valid.get(welfarePlan.getStatus().intValue()) ;
			arr[2] = welfarePlan.getCompanyName();
			arr[3] = welfarePlan.getYear();
			arr[4] = welfarePlan.getName();
			if (welfarePlan.getPaymentWay()!=null && !"".equals(welfarePlan.getPaymentWay())) {
				arr[5] = welfarePlan.getPaymentWay();
			}
			arr[6] = welfarePlan.getActuallyAmount();
			arr[7] = welfarePlan.getActuallyIntegral();
			arr[8] = welfarePlan.getUserName();
			datas.add(arr);
		}
		
		String exportName = "";
		exportName = FileUpDownUtils.encodeDownloadFileName(request, "福利计划订单查询_"+new Date().getTime()+".xls");
		ExcelUtil excelUtil=new ExcelUtil();
		excelUtil.exportExcel(response, datas, titles, exportName);
		return null;
	}
	
	@RequestMapping("/help")
	public String help(HttpServletRequest request,HttpServletResponse response){
		return BASE_DIR+"help";
	}
	
	@RequestMapping("/list")
	public String list(HttpServletRequest request,HttpServletResponse response, PageSearch page){
		PageSearch page1 = preparePage(request);
		PageSearch result = welfarePlanManager.getCheckWelfarePlanOrderList(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return BASE_DIR+"checkListWelfarePlanOrder";
	}
	
	@RequestMapping("/subDetial/{subOrderId}")
	public String subDetial(HttpServletRequest request,HttpServletResponse response,@PathVariable Long subOrderId){
		WelfareSubPlan welfareSubPlan = new WelfareSubPlan();
		welfareSubPlan.setOrderId(subOrderId);
		List<WelfareSubPlan> welfareSubPlanList = welfareSubPlanManager.getBySample(welfareSubPlan);
		if (welfareSubPlanList!=null && welfareSubPlanList.size()>0) {
			WelfareSubPlan w = welfareSubPlanList.get(0);
//		}
//		WelfareSubPlanItem wspi = new WelfareSubPlanItem();
//		wspi.setSubOrderId(subOrderId);
//		List<WelfareSubPlanItem> wspiList = welfareSubPlanItemManager.getBySample(wspi);
//		if (wspiList!= null && wspiList.size()>0) {
//			WelfareSubPlanItem wspiTemp = wspiList.get(0);
//			WelfareSubPlan w = welfareSubPlanManager.getByObjectId(wspiTemp.getSubPlanId());
			WelfareItem wi = welfareItemManager.getByObjectId(w.getWelfareItemId());
			if (wi != null) {
				w.setWelfareItemName(wi.getItemName());
			}
			WelfareSubPlanItem wsi = new WelfareSubPlanItem();
			wsi.setSubPlanId(w.getObjectId());
			List<WelfareSubPlanItem> wsis = welfareSubPlanItemManager.getBySample(wsi);
			if (wsis != null && wsis.size()>0) {
				for(WelfareSubPlanItem ws:wsis){
					if(ws.getType().equals((short)1)){
						WelfarePackage wp = welfarePackageManager.getPackagePrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), ws.getGoodsId());
						ws.setGoodsName(wp.getPackageName());
					}else if(ws.getType().equals((short)3)){
						SkuPublish sku = skuPublishManager.getSkuPublishPrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), ws.getGoodsId());
						if (sku.getAttributeValue1()!=null && sku.getAttributeValue2() !=null) {
    						ws.setGoodsName(sku.getName()+"("+sku.getAttributeValue1()+"+"+sku.getAttributeValue2()+")");
    					}else if (sku.getAttributeValue1()!=null && sku.getAttributeValue2() ==null){
    						ws.setGoodsName(sku.getName()+"("+sku.getAttributeValue1()+")");
    					}else if (sku.getAttributeValue1()==null ){
    						ws.setGoodsName(sku.getName());
    					}
					}else if(ws.getType().equals((short)5)){
						ws.setGoodsName(ws.getName());
					}
					if (ws.getSubOrderId()!=null) {
    					SubOrder subOrderTemp = subOrderManager.getByObjectId(ws.getSubOrderId());
    					ws.setSubOrderState(subOrderTemp.getSubOrderState());
    				}
					if (ws.getIsDefault()) {
						w.setHasDefault(true);
					}
				}
				w.setWelfareSubPlanItems(wsis);
			}else{
				wsis = null;
			}
			request.setAttribute("welfareSubPlan", w);
		}else{
			request.setAttribute("welfareSubPlan", null);
		}
		return BASE_DIR+"subDetialWelfarePlanOrder";
	}
	
	@RequestMapping("exportUserSelect/{planId}")
	public String exportUserSelect(HttpServletRequest request, HttpServletResponse response, @PathVariable Long planId) throws Exception {
	    WelfarePlan welfarePlan = welfarePlanManager.getByObjectId(planId);
        PageSearch pageSearch = PageUtils.getPageSearch(request);
        pageSearch.getFilters().add(new PropertyFilter("","EQL_planId",planId + ""));
        pageSearch.setPageSize(Integer.MAX_VALUE);
        pageSearch = welfareSubPlanStaffItemManager.exportWelfarePlanStaffSelect(pageSearch);
        String exportName = welfarePlan.getName() + "员工选择.xls";
//        Double point = userManager.getUserBalance(FrameworkContextUtils.getCurrentUserId());

        HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象
        HSSFSheet sheet=wb.createSheet("员工导入模板");
        CellStyle style = getStyle(wb);
//        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 3);
//        sheet.addMergedRegion(range);
//        Row row0 = sheet.createRow(0);
//        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
//        cell00.setCellStyle(style);
//        cell00.setCellValue("说明：当前可用余额：" + point);

        Row row1 = sheet.createRow(0);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("年份");
        sheet.autoSizeColumn(0);

        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("员工工号");
        sheet.autoSizeColumn(1);

        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("子计划名称");
        sheet.autoSizeColumn(2);

        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("选择项");
        sheet.autoSizeColumn(3);

        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
        cell4.setCellStyle(style);
        cell4.setCellValue("姓名");
        sheet.autoSizeColumn(4);

        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
        cell5.setCellStyle(style);
        cell5.setCellValue("部门");
        sheet.autoSizeColumn(5);

        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
        cell6.setCellStyle(style);
        cell6.setCellValue("额度");
        sheet.autoSizeColumn(6);

        short row = 1;
        for(Map map : (List<Map>)pageSearch.getList()){
            row1 = sheet.createRow(row++);
            //年份
            cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
            cell0.setCellStyle(style);
            cell0.setCellValue(welfarePlan.getYear().toString());
            sheet.autoSizeColumn(0);
            //员工工号
            cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
            cell1.setCellStyle(style);
            cell1.setCellValue(map.get("WORK_NO").toString());
            sheet.autoSizeColumn(1);
            //子计划名称
            cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
            cell2.setCellStyle(style);
            cell2.setCellValue(map.get("SUB_PLAN_NAME").toString());
            sheet.autoSizeColumn(2);
            //选择项名称
            cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
            cell3.setCellStyle(style);
            Long goodsId = Long.parseLong(map.get("GOODS_ID").toString());
            Short type = Short.parseShort(map.get("TYPE").toString());
            if(type.equals((short)1)){
                WelfarePackage wp = welfarePackageManager.getPackagePrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), goodsId);
                cell3.setCellValue(wp.getPackageName());
            }else if(type.equals((short)3)){
                SkuPublish sku = skuPublishManager.getSkuPublishPrice(FrameworkContextUtils.getCurrentUser().getCompanyId(), goodsId);
                cell3.setCellValue(sku.getName()+"("+(sku.getAttributeValue1()==null?"":sku.getAttributeValue1())+(sku.getAttributeValue2()==null?"":(","+sku.getAttributeValue2()))+")");
            }else if(type.equals((short)5)){
                cell3.setCellValue(map.get("GOODS_NAME").toString());
            }
            sheet.autoSizeColumn(3);
            //姓名
            cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
            cell4.setCellStyle(style);
            cell4.setCellValue(map.get("USER_NAME").toString());
            sheet.autoSizeColumn(4);
            //部门
            cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
            cell5.setCellStyle(style);
            Long departmentId = Long.parseLong(map.get("DEPARTMENT_ID").toString());
            CompanyDepartment department = null;
            if(departmentId!=null){
                department = companyDepartmentManager.getByObjectId(departmentId);
            }
            if(department!=null){
                cell5.setCellValue(department.getName());
            }else{
                cell5.setCellValue("");
            }
            sheet.autoSizeColumn(5);
            //额度
            cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
            cell6.setCellStyle(style);
            cell6.setCellValue(map.get("QUOTA").toString());
            sheet.autoSizeColumn(6);
        }
        FileUpDownUtils.setDownloadResponseHeaders(response, FileUpDownUtils.encodeDownloadFileName(request, exportName));
        wb.write(response.getOutputStream());
        return null;
	}
	
	private CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 设置单元格字体
		Font headerFont = workbook.createFont(); // 字体
		headerFont.setFontHeightInPoints((short) 14);
		headerFont.setColor(HSSFColor.BLACK.index);
		headerFont.setFontName("宋体");
		style.setFont(headerFont);
		style.setWrapText(true);

		// 设置单元格边框及颜色
		style.setBorderBottom((short) 1);
		style.setBorderLeft((short) 1);
		style.setBorderRight((short) 1);
		style.setBorderTop((short) 1);
		style.setWrapText(true);
		return style;
	}

}
