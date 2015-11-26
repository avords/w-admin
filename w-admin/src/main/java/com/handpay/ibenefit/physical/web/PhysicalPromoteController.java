package com.handpay.ibenefit.physical.web;

import java.util.HashMap;
import java.util.Map;

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
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.physical.entity.PhysicalPromote;
import com.handpay.ibenefit.physical.entity.PhysicalPromoteForm;
import com.handpay.ibenefit.physical.service.IPhysicalPromoteManager;

/**    
 *     
 * 项目名称：w-admin    
 * 类名称：PhysicalPromoteController    
 * 类描述：体检套餐升级包管理    
 * 创建人：wangyawei    
 * 创建时间：2015-6-30 上午09:50:00    
 * 修改人：wangyawei    
 * 修改时间：2015-6-30 上午09:50:00    
 * 修改备注：    
 * @version     
 *     
 */
@Controller
@RequestMapping("/physicalPromote")
public class PhysicalPromoteController extends PageController<PhysicalPromote> {
	private static final Logger LOG = Logger.getLogger(PhysicalPromoteController.class);
	private static final String BASE_DIR = "physical/";
		
		@Reference(version = "1.0")
		private IPhysicalPromoteManager physicalPromoteManager;
	
		@Override
		public Manager<PhysicalPromote> getEntityManager() {
			return physicalPromoteManager;
		}
	
		@Override
		public String getFileBasePath() {
			return BASE_DIR;
		}
		
		/**
		 * @param request
		 * @param t
		 * @param backPage 
		 * @return
		 * @throws Exception
		 */
		@Override		
		protected String handlePage(HttpServletRequest request, PageSearch page) {
			PageSearch pSearch=preparePage(request); 
			PageSearch result=physicalPromoteManager.findPhysicalPromotePage(pSearch) ;
			page.setTotalCount(result.getTotalCount());
			page.setList(result.getList());
			afterPage(request, page, PageUtils.IS_NOT_BACK);
			return getFileBasePath() + "listPhysicalPromote";
		}

		/**
		 * 重写SaveToPage方法，保存体检套餐升级包
		 * @param request
		 * @param t
		 * @param backPage 
		 * @return
		 * @throws Exception
		 */
		@Override
		protected String handleSaveToPage(HttpServletRequest request,
				ModelMap modelMap, PhysicalPromote physicalPromote) throws Exception {
		 
			
			if(null ==  physicalPromote.getPhysicalPromoteForm() ) {
				LOG.error("参数为空");
				return "redirect:/physicalPromote/page";
			} 
			
			PhysicalPromoteForm physicalPromoteForm = physicalPromote.getPhysicalPromoteForm();
			
			if( null == physicalPromoteForm.getWelfares()
					|| null == physicalPromoteForm.getAddtionalWelfares()
					|| ( physicalPromoteForm.getUseCompany() == 1 
					      &&  (null == physicalPromoteForm.getCompanys() || physicalPromoteForm.getCompanys().isEmpty()) )) {
				
				LOG.error("参数为空");
				return "redirect:/physicalPromote/page";
			}
			
			physicalPromoteManager.savePhysicalPromote(physicalPromote);
			
			return "redirect:page" + getMessage("common.base.success", request);
		}

		/**
		 * 重写handleDelete方法，删除体检套餐升级包
		 * @param request
		 * @param t
		 * @param backPage 
		 * @return
		 * @throws Exception
		 */
		@Override
		@RequestMapping(value = "/deletephysicalpromote")
		protected String handleDelete(HttpServletRequest request,
				HttpServletResponse response, Long objectId) throws Exception {
			 
			String[] promoteCodeArray = request.getParameter("promoteCodeArray").split(",");
			physicalPromoteManager.deleteBatch(promoteCodeArray);
			 
			return "redirect:page" + getMessage("common.base.success", request);
		}
		
		@RequestMapping(value = "/createPhysicalPromote")
		public String create(HttpServletRequest request) throws Exception {
			
			return getFileBasePath() + "createPhysicalPromote";
		}
		
		/**
		 * 重写edit方法，编辑体检套餐升级包
		 * @param request
		 * @param t
		 * @param backPage 
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/edit/{promoteCode}")
		public String edit(HttpServletRequest request, HttpServletResponse response, @PathVariable Long promoteCode) throws Exception {
			PhysicalPromote physicalpromote =  physicalPromoteManager.findByPromoteCode(promoteCode);
			request.setAttribute("physicalpromote", physicalpromote);
			
			return getFileBasePath() +"editPhysicalPromote";
		}
		
		@RequestMapping(value = "/updatePhysicalPromote")
		public String updatePhysicalPromote(HttpServletRequest request) throws Exception {
			String promoteCode = request.getParameter("promoteCode");
			String oldPrice = request.getParameter("oldPrice");
			String oldPromotePackageId = request.getParameter("oldPromotePackageId");
			
			String newPromotePrice = request.getParameter("promotePrice");
			String newPromotePackageId = request.getParameter("promotePackageId");
			Long promotePackageId = null;
			Double price = null;
			
			if (StringUtils.isBlank(promoteCode)) {
				LOG.error("参数promoteCode为空");
				return "redirect:page" + getMessage("common.base.fail", request);
			}
			
			//新旧 升级套餐不一样, 更新
			if (StringUtils.isNotBlank(newPromotePackageId) && !newPromotePackageId.equals(oldPromotePackageId)) {
				promotePackageId = Long.parseLong(newPromotePackageId);
				LOG.info("新旧 升级套餐不一样, 更新");
			}
			
			//新旧价格不一样 ,更新
			if (StringUtils.isNotBlank(newPromotePrice) && !newPromotePrice.equals(oldPrice)) {
				price = Double.parseDouble(newPromotePrice);
				LOG.info("新旧 升级套餐不一样, 更新");
			}
			
			boolean result = physicalPromoteManager.updatePromotePackage(Long.parseLong(promoteCode),promotePackageId, price);
			
			if ( result) {
			  return "redirect:page" + getMessage("common.base.success", request);
			} else {
			  return "redirect:page" + getMessage("common.base.fail", request);
			}
		}
		
		/**
		 * 体检套餐升级包置无效
		 * @param request
		 * @param t
		 * @param backPage 
		 * @return
		 * @throws Exception
		 */
		@RequestMapping(value = "/updateToPage")
		public String updateToPage(HttpServletRequest request) throws Exception {
			String[]  promoteCodeArray = request.getParameter("promoteCodeArray").split(",");
			String status = request.getParameter("status");
			Map<String, Object> param = new HashMap<String, Object>();
			
			if (StringUtils.isBlank(status) 
					|| (!status.equals(IBSConstants.EFFECTIVE + "") 
							&& !status.equals(IBSConstants.INVALID + "") )) {
				status = IBSConstants.EFFECTIVE + "";//有效
			}
			
				for (int i = 0; i < promoteCodeArray.length; i++) {
					if(promoteCodeArray[i]!=null && ! ("").equals(promoteCodeArray[i])){
						param.put("promoteCode", promoteCodeArray[i]);
						param.put("status", status);
					}
						physicalPromoteManager.updateColumn(param);				
				}
				return "redirect:page"  + getMessage("common.base.success", request);
			
		}
}
