package com.handpay.ibenefit.physical.web;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.ForeverEntity;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.physical.entity.PhysicalItem;
import com.handpay.ibenefit.physical.service.IPhysicalItemManager;

/**
 * 
 * 项目名称：w-admin 类名称：PhysicalItemController 类描述： 创建人：liran 创建时间：2015-5-14
 * 下午2:58:53 修改人：liran 修改时间：2015-5-14 下午2:58:53 修改备注：
 * 
 * @version
 * 
 */
@Controller
@RequestMapping("/physical")
public class PhysicalItemController extends PageController<PhysicalItem> {

	private static final String BASE_DIR = "physical/";

	@Reference(version = "1.0")
	private IPhysicalItemManager physicalItemManager;

	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

	@Override
	public Manager<PhysicalItem> getEntityManager() {
		return physicalItemManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}

	/**
	 * 重写page方法，只显示一级项目列表页面
	 * 
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/page")
	public String page(HttpServletRequest request, PhysicalItem t, Integer backPage) throws Exception {
		PageSearch page = preparePage(request);
		physicalItemManager.updateSubItemNum();
		page.getFilters().add(new PropertyFilter("PhysicalItem", "EQI_itemType", "1"));
		String result = handlePage(request, page);
		afterPage(request, page, backPage);
		return result;
	}

	/**
	 * Save the submit,and return to query page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveToPage")
	public String saveToPage(HttpServletRequest request, ModelMap modelMap, PhysicalItem t) throws Exception {
		if (t.getItemNo() == null || ("").equals(t.getItemNo())) {
			String no = sequenceManager.getNextNo("PHYSICAL_FIRST_ITEM_SQ", "", 4);
			t.setItemNo(no);
		}
		return handleSaveToPage(request, modelMap, t);
	}

	@RequestMapping(value = "/edit/{objectId}")
	public String edit(HttpServletRequest request, HttpServletResponse response, @PathVariable Long objectId) throws Exception {

		if (hasValidSubItem(objectId)) {
			request.setAttribute("hasValidSubItem", true);
		}

		return super.handleEdit(request, response, objectId);
	}

	/**
	 * 编辑二级项目后返回到二级项目page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/saveToSubItemPage")
	public String saveToSubItemPage(HttpServletRequest request, ModelMap modelMap, PhysicalItem t) throws Exception {
		if (request.getParameter("parentItemId") != null && !("").equals(request.getParameter("parentItemId"))) {
			t.setParentItemId(Long.parseLong(request.getParameter("parentItemId")));
		}
		if (t.getFirstItemName() == null || ("").equals(t.getFirstItemName())) {
			PhysicalItem parentItem = physicalItemManager.getByObjectId(Long.parseLong(request.getParameter("parentItemId")));
			t.setFirstItemName(parentItem.getFirstItemName());
		}
		if (t.getItemNo() == null || ("").equals(t.getItemNo())) {
			physicalItemManager.getByObjectId(t.getParentItemId());
			String parentItemNo = physicalItemManager.getByObjectId(t.getParentItemId()).getItemNo();
			PhysicalItem physicalItem = new PhysicalItem();
			physicalItem.setParentItemId(t.getParentItemId());
			physicalItem.setDeleted(0);
			List<PhysicalItem> physicalItems = physicalItemManager.getBySample(physicalItem);
			String no = "";
			if (physicalItems.size() >= 10) {
				no = parentItemNo + "-" + physicalItems.size();
			} else if (physicalItems.size() == 0) {
				no = parentItemNo + "-" + "01";
			} else if (physicalItems.size() > 0 && physicalItems.size() <= 9) {
				no = parentItemNo + "-" + "0" + (physicalItems.size() + 1);
			}
			t.setItemNo(no);
		}
		save(t);
		return "redirect:subItemPage/" + t.getParentItemId() + getMessage("common.base.success", request);
	}

	/**
	 * 重写saveToPage方法，保存排序，并返回到二级项目page
	 * 
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request) throws Exception {
		String itemLevel = request.getParameter("level");
		String parentItemId = request.getParameter("parentItemId");
		String[] objectIdArray = request.getParameter("objectIdArray").split(",");
		String[] sortNoArray = request.getParameter("sortNoArray").split(",");
		Map<String, Object> param = new HashMap<String, Object>();
		if (("1").equals(request.getParameter("invalid"))) {
			// 置为无效
			for (int i = 0; i < objectIdArray.length; i++) {
				if (objectIdArray[i] != null && !("").equals(objectIdArray[i])) {
					param.put("objectId", objectIdArray[i]);
					param.put("status", 2);
				}
				if (itemLevel != null && "1".equals(itemLevel)) {
					if (!hasValidSubItem(Long.valueOf(objectIdArray[i]))) {
						physicalItemManager.updateColumn(param);
					}
				} else {
					physicalItemManager.updateColumn(param);
				}
			}
		} else {
			// 保存排序
			for (int i = 0; i < objectIdArray.length; i++) {
				if (objectIdArray[i] != null && !("").equals(objectIdArray[i])) {
					param.put("objectId", objectIdArray[i]);
					param.put("sortNo", sortNoArray[i]);
				}
				physicalItemManager.updateColumn(param);
			}
		}
		if (parentItemId != null && !("").equals(parentItemId)) {
			return "redirect:subItemPage/" + parentItemId + getMessage("common.base.success", request);
		} else {
			return "redirect:page" + getMessage("common.base.success", request);
		}

	}

	// 判断是否有【有效的】子项目
	public boolean hasValidSubItem(Long itemId) throws Exception {
		PhysicalItem item = new PhysicalItem();
		item.setParentItemId(itemId);
		List<PhysicalItem> list = physicalItemManager.getBySample(item);
		int countValid = 0;
		for (int i = 0; i < list.size(); i++) {
			if (list.get(i).getStatus() == 1) {
				countValid++;
			}
		}
		if (countValid > 0)
			return true;
		return false;
	}

	/**
	 * 根据一级项目主键Id显示二级项目列表页面
	 * 
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/subItemPage/{parentItemId}")
	public String subItemPage(HttpServletRequest request, PhysicalItem t, Integer backPage, @PathVariable String parentItemId) throws Exception {
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter("PhysicalItem", "EQL_parentItemId", parentItemId));
		page.getFilters().add(new PropertyFilter("PhysicalItem", "EQI_itemType", "2"));
		handlePage(request, page);
		afterPage(request, page, backPage);
		request.setAttribute("parentItemId", parentItemId);
		return getFileBasePath() + "listPhysicalSubItem";
	}

	/**
	 * Go into the create page
	 * 
	 * @param request
	 * @param response
	 * @param PhysicalItem
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/createSubItem/{parentItemId}")
	public String createSubItem(HttpServletRequest request, HttpServletResponse response, PhysicalItem t, @PathVariable Long parentItemId) throws Exception {
		request.setAttribute("parentItemId", parentItemId);
		return getFileBasePath() + "editPhysicalSubItem";
	}

	/**
	 * Go into the editPhysicalSubItem page
	 * 
	 * @param request
	 * @param response
	 * @param id
	 *            primary key
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editSubItem/{parentItemId}/{objectId}")
	public String editSubItem(HttpServletRequest request, HttpServletResponse response, @PathVariable Long parentItemId, @PathVariable Long objectId)
			throws Exception {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		request.setAttribute("parentItemId", parentItemId);
		return getFileBasePath() + "editPhysicalSubItem";
	}

	/**
	 * 删除体检套餐
	 */
	@RequestMapping(value = "/delPhy")
	protected String handleDelete(HttpServletRequest request, HttpServletResponse response, Long objectId) {
		String[] objectIdArray = request.getParameter("objectIdArray").split(",");
		PhysicalItem physicalItem = new PhysicalItem();

		if (objectIdArray != null && objectIdArray.length > 0) {
			for (int i = 0; i < objectIdArray.length; i++) {
				if (objectIdArray[i] != null && !("").equals(objectIdArray[i])) {
					// param.put("objectId", objectIdArray[i]);
					// param.put("deleted", ForeverEntity.DELETED_YES);
					physicalItem.setObjectId(Long.valueOf(objectIdArray[i]));
					physicalItem.setDeleted(ForeverEntity.DELETED_YES);
				}
				physicalItemManager.delete(physicalItem);
			}
		}
		String parentItemId = request.getParameter("parentItemId");
		if (parentItemId != null && !("").equals(parentItemId)) {
			if (request.getParameter("subItem") != null && !("").equals(request.getParameter("subItem"))) {
				return "redirect:subItemPage/" + parentItemId + getMessage("common.base.success", request);
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

}
