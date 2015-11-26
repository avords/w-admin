package com.handpay.ibenefit.insure.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.ExcelUtil;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.insure.entity.InsureOrder;
import com.handpay.ibenefit.insure.entity.InsureOrderUser;
import com.handpay.ibenefit.insure.entity.InsureUserTemp;
import com.handpay.ibenefit.insure.service.IInsureBaseManager;
import com.handpay.ibenefit.insure.service.IInsureOrderManager;
import com.handpay.ibenefit.insure.service.IInsureOrderUserManager;
import com.handpay.ibenefit.insure.service.IInsureUserTempManager;
import com.handpay.ibenefit.member.entity.CompanyPublished;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ICompanyPublishedManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.product.entity.AttributeValue;
import com.handpay.ibenefit.product.entity.ProductPublish;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.IAttributeValueManager;
import com.handpay.ibenefit.product.service.IProductPublishManager;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.Role;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IRoleManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/insureOrder")
public class InsureOrderController extends PageController<InsureOrder>{
    private static final String BASE_DIR = "insure/";

    @Reference(version = "1.0")
    private IInsureOrderManager iInsureOrderManager;
    @Reference(version = "1.0")
    private IInsureOrderUserManager iInsureOrderUserManager;
    @Reference(version = "1.0")
    private IInsureBaseManager iInsureBaseManager;
    @Reference(version = "1.0") 
    private IInsureUserTempManager insureUserTempManager;
    @Reference(version = "1.0")
    private ICompanyPublishedManager iCompanyPublishedManager;
    @Reference(version = "1.0")
    private IProductPublishManager productPublishManager;
    @Reference(version = "1.0")
    private IAttributeValueManager attributeValueManager;
    @Reference(version = "1.0")
    private ISkuPublishManager iSkuPublishManager;
    @Reference(version = "1.0")
    private IUserManager iUserManager;
    @Reference(version = "1.0")
    private IRoleManager iRoleManager;
    @Reference(version = "1.0")
    private ISubOrderManager iSubOrderManager;
    @Reference(version = "1.0")
	private ISupplierManager iSupplierManager;
    @Reference(version = "1.0")
	private IDictionaryManager dictionaryManager;
    
    @Override
    public Manager<InsureOrder> getEntityManager() {
        return iInsureOrderManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    /**
	 *
	 * 核保单查询界面列表显示
	 */
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch page1 = preparePage(request);
		PageSearch result = iInsureOrderManager.findInsureOrder(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listInsureOrder";
	}
	
	@Override
	protected String handleView(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		InsureOrder insureOrder = iInsureOrderManager.getByObjectId(objectId);
		if (insureOrder != null) {
			if (insureOrder.getCompanyId() != null) {
				CompanyPublished company = iCompanyPublishedManager.getByObjectId(insureOrder.getCompanyId());
				request.setAttribute("company", company);
			}else{
				request.setAttribute("company", null);
			}
			if (insureOrder.getProductId() != null) {
				ProductPublish productPublish = productPublishManager.getByObjectId(insureOrder.getProductId());
				request.setAttribute("productPublish", productPublish);
			}else{
				request.setAttribute("productPublish", null);
			}
			if (insureOrder.getAttribute1ValueId() != null) {
				AttributeValue attributeValue = attributeValueManager.getByObjectId(insureOrder.getAttribute1ValueId());
				request.setAttribute("attributeValue", attributeValue);
			}else{
				request.setAttribute("productPublish", null);
			}
			if (insureOrder.getCreatedBy() != null) {
				User user = iUserManager.getByObjectId(insureOrder.getCreatedBy());
				if (user.getRoleId()!=null) {
					Role role = iRoleManager.getByObjectId(user.getRoleId());
					request.setAttribute("role", role);
				}else{
					request.setAttribute("role", null);
				}
				request.setAttribute("user", user);
			}
			if (insureOrder.getSubOrderId() != null) {
				SubOrder subOrder = iSubOrderManager.getByObjectId(insureOrder.getSubOrderId());
				request.setAttribute("subOrder", subOrder);
			}else{
				request.setAttribute("subOrder", null);
			}
			if (insureOrder.getSupplierId() != null) {
				Supplier supplier = iSupplierManager.getByObjectId(insureOrder.getSupplierId());
				request.setAttribute("supplier", supplier);
			}else{
				request.setAttribute("supplier", null);
			}
			Integer allNum = iInsureOrderUserManager.getInsureNum(objectId,null);
			Integer passNum = iInsureOrderUserManager.getInsureNum(objectId, InsureOrderUser.STATUS_PASS);
			Integer notPassNum = iInsureOrderUserManager.getInsureNum(objectId, InsureOrderUser.STATUS_NOT_PASS);
			request.setAttribute("allNum", allNum);
			request.setAttribute("passNum", passNum);
			request.setAttribute("notPassNum", notPassNum);
			request.setAttribute("insureOrder", insureOrder);
		}
		return getFileBasePath() + "editInsureOrder";
	}
	
	@RequestMapping("exportAll/{insureOrderId}")
	public String exportAll(HttpServletRequest request, HttpServletResponse response,@PathVariable Long insureOrderId) throws Exception {
		String[] titles={"序号","单位名称","合同号","姓名","工号","手机号码","证件类型","证件号码","性别","出生年月",
				"职业类型","社保类型","投保方案（层级）","生效日期","理赔账号开户人","理赔账号开户分行","理赔账户账号","保费","核保","既往症","备注"};
		//List<InsureBase> list = iInsureBaseManager.findInsureInfo(insureOrderId);
		InsureOrderUser temp = new InsureOrderUser();
		temp.setInsureOrderId(insureOrderId);
		List<InsureOrderUser> list = iInsureOrderUserManager.getBySample(temp);
		if (list!=null && list.size()>0) {
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
				InsureOrderUser insureOrderUser = list.get(i);
				Object[] arr = new Object[21];
				arr[0] = i+1;
				arr[1] = insureOrderUser.getCompanyName();
				arr[2] = insureOrderUser.getContractNo();
				arr[3] = insureOrderUser.getUserName();
				arr[4] = insureOrderUser.getWorkNo();
				arr[5] = insureOrderUser.getMobilePhone();
				arr[6] = insureOrderUser.getType();
				arr[7] = insureOrderUser.getCardNo();
				arr[8] = insureOrderUser.getSex();
				arr[9] = insureOrderUser.getBirthday();
				arr[10] = insureOrderUser.getOccupationalType();
				arr[11] = insureOrderUser.getSocialSecurityType();
				arr[12] = insureOrderUser.getInsurePlan();
				if (insureOrderUser.getEffectiveDate()!=null) {
					arr[13] = DateUtils.date2String(insureOrderUser.getEffectiveDate(), "yyyy/MM/dd");
				}
				arr[14] = insureOrderUser.getClaimsAccountUser();
				arr[15] = insureOrderUser.getClaimsAccountBranch();
				arr[16] = insureOrderUser.getClaimsAccountAccount();
				arr[17] = insureOrderUser.getPremiumq();
				arr[18] = insureOrderUser.getStatus();
				arr[19] = insureOrderUser.getPastDisease();
				arr[20] = insureOrderUser.getRemark();
				datas.add(arr);
			}
			
			String exportName = "";
			exportName = FileUpDownUtils.encodeDownloadFileName(request, "核保用户信息_"+new Date().getTime()+".xls");
			ExcelUtil excelUtil=new ExcelUtil();
			excelUtil.exportExcel(response, datas, titles, exportName);
		}
		return null;
	}
	
	@RequestMapping(value = "/importInsureOrder/{insureOrderId}")
    public String importInsureOrder(HttpServletRequest request,HttpServletResponse response,@PathVariable Long insureOrderId){
		request.setAttribute("insureOrderId", insureOrderId);
		return getFileBasePath() + "importInsureOrder";
    }
	
	@RequestMapping("impInsureInfo/{insureOrderId}")
	public String importInsureInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap,@PathVariable Long insureOrderId) throws Exception {
		Long userId=FrameworkContextUtils.getCurrentUserId();
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		String msg = "";
		boolean result = false;
		if(uploadFile!=null ){
			byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
			msg = iInsureOrderUserManager.importInsureInfo(fileData, insureOrderId,userId);
		}
		String[] arr = msg.split("|");
		if ("0".equals(arr[0])) {
			result = true;
		}
		request.setAttribute("result", result);
		request.setAttribute("msg", arr[1]);
		request.setAttribute("insureOrderId", insureOrderId);
		return getFileBasePath() + "importInsureOrderResult";
	}
	
	/**
	 * 导出上传错误数据
	 * @param request
	 * @param response
	 * @param insureOrderId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("excResult/{insureOrderId}")
	public String excResult(HttpServletRequest request, HttpServletResponse response,@PathVariable Long insureOrderId) throws Exception {
		String[] titles={"序号","单位名称","合同号","姓名","工号","手机号码","证件类型","证件号码","性别","出生年月",
				"职业类型","社保类型","投保方案（层级）","生效日期","理赔账号开户人","理赔账号开户分行","理赔账户账号","保费","核保","既往症","备注","错误说明"};
		//List<InsureBase> list = iInsureBaseManager.findInsureInfo(insureOrderId);
		InsureUserTemp temp = new InsureUserTemp();
		temp.setInsureOrderId(insureOrderId);
		List<InsureUserTemp> list = insureUserTempManager.getBySample(temp);
		if (list!=null && list.size()>0) {
			List<Dictionary> dictionaries = dictionaryManager.getDictionariesByDictionaryId(1610);
			Map<Integer,String> valid = new HashMap<Integer,String>();
			for(Dictionary dictionary : dictionaries){
				if(dictionary.getStatus()!=null && dictionary.getStatus()){
					valid.put(dictionary.getValue(), dictionary.getName());
				}
			}
			List<Object[]> datas = new ArrayList<Object[]>();
			for (int i=0;i<list.size();i++) {
				InsureUserTemp insureUserTemp = list.get(i);
				Object[] arr = new Object[22];
				arr[0] = i+1;
				arr[1] = insureUserTemp.getCompanyName();
				arr[2] = insureUserTemp.getContractNo();
				arr[3] = insureUserTemp.getUserName();
				arr[4] = insureUserTemp.getWorkNo();
				arr[5] = insureUserTemp.getMobilePhone();
				arr[6] = insureUserTemp.getType();
				arr[7] = insureUserTemp.getCardNo();
				arr[8] = insureUserTemp.getSex();
				arr[9] = insureUserTemp.getBirthday();
				arr[10] = insureUserTemp.getOccupationalType();
				arr[11] = insureUserTemp.getSocialSecurityType();
				arr[12] = insureUserTemp.getInsurePlan();
				if (insureUserTemp.getEffectiveDate()!=null) {
					arr[13] = DateUtils.date2String(insureUserTemp.getEffectiveDate(),"yyyy/MM/dd");
				}
				arr[14] = insureUserTemp.getClaimsAccountUser();
				arr[15] = insureUserTemp.getClaimsAccountBranch();
				arr[16] = insureUserTemp.getClaimsAccountAccount();
				arr[17] = insureUserTemp.getPremiumq();
				arr[18] = insureUserTemp.getStatus();
				arr[19] = insureUserTemp.getPastDisease();
				arr[20] = insureUserTemp.getRemark();
				arr[21] = insureUserTemp.getDescribe();
				datas.add(arr);
			}
			
			String exportName = "";
			exportName = FileUpDownUtils.encodeDownloadFileName(request, "导入核保用户信息_"+new Date().getTime()+".xls");
			ExcelUtil excelUtil=new ExcelUtil();
			excelUtil.exportExcel(response, datas, titles, exportName);
		}
		return null;
	}
}
