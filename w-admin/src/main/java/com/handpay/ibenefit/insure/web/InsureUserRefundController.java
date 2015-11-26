package com.handpay.ibenefit.insure.web;

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
import com.handpay.ibenefit.framework.entity.AbstractEntity;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
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
import com.handpay.ibenefit.insure.entity.InsureUserRefund;
import com.handpay.ibenefit.insure.entity.InsureUserTemp;
import com.handpay.ibenefit.insure.service.IInsureBaseManager;
import com.handpay.ibenefit.insure.service.IInsureOrderManager;
import com.handpay.ibenefit.insure.service.IInsureOrderUserManager;
import com.handpay.ibenefit.insure.service.IInsureUserRefundManager;
import com.handpay.ibenefit.insure.service.IInsureUserTempManager;
import com.handpay.ibenefit.member.entity.CompanyPublished;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ICompanyPublishedManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.order.entity.SubOrder;
import com.handpay.ibenefit.order.service.ISubOrderManager;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.ISkuPublishManager;
import com.handpay.ibenefit.security.entity.Role;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IRoleManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/insureUserRefund")
public class InsureUserRefundController extends PageController<InsureUserRefund>{
    private static final String BASE_DIR = "insure/";

    @Reference(version = "1.0")
    private IInsureUserRefundManager insureUserRefundManager;
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
    public Manager<InsureUserRefund> getEntityManager() {
        return insureUserRefundManager;
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
		PageSearch result = insureUserRefundManager.findInsureRefunList(page1);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listInsureUserRefund";
	}
	
	@RequestMapping(value = "/addRefundInsure")
    public String addRefundInsure(HttpServletRequest request,HttpServletResponse response){
		return getFileBasePath() + "addRefundInsure";
    }
	
	@RequestMapping(value = "/check")
    public String check(HttpServletRequest request,HttpServletResponse response,ModelMap map){
		String contractNo = request.getParameter("contractNo");
		String refundName = request.getParameter("refundName");
		InsureOrder insureOrder = new InsureOrder();
		insureOrder.setContractNo(contractNo);
		List<InsureOrder> insureOrders = iInsureOrderManager.getBySample(insureOrder);
		if (insureOrders!=null && insureOrders.size()>0) {
			insureOrder = insureOrders.get(0);
			User user = new User();
			user.setLoginName(refundName);
			List<User> users = iUserManager.getBySample(user);
			if (users!=null && users.size()>0) {
				user = users.get(0);
				InsureOrderUser insureOrderUser = new InsureOrderUser();
				insureOrderUser.setInsureOrderId(insureOrder.getObjectId());
				insureOrderUser.setUserId(user.getObjectId());
				List<InsureOrderUser> insureOrderUsers = iInsureOrderUserManager.getBySample(insureOrderUser);
				if (insureOrderUsers!=null && insureOrderUsers.size()>0) {
					insureOrderUser = insureOrderUsers.get(0);
					map.put("result", true);
					map.put("insureOrder", insureOrder);
					map.put("insureOrderUser", insureOrderUser);
				}else{
					map.put("result", false);
					map.put("msg", "该账户未在此保单中，无法退保！");
				}
			}else{
				map.put("result", false);
				map.put("msg", "该账户不存在！");
			}
		}else{
			map.put("result", false);
			map.put("msg", "合同号不正确！");
		}
		return "jsonView";
    }
	
	protected String handleSave(HttpServletRequest request, ModelMap modelMap, InsureUserRefund insureUserRefund) throws Exception {
		insureUserRefund = save(insureUserRefund);
		return getFileBasePath() + "listInsureUserRefund";
		//return "redirect:edit/" + insureUserRefund.getObjectId() + getMessage("common.base.success", request)
				//+ "&" + appendAjaxParameter(request) + "&action=" + request.getParameter("action");
	}
	
	@RequestMapping(value = "/importInsureRefund")
    public String importInsureRefund(HttpServletRequest request,HttpServletResponse response,@PathVariable Long insureOrderId){
		return getFileBasePath() + "importInsureRefund";
    }
	
	@RequestMapping("impInsureRefund")
	public String importInsureInfo(HttpServletRequest request, HttpServletResponse response, ModelMap modelMap,@PathVariable Long insureOrderId) throws Exception {
		Long userId=FrameworkContextUtils.getCurrentUserId();
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		boolean result = false;
		if(uploadFile!=null ){
			byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
			insureUserRefundManager.importInsureRefund(fileData,userId);
			result = true;
		}
		//modelMap.addAttribute("result", result);
		request.setAttribute("result", result);
		//AjaxUtils.doAjaxResponseOfMap(response, modelMap);
		return getFileBasePath() + "importInsureRefundResult";
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
				Object[] arr = new Object[9];
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
				arr[13] = DateUtils.date2String(insureUserTemp.getEffectiveDate(),"yyyy-MM-dd");
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
	
	/**
	 * 逻辑删除
	 * @param request
	 * @param response
	 * @return
	 */
	@RequestMapping(value = "/doDelete")
    public String doDelete(HttpServletRequest request,HttpServletResponse response){
		Long userId=FrameworkContextUtils.getCurrentUserId();
		String objectIds = request.getParameter("objectIds");
		insureUserRefundManager.delete(objectIds, userId);
		return getFileBasePath() + "listInsureUserRefund";
    }
}
