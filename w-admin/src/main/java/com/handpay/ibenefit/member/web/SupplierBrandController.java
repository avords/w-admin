package com.handpay.ibenefit.member.web;

import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierBrand;
import com.handpay.ibenefit.member.service.ISupplierBrandManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.product.entity.Brand;
import com.handpay.ibenefit.product.service.IBrandManager;

@Controller
@RequestMapping("/supplierBrand")
public class SupplierBrandController extends PageController<SupplierBrand>{
	private static final String BASE_DIR = "member/";
	
	Logger logger = Logger.getLogger(SupplierBrandController.class);
	
	@Reference(version = "1.0")
	private ISupplierBrandManager supplierBrandManager;

	@Reference(version = "1.0")
	private ISupplierManager supplierManager;
	
	@Reference(version = "1.0")
	private IBrandManager brandManager;

	@Reference(version = "1.0")
	private IProductCategoryManager productCategoryManager;
	
	@Reference(version = "1.0")
	private IDictionaryManager dictionaryManager;
	
	@Override
	public Manager<SupplierBrand> getEntityManager() {
		return supplierBrandManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			SupplierBrand t) throws Exception {
		boolean flag=false;
		//供应商ID
		String supplierId=request.getParameter("supplierID");
		if (StringUtils.isBlank(supplierId)) {
			logger.error("supplierId can not null");
		}else {
			t.setSupplierId(Long.parseLong(supplierId));
		}
		String proCtgy1=request.getParameter("category1");
		String proCtgy2=request.getParameter("category2");
		String proCtgy3=request.getParameter("category3");
		Date startDate = t.getTermStart();
		Date endDate = t.getTermEnd();
		//如果有三级分类则肯定有一级和二级分类，则验证改数据是否唯一（时间不验证）
		if (StringUtils.isNotBlank(proCtgy3)) {
			t.setTermStart(null);
			t.setTermEnd(null);
			t.setCategoryId(proCtgy3);
			flag = getEntityManager().isUnique(t);
			if (!flag) {
				modelMap.addAttribute("brandError", true);
			}
			
			t.setCategoryThree(productCategoryManager.getByObjectId(Long.parseLong(proCtgy3)).getName());
			t.setCategoryTwo(productCategoryManager.getProductCategoryBySecondId(proCtgy2).getName());
			
			ProductCategory productCategory=new ProductCategory();
			productCategory.setFirstId(proCtgy1);
			productCategory.setLayer(1);
			List<ProductCategory> productCategories=productCategoryManager.getBySample(productCategory);
			t.setCategoryOne(productCategories.get(0).getName());
		}else if (StringUtils.isNotBlank(proCtgy2)) {//否则，如果是二级分类，则验证数据唯一
			t.setTermStart(null);
			t.setTermEnd(null);
			t.setCategoryId(proCtgy2);
			flag = getEntityManager().isUnique(t);
			if (!flag) {
				modelMap.addAttribute("brandError", true);
			}
			
			t.setCategoryTwo(productCategoryManager.getProductCategoryBySecondId(proCtgy2).getName());
			
			ProductCategory productCategory=new ProductCategory();
			productCategory.setFirstId(proCtgy1);
			productCategory.setLayer(1);
			List<ProductCategory> productCategories=productCategoryManager.getBySample(productCategory);
			t.setCategoryOne(productCategories.get(0).getName());
		}else if (StringUtils.isNotBlank(proCtgy1)) {//否则，如果是一级分类，则验证数据唯一
			t.setTermStart(null);
			t.setTermEnd(null);
			t.setCategoryId(proCtgy1);
			flag = getEntityManager().isUnique(t);
			if (!flag) {
				modelMap.addAttribute("brandError", true);
			}
			
			ProductCategory productCategory=new ProductCategory();
			productCategory.setFirstId(proCtgy1);
			productCategory.setLayer(1);
			List<ProductCategory> productCategories=productCategoryManager.getBySample(productCategory);
			t.setCategoryOne(productCategories.get(0).getName());
		}else {//无产品分类
			SupplierBrand tBrand=new SupplierBrand();
			tBrand.setSupplierId(Long.parseLong(supplierId));
			tBrand.setBrandId(t.getBrandId());
			tBrand.setBrandLevel(t.getBrandLevel());
			List<SupplierBrand> tBrands=supplierBrandManager.getBySample(tBrand);
			if (tBrands.size()!=0) {
				boolean find=false;
				for(SupplierBrand sbb:tBrands){
					if(sbb.getCategoryId()==null && StringUtils.isBlank(sbb.getCategoryOne()) && StringUtils.isBlank(sbb.getCategoryTwo())){
						find=true;
					}
				}
				if (find) {
					modelMap.addAttribute("brandError", true);
				}else {
					flag=true;
				}
			}else{
				flag=true;
			}
		}
		
		if (flag) {//代理品牌唯一
			t.setTermStart(startDate);
			t.setTermEnd(endDate);
			t.setIsPublished(IBSConstants.STATUS_NO);
			t=getEntityManager().save(t);
			//代理品牌
			modelMap.addAttribute("sBrand",t);
			//品牌名称
			Brand brand=brandManager.getByObjectId(t.getBrandId());
			modelMap.addAttribute("brandName", brand.getChineseName());
			//代理级别
			Dictionary dictionary=dictionaryManager.getDictionaryByDictionaryId(1317);
			if (dictionary!=null && dictionary.getObjectId()!=null) {
				Dictionary temp=new Dictionary();
				temp.setParentId(dictionary.getObjectId());
				temp.setType(2);
				temp.setValue(t.getBrandLevel());
				List<Dictionary> lists=dictionaryManager.getBySample(temp);
				if (lists.size()!=0 && lists.get(0)!=null) {
					modelMap.addAttribute("levelName",lists.get(0).getName());
				}
			}else {
				modelMap.addAttribute("levelName",t.getBrandLevel());
			}
			
			//有效期
			DateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd");
			String start = dateFormat.format(t.getTermStart());
			String end=dateFormat.format(t.getTermEnd());
			String time="";
			time=time.concat(start);
			if (StringUtils.isNotBlank(end)) {
				time=time.concat("至");
				time=time.concat(end);
			}
			modelMap.addAttribute("time", time);
		}
		return "jsonView";

	}

	/**
	 * 
	  * 删除代理品牌
	  *
	  * @Title: deleteBrand
	  * @Description: TODO
	  * @param @param request
	  * @param @param response
	  * @param @param objectId
	  * @param @param modelMap
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/deleteBrand/{objectId}")
	protected String deleteBrand(HttpServletRequest request,
			HttpServletResponse response,@PathVariable Long objectId,ModelMap modelMap) throws Exception {
		getEntityManager().delete(objectId);
		modelMap.addAttribute("result", true);
		return "jsonView";
	}
	
	/**
	 * 
	  * 保存代理品牌
	  *
	  * @Title: saveBrands
	  * @Description: TODO
	  * @param @param request
	  * @param @param response
	  * @param @param modelMap
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/saveBrands")
	protected String saveBrands(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap) throws Exception {
		String supplierId=request.getParameter("supplierID");
		if (StringUtils.isNotBlank(supplierId)) {
			Long id=Long.parseLong(supplierId);
			SupplierBrand sb=new SupplierBrand();
			sb.setSupplierId(id);
			List<SupplierBrand> sBrands=supplierBrandManager.getBySample(sb);
			if (sBrands.size()==0) {
				modelMap.addAttribute("noBrands",true);
			}else {
				for(SupplierBrand sBrand:sBrands){
					//改临时变正式
					if (sBrand.getIsPublished()==IBSConstants.STATUS_NO) {
						sBrand.setIsPublished(IBSConstants.STATUS_YES);
						supplierBrandManager.save(sBrand);
					}
				}
				modelMap.addAttribute("result", true);
			}
			Supplier supplier=supplierManager.getByObjectId(id);
			if (supplier!=null) {
				supplier.setStatus(IBSConstants.VERIFY_STATUS_DRAFT);
				supplierManager.save(supplier);
			}
		}
		return "jsonView";
	}
	
	/**
	 * 
	  * 检查代理品牌是否保存
	  *
	  * @Title: checkBrands
	  * @Description: TODO
	  * @param @param request
	  * @param @param response
	  * @param @param modelMap
	  * @param @return
	  * @param @throws Exception    设定文件
	  * @return String    返回类型
	  * @throws
	 */
	@RequestMapping("/checkBrands")
	protected String checkBrands(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap) throws Exception {
		String supplierId=request.getParameter("supplierID");
		if (StringUtils.isNotBlank(supplierId)) {
			Long id=Long.parseLong(supplierId);
			SupplierBrand sb=new SupplierBrand();
			sb.setSupplierId(id);
			sb.setIsPublished(IBSConstants.STATUS_NO);
			List<SupplierBrand> sBrands=supplierBrandManager.getBySample(sb);
			if (sBrands.size()!=0) {
				modelMap.addAttribute("result", true);
			}else {
				modelMap.addAttribute("result", false);
			}
		}
		return "jsonView";
	}
}
