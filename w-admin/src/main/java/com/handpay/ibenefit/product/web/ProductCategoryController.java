package com.handpay.ibenefit.product.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

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
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.MessageUtils;
import com.handpay.ibenefit.framework.web.PageController;

@Controller
@RequestMapping("/productCategory")
public class ProductCategoryController extends PageController<ProductCategory>{

    private static final String BASE_DIR = "product/";

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;
    
	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

    @Override
    public Manager<ProductCategory> getEntityManager() {
        return productCategoryManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @Override
    @RequestMapping(value = "/page")
    public String page(HttpServletRequest request, ProductCategory t, Integer backPage) throws Exception {
    	PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductCategory.class);
    	if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
    	request.getSession().removeAttribute("firstProductCategory");
    	request.getSession().removeAttribute("secondProductCategory");
    	productCategoryManager.updateSecondCategoryCount();
    	page.getFilters().add(new PropertyFilter("ProductCategory", "EQI_layer", "1"));
		String result = handlePage(request, page);
		afterPage(request, page, backPage);
		return result;
    }

	@RequestMapping(value = "/secondpage")
    public String secondPage(HttpServletRequest request, ProductCategory t, Integer backPage) throws Exception {
		String firstId = request.getParameter("search_EQS_firstId");
		PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductCategory.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
		if(StringUtils.isNotBlank(firstId)){
			ProductCategory first = productCategoryManager.getProductCategoryByFirstId(firstId);
			if(first!=null){
				request.getSession().setAttribute("firstProductCategory", first);
			}
		}else{
			ProductCategory first = (ProductCategory)request.getSession().getAttribute("firstProductCategory");
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQS_firstId",first.getFirstId()));
		}
		request.getSession().removeAttribute("secondProductCategory");
    	productCategoryManager.updateThirdCategoryCount();
    	page.getFilters().add(new PropertyFilter("ProductCategory", "EQI_layer", "2"));
    	handlePage(request, page);
		afterPage(request, page, backPage);
		return getFileBasePath() + "listProductSecondCategory";
    }

	@RequestMapping(value = "/thirdpage")
    public String thirdPage(HttpServletRequest request, ProductCategory t, Integer backPage) throws Exception {
		String secondId = request.getParameter("search_EQS_secondId");
		PageSearch page  = PageUtils.preparePageWithoutSort(request,ProductCategory.class);
		if(null==page.getSortProperty()){
			page.setSortProperty("sortNo");
			page.setSortOrder("asc");
	    }
		if(secondId!=null){
			ProductCategory second = productCategoryManager.getProductCategoryBySecondId(secondId);
			if(second!=null){
				request.getSession().setAttribute("secondProductCategory", second);
			}
		}else{
			ProductCategory second = (ProductCategory)request.getSession().getAttribute("secondProductCategory");
			page.getFilters().add(new PropertyFilter(getEntityName(),"EQS_secondId",second.getSecondId()));
		}
    	page.getFilters().add(new PropertyFilter("ProductCategory", "EQI_layer", "3"));
    	handlePage(request, page);
		afterPage(request, page, backPage);
		return getFileBasePath() + "listProductThirdCategory";
    }

	@RequestMapping(value = "/createSecondCategory")
	public String createSecondCategory(HttpServletRequest request, HttpServletResponse response, ProductCategory t)throws Exception {
		request.setAttribute("canInvalid", true);
		return getFileBasePath() + "editProductSecondCategory";
	}

	@RequestMapping(value = "/editSecondCategory/{secondId}")
	public String editSecondCategory(HttpServletRequest request, HttpServletResponse response, @PathVariable String secondId)
			throws Exception {
		if (StringUtils.isNotBlank(secondId)) {
			ProductCategory entity = productCategoryManager.getProductCategoryBySecondId(secondId);
			request.setAttribute("entity", entity);
			request.setAttribute("canInvalid", productCategoryManager.canInvalid(entity.getObjectId()));
		}
		 return getFileBasePath() + "editProductSecondCategory";
	}

	@RequestMapping(value = "/createThirdCategory")
	public String createThirdCategory(HttpServletRequest request, HttpServletResponse response, ProductCategory t) throws Exception {
		request.setAttribute("canInvalid", true);
		return getFileBasePath() + "editProductThirdCategory";
	}

	@RequestMapping(value = "/editThirdCategory/{thirdId}")
	public String editThirdCategory(HttpServletRequest request, HttpServletResponse response, @PathVariable String thirdId)
			throws Exception {
		if (StringUtils.isNotBlank(thirdId)) {
			ProductCategory entity = productCategoryManager.getProductCategoryByThirdId(thirdId);
			request.setAttribute("entity", entity);
			request.setAttribute("canInvalid", productCategoryManager.canInvalid(entity.getObjectId()));
		}
		 return getFileBasePath() + "editProductThirdCategory";
	}

	@RequestMapping(value = "/secondCategory/{firstId}")
    public String secondCategory(HttpServletRequest request, HttpServletResponse response,@PathVariable String firstId,ModelMap map) throws Exception {
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("firstId", firstId);
	    List<ProductCategory> secondCategory = productCategoryManager.getSecondCategoryByParam(param);
	    map.put("secondCategory", secondCategory);
	    return "jsonView";
    }

	@RequestMapping(value = "/thirdCategory/{secondId}")
    public String thirdCategory(HttpServletRequest request, HttpServletResponse response,@PathVariable String secondId,ModelMap map) throws Exception {
        Map<String,Object> param = new HashMap<String,Object>();
        param.put("secondId", secondId);
        List<ProductCategory> thirdCategory = productCategoryManager.getThirdCategoryByParam(param);
        map.put("thirdCategory", thirdCategory);
        return "jsonView";
    }

	@Override
    @RequestMapping(value = "/save")
	public String save(HttpServletRequest request, ModelMap modelMap, @Valid ProductCategory t, BindingResult result)
			throws Exception {
		ProductCategory first = (ProductCategory)request.getSession().getAttribute("firstProductCategory");
		ProductCategory second = (ProductCategory)request.getSession().getAttribute("secondProductCategory");
		String layer = request.getParameter("layer");
		if (layer!=null) {
			if(t.getObjectId()==null){
				String no = null;
				if(layer.equals("1")){
					no = sequenceManager.getNextNo("SEQ_FIRST_ID", "", 4);
					t.setFirstId(no);
				}else if(layer.equals("2")){
					no = sequenceManager.getNextNo("SEQ_SECOND_ID", "", 4);
					t.setSecondId(no);
					t.setFirstId(first.getFirstId());
				}else if(layer.equals("3")){
					no = sequenceManager.getNextNo("SEQ_THIRD_ID", "", 4);
					t.setThirdId(no);
					t.setFirstId(second.getFirstId());
					t.setSecondId(second.getSecondId());
				}
			}
			getManager().save(t);
			if(layer.equals("1")){
				return "redirect:page" + getMessage("common.base.success", request);
			}else if(layer.equals("2")){
				return "redirect:secondpage" + getMessage("common.base.success", request);
			}else if(layer.equals("3")){
				return "redirect:thirdpage" + getMessage("common.base.success", request);
			}
		}
		return null;
	}

	@Override
    protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
			throws Exception {
		String message = null;
		if(objectId!=null && productCategoryManager.canDelete(objectId)){
			delete(objectId);
			message = "删除成功";
		} else {
			message = "不能删除";
		}
		String action = request.getParameter("action");
		return "redirect:" + action + "?message=" + MessageUtils.urlEncodeWithUtf8(message) + "&" + appendAjaxParameter(request);
	}

	@RequestMapping(value = "/productCategoryTemplate")
	public String productCategoryTemplate(HttpServletRequest request, ProductCategory t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter(ProductCategory.class.getName(),"EQI_status",IBSConstants.STATUS_YES+""));
		PageSearch result = productCategoryManager.findAllThirdCategory(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        request.setAttribute("action", "page");
        request.setAttribute("inputName", request.getParameter("inputName"));
        afterPage(request, page,backPage);
		return "product/" + "listProductCategoryTemplate";
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
				if(objectId!=null && productCategoryManager.canInvalid(objectId)){
					productCategoryManager.updateStatus(objectId, IBSConstants.INVALID);
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
			productCategoryManager.updateSortNoByObjectId(ids, sortNos);
			result = true;
		}
		return String.valueOf(result);
	}

	@Override
    protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId) throws Exception {
		if(objectId!=null){
			request.setAttribute("canInvalid", productCategoryManager.canInvalid(objectId));
		}else{
			request.setAttribute("canInvalid", true);
		}
		return super.handleEdit(request, response, objectId);
	}
}
