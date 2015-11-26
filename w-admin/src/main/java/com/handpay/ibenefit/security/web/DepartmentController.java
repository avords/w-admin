package com.handpay.ibenefit.security.web;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.beanutils.BeanUtils;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import com.alibaba.dubbo.config.annotation.Reference;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.entity.Department;
import com.handpay.ibenefit.security.service.IDepartmentManager;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/department")
public class DepartmentController extends PageController<Department> {
	private static final String BASE_DIR = "security/";
	@Reference(version="1.0")
	private IDepartmentManager departmentManager;
	@Reference(version="1.0")
	private IUserManager userManager;

	@Override
	public Manager getEntityManager() {
		return departmentManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		request.setAttribute("userList", userManager.getAll());
		return super.handlePage(request, page);
	}
	protected String handleEdit(HttpServletRequest request, HttpServletResponse response, Long id) throws Exception {
		List<Department> departments = departmentManager.getAll();
		List<Department> my = new ArrayList<Department>();
		for(Department department : departments){
			Department dest = new Department();
			BeanUtils.copyProperties(dest, department);
			my.add(dest);
		}
		if(null!=id){
			Object entity = getEntityManager().getByObjectId(id);
			request.setAttribute("entity", entity);
			my.remove(entity);
		}
		request.setAttribute("departments", my);
		request.setAttribute("users", userManager.getAll());
		return BASE_DIR + "editDepartment";
	}
	
	@RequestMapping("selectSingle")
	public String select(HttpServletRequest request, HttpServletResponse response) throws Exception {
		PageSearch page = preparePage(request);
		handlePage(request, page);
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "selectSingle");
		return getFileBasePath() + "selectSingleDepartment";
	}
	
	@RequestMapping("")
	public String index(HttpServletRequest request) {
		List<Department> trees = new ArrayList<Department>();
		trees.add(Department.ROOT);
		request.setAttribute("root", parseJsonTree(trees));
		return getFileBasePath() + "departmentTree";
	}
	
	@RequestMapping("getChildren")
	public @ResponseBody String getChildren(Long objectId) throws Exception {
		List<Department> trees = new ArrayList<Department>();
		if(objectId!=null){
			trees = departmentManager.getDirectChildren(objectId);
		}else{
			trees.add(Department.ROOT);
		}
		return parseJsonTree(trees);
	}

	private String parseJsonTree(List<Department> trees) {
		StringBuilder children = new StringBuilder(140 * trees.size());
		children.append("[");
		int i=0;
		Gson gson = new GsonBuilder().create();
		for ( Department tree : trees) {
			if(i>0){
				children.append(",");
			}
			children.append(gson.toJson(tree));
			i++;
		}
		children.append("]");
		return children.toString();
	}
	
	@RequestMapping(value="/getChildren/{code}")
	public String getChildren(HttpServletRequest request, ModelMap modelMap,@PathVariable String code){
		List<Department> Trees = departmentManager.getRecursionChildrenByLayer(code);
		modelMap.addAttribute("Trees",Trees);
		return "jsonView";
	}

	@RequestMapping("treeDelete/{treeId}")
	public String treeDelete(ModelMap modelMap, @PathVariable Long treeId) {
		Department tree = departmentManager.getByObjectId(treeId);
		boolean result = false;
		if (tree != null) {
			departmentManager.delete(tree.getObjectId());
			result = true;
		}
		modelMap.addAttribute("status", result);
		return "jsonView";
	}
	
	@ResponseBody
	@RequestMapping(value="/treeSave")
	public String treeSave(ModelMap modelMap, Department entity) throws Exception {
		Gson gson = new GsonBuilder().create();
		if (entity.getObjectId() != null) {
			Department old = departmentManager.getByObjectId(entity.getObjectId());
			entity.setParentId(old.getParentId());
			entity.setLayer(old.getLayer());
		}
		departmentManager.save(entity);
//		modelMap.remove("tree");
//		modelMap.addAttribute("result", true);
//		modelMap.addAttribute("entity", entity);
		return gson.toJson(entity);
	}
}
