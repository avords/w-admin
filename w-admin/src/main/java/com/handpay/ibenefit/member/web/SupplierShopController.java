package com.handpay.ibenefit.member.web;

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
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.entity.AreaInfo;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.cache.ICacheManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.AreaUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierShop;
import com.handpay.ibenefit.member.entity.SupplierTypes;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.member.service.ISupplierShopManager;
import com.handpay.ibenefit.member.service.ISupplierTypesManager;
import com.handpay.ibenefit.security.entity.User;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/supplierShop")
public class SupplierShopController extends PageController<SupplierShop>{
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private ISupplierShopManager supplierShopManager;
	
	@Reference(version = "1.0")
	private ISupplierTypesManager supplierTypesManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private IUserManager userManager;
	@Reference(version = "1.0")
	private ICacheManager cacheManager;
	@Reference(version = "1.0")
	private IAreaManager areaManager;
	@Reference(version="1.0")
	private IFileManager fileManager;
	
	@Override
	public Manager<SupplierShop> getEntityManager() {
		return supplierShopManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			SupplierShop t) throws Exception {
		t.setUpdatedBy(FrameworkContextUtils.getCurrentUserId());
		t.setUpdatedOn(new Date());
		if (IBSConstants.INVALID==t.getIsValid()) {
			t.setIsValid(IBSConstants.STATUS_NO);
		}
		String img=request.getParameter("shopImage");
		t.setShopImage(img);
		getEntityManager().save(t);
		return "redirect:/supplierShop/page"+getMessage("common.base.success", request);
	}
	
	@Override
	protected String handleEdit(HttpServletRequest request,
			HttpServletResponse response, Long objectId) throws Exception {
		if (objectId!=null) {
			SupplierShop supplierShop=getEntityManager().getByObjectId(objectId);
			if (supplierShop.getSupplierId()!=null) {
				request.setAttribute("supplierId", supplierShop.getSupplierId());
			}
		}
		return super.handleEdit(request, response, objectId);
	}
	
	@Override
	protected String handlePage(HttpServletRequest request, PageSearch page) {
	/*	Supplier supplier=new Supplier();
		supplier.setStatus(3);
		List<Supplier> suppliers=supplierManager.getBySample(supplier);
		request.setAttribute("suppliers", suppliers);
		User user=new User();
		user.setStatus(IBSConstants.STATUS_YES);
		List<User> users=userManager.getBySample(user);
		request.setAttribute("users", users);
		handleFind(page);
		fillAreaInfo(page.getList());
		request.setAttribute("action", "page");*/
		String province = request.getParameter("search_LIKES_province");
		String city = request.getParameter("search_LIKES_city");
		request.setAttribute("province", province);
		request.setAttribute("city", city);
	 	Area area = new Area();
	    area.setDeepLevel(1);
	    List<Area> firstArea = areaManager.getBySample(area);
	    request.setAttribute("firstArea", firstArea);
	  
	 	PageSearch result = supplierShopManager.getSupplierShop(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listSupplierShop";
	}
	
	private void fillAreaInfo(List<SupplierShop> list){
		List<Area> allAreas = (List<Area>)cacheManager.getObject(AreaUtils.CACHE_KEY_GET_ALL_AREA);
		if(allAreas==null){
			allAreas = areaManager.getAll();
			cacheManager.set(AreaUtils.CACHE_KEY_GET_ALL_AREA, allAreas);
		}
		for(SupplierShop company : list){
			AreaInfo areaInfo = new AreaInfo();
			if(StringUtils.isNotBlank(company.getAreaId())){
				areaInfo.setAreaCode(company.getAreaId());
				AreaUtils.setCity(areaInfo, allAreas);
				company.setAreaInfo(areaInfo);
			}
		}
	}
	
	/**
	 * 获取供应商门店
	 * @param request
	 * @return
	 */
	@RequestMapping("/getSupplierShop")
	protected String getSupplierShop(HttpServletRequest request) {
		String province = request.getParameter("search_LIKES_province");
		String city = request.getParameter("search_LIKES_city");
		request.setAttribute("province", province);
		request.setAttribute("city", city);
	 	Area area = new Area();
	    area.setDeepLevel(1);
	    List<Area> firstArea = areaManager.getBySample(area);
	    request.setAttribute("firstArea", firstArea);
	    
		/*Supplier supplier=new Supplier();
		supplier.setStatus(3);
		List<Supplier> suppliers=supplierManager.getBySample(supplier);
		request.setAttribute("suppliers", suppliers);
		User user=new User();
		user.setStatus(IBSConstants.STATUS_YES);
		List<User> users=userManager.getBySample(user);
		request.setAttribute("users", users);*/
		
		PageSearch page = preparePage(request);
		String supplierId = request.getParameter("supplierId");
		if (StringUtils.isNotEmpty(supplierId)) {
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQI_supplierId",supplierId));
		}
		/*PageSearch result = supplierShopManager.find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		if (StringUtils.isNotEmpty(supplierId)) {
			request.setAttribute("supplierId", supplierId);
		}else{
			request.setAttribute("supplierId", null);
		}*/
		PageSearch result = supplierShopManager.getSupplierShop(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		return "/vendorPhysical/listSupplierShop";
	}
	
	/**
	 * 根据供应商类型获得审核通过的供应商
	 * @param request
	 * @param typeId
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/getSuppliers/{typeId}")
	public String verifySuccess(HttpServletRequest request,@PathVariable String typeId,ModelMap modelMap) throws Exception {
		SupplierTypes supplierTypes=new SupplierTypes();
		supplierTypes.setTypeId(Integer.parseInt(typeId));
		List<SupplierTypes> supplierTypes2=supplierTypesManager.getBySample(supplierTypes);
		List<Supplier> suppliers=new ArrayList<Supplier>();
		for(SupplierTypes sTypes:supplierTypes2){
			Supplier supplier=supplierManager.getByObjectId(sTypes.getSupplierId());
			if (supplier!=null ) {
				if (supplier.getStatus() != null) {
					if (supplier.getStatus()==3) {
						suppliers.add(supplier);
					}
				}
			}
		}
		modelMap.addAttribute("suppliers",suppliers);
		return "jsonView";
	}
	
	/**
	 * 批量删除门店
	 * @param request
	 * @param ids
	 * @param modelMap
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/deleteAll/{ids}")
	public String deleteAll(HttpServletRequest request,@PathVariable String ids,ModelMap modelMap) throws Exception {
		if (StringUtils.isNotBlank(ids)) {
			String[] array=ids.split(",");
			for (int i = 0; i < array.length; i++) {
				getEntityManager().delete(Long.parseLong(array[i]));
			}
		}
		modelMap.addAttribute("result",true);
		return "jsonView";
	}
	
	/**
	 * 检查供应商内部门店代号
	  * checkSupplierShopNo(这里用一句话描述这个方法的作用)
	  *
	  * @Title: checkSupplierShopNo
	  * @Description: TODO
	  * @param @param request
	  * @param @param modelMap
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/checkSupplierShopNo")
	public String checkSupplierShopNo(HttpServletRequest request,ModelMap modelMap) throws Exception {
		String supplierShopNo = request.getParameter("supplierShopNo");
		String shopType = request.getParameter("shopType");
		String supplierId = request.getParameter("supplierId");
		String objectId = request.getParameter("objectId");
		SupplierShop supplierShop = new SupplierShop();
		supplierShop.setSupplierShopNo(supplierShopNo);
		if (StringUtils.isNotBlank(shopType)) {
			supplierShop.setShopType(Integer.parseInt(shopType));
		}
		if (StringUtils.isNotBlank(supplierId)) {
			supplierShop.setSupplierId(Long.parseLong(supplierId));
		}
		if (StringUtils.isNotEmpty(objectId)) {
			supplierShop.setObjectId(Long.parseLong(objectId));
		}
		boolean ret = supplierShopManager.isUnique(supplierShop);
		modelMap.addAttribute("ret",ret);
		return "jsonView";
	}
	
	
	//上传或更新门店主图
	@RequestMapping("/uploadShopImage")
    @ResponseBody
    public String uploadShopImage(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object> map = new HashMap<String,Object>();
        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile1");
        long fl = uploadFile.getFile().length();
        if(fl > 3*1024*1024){
        	map.put("result", false);
        	map.put("msg", "上传图片大小不可超过3MB");
        	AjaxUtils.doAjaxResponseOfMap(response, map);
    	    return null;
        }
        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        
        String filePath = fileManager.saveCompanyLogo(fileData, uploadFile.getFileName());
        map.put("result",true);
        map.put("filePath", filePath.trim());
        AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
	}
}
