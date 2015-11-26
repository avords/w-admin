/**
 * 
 */
package com.handpay.ibenefit.welfare.web;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Arrays;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.ExcelUtil;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.grantWelfare.service.IGrantWelfareManager;
import com.handpay.ibenefit.order.entity.ChangeOrder;
import com.handpay.ibenefit.order.entity.ChnaOrderCard;
import com.handpay.ibenefit.order.entity.OrderSku;
import com.handpay.ibenefit.order.service.IChangeOrderManager;
import com.handpay.ibenefit.order.service.IChnaOrderCardManager;
import com.handpay.ibenefit.order.service.IOrderProductManager;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.entity.CardOperateLog;
import com.handpay.ibenefit.welfare.service.ICardCreateInfoManager;
import com.handpay.ibenefit.welfare.service.ICardInfoManager;
import com.handpay.ibenefit.welfare.service.ICardOperateLogManager;
import com.handpay.ibenefit.welfare.service.IWpRelationManager;

/**
 * @author liran
 * 
 */
@Controller
@RequestMapping("/cardInfo")
public class CardInfoController extends PageController<CardInfo> {

	private static final String BASE_DIR = "welfare/";

	@Reference(version = "1.0")
	private ICardInfoManager cardInfoManager;

	@Reference(version = "1.0")
	private IWpRelationManager wpRelationManager;

	@Reference(version = "1.0")
	private ICardCreateInfoManager cardCreateInfoManager;

	@Reference(version = "1.0")
	private ICardOperateLogManager cardOperateLogManager;
	@Reference(version = "1.0")
	private IOrderProductManager orderProductManager;
	
	@Reference(version = "1.0")
	private IChnaOrderCardManager chnaOrderCardManager;
	
	@Reference(version = "1.0")
	private IDictionaryManager dictionaryManager; 
	
	@Reference(version = "1.0")
	private IGrantWelfareManager grantWelfareManager;
	
	
	@Reference(version = "1.0")
    private IChangeOrderManager changeOrderManager;

	@Override
	public Manager<CardInfo> getEntityManager() {
		return cardInfoManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	/**
	 * 根据卡密生成的项目主键ID到卡密列表页面
	 * 
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/page/{createInfoId}")
	public String page(HttpServletRequest request, CardInfo t,
			Integer backPage, @PathVariable String createInfoId)
			throws Exception {
		CardCreateInfo cardCreateInfo = new CardCreateInfo();
		cardCreateInfo = cardCreateInfoManager.getByObjectId(Long.parseLong(createInfoId));
		request.setAttribute("cardCreateInfo", cardCreateInfo);
		List<CardOperateLog> cardOperateLogList = cardOperateLogManager.getCardOperateLogByCreateInfoId(Long.parseLong(createInfoId));
		request.setAttribute("logitems", cardOperateLogList);
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter("CardInfo", "EQL_createInfoId",createInfoId));
		request.setAttribute("cardStatus",page.getFilterValue("EQI_cardStatus"));
		String result = handlePage(request, page);
		afterPage(request, page, backPage);
		return result;
	}
	
	@RequestMapping("exportAll/{createInfoId}")
	public String exportAll(HttpServletRequest request,CardInfo t,
			HttpServletResponse response,@PathVariable String createInfoId) throws Exception {
		String objectIdStr= request.getParameter("objectIdArray");
		if(objectIdStr.equals("null")){
			objectIdStr = null;
		}
		String[]  objectIdArray = null;
		List idList = null;
		if (StringUtils.isNotEmpty(objectIdStr)) {
			objectIdArray = objectIdStr.split(",");
			idList = Arrays.asList(objectIdArray);
		}
		String[] titles={"序号","状态","卡号","密码","有效时间"};
		CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByObjectId(Long.parseLong(createInfoId));
		List<Dictionary> dictionaries = dictionaryManager.getDictionariesByDictionaryId(1604);
		Map<Integer,String> valid = new HashMap<Integer,String>();
		for(Dictionary dictionary : dictionaries){
			if(dictionary.getStatus()!=null && dictionary.getStatus()){
				valid.put(dictionary.getValue(), dictionary.getName());
			}
		}
		
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("createInfoId",createInfoId);
		param.put("cardStatus", request.getParameter("search_EQI_cardStatus"));
		param.put("cardNo", request.getParameter("search_LIKES_cardNo"));
		param.put("objIds",idList);
		
		List<CardInfo> cardInfoList = cardInfoManager.getCardInfoByParam(param);
		List<Object[]> datas = new ArrayList<Object[]>();
		String startDate = "";
		String endDate = "";
		for (int i=0;i<cardInfoList.size();i++) {
			CardInfo cardInfo = cardInfoList.get(i);
			Object[] arr = new Object[5];
			arr[0] = i+1;
			arr[1] = valid.get(cardInfo.getCardStatus());  
			arr[2] = cardInfo.getCardNo();			
			arr[3] = cardInfo.getPassWord();			 
			//arr[4] = cardInfo.getUpdateTime();
			//arr[5] = cardInfo.getUpdateUser();
			if (cardCreateInfo!=null) {
				startDate = DateUtils.getDateFormat(DateUtils.FORMAT_YYYY_MM_DD).format(cardCreateInfo.getStartDate());
				endDate = DateUtils.getDateFormat(DateUtils.FORMAT_YYYY_MM_DD).format(cardCreateInfo.getEndDate());
			}
			arr[4] = startDate+" - "+endDate;
			datas.add(arr);
		}
		
		String exportName = "cardInfo.xls";
		 
		ExcelUtil excelUtil=new ExcelUtil();
		excelUtil.exportExcel(response, datas, titles, exportName);
		return null;
	}

	
	/**
	 * 根据卡密生成的项目主键ID，得到可退换货的卡密信息
	 * 
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/card/{createInfoId}")
	public String cardInfo(HttpServletRequest request,
			@PathVariable Long createInfoId) {
		String createInfoIdL = createInfoId.toString();
		PageSearch page = preparePage(request);	
		request.setAttribute("index", request.getParameter("index"));
	    String changeNo=request.getParameter("changeNo");
	    //若是编辑则先将退的卡删除
	  	if( changeNo!=null){				
	  			ChangeOrder chanOrder=new ChangeOrder();
	  			chanOrder.setChangeNo(changeNo);
	  			List<ChangeOrder> list=changeOrderManager.getBySample(chanOrder);
	  			if(list.size()>0){
	  				ChnaOrderCard chacard=new ChnaOrderCard();
	  				chacard.setChangeOrderId(list.get(0).getObjectId());
	  				chnaOrderCardManager.deleteBySample(chacard);
	  			}
	  		}	    
		page.getFilters().add(
				new PropertyFilter("CardInfo", "EQL_createInfoId",
						createInfoIdL));
		PageSearch result = cardInfoManager.findCardInfo(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		if(StringUtils.isBlank(changeNo)||StringUtils.isNotBlank(changeNo)){
		List<CardInfo> list = page.getList();
		for(CardInfo ci:list){
			ChnaOrderCard coc = new ChnaOrderCard();
			coc.setCardId(ci.getObjectId());			
			List<ChnaOrderCard> chs = chnaOrderCardManager.getBySample(coc);
			if(chs.size()>0){
				ci.setIsChangeOrderCard(1);
			}else{
				ci.setIsChangeOrderCard(0);
			}
		 }
		}		
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("createInfoId", createInfoId);
		return "order/changeProductCard";
	}

	/**
	 * page方法，根据数量查看卡发送了多少还剩余多少并实现列表显示
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/orderCard")
	public String page(HttpServletRequest request) throws Exception {
		// 得到发送了多少卡还剩多少卡
		String productId1=request.getParameter("productId");
		String createInfoId=request.getParameter("createInfoId");
		String productCount1=request.getParameter("productCount");
		String subOrderId=request.getParameter("subOrderId");
		if(productId1!=null&&createInfoId!=null&&productCount1!=null){
	
		Long productCount = Long.parseLong(request.getParameter("productCount"));
		request.setAttribute("productCount", productCount);
	
		//CardCreateInfo cardCreateInfo = cardCreateInfoManager.getByPackageId(productId);
		//if (createInfoId != null) {
//			List<CardInfo> cardInfos = cardInfoManager.getCardByCreateInfoId(Long.valueOf(createInfoId));
//			for (CardInfo cardInfo : cardInfos) {
//				if (cardInfo.getCardStatus() == IBSConstants.CARD_ACTIVATION || cardInfo.getCardStatus() == IBSConstants.CARD_FREEZE
//						|| cardInfo.getCardStatus() == IBSConstants.CARD_EXPIRED ||cardInfo.getCardStatus() == IBSConstants.CARD_USED ) {
//					sendedCount += 1;
//				}
//			}
		//计算已发放份数
		Long sendedCount = grantWelfareManager.getSubOrderByGranted(Long.valueOf(subOrderId)) ;
		
		//}
		 request.setAttribute("sendedCount", sendedCount);		  
	    }		
		if(createInfoId!=null&&productId1!=null&&productCount1==null&&subOrderId!=null){
			Long productId = Long.parseLong(productId1);
			Long subOrderI= Long.parseLong(subOrderId);
			OrderSku orderSku=orderProductManager.getByProduct(productId,subOrderI);
			 Long productCount=orderSku.getProductCount();	
			 
			//List<CardInfo> cardInfos = cardInfoManager.getCardByCreateInfoId(createInfo);
			//for (CardInfo cardInfo : cardInfos) {
				//if (cardInfo.getCardStatus() == IBSConstants.CARD_ACTIVATION || cardInfo.getCardStatus() == IBSConstants.CARD_FREEZE
					//	|| cardInfo.getCardStatus() == IBSConstants.CARD_EXPIRED ||cardInfo.getCardStatus() == IBSConstants.CARD_USED ) {
					//sendedCount += 1;
			//}
			//}
			//计算已发放份数
			Long sendedCount = grantWelfareManager.getSubOrderByGranted(Long.valueOf(subOrderId)) ;

			request.setAttribute("sendedCount", sendedCount);
			request.setAttribute("productCount", productCount);
			
		 }
			PageSearch page = preparePage(request);
			page.getFilters().add(
					new PropertyFilter("CardInfo", "EQL_createInfoId",createInfoId));
			PageSearch result = cardInfoManager.findCardInfo(page);
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, IS_NOT_BACK);
			request.setAttribute("createInfoId", createInfoId);
			request.setAttribute("productId", productId1);
			request.setAttribute("subOrderId", subOrderId);
		   return "order/editProductCard";
		   		
	}
	
	/**
	 * 重写saveToPage方法，根据传入的status参数改写卡密状态，并返回到卡密信息页面
	 * 
	 * @param request
	 * @param modelMap
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request) throws Exception {
		String loginuser = (String)request.getSession().getAttribute(SecurityConstants.LOGIN_NAME);
		Date time = new Date();
		String createInfoId = request.getParameter("createInfoId");
		String cardStatus = request.getParameter("cardStatus");
		String objectIds = request.getParameter("objectIdArray");
		int count = 0;
		//如果没有勾选，则查询条件所有，更新卡密状态
		if (objectIds==null || "".equals(objectIds)) {
			String tempStatus = request.getParameter("tempStatus");
			CardInfo cardInfo = new CardInfo();
			cardInfo.setCardStatus(Integer.parseInt(tempStatus));
			cardInfo.setCreateInfoId(Long.parseLong(createInfoId));
			List<CardInfo> list = cardInfoManager.getBySample(cardInfo);
			if (list !=null && list.size()>0) {
				for (CardInfo ci : list) {
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("objectId", ci.getObjectId());
					param.put("cardStatus", cardStatus);
					param.put("updateUser", loginuser);
					param.put("updateTime", time);
					cardInfoManager.updateCardStatus(param);
				}
				count = list.size();
			}
		}else {
			String[]  objectIdArray = objectIds.split(",");
			//更新卡密状态
			for (int i = 0; i < objectIdArray.length; i++) {
				if(objectIdArray[i]!=null && ! ("").equals(objectIdArray[i])){
					Map<String, Object> param = new HashMap<String, Object>();
					param.put("objectId", objectIdArray[i]);
					param.put("cardStatus", cardStatus);
					param.put("updateUser", loginuser);
					param.put("updateTime", time);
					cardInfoManager.updateCardStatus(param);
				}
			}
			count = objectIdArray.length;
		}
		
		//更新卡密状态后写入日志表信息
		CardOperateLog cardOperateLog = new CardOperateLog();
		cardOperateLog.setCreateInfoId(Long.parseLong(createInfoId));
		cardOperateLog.setOperateTime(time);
		cardOperateLog.setOperateUser(loginuser);
		cardOperateLog.setOperateType(Integer.parseInt(cardStatus));
		cardOperateLog.setOperateAmount(count);
		cardOperateLogManager.save(cardOperateLog);

		return "redirect:page/" + createInfoId
				+ getMessage("common.base.success", request);
	}
	
	@RequestMapping(value = "/countCardInUse/{createInfoId}")
	public String countCardInUse(HttpServletRequest request, 
			CardInfo t,Integer backPage, @PathVariable String createInfoId)	throws Exception {
		CardCreateInfo cardCreateInfo = new CardCreateInfo();
		cardCreateInfo = cardCreateInfoManager.getByObjectId(Long.parseLong(createInfoId));
		request.setAttribute("cardCreateInfo", cardCreateInfo);
		List<CardOperateLog> cardOperateLogList = cardOperateLogManager.getCardOperateLogByCreateInfoId(Long.parseLong(createInfoId));
		request.setAttribute("logitems", cardOperateLogList);
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter("CardInfo", "EQL_createInfoId",createInfoId));
		request.setAttribute("cardStatus",page.getFilterValue("EQI_cardStatus"));
		String result = handlePage(request, page);
		
		Integer cardInUseNum  = cardCreateInfoManager.countCardInUse(Long.parseLong(createInfoId));
		request.setAttribute("cardInUseNum",cardInUseNum);		
		
		
		afterPage(request, page, backPage);
		//return result;
		return "welfare/listCardInfoInUse";
	}

}
