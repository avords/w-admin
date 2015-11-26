package com.handpay.ibenefit.order.web;

import java.io.File;
import java.io.IOException;
import java.net.URLEncoder;
import java.text.DateFormat;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.ProductConstants;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.CardCreInfoSubOrder;
import com.handpay.ibenefit.order.entity.ChangeOrder;
import com.handpay.ibenefit.order.entity.ChangeOrderExpla;
import com.handpay.ibenefit.order.entity.ChangeOrderSku;
import com.handpay.ibenefit.order.entity.ChnaOrderCard;
import com.handpay.ibenefit.order.entity.LogisticsCompany;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ICardCreInfoSubOrderManager;
import com.handpay.ibenefit.order.service.IChangeOrderExplaManager;
import com.handpay.ibenefit.order.service.IChangeOrderManager;
import com.handpay.ibenefit.order.service.IChangeOrderSkuManager;
import com.handpay.ibenefit.order.service.IChnaOrderCardManager;
import com.handpay.ibenefit.order.service.ILifeServiceOrderManager;
import com.handpay.ibenefit.order.service.ILogisticsCompanyManager;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.order.service.IOrderSkuManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.product.entity.Sku;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IPointOperateManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.security.service.OperationType;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
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
@RequestMapping("/lifeserviceoderstatusupdate")
public class LifeServiceOrderController extends PageController<SubOrder> {

	
	private static final String BASE_DIR = "order/";

	@Reference(version = "1.0")
	private ILifeServiceOrderManager lifeServiceOrderManager;

	@Reference(version="1.0")
	private IDictionaryManager dictionarymanager;
	
	@Reference(version="1.0")
	private IOrderManager orderManager;
	
	@Reference(version = "1.0")
	private IUserManager userManager;
	
	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Reference(version = "1.0")
	private IOrderSkuManager orderSkuManager;
	
	@Override
	public Manager<SubOrder> getEntityManager() {
		return lifeServiceOrderManager;
	}

	@Reference(version = "1.0")
	private ILogisticsCompanyManager  logisticsCompanyManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private IOrderProductManager productOrderManager;

	@Override
	public String getFileBasePath() {

		return BASE_DIR;
	}

	/**
	 * 生活服务类订单列表界面
	 *
	 * @throws IOException
	 *
	 */
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		PageSearch result = lifeServiceOrderManager.queryLifeServiceOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		request.getSession().setAttribute("action", "/changeOrder/page");
		return getFileBasePath() + "listLifeServiceOrder";
	}
	
	/**
	 * 导出类型选择界面
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exportChoice")
	public String exportChoice(HttpServletRequest request) throws Exception {
//		List<Dictionary> fateherDics = dictionarymanager.getDictionariesByDictionaryId(IBSConstants.LIFE_ORDER_TYPE);
//		List<Dictionary> childrenDics = dictionarymanager.getChildrenByParentId(fateherDics.get(0).getObjectId());
//		request.setAttribute("childrenDics", childrenDics);
		return getFileBasePath() + "exportChoice";
	}

	/**
	 * 退还处理失败订单积分
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/returnIntegral")
	public String returnIntegral(HttpServletRequest request,ModelMap map) throws Exception {
		Long userid;
		String suborderno = request.getParameter("suborderno");
		SubOrder suborder = subOrderManager.getBySubOrderNo(suborderno);
		
		if(null != suborder && suborder.getSubOrderState().equals(IBSConstants.ORDER_PROCESS_FAILED)){
			Order order = orderManager.getByObjectId(suborder.getGeneralOrderId());
			userid = order.getUserId();
			String returnResult = lifeServiceOrderManager.returnIntegral(suborder,userid);
			if(returnResult.equals("success")){
				map.put("result", "0");
				return "jsonView";
			}else{
				map.put("result", "1");
				return "jsonView";
			}
		}else{
			map.put("result", "2");
			return "jsonView";
		}
	}
	
	@RequestMapping("/lifeOrderInfo")
	public String lifeOrderInfo(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception{
		// 得到总订单和子订单信息
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
			
			List<SubOrder> subOrders = subOrderManager
					.getSubOrderObjectIdByGeneralOrderID(order.getObjectId());
			for(SubOrder subOrder : subOrders){
				LogisticsCompany  logisticsCompany =logisticsCompanyManager.getByObjectId(subOrder.getLogisticsCompany());
				if(logisticsCompany!=null){
				 subOrder.setCompanyName(logisticsCompany.getCompanyName());
				}
			}
			
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
					if(null != subOrder.getPayUserId()){
						User payUser = userManager.getByObjectId(subOrder.getPayUserId());
						subOrder.setPayUserName(payUser.getUserName());
					}
				}
				request.setAttribute("ActuallyAmount", ActuallyAmount);
				request.setAttribute("ActuallyIntegral", ActuallyIntegral);
			}
			request.setAttribute("orderstu", order.getOrderStatus());
			request.setAttribute("order", order);
			request.setAttribute("view", 1);
		}
		return getFileBasePath()+"LifeServiceOrderInfo";
	}
	/**
	 * 导入的结果
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadOrders")
	public String uploadOrders(HttpServletRequest request) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		String result = lifeServiceOrderManager.importOrders(fileData);
		request.setAttribute("result", result);
		return getFileBasePath() + "lifeOderUpdateResult";
	}
	
	@RequestMapping(value = "/exportOrder")
	public void exportOrder(HttpServletRequest request,
			HttpServletResponse response) throws IOException {
		
				Map<String,Object>  map = new HashMap<String, Object>();
				String startbookingDate  = request.getParameter("startbookingDate");
				if(startbookingDate.equals("")){
					startbookingDate=null;
				}

				String endbookingDate  = request.getParameter("endbookingDate");
				if(endbookingDate.equals("")||null==endbookingDate){
					endbookingDate=null;
				}else{
					endbookingDate+=" 23:59:59";
				}

				String subOrderNo  = request.getParameter("subOrderNo");
				if(subOrderNo.equals("")){
					subOrderNo = null;
				}else{
					subOrderNo = "%"+subOrderNo+"%";
				}
				String subOrderState  = request.getParameter("subOrderState");
				if(subOrderState.equals("")){
					subOrderState = null;
				}
				String userName  = request.getParameter("userName");
				if(userName.equals("")){
					userName = null;
				}else{
					userName = "%"+userName+"%";
				}
				String supplierId  = request.getParameter("supplierId");
				if(supplierId.equals("")){
					supplierId = null;
				}else{
					supplierId = "%"+supplierId+"%";
				}
				String supplierName  = request.getParameter("supplierName");
				if(supplierName.equals("")){
					supplierName = null;
				}else{
					supplierName = "%"+supplierName+"%";
				}
				String lifeType  = request.getParameter("lifeType");
				if(lifeType.equals("")){
					lifeType = null;
				}
				String[] types = lifeType.split(",");
				
				map.put("startbookingDate", startbookingDate);
				map.put("endbookingDate", endbookingDate);
				map.put("subOrderNo", subOrderNo);
				map.put("subOrderState", subOrderState);
				map.put("userName", userName);
				map.put("supplierId", supplierId);
				map.put("supplierName", supplierName);
		
				
				List<SubOrder> phoneList = null;
				List<SubOrder> qqList = null;
				List<SubOrder> creditList = null;
				List<SubOrder> alipayList = null;
				
				for(int i=0;i<types.length;i++){
					if("1".equals(types[i])){
						map.remove("lifeType");
						map.put("lifeType", types[i]);
						phoneList = lifeServiceOrderManager.exportLifeServiceOrder(map);
					}else if("7".equals(types[i])){
						map.remove("lifeType");
						map.put("lifeType", types[i]);
						qqList = lifeServiceOrderManager.exportLifeServiceOrder(map);
					}else if("3".equals(types[i])){
						map.remove("lifeType");
						map.put("lifeType", types[i]);
						creditList = lifeServiceOrderManager.exportLifeServiceOrder(map);
					}else if("8".equals(types[i])){
						map.remove("lifeType");
						map.put("lifeType", types[i]);
						alipayList = lifeServiceOrderManager.exportLifeServiceOrder(map);
					}
				}

				HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象
		        //订单状态
		        Dictionary dictionary=dictionarymanager.getDictionaryByDictionaryId(1409);
		        List<Dictionary> dictionaries=dictionarymanager.getChildrenByParentId(dictionary.getObjectId());
		        String[] LifeServiceOrderState=new String[dictionaries.size()];
		        for (int i = 0; i < dictionaries.size(); i++) {
					LifeServiceOrderState[i]=dictionaries.get(i).getName();
				}
				
				for(int i=0;i<types.length;i++){
					if("1".equals(types[i])){
				        HSSFSheet sheet1=wb.createSheet("话费充值");
				        CellStyle style = getStyle(wb);
				        
				        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 16);
				        sheet1.addMergedRegion(range);
				        Row row0 = sheet1.createRow(0);
				        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
				        cell00.setCellStyle(style);
				        cell00.setCellValue("此单元格勿动！");
				        sheet1.autoSizeColumn(0);
				        
				        Row row1 = sheet1.createRow(3);
				        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
				        cell0.setCellStyle(style);
				        cell0.setCellValue("订单编号");
				        sheet1.autoSizeColumn(0);
				        
				        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
				        cell1.setCellStyle(style);
				        cell1.setCellValue("订单状态");
				        sheet1.autoSizeColumn(1);
				        
				        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
				        cell2.setCellStyle(style);
				        cell2.setCellValue("订单来源");
				        sheet1.autoSizeColumn(2);
				        
				        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
				        cell3.setCellStyle(style);
				        cell3.setCellValue("订单类型");
				        sheet1.autoSizeColumn(3);
				        
				        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
				        cell4.setCellStyle(style);
				        cell4.setCellValue("客户下单时间");
				        sheet1.autoSizeColumn(4);
				        
				        
				        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
				        cell5.setCellStyle(style);
				        cell5.setCellValue("下单账户");
				        sheet1.autoSizeColumn(5);
				        
				        
				        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
				        cell6.setCellStyle(style);
				        cell6.setCellValue("支付方式");
				        sheet1.autoSizeColumn(6);
				        
				        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
				        cell7.setCellStyle(style);
				        cell7.setCellValue("付款积分");
				        sheet1.autoSizeColumn(7);
				        
				        
				        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
				        cell8.setCellStyle(style);
				        cell8.setCellValue("付款时间");
				        sheet1.autoSizeColumn(8);
				        
				        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
				        cell9.setCellStyle(style);
				        cell9.setCellValue("付款操作人");
				        sheet1.autoSizeColumn(9);

				        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
				        cell10.setCellStyle(style);
				        cell10.setCellValue("商品名称");
				        sheet1.autoSizeColumn(10);
				        
				        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
				        cell11.setCellStyle(style);
				        cell11.setCellValue("手机号码");
				        sheet1.autoSizeColumn(11);
				        
				        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
				        cell12.setCellStyle(style);
				        cell12.setCellValue("商品类型");
				        sheet1.autoSizeColumn(12);
				        
				        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
				        cell13.setCellStyle(style);
				        cell13.setCellValue("数量");
				        sheet1.autoSizeColumn(13);
				        
				        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
				        cell14.setCellStyle(style);
				        cell14.setCellValue("单价");
				        sheet1.autoSizeColumn(14);
				        
				        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
				        cell15.setCellStyle(style);
				        cell15.setCellValue("小计");
				        sheet1.autoSizeColumn(15);
				        
				        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
				        cell16.setCellStyle(style);
				        cell16.setCellValue("实付积分");
				        sheet1.autoSizeColumn(16);
				        
				        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
				        sheet1.addValidationData(ddValidation);
				        
						for(int j=0;j<phoneList.size();j++){
							SubOrder suborder = phoneList.get(j);
							OrderSku ordersku1 = new OrderSku();
							OrderSku ordersku2 = new OrderSku();
							ordersku1.setSubOrderId(suborder.getObjectId());
							List<OrderSku> orderskus = orderSkuManager.getBySample(ordersku1);
							ordersku2 = orderskus.get(0);
							HSSFRow row = sheet1.createRow(j + 4);
							//订单编号
					        Cell cell = row.createCell(0, Cell.CELL_TYPE_STRING);  
				            cell.setCellStyle(style);
				            if(null!=suborder.getSubOrderNo()){
				            	cell.setCellValue(suborder.getSubOrderNo());	
				            }
				            //订单状态
				            HSSFCell cel2 = row.createCell(1, Cell.CELL_TYPE_STRING);   
				            cel2.setCellStyle(style);
				            Dictionary dicChildern = new Dictionary();
				            List<Dictionary> dics = dictionarymanager.getDictionariesByDictionaryId(IBSConstants.LIFE_ORDER_TYPE);
				            dicChildern.setValue(suborder.getSubOrderState());
				            dicChildern.setParentId(dics.get(0).getParentId());
				            if(null!= dictionarymanager.getBySample(dicChildern) && dictionarymanager.getBySample(dicChildern).size() != 0){
				            	if(null != dictionarymanager.getBySample(dicChildern).get(0)){
				                	Dictionary goaldic = dictionarymanager.getBySample(dicChildern).get(0);
				                	cel2.setCellValue(goaldic.getName()); 
				            	}else{
				            		cel2.setCellValue("非生活服务类订单状态"); 
				            	}
				            }else{
				            	cel2.setCellValue("非生活服务类订单状态"); 
				            }
				            //订单来源
				            HSSFCell cel3 = row.createCell(2, Cell.CELL_TYPE_STRING); 
				            cel3.setCellStyle(style);
				            Dictionary dic1 = new Dictionary();
				            dic1.setValue(suborder.getOrderSource());
				            dic1.setParentId(50058L);
				            if(null!= dictionarymanager.getBySample(dic1) && dictionarymanager.getBySample(dic1).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic1).get(0)){
				                	Dictionary goaldic1 = dictionarymanager.getBySample(dic1).get(0);
				                    cel3.setCellValue(goaldic1.getName());
				            	}
				            }
				            //订单类型
				            HSSFCell cel4 = row.createCell(3, Cell.CELL_TYPE_STRING);   
				            cel4.setCellStyle(style);
				            Dictionary dic2 = new Dictionary();
				            dic2.setValue(suborder.getOrderType());
				            dic2.setParentId(50061L);
				            if(null!= dictionarymanager.getBySample(dic2) && dictionarymanager.getBySample(dic2).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic2).get(0)){
				                	Dictionary goaldic2 = dictionarymanager.getBySample(dic2).get(0);
				                	cel4.setCellValue(goaldic2.getName());            		
				            	}
				            }
				            //客户下单时间
				            HSSFCell cel5 = row.createCell(4, Cell.CELL_TYPE_STRING);
				            cel5.setCellStyle(style);
				            if(null!=suborder.getBookingDate()){
				            	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String bookdate = format1.format(suborder.getBookingDate());
				            	cel5.setCellValue(bookdate);	
				            }
				            //下单账户
				            HSSFCell cel6 = row.createCell(5, Cell.CELL_TYPE_STRING);  
				            cel6.setCellStyle(style);
				            if(null!=suborder.getUserName()){
				            	cel6.setCellValue(suborder.getUserName());
				            }
				            //支付方式
				            HSSFCell cel7 = row.createCell(6, Cell.CELL_TYPE_STRING);  
				            cel7.setCellStyle(style);
				            Dictionary dic3 = new Dictionary();
				            dic3.setValue(suborder.getPaymentWay());
				            dic3.setParentId(50061L);
				            if(null!=dictionarymanager.getBySample(dic3) && dictionarymanager.getBySample(dic3).size() != 0){
				            	if(null!=dictionarymanager.getBySample(dic3).get(0)){
					            	Dictionary goaldic3 = dictionarymanager.getBySample(dic3).get(0);
					            	cel7.setCellValue(goaldic3.getName());
				            	}
				            }
				            //付款积分
				            HSSFCell cel8 = row.createCell(7, Cell.CELL_TYPE_STRING); 
				            cel8.setCellStyle(style); 
				            if(null!=suborder.getActuallyIntegral()){
				            	cel8.setCellValue(suborder.getActuallyIntegral());	
				            }else{
				            	cel8.setCellValue("");
				            }
				            //付款时间 
				            HSSFCell cel9 = row.createCell(8, Cell.CELL_TYPE_STRING);  
				            cel9.setCellStyle(style);
				            if(null!=suborder.getPaymentDate()){
				            	DateFormat format9 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String paymentdate = format9.format(suborder.getPaymentDate());
				            	cel9.setCellValue(paymentdate);	
				            }else{
				            	cel9.setCellValue("");
				            }
				            //付款操作人  
				            HSSFCell cel10 = row.createCell(9, Cell.CELL_TYPE_STRING);  
				            cel10.setCellStyle(style);  
				            if(null!=suborder.getPayUserName()){
				            	cel10.setCellValue(suborder.getPayUserName());	
				            }else{
				            	cel10.setCellValue("");
				            }
				            //商品名称
				            HSSFCell cel11 = row.createCell(10, Cell.CELL_TYPE_STRING);  
				            cel11.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel11.setCellValue(ordersku2.getName());
				            }else{
				            	cel11.setCellValue("");
				            }
				            //手机号码
				            HSSFCell cel12 = row.createCell(11, Cell.CELL_TYPE_STRING);  
				            cel12.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel12.setCellValue(ordersku2.getRemark1());
				            }else{
				            	cel12.setCellValue("");
				            }
				            //商品类型
				            HSSFCell cel13 = row.createCell(12, Cell.CELL_TYPE_STRING);  
				            cel13.setCellStyle(style);  				           
				            cel13.setCellValue("生活服务");

				            //数量
				            HSSFCell cel14 = row.createCell(13, Cell.CELL_TYPE_STRING);  
				            cel14.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount()){
				            	cel14.setCellValue(ordersku2.getProductCount());
				            }else{
				            	cel14.setCellValue("");
				            }
				            //单价
				            HSSFCell cel15= row.createCell(14, Cell.CELL_TYPE_STRING);  
				            cel15.setCellStyle(style);  
				            if(null!=ordersku2.getProductPrice()){
				            	cel15.setCellValue(ordersku2.getProductPrice());
				            }else{
				            	cel15.setCellValue("");
				            }
				            //小计
				            HSSFCell cel16 = row.createCell(15, Cell.CELL_TYPE_STRING);  
				            cel16.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount() && null!=ordersku2.getProductPrice()){
				            	cel16.setCellValue(ordersku2.getProductCount() * ordersku2.getProductPrice());
				            }else{
				            	cel16.setCellValue("");
				            }
				            //实付积分
				            HSSFCell cel17 = row.createCell(16, Cell.CELL_TYPE_STRING);  
				            cel17.setCellStyle(style);  
				            if(null!=suborder.getActuallyIntegral()){
				            	cel17.setCellValue(suborder.getActuallyIntegral());
				            }else{
				            	cel17.setCellValue("");
				            }
						}
					}
					if("8".equals(types[i])){
				        HSSFSheet sheet3=wb.createSheet("支付宝充值");
				        CellStyle style = getStyle(wb);
				        
				        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 16);
				        sheet3.addMergedRegion(range);
				        Row row0 = sheet3.createRow(0);
				        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
				        cell00.setCellStyle(style);
				        cell00.setCellValue("此单元格勿动！");
				        sheet3.autoSizeColumn(0);
				        
				        Row row1 = sheet3.createRow(3);
				        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
				        cell0.setCellStyle(style);
				        cell0.setCellValue("订单编号");
				        sheet3.autoSizeColumn(0);
				        
				        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
				        cell1.setCellStyle(style);
				        cell1.setCellValue("订单状态");
				        sheet3.autoSizeColumn(1);
				        
				        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
				        cell2.setCellStyle(style);
				        cell2.setCellValue("订单来源");
				        sheet3.autoSizeColumn(2);
				        
				        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
				        cell3.setCellStyle(style);
				        cell3.setCellValue("订单类型");
				        sheet3.autoSizeColumn(3);
				        
				        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
				        cell4.setCellStyle(style);
				        cell4.setCellValue("客户下单时间");
				        sheet3.autoSizeColumn(4);
				        
				        
				        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
				        cell5.setCellStyle(style);
				        cell5.setCellValue("下单账户");
				        sheet3.autoSizeColumn(5);
				        
				        
				        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
				        cell6.setCellStyle(style);
				        cell6.setCellValue("支付方式");
				        sheet3.autoSizeColumn(6);
				        
				        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
				        cell7.setCellStyle(style);
				        cell7.setCellValue("付款积分");
				        sheet3.autoSizeColumn(7);
				        
				        
				        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
				        cell8.setCellStyle(style);
				        cell8.setCellValue("付款时间");
				        sheet3.autoSizeColumn(8);
				        
				        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
				        cell9.setCellStyle(style);
				        cell9.setCellValue("付款操作人");
				        sheet3.autoSizeColumn(9);

				        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
				        cell10.setCellStyle(style);
				        cell10.setCellValue("商品名称");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
				        cell11.setCellStyle(style);
				        cell11.setCellValue("支付宝账号");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
				        cell12.setCellStyle(style);
				        cell12.setCellValue("商品类型");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
				        cell13.setCellStyle(style);
				        cell13.setCellValue("数量");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
				        cell14.setCellStyle(style);
				        cell14.setCellValue("单价");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
				        cell15.setCellStyle(style);
				        cell15.setCellValue("小计");
				        sheet3.autoSizeColumn(9);
				        
				        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
				        cell16.setCellStyle(style);
				        cell16.setCellValue("实付积分");
				        sheet3.autoSizeColumn(9);
				        
				        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
				        sheet3.addValidationData(ddValidation);
				        
						for(int j=0;j<alipayList.size();j++){
							SubOrder suborder = alipayList.get(j);
							OrderSku ordersku1 = new OrderSku();
							OrderSku ordersku2 = new OrderSku();
							ordersku1.setSubOrderId(suborder.getObjectId());
							List<OrderSku> orderskus = orderSkuManager.getBySample(ordersku1);
							ordersku2 = orderskus.get(0);
							HSSFRow row = sheet3.createRow(j + 4);
							//订单编号
					        Cell cell = row.createCell(0, Cell.CELL_TYPE_STRING);  
				            cell.setCellStyle(style);
				            if(null!=suborder.getSubOrderNo()){
				            	cell.setCellValue(suborder.getSubOrderNo());	
				            }
				            //订单状态
				            HSSFCell cel2 = row.createCell(1, Cell.CELL_TYPE_STRING);   
				            cel2.setCellStyle(style);
				            Dictionary dicChildern = new Dictionary();
				            List<Dictionary> dics = dictionarymanager.getDictionariesByDictionaryId(IBSConstants.LIFE_ORDER_TYPE);
				            dicChildern.setValue(suborder.getSubOrderState());
				            dicChildern.setParentId(dics.get(0).getParentId());
				            if(null!= dictionarymanager.getBySample(dicChildern) && dictionarymanager.getBySample(dicChildern).size() != 0){
				            	if(null != dictionarymanager.getBySample(dicChildern).get(0)){
				                	Dictionary goaldic = dictionarymanager.getBySample(dicChildern).get(0);
				                	cel2.setCellValue(goaldic.getName()); 
				            	}else{
				            		cel2.setCellValue("非生活服务类订单状态"); 
				            	}
				            }else{
				            	cel2.setCellValue("非生活服务类订单状态"); 
				            }
				            //订单来源
				            HSSFCell cel3 = row.createCell(2, Cell.CELL_TYPE_STRING); 
				            cel3.setCellStyle(style);
				            Dictionary dic1 = new Dictionary();
				            dic1.setValue(suborder.getOrderSource());
				            dic1.setParentId(50058L);
				            if(null!= dictionarymanager.getBySample(dic1) && dictionarymanager.getBySample(dic1).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic1).get(0)){
				                	Dictionary goaldic1 = dictionarymanager.getBySample(dic1).get(0);
				                    cel3.setCellValue(goaldic1.getName());
				            	}
				            }
				            //订单类型
				            HSSFCell cel4 = row.createCell(3, Cell.CELL_TYPE_STRING);   
				            cel4.setCellStyle(style);
				            Dictionary dic2 = new Dictionary();
				            dic2.setValue(suborder.getOrderType());
				            dic2.setParentId(50061L);
				            if(null!= dictionarymanager.getBySample(dic2) && dictionarymanager.getBySample(dic2).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic2).get(0)){
				                	Dictionary goaldic2 = dictionarymanager.getBySample(dic2).get(0);
				                	cel4.setCellValue(goaldic2.getName());            		
				            	}
				            }
				            //客户下单时间
				            HSSFCell cel5 = row.createCell(4, Cell.CELL_TYPE_STRING);
				            cel5.setCellStyle(style);
				            if(null!=suborder.getBookingDate()){
				            	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String bookdate = format1.format(suborder.getBookingDate());
				            	cel5.setCellValue(bookdate);	
				            }
				            //下单账户
				            HSSFCell cel6 = row.createCell(5, Cell.CELL_TYPE_STRING);  
				            cel6.setCellStyle(style);
				            if(null!=suborder.getUserName()){
				            	cel6.setCellValue(suborder.getUserName());
				            }
				            //支付方式
				            HSSFCell cel7 = row.createCell(6, Cell.CELL_TYPE_STRING);  
				            cel7.setCellStyle(style);
				            Dictionary dic3 = new Dictionary();
				            dic3.setValue(suborder.getPaymentWay());
				            dic3.setParentId(50061L);
				            if(null!=dictionarymanager.getBySample(dic3) && dictionarymanager.getBySample(dic3).size() != 0){
				            	if(null!=dictionarymanager.getBySample(dic3).get(0)){
					            	Dictionary goaldic3 = dictionarymanager.getBySample(dic3).get(0);
					            	cel7.setCellValue(goaldic3.getName());
				            	}
				            }
				            //付款积分
				            HSSFCell cel8 = row.createCell(7, Cell.CELL_TYPE_STRING); 
				            cel8.setCellStyle(style); 
				            if(null!=suborder.getActuallyIntegral()){
				            	cel8.setCellValue(suborder.getActuallyIntegral());	
				            }else{
				            	cel8.setCellValue("");
				            }
				            //付款时间 
				            HSSFCell cel9 = row.createCell(8, Cell.CELL_TYPE_STRING);  
				            cel9.setCellStyle(style);
				            if(null!=suborder.getPaymentDate()){
				            	DateFormat format9 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String paymentdate = format9.format(suborder.getPaymentDate());
				            	cel9.setCellValue(paymentdate);
				            }else{
				            	cel9.setCellValue("");
				            }
				            //付款操作人  
				            HSSFCell cel10 = row.createCell(9, Cell.CELL_TYPE_STRING);  
				            cel10.setCellStyle(style);  
				            if(null!=suborder.getPayUserName()){
				            	cel10.setCellValue(suborder.getPayUserName());	
				            }else{
				            	cel10.setCellValue("");
				            }
				            //商品名称
				            HSSFCell cel11 = row.createCell(10, Cell.CELL_TYPE_STRING);  
				            cel11.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel11.setCellValue(ordersku2.getName());
				            }else{
				            	cel11.setCellValue("");
				            }
				            //支付宝账号
				            HSSFCell cel12 = row.createCell(11, Cell.CELL_TYPE_STRING);  
				            cel12.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel12.setCellValue(ordersku2.getRemark1());
				            }else{
				            	cel12.setCellValue("");
				            }
				            //商品类型
				            HSSFCell cel13 = row.createCell(12, Cell.CELL_TYPE_STRING);  
				            cel13.setCellStyle(style);  				           
				            cel13.setCellValue("生活服务");

				            //数量
				            HSSFCell cel14 = row.createCell(13, Cell.CELL_TYPE_STRING);  
				            cel14.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount()){
				            	cel14.setCellValue(ordersku2.getProductCount());
				            }else{
				            	cel14.setCellValue("");
				            }
				            //单价
				            HSSFCell cel15= row.createCell(14, Cell.CELL_TYPE_STRING);  
				            cel15.setCellStyle(style);  
				            if(null!=ordersku2.getProductPrice()){
				            	cel15.setCellValue(ordersku2.getProductPrice());
				            }else{
				            	cel15.setCellValue("");
				            }
				            //小计
				            HSSFCell cel16 = row.createCell(15, Cell.CELL_TYPE_STRING);  
				            cel16.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount() && null!=ordersku2.getProductPrice()){
				            	cel16.setCellValue(ordersku2.getProductCount() * ordersku2.getProductPrice());
				            }else{
				            	cel16.setCellValue("");
				            }
				            //实付积分
				            HSSFCell cel17 = row.createCell(16, Cell.CELL_TYPE_STRING);  
				            cel17.setCellStyle(style);  
				            if(null!=suborder.getActuallyIntegral()){
				            	cel17.setCellValue(suborder.getActuallyIntegral());
				            }else{
				            	cel17.setCellValue("");
				            }
						}

					}
					if("7".equals(types[i])){
				        HSSFSheet sheet2=wb.createSheet("Q币充值");
				        CellStyle style = getStyle(wb);
				        

				        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 16);
				        sheet2.addMergedRegion(range);
				        Row row0 = sheet2.createRow(0);
				        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
				        cell00.setCellStyle(style);
				        cell00.setCellValue("此单元格勿动！");
				        sheet2.autoSizeColumn(0);
				        
				        Row row1 = sheet2.createRow(3);
				        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
				        cell0.setCellStyle(style);
				        cell0.setCellValue("订单编号");
				        sheet2.autoSizeColumn(0);
				        
				        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
				        cell1.setCellStyle(style);
				        cell1.setCellValue("订单状态");
				        sheet2.autoSizeColumn(1);
				        
				        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
				        cell2.setCellStyle(style);
				        cell2.setCellValue("订单来源");
				        sheet2.autoSizeColumn(2);
				        
				        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
				        cell3.setCellStyle(style);
				        cell3.setCellValue("订单类型");
				        sheet2.autoSizeColumn(3);
				        
				        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
				        cell4.setCellStyle(style);
				        cell4.setCellValue("客户下单时间");
				        sheet2.autoSizeColumn(4);
				        
				        
				        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
				        cell5.setCellStyle(style);
				        cell5.setCellValue("下单账户");
				        sheet2.autoSizeColumn(5);
				        
				        
				        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
				        cell6.setCellStyle(style);
				        cell6.setCellValue("支付方式");
				        sheet2.autoSizeColumn(6);
				        
				        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
				        cell7.setCellStyle(style);
				        cell7.setCellValue("付款积分");
				        sheet2.autoSizeColumn(7);
				        
				        
				        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
				        cell8.setCellStyle(style);
				        cell8.setCellValue("付款时间");
				        sheet2.autoSizeColumn(8);
				        
				        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
				        cell9.setCellStyle(style);
				        cell9.setCellValue("付款操作人");
				        sheet2.autoSizeColumn(9);

				        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
				        cell10.setCellStyle(style);
				        cell10.setCellValue("商品名称");
				        sheet2.autoSizeColumn(10);
				        
				        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
				        cell11.setCellStyle(style);
				        cell11.setCellValue("QQ号码");
				        sheet2.autoSizeColumn(11);
				        
				        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
				        cell12.setCellStyle(style);
				        cell12.setCellValue("商品类型");
				        sheet2.autoSizeColumn(12);
				        
				        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
				        cell13.setCellStyle(style);
				        cell13.setCellValue("数量");
				        sheet2.autoSizeColumn(13);
				        
				        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
				        cell14.setCellStyle(style);
				        cell14.setCellValue("单价");
				        sheet2.autoSizeColumn(14);
				        
				        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
				        cell15.setCellStyle(style);
				        cell15.setCellValue("小计");
				        sheet2.autoSizeColumn(15);
				        
				        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
				        cell16.setCellStyle(style);
				        cell16.setCellValue("实付积分");
				        sheet2.autoSizeColumn(16);
				        
				        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
				        sheet2.addValidationData(ddValidation);
				        
						for(int j=0;j<qqList.size();j++){
							SubOrder suborder = qqList.get(j);
							OrderSku ordersku1 = new OrderSku();
							OrderSku ordersku2 = new OrderSku();
							ordersku1.setSubOrderId(suborder.getObjectId());
							List<OrderSku> orderskus = orderSkuManager.getBySample(ordersku1);
							ordersku2 = orderskus.get(0);
							HSSFRow row = sheet2.createRow(j + 4);
							//订单编号
					        Cell cell = row.createCell(0, Cell.CELL_TYPE_STRING);  
				            cell.setCellStyle(style);
				            if(null!=suborder.getSubOrderNo()){
				            	cell.setCellValue(suborder.getSubOrderNo());	
				            }
				            //订单状态
				            HSSFCell cel2 = row.createCell(1, Cell.CELL_TYPE_STRING);   
				            cel2.setCellStyle(style);
				            Dictionary dicChildern = new Dictionary();
				            List<Dictionary> dics = dictionarymanager.getDictionariesByDictionaryId(IBSConstants.LIFE_ORDER_TYPE);
				            dicChildern.setValue(suborder.getSubOrderState());
				            dicChildern.setParentId(dics.get(0).getParentId());
				            if(null!= dictionarymanager.getBySample(dicChildern) && dictionarymanager.getBySample(dicChildern).size() != 0){
				            	if(null != dictionarymanager.getBySample(dicChildern).get(0)){
				                	Dictionary goaldic = dictionarymanager.getBySample(dicChildern).get(0);
				                	cel2.setCellValue(goaldic.getName()); 
				            	}else{
				            		cel2.setCellValue("非生活服务类订单状态"); 
				            	}
				            }else{
				            	cel2.setCellValue("非生活服务类订单状态"); 
				            }
				            //订单来源
				            HSSFCell cel3 = row.createCell(2, Cell.CELL_TYPE_STRING); 
				            cel3.setCellStyle(style);
				            Dictionary dic1 = new Dictionary();
				            dic1.setValue(suborder.getOrderSource());
				            dic1.setParentId(50058L);
				            if(null!= dictionarymanager.getBySample(dic1) && dictionarymanager.getBySample(dic1).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic1).get(0)){
				                	Dictionary goaldic1 = dictionarymanager.getBySample(dic1).get(0);
				                    cel3.setCellValue(goaldic1.getName());
				            	}
				            }
				            //订单类型
				            HSSFCell cel4 = row.createCell(3, Cell.CELL_TYPE_STRING);   
				            cel4.setCellStyle(style);
				            Dictionary dic2 = new Dictionary();
				            dic2.setValue(suborder.getOrderType());
				            dic2.setParentId(50061L);
				            if(null!= dictionarymanager.getBySample(dic2) && dictionarymanager.getBySample(dic2).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic2).get(0)){
				                	Dictionary goaldic2 = dictionarymanager.getBySample(dic2).get(0);
				                	cel4.setCellValue(goaldic2.getName());            		
				            	}
				            }
				            //客户下单时间
				            HSSFCell cel5 = row.createCell(4, Cell.CELL_TYPE_STRING);
				            cel5.setCellStyle(style);
				            if(null!=suborder.getBookingDate()){
				            	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String bookdate = format1.format(suborder.getBookingDate());
				            	cel5.setCellValue(bookdate);	
				            }
				            //下单账户
				            HSSFCell cel6 = row.createCell(5, Cell.CELL_TYPE_STRING);  
				            cel6.setCellStyle(style);
				            if(null!=suborder.getUserName()){
				            	cel6.setCellValue(suborder.getUserName());
				            }
				            //支付方式
				            HSSFCell cel7 = row.createCell(6, Cell.CELL_TYPE_STRING);  
				            cel7.setCellStyle(style);
				            Dictionary dic3 = new Dictionary();
				            dic3.setValue(suborder.getPaymentWay());
				            dic3.setParentId(50061L);
				            if(null!=dictionarymanager.getBySample(dic3) && dictionarymanager.getBySample(dic3).size() != 0){
				            	if(null!=dictionarymanager.getBySample(dic3).get(0)){
					            	Dictionary goaldic3 = dictionarymanager.getBySample(dic3).get(0);
					            	cel7.setCellValue(goaldic3.getName());
				            	}
				            }
				            //付款积分
				            HSSFCell cel8 = row.createCell(7, Cell.CELL_TYPE_STRING); 
				            cel8.setCellStyle(style); 
				            if(null!=suborder.getActuallyIntegral()){
				            	cel8.setCellValue(suborder.getActuallyIntegral());	
				            }else{
				            	cel8.setCellValue("");
				            }
				            //付款时间 
				            HSSFCell cel9 = row.createCell(8, Cell.CELL_TYPE_STRING);  
				            cel9.setCellStyle(style);
				            if(null!=suborder.getPaymentDate()){
				            	DateFormat format9 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String paymentdate = format9.format(suborder.getPaymentDate());
				            	cel9.setCellValue(paymentdate);		
				            }else{
				            	cel9.setCellValue("");
				            }
				            //付款操作人  
				            HSSFCell cel10 = row.createCell(9, Cell.CELL_TYPE_STRING);  
				            cel10.setCellStyle(style);  
				            if(null!=suborder.getPayUserName()){
				            	cel10.setCellValue(suborder.getPayUserName());	
				            }else{
				            	cel10.setCellValue("");
				            }
				            //商品名称
				            HSSFCell cel11 = row.createCell(10, Cell.CELL_TYPE_STRING);  
				            cel11.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel11.setCellValue(ordersku2.getName());
				            }else{
				            	cel11.setCellValue("");
				            }
				            //QQ号码
				            HSSFCell cel12 = row.createCell(11, Cell.CELL_TYPE_STRING);  
				            cel12.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel12.setCellValue(ordersku2.getRemark1());
				            }else{
				            	cel12.setCellValue("");
				            }
				            //商品类型
				            HSSFCell cel13 = row.createCell(12, Cell.CELL_TYPE_STRING);  
				            cel13.setCellStyle(style);  				           
				            cel13.setCellValue("生活服务");

				            //数量
				            HSSFCell cel14 = row.createCell(13, Cell.CELL_TYPE_STRING);  
				            cel14.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount()){
				            	cel14.setCellValue(ordersku2.getProductCount());
				            }else{
				            	cel14.setCellValue("");
				            }
				            //单价
				            HSSFCell cel15= row.createCell(14, Cell.CELL_TYPE_STRING);  
				            cel15.setCellStyle(style);  
				            if(null!=ordersku2.getProductPrice()){
				            	cel15.setCellValue(ordersku2.getProductPrice());
				            }else{
				            	cel15.setCellValue("");
				            }
				            //小计
				            HSSFCell cel16 = row.createCell(15, Cell.CELL_TYPE_STRING);  
				            cel16.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount() && null!=ordersku2.getProductPrice()){
				            	cel16.setCellValue(ordersku2.getProductCount() * ordersku2.getProductPrice());
				            }else{
				            	cel16.setCellValue("");
				            }
				            //实付积分
				            HSSFCell cel17 = row.createCell(16, Cell.CELL_TYPE_STRING);  
				            cel17.setCellStyle(style);  
				            if(null!=suborder.getActuallyIntegral()){
				            	cel17.setCellValue(suborder.getActuallyIntegral());
				            }else{
				            	cel17.setCellValue("");
				            }
						}

					}
					if("3".equals(types[i])){

						
						
				        HSSFSheet sheet4=wb.createSheet("信用卡还款");
				        CellStyle style = getStyle(wb);
				        
				        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 19);
				        sheet4.addMergedRegion(range);
				        Row row0 = sheet4.createRow(0);
				        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
				        cell00.setCellStyle(style);
				        cell00.setCellValue("此单元格勿动！");
				        sheet4.autoSizeColumn(0);
				        
				        Row row1 = sheet4.createRow(3);
				        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
				        cell0.setCellStyle(style);
				        cell0.setCellValue("订单编号");
				        sheet4.autoSizeColumn(0);
				        
				        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
				        cell1.setCellStyle(style);
				        cell1.setCellValue("订单状态");
				        sheet4.autoSizeColumn(1);
				        
				        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
				        cell2.setCellStyle(style);
				        cell2.setCellValue("订单来源");
				        sheet4.autoSizeColumn(2);
				        
				        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
				        cell3.setCellStyle(style);
				        cell3.setCellValue("订单类型");
				        sheet4.autoSizeColumn(3);
				        
				        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
				        cell4.setCellStyle(style);
				        cell4.setCellValue("客户下单时间");
				        sheet4.autoSizeColumn(4);
				        
				        
				        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
				        cell5.setCellStyle(style);
				        cell5.setCellValue("下单账户");
				        sheet4.autoSizeColumn(5);
				        
				        
				        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
				        cell6.setCellStyle(style);
				        cell6.setCellValue("支付方式");
				        sheet4.autoSizeColumn(6);
				        
				        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
				        cell7.setCellStyle(style);
				        cell7.setCellValue("付款积分");
				        sheet4.autoSizeColumn(7);
				        
				        
				        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
				        cell8.setCellStyle(style);
				        cell8.setCellValue("付款时间");
				        sheet4.autoSizeColumn(8);
				        
				        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
				        cell9.setCellStyle(style);
				        cell9.setCellValue("付款操作人");
				        sheet4.autoSizeColumn(9);

				        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
				        cell10.setCellStyle(style);
				        cell10.setCellValue("商品名称");
				        sheet4.autoSizeColumn(10);
				        
				        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
				        cell11.setCellStyle(style);
				        cell11.setCellValue("开户省市");
				        sheet4.autoSizeColumn(11);
				        
				        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
				        cell12.setCellStyle(style);
				        cell12.setCellValue("开户银行");
				        sheet4.autoSizeColumn(12);

				        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
				        cell13.setCellStyle(style);
				        cell13.setCellValue("开户账号");
				        sheet4.autoSizeColumn(13);
				        
				        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
				        cell14.setCellStyle(style);
				        cell14.setCellValue("户主姓名");
				        sheet4.autoSizeColumn(14);
				        
				        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
				        cell15.setCellStyle(style);
				        cell15.setCellValue("商品类型");
				        sheet4.autoSizeColumn(15);
				        
				        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
				        cell16.setCellStyle(style);
				        cell16.setCellValue("数量");
				        sheet4.autoSizeColumn(16);
				        
				        Cell cell17 = row1.createCell(17, Cell.CELL_TYPE_STRING);
				        cell17.setCellStyle(style);
				        cell17.setCellValue("单价");
				        sheet4.autoSizeColumn(17);
				        
				        Cell cell18 = row1.createCell(18, Cell.CELL_TYPE_STRING);
				        cell18.setCellStyle(style);
				        cell18.setCellValue("小计");
				        sheet4.autoSizeColumn(18);
				        
				        Cell cell19 = row1.createCell(19, Cell.CELL_TYPE_STRING);
				        cell19.setCellStyle(style);
				        cell19.setCellValue("实付积分");
				        sheet4.autoSizeColumn(19);
				        
				        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
				        sheet4.addValidationData(ddValidation);
				        
						for(int j=0;j<creditList.size();j++){
							SubOrder suborder = creditList.get(j);
							OrderSku ordersku1 = new OrderSku();
							OrderSku ordersku2 = new OrderSku();
							ordersku1.setSubOrderId(suborder.getObjectId());
							List<OrderSku> orderskus = orderSkuManager.getBySample(ordersku1);
							ordersku2 = orderskus.get(0);
							HSSFRow row = sheet4.createRow(j + 4);
							//订单编号
					        Cell cell = row.createCell(0, Cell.CELL_TYPE_STRING);  
				            cell.setCellStyle(style);
				            if(null!=suborder.getSubOrderNo()){
				            	cell.setCellValue(suborder.getSubOrderNo());	
				            }
				            //订单状态
				            HSSFCell cel2 = row.createCell(1, Cell.CELL_TYPE_STRING);   
				            cel2.setCellStyle(style);
				            Dictionary dicChildern = new Dictionary();
				            List<Dictionary> dics = dictionarymanager.getDictionariesByDictionaryId(IBSConstants.LIFE_ORDER_TYPE);
				            dicChildern.setValue(suborder.getSubOrderState());
				            dicChildern.setParentId(dics.get(0).getParentId());
				            if(null!= dictionarymanager.getBySample(dicChildern) && dictionarymanager.getBySample(dicChildern).size() != 0){
				            	if(null != dictionarymanager.getBySample(dicChildern).get(0)){
				                	Dictionary goaldic = dictionarymanager.getBySample(dicChildern).get(0);
				                	cel2.setCellValue(goaldic.getName()); 
				            	}else{
				            		cel2.setCellValue("非生活服务类订单状态"); 
				            	}
				            }else{
				            	cel2.setCellValue("非生活服务类订单状态"); 
				            }
				            //订单来源
				            HSSFCell cel3 = row.createCell(2, Cell.CELL_TYPE_STRING); 
				            cel3.setCellStyle(style);
				            Dictionary dic1 = new Dictionary();
				            dic1.setValue(suborder.getOrderSource());
				            dic1.setParentId(50058L);
				            if(null!= dictionarymanager.getBySample(dic1) && dictionarymanager.getBySample(dic1).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic1).get(0)){
				                	Dictionary goaldic1 = dictionarymanager.getBySample(dic1).get(0);
				                    cel3.setCellValue(goaldic1.getName());
				            	}
				            }
				            //订单类型
				            HSSFCell cel4 = row.createCell(3, Cell.CELL_TYPE_STRING);   
				            cel4.setCellStyle(style);
				            Dictionary dic2 = new Dictionary();
				            dic2.setValue(suborder.getOrderType());
				            dic2.setParentId(50061L);
				            if(null!= dictionarymanager.getBySample(dic2) && dictionarymanager.getBySample(dic2).size() != 0){
				            	if(null != dictionarymanager.getBySample(dic2).get(0)){
				                	Dictionary goaldic2 = dictionarymanager.getBySample(dic2).get(0);
				                	cel4.setCellValue(goaldic2.getName());            		
				            	}
				            }
				            //客户下单时间
				            HSSFCell cel5 = row.createCell(4, Cell.CELL_TYPE_STRING);
				            cel5.setCellStyle(style);
				            if(null!=suborder.getBookingDate()){
				            	DateFormat format1 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String bookdate = format1.format(suborder.getBookingDate());
				            	cel5.setCellValue(bookdate);	
				            }
				            //下单账户
				            HSSFCell cel6 = row.createCell(5, Cell.CELL_TYPE_STRING);  
				            cel6.setCellStyle(style);
				            if(null!=suborder.getUserName()){
				            	cel6.setCellValue(suborder.getUserName());
				            }
				            //支付方式
				            HSSFCell cel7 = row.createCell(6, Cell.CELL_TYPE_STRING);  
				            cel7.setCellStyle(style);
				            Dictionary dic3 = new Dictionary();
				            dic3.setValue(suborder.getPaymentWay());
				            dic3.setParentId(50061L);
				            if(null!=dictionarymanager.getBySample(dic3) && dictionarymanager.getBySample(dic3).size() != 0){
				            	if(null!=dictionarymanager.getBySample(dic3).get(0)){
					            	Dictionary goaldic3 = dictionarymanager.getBySample(dic3).get(0);
					            	cel7.setCellValue(goaldic3.getName());
				            	}
				            }
				            //付款积分
				            HSSFCell cel8 = row.createCell(7, Cell.CELL_TYPE_STRING); 
				            cel8.setCellStyle(style); 
				            if(null!=suborder.getActuallyIntegral()){
				            	cel8.setCellValue(suborder.getActuallyIntegral());	
				            }else{
				            	cel8.setCellValue("");
				            }
				            //付款时间 
				            HSSFCell cel9 = row.createCell(8, Cell.CELL_TYPE_STRING);  
				            cel9.setCellStyle(style);
				            if(null!=suborder.getPaymentDate()){
				            	DateFormat format9 = new SimpleDateFormat("yyyy-MM-dd hh:mm:ss");
				            	String paymentdate = format9.format(suborder.getPaymentDate());
				            	cel9.setCellValue(paymentdate);	
				            }else{
				            	cel9.setCellValue("");
				            }
				            //付款操作人  
				            HSSFCell cel10 = row.createCell(9, Cell.CELL_TYPE_STRING);  
				            cel10.setCellStyle(style);  
				            if(null!=suborder.getPayUserName()){
				            	cel10.setCellValue(suborder.getPayUserName());	
				            }else{
				            	cel10.setCellValue("");
				            }
				            //商品名称
				            HSSFCell cel11 = row.createCell(10, Cell.CELL_TYPE_STRING);  
				            cel11.setCellStyle(style);  
				            if(null!=ordersku2.getName()){
				            	cel11.setCellValue(ordersku2.getName());
				            }else{
				            	cel11.setCellValue("");
				            }
				            //开户省市
				            HSSFCell cel12 = row.createCell(11, Cell.CELL_TYPE_STRING);  
				            cel12.setCellStyle(style);
				            String shengshixinxi = "";
				            if(null != ordersku2.getProvince()){
				            	shengshixinxi = shengshixinxi+ordersku2.getProvince();
				            }
				            if(null != ordersku2.getCity()){
				            	shengshixinxi = shengshixinxi+ordersku2.getCity();
				            }
				            if(null!=shengshixinxi){
				            	cel12.setCellValue(shengshixinxi);
				            }
				            
				            //开户银行
				            HSSFCell cel13 = row.createCell(12, Cell.CELL_TYPE_STRING);  
				            cel13.setCellStyle(style);  
				            if(null!=ordersku2.getRemark3()){
				            	cel13.setCellValue(ordersku2.getRemark3());
				            }else{
				            	cel13.setCellValue("");
				            }
				            //开户账号
				            HSSFCell cel14 = row.createCell(13, Cell.CELL_TYPE_STRING);  
				            cel14.setCellStyle(style);  
				            if(null!=ordersku2.getRemark1()){
				            	cel14.setCellValue(ordersku2.getRemark1());
				            }else{
				            	cel14.setCellValue("");
				            }
				            //户主姓名
				            HSSFCell cel15 = row.createCell(14, Cell.CELL_TYPE_STRING);  
				            cel15.setCellStyle(style);  
				            if(null!=ordersku2.getRemark2()){
				            	cel15.setCellValue(ordersku2.getRemark2());
				            }else{
				            	cel15.setCellValue("");
				            }
				            //商品类型
				            HSSFCell cel16 = row.createCell(15, Cell.CELL_TYPE_STRING);  
				            cel16.setCellStyle(style);  				           
				            cel16.setCellValue("生活服务");

				            //数量
				            HSSFCell cel17 = row.createCell(16, Cell.CELL_TYPE_STRING);  
				            cel17.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount()){
				            	cel17.setCellValue(ordersku2.getProductCount());
				            }else{
				            	cel17.setCellValue("");
				            }
				            //单价
				            HSSFCell cel18= row.createCell(17, Cell.CELL_TYPE_STRING);  
				            cel18.setCellStyle(style);  
				            if(null!=ordersku2.getProductPrice()){
				            	cel18.setCellValue(ordersku2.getProductPrice());
				            }else{
				            	cel18.setCellValue("");
				            }
				            //小计
				            HSSFCell cel19 = row.createCell(18, Cell.CELL_TYPE_STRING);  
				            cel19.setCellStyle(style);  
				            if(null!=ordersku2.getProductCount() && null!=ordersku2.getProductPrice()){
				            	cel19.setCellValue(ordersku2.getProductCount() * ordersku2.getProductPrice());
				            }else{
				            	cel19.setCellValue("");
				            }
				            //实付积分
				            HSSFCell cel20 = row.createCell(19, Cell.CELL_TYPE_STRING);  
				            cel20.setCellStyle(style);  
				            if(null!=suborder.getActuallyIntegral()){
				            	cel20.setCellValue(suborder.getActuallyIntegral());
				            }else{
				            	cel20.setCellValue("");
				            }
						}

					}
					
				}
		        FileUpDownUtils.setDownloadResponseHeaders(response, "lifeServiceOrders.xls");
		        wb.write(response.getOutputStream());
	}
	
	@RequestMapping("/importOrder")
	public String importOrder(HttpServletRequest request) {
		return getFileBasePath() + "importOrders";
	}
	
	//信用卡 导入模板
	@RequestMapping("/exportCreditTemplate")
	public String exportCreditTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
        HSSFSheet sheet=wb.createSheet("信用卡充值模板");
        CellStyle style = getStyle(wb);
        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 19);
        sheet.addMergedRegion(range);
        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
        cell00.setCellStyle(style);
        cell00.setCellValue("说明：加*为必填项，如‘订单编号’‘订单状态’");
        sheet.autoSizeColumn(0);
        
        Row row1 = sheet.createRow(3);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("订单编号*");
        sheet.autoSizeColumn(0);
        
        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("订单状态*");
        sheet.autoSizeColumn(1);
        
        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("订单来源");
        sheet.autoSizeColumn(2);
        
        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("订单类型");
        sheet.autoSizeColumn(3);
        
        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
        cell4.setCellStyle(style);
        cell4.setCellValue("客户下单时间");
        sheet.autoSizeColumn(4);
        
        
        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
        cell5.setCellStyle(style);
        cell5.setCellValue("下单账户");
        sheet.autoSizeColumn(5);
        
        
        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
        cell6.setCellStyle(style);
        cell6.setCellValue("支付方式");
        sheet.autoSizeColumn(6);
        
        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
        cell7.setCellStyle(style);
        cell7.setCellValue("付款积分");
        sheet.autoSizeColumn(7);
        
        
        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
        cell8.setCellStyle(style);
        cell8.setCellValue("付款时间");
        sheet.autoSizeColumn(8);
        
        
        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
        cell9.setCellStyle(style);
        cell9.setCellValue("付款操作人");
        sheet.autoSizeColumn(9);

        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
        cell10.setCellStyle(style);
        cell10.setCellValue("商品名称");
        sheet.autoSizeColumn(10);
        
        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
        cell11.setCellStyle(style);
        cell11.setCellValue("开户省市");
        sheet.autoSizeColumn(11);
        
        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
        cell12.setCellStyle(style);
        cell12.setCellValue("开户银行");
        sheet.autoSizeColumn(12);

        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
        cell13.setCellStyle(style);
        cell13.setCellValue("开户账号");
        sheet.autoSizeColumn(13);
        
        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
        cell14.setCellStyle(style);
        cell14.setCellValue("户主姓名");
        sheet.autoSizeColumn(14);
        
        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
        cell15.setCellStyle(style);
        cell15.setCellValue("商品类型");
        sheet.autoSizeColumn(15);
        
        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
        cell16.setCellStyle(style);
        cell16.setCellValue("数量");
        sheet.autoSizeColumn(16);
        
        Cell cell17 = row1.createCell(17, Cell.CELL_TYPE_STRING);
        cell17.setCellStyle(style);
        cell17.setCellValue("单价");
        sheet.autoSizeColumn(17);

        Cell cell18 = row1.createCell(18, Cell.CELL_TYPE_STRING);
        cell18.setCellStyle(style);
        cell18.setCellValue("小计");
        sheet.autoSizeColumn(18);
        
        Cell cell19 = row1.createCell(19, Cell.CELL_TYPE_STRING);
        cell19.setCellStyle(style);
        cell19.setCellValue("实付积分");
        sheet.autoSizeColumn(19);
        //订单状态
        Dictionary dictionary=dictionarymanager.getDictionaryByDictionaryId(1409);
        List<Dictionary> dictionaries=dictionarymanager.getChildrenByParentId(dictionary.getObjectId());
        String[] LifeServiceOrderState=new String[dictionaries.size()];
        for (int i = 0; i < dictionaries.size(); i++) {
			LifeServiceOrderState[i]=dictionaries.get(i).getName();
		}
        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
        sheet.addValidationData(ddValidation);
        
        FileUpDownUtils.setDownloadResponseHeaders(response,"CreditFare.xls");
        wb.write(response.getOutputStream());
		return null;
	}
	
	@RequestMapping("/exportAlipayTemplate")
	public String exportAlipayTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {

		HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
        HSSFSheet sheet=wb.createSheet("支付宝直冲模板");
        CellStyle style = getStyle(wb);
        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 16);
        sheet.addMergedRegion(range);
        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
        cell00.setCellStyle(style);
        cell00.setCellValue("说明：加*为必填项，如‘订单编号’‘订单状态’");
        sheet.autoSizeColumn(0);
        
        Row row1 = sheet.createRow(3);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("订单编号*");
        sheet.autoSizeColumn(0);
        
        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("订单状态*");
        sheet.autoSizeColumn(1);
        
        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("订单来源");
        sheet.autoSizeColumn(2);
        
        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("订单类型");
        sheet.autoSizeColumn(3);
        
        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
        cell4.setCellStyle(style);
        cell4.setCellValue("客户下单时间");
        sheet.autoSizeColumn(4);
        
        
        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
        cell5.setCellStyle(style);
        cell5.setCellValue("下单账户");
        sheet.autoSizeColumn(5);
        
        
        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
        cell6.setCellStyle(style);
        cell6.setCellValue("支付方式");
        sheet.autoSizeColumn(6);
        
        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
        cell7.setCellStyle(style);
        cell7.setCellValue("付款积分");
        sheet.autoSizeColumn(7);
        
        
        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
        cell8.setCellStyle(style);
        cell8.setCellValue("付款时间");
        sheet.autoSizeColumn(8);
        
        
        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
        cell9.setCellStyle(style);
        cell9.setCellValue("付款操作人");
        sheet.autoSizeColumn(9);

        Cell cell10 = row1.createCell(10, Cell.CELL_TYPE_STRING);
        cell10.setCellStyle(style);
        cell10.setCellValue("商品名称");
        sheet.autoSizeColumn(10);
        
        Cell cell11 = row1.createCell(11, Cell.CELL_TYPE_STRING);
        cell11.setCellStyle(style);
        cell11.setCellValue("支付宝账户");
        sheet.autoSizeColumn(11);
        
        Cell cell12 = row1.createCell(12, Cell.CELL_TYPE_STRING);
        cell12.setCellStyle(style);
        cell12.setCellValue("商品类型");
        sheet.autoSizeColumn(12);
        
        Cell cell13 = row1.createCell(13, Cell.CELL_TYPE_STRING);
        cell13.setCellStyle(style);
        cell13.setCellValue("数量");
        sheet.autoSizeColumn(13);
        
        Cell cell14 = row1.createCell(14, Cell.CELL_TYPE_STRING);
        cell14.setCellStyle(style);
        cell14.setCellValue("单价");
        sheet.autoSizeColumn(14);
        
        Cell cell15 = row1.createCell(15, Cell.CELL_TYPE_STRING);
        cell15.setCellStyle(style);
        cell15.setCellValue("小计");
        sheet.autoSizeColumn(15);
        
        Cell cell16 = row1.createCell(16, Cell.CELL_TYPE_STRING);
        cell16.setCellStyle(style);
        cell16.setCellValue("实付积分");
        sheet.autoSizeColumn(16);
        
        //订单状态
        Dictionary dictionary=dictionarymanager.getDictionaryByDictionaryId(1409);
        List<Dictionary> dictionaries=dictionarymanager.getChildrenByParentId(dictionary.getObjectId());
        String[] LifeServiceOrderState=new String[dictionaries.size()];
        for (int i = 0; i < dictionaries.size(); i++) {
			LifeServiceOrderState[i]=dictionaries.get(i).getName();
		}
        HSSFDataValidation ddValidation = setDataValidationList((short)1, (short)32767, (short)1, LifeServiceOrderState);
        sheet.addValidationData(ddValidation);
        
        FileUpDownUtils.setDownloadResponseHeaders(response,"Alipay.xls");
        wb.write(response.getOutputStream());
		return null;
	}
	
	private CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 设置单元格字体
		Font headerFont = workbook.createFont(); // 字体
		headerFont.setFontHeightInPoints((short) 10);
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
	
	public static HSSFDataValidation setDataValidationList(short firstRow,short endRow, short col, String[] textList){  
        //加载下拉列表内容  
        DVConstraint constraint= DVConstraint.createExplicitListConstraint(textList);  
        //设置数据有效性加载在哪个单元格上。  
          
        //四个参数分别是：起始行、终止行、起始列、终止列  
        CellRangeAddressList regions=new CellRangeAddressList(firstRow,endRow,col,col);  
        //数据有效性对象  
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);  
        return dataValidation;  
    }
}
