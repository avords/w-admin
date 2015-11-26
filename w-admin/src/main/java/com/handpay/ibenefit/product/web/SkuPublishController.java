package com.handpay.ibenefit.product.web;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.entity.SkuPublish;
import com.handpay.ibenefit.product.service.ISkuPublishManager;

@Controller
@RequestMapping("/skuPublish")
public class SkuPublishController extends PageController<SkuPublish>{

    @Reference(version="1.0")
    private ISkuPublishManager skuPublishManager;

    @Override
    public Manager<SkuPublish> getEntityManager() {
        return skuPublishManager;
    }
    @Override
    public String getFileBasePath() {
        return "product/";
    }
}
