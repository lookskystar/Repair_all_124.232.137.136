package com.repair.query.action;

import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.JcManageService;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.TrainFault;
import com.repair.common.util.PageModel;
import com.repair.query.service.TeachManageService;
import com.repair.work.service.JtPreDictService;

public class TeachManageAction {
	
	@Resource(name="teachManageService")
	private TeachManageService teachManageService;
	@Resource(name="jcManageService")
	private JcManageService jcManageService;
	@Resource(name = "jtPreDictService")
	private JtPreDictService jtPreDictService;

	
	private String jcType;
	private String jcNum;
	private String type;
	private String dateStart;
	private String dateEnd;
	private String jcnum;
	private String rjhmId;
	private String ejbj;
	private String yjbj;
	private TrainFault trainFault;
	private JtRunKiloRec jtRunKiloRec;

	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");
	
	
	
	/**
	 * 临修、加改分析（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String techManage() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel DatePlanPriPm = teachManageService.techManage(type, dateStart, dateEnd, jcnum);
		request.setAttribute("DatePlanPriPm", DatePlanPriPm);
		return "tempFix";
	}
	
	/**
	 * 超修分析（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String superFix() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel DatePlanPriPm = teachManageService.superFix(dateStart, dateEnd, jcnum);
		request.setAttribute("DatePlanPriPm", DatePlanPriPm);
		return "superFix";
	}
	
	/**
	 * 超修分析（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String superFixRecord() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel JtPreDictPm = teachManageService.zoreRecord("super",Integer.valueOf(rjhmId), dateStart, dateEnd);
		request.setAttribute("JtPreDictPm", JtPreDictPm);
		return "superFixRecord";
	}
	
	/**
	 * 临修、加改、超修分析（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String tempRecord() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel JtPreDictPm = teachManageService.zoreRecord("tem",Integer.valueOf(rjhmId), dateStart, dateEnd);
		request.setAttribute("JtPreDictPm", JtPreDictPm);
		return "tempRecord";
	}
	
	
	
	/**
	 * 零公里检查分析（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String zoreAnalyse() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel DatePlanPriPm  = teachManageService.zoreAnalyse(dateStart, dateEnd, jcnum);
		request.setAttribute("DatePlanPriPm", DatePlanPriPm);
		return "zeroAnalyse";
	}
	
	/**
	 * 零公里记录检查（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String zoreRecord() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel JtPreDictPm = teachManageService.zoreRecord("zore", Integer.valueOf(rjhmId), dateStart, dateEnd);
		request.setAttribute("JtPreDictPm", JtPreDictPm);
		return "zeroRecord";
	}
	
	/**
	 * 检修指标统计（技术管理）
	 * @return
	 */
	public String maintenIndexCountInput() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "fixIndexInput";
	}
	
	/**
	 * 检修指标统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String maintenIndexCount() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel jtRunKiloRecPm =  jcManageService.listJtRunKiloRec(jcType, jcNum);
		request.setAttribute("jtRunKiloRecPm", jtRunKiloRecPm);
		return "fixIndex";
	}
	
	/**
	 * 走行部故障统计（技术管理）
	 * @return
	 */
	public String runDepartDictManage() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "runDepart";
	}
	
	/**
	 * 走行部故障统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String runDepartDict() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel jtRunKiloRecPm =  jcManageService.listJtRunKiloRec(jcType, jcNum);
		request.setAttribute("jtRunKiloRecPm", jtRunKiloRecPm);
		return "runDict";
	}
	
	/**
	 * 走行部故障统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String runFixInfoRecord() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel DatePlanPriPm  = teachManageService.fixIndexMainten(jcType, jcnum,dateStart, dateEnd);
		request.setAttribute("DatePlanPriPm", DatePlanPriPm);
		return "runFixInfoRecord";
	}
	
	
	/**
	 * 检修指标统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String fixInfoRecord() throws Exception {
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel DatePlanPriPm  = teachManageService.fixIndexMainten(jcType, jcnum,dateStart, dateEnd);
		request.setAttribute("DatePlanPriPm", DatePlanPriPm);
		return "fixInfoRecord";
	}
	
	/**
	 * 检修指标统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String preInfoRecord() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		//查询所有专业
		request.setAttribute("dictFirstUnitList", jtPreDictService.listFirstUnitNameOfDictFailure());
		PageModel JtPreDictPm = teachManageService.preInfoRecord(type,yjbj,ejbj,jcType, jcnum,dateStart, dateEnd);
		request.setAttribute("JtPreDictPm", JtPreDictPm);
		return "preInfoRecord";
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 */
	public String trainFaultManage() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "trainFaultManage";
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String trainFaultLists() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		PageModel TrainFaultPm = teachManageService.trainFaultList(jcType, jcnum,dateStart, dateEnd);
		request.setAttribute("TrainFaultPm", TrainFaultPm);
		return "trainFaultList";
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 */
	public String newTrainFault() throws Exception{
		return "newTrainFault";
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 * @throws Exception
	 */
	public String saveTrainFault() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		//根据机车类型和编号查找机车 
		JtRunKiloRec jtRunKiloRec =  jcManageService.listJtRunKiloRecOnly(trainFault.getJctype(), trainFault.getJcnum());
		trainFault.setJtRunKiloRec(jtRunKiloRec);
		try {
			teachManageService.saveTrainFault(trainFault);
			request.setAttribute("message", "机破信息添加成功!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return trainFaultLists();
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 * @throws Exception
	 */
	public String deleteTrainFaultAjax() throws Exception{
		String result = "";
		//删除机破信息
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String[] trainFaultIdArray = ServletActionContext.getRequest().getParameter("faults").split(",");
		try {
			for(int i=0; i < trainFaultIdArray.length; i++){
				TrainFault trainFault = teachManageService.queryTrainFaultById(Integer.valueOf(trainFaultIdArray[i]));
				teachManageService.deleteTrainFault(trainFault);
				result = "success";
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 * @throws Exception
	 */
	public String editTrainFault() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		//根据机车类型和编号查找机车 
		trainFault.setJtRunKiloRec(jtRunKiloRec);
		try {
			teachManageService.saveTrainFault(trainFault);
			request.setAttribute("message", "机破信息编辑成功!");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return trainFaultLists();
	}
	
	/**
	 * 机破信息统计（技术管理）
	 * @return
	 * @throws Exception
	 */
	public String trainFaultInfo() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		TrainFault trainFault = teachManageService.queryTrainFaultById(Integer.valueOf(request.getParameter("id")));
		request.setAttribute("trainFault", trainFault);
		return "trainFaultInfo";
	}
	
	public String getType() {
		return type;
	}

	public void setType(String type) {
		this.type = type;
	}

	public String getDateStart() {
		return dateStart;
	}

	public void setDateStart(String dateStart) {
		this.dateStart = dateStart;
	}

	public String getDateEnd() {
		return dateEnd;
	}

	public void setDateEnd(String dateEnd) {
		this.dateEnd = dateEnd;
	}

	public String getJcnum() {
		return jcnum;
	}

	public void setJcnum(String jcnum) {
		this.jcnum = jcnum;
	}
	
	public String getEjbj() {
		return ejbj;
	}

	public void setEjbj(String ejbj) {
		this.ejbj = ejbj;
	}

	public String getYjbj() {
		return yjbj;
	}

	public void setYjbj(String yjbj) {
		this.yjbj = yjbj;
	}

	public TrainFault getTrainFault() {
		return trainFault;
	}

	public void setTrainFault(TrainFault trainFault) {
		this.trainFault = trainFault;
	}

	public JtRunKiloRec getJtRunKiloRec() {
		return jtRunKiloRec;
	}

	public void setJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		this.jtRunKiloRec = jtRunKiloRec;
	}

	public String getRjhmId() {
		return rjhmId;
	}

	public void setRjhmId(String rjhmId) {
		this.rjhmId = rjhmId;
	}

	public String getJcType() {
		return jcType;
	}

	public void setJcType(String jcType) {
		this.jcType = jcType;
	}

	public String getJcNum() {
		return jcNum;
	}

	public void setJcNum(String jcNum) {
		this.jcNum = jcNum;
	}
	
	
	
	

}