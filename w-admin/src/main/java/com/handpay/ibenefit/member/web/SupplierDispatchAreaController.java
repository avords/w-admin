package com.handpay.ibenefit.member.web;

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
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Supplier;
import com.handpay.ibenefit.member.entity.SupplierDispatchArea;
import com.handpay.ibenefit.member.service.ISupplierDispatchAreaManager;
import com.handpay.ibenefit.member.service.ISupplierManager;

@Controller
@RequestMapping("/supplierDispatchArea")
public class SupplierDispatchAreaController extends PageController<SupplierDispatchArea>{
	private static final String BASE_DIR = "member/";

	Logger logger = Logger.getLogger(SupplierDispatchAreaController.class);
	
	@Reference(version = "1.0")
	private ISupplierDispatchAreaManager supplierDispatchAreaManager;
	
	@Reference(version = "1.0")
	private ISupplierManager supplierManager;

	@Reference(version = "1.0")
	private IAreaManager areaManager;

	@Override
	public Manager<SupplierDispatchArea> getEntityManager() {
		return supplierDispatchAreaManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			SupplierDispatchArea t) throws Exception {
		//供应商ID
		String supplierId=request.getParameter("supplierIDD");
		//areaId
		String areaId=request.getParameter("areaId2");
		if (StringUtils.isBlank(supplierId)) {
			logger.error("supplierId can not null");
		}else {
			t.setSupplierId(Long.parseLong(supplierId));
			if (StringUtils.isNotBlank(areaId)) {
				//判断配送区域是否存在
				SupplierDispatchArea sda=new SupplierDispatchArea();
				sda.setSupplierId(Long.parseLong(supplierId));
				sda.setAreaId(areaId);
				sda.setDistributionTime(t.getDistributionTime());
				sda.setDistributionPrice(t.getDistributionPrice());
				List<SupplierDispatchArea> sdas=supplierDispatchAreaManager.getBySample(sda);
				if (sdas.size()!=0) {
					modelMap.addAttribute("areaError", true);
				}else {
					t.setAreaId(areaId);
					Area area=areaManager.getByObjectId(Long.parseLong(areaId));
					if (areaId.equals("-1")) {//全国
						t.setProvName("全国");
						t.setCityName("全国");
						t.setAreaName("全国");
					}else if (area.getParentId()==-1 && area.getDeepLevel()==1) {//省
						t.setProvName(area.getName());
					}else if (area.getDeepLevel()==2) {//市
						Area province=areaManager.getByObjectId(area.getParentId());
						t.setProvName(province.getName());
						t.setCityName(area.getName());
					}else {//区
						Area cityaArea =areaManager.getByObjectId(area.getParentId());
						if(cityaArea.getParentId()!=null){
							Area proaArea=areaManager.getByObjectId(cityaArea.getParentId());
							t.setProvName(proaArea.getName());
							t.setCityName(cityaArea.getName());
							t.setAreaName(areaManager.getAreaFullNameById(Long.parseLong(areaId)));
						}
					}
					t.setIsPublished(IBSConstants.STATUS_NO);
					t=getEntityManager().save(t);
					//配送区域
					modelMap.addAttribute("sArea", t);
				}
			}
		}
		return "jsonView";
	}

	@RequestMapping("/deleteArea/{objectId}")
	protected String deleteArea(HttpServletRequest request,
			HttpServletResponse response,@PathVariable Long objectId,ModelMap modelMap) throws Exception {
		getEntityManager().delete(objectId);
		modelMap.addAttribute("result", true);
		return "jsonView";
	}
	
	@RequestMapping("/saveAreas")
	protected String saveAreas(HttpServletRequest request,
			HttpServletResponse response,ModelMap modelMap) throws Exception {
		String supplierId=request.getParameter("supplierIDD");
		if (StringUtils.isNotBlank(supplierId)) {
			Long id=Long.parseLong(supplierId);
			SupplierDispatchArea sb=new SupplierDispatchArea();
			sb.setSupplierId(id);
			List<SupplierDispatchArea> sBrands=supplierDispatchAreaManager.getBySample(sb);
			if (sBrands.size()==0) {
				modelMap.addAttribute("noAreas",true);
			}else {
				for(SupplierDispatchArea sBrand:sBrands){
					//改临时变正式
					if (sBrand.getIsPublished()==IBSConstants.STATUS_NO) {
						sBrand.setIsPublished(IBSConstants.STATUS_YES);
						supplierDispatchAreaManager.save(sBrand);
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
}
