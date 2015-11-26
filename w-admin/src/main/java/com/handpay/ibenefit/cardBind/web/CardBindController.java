package com.handpay.ibenefit.cardBind.web;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Comparator;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.TreeMap;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang3.StringUtils;
import org.apache.log4j.Logger;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.ss.util.CellRangeAddress;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;

import com.alibaba.dubbo.config.annotation.Reference;
import com.handpay.ibenefit.framework.service.Manager;
import com.handpay.ibenefit.framework.util.FileUpDownUtils;
import com.handpay.ibenefit.framework.util.FrameworkContextUtils;
import com.handpay.ibenefit.framework.util.PageSearch;
import com.handpay.ibenefit.framework.util.PageUtils;
import com.handpay.ibenefit.framework.util.PropertyFilter;
import com.handpay.ibenefit.framework.util.UploadFile;
import com.handpay.ibenefit.framework.web.PageController;
import com.handpay.ibenefit.security.SecurityConstants;
import com.handpay.ibenefit.welfare.entity.CardBind;
import com.handpay.ibenefit.welfare.entity.CardBindLog;
import com.handpay.ibenefit.welfare.entity.CardCreateInfo;
import com.handpay.ibenefit.welfare.entity.CardInfo;
import com.handpay.ibenefit.welfare.entity.WelfarePackage;
import com.handpay.ibenefit.welfare.service.ICardBindLogManager;
import com.handpay.ibenefit.welfare.service.ICardBindManager;

/**
 * 卡密绑定管理处理类
 * @Description:   
 * @date 2015年9月14日 上午9:56:29 
 * @version V1.0   
 * @author ylan
 */
@Controller
@RequestMapping("/cardBind")
public class CardBindController extends PageController<CardBind> {
	
	Logger logger = Logger.getLogger(CardBindController.class);
	private static final String BASE_DIR = "cardBind/";
	
	@Reference(version = "1.0")
	private ICardBindLogManager  cardBindLogManager ;
	
	@Reference(version = "1.0")
	private ICardBindManager cardBindManager ;
	@Override
	public Manager<CardBind> getEntityManager() {
		return cardBindManager;
	}

	
	@Override
	public String getFileBasePath() {
		return BASE_DIR;
	}
	
	
	/**
	 * 
	 * @Description: 查询卡密绑定管理列表
	 * @parameter : @return
	 */
	@RequestMapping(value = "/listCardBind")
	public String listCardBind(HttpServletRequest request, CardCreateInfo t){
		PageSearch page  = preparePage(request);
		
		//卡密生成日期
		Date date = new Date();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		String currentTime = sdf.format(date);
		if(("1").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "LTD_endDate", currentTime));
			request.setAttribute("expireStatus", "1");
		}else if(("0").equals(request.getParameter("isExpire"))){
			page.getFilters().add(new PropertyFilter("CardCreateInfo", "GTD_endDate", currentTime));
			request.setAttribute("expireStatus", "0");
		}

		PageSearch result =  cardBindManager.loadWelfareBindInfos(page);
		page.setTotalCount(result.getTotalCount());
		page.setList(result.getList());
		afterPage(request, page, PageUtils.IS_NOT_BACK);
		
		return getFileBasePath() + "listCardBind";
	}
	
	
	
	/**
	 * 导出某个选中的套餐未绑定卡密列表
	 * @throws IOException 
	 * 
	 */
	@RequestMapping(value = "/exportCard")
	public void exportCard(HttpServletRequest request, HttpServletResponse response, Long packageId) throws IOException {
		List<Long> packageIds = new ArrayList<Long>() ;
		if(packageId!=null){
			packageIds = new ArrayList<Long>() ;
			packageIds.add(packageId) ;
		}
		//获取要导出的数据
		List<CardInfo> exportList = cardBindManager.queryNotBindCardByPackageIds(packageIds) ;
		//excel文件对象
		HSSFWorkbook wb=new HSSFWorkbook();
		wb = this.makeExportTemplate("卡密绑定批量导出模板");
		HSSFSheet sheet1 = wb.getSheetAt(0);
		CellStyle style = getStyle(wb);
	  	  for (int i=0; i<exportList.size(); i++) {
	  		    CardInfo cardInfo = exportList.get(i);
		        String packageName = cardInfo.getPackageName() ;
		        String cardNo = cardInfo.getCardNo() ;
		       /* String mobile = "" ;第三列
		        String remark = "" ;第四列*/
		        
				HSSFRow exeRow = sheet1.createRow(i + 4);
				//套餐名称
		        Cell cell1 = exeRow.createCell(0, Cell.CELL_TYPE_STRING);  
		        cell1.setCellStyle(style);
	            if(StringUtils.isNotBlank(packageName)){
	            	cell1.setCellValue(packageName);	
	            }else{
	            	cell1.setCellValue(""); 
	        	}
	            
				//卡号
		        Cell cell2 = exeRow.createCell(1, Cell.CELL_TYPE_STRING);  
		        cell2.setCellStyle(style);
	            if(StringUtils.isNotBlank(cardNo)){
	            	cell2.setCellValue(cardNo);	
	            }else{
	            	cell2.setCellValue(""); 
	        	}
	            
				//手机号码
		        Cell cell3 = exeRow.createCell(2, Cell.CELL_TYPE_STRING);  
		        cell3.setCellStyle(style);
		        cell3.setCellValue("");
	            
				//备注
		        Cell cell4 = exeRow.createCell(3, Cell.CELL_TYPE_STRING);  
		        cell4.setCellStyle(style);
	            cell4.setCellValue(""); 
	        	
		      }
	        FileUpDownUtils.setDownloadResponseHeaders(response, "CardBind.xls");
	        wb.write(response.getOutputStream());
	}
	
	
	
	/**
	 * 
	 * @Description: 导出模板
	 * @parameter : @return
	 */
	private  HSSFWorkbook makeExportTemplate(String exportTitle){
		HSSFWorkbook wb=new HSSFWorkbook();//excel文件对象  
        HSSFSheet sheet=wb.createSheet(exportTitle);
        CellStyle style = getStyle(wb);
        CellRangeAddress range= new CellRangeAddress(0, 2, 0, 3);
        sheet.addMergedRegion(range);
        Row row0 = sheet.createRow(0);
        Cell cell00 = row0.createCell(0, Cell.CELL_TYPE_STRING);
        cell00.setCellStyle(style);
        cell00.setCellValue("说明：‘套餐名称’ ‘卡号’ ‘手机号码’为必填项，‘备注’可为空");
        sheet.autoSizeColumn(0);
        
        Row row1 = sheet.createRow(3);
        Cell cell0 = row1.createCell(0, Cell.CELL_TYPE_STRING);
        cell0.setCellStyle(style);
        cell0.setCellValue("套餐名称");
        sheet.setColumnWidth(0, 6000);
        
        Cell cell1 = row1.createCell(1, Cell.CELL_TYPE_STRING);
        cell1.setCellStyle(style);
        cell1.setCellValue("卡号");
        sheet.setColumnWidth(1, 6000);
        
        Cell cell2 = row1.createCell(2, Cell.CELL_TYPE_STRING);
        cell2.setCellStyle(style);
        cell2.setCellValue("手机号码");
        sheet.setColumnWidth(2, 6000);
        
        Cell cell3 = row1.createCell(3, Cell.CELL_TYPE_STRING);
        cell3.setCellStyle(style);
        cell3.setCellValue("备注");
        sheet.setColumnWidth(3, 6000);
        
		return wb;
	}
	
	
	
	private CellStyle getStyle(Workbook workbook) {
		CellStyle style = workbook.createCellStyle();
		style.setAlignment(CellStyle.ALIGN_CENTER);
		style.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
		// 设置单元格字体
		Font headerFont = workbook.createFont(); // 字体
		headerFont.setFontHeightInPoints((short) 14);
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
	
	
	
	/**
	 * 
	 * @Description: 导入卡密手机绑定模板
	 * @parameter : @param request
	 * @parameter : @return
	 */
	@RequestMapping("/importCardBindDialog")
	public String importCardBindDialog(HttpServletRequest request) {
		return getFileBasePath() + "importCardBind";
	}
	
	
	
	/**
	 * 
	 * @Description: 导出模板
	 * @parameter : @param request
	 * @parameter : @param response
	 * @parameter : @return
	 * @parameter : @throws Exception
	 */
	@RequestMapping("/exportTemplate")
	public String exportTemplate(HttpServletRequest request, HttpServletResponse response) throws Exception {
		HSSFWorkbook wb = this.makeExportTemplate("卡密绑定批量导入模板");
        response.setHeader("Content-Disposition", "attachment; filename=" + java.net.URLEncoder.encode("importCardBind", "UTF-8")+".xls");
		response.setContentType("application/x-msdownload");
        wb.write(response.getOutputStream());
		return null;
	}
	
	
	/**
	 * 
	 * @Description: 查询卡密绑定详情页面
	 * @parameter : @return
	 */
	@RequestMapping(value="/handlePageCardInfo")
	public String handlePageCardInfo(HttpServletRequest request,String packageID){
		PageSearch cardPage = this.preparePage(request);
		cardPage.getFilters().add(new PropertyFilter("CardCreateInfo", "EQS_packageId", packageID));
		Long pid=0l;
		if(StringUtils.isNotEmpty(packageID)){
			pid=Long.parseLong(packageID);
			//卡密绑定的日志信息(十条)
			List<CardBindLog>cList= cardBindLogManager.queryBindLogByPackageId(pid, 10);
			request.setAttribute("data", cList);
		
		
		//根据套餐Id 查询套餐绑定信息
		WelfarePackage wpackage=cardBindManager.queryBindInfo(pid);
		request.setAttribute("wpackage", wpackage);
		request.setAttribute("packageID", packageID);
		}
		PageSearch result=cardBindManager.queryCardBindInfoPage(cardPage, pid);
		cardPage.setTotalCount(result.getTotalCount());
		cardPage.setList(result.getList());
		afterPage(request, cardPage,PageUtils.IS_NOT_BACK);
		return getFileBasePath() + "listCardInfo";
	}
	/**
	 * 加载全部卡密绑定日志
	 * @return
	 */
	@RequestMapping(value="/loadAllLog")
	public String loadAllLog(HttpServletRequest request,String packageID){
		Long pid=0l;
		if(StringUtils.isNotEmpty(packageID)){
			pid=Long.parseLong(packageID);
			//卡密绑定的日志信息(全部)
			List<CardBindLog>cList= cardBindLogManager.queryBindLogByPackageId(pid, -1);
			request.setAttribute("data", cList);
			request.setAttribute("packageID", pid);
		}
		return getFileBasePath() + "listCardOperateLog";
	}
	
	
	
	@RequestMapping(value="/savaCardBindPhone")
	public String savaCardBindPhone(HttpServletRequest request,String packageID,String arrayCardStr){
		
		Long welfarePackageId=Long.parseLong(packageID);
		
		Long userId = FrameworkContextUtils.getCurrentUserId();
		
		cardBindManager.saveCardBindByStr(arrayCardStr, welfarePackageId, userId);
	
		return "redirect:handlePageCardInfo?packageID="+packageID;
	}
	
	
	/**
	 * 导入卡密绑定手机号入数据库
	 * @param request
	 * @param companyId
	 * @return
	 * @throws Exception
	 */
	@RequestMapping("/uploadCardBind")
	public String uploadCardBind(HttpServletRequest request) throws Exception {
		UploadFile uploadFile = FileUpDownUtils.getUploadFile(request);
		byte[] fileData = FileUpDownUtils.getFileContent(uploadFile.getFile());
		//当前登录人 
		Long userId = FrameworkContextUtils.getCurrentUserId();
		Map<String, String> msgMap =  new TreeMap<String, String>();
		msgMap = cardBindManager.importBindCard(fileData, userId);
		msgMap = this.sortMapByKey(msgMap);
		String resMsg = "导入绑定结果：</br>";
		StringBuilder sb = new StringBuilder("");
		if(msgMap != null){
			for (String lineNum : msgMap.keySet()) {
				if(lineNum.equals("-1")){
					sb.append(msgMap.get("-1"));	
				}else{
					sb.append("第");
					sb.append(lineNum);
					sb.append("行导入失败：");
					sb.append(msgMap.get(lineNum));
				}
				sb.append("</br>");
			}	
		}
		if(sb.length() >0 ){
			resMsg += sb.toString();
		}else{
			resMsg += "导入完成！";
		}
		request.setAttribute("resMsg", resMsg);
		return getFileBasePath() + "importResult";
	}
	
	
	 /**
     * 使用 Map按key进行排序
     * @param map
     * @return
     */
    public Map<String, String> sortMapByKey(Map<String, String> map) {
        if (map == null || map.isEmpty()) {
            return null;
        }
 
        Map<String, String> sortMap = new TreeMap<String, String>(new MapKeyComparator());
 
        sortMap.putAll(map);
 
        return sortMap;
    }
	
	
	public  class MapKeyComparator implements Comparator<String>{
		public int compare(String str, String cmpStr) {
			int key = Integer.valueOf(str);
			int cmpKey = Integer.valueOf(cmpStr);
			int res = -1;
			if(key > cmpKey){
				res = 1;
			}
			if(key == cmpKey){
				res = 0;
			}
			return res;
		}
		
	}
}
