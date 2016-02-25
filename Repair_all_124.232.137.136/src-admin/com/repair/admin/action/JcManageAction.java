package com.repair.admin.action;

import java.io.PrintWriter;
import java.util.List;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.JcManageService;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.util.PageModel;

public class JcManageAction {

	@Resource(name="jcManageService")
	//private static final String midRunKilo = null;
	private JcManageService jcManageService;
	private JtRunKiloRec jtRunKiloRec;
	private String jcType;
	private String jcNum;
	private String fixFreque;
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response = ServletActionContext.getResponse();

	/**
	 * 进入机车管理页面
	 * 
	 */
	public String jcManageInput() throws Exception {
		//查询机车类型
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "jcmanage";
	}
	
	/**
	 * 查询所有机车
	 * 1.根据机车类型
	 * 2.根据机车编号
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String listJtRunKiloRec() throws Exception {
		String jcNum = request.getParameter("jcNum");
		String jcType = request.getParameter("jcType");
		PageModel jtRunKiloRecPm =  jcManageService.listJtRunKiloRec(jcType, jcNum);
		request.setAttribute("jtRunKiloRecPm", jtRunKiloRecPm);
		request.setAttribute("jcType", jcType);
		request.setAttribute("jcNum", jcNum);
		return "jc";
	}
	
	/**
	 * 进入新增机车型号
	 */
	public String addJcStypeInput() throws Exception {
		return "addJcStype";
	}
	/**
	 * 进入新增机车
	 */
	public String addJcInput() throws Exception {
		//查询机车类型
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "jcadd";
	}
	
	/**
	 * 添加机车信息
	 */
	public String addJtRunKiloRec() throws Exception {
		JtRunKiloRec jtRunKiloRec = new JtRunKiloRec();
		String jcType = request.getParameter("jcType");
		String jcNum = request.getParameter("jcNum");
		String dayRunKilo = request.getParameter("dayRunKilo");
		String minorRunKilo = request.getParameter("minorRunKilo");
		String smaRunKilo = request.getParameter("smaRunKilo");
		String midRunKilo = request.getParameter("midRunKilo");
		String larRunKilo = request.getParameter("larRunKilo");
		String totalRunKilo = request.getParameter("totalRunKilo");
		String registRant = request.getParameter("registRant");
		if(!"".equals(jcType)){
			jtRunKiloRec.setJcType(jcType);
		}
		if(!"".equals(jcNum)){
			jtRunKiloRec.setJcNum(jcNum);
		}
		jtRunKiloRec.setDayRunKilo(dayRunKilo);
		jtRunKiloRec.setMinorRunKilo(minorRunKilo);
		jtRunKiloRec.setSmaRunKilo(smaRunKilo);
		jtRunKiloRec.setMidRunKilo(midRunKilo);
		jtRunKiloRec.setLarRunKilo(larRunKilo);
		jtRunKiloRec.setTotalRunKilo(totalRunKilo);
		jtRunKiloRec.setRegistRant(registRant);
		try {
			jcManageService.saveOrUpdateJtRunKiloRec(jtRunKiloRec);
			ServletActionContext.getResponse().setContentType("text/plain");
			ServletActionContext.getResponse().getWriter().print("success");
			
		} catch (Exception e) {
			e.printStackTrace();
			ServletActionContext.getResponse().getWriter().write("failure");
		}
		return null;
	}
	
	/**
	 * 删除机车
	 * @return
	 */
	public String deleteJtRunKiloRec() throws Exception {
		String result = "";
		//删除机车
		PrintWriter out = ServletActionContext.getResponse().getWriter();
		String[] jtRunKiloRecIdArray = ServletActionContext.getRequest().getParameter("jcs").split(",");
		try {
			for(int i=0; i < jtRunKiloRecIdArray.length; i++){
				JtRunKiloRec jtRunKiloRec = jcManageService.queryJtRunKiloRecById(Long.parseLong(jtRunKiloRecIdArray[i]));
				result = jcManageService.deleteJtRunKiloRec(jtRunKiloRec);
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入编辑机车信息
	 * @return
	 */
	public String editeJtRunKiloRecInput() throws Exception {
		String runId = request.getParameter("runId");
		List<DictJcStype> dictJcStypeList = jcManageService.ListDictJcStype();
		JtRunKiloRec jtRunKiloRec = null;
		if(!"".equals(runId )){
			jtRunKiloRec = jcManageService.queryJtRunKiloRecById(Long.parseLong(runId));
		}
		request.setAttribute("jtRunKiloRec", jtRunKiloRec);
		request.setAttribute("dictJcStypeList", dictJcStypeList);
		return "jcedite";
	}
	
	/**
	 * 编辑机车信息
	 * @return
	 */
	public String editeJtRunKiloRec() throws Exception {
		try {
			jcManageService.saveOrUpdateJtRunKiloRec(jtRunKiloRec);
			request.setAttribute("message", "机车信息编辑成功！");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return jcManageInput();
	}
	
	
	/**
	 * 查询所有机车
	 * 1.根据机车类型
	 * 2.根据机车编号
	 * @return
	 * @throws Exception
	 */
	@SuppressWarnings("unchecked")
	public String listDatePlanPri() throws Exception {
		request.setAttribute("datePlanPri", jcManageService.listDatePlanPri(jcType, jcNum, fixFreque));
		request.setAttribute("dictJcStypeList", jcManageService.ListDictJcStype());
		request.setAttribute("jcType", jcType);
		request.setAttribute("jcNum", jcNum);
		request.setAttribute("fixFreque", fixFreque);
		return "repairjc";
	}
	
	/**
	 * 删除在修机车
	 */
	public String deleteRepairjc() throws Exception {
		String result = "failure";
		String jcArray[] = request.getParameter("rjhmId").split(",");
		if (jcArray.length > 0) {
			jcManageService.deleteRepairjc(jcArray);
			result = "success";
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
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
	
	public String getFixFreque() {
		return fixFreque;
	}

	public void setFixFreque(String fixFreque) {
		this.fixFreque = fixFreque;
	}

	public JtRunKiloRec getJtRunKiloRec() {
		return jtRunKiloRec;
	}
	public void setJtRunKiloRec(JtRunKiloRec jtRunKiloRec) {
		this.jtRunKiloRec = jtRunKiloRec;
	}
	public JcManageService getJcManageService() {
		return jcManageService;
	}
	public void setJcManageService(JcManageService jcManageService) {
		this.jcManageService = jcManageService;
	}
	
}
