package com.repair.query.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;

import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.struts2.ServletActionContext;

import com.opensymphony.xwork2.ActionSupport;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.util.Contains;
import com.repair.query.service.QueryService;

/**
 * 处理Excel文件导入和导出
 * 
 * @author Administrator
 * 
 */
public class ExcelAction extends ActionSupport{

	/**
	 * 
	 */
	private static final long serialVersionUID = 4959349087464306283L;

	//将数据导出为excel
	@Resource(name = "queryService")
	private QueryService queryService;
	private String fileName;//导出为excel文件名称
	
	//将excel导入到数据库中
	
	/**
	 * 导出excel
	 * 
	 * @return
	 */
	public String execute() {
		return "success";
	}

	/**
	 * 文件导出
	 */
	public InputStream getDownLoadExcelFile() {
		HttpServletRequest request = ServletActionContext.getRequest();
		Integer rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		String type=request.getParameter("type");
		DatePlanPri datePlan = queryService.findDatePlanPriById(rjhmId);
		fileName = datePlan.getJcType() + "-" + datePlan.getFixFreque() + "-" + datePlan.getJcnum() +"-"+dealDateString(datePlan.getKcsj())+".xls";
		// 创建一个excel文件
		HSSFWorkbook wb = new HSSFWorkbook();
		if(type.equals("0")){
			createJCFixRecSheet(wb,rjhmId);
		}else if(type.equals("1")){//中修
			createJCZXFixRecSheet(wb,rjhmId);
		}
		ByteArrayOutputStream baos=new ByteArrayOutputStream();
		try {
			wb.write(baos);
		} catch (IOException e1) {
			e1.printStackTrace();
		}
		byte[] buf=baos.toByteArray();
		//转换为InputStream
		InputStream is=new ByteArrayInputStream(buf);
		return is;
	}
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-21
	 * 添加内容：设置表头样式方法
	 * Excel表头样式
	 * @param wb 表
	 * @return cellstyle 单元格样式
	 */
	private HSSFCellStyle excelTableHeadStyle(HSSFWorkbook wb){
		HSSFCellStyle cellstyle=wb.createCellStyle();
	    cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 水平居中  
	    cellstyle.setWrapText(true);//设置自动换行 
	    HSSFFont headerFont = (HSSFFont) wb.createFont();  
	    headerFont.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);// 字体加粗  
	    headerFont.setFontName("Times New Roman");  
	    headerFont.setFontHeightInPoints((short) 10);  
	    cellstyle.setFont(headerFont);
	    cellstyle.setFillForegroundColor(IndexedColors.AQUA.getIndex());
	    cellstyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
	    cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框 
	    return cellstyle;
	}
	
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-21
	 * 添加内容：设置表内容样式方法
	 * Excel表内容样式
	 * @param wb 表
	 * @return cellstyle 单元格样式
	 */
	private HSSFCellStyle excelTableBodyStyle(HSSFWorkbook wb){
		HSSFCellStyle cellstyle=wb.createCellStyle();
	    cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 水平居中  
	    cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);    //设置垂直居中 
	    cellstyle.setWrapText(true);//设置自动换行
	    //cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); // 下边框 
	    return cellstyle;
	}
	

	/**
	 * 黄亮 ，2015-5-21，修改，表头数据改为数组形式，通过excelTableHeadStyle，excelTableBodyStyle两个方法得到表头和表内容样式，并设置样式。
	 * 封装小辅修记录表
	 */
	private void createJCFixRecSheet(HSSFWorkbook wb,Integer rjhmId){
		//定义表头
		 String[] tableHeader = {"部件","检修部件","检修项目","检修情况","部位","检修人","工长","质检员",
 				 "技术员","交车工长","验收员"};
		 //设置表头和表内容样式
		 HSSFCellStyle tableHeadCellstyle=excelTableHeadStyle(wb);
		 HSSFCellStyle tableBodyCellstyle=excelTableBodyStyle(wb);
		 
		Map<String,List<JCFixrec>> map=this.mapJCFixRec(rjhmId);
		for(Iterator<String> iterator=map.keySet().iterator();iterator.hasNext();){
			String key=iterator.next();
			HSSFSheet sheet=wb.createSheet(key);
			
			//设置表头，并赋值
			// 创建第一行
			HSSFRow row = sheet.createRow(0);
			// 设置单元格
			for (int i = 0; i < tableHeader.length; i++) {
				cteateCell(wb,row,i,tableHeader[i],tableHeadCellstyle);
			}
			
			//循环设置表内容，并赋值
			List<JCFixrec> jcFixRecs=map.get(key);
			for (int i = 1; i <= jcFixRecs.size(); i++) {
				JCFixrec jcFixRec = jcFixRecs.get(i - 1);
				row = sheet.createRow(i);
				cteateCell(wb,row,0,jcFixRec.getUnitName(),tableBodyCellstyle);
				cteateCell(wb,row,1,jcFixRec.getSecUnitName(),tableBodyCellstyle);
				cteateCell(wb,row,2,jcFixRec.getItemName(),tableBodyCellstyle);
				if(jcFixRec.getFixSituation()!=null){
					String unit=jcFixRec.getUnit()==null?"":jcFixRec.getUnit();
					cteateCell(wb,row,3,jcFixRec.getFixSituation() + unit,tableBodyCellstyle);
				}else{
					row.createCell(3).setCellValue("");
					//row.createCell(3).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getPosiName()!=null){
					cteateCell(wb,row,4,jcFixRec.getPosiName(),tableBodyCellstyle);
				}else{
					row.createCell(4).setCellValue("");
					//row.createCell(4).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getFixEmp()!=null){
					row.createCell(5).setCellValue(jcFixRec.getFixEmp().substring(1, jcFixRec.getFixEmp().length() - 1) + " "
							+ jcFixRec.getEmpAfformTime().substring(5,16));
					//row.createCell(5).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(5).setCellValue("");
					//row.createCell(5).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getLead()!=null){
					row.createCell(6).setCellValue(jcFixRec.getLead()+" "+jcFixRec.getLdAffirmTime().substring(5,16));
					//row.createCell(6).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(6).setCellValue("");
					//row.createCell(6).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getQi()==null&&jcFixRec.getItemCtrlQI()==1){
					row.createCell(7).setCellValue("");
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}else if(jcFixRec.getQi()==null&&jcFixRec.getItemCtrlQI()==0){
					row.createCell(7).setCellValue("/");
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(7).setCellValue(jcFixRec.getQi()+" "+jcFixRec.getQiAffiTime().substring(5,16));
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getTech()==null&&jcFixRec.getItemCtrlTech()==1){
					row.createCell(8).setCellValue("");
					//row.createCell(8).setCellStyle(tableBodyCellstyle);
				}else if(jcFixRec.getTech()==null&&jcFixRec.getItemCtrlTech()==0){
					row.createCell(8).setCellValue("/");
					//row.createCell(8).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(8).setCellValue(jcFixRec.getTech()+" "+jcFixRec.getTechAffiTime().substring(5,16));
					//row.createCell(8).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getCommitLead()==null&&jcFixRec.getItemCtrlComLd()==1){
					row.createCell(9).setCellValue("");
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}else if(jcFixRec.getCommitLead()==null&&jcFixRec.getItemCtrlComLd()==0){
					row.createCell(9).setCellValue("/");
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(9).setCellValue(jcFixRec.getCommitLead()+" "+jcFixRec.getComLdAffiTime().substring(5,16));
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}
				if(jcFixRec.getAccepter()==null&&jcFixRec.getItemCtrlAcce()==1){
					row.createCell(10).setCellValue("");
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}else if(jcFixRec.getAccepter()==null&&jcFixRec.getItemCtrlAcce()==0){
					row.createCell(10).setCellValue("/");
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(10).setCellValue(jcFixRec.getAccepter()+" "+jcFixRec.getAcceAffiTime().substring(5,16));
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}
			}

//			sheet.autoSizeColumn(5);//调整第六列的宽度
//			sheet.autoSizeColumn(6);//调整第七列的宽度
//			sheet.autoSizeColumn(7);//调整第八列的宽度
//			sheet.autoSizeColumn(8);//调整第九列的宽度
//			sheet.autoSizeColumn(9);//调整第十列的宽度
//			sheet.autoSizeColumn(10);//调整第11列的宽度
			
			sheet.setColumnWidth(5, 4800);
			sheet.setColumnWidth(6, 4800);
			sheet.setColumnWidth(7, 4800);
			sheet.setColumnWidth(8, 4800);
			sheet.setColumnWidth(9, 4800);
			sheet.setColumnWidth(10, 4800);
		}
	}
	
	/**
	 * 黄亮 ，2015-5-21，修改，表头数据改为数组形式，通过excelTableHeadStyle，excelTableBodyStyle两个方法得到表头和表内容样式，并设置样式。
	 * 创建中修记录表
	 * @param wb
	 */
	private void createJCZXFixRecSheet(HSSFWorkbook wb,Integer rjhmId){
		//定义表头
		 String[] tableHeader = {"部件","检修项目","所处节点","检修情况","配件编号","检修人","工长","质检员",
				 				 "技术员","交车工长","验收员"}; 
		 
		 //设置表头和表内容样式
		 HSSFCellStyle tableHeadCellstyle=excelTableHeadStyle(wb);
		 HSSFCellStyle tableBodyCellstyle=excelTableBodyStyle(wb);
		 
		 
		//将数据从数据库中查询出来,并且自己封装成为一个map对象
		Map<String, List<JCZXFixRec>> map = this.mapJCZXFixRec(rjhmId);
		for (Iterator<String> iterator = map.keySet().iterator(); iterator.hasNext();) {
			String key = iterator.next();
			// 创建一个sheet对象
			HSSFSheet sheet = wb.createSheet(key);
			//设置单元格宽度
			sheet.setColumnWidth(1, 6300);
			sheet.setColumnWidth(4, 5000);
			
			//设置表头，并赋值
			// 创建第一行
			HSSFRow row = sheet.createRow(0);
			// 设置单元格
			for (int i = 0; i < tableHeader.length; i++) {
				cteateCell(wb,row,i,tableHeader[i],tableHeadCellstyle);
			}

			List<JCZXFixRec> jcZxFixRecs = map.get(key);
			for (int i = 1; i <= jcZxFixRecs.size(); i++) {
				row = sheet.createRow(i);
				JCZXFixRec jcZxFixRec = jcZxFixRecs.get(i - 1);
				cteateCell(wb,row,0,jcZxFixRec.getUnitName(),tableBodyCellstyle);
				cteateCell(wb,row,1,jcZxFixRec.getItemName(),tableBodyCellstyle);
				if (jcZxFixRec.getNodeId().intValue() == Contains.ZX_FG_NODEID.intValue()) {
					cteateCell(wb,row,2,"机车分解",tableBodyCellstyle);
				} else {
					cteateCell(wb,row,2,"车上组装",tableBodyCellstyle);
				}
				if (jcZxFixRec.getUnit() != null && !" ".equals(jcZxFixRec.getUnit())) {
					cteateCell(wb,row,3,jcZxFixRec.getFixSituation() + jcZxFixRec.getUnit(),tableBodyCellstyle);
				} else {
					cteateCell(wb,row,3,jcZxFixRec.getFixSituation(),tableBodyCellstyle);
				}
				if (jcZxFixRec.getNodeId().intValue() == Contains.ZX_FG_NODEID.intValue()) {
					//创建单元格，并且给单元格设置值
					row.createCell(4).setCellValue("/");
					//row.createCell(4).setCellStyle(tableBodyCellstyle);
				} else {
					if(jcZxFixRec.getUpPjNum()==null){
						row.createCell(4).setCellValue("");
						//row.createCell(4).setCellStyle(tableBodyCellstyle);
					}else{
						cteateCell(wb,row,4,jcZxFixRec.getUpPjNum(),tableBodyCellstyle);
						//row.createCell(4).setCellStyle(tableBodyCellstyle);
					}
				}
				if(jcZxFixRec.getFixEmp()!=null){
					row.createCell(5).setCellValue(jcZxFixRec.getFixEmp().substring(1, jcZxFixRec.getFixEmp().length() - 1) + " "
							+ jcZxFixRec.getFixEmpTime().substring(5,16));
					//row.createCell(5).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(5).setCellValue("");
					//row.createCell(5).setCellStyle(tableBodyCellstyle);
				}
				if(jcZxFixRec.getLead()!=null){
					row.createCell(6).setCellValue(jcZxFixRec.getLead()+" "+jcZxFixRec.getLdAffirmTime().substring(5,16));
					//row.createCell(6).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(6).setCellValue("");
					//row.createCell(6).setCellStyle(tableBodyCellstyle);
				}
				if(jcZxFixRec.getQi()==null&&jcZxFixRec.getItemCtrlQi()==1){
					row.createCell(7).setCellValue("");
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}else if(jcZxFixRec.getQi()==null&&jcZxFixRec.getItemCtrlQi()==0){
					row.createCell(7).setCellValue("/");
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(7).setCellValue(jcZxFixRec.getQi()+" "+jcZxFixRec.getQiAffiTime().substring(5,16));
					//row.createCell(7).setCellStyle(tableBodyCellstyle);
				}
				if(jcZxFixRec.getTeachName()==null&&jcZxFixRec.getItemCtrlTech()==1){
					row.createCell(8).setCellValue("");
					//row.createCell(8).setCellStyle(tableBodyCellstyle);
				}else if(jcZxFixRec.getTeachName()==null&&jcZxFixRec.getItemCtrlTech()==0){
					row.createCell(8).setCellValue("/");
					//row.createCell(8).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(8).setCellValue(jcZxFixRec.getTeachName()+" "+jcZxFixRec.getTeachAffiTime().substring(5,16));
				}
				if(jcZxFixRec.getCommitLead()==null&&jcZxFixRec.getItemCtrlComld()==1){
					row.createCell(9).setCellValue("");
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}else if(jcZxFixRec.getCommitLead()==null&&jcZxFixRec.getItemCtrlComld()==0){
					row.createCell(9).setCellValue("/");
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(9).setCellValue(jcZxFixRec.getCommitLead()+" "+jcZxFixRec.getComLdAffiTime().substring(5,16));
					//row.createCell(9).setCellStyle(tableBodyCellstyle);
				}
				if(jcZxFixRec.getAcceptEr()==null&&jcZxFixRec.getItemCtrlAcce()==1){
					row.createCell(10).setCellValue("");
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}else if(jcZxFixRec.getAcceptEr()==null&&jcZxFixRec.getItemCtrlAcce()==0){
					row.createCell(10).setCellValue("/");
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}else{
					row.createCell(10).setCellValue(jcZxFixRec.getAcceptEr()+" "+jcZxFixRec.getAcceAffiTime().substring(5,16));
					//row.createCell(10).setCellStyle(tableBodyCellstyle);
				}
			}

//			sheet.autoSizeColumn(5);//调整第六列的宽度
//			sheet.autoSizeColumn(6);//调整第七列的宽度
//			sheet.autoSizeColumn(7);//调整第八列的宽度
//			sheet.autoSizeColumn(8);//调整第九列的宽度
//			sheet.autoSizeColumn(9);//调整第十列的宽度
//			sheet.autoSizeColumn(10);//调整第11列的宽度

			sheet.setColumnWidth(5, 4800);
			sheet.setColumnWidth(6, 4800);
			sheet.setColumnWidth(7, 4800);
			sheet.setColumnWidth(8, 4800);
			sheet.setColumnWidth(9, 4800);
			sheet.setColumnWidth(10, 4800);
			
		}
	}
	
	/**
	 * 将中修检修记录封装为一个map对象
	 * 
	 * @param rjhmId
	 * @return
	 */
	private Map<String, List<JCZXFixRec>> mapJCZXFixRec(Integer rjhmId) {
		List<JCZXFixRec> jcZxFixRecs = queryService.findJCZXFixRec(rjhmId);
		Map<String, List<JCZXFixRec>> map = new HashMap<String, List<JCZXFixRec>>();
		for (JCZXFixRec jcZxFixRec : jcZxFixRecs) {
			String unitName = jcZxFixRec.getUnitName();
			if (map.get(unitName) == null) {
				map.put(unitName, new ArrayList<JCZXFixRec>());
			}
			map.get(unitName).add(jcZxFixRec);
		}
		return map;
	}
	
	/**
	 * 将小辅修检修记录封装为一个map对象
	 * @param rjhmId
	 * @return
	 */
	private Map<String,List<JCFixrec>> mapJCFixRec(Integer rjhmId){
		List<JCFixrec> jcFixRecs=queryService.findJCFixrec(rjhmId);
		Map<String,List<JCFixrec>> map=new HashMap<String,List<JCFixrec>>();
		for(JCFixrec jcFixRec:jcFixRecs){
			String unitName=jcFixRec.getUnitName();
			if(map.get(unitName)==null){
				map.put(unitName, new ArrayList<JCFixrec>());
			}
			map.get(unitName).add(jcFixRec);
		}
		return map;
	}
	

	/**
	 * 设置响应头
	 * @param response
	 * @param fileName
	 */
	public void setResponseHeader(HttpServletResponse response,String fileName) {
		try {
			response.setContentType("application/msexcel;charset=UTF-8"); //两种方法都可以
			//response.setContentType("application/octet-stream;charset=iso-8859-1");
			response.setHeader("Content-Disposition", "attachment;filename=" + java.net.URLEncoder.encode(fileName, "UTF-8"));
			// 客户端不缓存
			response.addHeader("Pargam", "no-cache");
			response.addHeader("Cache-Control", "no-cache");
		} catch (Exception ex) {
			ex.printStackTrace();
		}
	}
	
	/**
	 * 黄亮 ，2015-5-21，修改，注释以下语句，整合到上面
	 * 创建带有样式的表格
	 * @param wb
	 * @param row
	 * @param col
	 * @param val
	 */
	private void cteateCell(HSSFWorkbook wb,HSSFRow row,int col,String val,HSSFCellStyle cellstyle)
    {

		//创建一个celll单元格
        HSSFCell cell=row.createCell(col);
        
        cell.setCellStyle(cellstyle);//给单元格设置样式
        
        cell.setCellValue(val);
        
        
        
        //创建样式
//        HSSFCellStyle cellstyle=wb.createCellStyle();
//        cellstyle.setAlignment(HSSFCellStyle.ALIGN_CENTER_SELECTION);//居中对齐
//        cellstyle.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);//垂直方向居中对齐
       
        //2015-5-19 黄亮，改，如果是第一行就设置以下样式，为表头
//        if(row.getRowNum()==0){
//        	cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);//带边框
//        	cellstyle.setFillForegroundColor((short) 13);// 设置背景色 
//        	cellstyle.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND);
//        }
//        
//        cellstyle.setBorderBottom(HSSFCellStyle.BORDER_THIN); //下边框
//        cellstyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);//左边框
//        cellstyle.setBorderTop(HSSFCellStyle.BORDER_THIN);//上边框
//        cellstyle.setBorderRight(HSSFCellStyle.BORDER_THIN);//右边框
        
//        cellstyle.setWrapText(true);//设置自动换行
//        cell.setCellStyle(cellstyle);//给单元格设置样式
        
        
    }
	
	/**
	 * 格式数据
	 * @param str
	 * @return
	 */
	@SuppressWarnings("unused")
	private String format(String str) {
		if (str != null && !"".equals(str)) {
			return str;
		}
		return "";
	}
	
	/**
	 * 处理日期字符串
	 * @param date
	 * @return
	 */
	private String dealDateString(String date){
		if(date!=null&&!"".equals(date)){
			String[] str=date.split("-");
			return str[1]+str[2].substring(0,2);
		}else{
			return "";
		}
	}
	
	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
