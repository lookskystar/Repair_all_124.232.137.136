package com.repair.query.action;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.log4j.Logger;
import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictJcType;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.OilAssayPriRecorder;
import com.repair.query.service.QueryService;
import com.repair.work.service.OilAssayService;

/**
 * 状态查询Action
 * @author shenfu
 *
 */
public class ReportAction {
	
	public static Logger log=Logger.getLogger(ReportAction.class);
	
	@Resource(name="queryService")
	private QueryService queryService;
	@Resource(name="oilAssayService")
	private OilAssayService oilAssayService;
	private List<DatePlanPri> allJC;
	
	private String jcJSON;
	
	/**
	 * 查询机务段中的所有机车
	 * @return
	 */
	public String findAllJC(){
		String time=ServletActionContext.getRequest().getParameter("time");
		this.allJC=queryService.findGDJCInDailyPlan(time);
		this.jcJSON=toJSON(this.allJC);
		ServletActionContext.getRequest().setAttribute("time", time);
		
		String type = ServletActionContext.getRequest().getParameter("type");
		if("work".equals(type)){  //工人或者工长查看
			return "work_success";
		}
		if("lead".equals(type)){
			return "lead_success";
		}
		if("jcgz".equals(type)){
			if("gdt".equals(ServletActionContext.getRequest().getParameter("flag"))){
				return "jcgz_gdt";
			}else{
				return "jcgz_success";
			}
		}
		if("kc".equals(type)){
			return "kc_success";
		}
		return "success";
	}
	
	private static String toJSON(List<DatePlanPri> list){
		StringBuffer sb=new StringBuffer("[");
		DatePlanPri dp;
		for(int i=0;i<list.size();i++){
			dp=list.get(i);
			sb.append("{'rjhmId':'"+dp.getRjhmId()+"','jcnum':'"+dp.getJcnum()+"','fixFreque':'"+dp.getFixFreque()+"','gdh':'"+dp.getGdh()+"','statue':"+dp.getPlanStatue()+",'tw':"+dp.getTwh()+"}");
			if(i!=(list.size()-1)){
				sb.append(",");
			}
		}
		sb.append("]");
		return sb.toString();
	}
	
	/**
	 * 日计划ID
	 */
	private Integer rjhmId;
	
	private DatePlanPri datePlan;
	
	private List<JCFlowRec> jcFlowRecs;
	
	private OilAssayPriRecorder oilAssayPriRecorder;
	
	public String getInfoDetail(){
		//查找日计划
		this.datePlan=queryService.findDatePlanPriById(rjhmId);
		String type = ServletActionContext.getRequest().getParameter("type");
		if("work".equals(type)){  //工人或者工长查看
			return "work_infodetail";
		}else{
			this.jcFlowRecs=queryService.findJCFlowRecByDatePlan(rjhmId);
			List<JCFlowRec> flowRecs = queryService.findJCFlowRecByDatePlan(rjhmId);
			ServletActionContext.getRequest().setAttribute("flowRecs", flowRecs);
			
			if(datePlan.getProjectType()==0){//小辅修
				//试验情况判断
				String xcxc=datePlan.getFixFreque();
				if(isSuitXcxc(xcxc)){
					Map<String,Object> map=queryService.findExpSituation(rjhmId);
					ServletActionContext.getRequest().setAttribute("map", map);
				}
			}else{//中修待定
			}
			return "infodetail";
		}
	}
	
	/**
	 * 机车检修系统查询
	 * @return
	 */
	public String select(){
		HttpServletRequest request = ServletActionContext.getRequest();
		List<DictJcType> dicJcType=queryService.getAllJcType();
		request.setAttribute("dicJcType", dicJcType);
		request.setAttribute("fixSeq", queryService.getAllFixSeq());
		request.setAttribute("units", queryService.getAllFirstUnit());
		request.setAttribute("gudaos", queryService.getAllGuDao());
		request.setAttribute("teams", queryService.getAllProTeam());
		String type = ServletActionContext.getRequest().getParameter("type");
		if(type.equals("lead")){
			return "lead_select";
		}else{
			return "select";
		}
	}
	
	private Integer typeId;
	
	/**
	 * 查询机车类型
	 * @return
	 */
	public String getJcSType(){
		HttpServletResponse resp=ServletActionContext.getResponse();
		List<DictJcStype> list=queryService.findStypeByTypeId(typeId);
		StringBuilder sb=new StringBuilder("[");
		DictJcStype type=null;
		for(int i=0;i<list.size();i++){
			type=list.get(i);
			sb.append("{'jcNumId':'"+type.getJcNumId()+"','jcStypeValue':'"+type.getJcStypeValue()+"'}");
			if(i!=(list.size()-1)){
				sb.append(",");
			}
		}
		sb.append("]");
		resp.setContentType("text/plain");
		try {
			resp.getWriter().write(sb.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
		}
		return null;
	}
	
	private String jcStype;
	
	/**
	 * 查询机车类型
	 * @return
	 */
	public String getJcNum(){
		HttpServletResponse resp=ServletActionContext.getResponse();
		List<JtRunKiloRec> list=queryService.findJtRunKiloRec(jcStype);
		StringBuilder sb=new StringBuilder("[");
		JtRunKiloRec type=null;
		for(int i=0;i<list.size();i++){
			type=list.get(i);
			sb.append("{'jcNum':'"+type.getJcNum()+"'}");
			if(i!=(list.size()-1)){
				sb.append(",");
			}
		}
		sb.append("]");
		resp.setContentType("text/plain");
		try {
			resp.getWriter().write(sb.toString());
		} catch (IOException e) {
			log.error(e.getMessage());
		}
		return null;
	}
	
    /**
     * 判断是否满足合适的修程修次
     * @return
     */
	public boolean isSuitXcxc(String xcxc){
		boolean flag=true;
//		if(xcxc.startsWith("LX") || xcxc.startsWith("JG")|| xcxc.startsWith("ZZ")||xcxc.startsWith("QZ") || xcxc.startsWith("CJ")){
		if(xcxc.startsWith("LX") || xcxc.startsWith("JG")|| xcxc.startsWith("ZZ")|| xcxc.startsWith("CJ")){
			
			flag=false;
		}
		return flag;
	}

	public String getJcStype() {
		return jcStype;
	}

	public void setJcStype(String jcStype) {
		this.jcStype = jcStype;
	}

	public Integer getTypeId() {
		return typeId;
	}

	public void setTypeId(Integer typeId) {
		this.typeId = typeId;
	}

	public Integer getRjhmId() {
		return rjhmId;
	}

	public void setRjhmId(Integer rjhmId) {
		this.rjhmId = rjhmId;
	}

	public DatePlanPri getDatePlan() {
		return datePlan;
	}

	public void setDatePlan(DatePlanPri datePlan) {
		this.datePlan = datePlan;
	}

	public List<JCFlowRec> getJcFlowRecs() {
		return jcFlowRecs;
	}

	public void setJcFlowRecs(List<JCFlowRec> jcFlowRecs) {
		this.jcFlowRecs = jcFlowRecs;
	}

	public List<DatePlanPri> getAllJC() {
		return allJC;
	}

	public void setAllJC(List<DatePlanPri> allJC) {
		this.allJC = allJC;
	}

	public String getJcJSON() {
		return jcJSON;
	}

	public void setJcJSON(String jcJSON) {
		this.jcJSON = jcJSON;
	}

	public OilAssayPriRecorder getOilAssayPriRecorder() {
		return oilAssayPriRecorder;
	}

	public void setOilAssayPriRecorder(OilAssayPriRecorder oilAssayPriRecorder) {
		this.oilAssayPriRecorder = oilAssayPriRecorder;
	}	

}
