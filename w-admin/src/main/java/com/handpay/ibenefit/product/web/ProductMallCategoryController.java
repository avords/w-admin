package com.handpay.ibenefit.product.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.entity.ProductCategoryMapping;
import com.handpay.ibenefit.category.entity.ProductMallCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.category.service.IProductCategoryMappingManager;
import com.handpay.ibenefit.category.service.IProductMallCategoryManager;
import com.handpay.ibenefit.framework.entity.BaseTree;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.MessageUtils;
import com.handpay.ibenefit.framework.web.PageController;

@Controller
@RequestMapping("/productMallCategory")
public class ProductMallCategoryController extends PageController<ProductMallCategory>{
    private static final String BASE_DIR = "product/";

    @Reference(version="1.0")
    private IProductMallCategoryManager productMallCategoryManager;

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;
    
    @Reference(version="1.0")
    private IProductCategoryMappingManager productCategoryMappingManager;
    
	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;
    
    @Override
    public Manager<ProductMallCategory> getEntityManager() {
        return productMallCategoryManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }
    
    @RequestMapping(value = "/page")
    public String page(HttpServletRequest request, ProductMallCategory t, Integer backPage) throws Exception {
    	PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductMallCategory.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
    	productMallCategoryManager.updateSecondCategoryCount();
    	page.getFilters().add(new PropertyFilter("ProductMallCategory","EQI_layer","1"));
		String result = handlePage(request, page);
		afterPage(request, page, backPage);
		return result;
    }
    
	@RequestMapping(value = "/secondpage")
    public String secondPage(HttpServletRequest request, ProductMallCategory t, Integer backPage) throws Exception {
		String firstId = request.getParameter("search_EQL_firstId");
		PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductMallCategory.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
		if(StringUtils.isNotBlank(firstId)){
			ProductMallCategory first = productMallCategoryManager.getProductMallCategoryByFirstId(firstId);
			if(first!=null){
				request.getSession().setAttribute("firstProductMallCategory", first);
			}
		}else{
			ProductMallCategory first = (ProductMallCategory)request.getSession().getAttribute("firstProductMallCategory");
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQL_firstId",first.getFirstId() + ""));
		}
		request.getSession().removeAttribute("secondProductMallCategory");
    	productMallCategoryManager.updateThirdCategoryCount();
    	page.getFilters().add(new PropertyFilter("ProductMallCategory","EQI_layer","2"));
    	handlePage(request, page);
		afterPage(request, page, backPage);
		return getFileBasePath() + "listProductMallSecondCategory";
    }
	
	@RequestMapping(value = "/thirdpage")
    public String thirdPage(HttpServletRequest request, ProductMallCategory t, Integer backPage) throws Exception {
		String secondId = request.getParameter("search_EQL_secondId");
		PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductMallCategory.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
		if(StringUtils.isNotBlank(secondId)){
			ProductMallCategory first = productMallCategoryManager.getProductMallCategoryBySecondId(secondId);
			if(first!=null){
				request.getSession().setAttribute("secondProductMallCategory", first);
			}
		}else{
			ProductMallCategory first = (ProductMallCategory)request.getSession().getAttribute("secondProductMallCategory");
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQL_secondId",first.getSecondId() + ""));
		}
    	page.getFilters().add(new PropertyFilter("ProductMallCategory","EQI_layer","3"));   	
    	handlePage(request, page);
		afterPage(request, page, backPage);
		return getFileBasePath() + "listProductMallThirdCategory";
    }
	
	@RequestMapping(value = "/createMallSecondCategory")
	public String createMallSecondCategory(HttpServletRequest request, HttpServletResponse response, ProductMallCategory t) throws Exception {
		request.setAttribute("canInvalid", true);
		return getFileBasePath() + "editProductMallSecondCategory";
	} 
	
	@RequestMapping(value = "/editMallSecondCategory/{secondId}")
	public String editMallSecondCategory(HttpServletRequest request, HttpServletResponse response, @PathVariable Long secondId)
			throws Exception {
		if (null != secondId) {
			ProductMallCategory entity = getManager().getByObjectId(secondId);
			request.setAttribute("entity", entity);
			request.setAttribute("canInvalid", productMallCategoryManager.canInvalid(entity.getObjectId()));
		}
		 return getFileBasePath() + "editProductMallSecondCategory";
	}

	@RequestMapping(value = "/createMallThirdCategory")
	public String createMallThirdCategory(HttpServletRequest request, HttpServletResponse response, ProductMallCategory t) throws Exception {
		request.setAttribute("canInvalid", true);
		return editMallThirdCategory(request, response, null);
	} 
	
	@RequestMapping(value = "/editMallThirdCategory/{objectId}")
	public String editMallThirdCategory(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId)
			throws Exception {
		ProductCategory sample = new ProductCategory();
		sample.setStatus(IBSConstants.EFFECTIVE);
		List<ProductCategory> leftCategories = productCategoryManager.getBySample(sample);
		List<ProductCategory> rightCategories = null;
		if (null != objectId) {
			ProductMallCategory entity = getManager().getByObjectId(objectId);
			rightCategories = productCategoryManager.getProductCategoriesByMallCategoryId(entity.getObjectId());
			request.setAttribute("entity", entity);
			request.setAttribute("canInvalid", productMallCategoryManager.canInvalid(objectId));
		}else{
			rightCategories = new ArrayList<ProductCategory>(0);
		}
		
		//添加二级分类到右边树
		outer1: for(ProductCategory category : leftCategories){
			if(category.getLayer()==2){
				for(ProductCategory temp : rightCategories){
					if(category.getSecondId().equals(temp.getSecondId())){
						rightCategories.add(category);
						continue outer1;
					}
				}
			}
		}
		//添加一级分类到右边树
		outer2: for(ProductCategory category : leftCategories){
			if(category.getLayer()==1){
				for(ProductCategory temp : rightCategories){
					if(category.getFirstId().equals(temp.getFirstId())){
						rightCategories.add(category);
						continue outer2;
					}
				}
			}
		}
		request.setAttribute("leftNodes", buildNodes(leftCategories));
		request.setAttribute("rightNodes", buildNodes(rightCategories));
		return getFileBasePath() + "editProductMallThirdCategory";
	}
	
	@RequestMapping(value = "/save")
	public String save(HttpServletRequest request, ModelMap modelMap, @Valid ProductMallCategory t, BindingResult result) 
			throws Exception {
		ProductMallCategory first = (ProductMallCategory)request.getSession().getAttribute("firstProductMallCategory");
		ProductMallCategory second = (ProductMallCategory)request.getSession().getAttribute("secondProductMallCategory");
		String layer = request.getParameter("layer");
		if (layer!=null) {
			if(t.getObjectId()==null){
				Long no = null;
				if(layer.equals("1")){
					no = sequenceManager.getNextId("SEQ_FIRST_ID");
					t.setFirstId(no);
				}else if(layer.equals("2")){
					no = sequenceManager.getNextId("SEQ_SECOND_ID");
					t.setSecondId(no);
					t.setFirstId(first.getFirstId());
					t.setPlatform(first.getPlatform());
				}else if(layer.equals("3")){
					no = sequenceManager.getNextId("SEQ_THIRD_ID");
					t.setThirdId(no);
					t.setFirstId(second.getFirstId());
					t.setSecondId(second.getSecondId());
					t.setPlatform(first.getPlatform());
				}
			}
			
			if(layer.equals("1")){
				//多个平台分别保存
				if(t.getObjectId()==null){
					String[] platform = request.getParameterValues("platform");
					for(String p : platform){
						t.setObjectId(null);
						t.setPlatform(Integer.parseInt(p));
						t.setFirstId(sequenceManager.getNextId("SEQ_FIRST_ID"));
						getManager().save(t);
					}
				}else{
					getManager().save(t);
				}
				return "redirect:page" + getMessage("common.base.success", request);
			}else if(layer.equals("2")){
				getManager().save(t);
				return "redirect:secondpage" + getMessage("common.base.success", request);
			}else if(layer.equals("3")){
				t = getManager().save(t);
				if(t.getObjectId()!=null){
					ProductCategoryMapping sample = new ProductCategoryMapping();
					sample.setMallCategoryId(t.getObjectId());
					productCategoryMappingManager.deleteBySample(sample);
					String cetegoryId = request.getParameter("selelctedIds");
					if(StringUtils.isNotBlank(cetegoryId)){
						String[] cetegoryIds = cetegoryId.split(",");
						// 保存专属商品信息
						for(String id : cetegoryIds){
							ProductCategoryMapping mapping = new ProductCategoryMapping();
							mapping.setMallCategoryId(t.getObjectId());
							mapping.setProductCategoryId(Long.parseLong(id));
							productCategoryMappingManager.save(mapping);
						}
					}
				}
				return "redirect:thirdpage" + getMessage("common.base.success", request);
			}
		}
		return "redirect:page";
	}

	/**
	 * 构造商品运营分类Left tree的结构
	 * @param	商品运营分类List
	 * @return	Left tree的HTML
	 */
	private String buildNodes(List<ProductCategory> productCategories) {
		StringBuilder leftNodes = new StringBuilder();
		leftNodes.append("[");
		for (ProductCategory productCategory1 : productCategories) {
			if (productCategory1.getLayer() == 1) {
				leftNodes.append("{id:" + productCategory1.getFirstId() + ", pId:" + BaseTree.ROOT + ", name:'" + productCategory1.getName()+ "', open:true},");
				for (ProductCategory productCategory2 : productCategories) {
					if (productCategory2.getLayer() == 2 && productCategory2.getFirstId().equals(productCategory1.getFirstId())) {
						leftNodes.append("{id:" + productCategory2.getSecondId() + ", pId:" + productCategory2.getFirstId() + ", name:'" + productCategory2.getName()+ "', open:true},");
						for (ProductCategory productCategory3 : productCategories) {
							if (productCategory3.getLayer() == 3 && productCategory3.getSecondId().equals(productCategory2.getSecondId()) && 
									productCategory3.getFirstId().equals(productCategory1.getFirstId())) {
								leftNodes.append("{id:" + productCategory3.getObjectId() + ", pId:" + productCategory3.getSecondId() + ", name:'" + productCategory3.getName()+ "'},");
							}
						}
					}
				}
			}
		}
		if(leftNodes.length()>1){
			return leftNodes.subSequence(0, leftNodes.length()-1)+ "]";
		}else{
			return leftNodes + "]";
		}
	}
	
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		String message = null;
		if(objectId!=null && productMallCategoryManager.canDelete(objectId)){
			delete(objectId);
			ProductCategoryMapping sample = new ProductCategoryMapping();
			sample.setMallCategoryId(objectId);
			productCategoryMappingManager.deleteBySample(sample);
			message = "删除成功";
		} else {
			message = "不能删除";
		}
		String action = request.getParameter("action");
		return "redirect:" + action + "?message=" + MessageUtils.urlEncodeWithUtf8(message) + "&" + appendAjaxParameter(request);
	}
	
	@RequestMapping(value = "/invalid")
	@ResponseBody
	public String invalid(HttpServletRequest request, String ids,Integer status) throws Exception {
		int result = 0;
		if(StringUtils.isNotBlank(ids)){
			for(String id : ids.split(",")){
				Long objectId = null;
				try{
					objectId = Long.parseLong(id);
				}catch(Exception e){
				}
				if(objectId!=null && productMallCategoryManager.canInvalid(objectId)){
					productMallCategoryManager.updateStatus(objectId, IBSConstants.INVALID);
					result ++;
				}
			}
		}
		return String.valueOf(result);
	}
	
	@RequestMapping(value = "/saveSortNos")
	@ResponseBody
	public String saveSortNos(HttpServletRequest request, String ids,String sortNos) throws Exception {
		boolean result = false;
		if(StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(sortNos)){
			productMallCategoryManager.updateSortNoByObjectId(ids, sortNos);
			result = true;
		}
		return String.valueOf(result);
	}
	
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId) throws Exception {
		if(objectId!=null){
			request.setAttribute("canInvalid", productMallCategoryManager.canInvalid(objectId));
		}else{
			request.setAttribute("canInvalid", true);
		}
		
		return super.handleEdit(request, response, objectId);
	}
	
}
