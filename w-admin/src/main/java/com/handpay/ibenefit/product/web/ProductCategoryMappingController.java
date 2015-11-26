package com.handpay.ibenefit.product.web;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.entity.ProductCategoryMapping;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.category.service.IProductCategoryMappingManager;
import com.handpay.ibenefit.category.service.IProductMallCategoryManager;
import com.handpay.ibenefit.framework.entity.BaseTree;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;

@Controller
@RequestMapping("/productCategoryMapping")
public class ProductCategoryMappingController extends PageController<ProductCategoryMapping>{
    private static final String BASE_DIR = "product/";

    @Reference(version="1.0")
    private IProductCategoryMappingManager productCategoryMappingManager;

    @Reference(version="1.0")
    private IProductMallCategoryManager productMallCategoryManager;

    @Reference(version="1.0")
    private IProductCategoryManager productCategoryManager;

    @Override
    public Manager<ProductCategoryMapping> getEntityManager() {
        return productCategoryMappingManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }


	@RequestMapping(value = "/editCategoryMapping/{mallCategoryId}")
	public String editCategoryMapping(HttpServletRequest request, HttpServletResponse response, @PathVariable Long mallCategoryId)
			throws Exception {
		if (null != mallCategoryId) {
			Object entity = productMallCategoryManager.getByObjectId(mallCategoryId);
			request.setAttribute("entity", entity);
		}
		List<ProductCategory> leftCategories = productCategoryManager.getAll();

		List<ProductCategory> rightCategories = productCategoryManager.getProductCategoriesByMallCategoryId(mallCategoryId);
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
		return getFileBasePath() + "editProductCategoryMapping";
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
								leftNodes.append("{id:" + productCategory3.getThirdId() + ", pId:" + productCategory3.getSecondId() + ", name:'" + productCategory3.getName()+ "'},");
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

	@RequestMapping(value = "/saveMapping")
	public String saveMapping(HttpServletRequest request, HttpServletResponse response,Long mallCategoryId){
	    String cetegoryId = request.getParameter("selelctedIds");
	    productCategoryMappingManager.save(mallCategoryId,cetegoryId);
		return "redirect:editCategoryMapping/" + mallCategoryId;
	}
}
