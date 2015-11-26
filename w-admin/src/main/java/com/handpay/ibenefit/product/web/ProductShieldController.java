package com.handpay.ibenefit.product.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.category.entity.ProductCategory;
import com.handpay.ibenefit.category.service.IProductCategoryManager;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ISupplierManager;
import com.handpay.ibenefit.product.entity.Brand;
import com.handpay.ibenefit.product.entity.Product;
import com.handpay.ibenefit.product.entity.ProductShield;
import com.handpay.ibenefit.product.entity.ProductShieldForm;
import com.handpay.ibenefit.product.service.IBrandManager;
import com.handpay.ibenefit.product.service.ICompanyGoodsManager;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.product.service.IProductShieldManager;
import com.handpay.ibenefit.product.service.ISkuManager;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.service.IWelfarePackageManager;

@Controller
@RequestMapping("/productShield")
public class ProductShieldController extends PageController<ProductShield> {
    private static final String BASE_DIR = "product/";

    @Reference(version = "1.0")
    private IProductShieldManager productShieldManager;

    @Reference(version = "1.0")
    private ISupplierManager supplierManager;

    @Reference(version = "1.0")
    private IBrandManager brandManager;

    @Reference(version = "1.0")
    private IProductCategoryManager productCategoryManager;

    @Reference(version = "1.0")
    private ISkuManager skuManager;

    @Reference(version = "1.0")
    private ICompanyManager companyManager;

    @Reference(version = "1.0")
    private IDictionaryManager dictionaryManager;

    @Reference(version = "1.0")
    private IProductManager productManager;

    @Reference(version = "1.0")
    private IWelfarePackageManager welfarePackageManager;


    @Reference(version = "1.0")
    private ICompanyGoodsManager companyGoodsManager;

    @Override
    public Manager<ProductShield> getEntityManager() {
        return productShieldManager;
    }

    @Override
    public String getFileBasePath() {
        return BASE_DIR;
    }

    @Override
    public String handlePage(HttpServletRequest request, PageSearch page) {
        List<ProductCategory> firstCategory = productCategoryManager.getAllFirstCategory();
        request.setAttribute("firstCategory", firstCategory);
        PageSearch result = productShieldManager.getShieldInfo(page);
        page.setTotalCount(result.getTotalCount());
        page.setList(result.getList());
        request.setAttribute("action", "page");
        return getFileBasePath() + "list" + getActualArgumentType().getSimpleName();
    }

    @Override
    protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception {
        if (null != objectId) {
            // Object entity = getManager().getByObjectId(objectId);
            Company company = companyManager.getByObjectId(objectId);
            request.setAttribute("company", company);
            // 取供应商品
            ProductShield ps1 = new ProductShield();
            ps1.setCompanyId(objectId);
            ps1.setType(IBSConstants.SUPPLIER);
            List<ProductShield> pss1 = productShieldManager.getBySample(ps1);
            List<Supplier> suppliers = new ArrayList<Supplier>();
            for (ProductShield p : pss1) {
                Supplier s = supplierManager.getByObjectId(p.getItemId());
                suppliers.add(s);
            }
            request.setAttribute("suppliers", suppliers);
            // 品牌
            ProductShield ps2 = new ProductShield();
            ps2.setCompanyId(objectId);
            ps2.setType(IBSConstants.BRAND);
            List<ProductShield> pss2 = productShieldManager.getBySample(ps2);
            List<Brand> brands = new ArrayList<Brand>();
            for (ProductShield p : pss2) {
                Brand s = brandManager.getByObjectId(p.getItemId());
                brands.add(s);
            }
            request.setAttribute("brands", brands);
            // 分类
            ProductShield ps3 = new ProductShield();
            ps3.setCompanyId(objectId);
            ps3.setType(IBSConstants.PRODUCT_CATEGORY);
            List<ProductShield> pss3 = productShieldManager.getBySample(ps3);
            List<ProductCategory> productCategories = new ArrayList<ProductCategory>();
            for (ProductShield p : pss3) {
                ProductCategory s = productCategoryManager.getByObjectId(p.getItemId());
                s = productCategoryManager.getThirdCategoryByThirdId(s.getThirdId());
                s.setName(s.getFirstName()+"-"+s.getSecondName()+"-"+s.getName());
                productCategories.add(s);
            }
            request.setAttribute("productCategories", productCategories);
            // 生活服务
            ProductShield ps4 = new ProductShield();
            ps4.setCompanyId(objectId);
            ps4.setType(IBSConstants.LIFE_SERVICE);
            List<ProductShield> lifeServies = productShieldManager.getBySample(ps4);
            request.setAttribute("lifeServies", lifeServies);
            // 商品
            ProductShield ps5 = new ProductShield();
            ps5.setCompanyId(objectId);
            ps5.setType(IBSConstants.PRODUCT);
            List<ProductShield> pss5 = productShieldManager.getBySample(ps5);
            List<Product> products = new ArrayList<Product>();
            for (ProductShield p : pss5) {
                Product s = productManager.getByObjectId(p.getItemId());
                s.setCategory(productCategoryManager.getThirdCategoryByObjectId(s.getCategoryId()));
                Supplier sup = supplierManager.getByObjectId(s.getSupplierId());
                if(sup!=null){
                    s.setSupplierName(sup.getSupplierName());
                }
                products.add(s);
            }
            request.setAttribute("products", products);
            // 福利套餐
            ProductShield ps6 = new ProductShield();
            ps6.setCompanyId(objectId);
            ps6.setType(IBSConstants.WELFARE_PACKAGE);
            List<ProductShield> pss6 = productShieldManager.getBySample(ps6);
            List<WelfarePackage> welfarePackages = new ArrayList<WelfarePackage>();
            for (ProductShield p : pss6) {
                WelfarePackage s = welfarePackageManager.getByObjectId(p.getItemId());
                welfarePackages.add(s);
            }
            request.setAttribute("welfarePackages", welfarePackages);
            // 体检套餐
            // ProductShield ps7 = new ProductShield();
            // ps7.setCompanyId(objectId);
            // ps7.setType(IBSConstants.PHYSICAL_PACKAGE);
            // List<ProductShield> pss7 = productShieldManager.getBySample(ps7);
            // List<PhysicalPackage> physicalPackages = new
            // ArrayList<PhysicalPackage>();
            // for(ProductShield p:pss7){
            // PhysicalPackage s=
            // physicalPackageManager.getByObjectId(p.getItemId());
            // physicalPackages.add(s);
            // }
            // request.setAttribute("physicalPackages", physicalPackages);
        }
        return super.handleEdit(request, response, objectId);
    }

    @Override
    public String handleSave(HttpServletRequest request, ModelMap modelMap, ProductShield t) throws Exception {
        ProductShieldForm t1 = t.getProductShieldForm();
        ProductShield p = new ProductShield();
        p.setCompanyId(t.getProductShieldForm().getCompanyId());
        productShieldManager.deleteBySample(p);
        Long companyId = t.getProductShieldForm().getCompanyId();
        if (null != t1) {
            // 保存屏蔽供应商信息
            if (t1.getSuppliers() != null) {
                for (Supplier supplier : t1.getSuppliers()) {
                	if(supplier.getObjectId()!=null){
                		 ProductShield tempSupplier = new ProductShield();
                         tempSupplier.setCompanyId(companyId);
                         tempSupplier.setType(IBSConstants.SUPPLIER);
                         tempSupplier.setItemId(supplier.getObjectId());
                         productShieldManager.deleteBySample(tempSupplier);
                         productShieldManager.save(tempSupplier);
                	}
                }
            }
            // 保存屏蔽品牌信息
            if (t1.getBrands() != null) {
                for (Brand brand : t1.getBrands()) {
                	if(brand.getObjectId()!=null){
                		 ProductShield tempBrand = new ProductShield();
                         tempBrand.setCompanyId(companyId);
                         tempBrand.setType(IBSConstants.BRAND);
                         tempBrand.setItemId(brand.getObjectId());
                         productShieldManager.deleteBySample(tempBrand);
                         productShieldManager.save(tempBrand);
                	}
                }
            }
            // 保存屏蔽商品分类信息
            if (t1.getProductCategories() != null) {
                for (ProductCategory productCategory : t1.getProductCategories()) {
                	if(productCategory.getObjectId()!=null){
                		 ProductShield tempProductCategory = new ProductShield();
                         tempProductCategory.setCompanyId(companyId);
                         tempProductCategory.setType(IBSConstants.PRODUCT_CATEGORY);
                         tempProductCategory.setItemId(productCategory.getObjectId());
                         productShieldManager.deleteBySample(tempProductCategory);
                         productShieldManager.save(tempProductCategory);
                	}
                }
            }
            // 保存屏蔽生活服务信息
            if (t1.getLifeServies() != null) {
                for (String lifeService : t1.getLifeServies()) {
                    ProductShield tempLifeService = new ProductShield();
                    tempLifeService.setCompanyId(companyId);
                    tempLifeService.setType(IBSConstants.LIFE_SERVICE);
                    tempLifeService.setItemId(Long.parseLong(lifeService));
                    productShieldManager.deleteBySample(tempLifeService);
                    productShieldManager.save(tempLifeService);
                }
            }
            // 保存屏蔽商品信息
            if (t1.getProducts() != null) {
                for (Product product : t1.getProducts()) {
                	if(product.getObjectId()!=null){
                		ProductShield tempProduct = new ProductShield();
                        tempProduct.setCompanyId(companyId);
                        tempProduct.setType(IBSConstants.PRODUCT);
                        tempProduct.setItemId(product.getObjectId());
                        productShieldManager.deleteBySample(tempProduct);
                        productShieldManager.save(tempProduct);
                	}
                }
            }
            // 保存屏蔽福利套餐
            if (t1.getWelfarePackages() != null) {
                for (WelfarePackage wp : t1.getWelfarePackages()) {
                	if(wp.getObjectId()!=null){
                		 ProductShield tempProduct = new ProductShield();
                         tempProduct.setCompanyId(companyId);
                         tempProduct.setType(IBSConstants.WELFARE_PACKAGE);
                         tempProduct.setItemId(wp.getObjectId());
                         productShieldManager.deleteBySample(tempProduct);
                         productShieldManager.save(tempProduct);
                	}
                }
            }
            //更新权限商品权限数据
            companyGoodsManager.updateByCompanyId(companyId);
        }
        return "redirect:page" + getMessage("common.base.success", request);
    }

    @Override
    protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId)
            throws Exception {
        ProductShield t = new ProductShield();
        t.setCompanyId(objectId);
        productShieldManager.deleteBySample(t);
        //更新权限商品权限数据
        companyGoodsManager.updateByCompanyId(objectId);
        return "redirect:/productShield/page" + getMessage("common.base.success", request);
    }

}
