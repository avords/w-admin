package com.handpay.ibenefit.cardExchange.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONArray;
import net.sf.json.JSONObject;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.common.constant.PartnerEnum;
import com.handpay.ibenefit.common.service.ICheckup;
import com.handpay.ibenefit.common.service.ISendEmailService;
import com.handpay.ibenefit.common.service.ISendSmsService;
import com.handpay.ibenefit.framework.cache.ICacheManager;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.grantWelfare.service.IGrantWelfareStaffManager;
import com.handpay.ibenefit.grantWelfare.web.GrantWelfareStaff;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.service.IStaffManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierShopManager;
import com.handpay.ibenefit.order.entity.Order;
import com.handpay.ibenefit.order.entity.RequestBookingOrder;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.IExchangeManger;
import com.handpay.ibenefit.order.service.IOrderManager;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.other.service.IMessageTemplateManager;
import com.handpay.ibenefit.physical.entity.PhysicalItem;
import com.handpay.ibenefit.physical.entity.PhysicalPkgItem;
import com.handpay.ibenefit.physical.entity.PhysicalSubscribe;
import com.handpay.ibenefit.physical.entity.PhysicalSupply;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalPkgItemManager;
import com.handpay.ibenefit.physical.service.IPhysicalSubscribeManager;
import com.handpay.ibenefit.physical.service.IPhysicalSupplierCardManager;
import com.handpay.ibenefit.physical.service.IPhysicalSupplyManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.SystemParameter;
import com.handpay.ibenefit.security.service.ISystemParameterManager;
import com.handpay.ibenefit.security.service.IUserManager;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.entity.WelfarePackageCategory;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.IWelfareManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageCategoryManager;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("/CardExchange")
public class CardExchangeController extends PageController<CardInfo> {
	private static final String BASE_DIR = "cardExchange/";
	Logger logger = Logger.getLogger(CardExchangeController.class);

	@Reference(version = "1.0")
	private ICardInfoManager cardInfoManager;

	@Reference(version = "1.0")
	private IWelfarePackageManager welfarePackageManager;

	@Reference(version = "1.0")
	private ISupplierShopManager supplierShopManager;

	@Reference(version = "1.0")
	private IPhysicalPkgItemManager physicalPkgItemManager;

	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;

	@Reference(version = "1.0", timeout = 61000)
	private IPhysicalSubscribeManager physicalSubscribeManager;

	@Reference(version = "1.0")
	private ICardCreateInfoManager cardCreateInfoManager;

	@Reference(version = "1.0")
	private IOrderManager orderManager;

	@Reference(version = "1.0")
	private ISubOrderManager subOrderManager;

	@Reference(version = "1.0")
	private IWelfareManager welfareManager;

	@Reference(version = "1.0")
	private IExchangeManger exchangeManger;

	@Reference(version = "1.0")
	private ISkuPublishManager skuPublishManager;

	@Reference(version = "1.0", timeout = 18000)
	private ICheckup checkup;

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IPhysicalSupplyManager physicalSupplyManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private ICacheManager cacheManager;

	@Reference(version = "1.0")
	private IAreaManager areaManager;

	@Reference(version = "1.0")
	private IPhysicalSupplierCardManager physicalSupplierCardManager;

	@Reference(version = "1.0")
	private IGrantWelfareStaffManager grantWelfareStaffManager;

	@Reference(version = "1.0")
	private IStaffManager staffManager;

	@Reference(version = "1.0")
	private ISystemParameterManager systemParameterManager;

	@Reference(version = "1.0")
	private IMessageTemplateManager messageTemplateManager;

	@Reference(version = "1.0",async=true)
	private ISendSmsService sendSmsService;

	@Reference(version = "1.0",async=true)
	private ISendEmailService sendEmailService;

	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

	@Override
	public Manager<CardInfo> getEntityManager() {
		return cardInfoManager;
	}

	@Reference(version = "1.0")
	private IWelfarePackageCategoryManager welfarePackageCategoryManager;

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	/**
	 * handlePage(卡号兑换列表)
	 * 
	 * @param request  PageSearch
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@Override
	public String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch result = cardInfoManager.getExchangeCardInfo(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listCardExchange";
	}

	/**
	 * viewPhysicalDetail(体检详情页面，可进行改期，取消操作)
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/viewPhysicalDetail/{cardNo}")
	public String viewPhysicalDetail(HttpServletRequest request, PhysicalSubscribe pSubscribe, @PathVariable String cardNo) throws Exception {
		if (request.getParameter("physicalDateStr") != null && !("").equals(request.getParameter("physicalDateStr"))) {
			pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");
			String supplierPackageNo = physicalSubscribeManager.getSupplierPackageNo(pSubscribe);
			pSubscribe.setSupplierPackgeNo(supplierPackageNo);
			String physicalDateStr = request.getParameter("physicalDateStr");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date physicalDate = sdf.parse(physicalDateStr);
			pSubscribe.setPhysicalDate(physicalDate);
			PhysicalSubscribe p = physicalSubscribeManager.updatePhysicalSubscribeDate(pSubscribe);
			if("1".equals(p.getIsUpdateSuccess())){
				request.setAttribute("message", "体检改期成功！");
				return "cardExchange/changeDateSuccess";
			}else{
				request.setAttribute("message", "体检改期不成功！");
				return "cardExchange/changeDateFailure";
			}
		} 
		if (pSubscribe != null) {
			cardNo = pSubscribe.getCardNo();
		}
		CardInfo cardInfo = new CardInfo();
		cardInfo.setCardNo(cardNo);
		List<CardInfo> cardInfos = cardInfoManager.getBySample(cardInfo);
		if (cardInfos.size() > 0) {
			cardInfo = cardInfos.get(0);
		}
		Long cardCreateId = cardInfo.getCreateInfoId();
		CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(cardCreateId);

		PhysicalSubscribe physicalSubscribe = new PhysicalSubscribe();
		physicalSubscribe.setCardNo(cardNo);
		physicalSubscribe.setCancelStatus(0);
		List<PhysicalSubscribe> physicalSubscribeList = physicalSubscribeManager.getBySample(physicalSubscribe);
		if (physicalSubscribeList.size() > 0) {
			physicalSubscribe = physicalSubscribeList.get(0);
		} else {
			String packageId = request.getParameter("PackageId");
			request.getSession().setAttribute("packageId", packageId);
		}
		// 体检预约信息
		Long packageId = physicalSubscribe.getPackageId();
		Long orderId = physicalSubscribe.getOrderId();
		// 查询订单号、下单时间
		SubOrder subOrder = subOrderManager.getByObjectId(orderId);
		Order order  = orderManager.getByObjectId(subOrder.getGeneralOrderId());
		request.setAttribute("generalOrderNo", subOrder.getSubOrderNo());
		request.setAttribute("bookDate", order.getBookingDate());
		// 对应的体检套餐
		WelfarePackage physicalPackage = welfarePackageManager.getByObjectId(packageId);
		WelfareItem welfareItem = welfareManager.getByObjectId(physicalPackage.getSubItemId());
		// 对应的门店
		Long shopId = physicalSubscribe.getStoreId();
		SupplierShop supplierShop = supplierShopManager.getByObjectId(shopId);
		// 查找体检项目
		PhysicalPkgItem physicalPkgItem = new PhysicalPkgItem();
		physicalPkgItem.setPackageId(packageId);
		List<PhysicalPkgItem> physicalPkgItems = physicalPkgItemManager.getBySample(physicalPkgItem);
		List<PhysicalItem> physicalItems = new ArrayList<PhysicalItem>();
		if (physicalPkgItems.size() > 0) {
			for (PhysicalPkgItem p : physicalPkgItems) {
				PhysicalItem physicalItem = new PhysicalItem();
				physicalItem.setObjectId(p.getPhysicalPriceId());
				List<PhysicalItem> vphysicalItems = physicalItemManager.getBySample(physicalItem);
				if (vphysicalItems.size() > 0) {
					physicalItems.add(vphysicalItems.get(0));
				}

			}
		}
		/*根据系统时间设置，控制是否能改期*/
		SystemParameter systemParameter = systemParameterManager.getAdvanceBeSpeakTimeChange();
		Date physicalDate = physicalSubscribe.getPhysicalDate();
		Date nowDate = new Date();

		long time1 = physicalDate.getTime();
		long time2 = nowDate.getTime();

		int hour = (int) ((time1 - time2) / (1000 * 60 * 60));
		if (hour > Integer.parseInt(systemParameter.getValue())) {
			request.setAttribute("show", 1);
		} else {
			request.setAttribute("show", 2);
		}
		request.setAttribute("physicalItems", physicalItems);
		request.setAttribute("pSubscribe", physicalSubscribe);
		request.setAttribute("physicalPackage", physicalPackage);
		request.setAttribute("supplierShop", supplierShop);
		request.setAttribute("cardCreateInfo", cardCreateInfo);
		request.setAttribute("welfareItem", welfareItem);
		return getFileBasePath() + "viewPhysicalDetail";
	}

	/**
	 * 根据 子订单号查询订单详细
	 * 
	 * @param OrderNo
	 *            :总订单号
	 * @param cardNo
	 *            :卡号
	 * @author 巩文杰
	 * @return
	 */
	@RequestMapping("/viewWelfareDetail/{orderNo}")
	public String subOrderDetail(HttpServletRequest request, @PathVariable String orderNo) {

		try {
			List<SubOrder> subOrderes = new ArrayList<SubOrder>();
			Map parmmap = new HashMap();

			// 根据 总订单号查询总订单信息
			Order order = new Order();
			order.setGeneralOrderNo(orderNo);
			List<Order> orderList = orderManager.getBySample(order);
			if (orderList.size() > 0) {
				order = orderList.get(0);
			}
			// 查询订单信息
			if (StringUtils.isNotEmpty(orderNo)) {
				parmmap.put("generalOrderNo", orderNo);
				subOrderes = exchangeManger.subOrderDetail(parmmap);
			}

			// 查询卡号信息

			parmmap.put("cardNo", order.getCashCard());
			List<CardInfo> cardInfoList = cardInfoManager.findCardInfoAndPackageInfo(parmmap);

			request.setAttribute("subOrderes", subOrderes);
			request.setAttribute("cardInfoList", cardInfoList);
			request.setAttribute("order", order);

		} catch (Exception e) {
			e.printStackTrace();
		}

		return "giftExchange/subOrderDetail";
	}

	@RequestMapping(value = "/appointment1/{cardNo}")
	public String appointment1(HttpServletRequest request, @PathVariable String cardNo) throws Exception {
		request.getSession().setAttribute("cardNo", cardNo);
		return "cardExchange/appointment1";
	}

	/**
	 * 兑换功能--卡号密码校验 卡密状态信息(0：待激活 1：激活 2：冻结 3：已过期 4：已使用 5：已作废 6：已删除)
	 * 
	 * @param request
	 * @param cardInfo
	 * @return
	 * @throws IOException
	 */
	@RequestMapping(value = "/validateCard")
	public String validateCard(HttpServletRequest request, HttpServletResponse response, CardInfo cardInfo) throws IOException {
		/*
		 * logger.info("卡号密码校验!!!" + cardInfo.getCardNo() + "==" +
		 * cardInfo.getPassWord());
		 */
		try {
			/**
			 * 步骤一、卡号密码校验
			 */
			Map<String, String> map = exchangeManger.checkTjCard(cardInfo);
			String status = map.get("status"); // 卡状态
			String msg = map.get("msg"); // 卡状态描述
			String code = map.get("code"); // 卡密状态为1-待激活 code:套餐ID 卡密状态为4-已使用
											// code:子订单号
			// 激活状态
			if (!"".equals(status) && "1".equals(status)) {

				if (code != null && !"".equals(code)) { // 套餐ID

					WelfarePackage welfarePackage = welfarePackageManager.getByObjectId(Long.valueOf(code));
					WelfarePackageCategory category = welfarePackageCategoryManager.getByObjectId(welfarePackage.getWpCategoryId());

				}
			} else if (!"".equals(status) && "4".equals(status)) {// 已使用
				if (code != null && !"".equals(code)) { // 子订单号
					return this.subOrderDetail(request, code);
				}
			} else {// 其它状态不合法 则跳转到兑换登录页显示对应的错误提示
				request.setAttribute("msg", msg);
				return "cardExchange/appointment1";
			}
		} catch (Exception e) {
			e.printStackTrace();
			request.setAttribute("msg", "系统异常");
			return "cardExchange/appointment1";
		}
		/*
		 * PhysicalSubscribe pSubscribe = getUserInfo(cardInfo.getCardNo());
		 * request.getSession().setAttribute("pSubscribe", pSubscribe);
		 */
		request.getSession().removeAttribute("pSubscribe");
		return "cardExchange/appointmentFirst";
	}
	
	/**
	 * viewAgreement 查询协议详情
	 * 
	 * @param request response cardInfo
	 * @param cardInfo
	 * @return
	 * @throws IOException
	 */

	@RequestMapping(value = "/viewAgreement")
	public String viewAgreement(HttpServletRequest request, HttpServletResponse response, CardInfo cardInfo) throws IOException {
		String userName = request.getParameter("userName");
		String certificateNo = request.getParameter("certificateNo");
		request.setAttribute("userName", userName);
		request.setAttribute("certificateNo", certificateNo);
		return "cardExchange/viewAgreement";
	}
	/**
	 * appointmentFirst 预约填写基本信息
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/appointmentFirst")
	public String appointmentFirst(HttpServletRequest request, HttpServletResponse response, CardInfo cardInfo) throws IOException {
		PhysicalSubscribe pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");
		request.setAttribute("pSubscribe", pSubscribe);
		return "cardExchange/appointmentFirst";
	}
	
	/**
	 * appointment1Confirm 预约填写基本信息确认
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/appointment1Confirm")
	public String appointment1Confirm(HttpServletRequest request, PhysicalSubscribe pSubscribe) throws Exception {
		String cardNo = (String) request.getSession().getAttribute("cardNo");
		CardInfo card = new CardInfo();
		card.setCardNo(cardNo);
		List<CardInfo> cards = cardInfoManager.getBySample(card);
		if (cards.size() > 0) {
			card = cards.get(0);
		}
		CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(card.getCreateInfoId());
		Long packageId = cardCreateInfo.getPackageId();
		String yyyy = request.getParameter("YYYY");
		String MM = request.getParameter("MM");
		String DD = request.getParameter("DD");
		if (yyyy.length() > 0 && MM.length() > 0 && DD.length() > 0) {
			String birthdayStr = request.getParameter("YYYY") + "-" + request.getParameter("MM") + "-" + request.getParameter("DD");
			SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
			Date birthday = sdf.parse(birthdayStr);
			pSubscribe.setBirthday(birthday);
		}

		pSubscribe.setPackageId(packageId);
		pSubscribe.setCardNo(cardNo);
		if (1 == (pSubscribe.getMarryStatus())) {
			pSubscribe.setMarryStatus(1);
			pSubscribe.setSex(1);
		} else if (2 == (pSubscribe.getMarryStatus())) {
			pSubscribe.setMarryStatus(0);
			pSubscribe.setSex(1);
		} else if (3 == (pSubscribe.getMarryStatus())) {
			pSubscribe.setMarryStatus(1);
			pSubscribe.setSex(0);
		} else {
			pSubscribe.setMarryStatus(0);
			pSubscribe.setSex(0);
		}
		request.getSession().setAttribute("pSubscribe", pSubscribe);
		WelfarePackage welfarePackage = welfarePackageManager.getByObjectId(packageId);
		request.setAttribute("welfarePackage", welfarePackage);

		return "cardExchange/choosePhysicalPackage";
	}

	/**
	 * savePhysicalSubscribeInfo 获取体检机构提供的套餐编号
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	public String getSupplierPackageNo(PhysicalSubscribe pSubscribe) {
		String supplierCode = "";
		PhysicalSupply physicalSupply = new PhysicalSupply();
		physicalSupply.setPackageId(pSubscribe.getPackageId());
		physicalSupply.setSupplierId(pSubscribe.getSupplierId());
		// supplierCode =
		// physicalSupplyManager.getBySample(physicalSupply).get(0).getSupplierCode();
		List<PhysicalSupply> physicalSupplys = physicalSupplyManager.getBySample(physicalSupply);
		if (physicalSupplys.size() > 0) {
			supplierCode = physicalSupplys.get(0).getSupplierCode();
		}
		return supplierCode;
	}
	/**
	 * packageDetail 套餐详情
	 * 
	 * @param objectId 体检套餐ID
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/packageDetail/{objectId}")
	public String packageDetail(HttpServletRequest request, @PathVariable Long objectId) throws Exception {
		WelfarePackage physicalPackage = welfarePackageManager.getByObjectId(objectId);
		List<PhysicalItem> physicalItems = new ArrayList<PhysicalItem>();
		Map<String, Object> param = new HashMap<String, Object>();
		param.put("packageId", objectId);
		physicalItems = physicalItemManager.getPhysicalItem(param);
		request.setAttribute("physicalItems", physicalItems);
		request.getSession().setAttribute("physicalPackage", physicalPackage);
		return "cardExchange/viewPackageDetail";
	}
	/**
	 * listPhysicalStore 查看相应的预约体检机构
	 * 
	 * @param 
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/listPhysicalStore")
	public String listPhysicalStore(HttpServletRequest request) {
		String packageName = request.getParameter("packageName");
		PhysicalSubscribe pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");// 从session中取得voEntity

		Area area = new Area();
		area.setDeepLevel(1);
		List<Area> firstArea = areaManager.getBySample(area);
		request.setAttribute("firstArea", firstArea);

		pSubscribe.setPackageName(packageName);
		request.getSession().setAttribute("pSubscribe", pSubscribe);

		PhysicalSupply sample = new PhysicalSupply();
		sample.setSex(pSubscribe.getSex());
		sample.setPackageId(pSubscribe.getPackageId());
		if(pSubscribe.getSex()==IBSConstants.SEX_WOMAN){
			sample.setIsMarried(pSubscribe.getMarryStatus());
		}
		List<PhysicalSupply> physicalSupplyList = physicalSupplyManager.getBySample(sample);
		List<Supplier> supplierList = new ArrayList<Supplier>();
		for (int i = 0; i < physicalSupplyList.size(); i++) {
			Supplier supplier = supplierManager.getByObjectId(physicalSupplyList.get(i).getSupplierId());
			supplierList.add(supplier);
		}
		// List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		request.setAttribute("supplierList", supplierList);
		return getFileBasePath() + "listPhysicalStore";
	}
	/**
	 * getPhysicalStore 查看相应的门店
	 * 
	 * @param 
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/getPhysicalStore")
	public String getPhysicalStore(HttpServletRequest request, ModelMap modelMap) {
		// List<Supplier> supplierList = supplierManager.querySupplierByType(1);
		String brand = request.getParameter("brand");

		String cityId = request.getParameter("cityId");
		PageSearch page = new PageSearch();
		page.setPageSize(1000);
		page.setCurrentPage(1);
		page.setEntityClass(SupplierShop.class);
		page.getFilters().add(new PropertyFilter("SupplierShop", "EQI_shopType", "1"));
		if (cityId != null && !("").equals(cityId)) {
			page.getFilters().add(new PropertyFilter("SupplierShop", "STARTS_areaId", cityId));
		}
		page.getFilters().add(new PropertyFilter("SupplierShop", "EQL_supplierId", brand));
		page.getFilters().add(new PropertyFilter("SupplierShop", "EQL_isValid", "1"));
		page = supplierShopManager.find(page);
		List<SupplierShop> supplierShopList = page.getList();
		modelMap.addAttribute("supplierShopList", supplierShopList);
		return "jsonView";
	}

	/**
	 * changeDate(体检预约改期页面，体检详情的改期)
	 * 
	 * @param cardNo 体检卡号
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/changeDate/{cardNo}")
	public String changeDate(HttpServletRequest request, @PathVariable String cardNo) throws Exception {
		SystemParameter systemParameter = systemParameterManager.getAdvanceBeSpeakTimeChange();
		PhysicalSubscribe pSubscribe = new PhysicalSubscribe();
		pSubscribe.setCancelStatus(0);
		pSubscribe.setCardNo(cardNo);

		List<PhysicalSubscribe> physicalSubscribes = physicalSubscribeManager.getBySample(pSubscribe);
		if (physicalSubscribes.size() > 0) {
			pSubscribe = physicalSubscribes.get(0);
		}
		/*根据系统设置的时间，控制是否能改期*/
		Date physicalDate = pSubscribe.getPhysicalDate();
		Date nowDate = new Date();

		long time1 = physicalDate.getTime();
		long time2 = nowDate.getTime();

		int hour = (int) ((time1 - time2) / (1000 * 60 * 60));
		if (hour > Integer.parseInt(systemParameter.getValue())) {
			String shopName = supplierShopManager.getByObjectId(pSubscribe.getStoreId()).getShopName();
			String strRegdate = "";
			String regDateFlag = "yes";
			SupplierShop supplierShop = supplierShopManager.getByObjectId(pSubscribe.getStoreId());
			Long supplierId = supplierShop.getSupplierId();
			String supplierName = supplierManager.getByObjectId(supplierId).getSupplierName();
			if(supplierName.equals(IBSConstants.PHYSICAL_SUPPLIER_AK) || supplierName.equals(IBSConstants.PHYSICAL_SUPPLIER_MN)){
				strRegdate = physicalSubscribeManager.getRegDate(pSubscribe.getSupplierId(), pSubscribe.getStoreId());
			}else{
				WelfarePackage  welfarePackage = welfarePackageManager.getByObjectId(pSubscribe.getPackageId());
				SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
				String startDate = sdf.format(welfarePackage.getStartDate());
				strRegdate  = startDate+","+"9999-12-31";
				regDateFlag = "no";
			}
			request.setAttribute("strRegdate", strRegdate);
			request.setAttribute("regDateFlag", regDateFlag);
			request.setAttribute("shopName", shopName);
			request.getSession().setAttribute("cardNo", cardNo);
			request.getSession().setAttribute("pSubscribe", pSubscribe);
			return "cardExchange/changeDate";
		} else {
			request.setAttribute("message", "请在体检日期前" + systemParameter.getValue() + "小时改期！");
			PageSearch page = preparePage(request);
			return handlePage(request, page);
		}

	}

	/**
	 * 
	 * getRegDate(获取不同体检机构排期字符串) TODO(这里描述这个方法适用条件 – 可选)
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	public String getRegDate(Long supplierId, Long storeId) throws Exception {
		String supplierName = supplierManager.getByObjectId(supplierId).getSupplierName();
		String shopNo = supplierShopManager.getByObjectId(storeId).getSupplierShopNo();
		String resultStr = "";
		JSONObject jsonObject = new JSONObject();
		String dateString = "";
		String strRegdate = "";
		// 如果用户选择的体检机构是爱康，走爱康接口调用流程
		if (supplierName.indexOf("爱康") != -1) {
			resultStr = checkup.getHospDate(shopNo, PartnerEnum.AIKANG);
			jsonObject = JSONObject.fromObject(resultStr);
			dateString = jsonObject.getString("list");
			JSONArray dateArray = JSONArray.fromObject(dateString);
			for (int i = 0; i < dateArray.size(); i++) {
				jsonObject = JSONObject.fromObject(dateArray.get(i));
				if (strRegdate == "") {
					strRegdate += jsonObject.getString("strRegdate");
				} else {
					strRegdate += "," + jsonObject.getString("strRegdate");
				}
			}
			// 如果用户选择的体检机构是美年，走美年接口调用流程
		} else if (supplierName.indexOf("美年") != -1) {
			resultStr = checkup.getHospDate(shopNo, PartnerEnum.MEINIAN);
			jsonObject = JSONObject.fromObject(resultStr);
			dateString = jsonObject.getString("data");
			if (dateString.length() > 2) {
				strRegdate = dateString.substring(2, dateString.length() - 1);
				strRegdate = strRegdate.replace("{", "");
				strRegdate = strRegdate.replace("}", "");
			}

		}
		return strRegdate;
	}

	/**
	 * choosePhysicalDate(预约体检时间页面)
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/choosePhysicalDate")
	public String choosePhysicalDate(HttpServletRequest request, PhysicalSubscribe pSubscribe) throws Exception {
		Long storeId = Long.parseLong(request.getParameter("storeId"));
		String strRegdate = "";
		String regDateFlag = "yes";
		SupplierShop supplierShop = supplierShopManager.getByObjectId(storeId);
		Long supplierId = supplierShop.getSupplierId();
		pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");// 从session中取得voEntity
		String supplierName = supplierManager.getByObjectId(supplierId).getSupplierName();
		if (pSubscribe.getStoreId() == null) {
			pSubscribe.setStoreId(storeId);
			pSubscribe.setPhysicalAddress(supplierShop.getAddress());
		}
		if (pSubscribe.getSupplierId() == null) {
			pSubscribe.setSupplierId(supplierId);
		}
		if(supplierName.equals(IBSConstants.PHYSICAL_SUPPLIER_AK) || supplierName.equals(IBSConstants.PHYSICAL_SUPPLIER_MN)){
			strRegdate = physicalSubscribeManager.getRegDate(pSubscribe.getSupplierId(), pSubscribe.getStoreId());
		}else{
			WelfarePackage  welfarePackage = welfarePackageManager.getByObjectId(pSubscribe.getPackageId());
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd");
			String startDate = sdf.format(welfarePackage.getStartDate());
			//String endDate  = sdf.format(welfarePackage.getEndDate());
			strRegdate  = startDate+","+"9999-12-31";
			regDateFlag = "no";
		}
		
		
		request.setAttribute("strRegdate", strRegdate);
		request.setAttribute("regDateFlag", regDateFlag);
		request.getSession().setAttribute("pSubscribe", pSubscribe);
		return "cardExchange/choosePhysicalDate";
	}

	/**
	 * confirmPhysicalDetail(确认体检预约信息)
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/confirmPhysicalDetail")
	public String choosePhysicalReport(HttpServletRequest request, PhysicalSubscribe pSubscribe) throws Exception {
		String physicalDateStr = request.getParameter("physicalDateStr");
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

		pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");
		if (physicalDateStr != null && !"".equals(physicalDateStr)) {
			Date physicalDate = sdf.parse(physicalDateStr);
			pSubscribe.setPhysicalDate(physicalDate);
		}

		request.getSession().setAttribute("pSubscribe", pSubscribe);
		return "cardExchange/confirmPhysicalDetail";
	}

	/**
	 * appointment4(预约成功页面) TODO(这里描述这个方法适用条件 – 可选)
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/appointment4")
	public String appointment4(HttpServletRequest request, PhysicalSubscribe pSubscribe) throws Exception {
		pSubscribe = (PhysicalSubscribe) request.getSession().getAttribute("pSubscribe");
		String supplierPackageNo = physicalSubscribeManager.getSupplierPackageNo(pSubscribe);
		pSubscribe.setSupplierPackgeNo(supplierPackageNo);
		Long userId  =physicalSubscribeManager.getUserIdByCardNo(pSubscribe.getCardNo());
		pSubscribe = physicalSubscribeManager.appointment(pSubscribe);
		if(userId != null){
			pSubscribe.setStaffId(userId);
		}
		if(("1").equals(pSubscribe.getCode())){
			request.setAttribute("message", "体检预约成功");
			/* Long orderId = orderManager.savePhysicalOrderInfo(voEntity); */
			RequestBookingOrder bookingOrder = getBookingOrder(pSubscribe);
			//根据卡号查询卡ID，并传递到订单接口中
			CardInfo cardInfo = cardInfoManager.getCardInfoByCardNo(pSubscribe.getCardNo());
			if(cardInfo!=null){
				bookingOrder.setCashCardId(cardInfo.getObjectId());
			}else{
				request.setAttribute("message", "卡密信息异常");
				return "cardExchange/subscribeFailure";
			}
			//创建订单
			Order order;
			try {
				order = orderManager.createImmediateOrder(bookingOrder);
				physicalSubscribeManager.sendMessageAfterAppointAndCancel(pSubscribe);
				physicalSubscribeManager.sendEmailAfterAppointAndCancel(pSubscribe);
			} catch (RuntimeException e) {
				request.setAttribute("message", e.getMessage());
				return "cardExchange/subscribeFailure";
			}catch (Exception e) {
				request.setAttribute("message", "体检预约失败");
				return "cardExchange/subscribeFailure";
			}
			SubOrder subOrder = new SubOrder();
			subOrder.setGeneralOrderId(order.getObjectId());
			List<SubOrder> subOrders = subOrderManager.getBySample(subOrder);
			if (subOrders.size() > 0) {
				subOrder = subOrders.get(0);
			}
			pSubscribe.setOrderId(subOrder.getObjectId());
			pSubscribe.setCancelStatus(0);
			pSubscribe.setIsSendEmail(IBSConstants.NO_SEND_REPORT_MESSAGE);
			pSubscribe.setIsSendMessage(IBSConstants.NO_SEND_REPORT_EMAIL);
			savePhysicalSubscribeInfo(request, pSubscribe);
			
			/*sendMessage(pSubscribe);
			sendPhysicalEmail(pSubscribe);*/
			return "cardExchange/subscribeSuccess";
		}else{
			request.setAttribute("message", "体检预约失败");
			return "cardExchange/subscribeFailure";
		}
	}


	/**
	 * savePhysicalSubscribeInfo 保存体检预约信息
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	public void savePhysicalSubscribeInfo(HttpServletRequest request, PhysicalSubscribe pSubscribe) {
		pSubscribe = physicalSubscribeManager.save(pSubscribe);
		request.getSession().setAttribute("objectId", pSubscribe.getObjectId());
	}
	/**
	 * CardExchange 礼品兑换，跳转到礼品兑换页面
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return String DOM对象
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/CardExchange/{cardNo}")
	public String CardExchange(HttpServletRequest request, @PathVariable String cardNo) throws Exception {
		request.getSession().setAttribute("cardNo", cardNo);
		return "giftExchange/giftExchangeIndex";
	}

	/**
	 * getSubOrderId 根据体检预约信息查询子订单Id
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return Long 子订单Id
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	public Long getSubOrderId(PhysicalSubscribe pSubscribe) {
		Long orderId = pSubscribe.getOrderId();
		String OrderNo = orderManager.getByObjectId(orderId).getGeneralOrderNo();
		SubOrder subOrder = new SubOrder();
		subOrder.setGeneralOrderNo(OrderNo);
		List<SubOrder> subOrders = subOrderManager.getBySample(subOrder);
		if (subOrders.size() > 0) {
			subOrder = subOrders.get(0);
		}
		return subOrder.getObjectId();
	}
	
	public RequestBookingOrder getBookingOrder(PhysicalSubscribe pSubscribe) {
		RequestBookingOrder bookingOrder = new RequestBookingOrder();
		bookingOrder.setOrderSource(IBSConstants.ORDER_SOURCE_ADMIN);
		bookingOrder.setOrderType(IBSConstants.ORDER_TYPE_PHSYCAL_APPOINTMENT);
		bookingOrder.setUserId(FrameworkContextUtils.getCurrentUserId());
		bookingOrder.setOrderProductType(IBSConstants.ORDER_PRODUCT_TYPE_PHYSICAL);
		bookingOrder.setPakageId(pSubscribe.getPackageId());
		bookingOrder.setCount(1L);
		bookingOrder.setReceiptAddress(pSubscribe.getPostAddress());
		bookingOrder.setReceiptContacts(pSubscribe.getUserName());
		bookingOrder.setReceiptEmail(pSubscribe.getEmail());
		bookingOrder.setReceiptMobile(Long.valueOf(pSubscribe.getCellphoneNo()));
		if(pSubscribe.getPostCode()!=null && StringUtils.isNotBlank(pSubscribe.getPostCode())){
		  bookingOrder.setReceiptZipcode(Long.valueOf(pSubscribe.getPostCode()));
		}
		bookingOrder.setSupplierId(pSubscribe.getSupplierId());
		bookingOrder.setCashCard(pSubscribe.getCardNo());
		bookingOrder.setPaymentWay(IBSConstants.PAY_WAY_OFF_LINE);
		return bookingOrder;
	}
	/**
	 * supplierShopDetail 门店详情
	 * 
	 * @param objectId 门店ID
	 * @param @return 设定文件
	 * @return
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/supplierShopDetail/{objectId}")
	public String supplierShopDetail(HttpServletRequest request, @PathVariable Long objectId) throws Exception {
		SupplierShop supplierShop = supplierShopManager.getByObjectId(objectId);
		request.setAttribute("supplierShop", supplierShop);
		return "cardExchange/viewSupplierShopDetail";
	}

	/**
	 * getGrantWelfareStaff 根据卡号查询相关发放员工
	 * 
	 * @param name
	 * @param @return 设定文件
	 * @return Long 员工Id
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	public GrantWelfareStaff getGrantWelfareStaff(String cardNo) {
		CardInfo cardInfo = new CardInfo();
		cardInfo.setCardNo(cardNo);
		List<CardInfo> cardInfos = cardInfoManager.getBySample(cardInfo);
		if (cardInfos.size() > 0) {
			cardInfo = cardInfos.get(0);
			CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(cardInfo.getObjectId());
			GrantWelfareStaff grantWelfareStaff = new GrantWelfareStaff();
			grantWelfareStaff.setCardId(cardCreateInfo.getObjectId());
			List<GrantWelfareStaff> grantWelfareStaffs = grantWelfareStaffManager.getBySample(grantWelfareStaff);
			if (grantWelfareStaffs.size() > 0) {
				grantWelfareStaff = grantWelfareStaffs.get(0);
				return grantWelfareStaff;
			} else {
				return null;
			}
		}
		return null;
	}
	/**
	 * getaddtionPackage 加项套餐详情页面
	 * 
	 * @param objectId 相应加项套餐的ID字符串
	 * @param @return 设定文件
	 * @return Long 员工Id
	 * @Exception 异常对象
	 * @since CodingExample　Ver(编码范例查看) 1.1
	 */
	@RequestMapping(value = "/getaddtionPackage/{objectId}")
	public String getaddtionPackage(HttpServletRequest request, @PathVariable String objectId) throws Exception {
		List<WelfarePackage> addtionPackages = new ArrayList<WelfarePackage>();
		String[] addtionPackage = objectId.split(",");
		for (int i = 0; i < addtionPackage.length; i++) {
			Long addPackageId = Long.parseLong(addtionPackage[i]);
			addtionPackages.add(welfarePackageManager.getByObjectId(addPackageId));
		}
		request.setAttribute("addtionPackages", addtionPackages);
		return "cardExchange/listAddtionPackage";
	}
}
