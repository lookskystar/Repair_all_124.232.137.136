package com.repair.query.action;

import static com.repair.common.util.WebUtil.dateConvertString;

import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.poi.hssf.usermodel.HSSFCell;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.service.ProteamEntryService;
import com.repair.kq.service.RewardService;
import com.repair.plan.service.PlanManageService;

/**
 * 导入excel数据
 * @author Administrator
 *
 */
public class UploadExcelAction {
	
	private File excelFile;//与jsp页面的file标签的name属性一样
	private String excelFileFileName;//File对象的名称+FileName,一定要这样写，不然名称获取不到
	private ExcelWorkSheet<MainPlanDetail> excelWorkSheet;//将数据记录封装为我们需要的对象
	private ExcelWorkSheet<KQAssessReward> excelRewardWorkSheet;
	private ExcelWorkSheet<KQWorkTimeCount> excelWorkTimeCountSheet;
	
	
	// 计划管理服务
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	//考核奖励服务
	@Resource(name="rewardService")
	private RewardService rewardService;
	//工时统计服务
	@Resource(name="proteamEntryService")
	private ProteamEntryService proteamEntryService; 
	
	/**
	 * 从excel中导入计划信息数据
	 */
	public String uploadPlanExcel() throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String startTime=request.getParameter("startTime");
		String endTime=request.getParameter("endTime");
		String planTitle=request.getParameter("planTitle");
		Workbook workBook=createWorkbook(new FileInputStream(excelFile));
		List<MainPlanDetail> mainPlanDetails=getMainPlanDetail(workBook);
		
		MainPlan mainPlan=new MainPlan();
		mainPlan.setStartTime(startTime);
		mainPlan.setEndTime(endTime);
		mainPlan.setTitle(planTitle);
		mainPlan.setMakePeople(user.getXm());
		mainPlan.setMakeTime(dateConvertString(new Date()));
		mainPlan.setStatus(0);
		String message="计划信息导入失败!";
		try {
			planManageService.savePlan(mainPlan, mainPlanDetails);
			request.setAttribute("mainPlanId", mainPlan.getId());
			message="计划信息导入成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("message", message);
		return "uploadPlan";
	}
	
	/**
	 * 从excel中导入奖励考核信息
	 * @return
	 */
	public String uploadRewardExcel()throws Exception{
		HttpServletRequest request=ServletActionContext.getRequest();
		Workbook workBook=createWorkbook(new FileInputStream(excelFile));
		String message="考核奖励信息导入失败!";
		try {
			saveKQAssessReward(workBook);
			message="考核奖励信息导入成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("message", message);
		return "uploadReward";
	}
	
	//判断文件类型创建Workbook对象
    private Workbook createWorkbook(InputStream is) throws IOException{
    	if(excelFileFileName.toLowerCase().endsWith("xls")){
    		return new HSSFWorkbook(is);
    	}
    	if(excelFileFileName.toLowerCase().endsWith("xlsx")){
    		return new XSSFWorkbook(is);
    	}
    	return null;
    }
    
    private List<MainPlanDetail> getMainPlanDetail(Workbook workBook){
		Sheet sheet=workBook.getSheetAt(0);//得到第一个sheet
		excelWorkSheet=new ExcelWorkSheet<MainPlanDetail>();
		Row firstRow=sheet.getRow(0);//得到第一行，也就是列名
		Iterator<Cell> iterator=firstRow.cellIterator();//得到第一行的一个迭代器
		List<String> cellNames=new ArrayList<String>();
		//将列名取出来
		while(iterator.hasNext()){
			cellNames.add(iterator.next().getStringCellValue());
		}
		excelWorkSheet.setColumns(cellNames);
		MainPlanDetail mainPlanDetail=null;
		//遍历各列数据，并将其取出来放到excelWorkSheet中
		for(int i=1;i<sheet.getLastRowNum();i++){
			Row row=sheet.getRow(i);
			mainPlanDetail=new MainPlanDetail();
			mainPlanDetail.setPlanTime(getFormatDate(row.getCell(0)));
			mainPlanDetail.setPlanWeek(getCellValue(row.getCell(1)));
			mainPlanDetail.setNum(i);
			mainPlanDetail.setJcType(getCellValue(row.getCell(2)));
			mainPlanDetail.setJcNum(getCellValue(row.getCell(3)));
			mainPlanDetail.setXcxc(getCellValue(row.getCell(4)));
			mainPlanDetail.setKilometre(getCellValue(row.getCell(5)));
			mainPlanDetail.setRealKilometre(getCellValue(row.getCell(6)));
			mainPlanDetail.setKcArea(getCellValue(row.getCell(7)));
			mainPlanDetail.setComments(getCellValue(row.getCell(8)));
			mainPlanDetail.setIsCash(0);
			excelWorkSheet.getData().add(mainPlanDetail);
		}
		return excelWorkSheet.getData();
    }
    
    /**
     * 保存考核奖励信息
     * @param workBook
     */
    private void saveKQAssessReward(Workbook workBook){
    	HttpServletRequest request=ServletActionContext.getRequest();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
		
    	Sheet sheet=workBook.getSheetAt(0);//得到第一个sheet
		excelRewardWorkSheet=new ExcelWorkSheet<KQAssessReward>();
		KQAssessReward reward=null;
		//遍历各列数据，并将其取出来放到excelWorkSheet中
		for(int i=1;i<=sheet.getLastRowNum();i++){
			Row row=sheet.getRow(i);
			DictProTeam proteam=rewardService.findDictProTeamByName(getCellValue(row.getCell(0)));
			if(proteam==null){
				continue;
			}else{
				reward=new KQAssessReward();
				String rewardPerson=getCellValue(row.getCell(1));
				reward.setProteam(proteam);//班组
				reward.setRewardPerson(rewardPerson);
				reward.setRewardTime(getFormatDate(row.getCell(2)));
				reward.setRewardContent(getCellValue(row.getCell(3)));
				reward.setRewardAdd(getIntegerCellValue(row.getCell(4)));
				reward.setRewardSub(getIntegerCellValue(row.getCell(5)));
				reward.setRewardStandard(getCellValue(row.getCell(6)));
				reward.setRewardNote(getCellValue(row.getCell(7)));
				reward.setReportPerson(user.getXm());
				reward.setReportTime(format.format(new Date()));
				if("".equals(rewardPerson)){
					reward.setRewardStatus(0);
				}else{
					reward.setRewardStatus(1);
				}
				rewardService.saveOrUpdateKQAssessReward(reward);
			}
		}
    }
    
    /**
     * 将相应数据转换为字符串类型
     * @param cell
     * @return
     */
    private String getCellValue(Cell cell){
    	String temp="";
    	if(cell==null){
    		return temp;
    	}else if(cell.getCellType()==HSSFCell.CELL_TYPE_NUMERIC){
    		temp=cell.getNumericCellValue()+"";
    		temp=temp.substring(0,temp.lastIndexOf("."));
    	}else if(cell.getCellType()==HSSFCell.CELL_TYPE_STRING){
    		temp=cell.getStringCellValue();
    	}
    	return temp;
    }
    
    /**
     * 得到相应的整形数据
     * @param cell
     * @return
     */
    private Integer getIntegerCellValue(Cell cell){
    	if(cell==null){
    		return null;
    	}else{
    		String temp=cell.getNumericCellValue()+"";
    		temp=temp.substring(0,temp.lastIndexOf("."));
    		return Integer.parseInt(temp);
    	}
    }
    
    /**
     * 将Date数据转换为字符串类型
     * @return
     */
    private String getFormatDate(Cell cell){
    	String temp="";
    	if(cell!=null){
    		SimpleDateFormat format = new SimpleDateFormat("yyyy-MM-dd");
    		temp=format.format(cell.getDateCellValue());
    	}
    	return temp;
    }

	/**
	 * 从excel导入工时录入信息
	 * */
	public String uploadWorkTimeCountExcel() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		Workbook workBook = createWorkbook(new FileInputStream(excelFile));
		String message = "工时录入信息导入失败!";
		try {
			saveWorkTimeCount(workBook);
			message = "工时录入信息导入成功!";
		} catch (Exception e) {
			e.printStackTrace();
		}
		request.setAttribute("message", message);
		return "uploadWorkTimeCount";
	}
 
	/**
	 * 保存工时录入信息
	 * */
	private void saveWorkTimeCount(Workbook workBook) {
		Sheet sheet = workBook.getSheetAt(0);// 得到第一个sheet
		excelWorkTimeCountSheet = new ExcelWorkSheet<KQWorkTimeCount>();
		KQWorkTimeCount workTimeCount = null;
		// 遍历各列数据，并将其取出来放到excelWorkSheet中
		for (int i = 1; i <= sheet.getLastRowNum(); i++) {
			Row row = sheet.getRow(i);
			DictProTeam proteam = rewardService.findDictProTeamByName(getCellValue(row.getCell(2)));
			if (proteam == null) {
				continue;
			} else {
				workTimeCount = new KQWorkTimeCount();
				workTimeCount.setName(getCellValue(row.getCell(0)));// 姓名
				workTimeCount.setGonghao(getCellValue(row.getCell(1)));// 工号
				workTimeCount.setProteam(proteam);// 班组
				workTimeCount.setTime(getCellValue(row.getCell(3)));// 时间
				workTimeCount.setWorkContent(getCellValue(row.getCell(4)));// 工作内容
				workTimeCount.setWorkScore(getCellValue(row.getCell(5)));// 工时得分
				workTimeCount.setWorkNote(getCellValue(row.getCell(6)));// 备注
				proteamEntryService.saveProteamEntry(workTimeCount);
			}
		}
	}
    
	public File getExcelFile() {
		return excelFile;
	}
	public void setExcelFile(File excelFile) {
		this.excelFile = excelFile;
	}
	public String getExcelFileFileName() {
		return excelFileFileName;
	}

	public void setExcelFileFileName(String excelFileFileName) {
		this.excelFileFileName = excelFileFileName;
	}

	public ExcelWorkSheet<MainPlanDetail> getExcelWorkSheet() {
		return excelWorkSheet;
	}

	public void setExcelWorkSheet(ExcelWorkSheet<MainPlanDetail> excelWorkSheet) {
		this.excelWorkSheet = excelWorkSheet;
	}

	public ExcelWorkSheet<KQAssessReward> getExcelRewardWorkSheet() {
		return excelRewardWorkSheet;
	}

	public void setExcelRewardWorkSheet(
			ExcelWorkSheet<KQAssessReward> excelRewardWorkSheet) {
		this.excelRewardWorkSheet = excelRewardWorkSheet;
	}

	public ExcelWorkSheet<KQWorkTimeCount> getExcelWorkTimeCountSheet() {
		return excelWorkTimeCountSheet;
	}

	public void setExcelWorkTimeCountSheet(
			ExcelWorkSheet<KQWorkTimeCount> excelWorkTimeCountSheet) {
		this.excelWorkTimeCountSheet = excelWorkTimeCountSheet;
	}
}
