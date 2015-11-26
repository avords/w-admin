package com.handpay.ibenefit.news.web;

import java.io.IOException;
import java.io.OutputStream;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.DateUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.news.entity.Contract;
import com.handpay.ibenefit.news.entity.ContractTemplate;
import com.handpay.ibenefit.news.service.IContractManager;
import com.handpay.ibenefit.news.service.IContractTemplateManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/contract")
public class ContractController extends PageController<Contract> {

	private static final String BASE_DIR = "news/";

	@Reference(version = "1.0")
	private IContractManager contractManager;

	@Reference(version = "1.0")
	private IFileManager fileManager;

	@Reference(version = "1.0")
	private IContractTemplateManager contractTemplateManager;

	@Reference(version = "1.0")
	private IUserManager userManager;

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Override
	public Manager<Contract> getEntityManager() {
		return contractManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		getManager().delete(objectId);
		return "redirect:../page";
	}

	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap, Contract t) throws Exception {
		Date startDate = t.getStartDate();
		Date endDate = t.getEndDate();
		Long objectId = t.getObjectId();
		if (objectId != null) {
			t = contractManager.getByObjectId(objectId);
			t.setStartDate(startDate);
			t.setEndDate(endDate);
		}
		UploadFile uploadFile = null;
		try {
			uploadFile = FileUpDownUtils.getUploadFile(request, "attachmentNo");
			if (null != uploadFile) {
				byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
				String filePath = fileManager.saveContractFile(fileData, uploadFile.getFileName());
				t.setAttachmentNo(filePath);
			}
		} catch (IOException e1) {

		}
		/*
		 * if (t.getCustomerType()!=null) { if(1L !=t.getCustomerType()){
		 * if(StringUtils.isNotBlank(t.getManagerId())){ Long userId =
		 * Long.parseLong(t.getManagerId());
		 * t.setManagerId(userManager.getUserByUserId(userId).getUserName()); }
		 * 
		 * } }
		 */
		t.setUploadDate(new Date());
		t.setUploadUserId(FrameworkContextUtils.getCurrentLoginName());
		if (objectId != null) {
			t = getManager().updateById(t);
		} else {
			t = save(t);
		}
		if (t.getCustomerType() != null && 1L == t.getCustomerType()) {
			if (t.getCustomerNo() != null) {
				Supplier supplier = supplierManager.getByObjectId(t.getCustomerNo());
				supplier.setContractId(t.getObjectId());
				supplier.setContractNo(t.getContractNo());
				supplierManager.save(supplier);
			}
		}
		return "redirect:page/" + getMessage("common.base.success", request) + "&" + appendAjaxParameter(request)
				+ "&action=" + request.getParameter("action");
	}

	@Override
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		String startDateShow = DateUtils.getPreviousOrNextDaysOfNow(DateUtils.getCurrentDate(), 1);
		request.setAttribute("startDateShow", startDateShow);
		return super.handleEdit(request, response, objectId);

	}

	@RequestMapping(value = "/chooseCustomer")
	public String chooseCustomer(HttpServletRequest request, SupplierShop t, Integer backPage) throws Exception {
		String customerType = request.getParameter("customerType");
		if ("1".equals(customerType)) {
			return "redirect:/supplier/getSupplierInfo?ajax=1";
		} else {
			return "redirect:/company/getCompanyInfo?ajax=1";
		}
	}

	@RequestMapping(value = "/downloadFile")
	public String downloadFile(HttpServletRequest request, HttpServletResponse response) throws Exception {
		String filePath = request.getParameter("filePath");
		String fileName = filePath.substring(filePath.lastIndexOf("/") + 1);
		response.setContentType("APPLICATION/OCTET-STREAM");
		response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
		byte[] fileData = fileManager.getFile(filePath);
		OutputStream out = response.getOutputStream();
		out.write(fileData);
		out.flush();
		out.close();
		return null;
	}

	@RequestMapping("/importTemplate")
	public String importInfo(HttpServletRequest request) {
		return "news/importTemplate";
	}

	protected String handlePage(HttpServletRequest request, PageSearch page) {
		PageSearch result = getManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);

		ContractTemplate contractTemplate = new ContractTemplate();
		List<ContractTemplate> contractTemplates = contractTemplateManager.getAll();
		if (contractTemplates.size() > 0) {
			contractTemplate = contractTemplates.get(0);
			request.setAttribute("filePath", contractTemplate.getContractTemPath());
		}
		List<User> users = userManager.getUserByUserType(IBSConstants.USER_TYPE_IBS_OPERATOR);
		request.setAttribute("users", users);
		return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
	}

	@RequestMapping("/checkContractNo")
	public String checkContractNo(HttpServletRequest request, ModelMap modelMap) {
		String contractNo = request.getParameter("contractNo");
		boolean ret = true;

		if (StringUtils.isNotEmpty(contractNo)) {
			Contract contract = new Contract();
			contract.setContractNo(contractNo);
			boolean isUnique = contractManager.isUnique(contract);
			ret = isUnique;
		}
		modelMap.addAttribute("result", ret);
		return "jsonView";
	}
}
