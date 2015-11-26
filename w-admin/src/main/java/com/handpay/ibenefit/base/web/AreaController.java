package com.handpay.ibenefit.base.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang3.StringUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.web.PageController;

@Controller
@RequestMapping("area")
public class AreaController extends PageController<Area> {

	@Reference(version="1.0")
	private IAreaManager areaManager;

	@RequestMapping("general")
	public String general(HttpServletRequest request){
		List<Area> allTopics2=areaManager.getAll();
		request.setAttribute("allTopics2",allTopics2 );
		return getFileBasePath()+"general";
	}


	/**
	 * 获取省份的子节点
	 * @author zhliu
	 * @date 2015年6月9日
	 * @parm
	 * @param request
	 * @param modelMap
	 * @param code
	 * @return
	 */

	@RequestMapping(value="/getChildren/{code}")
	public String getChildren(HttpServletRequest request, ModelMap modelMap,@PathVariable String code){
		List<Area> areas =areaManager.getChildren(Long.valueOf(code));
		modelMap.addAttribute("areas",areas);
		return "jsonView";
	}

	@RequestMapping("treeDelete/{areaId}")
	public String treeDelete(ModelMap modelMap, @PathVariable Long topicId) {
		Area topic = areaManager.getByObjectId(topicId);
		boolean result = false;
		if (topic != null) {
			areaManager.delete(topic.getObjectId());
			result = true;
		}
		modelMap.addAttribute("status", result);
		return "jsonView";
	}

	/**
	 * 获取省份信息
	 * @author zhliu
	 * @date 2015年6月9日
	 * @parm
	 * @param modelMap
	 * @return
	 */
	@RequestMapping("getRoot")
	public String getRoot(ModelMap modelMap) {
		List<Area> areaList=areaManager.getRoot();
		modelMap.addAttribute("allProvince", areaList);
		return "jsonView";
	}


	@RequestMapping("change")
	public String change(HttpServletRequest request, String areaCode) throws Exception {
		request.setAttribute("areaCode",areaCode);
		return getFileBasePath() + "changeArea";
	}

	@RequestMapping("search")
	public String search(HttpServletRequest request, String areaCode) throws Exception {
		request.setAttribute("areaCode",areaCode);
		return getFileBasePath() + "changeArea";
	}

	/**
	 * 选择多个省市
	 * @param request
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("searchMultipleCity")
	public String searchMultipleCity(HttpServletRequest request) throws Exception {
		List<Area> leftCities = areaManager.getAllCity();
		//去掉二级中的市辖区、县
		for(int i = leftCities.size()-1;i>=0;i--) {
			Area area = leftCities.get(i);
			if(area.getName().equals("市辖区") || area.getName().equals("县")){
				leftCities.remove(i);
			}
		}
		List<Area> rightCities = new ArrayList<Area>();
		String selectedId = request.getParameter("selectedIds");
		if(StringUtils.isNotBlank(selectedId)){
			String[] selectedIds = selectedId.split(",");
			for(String id : selectedIds){
				for(Area area : leftCities){
					if(area.getAreaCode().equals(id)){
						rightCities.add(area);
					}
				}
			}
		}
		//填充省份
		if(rightCities.size()>0){
			outer: for(Area temp : leftCities){
				if(temp.getDeepLevel()==1){
					for(Area area : rightCities){
						if(area.getDeepLevel()==2 && temp.getObjectId().equals(area.getParentId())){
							rightCities.add(temp);
							continue outer;
						}
					}
				}
			}
		}
		request.setAttribute("leftCities", leftCities);
		request.setAttribute("rightCities", rightCities);
		return getFileBasePath() + "searchMultipleCity";
	}

	   @RequestMapping("searchMultipleGivenCity")
	    public String searchMultipleGivenCity(HttpServletRequest request) throws Exception {
	        List<Area> leftCities = new ArrayList<Area>();
	        String givenId = request.getParameter("givenIds");
	        if(StringUtils.isNotBlank(givenId)){
	            String[] givenIds = givenId.split(",");
	            for(String id : givenIds){
	                Area area = areaManager.getByObjectId(Long.parseLong(id));
	                if(area!=null){
	                    leftCities.add(area);
	                }
	            }
	        }
	        List<Area> rightCities = new ArrayList<Area>();
	        String selectedId = request.getParameter("selectedIds");
	        if(StringUtils.isNotBlank(selectedId)){
	            String[] selectedIds = selectedId.split(",");
	            for(String id : selectedIds){
	                for(Area area : leftCities){
	                    if(area.getAreaCode().equals(id)){
	                        rightCities.add(area);
	                    }
	                }
	            }
	        }
	        //填充省份
	        for(int i=0;i<leftCities.size();i++){
	            Area area = leftCities.get(i);
	            if(area.getDeepLevel()==2){
	                Area temp = areaManager.getByObjectId(area.getParentId());
	                if(temp!=null && !leftCities.contains(temp)){
	                    leftCities.add(temp);
	                }
	            }
	        }

	        for(int i=0;i<rightCities.size();i++){
	            Area area = rightCities.get(i);
	            if(area.getDeepLevel()==2){
	                Area temp = areaManager.getByObjectId(area.getParentId());
	                if(temp!=null){
	                    rightCities.add(temp);
	                }
	            }
	        }

	      //去掉二级中的市辖区、县
	        for(int i = leftCities.size()-1;i>=0;i--) {
	            Area area = leftCities.get(i);
	            if(area.getName().equals("市辖区") || area.getName().equals("县")){
	                leftCities.remove(i);
	            }
	        }
//	        Area root = new Area();
//	        root.setObjectId(-1L);
//	        root.setName("全国");
//	        leftCities.add(root);
	        request.setAttribute("leftCities", leftCities);
	        request.setAttribute("rightCities", rightCities);
	        return getFileBasePath() + "searchMultipleCity";
	    }

	@RequestMapping("defaultAllCity")
	@ResponseBody
	public String defaultAllCity(HttpServletRequest request) throws Exception {
		List<Area> Cities = areaManager.getAllCity();
		//去掉二级中的市辖区、县
		for(int i = Cities.size()-1;i>=0;i--) {
			Area area = Cities.get(i);
			if(area.getName().equals("市辖区") || area.getName().equals("县")){
				Cities.remove(i);
			}
			if(area.getDeepLevel() == 1 && !"71".equals(area.getAreaCode())){
				Cities.remove(i);
			}
		}
		Gson g = new Gson();
		return g.toJson(Cities);
	}












	@Override
	public Manager<Area> getEntityManager() {
		return areaManager;
	}

	@RequestMapping("/update/{entity}")
	public void update(Area area){
		areaManager.save(area);
	}
	@Override
	public String getFileBasePath() {
		return "base/";
	}
}
