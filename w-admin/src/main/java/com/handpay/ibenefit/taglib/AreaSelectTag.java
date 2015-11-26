package com.handpay.ibenefit.taglib;

import java.io.IOException;
import java.util.List;

import javax.servlet.jsp.JspException;
import javax.servlet.jsp.tagext.TagSupport;

import org.apache.commons.lang.StringUtils;
import org.apache.log4j.Logger;
import org.apache.taglibs.standard.lang.support.ExpressionEvaluatorManager;

import com.handpay.ibenefit.base.area.entity.Area;
import com.handpay.ibenefit.base.area.service.IAreaManager;

public class AreaSelectTag extends TagSupport {
	/**
	 * 
	 */
	private static final long serialVersionUID = -8322211607700170220L;
	private static final Logger LOGGER = Logger.getLogger(AreaSelectTag.class);
	private String province = "province";//省份下拉框名称
	private String city = "city";//市下拉框名称
	private String district = "district";//区下拉框名称
	private String code;//地区编码值
	private String styleClass; //样式
	private static IAreaManager areaManager;

	public int doStartTag() throws JspException {
		code =(String) ExpressionEvaluatorManager.evaluate("code", code, String.class, this, pageContext);
		String first = null;
		String second = null;
		if(StringUtils.isNotBlank(code)){
			if(code.length()==6){
				first = code.substring(0,2); 
				second = code.substring(0,4);
			}else if(code.length() == 4){
				first = code.substring(0,2); 
				second = code.substring(0,4);
			}else if(code.length() ==2){
				first = code; 
			}
		}
		try {
			List<Area> provinces = areaManager.getChildren(-1L);
			String pleaseSelect = "<option value='-1'>全国</option>";
			StringBuilder html = new StringBuilder();
			html.append("<select style='width:100px' class='" + styleClass +"' id='" + province + "' onchange=\"javascript:getAreaChildren('"  + city  + "',this);setAreaCode" + district + "(this,1);\">");
			html.append(pleaseSelect + selectOption(provinces, first));
			html.append("</select>");
			List<Area> cities = null;
			if(first!=null){
				cities = areaManager.getChildren(Long.valueOf(first));
			}
			html.append("<select style='width:180px' class='" + styleClass +"' id='" + city + "' onchange=\"javascript:getAreaChildren('_" + district + "',this);setAreaCode" + district + "(this,2);\">");
			html.append(pleaseSelect + selectOption(cities, second));
			html.append("</select>");
			List<Area> districts = null;
			if(second!=null){
				districts = areaManager.getChildren(Long.valueOf(second));
			}
			html.append("<input type='hidden' value='"+code+"' name='" + district + "' id='" + district + "' >");
			html.append("<select style='width:140px' class='" + styleClass +"' id='_" + district + "' onchange=\"javascript:setAreaCode" + district + "(this,3);\">");
			html.append(pleaseSelect + selectOption(districts, code));
			html.append("</select>");
			html.append("<script type='text/javascript'>function setAreaCode" + district + "(trigger,type){\n var code = $(trigger).val();\n var district = $('#"
					+ district + "');\n if(type==1){\n district.val(code);\n }else if(type==2){\n if(code==''){district.val($('#"
					+ province + "').val());\n }else{\n district.val(code);\n }}else if(type==3){\n if(code==''){\n var t=$('#"
					+ city + "').val();\n if(t==''){t=$('#"
					+ province + "').val();\n }\n district.val(t);\n }else{\n district.val(code);\n }}}</script>");
			if(first==null){
				html.append("<script type='text/javascript'>$('#" + province + "').change();</script>");
			}else if(second==null){
				html.append("<script type='text/javascript'>$('#" + city + "').change();</script>");
			}
			pageContext.getOut().write(html.toString());
		} catch (Exception e) {
			LOGGER.error("doStartTag()", e);
		}
		return EVAL_PAGE;
	}
	
	private String selectOption(List<Area> areas,String selected) throws JspException, IOException {
		if(areas==null||areas.size()==0){
			return "";
		}
		StringBuilder result = new StringBuilder(areas.size()*35);
		for (Area area : areas) {
			result.append("<option value='").append(area.getObjectId()).append("'");
			if(StringUtils.isNotBlank(selected) && area.getObjectId().equals(Long.valueOf(selected))){
				result.append(" selected ");
			}
			result.append(">").append(area.getName()).append("</option>");
		}
		return result.toString();
	}

	public String getCode() {
		return code;
	}

	public void setCode(String code) {
		this.code = code;
	}

	public static IAreaManager getAreaManager() {
		return areaManager;
	}

	public void setAreaManager(IAreaManager areaManager) {
		AreaSelectTag.areaManager = areaManager;
	}

	public String getProvince() {
		return province;
	}

	public void setProvince(String province) {
		this.province = province;
	}

	public String getCity() {
		return city;
	}

	public void setCity(String city) {
		this.city = city;
	}

	public String getDistrict() {
		return district;
	}

	public void setDistrict(String district) {
		this.district = district;
	}

	public String getStyleClass() {
		return styleClass;
	}

	public void setStyleClass(String styleClass) {
		this.styleClass = styleClass;
	}
}
