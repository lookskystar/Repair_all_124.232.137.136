package com.repair.query.action;

import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;

import com.repair.admin.service.UserRolesService;
import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.util.PageModel;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.query.service.JcFixRecService;

public class JcFixRecAction {
	@Resource(name="aaa")
	private JcFixRecService jcFixRecService;
	@Resource(name = "pdiFroemanManageService")
	private PdiFroemanManageService pdiFroemanManageService;
	@Resource(name = "userRolesService")
	private UserRolesService userRolesService;
	/**
	 * 按条件统计工人指定时间段内检修小辅修机车工作时长
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getTotalDuration(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String fixEmp = request.getParameter("fixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		if(fixEmp !=null){
			try {
				fixEmp = URLDecoder.decode(fixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(fixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<Integer, PageModel<Object[]>> map = this.jcFixRecService.getTotalDuration(startDate, endDate, jcNum, fixEmp);
		Integer dataSize = 0;
		PageModel pm = null;
		for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
			dataSize = (Integer) iterator.next();
			pm = map.get(dataSize);
		}
		request.setAttribute("pm", pm);
		request.setAttribute("dataSize", dataSize);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("fixEmp", fixEmp);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("jcNum", jcNum);
		return "success";
	}
	
	/**
	 * 按条件统计工人指定时间段内检修中修机车工作时长
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String getZxDuration(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String fixEmp = request.getParameter("fixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		if(fixEmp !=null){
			try {
				fixEmp = URLDecoder.decode(fixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(fixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		Map<Integer, PageModel<Object[]>> map = this.jcFixRecService.getZxDuration(startDate, endDate, jcNum, fixEmp);
		Integer dataSize = 0;
		PageModel pm = null;
		for (Iterator iterator = map.keySet().iterator(); iterator.hasNext();) {
			dataSize = (Integer) iterator.next();
			pm = map.get(dataSize);
		}
		request.setAttribute("pm", pm);
		request.setAttribute("dataSize", dataSize);
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("fixEmp", fixEmp);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("jcNum", jcNum);
		return "zx";
	}
	
	
	/**
	 * 按条件统计工人指定时间段内检修机车详细项目
	 * @return
	 */
	public String itemTime(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String fixEmp = request.getParameter("fixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		if(fixEmp !=null){
			try {
				fixEmp = URLDecoder.decode(fixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(fixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		PageModel<JCFixrec> jcfixrec = this.jcFixRecService.itemTime(startDate, endDate, jcNum, fixEmp);
		request.setAttribute("jcfixrec", jcfixrec);
		request.setAttribute("fixEmp", fixEmp);
		request.setAttribute("startDate", startDate);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		return "itemtime";
	}
	

	/**
	 * 按条件统计工人指定时间段内检修机车详细项目
	 * @return
	 */
	public String zxItemTime(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String fixEmp = request.getParameter("fixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		if(fixEmp !=null){
			try {
				fixEmp = URLDecoder.decode(fixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(fixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		PageModel<JCZXFixRec> jczxfixrec = this.jcFixRecService.zxItemTime(startDate, endDate, jcNum, fixEmp);
		request.setAttribute("jczxfixrec", jczxfixrec);
		request.setAttribute("fixEmp", fixEmp);
		request.setAttribute("startDate", startDate);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		return "zxitemtime";
	}
	/**
	 * 查询工人检修活件数
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String repCount(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String dealFixEmp = request.getParameter("dealFixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		
		String type=request.getParameter("type");
		String roleid=request.getParameter("roleid");
		String bzId=request.getParameter("bzId");
		Long nRoleid = null;
		Long nBzId = null;
		Long nType = null;
		if(!"".equals(roleid) && roleid != null)
			nRoleid = Long.parseLong(roleid);
		if(!"".equals(bzId) && bzId != null)
			nBzId = Long.parseLong(bzId);
		if(!"".equals(type) && type != null)
			nType = Long.parseLong(type);
		if(dealFixEmp !=null){
			try {
				dealFixEmp = URLDecoder.decode(dealFixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(dealFixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//工人检修报活件数
		Object count = null;
		Map<Object, PageModel<Object[]>> resultMap = this.jcFixRecService.repCount(startDate, endDate, jcNum, dealFixEmp,nType,nRoleid,nBzId);
		for (Iterator iterator = resultMap.keySet().iterator(); iterator.hasNext();) {
			 count = iterator.next();
		}
		PageModel<Object[]> jtpredict = resultMap.get(count);
		jtpredict.setCount(Integer.parseInt(count.toString()));
		request.setAttribute("jtpredict", jtpredict);
		if(dealFixEmp != null && !"".equals(dealFixEmp)){
			request.setAttribute("dealFixEmp", dealFixEmp);
		}
		//唐倩 2015-7-7 获取班组、角色信息
		request.setAttribute("dictProTeamList", pdiFroemanManageService.findWorkDictProTeam());
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		request.setAttribute("startDate", startDate);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		request.setAttribute("type", type);
		request.setAttribute("roleid", roleid);
		request.setAttribute("bzId", bzId);
		return "repcount";
	}
	/**
	 * 查询工人详细检修修活项目
	 */
	public String repItem(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String dealFixEmp = request.getParameter("dealFixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		String type = request.getParameter("type");//报活类型
		Long nType = null;
		if(!"".equals(type) && type != null)
			nType = Long.parseLong(type);
		if(dealFixEmp !=null){
			try {
				dealFixEmp = URLDecoder.decode(dealFixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(dealFixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		PageModel<JtPreDict> jtpredict = this.jcFixRecService.repItem(startDate, endDate, jcNum, dealFixEmp,nType);
		request.setAttribute("jtpredict", jtpredict);
		if(dealFixEmp != null && !"".equals(dealFixEmp)){
			request.setAttribute("dealFixEmp", dealFixEmp);
		}
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		request.setAttribute("urlEmp", urlEmp);
		//唐倩 2015-7-6 获取班组信息
		//List<DictProTeam> dict = pdiFroemanManageService.findWorkDictProTeam();
		//request.setAttribute("dictProTeams", dict);
		request.setAttribute("type", type);//报活类型
		return "repitem";
	}
	
	/**
	 * 报活件数统计
	 * @return
	 */
	public String reportCount(){
		HttpServletRequest request = ServletActionContext.getRequest();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String dealFixEmp = request.getParameter("dealFixEmp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		
		String type=request.getParameter("type");
		String roleid=request.getParameter("roleid");
		String bzId=request.getParameter("bzId");
		Long nRoleid = null;
		Long nBzId = null;
		Long nType = null;
		if(!"".equals(roleid) && roleid != null)
			nRoleid = Long.parseLong(roleid);
		if(!"".equals(bzId) && bzId != null)
			nBzId = Long.parseLong(bzId);
		if(!"".equals(type) && type != null)
			nType = Long.parseLong(type);
		if(dealFixEmp !=null){
			try {
				dealFixEmp = URLDecoder.decode(dealFixEmp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(dealFixEmp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		//工人检修报活件数
		Object count = null;
		Map<Object, PageModel<Object[]>> resultMap = this.jcFixRecService
				.reportCount(startDate, endDate, jcNum, dealFixEmp,nType,nRoleid,nBzId);
		for (Iterator iterator = resultMap.keySet().iterator(); iterator.hasNext();) {
			 count = iterator.next();
		}
		PageModel<Object[]> jtpredict = resultMap.get(count);
		jtpredict.setCount(Integer.parseInt(count.toString()));
		request.setAttribute("jtpredict", jtpredict);
		if(dealFixEmp != null && !"".equals(dealFixEmp)){
			request.setAttribute("dealFixEmp", dealFixEmp);
		}
		//唐倩 2015-7-7 获取班组、角色信息
		request.setAttribute("dictProTeamList", pdiFroemanManageService.findWorkDictProTeam());
		request.setAttribute("rolePrivsList",userRolesService.listRolePrivs());
		
		request.setAttribute("startDate", startDate);
		request.setAttribute("urlEmp", urlEmp);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		request.setAttribute("type", type);
		request.setAttribute("roleid", roleid);
		request.setAttribute("bzId", bzId);
		return "report_count";
	}
	
	/**
	 * 查询工人详细检修报活项目
	 */
	public String reportItem(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		String startDate = request.getParameter("startDate");
		String endDate = request.getParameter("endDate");
		String repemp = request.getParameter("repemp");
		String jcNum = request.getParameter("jcNum");
		String urlEmp=request.getParameter("urlEmp");
		//唐倩 2015-7-7 
		String type = request.getParameter("type");//报活类型
		Long nType = null;
		if(!"".equals(type) && type != null)
			nType = Long.parseLong(type);
		
		if(repemp !=null){
			try {
				repemp = URLDecoder.decode(repemp, "UTF-8");//十六制转为中文
				urlEmp = URLEncoder.encode(repemp, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		PageModel<JtPreDict> jtpredict = this.jcFixRecService.reportItem(startDate, endDate, jcNum, repemp,nType);
		request.setAttribute("jtpredict", jtpredict);
		if(repemp != null && !"".equals(repemp)){
			request.setAttribute("repemp", repemp);
		}
		request.setAttribute("startDate", startDate);
		request.setAttribute("endDate", endDate);
		request.setAttribute("jcNum", jcNum);
		request.setAttribute("urlEmp", urlEmp);
		//唐倩 2015-7-7 
		request.setAttribute("type", type);//报活类型
		return "report_item";
	}
	
	/**
	 * 修改报活积分
	 * @return
	 */
	public String updateRepScoreInput(){
		HttpServletRequest request = ServletActionContext.getRequest();
		//查询所有在修的机车
		List<DatePlanPri> datePlans=jcFixRecService.findFixDatePlanPri();
		String rjhmId=request.getParameter("rjhmId");
		if(rjhmId!=null&&!"".equals(rjhmId)){
			List<JtPreDict> jtPreDicts=jcFixRecService.findJtPreDictByRjhmId(Integer.parseInt(rjhmId));
			request.setAttribute("datePlanPri", jcFixRecService.findDatePlanPriById(Integer.parseInt(rjhmId)));
			request.setAttribute("jtPreDicts", jtPreDicts);
		}
		request.setAttribute("datePlans", datePlans);
		return "updateRepScoreInput";
	}
	
	/**
	 * ajax修改报活分值信息
	 * @return
	 */
	public String ajaxUpdateRepScore(){
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		Integer preDictId=Integer.parseInt(request.getParameter("preDictId"));
		Integer score=Integer.parseInt(request.getParameter("score"));
		
		try {
			jcFixRecService.updateJtPreDictScore(preDictId, score);
			response.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
}