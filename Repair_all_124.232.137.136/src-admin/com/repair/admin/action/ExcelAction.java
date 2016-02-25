package com.repair.admin.action;

import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.InputStream;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFCellStyle;
import org.apache.poi.hssf.usermodel.HSSFFont;
import org.apache.poi.hssf.usermodel.HSSFRow;
import org.apache.poi.hssf.usermodel.HSSFSheet;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;

public class ExcelAction {
	
	public InputStream excelStream;  //这个输入流对应上面struts.xml中配置的那个excelStream，两者必须一致
	public String fileName;  //这个名称就是用来传给上面struts.xml中的${fileName}的
	
	/**
	 * 导出
	 */
	public String export() throws Exception {
		HSSFWorkbook workbook = new HSSFWorkbook();
		HSSFSheet sheet = null;
		for (int i = 0; i < 3; i++) {
			sheet = workbook.createSheet("测试"+i);//sheet单元
			
			HSSFRow row = sheet.createRow(0);//表头行
			
			HSSFCell cell = null;
			
			// 设置单元格字体          
			HSSFFont font = workbook.createFont();          
			font.setBoldweight(HSSFFont.BOLDWEIGHT_BOLD);          
			font.setFontName("宋体");          
			
			//设置单元格格式
			HSSFCellStyle style = workbook.createCellStyle();           
			style.setAlignment(HSSFCellStyle.ALIGN_CENTER); // 指定单元格居中对齐          
			style.setVerticalAlignment(HSSFCellStyle.VERTICAL_CENTER);// 指定单元格垂直居中对齐          
			style.setWrapText(true);// 指定单元格自动换行
			style.setFont(font);
			
			// 设置单元格背景色          
			style.setFillForegroundColor(HSSFColor.GREY_25_PERCENT.index);          
			style.setFillPattern(HSSFCellStyle.SOLID_FOREGROUND); 
			
			sheet.setColumnWidth(1, 30*256);//设置列宽度，50*256 表示50个字符宽度
			
			cell = row.createCell(0);
			cell.setCellValue("ID");
			cell.setCellStyle(style);//引入样式
			
			cell = row.createCell(1);
			cell.setCellValue("姓名");
			cell.setCellStyle(style);//引入样式

			
			String[] content = new String[]{"张三11111111111111","李四","王五","赵六"};
			
			
			//内容行--10行
			for (int j = 0; j < content.length; j++) {
				row = sheet.createRow(j+1);
				row.createCell(0).setCellValue(j);
				row.createCell(1).setCellValue(content[j]);
			}
		}
		
		ByteArrayOutputStream baos = new ByteArrayOutputStream();
        workbook.write(baos); 
        baos.flush(); 
        byte[] bArr = baos.toByteArray();
        excelStream = new ByteArrayInputStream(bArr, 0, bArr.length);
        baos.close();

		return "success";
	}

	public InputStream getExcelStream() {
		return excelStream;
	}

	public void setExcelStream(InputStream excelStream) {
		this.excelStream = excelStream;
	}

	public String getFileName() {
		return fileName;
	}

	public void setFileName(String fileName) {
		this.fileName = fileName;
	}
}
