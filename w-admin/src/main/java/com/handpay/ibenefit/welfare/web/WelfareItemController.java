/**
 *
 */
package com.handpay.ibenefit.welfare.web;

import java.awt.image.BufferedImage;
import java.io.File;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.validation.Valid;

import org.apache.commons.io.FileUtils;
import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.validation.BindingResult;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.handpay.ibenefit.IBSConstants;
import com.handpay.ibenefit.base.file.service.IFileManager;
import com.handpay.ibenefit.framework.config.GlobalConfig;
import com.handpay.ibenefit.framework.service.ISequenceManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.AjaxUtils;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.ImageUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.product.service.IProductManager;
import com.handpay.ibenefit.welfare.entity.WelfareItem;
import com.handpay.ibenefit.welfare.service.IWelfareItemManager;
import com.handpay.ibenefit.welfare.service.IWelfareManager;

/**
 * @author liran
 *
 */
@Controller
@RequestMapping("/welfare")
public class WelfareItemController extends PageController<WelfareItem>{

	private static final String BASE_DIR = "welfare/";

	@Reference(version = "1.0")
	private IWelfareManager welfareManager;

	@Reference(version="1.0")
    private IFileManager fileManager;

	@Reference(version="1.0")
    private IProductManager productManager;

	@Reference(version = "1.0")
	private ISequenceManager sequenceManager;

	@Reference(version = "1.0")
    private IWelfareItemManager welfareItemManager;

	 protected static final String TMP_DIR = GlobalConfig.getTempDir();


	@Override
    public String getFileBasePath() {
		return BASE_DIR;
	}

	@Override
	public Manager<WelfareItem> getEntityManager() {
		return welfareManager;
	}

	/**
	 * 重写page方法，只显示福利项目大类列表页面
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/page")
	public String page(HttpServletRequest request, WelfareItem t, Integer backPage) throws Exception {
		PageSearch page  = preparePage(request);
		String objectId = request.getParameter("search_EQL_objectId");
		welfareManager.updateSubItemNum();
		page.getFilters().add(new PropertyFilter("WelfareItem","EQI_itemGrade","1"));
		String result = handlePage(request, page);
		request.setAttribute("tempType", objectId);
		afterPage(request, page,backPage);
		return result;
	}

	/**
	 * 根据项目大类主键Id显示项目分类列表页面
	 * @param request
	 * @param t
	 * @param backPage
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/subItemPage/{parentItemId}")
	public String subItemPage(HttpServletRequest request, WelfareItem welfareItem, Integer backPage,@PathVariable String parentItemId ) throws Exception {
		Map<String , Object> param = new HashMap<String, Object>();
		param.put("parentItemId", parentItemId);
		WelfareItem  bigItem = welfareManager.getByObjectId(Long.parseLong(parentItemId));
		Integer parentStatus = bigItem.getStatus();
		request.setAttribute("bigItem", bigItem );
		List<WelfareItem>   items = welfareManager.getItemByParam(param);
		request.setAttribute("subitems", items);
		PageSearch page  = preparePage(request);
		page.getFilters().add(new PropertyFilter("WelfareItem","EQL_parentItemId",parentItemId));
		page.getFilters().add(new PropertyFilter("WelfareItem","EQI_itemGrade","2"));
		handlePage(request, page);
		afterPage(request, page,backPage);
		request.setAttribute("parentStatus", parentStatus);
		request.setAttribute("parentItemId", parentItemId);
		return getFileBasePath()+"listWelfareSubItem";
	}

	/**
	 * Go into the create page
	 *
	 * @param request
	 * @param response
	 * @param WelfareItem
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/createSubItem/{parentItemId}")
	public String createSubItem(HttpServletRequest request, HttpServletResponse response, WelfareItem t,@PathVariable Long parentItemId) throws Exception {
		request.setAttribute("parentItemId", parentItemId);
		Integer itemType = Integer.parseInt(request.getParameter("itemType"));
		request.setAttribute("itemType", itemType);
		return getFileBasePath()+"createWelfareSubItem";
	}

	/**
	 * Go into the editWelfareSubItem page
	 *
	 * @param request
	 * @param response
	 * @param id
	 *            primary key
	 * @return
	 * @throws Exception
	 */
	@RequestMapping(value = "/editSubItem/{parentItemId}/{objectId}")
	public String editSubItem(HttpServletRequest request, HttpServletResponse response, @PathVariable Long parentItemId,@PathVariable  Long objectId)
			throws Exception {
		if (null != objectId) {
			Object entity = getManager().getByObjectId(objectId);
			request.setAttribute("entity", entity);
		}
		request.setAttribute("parentItemId", parentItemId);
		Integer itemType = Integer.parseInt(request.getParameter("itemType"));
		request.setAttribute("itemType", itemType);
		return getFileBasePath()+"editWelfareSubItem";
	}

	/**
	 * 重写save方法，自动生成套餐类型编号保存,and return to query page
	 *
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/saveToPage")
	public String saveToPage(HttpServletRequest request, ModelMap modelMap,WelfareItem t) throws Exception {
		if(t.getItemNo()==null || ("").equals(t.getItemNo())){
			String no="";
			if(request.getParameter("parentItemId")!=null &&! ("").equals(request.getParameter("parentItemId"))){
				t.setParentItemId(Long.parseLong(request.getParameter("parentItemId")));
			}
			if(request.getParameter("itemGrade").equals("1")){
				 no = sequenceManager.getNextNo("MT_SEQUENCE","", 4);
			}else if(request.getParameter("itemGrade").equals("2")){
				 String parentItemNo = welfareManager.getByObjectId(t.getParentItemId()).getItemNo();
				 no = sequenceManager.getNextNo("ST_SEQUENCE",parentItemNo+"-", 2);
			}
			t.setItemNo(no);
		}
		t.setItemGrade(Integer.parseInt(request.getParameter("itemGrade")));
		t.setItemType(Integer.parseInt(request.getParameter("itemType")));
		if(request.getParameter("itemGrade").equals("2")){
			t = getManager().save(t);
			return "redirect:subItemPage/" + t.getParentItemId()+ getMessage("common.base.success", request);
		}else{

			/*
			Long objectId = t.getObjectId();
			WelfareItem  welfareItem = new WelfareItem();
			welfareItem.setParentItemId(objectId);
			welfareItem.setStatus(1);
			List<WelfareItem> welfareItems = welfareManager.getBySample(welfareItem);
			if(welfareItems.size() >0){
				return page(request, welfareItem, PageUtils.IS_NOT_BACK);
			}
			else{
			*/
				return handleSaveToPage(request, modelMap, t);
			//}
		}

	}


	/**
	 * 重写save方法，自动生成套餐类型编号保存
	 *
	 * @param request
	 * @param modelMap
	 * @param t
	 *            Entity
	 * @return
	 * @throws Exception
	 */
	@Override
    @RequestMapping(value = "/save")
	@ResponseBody
	public String save(HttpServletRequest request, ModelMap modelMap, @Valid WelfareItem t, BindingResult result)
			throws Exception {
		if(t.getItemNo()==null || ("").equals(t.getItemNo())){
			String no="";
			if(request.getParameter("parentItemId")!=null &&! ("").equals(request.getParameter("parentItemId"))){
				t.setParentItemId(Long.parseLong(request.getParameter("parentItemId")));
			}
			if(request.getParameter("itemGrade").equals("1")){
				 no = sequenceManager.getNextNo("MT_SEQUENCE","", 4);
			}else if(request.getParameter("itemGrade").equals("2")){
				 String parentItemNo = welfareManager.getByObjectId(t.getParentItemId()).getItemNo();
				 no = sequenceManager.getNextNo("ST_SEQUENCE",parentItemNo+"-", 2);
			}
			t.setItemNo(no);
		}
		t.setItemGrade(Integer.parseInt(request.getParameter("itemGrade")));
		t.setItemType(Integer.parseInt(request.getParameter("itemType")));
			if(request.getParameter("itemGrade").equals("2")){
				WelfareItem itemFormDb = welfareManager.getByObjectId(t.getObjectId());
				if(null != itemFormDb && itemFormDb.getStatus().equals(IBSConstants.EFFECTIVE) && t.getStatus().equals(IBSConstants.INVALID)){
					if(!productManager.cansubitemInvalid(t.getObjectId())){
						String res = "fail";
						Gson g = new Gson();
						return g.toJson(res);
					}
				}
				getManager().save(t);
				String res = "success";
				Gson g = new Gson();
				return g.toJson(res);
			}else{
				return handleSave(request, modelMap, t);
			}
	}

	@RequestMapping("getItems/{itemType}")
	public String getItem( ModelMap modelMap ,@PathVariable String itemType){
		if( itemType!=null){
			Map<String , Object> param = new HashMap<String, Object>();
			param.put("itemType", Integer.parseInt(itemType));
			param.put("itemGrade",1);
			List<WelfareItem>   items = welfareManager.getItemByParam(param);
			modelMap.addAttribute("items", items);
		}
		return "jsonView";
	}

	@RequestMapping("/getSubItems/{itemId}")
    public String getSubItems( ModelMap modelMap ,@PathVariable Long itemId){
        if( itemId!=null){
            Map<String , Object> param = new HashMap<String, Object>();
            param.put("itemGrade",2);
            param.put("parentItemId",itemId);
            List<WelfareItem>   items = welfareManager.getItemByParam(param);
            modelMap.addAttribute("items", items);
        }
        return "jsonView";
    }
	@RequestMapping("/saveCrop")
    public String saveCrop(HttpServletRequest request,HttpServletResponse response,ModelMap map) throws Exception {
        String srcFilePath = request.getParameter("srcFilePath");
        byte[] fileData = fileManager.getFile(srcFilePath);
        String oldPath = TMP_DIR + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
        String newPath = TMP_DIR + "cut" + srcFilePath.substring(srcFilePath.lastIndexOf("/")+1);
        FileUtils.writeByteArrayToFile(new File(oldPath), fileData);
        // 图片在页面上的宽高
        int imageH = Integer.parseInt(request.getParameter("imageH"));
        int imageW = Integer.parseInt(request.getParameter("imageW"));
        // 图片距离编辑窗口的距离
        int imageX = Integer.parseInt(request.getParameter("imageX"));
        int imageY = Integer.parseInt(request.getParameter("imageY"));
        // 图片旋转的角度
//        int angle = Integer.parseInt(request.getParameter("imageRotate"));
//        String imageSource = request.getParameter("imageSource");
        // 图片选择框的座标和高宽
        int selectorH = Integer.parseInt(request.getParameter("selectorH"));
        int selectorW = Integer.parseInt(request.getParameter("selectorW"));
        int selectorX = Integer.parseInt(request.getParameter("selectorX"));
        int selectorY = Integer.parseInt(request.getParameter("selectorY"));
        // 编辑窗口的大小
//        int viewPortH = Integer.parseInt(request.getParameter("viewPortH"));
//        int viewPortW = Integer.parseInt(request.getParameter("viewPortW"));
        // Resize
        ImageUtils.scaleImage(oldPath, newPath, imageW, imageH);
        // BufferedImage image = ImageUtils.readImage(oldpath);
        // ImageUtils.rotateImage(image, (int)angle);
        int x = selectorX - imageX;
        if (x < 0) {
            x = 0;
        }
        int y = selectorY - imageY;
        if (y < 0) {
            y = 0;
        }
        ImageUtils.cutImage(x, y, selectorW, selectorH, newPath, newPath);
        fileData = FileUpDownUtils.getFileContent(new File(newPath));
        String filePath = fileManager.saveProductImage(fileData, srcFilePath.substring(srcFilePath.lastIndexOf("/")+1));
        //删除原上传文件
        fileManager.deleteFile(srcFilePath);
        //情况临时文件
        request.setAttribute("filePath", filePath);
        map.addAttribute("filePath", filePath);
        return "jsonView";
    }


	@RequestMapping("/uploadProduct")
    @ResponseBody
    public String uploadProduct(HttpServletRequest request, HttpServletResponse response) throws Exception {
        Map<String,Object> map = new HashMap<String,Object>();
        UploadFile uploadFile = FileUpDownUtils.getUploadFile(request, "uploadFile");
        byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
        String filePath = fileManager.saveProductImage(fileData, uploadFile.getFileName());
        BufferedImage image = ImageUtils.readImage(uploadFile.getFile().getAbsolutePath());
        map.put("width",image.getWidth()+"");
        map.put("height",image.getHeight()+"");
        map.put("result", "true");
        map.put("filePath", filePath.trim());
        AjaxUtils.doAjaxResponseOfMap(response, map);
	    return null;
    }

	@RequestMapping(value = "/updateToPage")
	public String updateToPage(HttpServletRequest request, ModelMap modelMap, WelfareItem t) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		String[]  sortNoArray = request.getParameter("sortNoArray").split(",");
		if(objectIdArray.length > 0){
			for(int i=0;i<objectIdArray.length;i++){
				t.setObjectId(Long.parseLong(objectIdArray[i].trim()));
				if(sortNoArray[i].length()!=0){
					t.setSortNo(Double.parseDouble(sortNoArray[i].trim()));
				}
				save(t);
			}
		}
		return "redirect:page" + getMessage("common.base.success", request);
	}

	@RequestMapping(value = "/updateSubToPage")
	public String updateSubToPage(HttpServletRequest request, ModelMap modelMap, WelfareItem t) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		String[]  sortNoArray = request.getParameter("sortNoArray").split(",");
		String parentItemId = request.getParameter("parentItemId");
		if(objectIdArray.length > 0){
			for(int i=0;i<objectIdArray.length;i++){
				t.setObjectId(Long.parseLong(objectIdArray[i].trim()));
				if(sortNoArray[i].length()!=0){
					t.setSortNo(Double.parseDouble(sortNoArray[i].trim()));
				}
				save(t);
			}
		}
		return "redirect:subItemPage/"+ parentItemId+ getMessage("common.base.success", request);
	}

	@RequestMapping(value = "/setStatusToPage")
	public String setStatusToPage(HttpServletRequest request, ModelMap modelMap, WelfareItem t) throws Exception {
		String[]  objectIdArray = request.getParameter("objectIdArray").split(",");
		String parentItemId = request.getParameter("parentItemId");
		if(objectIdArray.length > 0){
			for(int i=0;i<objectIdArray.length;i++){
				t.setObjectId(Long.parseLong(objectIdArray[i].trim()));
				t.setStatus(IBSConstants.INVALID);
				save(t);
			}
		}
		return "redirect:subItemPage/"+ parentItemId+ getMessage("common.base.success", request);
	}

	@RequestMapping(value = "/subInvalid")
	@ResponseBody
	public String subInvalid(HttpServletRequest request, String ids,Integer status) throws Exception {
		int result = 0;
		if(StringUtils.isNotBlank(ids)){
			for(String id : ids.split(",")){
				Long objectId = null;
				try{
					objectId = Long.parseLong(id);
				}catch(Exception e){
				}
				if(objectId!=null && productManager.cansubitemInvalid(objectId)){
					welfareManager.updateStatus(objectId, IBSConstants.INVALID);
					result ++;
				}
			}
		}
		return String.valueOf(result);
	}

	@RequestMapping("/itemGoodsSetPage")
    public String itemGoodsSetPage(HttpServletRequest request,HttpServletResponse response){
	    PageSearch page  = preparePage(request);
        PageSearch result = welfareManager.getItemGoodsSet(page);
        page.setList(result.getList());
        page.setTotalCount(result.getTotalCount());
        PageUtils.afterPage(request, page, PageUtils.IS_NOT_BACK);
        return "welfare/itemGoodsSetPage";
    }

	@RequestMapping("/setWelfarePlan")
    public String setWelfarePlan(HttpServletRequest request,HttpServletResponse response){
	    //只有状态为带上架或者已下架的商品才能上架
        String message = "操作成功";
        String skuIdsStr = request.getParameter("itemIds");
        Integer value = Integer.parseInt(request.getParameter("value"));
        if(StringUtils.isNotBlank(skuIdsStr)){
            String[] skuIds = skuIdsStr.split(",");
            for(String id:skuIds){
                Long objectId = Long.parseLong(id);
                WelfareItem welfareItem = new WelfareItem();
                welfareItem.setObjectId(objectId);
                welfareItem.setIsWelfarePlan(value);
                welfareItemManager.save(welfareItem);
            }
        }else{
            message = "操作失败，你没有选择任何项目";
        }
        return "redirect:/welfare/itemGoodsSetPage"+getMessage(message, request);
    }

	@RequestMapping("/setLinePayment")
    public String setLinePayment(HttpServletRequest request,HttpServletResponse response){
	  //只有状态为带上架或者已下架的商品才能上架
        String message = "操作成功";
        String skuIdsStr = request.getParameter("itemIds");
        Integer value = Integer.parseInt(request.getParameter("value"));
        if(StringUtils.isNotBlank(skuIdsStr)){
            String[] skuIds = skuIdsStr.split(",");
            for(String id:skuIds){
                Long objectId = Long.parseLong(id);
                WelfareItem welfareItem = new WelfareItem();
                welfareItem.setObjectId(objectId);
                welfareItem.setIsLinePayment(value);
                welfareItemManager.save(welfareItem);
            }
        }else{
            message = "操作失败，你没有选择任何项目";
        }
        return "redirect:/welfare/itemGoodsSetPage"+getMessage(message, request);
    }
}
