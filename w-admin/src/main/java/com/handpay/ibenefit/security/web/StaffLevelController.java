package com.handpay.ibenefit.security.web;

import java.util.ArrayList;
import java.util.Collections;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.security.entity.StaffContributeScore;
import com.handpay.ibenefit.security.entity.StaffGradeScore;
import com.handpay.ibenefit.security.entity.StaffYearScore;
import com.handpay.ibenefit.security.entity.SystemParameter;
import com.handpay.ibenefit.security.service.IStaffContributeScoreManager;
import com.handpay.ibenefit.security.service.IStaffGradeScoreManager;
import com.handpay.ibenefit.security.service.IStaffYearScoreManager;
import com.handpay.ibenefit.security.service.ISystemParameterManager;

/**
 * 
 *员工等级设置
 */
@Controller
@RequestMapping("/staffLevel")
public class StaffLevelController {

	private static final Logger LOGGER = Logger.getLogger(StaffLevelController.class);
	private static final String BASE_DIR = "security/";
	
	@Reference(version = "1.0")
	private IStaffGradeScoreManager  staffGradeScoreManager;

	@Reference(version="1.0")
	private IStaffYearScoreManager staffYearScoreManager;
	
	@Reference(version="1.0")
	private IStaffContributeScoreManager staffContributeScoreManager;
	
	@Reference(version="1.0")
	private ISystemParameterManager systemParameterManager;
	
	@RequestMapping("/edit")
	public String edit(ModelMap modelMap){
		List<StaffGradeScore> staffGradeScores =  staffGradeScoreManager.getStaffGrades();
		List<StaffYearScore> staffYearScores = staffYearScoreManager.getStaffYearScores();
		List<StaffContributeScore> staffContributeScores = staffContributeScoreManager.getStaffGrades();
		SystemParameter systemParameter = systemParameterManager.getGradeUpdateCycle();//等级更新周期
		if (null == staffGradeScores) {
			staffGradeScores = Collections.emptyList();
		}
		modelMap.addAttribute("staffGradeScores", staffGradeScores);
		if (null == staffYearScores) {
			staffYearScores = Collections.emptyList();
		}
		modelMap.put("staffYearScores", staffYearScores);
		if (null == staffContributeScores) {
			staffContributeScores = Collections.emptyList();
		}
		modelMap.put("staffContributeScores", staffContributeScores);
		modelMap.put("systemParameter", systemParameter);
		return BASE_DIR + "editStaffLevel";
	}
	
	/**
	 * 等级分值设置
	 * @param request
	 * @param modelMap
	 * @param gradeScore StaffGradeScore
	 * @return
	 */
	@RequestMapping("/saveGradeScore")
	public String handleSaveGradeScore(HttpServletRequest request, ModelMap modelMap, StaffGradeScore gradeScore) {
		String message = "";
		String[] objectIds = request.getParameterValues("objectId1");
		String[] names = request.getParameterValues("name");
		String[] startScores = request.getParameterValues("startScore");
		String[] endScores = request.getParameterValues("endScore");
		String[] values = request.getParameterValues("value");
		List<Long> deleteList = new ArrayList<Long>();
		List<StaffGradeScore> list = null;
		if (null != names && names.length > 0
				&& null != startScores && startScores.length > 0
				&& null != endScores && endScores.length > 0) {
			
			list = new ArrayList<StaffGradeScore>();
			int count = names.length;
			for (int i = 0; i < count; i++) {
				StaffGradeScore staffGradeScore = new StaffGradeScore();
				if(StringUtils.isNotBlank(objectIds[i])) {
					staffGradeScore.setObjectId(Long.parseLong(objectIds[i]));
				}
				
				//更新或新增
				if (StringUtils.isNotBlank(names[i]) 
						&& StringUtils.isNotBlank(startScores[i]) 
						&& (StringUtils.isNotBlank(endScores[i])) && StringUtils.isNotBlank(values[i])) {
					try{
						staffGradeScore.setName(names[i]);
						staffGradeScore.setValue(Integer.parseInt(values[i]));
						staffGradeScore.setStartScore(Integer.parseInt(startScores[i]));
						staffGradeScore.setEndScore(Integer.parseInt(endScores[i]));
						list.add(staffGradeScore);
					}catch(Exception e){
					}
					//要删除的数据
				} else if (null != staffGradeScore.getObjectId() 
						&& StringUtils.isBlank(names[i]) 
						&& StringUtils.isBlank(startScores[i]) 
						&& (StringUtils.isBlank(endScores[i]))&&StringUtils.isBlank(values[i])) {
					deleteList.add(staffGradeScore.getObjectId());
				}
			}
			message = staffGradeScoreManager.saveOrDelete(list, deleteList);
		}
	    return "redirect:edit" +  com.handpay.ibenefit.framework.web.MessageUtils.getMessage(message);
	}
	
	/**
	 * 年资分值设置
	 * @param request
	 * @param modelMap
	 * @param yearScore StaffYearScore
	 * @return
	 */
	@RequestMapping("/saveYearScore")
	public String saveYearScore(HttpServletRequest request, ModelMap modelMap, StaffYearScore yearScore) {
		String[] objectIds = request.getParameterValues("objectIdYear");
		String[] startYears = request.getParameterValues("startYear");
		String[] endYears = request.getParameterValues("endYear");
		String[] yearScores = request.getParameterValues("yearScore");
		List<StaffYearScore> list = null;
		
		if (null != startYears && startYears.length > 0
				&& null != endYears && endYears.length > 0
				&& null != yearScores && yearScores.length > 0) {
			
			list = new ArrayList<StaffYearScore>();
			int count = startYears.length;
			
			for(int i = 0; i < count; i++) {
				StaffYearScore staffScore = new StaffYearScore();
				
				if (StringUtils.isNotBlank(objectIds[i]) ) {
					staffScore.setObjectId(Long.parseLong(objectIds[i]));
				}
				
				if (StringUtils.isNotBlank(startYears[i]) 
						&& StringUtils.isNotBlank(endYears[i])
						&& StringUtils.isNotBlank(yearScores[i])) {
					
					staffScore.setStartYear(Integer.parseInt(startYears[i]));
					staffScore.setEndYear(Integer.parseInt(endYears[i]));
					staffScore.setScore(Integer.parseInt(yearScores[i]));
					list.add(staffScore);
				}
			}
			
			staffYearScoreManager.saveOrUpdate(list);
		}
		
		return  "redirect:edit/";
	}
	
	/**
	 * 贡献度分值设置
	 * @param request
	 * @param modelMap
	 * @param contributeScore
	 * @return
	 */
	@RequestMapping("/saveContributeScore")
	public String saveYearScore(HttpServletRequest request, ModelMap modelMap, StaffContributeScore contributeScore){
		String[] objectIds = request.getParameterValues("objectIdContribute");
		String[] startPercents = request.getParameterValues("startPercent");
		String[] endPercents = request.getParameterValues("endPercent");
		String[] scores = request.getParameterValues("contributeScore");
		List<StaffContributeScore> list = null;
		
		if (null != startPercents && startPercents.length > 0
				&& null !=  endPercents && endPercents.length > 0 
				&& null != scores && scores.length > 0) {
			
			list = new ArrayList<StaffContributeScore>();
			int count = startPercents.length;
			
			for (int i = 0; i < count; i++) {
				StaffContributeScore staffContributeScore = new StaffContributeScore();
				
				if (StringUtils.isNotBlank(objectIds[i])) {
					staffContributeScore.setObjectId( Long.parseLong(objectIds[i]) );
				}
				
				if (StringUtils.isNotBlank(startPercents[i]) 
						&& StringUtils.isNotBlank(endPercents[i]) 
						&& StringUtils.isNotBlank(scores[i])) {
					
					staffContributeScore.setStartPercent(Integer.parseInt(startPercents[i]));
					staffContributeScore.setEndPercent(Integer.parseInt(endPercents[i]));
					staffContributeScore.setScore(Integer.parseInt(scores[i]));
					list.add(staffContributeScore);
				}
			}
			
			staffContributeScoreManager.saveOrUpdate(list);
		}
		
		return  "redirect:edit/";
	}
	
	/**
	 * 等级更新周期
	 */
	@RequestMapping("/saveUpdateCycle")
	public String saveUpdateCycle(HttpServletRequest request, ModelMap modelMap){
		String objectId = request.getParameter("objectId");
		String name = request.getParameter("name");
		String value = request.getParameter("value");
		
		if (StringUtils.isNotBlank(value) && StringUtils.isNotBlank(name)) {
		 
			SystemParameter systemParameter = new SystemParameter();
			
			if (StringUtils.isNotBlank(objectId) ) {
				systemParameter.setObjectId(Long.parseLong(objectId));
			}
			
			systemParameter.setName(name);
			systemParameter.setValue(value);
			
			List<SystemParameter> list = new ArrayList<SystemParameter>();
			list.add(systemParameter);
			systemParameterManager.saveOrUpdate(list);
		}
		
		return "redirect:edit/";
	}
}
