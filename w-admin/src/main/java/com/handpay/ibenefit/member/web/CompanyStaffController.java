package com.handpay.ibenefit.member.web;

import java.text.ParseException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.poi.hssf.usermodel.DVConstraint;
import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFDataValidation;
import org.apache.poi.hssf.usermodel.HSSFRichTextString;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Name;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.apache.poi.ss.util.CellRangeAddressList;
import org.springframework.stereotype.Controller;
import org.springframework.ui.ModelMap;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.entity.Dictionary;
import com.handpay.ibenefit.framework.service.IDictionaryManager;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.member.entity.Company;
import com.handpay.ibenefit.member.entity.CompanyDepartment;
import com.handpay.ibenefit.member.entity.CompanyStaff;
import com.handpay.ibenefit.member.service.ICompanyDepartmentManager;
import com.handpay.ibenefit.member.service.ICompanyManager;
import com.handpay.ibenefit.member.service.ICompanyStaffManager;
import com.handpay.ibenefit.member.service.IStaffManager;
import com.handpay.ibenefit.security.entity.Department;
import com.handpay.ibenefit.security.service.IUserManager;

@Controller
@RequestMapping("/companyStaff")
public class CompanyStaffController extends PageController<CompanyStaff>{
	private static final String BASE_DIR = "member/";
	
	@Reference(version = "1.0")
	private ICompanyStaffManager companyStaffManager;
	
	@Reference(version = "1.0")
	private ICompanyManager companyManager;
	
	@Reference(version="1.0")
	private ICompanyDepartmentManager companyDepartmentManager;
	
	@Reference(version="1.0")
	private IStaffManager staffManager;
	
	@Reference(version="1.0")
	private IUserManager userManager;
	
	@Reference(version="1.0")
	private IDictionaryManager dictionaryManager;
	
	@Override
	public Manager<CompanyStaff> getEntityManager() {
		return companyStaffManager;
	}

	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	/**
	 * 员工导入
	 * @param request
	 * @param companyId
	 * @return
	 */
	@RequestMapping("/importStaffs/{companyId}")
	public String uploadStaffs(HttpServletRequest request,@PathVariable Long companyId) {
		Company company=companyManager.getByObjectId(companyId);
		if (company!=null) {
			request.setAttribute("company", company);
		}
		return getFileBasePath() + "importStaffs";
	}
	
	/**
	 * 导入的结果
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadStaffs/{companyId}")
	public String importStaffs(HttpServletRequest request,@PathVariable Long companyId) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		Long userId=FrameworkContextUtils.getCurrentUserId();
		String result = staffManager.importStaffs(fileData, companyId, userId, false);
		request.setAttribute("result", result);
		request.setAttribute("companyId", companyId);
		return getFileBasePath() + "importResult";
	}
	
	/**
	 * 导入的模板
	 * @param request
	 * @param response
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/exportTemplate/{companyId}")
	public String exportTemplate(HttpServletRequest request, HttpServletResponse response, @PathVariable Long companyId) throws Exception {
		Company company = companyManager.getByObjectId(companyId);
		List<CompanyDepartment> companyDepartments = companyDepartmentManager.getCompanyDepartmentsByCompanyId(companyId);
		List<String> departmentNames = new ArrayList<String>(companyDepartments.size());
		for(CompanyDepartment department : companyDepartments){
			fillFull(department, companyDepartments);
			departmentNames.add(department.getFullName()+ "[" + department.getObjectId() + "]");
		}
		
		HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
        HSSFSheet sheet=wb.createSheet("员工导入模板");
        CellStyle style = getStyle(wb);
        style.setWrapText(true);
        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 9);
        sheet.addMergedRegion(range);
        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
        cell00.setCellStyle(style);
        cell00.setCellValue(new HSSFRichTextString("说明：1、加*为必填项，如‘员工账号’‘员工工号’‘所属部门’‘姓名’‘入职日期（2015/5/1）’‘手机号码’;" + "\n" + "2、‘手机号码’或‘邮箱‘两者必须填写一个。"));
        
        Row row1 = sheet.createRow(3);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("员工帐号*");
        sheet.autoSizeColumn(0);
        
        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("员工工号*");
        sheet.autoSizeColumn(1);
        
        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("所属部门*");
        sheet.autoSizeColumn(2);
        
        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("员工姓名*");
        sheet.autoSizeColumn(3);
        
        Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
        cell4.setCellStyle(style);
        cell4.setCellValue("入职日期*");
        sheet.autoSizeColumn(4);
        
        
        Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
        cell5.setCellStyle(style);
        cell5.setCellValue("手机号码*");
        sheet.autoSizeColumn(5);
        
        
        Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
        cell6.setCellStyle(style);
        cell6.setCellValue("邮箱*");
        sheet.autoSizeColumn(6);
        
        Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
        cell7.setCellStyle(style);
        cell7.setCellValue("员工生日");
        sheet.autoSizeColumn(7);
        
        
        Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
        cell8.setCellStyle(style);
        cell8.setCellValue("员工证件类型");
        sheet.autoSizeColumn(8);
        
        
        Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
        cell9.setCellStyle(style);
        cell9.setCellValue("员工证件号码");
        sheet.setColumnWidth(9, 5000);
        
        //部门有效性
        if(departmentNames.size()>0){
        	addDepartmentValidation(departmentNames, wb, sheet);
        }
        //证件有效性
        Dictionary dictionary=dictionaryManager.getDictionaryByDictionaryId(1306);
        List<Dictionary> dictionaries=dictionaryManager.getChildrenByParentId(dictionary.getObjectId());
        String[] IDTypes=new String[dictionaries.size()];
        for (int i = 0; i < dictionaries.size(); i++) {
			IDTypes[i]=dictionaries.get(i).getName();
		}
        HSSFDataValidation ddValidation = setDataValidationList((short)4, (short)32767, (short)8, IDTypes );
        sheet.addValidationData(ddValidation);
        String exportFileName = FileUpDownUtils.encodeDownloadFileName(request, company.getCompanyName() + "员工导入模板"+ ".xls");
        FileUpDownUtils.setDownloadResponseHeaders(response, exportFileName);
        wb.write(response.getOutputStream());
		return null;
	}

	private void addDepartmentValidation(List<String> departmentNames, HSSFWorkbook wb, HSSFSheet sheet) {
		HSSFSheet hidden = wb.createSheet("hidden");
		for (int i = 0, length = departmentNames.size(); i < length; i++) {
			String name = departmentNames.get(i);
			HSSFRow row = hidden.createRow(i);
			HSSFCell cell = row.createCell(0);
			cell.setCellValue(name);
		}
		Name namedCell = wb.createName();
		namedCell.setNameName("hidden");
		namedCell.setRefersToFormula("hidden!$A$1:$A$" + departmentNames.size());
		DVConstraint constraint = DVConstraint.createFormulaListConstraint("hidden");
		CellRangeAddressList addressList = new CellRangeAddressList((short) 4, (short) 32767, (short) 2, (short) 2);
		HSSFDataValidation validation = new HSSFDataValidation(addressList, constraint);
		wb.setSheetHidden(1, true);
		sheet.addValidationData(validation);
	}
	
	private CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 设置单元格字体
		Font headerFont = workbook.createFont(); // 字体
		headerFont.setFontHeightInPoints((short) 10);
		headerFont.setColor(HSSFColor.BLACK.index);
		headerFont.setFontName("宋体");
		style.setFont(headerFont);
		style.setWrapText(true);

		// 设置单元格边框及颜色
		style.setBorderBottom((short) 1);
		style.setBorderLeft((short) 1);
		style.setBorderRight((short) 1);
		style.setBorderTop((short) 1);
		style.setWrapText(true);
		return style;
	}
	
	public static HSSFDataValidation setDataValidationList(short firstRow,short endRow, short col, String[] textList){  
        //加载下拉列表内容  
        DVConstraint constraint= DVConstraint.createExplicitListConstraint(textList);  
        //设置数据有效性加载在哪个单元格上。  
          
        //四个参数分别是：起始行、终止行、起始列、终止列  
        CellRangeAddressList regions=new CellRangeAddressList(firstRow,endRow,col,col);  
        //数据有效性对象  
        HSSFDataValidation dataValidation = new HSSFDataValidation(regions, constraint);  
        return dataValidation;  
    }  
	
	private void fillFull(CompanyDepartment entity, List<CompanyDepartment> allCompanyDepartments) {
		if (null != entity) {
			if (null != entity.getParentId() && !Department.ROOT.getObjectId().equals(entity.getParentId())) {
				CompanyDepartment parentMenu = getParentDepartment(entity.getParentId(),allCompanyDepartments);
				if (null != parentMenu) {
					entity.setFullName(parentMenu.getFullName() + Department.PATH_SEPARATOR + entity.getName());
					return;
				}
			}
			entity.setFullName(Department.PATH_SEPARATOR + entity.getName());
		}
	}

	public CompanyDepartment getParentDepartment(Long departmentId, List<CompanyDepartment> allCompanyDepartments) {
		for(CompanyDepartment companyDepartment : allCompanyDepartments){
			if(companyDepartment.getObjectId().equals(departmentId)){
				if(companyDepartment.getFullName()==null){
					fillFull(companyDepartment, allCompanyDepartments);
				}
				return companyDepartment;
			}
		}
		return null;
	}
	
	/**
	 * 导入员工管理
	 * @param request
	 * @param companyId
	 * @return
	 */
	@RequestMapping("/viewInfo/{companyId}")
	public String viewInfo(HttpServletRequest request,@PathVariable String companyId) {
		PageSearch page = preparePage(request);
		page.getFilters().add(new PropertyFilter(CompanyStaff.class.getName(),"EQI_companyId",companyId));
		PageSearch result = getEntityManager().find(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, IS_NOT_BACK);
		request.setAttribute("action", "page");
		request.setAttribute("companyId", companyId);
		//request.setAttribute("departments", companyDepartmentManager.getCompanyDepartmentsByCompanyId(Long.parseLong(request.getParameter("search_EQL_companyId"))));
		return "member/editCompanyStaff";
	}
	
	/**
	 * 批量删除
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="deleteAll")
	public String deleteAll(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
	    String ids=request.getParameter("ids");
		String[] idArray = ids.split(",");
		for(int i=0;i<idArray.length;i++){
		     String ID=  idArray[i];
		     getEntityManager().delete(Long.parseLong(ID));
	    }
	    modelMap.addAttribute("result", true);
		return "jsonView";
	}
	
	/**
	 * 批量导出
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 */
	@RequestMapping(value="exportAll")
	public String exportAll(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap){
		String ids=request.getParameter("ids");
		String companyId=request.getParameter("companyId");
		String[] idArray = ids.split(",");
		try {
	    	Company company = companyManager.getByObjectId(Long.parseLong(companyId));
	    	List<CompanyDepartment> companyDepartments = companyDepartmentManager.getCompanyDepartmentsByCompanyId(Long.parseLong(companyId));
	 		List<String> departmentNames = new ArrayList<String>(companyDepartments.size());
	 		for(CompanyDepartment department : companyDepartments){
	 			fillFull(department, companyDepartments);
	 			departmentNames.add(department.getFullName()+ "[" + department.getObjectId() + "]");
	 		}
	 		
	 		 HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
	         HSSFSheet sheet=wb.createSheet("员工导入模板");
	         CellStyle style = getStyle(wb);
	         style.setWrapText(true);
	         CellRangeAddress range= new CellRangeAddress(0, 2, 0, 9);
	         sheet.addMergedRegion(range);
	         Row row0 = sheet.createRow(0);
	         Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
	         cell00.setCellStyle(style);
	         cell00.setCellValue(new HSSFRichTextString("说明：1、加*为必填项，如‘员工账号’‘员工工号’‘所属部门’‘姓名’‘入职日期（2015/5/1）’‘手机号码’;" + "\n" + "2、‘手机号码’或‘邮箱‘两者必须填写一个。"));
	         sheet.autoSizeColumn(0);
	         
	         Row row1 = sheet.createRow(3);
	         Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
	         cell0.setCellStyle(style);
	         cell0.setCellValue("员工帐号*");
	         sheet.autoSizeColumn(0);
	         
	         Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
	         cell1.setCellStyle(style);
	         cell1.setCellValue("员工工号*");
	         sheet.autoSizeColumn(1);
	         
	         Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
	         cell2.setCellStyle(style);
	         cell2.setCellValue("所属部门*");
	         sheet.autoSizeColumn(2);
	         
	         Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
	         cell3.setCellStyle(style);
	         cell3.setCellValue("员工姓名*");
	         sheet.autoSizeColumn(3);
	         
	         Cell cell4 = row1.createCell(4, Cell.CELL_TYPE_STRING);
	         cell4.setCellStyle(style);
	         cell4.setCellValue("入职日期*");
	         sheet.autoSizeColumn(4);
	         
	         
	         Cell cell5 = row1.createCell(5, Cell.CELL_TYPE_STRING);
	         cell5.setCellStyle(style);
	         cell5.setCellValue("手机号码*");
	         sheet.autoSizeColumn(5);
	         
	         
	         Cell cell6 = row1.createCell(6, Cell.CELL_TYPE_STRING);
	         cell6.setCellStyle(style);
	         cell6.setCellValue("邮箱*");
	         sheet.autoSizeColumn(6);
	         
	         Cell cell7 = row1.createCell(7, Cell.CELL_TYPE_STRING);
	         cell7.setCellStyle(style);
	         cell7.setCellValue("员工生日");
	         sheet.autoSizeColumn(7);
	         
	         
	         Cell cell8 = row1.createCell(8, Cell.CELL_TYPE_STRING);
	         cell8.setCellStyle(style);
	         cell8.setCellValue("员工证件类型");
	         sheet.autoSizeColumn(8);
	         
	         
	         Cell cell9 = row1.createCell(9, Cell.CELL_TYPE_STRING);
	         cell9.setCellStyle(style);
	         cell9.setCellValue("员工证件号码");
	         sheet.setColumnWidth(9, 5000);
	         
	         for(int i=0;i<idArray.length;i++){
			     String ID=  idArray[i];
			     CompanyStaff companyStaff=companyStaffManager.getByObjectId(Long.parseLong(ID));
			     if (companyStaff==null) {
					break;
				 }
			     Row row2 = sheet.createRow(i+4);
		         Cell cellA = row2.createCell(0, Cell.CELL_TYPE_STRING);
		         cellA.setCellStyle(style);
		         cellA.setCellValue(companyStaff.getLoginName());
		         sheet.autoSizeColumn(0);
		         
		         Cell cellB = row2.createCell(1, Cell.CELL_TYPE_STRING);
		         cellB.setCellStyle(style);
		         cellB.setCellValue(companyStaff.getWorkNo());
		         sheet.autoSizeColumn(1);
		         
		         Cell cellC = row2.createCell(2, Cell.CELL_TYPE_STRING);
		         cellC.setCellStyle(style);
		         cellC.setCellValue(companyStaff.getDepartmentId());
		         sheet.autoSizeColumn(2);
		         
		         Cell cellD = row2.createCell(3, Cell.CELL_TYPE_STRING);
		         cellD.setCellStyle(style);
		         cellD.setCellValue(companyStaff.getStaffName());
		         sheet.autoSizeColumn(3);
		         
		         Cell cellE = row2.createCell(4, Cell.CELL_TYPE_STRING);
		         cellE.setCellStyle(style);
		         cellE.setCellValue(companyStaff.getEntryDay());
		         sheet.autoSizeColumn(4);
		         
		         
		         Cell cellF = row2.createCell(5, Cell.CELL_TYPE_STRING);
		         cellF.setCellStyle(style);
		         cellF.setCellValue(companyStaff.getTelephone());
		         sheet.autoSizeColumn(5);
		         
		         
		         Cell cellG = row2.createCell(6, Cell.CELL_TYPE_STRING);
		         cellG.setCellStyle(style);
		         cellG.setCellValue(companyStaff.getEmail());
		         sheet.autoSizeColumn(6);
		         
		         Cell cellH = row2.createCell(7, Cell.CELL_TYPE_STRING);
		         cellH.setCellStyle(style);
		         cellH.setCellValue(companyStaff.getBirthday());
		         sheet.autoSizeColumn(7);
		         
		         
		         Cell cellI = row2.createCell(8, Cell.CELL_TYPE_STRING);
		         cellI.setCellStyle(style);
		         cellI.setCellValue(companyStaff.getIdentityType());
		         sheet.autoSizeColumn(8);
		         
		         Cell cellJ = row2.createCell(9, Cell.CELL_TYPE_STRING);
		         cellJ.setCellStyle(style);
		         cellJ.setCellValue(companyStaff.getIdNo());
		         sheet.autoSizeColumn(9);
		     }
	         
	         //部门有效性
	         if(departmentNames.size()>0){
	         	addDepartmentValidation(departmentNames, wb, sheet);
	         }
	         //证件
	         Dictionary dictionary=dictionaryManager.getDictionaryByDictionaryId(1306);
	         List<Dictionary> dictionaries=dictionaryManager.getChildrenByParentId(dictionary.getObjectId());
	         String[] IDTypes=new String[dictionaries.size()];
	         for (int i = 0; i < dictionaries.size(); i++) {
	 			IDTypes[i]=dictionaries.get(i).getName();
	 		 }
	         HSSFDataValidation ddValidation = setDataValidationList((short)4, (short)32767, (short)8, IDTypes );
	         sheet.addValidationData(ddValidation);
	         FileUpDownUtils.setDownloadResponseHeaders(response, company.getShortName() + "员工导入模板" + ".xls");
	         wb.write(response.getOutputStream());
		} catch (Exception e) {
		}
		return null;
	}
	
	/**
	 * 数据校验
	 * @param request
	 * @param response
	 * @param modelMap
	 * @return
	 * @throws ParseException 
	 */
	@RequestMapping(value="verifyAll")
	public String verifyAll(HttpServletRequest request,HttpServletResponse response,ModelMap modelMap) throws ParseException{
	    String ids=request.getParameter("ids");
	    String companyId=request.getParameter("companyId");
	    String result="";
	    if (StringUtils.isNotBlank(ids) && StringUtils.isNotBlank(companyId)) {
			Long Id=Long.parseLong(companyId);
			result=companyStaffManager.saveStaffs(ids, Id);
		} 
	    modelMap.addAttribute("result", result);
		return "jsonView";
	}
	
	@Override
	protected String handleSave(HttpServletRequest request, ModelMap modelMap,
			CompanyStaff t) throws Exception {
		return super.handleSave(request, modelMap, t);
	}
	
	protected String handlePage(HttpServletRequest request, PageSearch page) {
		return super.handlePage(request, page);
	}
}
