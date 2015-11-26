package com.handpay.ibenefit.member.web;

import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyAccount;
import com.handpay.ibenefit.member.entity.CompanyPublished;
import com.handpay.ibenefit.member.service.ICompanyAccountManager;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ICompanyPublishedManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/companyAccount")
public class CompanyAccountController extends PageController<CompanyAccount>{
	
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private ICompanyAccountManager companyAccountManager;
	@Reference(version = "1.0")
	private IUserManager userManager;
	@Reference(version = "1.0")
	private ICompanyManager companyManager;
	@Reference(version = "1.0")
	private ICompanyPublishedManager companyPublishedManager;
	
	@Override
	public Manager<CompanyAccount> getEntityManager() {
		return companyAccountManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch pSearch=preparePage(request);
		PageSearch result=companyAccountManager.findCompanyAccounts(pSearch);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listCompanyAccount";
	}
	
	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		List<CompanyPublished> companys=companyPublishedManager.getAll();
		request.setAttribute("companys", companys);
		if (null != objectId) {
			CompanyAccount entity = getEntityManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		return getFileBasePath() + "edit" + getActualArgumentType().getSimpleName();
	}
	
	@Override
	protected String handleSaveToPage(HttpServletRequest request, ModelMap modelMap,
			CompanyAccount t) throws Exception {
		String companyId=request.getParameter("companyId");
		if (StringUtils.isNotBlank(companyId)) {
			User user=userManager.getUserByCompanyAdmin(Long.parseLong(companyId),IBSConstants.INVALID);
			if (user!=null) {
				t.setAccountStatus(user.getStatus());
				t.setCompanyAdminId(user.getObjectId());
				if (user.getAccountBalance()!=null) {
					t.setAccountMoney(user.getAccountBalance());
				}else {
					t.setAccountMoney(0D);
				}
			}else {
				t.setAccountStatus(2);
			}
		}
		if (t.getObjectId()==null) {
			t.setApplyId(FrameworkContextUtils.getCurrentUserId());
			t.setApplyTime(new Date());
			t.setStatus(1);
		}
		t=getEntityManager().save(t);
		return "redirect:edit/"+t.getObjectId()+getMessage("common.base.success", request)+"&" + appendAjaxParameter(request);
	}
	
	/**
	 * 账户充值审核
	 * @param request
	 * @return
	 */
	@RequestMapping("/verify")
	public String verifyCompanyAccount(HttpServletRequest request) {
		PageSearch pSearch=preparePage(request);
		PageSearch result=companyAccountManager.findCompanyAccounts(pSearch);
		pSearch.setTotalCount(result.getTotalCount());
		pSearch.setList(result.getList());
		afterPage(request, pSearch, PageUtils.IS_NOT_BACK);
		return "member/listCompanyAccountVerify";
	}
	
	/**
	 * 根据企业ID获得企业账户
	 * @param request
	 * @param response
	 * @param companyId
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/getAccountByCompanyId/{companyId}")
    public String getAccountByCompanyId(HttpServletRequest request, HttpServletResponse response,@PathVariable String companyId,ModelMap map) throws Exception {
		User user=null;
		if (StringUtils.isNotBlank(companyId)) {
			user=userManager.getUserByCompanyAdmin(Long.parseLong(companyId),IBSConstants.INVALID);
		}
		if (user!=null) {
			map.addAttribute("loginName", user.getLoginName());
		}else {
			map.addAttribute("loginName", false);
		}
	    return "jsonView";
    }
	
	/**
	 * 取消申请
	 * @param request
	 * @param response
	 * @param id
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/cancleApply/{id}")
    public String cancleApply(HttpServletRequest request, HttpServletResponse response,@PathVariable String id,ModelMap map) throws Exception {
		CompanyAccount companyAccount=companyAccountManager.getByObjectId(Long.parseLong(id));
		if (companyAccount!=null) {
			companyAccount.setStatus(2);
			companyAccountManager.save(companyAccount);
			map.addAttribute("result", true);
		}else {
			map.addAttribute("result", false);
		}
	    return "jsonView";
    }
	
	/**
	 * 审核通过
	 * @param request
	 * @param response
	 * @param id
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/verifySuccess/{id}")
    public String verifySuccess(HttpServletRequest request, HttpServletResponse response,@PathVariable String id,ModelMap map) throws Exception {
		CompanyAccount companyAccount=companyAccountManager.getByObjectId(Long.parseLong(id));
		if (companyAccount!=null) {
			companyAccount.setStatus(3);
			companyAccount.setVerifierId(FrameworkContextUtils.getCurrentUserId());
			companyAccount.setVerifyDate(new Date());
			if (companyAccount.getCompanyAdminId()!=null) {
				User user=userManager.getByObjectId(companyAccount.getCompanyAdminId());
				if (user.getAccountBalance()!=null) {
					companyAccount.setAccountMoney(user.getAccountBalance()+companyAccount.getRechargeMoney());
				}else {
					companyAccount.setAccountMoney(0+companyAccount.getRechargeMoney());
				}
			}
			companyAccountManager.save(companyAccount);
			Double money=0D;
			User temp=userManager.getByObjectId(companyAccount.getCompanyAdminId());
			if (temp.getAccountBalance()!=null) {
				money=temp.getAccountBalance();
			}
			temp.setAccountBalance(companyAccount.getRechargeMoney()+money);
			userManager.save(temp);
			map.addAttribute("result", true);
		}else {
			map.addAttribute("result", false);
		}
	    return "jsonView";
    }
	
	/**
	 * 审核不通过
	 * @param request
	 * @param response
	 * @param id
	 * @param map
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/verifyFail")
    public String verifyFail(HttpServletRequest request, HttpServletResponse response,ModelMap map) throws Exception {
		String id=request.getParameter("id");
		if (StringUtils.isNotBlank(id)) {
			CompanyAccount companyAccount=companyAccountManager.getByObjectId(Long.parseLong(id));
			if (companyAccount!=null) {
				companyAccount.setStatus(4);
				companyAccount.setVerifierId(FrameworkContextUtils.getCurrentUserId());
				companyAccount.setVerifyDate(new Date());
				String reasons=request.getParameter("reasons");
				companyAccount.setReasons(reasons);
				companyAccountManager.save(companyAccount);
				map.addAttribute("result", true);
			}else {
				map.addAttribute("result", false);
			}
		}
	    return "jsonView";
    }
	
	@RequestMapping("/reasonsForFail/{companyAccountId}")
	public String reasonsForFail(ModelMap modelMap, HttpServletRequest request, @PathVariable Long companyAccountId) {
		request.setAttribute("companyAccountId", companyAccountId);
		return BASE_DIR + "editCompanyAccountFail";
	}
}
