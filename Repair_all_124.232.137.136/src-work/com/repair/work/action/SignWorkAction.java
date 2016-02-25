package com.repair.work.action;

import java.io.PrintWriter;
import java.math.BigDecimal;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.plan.service.PlanManageService;
import com.repair.query.service.QueryService;
import com.repair.work.service.QZService;
import com.repair.work.service.SignWorkService;
import com.repair.work.service.UsersPrivsService;
import com.repair.work.service.WorkService;

/**
 * 工长、质检、技术、交车工长、验收签字
 * @author Administrator
 *
 */
public class SignWorkAction {
	@Resource(name="signWorkService")
	private SignWorkService signWorkService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="workService")
	private WorkService workService;
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	@Resource(name="queryService")
	private QueryService queryService;
	@Resource(name="qzService")
	private QZService qzService;
	
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();
	/**
	 * 查询待签机车
	 */
	public String listSignJC() throws Exception {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Integer nodeId = Integer.parseInt(request.getParameter("nodeId"));
		int rtype = Integer.parseInt(request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
		List<DatePlanPri> dpjcList = null;
		if(rtype==1){
			dpjcList = signWorkService.findDyPlanJC(user.getBzid(),nodeId);
		}else{
			dpjcList = signWorkService.findDyPlanJCByStatus(rtype,user.getUserid());//在修和待验的机车
		}
		request.setAttribute("nodeId", nodeId);
		request.setAttribute("dpjcList", dpjcList);
		request.setAttribute("rtype", rtype);
		return "jclist";
	}
	
	/**
	 * 查询待签项目
	 */
	@SuppressWarnings("unchecked")
	public String listSignItem() throws Exception {
		String result_jsp = "gz_itemlist";
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		int roleType = Integer.parseInt(request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
		switch(roleType){
			case 1 : result_jsp = "gz_itemlist";break;
			case 2 : result_jsp = "js_itemlist";break;
			case 3 : result_jsp = "zj_itemlist";break;
			case 4 : result_jsp = "jcgz_itemlist";break;
			case 5 : result_jsp = "ys_itemlist";break;
		}
		
		int xtype = getItemType(request.getParameter("jcstype"));//0：检修项目  1：临修、加改项目 2：秋整、春鉴项目
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		List result = null;
		if(xtype==0){
			result = signWorkService.listSignJCFixrec(rjhmId,user,roleType);
		}else if(xtype==1){
			result = signWorkService.listSignJtPreDict(rjhmId,user,roleType,Contains.LX_JG_TYPE);
		}else{
//			result = signWorkService.listSignJCQZFixRec(rjhmId,user,roleType);
			/** 2015-10-15 修改（秋整功能）*/
			result = signWorkService.listSignJCFixrec(rjhmId,user,roleType);
		}
		//如果是技术、质检，将其他班组查询出来
		if(roleType==2||roleType==3){
			request.setAttribute("unfinishBzs", signWorkService.findUnfinishedBz(rjhmId, roleType,0));
		}
		//根据日计划ID查找日计划,签字页面报活
		request.setAttribute("jctype", queryService.findDatePlanPriById(rjhmId).getJcType());
		request.setAttribute("rtype", roleType);
		request.setAttribute("xtype", xtype);
		request.setAttribute("itemList", result);
		request.setAttribute("rjhmId", rjhmId);
		return result_jsp;
	}
	
	/**
	 * 查询中修待签项目
	 */
	@SuppressWarnings("unchecked")
	public String listZxSignItem() throws Exception {
		String result_jsp = "gz_itemlist";
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		int roleType = Integer.parseInt(request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		DictProTeam tsTeam = workService.findDictProTeamByPY(Contains.TSZ_PY);
		request.setAttribute("tsbzid", tsTeam.getProteamid());
		switch(roleType){
			case 1 : result_jsp = "zx_gz_itemlist";break;
			case 2 : result_jsp = "zx_js_itemlist";break;
			case 3 : result_jsp = "zx_zj_itemlist";break;
			case 4 : result_jsp = "zx_jcgz_itemlist";break;
			case 5 : result_jsp = "zx_ys_itemlist";break;
		}
		
		int xtype = getItemType(request.getParameter("jcstype"));//0：检修项目  1：临修、加改项目 2：秋整、春鉴项目
		List result = null;
		if(xtype==0){
			result = signWorkService.listSignJCZxFixrec(rjhmId,user,roleType);
		}
		//如果是技术、质检，将其他班组查询出来
		if(roleType==2||roleType==3){
			request.setAttribute("unfinishBzs", signWorkService.findUnfinishedBz(rjhmId, roleType,1));
		}
		//根据日计划ID查找日计划,签字页面报活
		request.setAttribute("jctype", queryService.findDatePlanPriById(rjhmId).getJcType());
		request.setAttribute("rtype", roleType);
		request.setAttribute("xtype", xtype);
		request.setAttribute("itemList", result);
		request.setAttribute("rjhmId", rjhmId);
		return result_jsp;
	}
	
	/**
	 * 进入签字
	 */
	public String signWorkInput() throws Exception {
		request.setAttribute("rtype", request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
		request.setAttribute("qtype", request.getParameter("qtype"));//0:非全签 1：全签
		request.setAttribute("xtype", request.getParameter("xtype"));//0：检修  1：临修、加改 2：秋整、春鉴
		request.setAttribute("ids", request.getParameter("ids"));//选择签字的ID
		request.setAttribute("rjhmId", request.getParameter("rjhmId"));//日计划ID
		return "sign_dialog";
	}
	
	/**
	 * 签字
	 */
	public String signWork() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out=response.getWriter();
		try {
			int rtype = Integer.parseInt(request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
			int qtype = Integer.parseInt(request.getParameter("qtype"));//0:非全签 1：全签
			int xtype = Integer.parseInt(request.getParameter("xtype"));//0：检修  1：临修、加改 2：秋整、春鉴
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));//日计划ID
			
			String ids = request.getParameter("ids");//选择的记录ID字符串"-"隔开
	
			String result = "success";
			UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
			if(usersPrivs==null){
				result = "login_failure";//登陆错误
			}else{
				if(xtype==0){//0：检修
					result = signWorkService.updateJCFixRecOfSign(rtype,qtype,rjhmId,ids,usersPrivs);
				}else if(xtype==1){//1：临修、加改
					result = signWorkService.updateJtPreDictOfSign(rtype,qtype,rjhmId,ids,usersPrivs,Contains.LX_JG_TYPE);
					int count = signWorkService.checkRoleSign(rjhmId);
					if (count == 0) {
						DatePlanPri datePlanPri = planManageService.findDatePlanPriById(rjhmId);
						datePlanPri.setPlanStatue(1);
						planManageService.saveOrUpdateDatePlanPri(datePlanPri);
					}
				}else{//2：秋整、春鉴
//					result = signWorkService.updateJCQZFixRecOfSign(rtype,qtype,rjhmId,ids,usersPrivs);
					/**下列代码在2015-10-13  编写   周云韬*/
					result = signWorkService.updateJCFixRecOfSign(rtype,qtype,rjhmId,ids,usersPrivs);
					
					
					if((rtype == 2 || rtype == 3) && xtype == 2 ){
						//秋整中 如果是质检或技术员签认完毕就更改节点
						List<Map<String, Object>> teUnfinishList=signWorkService.findUnfinishedBz(rjhmId, 2, 0);
						List<Map<String, Object>> qiUnfinishList=signWorkService.findUnfinishedBz(rjhmId, 3, 0);
						boolean flag=true;
						for (int i = 0; i < teUnfinishList.size(); i++) {
							if(0 != ((BigDecimal)teUnfinishList.get(i).get("count")).intValue()  || 
									0 != ((BigDecimal)qiUnfinishList.get(i).get("count")).intValue() ){
								flag=false;
								break;
							}
						}
						if(flag){
							DatePlanPri datePlanPri=queryService.findDatePlanPriById(rjhmId);
							datePlanPri.setPlanStatue(0);
							datePlanPri.setNodeid(qzService.findJCFixflow(107));
							planManageService.updateDailyPlan(datePlanPri);
						}
					}
				}
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		}finally{
			out.flush();
			out.close();
		}
		return null;
	}
	
	/**
	 * 签字
	 */
	public String signZxWork() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out=response.getWriter();
		try {
			int rtype = Integer.parseInt(request.getParameter("rtype"));//1：工长 2：技术 3:质检 4:交车工长 5：验收
			int qtype = Integer.parseInt(request.getParameter("qtype"));//0:非全签 1：全签
			int xtype = Integer.parseInt(request.getParameter("xtype"));//0：检修  1：临修、加改 2：秋整、春鉴
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));//日计划ID
			
			String ids = request.getParameter("ids");//选择的记录ID字符串"-"隔开
	
			String result = "success";
			UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
			if(usersPrivs==null){
				result = "login_failure";//登陆错误
			}else{
				if(xtype==0){//0：检修
					result = signWorkService.updateJCZxFixRecOfSign(rtype,qtype,rjhmId,ids,usersPrivs);
				}
			}
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		}finally{
			out.flush();
			out.close();
		}
		return null;
	}
	
	public String ajaxGetBzItem()throws Exception{
		try{
		long bzId=Long.parseLong(request.getParameter("teamId"));
		int rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
		int xtype=Integer.parseInt(request.getParameter("xtype"));
		UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		//xtype == 2  说明为秋整修次
		if(xtype==0 || xtype ==2 ){//固定检修
			List<JCFixrec> jcFixrecs=null;
			if(usersPrivsService.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
				jcFixrecs=signWorkService.listNotChargeJCFixrec(rjhmId, bzId,usersPrivs,0);
			}else{
				jcFixrecs=signWorkService.listNotChargeJCFixrec(rjhmId, bzId,usersPrivs,1);
			}
			for(JCFixrec jcFixrec:jcFixrecs){
				obj=new JSONObject();
				obj.put("jcRecId", jcFixrec.getJcRecId());
				obj.put("secUnitName", jcFixrec.getFixitem().getSecUnitName());
				obj.put("posiName", jcFixrec.getFixitem().getPosiName());
				obj.put("itemName", jcFixrec.getItemName());
				obj.put("fixSituation", jcFixrec.getFixSituation());
				obj.put("unit", jcFixrec.getUnit());
				obj.put("fixEmp", jcFixrec.getFixEmp());
				obj.put("empAfformTime", jcFixrec.getEmpAfformTime());
				obj.put("lead", jcFixrec.getLead());
				obj.put("ldAffirmTime", jcFixrec.getLdAffirmTime());
				obj.put("qi", jcFixrec.getQi());
				obj.put("qiAffiTime", jcFixrec.getQiAffiTime());
				obj.put("tech", jcFixrec.getTech());
				obj.put("techAffiTime", jcFixrec.getTechAffiTime());
				obj.put("commitLead", jcFixrec.getCommitLead());
				obj.put("comLdAffiTime", jcFixrec.getComLdAffiTime());
				obj.put("accepter", jcFixrec.getAccepter());
				obj.put("acceAffiTime", jcFixrec.getAcceAffiTime());
				obj.put("recstatus", jcFixrec.getRecStas());
				obj.put("itemCtrlTech", jcFixrec.getFixitem().getItemCtrlTech());//技术卡控
				obj.put("itemCtrlQI", jcFixrec.getFixitem().getItemCtrlQI());//质检卡控
				obj.put("upPjNum", jcFixrec.getUpPjNum());
				array.put(obj);
			}
		}else if(xtype==1){//临修、加改
			 List<JtPreDict> jtPreDicts=signWorkService.listNotChargeJtPreDict(rjhmId, bzId);
			 for(JtPreDict jtPreDict:jtPreDicts){
				 obj=new JSONObject();
				 obj.put("jcRecId", jtPreDict.getPreDictId());
				 obj.put("itemName", jtPreDict.getRepsituation());
				 obj.put("fixSituation", jtPreDict.getDealSituation());
				 obj.put("fixEmp", jtPreDict.getDealFixEmp());
				 obj.put("empAfformTime", jtPreDict.getFixEndTime());
				 obj.put("lead", jtPreDict.getLead());
				 obj.put("ldAffirmTime", jtPreDict.getLdAffirmTime());
				 obj.put("qi", jtPreDict.getQi());
				 obj.put("qiAffiTime", jtPreDict.getQiAffiTime());
				 obj.put("tech", jtPreDict.getTechnician());
				 obj.put("techAffiTime", jtPreDict.getTechAffiTime());
				 obj.put("commitLead", jtPreDict.getCommitLd());
				 obj.put("comLdAffiTime", jtPreDict.getComLdAffiTime());
				 obj.put("accepter", jtPreDict.getAccepter());
				 obj.put("acceAffiTime", jtPreDict.getAcceTime());
				 //状态>=4
				 obj.put("itemCtrlTech", jtPreDict.getItemCtrlTech());//技术卡控
				 obj.put("itemCtrlQI", jtPreDict.getItemCtrlQI());//质检卡控
				 array.put(obj);
			 }
		}else{//秋整、春鉴
			List<JCQZFixRec> jcQZFixRecs=signWorkService.listNotChargeJCQZFixRec(rjhmId, bzId);
			for(JCQZFixRec jcQZFixRec:jcQZFixRecs){
				obj=new JSONObject();
				obj.put("jcRecId", jcQZFixRec.getJcRecId());
				obj.put("itemName", jcQZFixRec.getItemName());
				obj.put("fixSituation", jcQZFixRec.getFixSituation());
				obj.put("fixEmp", jcQZFixRec.getFixEmp());
				obj.put("empAfformTime", jcQZFixRec.getEmpAfformTime());
				obj.put("lead", jcQZFixRec.getLeadName());
				obj.put("ldAffirmTime", jcQZFixRec.getLdAffirmTime());
				obj.put("qi", jcQZFixRec.getQi());
				obj.put("qiAffiTime", jcQZFixRec.getQiAffiTime());
				obj.put("tech", jcQZFixRec.getTech());
				obj.put("techAffiTime", jcQZFixRec.getTechAffiTime());
				obj.put("commitLead", jcQZFixRec.getCommitLead());
				obj.put("comLdAffiTime",jcQZFixRec.getComLdAffiTime());
				obj.put("accepter", jcQZFixRec.getAccepter());
				obj.put("acceAffiTime", jcQZFixRec.getAcceAffiTime());
				obj.put("recstatus", jcQZFixRec.getRecStas());
				array.put(obj);
			}
		}
		JSONObject obj2=new JSONObject();
		obj2.put("datas", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj2.toString());
		}catch(Exception e){
			e.printStackTrace();
		}
		return null;
	}
	
	public String ajaxGetZxBzItem()throws Exception{
		long bzId=Long.parseLong(request.getParameter("teamId"));
		int rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
		int xtype=Integer.parseInt(request.getParameter("xtype"));
		UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		if(xtype==0){//固定检修
			List<JCZXFixRec> jcFixrecs=null;
			if(usersPrivsService.isHasRole(usersPrivs.getUserid(), Contains.ROLE_NAME_JSY)){
				jcFixrecs=signWorkService.listNotChargeJCZxFixrec(rjhmId, bzId,usersPrivs,0);
			}else{
				jcFixrecs=signWorkService.listNotChargeJCZxFixrec(rjhmId, bzId,usersPrivs,1);
			}
			for(JCZXFixRec jcFixrec:jcFixrecs){
				obj=new JSONObject();
				obj.put("jcRecId", jcFixrec.getId());
				obj.put("secUnitName", jcFixrec.getItemId().getUnitName());
				obj.put("posiName", jcFixrec.getItemId().getPosiName());
				obj.put("itemName", jcFixrec.getItemName());
				obj.put("fixSituation", jcFixrec.getFixSituation());
				obj.put("unit", jcFixrec.getUnit());
				obj.put("fixEmp", jcFixrec.getFixEmp());
				obj.put("empAfformTime", jcFixrec.getFixEmpTime());
				obj.put("lead", jcFixrec.getLead());
				obj.put("ldAffirmTime", jcFixrec.getLdAffirmTime());
				obj.put("qi", jcFixrec.getQi());
				obj.put("qiAffiTime", jcFixrec.getQiAffiTime());
				obj.put("tech", jcFixrec.getTeachName());
				obj.put("techAffiTime", jcFixrec.getTeachAffiTime());
				obj.put("commitLead", jcFixrec.getCommitLead());
				obj.put("comLdAffiTime", jcFixrec.getComLdAffiTime());
				obj.put("accepter", jcFixrec.getAcceptEr());
				obj.put("acceAffiTime", jcFixrec.getAcceAffiTime());
				obj.put("recstatus", jcFixrec.getRecStas());
				obj.put("itemCtrlTech", jcFixrec.getItemId().getItemCtrlTech());//技术卡控
				obj.put("itemCtrlAcce", jcFixrec.getItemId().getItemCtrlAcce());//验收卡控
				obj.put("itemCtrlQI", jcFixrec.getItemId().getItemCtrlQi());//质检卡控
				array.put(obj);
			}
		}
		JSONObject obj2=new JSONObject();
		obj2.put("datas", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj2.toString());
		return null;
	}
	
	/**
	 * 判断修程修次
	 * 0：检修项目  1：临修、加改项目 2：秋整、春鉴项目
	 */
	private int getItemType(String jcfix){
		int type = 0;
		String temp = jcfix.replaceAll("[0-9]", "");
		if(Contains.PY_LX.equalsIgnoreCase(temp) || Contains.PY_JG.equalsIgnoreCase(temp)|| Contains.PY_ZZ.equalsIgnoreCase(temp)){
			type = 1;
		}else if(Contains.PY_QZ.equalsIgnoreCase(temp) || Contains.PY_CJ.equalsIgnoreCase(temp)){
			type = 2;
		}
		return type;
	}
}
