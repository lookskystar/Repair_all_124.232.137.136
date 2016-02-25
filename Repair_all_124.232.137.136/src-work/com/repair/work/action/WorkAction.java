package com.repair.work.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.Iterator;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCFlowRec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JcExperimentItem;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.YSJCRec;
import com.repair.common.util.Contains;
import com.repair.experiment.service.ExperimentService;
import com.repair.plan.service.PlanManageService;
import com.repair.query.service.QueryService;
import com.repair.work.service.JCQZFixService;
import com.repair.work.service.JtPreDictService;
import com.repair.work.service.PresetDivisionService;
import com.repair.work.service.QZService;
import com.repair.work.service.SignWorkService;
import com.repair.work.service.UsersPrivsService;
import com.repair.work.service.WorkService;
import com.repair.work.service.YSJCRecService;

/**
 * 检修
 * 
 * @author Administrator
 */
public class WorkAction {

	@Resource(name = "usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name = "workService")
	private WorkService workService;
	@Resource(name = "presetDivisionService")
	private PresetDivisionService presetDivisionService;
	@Resource(name = "jtPreDictService")
	private JtPreDictService jtPreDictService;
	@Resource(name = "jcqzFixService")
	private JCQZFixService jcqzFixService;
	@Resource(name = "planManageService")
	private PlanManageService planManageService;
	@Resource(name = "signWorkService")
	private SignWorkService signWorkService;
	@Resource(name = "queryService")
	private QueryService queryService;
	@Resource(name = "experimentService")
	private ExperimentService experimentService;
	@Resource(name = "ysjcRecService")
	private YSJCRecService ysjcRecService;

	@Resource(name="qzService")
	private QZService qzService;
	
	HttpServletRequest request = ServletActionContext.getRequest();
	HttpServletResponse response = ServletActionContext.getResponse();

	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat YMDHM_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	
	
	//以下代码应该迁移到ReportWorkManageAction相关模块中，但是因为前期开发原因未迁移-----开始
	/**
	 * 作者：黄亮
	 * 时间：2015-5-27
	 * 报活修改上车配件编码
	 * 通过planId（日计划id），查找datePlanPri（日计划表），得到jcnum（机车编号），然后更新PJDynamicInfo（配件动态信息表）通过pjNum，和JtPreDict（报活记录表）
	 * 通过pjnum（配件编号）更新pJFixRecord（配件检修记录表）的planId（rjmid）[日计划id]字段
	 * @return String 
	 */
	public String updatePJDynamicInfosByPjNumAndJtPreDict(){	
		try {
			String pjNums = request.getParameter("pjNums"); //pjNums是PreDictId：PjNum字符串形式的数据
			String planIdStr = request.getParameter("planId");//日计划id字符串类型
			String preDictIdStr=request.getParameter("predictId");//报活主键id字符串类型
			String pjNumsOld=request.getParameter("pjNumsOld");//得到原配件编号

			Integer planId=null; //日计划id
			DatePlanPri datePlanPri=null; //日计划实体
			String jcnum=null; //车型+机车编号
			Integer preDictId=null; //报活主键id
			
			String [] pjNumArray=null;
			String [] pjNumOldArray=null;
			
			if(pjNums!=null&&!"".equals(pjNums)){
				pjNumArray=pjNums.split(",");
			}
			if(pjNumsOld!=null&&!"".equals(pjNumsOld)){
				pjNumOldArray=pjNumsOld.split(",");
			}
			if(planIdStr!=null&&!"".equals(planIdStr)){
				planId=Integer.parseInt(planIdStr);
			}
			
			//调用planManageService，根据日计划id（planId）获取上车编号getJcnum
			datePlanPri=planManageService.findDatePlanPriById(planId);
			if(datePlanPri!=null){
				jcnum=datePlanPri.getJcType()+"-"+datePlanPri.getJcnum();
			}	
			if(preDictIdStr!=null&&!"".equals(preDictIdStr)){
				preDictId=Integer.parseInt(preDictIdStr);
			}
			//修改
			if(pjNumArray!=null&&pjNumOldArray!=null){
				//执行更新操作-报活修改上车新配件状态，修改原配件状态
				workService.updatePJDynamicInfosByPjNumAndJtPreDict(pjNumArray,pjNumOldArray,jcnum,preDictId,planId);
			}else{//添加
				////执行更新操作-报活修改上车新配件状态
				workService.updatePJDynamicInfosByPjNumAndJtPreDict(pjNumArray,null,jcnum,preDictId,planId);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	
	/**
	 * 作者：黄亮
	 * 时间：2015-5-21
	 * 报活修改上车配件编码
	 * 通过planId（日计划id），查找datePlanPri（日计划表），得到jcnum（机车编号），然后更新PJDynamicInfo（配件动态信息表）和JtPreDict（报活记录表）
	 * @return String 
	 */
	public String updatePJDynamicInfosAndJtPreDict(){	
		try {
			String pjNums = request.getParameter("pjNums"); //pjNums是PreDictId：PjNum字符串形式的数据
			String planIdStr = request.getParameter("planId");//日计划id字符串类型
			String preDictIdStr=request.getParameter("predictId");//报活主键id字符串类型
			
			Integer planId=null; //日计划id
			DatePlanPri datePlanPri=null; //日计划实体
			String jcnum=null; //机车编号
			Integer preDictId=null; //报活主键id
			
			String [] pjNumArray=pjNums.split(",");
			
			if(planIdStr!=null){
				planId=Integer.parseInt(planIdStr);
			}
			
			if(pjNumArray.length>-1){
				//调用planManageService，根据日计划id（planId）获取上车编号getJcnum
				datePlanPri=planManageService.findDatePlanPriById(planId);
				if(datePlanPri!=null){
					jcnum=datePlanPri.getJcnum();
				}
				
				if(preDictIdStr!=null){
					preDictId=Integer.parseInt(preDictIdStr);
				}
				//执行更新操作-报活修改上车配件编码
				workService.updateStorePositionsAndGetOnNumsByPjdidForPJDynamicInfos_updateUpPjNumByPreDictIdForJtPreDict(pjNumArray,jcnum,preDictId);
			}
			return null;
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	//以下代码应该迁移到ReportWorkManageAction相关模块中，但是因为前期开发原因未迁移-----结束
	
	
	
	
	/**
	 * 查询日计划机车: 根据班组、状态查询
	 */
	public String findDyPlanJC() throws Exception {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		boolean isGZRole = usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_GZ);
		List<DatePlanPri> dpjcList = null;
		Integer nodeId = Integer.parseInt(request.getParameter("nodeId"));
		if (isGZRole) {
			dpjcList = workService.findDyPlanJC(user.getBzid(), Contains.PLAN_STATUS_DAIXIU, nodeId);
		}
		request.setAttribute("nodeId", nodeId);
		request.setAttribute("dpjcList", dpjcList);
		return "jclist";
	}

	/**
	 * 进入派工页面
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String findFlowItem() throws Exception {
		String jcType = request.getParameter("jctype");// 车型
		String jcfix = request.getParameter("jcfix");// 修程修次
		int rjhmId = Integer.parseInt(request.getParameter("dpid"));// 日计划ID
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		boolean isGZRole = usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_GZ);
		int itemType = getItemType(jcfix);// 0：检修项目 1：临修、加改项目 2：秋整、春鉴项目
		List result = null;
		List<UsersPrivs> users = null;

		if (isGZRole && jcType != null && !"".equals(jcType)) {
			Long bzId = user.getBzid();
			int nodeId = Integer.parseInt(request.getParameter("nodeId"));
			if (itemType == 0) {// 预设分工大类
				result = presetDivisionService.getPresetDivisonByTypeId(jcType, bzId, nodeId);
			} else if (itemType == 1) {// 临修加改项目
				result = jtPreDictService.getJtPreDict(rjhmId, bzId);
			} else {// 秋整春鉴项目
				result = jcqzFixService.getJCQZFix(jcfix, bzId, getJcsType(jcType));
			}
			users = usersPrivsService.listUsersByBzId(user.getBzid());
		}
		request.setAttribute("result", result);
		request.setAttribute("users", users);
		request.setAttribute("dpid", rjhmId);
		request.setAttribute("jcnum", request.getParameter("jcnum"));// 车号
		request.setAttribute("jcfix", jcfix);// 修程
		request.setAttribute("itemType", itemType);
		request.setAttribute("jctype", jcType);// 机车类型
		return "itemlist";
	}

	/**
	 * 分工详情列表
	 */
	@SuppressWarnings("unchecked")
	public String listDivision() {
		int type = Integer.parseInt(request.getParameter("type"));
		Long bzId = ((UsersPrivs) request.getSession().getAttribute("session_user")).getBzid();// ID
		int dpId = Integer.parseInt(request.getParameter("dpid"));// 日计划ID
		List result = null;
		if (type == 0) {// 检修项目（预设大类）
			result = workService.listJCDivision(dpId, bzId);
		} else if (type == 1) {// 临修加改（报活项目）
			result = workService.listJtPreDictByDivisionStatus(dpId, bzId);
		} else {// 秋整春鉴（秋整春鉴项目）
			result = workService.listJCQZFixRec(dpId, bzId);
		}
		request.setAttribute("result", result);
		request.setAttribute("type", type);
		return "division_list";
	}

	/**
	 * 保存派工
	 */
	public String saveDivision() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out = response.getWriter();
		try {
			String workersId = request.getParameter("workers");// 班组人员
			String presetId = request.getParameter("pdId");// 预设分类ID (或者报活记录ID
															// 或秋整春鉴项目ID)
			int dpId = Integer.parseInt(request.getParameter("dpid"));// 日计划ID
			String jcnum = request.getParameter("jcnum");// 车号
			String jcType = request.getParameter("jctype");// 车型
			int type = Integer.parseInt(request.getParameter("type"));// 0：机修
																		// 1：临修、加改
																		// 2、秋整、春鉴
			String[] ids = presetId.split(",");

			UsersPrivs leader = (UsersPrivs) request.getSession().getAttribute("session_user");
			if (type == 0) {// 机修
				workService.saveJCDivision(dpId, presetId, leader, workersId, jcnum, jcType);
			} else if (type == 1) {// 临修、加改
				for (int i = 0; i < ids.length; i++) {
					workService.updateJtPreDict(Integer.parseInt(ids[i]), workersId);
				}
			} else {// 秋整、春鉴
				for (int i = 0; i < ids.length; i++) {
					workService.saveJCQZFixRec(dpId, Integer.parseInt(ids[i]), workersId, leader.getBzid());
				}
			}
			out.write("success");
		} catch (Exception e) {
			out.write("failure");
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
		return null;
	}

	/**
	 * 取消分工
	 */
	public String deleteDivision() throws Exception {
		int divideId = Integer.parseInt(request.getParameter("dvid"));
		int type = Integer.parseInt(request.getParameter("type"));
		long result = 0;
		if (type == 0) {// 机修
			result = workService.deleteJCDivision(divideId);
		} else if (type == 1) {// 临修、加改
			result = workService.deleteJtPreDictDivision(divideId);
		} else {// 秋整、春鉴
			result = workService.deleteJCQZFixRec(Long.parseLong(request.getParameter("dvid")));
		}

		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out = response.getWriter();
		try {
			if (result == 0) {
				out.write("success");
			} else {
				out.write("already");
			}
		} catch (Exception e) {
			out.write("failure");
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
		return null;
	}

	/**
	 * 无活强制完成
	 */
	public String ajaxForceMake() throws Exception {
		try {
			UsersPrivs user = (UsersPrivs) ServletActionContext.getContext().getSession().get("session_user");
			Integer rjhmId = Integer.valueOf(request.getParameter("dpid"));
			planManageService.updateForcFinishJCFlow(rjhmId, user.getBzid(), Contains.XX_JX_NODEID);
			response.getWriter().print("success");
		} catch (Exception e) {
			e.printStackTrace();
			response.getWriter().print("failure");
		}
		return null;
	}

	/**
	 * 进入接活页面，查看待休机车
	 */
	@SuppressWarnings("unused")
	public String receivedWorkInput() throws Exception {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String projectType = request.getParameter("projectType");
		String jcNum = request.getParameter("jcNum");
		List<DatePlanPri> daprList = signWorkService.findDyPlanJCBy(jcNum, projectType);// 查询机修
		request.setAttribute("daprList", daprList);
		request.setAttribute("projectType", projectType);
		request.setAttribute("jcNum", jcNum);
		return "receive_work";
	}

	/**
	 * 进入查看项目页面
	 */
	public String listRatifyItemsInput() throws Exception {
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		DatePlanPri dateplan = queryService.findDatePlanPriById(rjhmId);
		request.setAttribute("rjhmId", rjhmId);
		request.setAttribute("dateplan", dateplan);
		request.setAttribute("xtype", getItemType(request.getParameter("xx")));
		
		return "worker_ratify";
	}

	/**
	 * 进入查看中修项目页面
	 */
	public String listZxRatifyItemsInput() throws Exception {
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		request.setAttribute("rjhmId", rjhmId);
		request.setAttribute("xtype", getItemType(request.getParameter("xx")));
		DatePlanPri datePlan = planManageService.findDatePlanPriById(rjhmId);
		int flowId = datePlan.getNodeid().getJcFlowId();
		if (flowId == Contains.ZX_SY_NODEID) {
			List<JcExperimentItem> experiments = experimentService.findJcExperimentsByFlowIdAndJcType(flowId,
					datePlan.getJcType());
			request.setAttribute("experiments", experiments);
			request.setAttribute("jcTypeNum", datePlan.getJcType() + "-" + datePlan.getJcnum());
			if (datePlan.getJcType().contains(Contains.JC_TYPE_OIL_PREFIX)) {// DF
				return "zx_df_experiment";
			} else if (datePlan.getJcType().contains(Contains.JC_TYPE_ELECTRIC_PREFIX)) {// SS
				return "zx_ss_experiment";
			} else {// 其他类型机车
				return "zx_no_experiment";
			}
		} else if (flowId == Contains.ZX_SYX_NODEID) {
			return "zx_tryrun";
		}
		return "zx_worker_ratify";
	}

	/**
	 * 小辅修
	 * 工人查看签认项目
	 */
	@SuppressWarnings("unchecked")
	public String listRatifyItems() throws Exception {
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		// 根据日计划ID查找日计划,签字页面报活
		String jctype = queryService.findDatePlanPriById(rjhmId).getJcType();
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");

		short itemType = Short.parseShort(request.getParameter("type"));// 0：检查项目
																		// 1：检测项目
		int xtype = Integer.parseInt(request.getParameter("xtype"));// 0：检修
																	// 1：临修、加改、整治
																	// 2：秋整、春鉴
		List itemList = null;
		List freeItemList = null;// 自选项目
		if (xtype == 0) {
			// itemList = workService.listMyJCFixRec(rjhmId,
			// user,itemType,true);
			freeItemList = workService.listMyJCFixRec(rjhmId, user, itemType, false);
			if (freeItemList != null && freeItemList.size() > 0) {
				request.setAttribute("freeItem", packFreeItemList(freeItemList, xtype));
				// request.setAttribute("freeItemList", freeItemList);
			}
		} else if (xtype == 1) {
			// itemList = jtPreDictService.listMyJtPreDict(rjhmId,
			// user,Contains.LX_JG_TYPE,true);
			// freeItemList =
			// jtPreDictService.listMyJtPreDict(rjhmId,user,Contains.LX_JG_TYPE,false);
			freeItemList = jtPreDictService.listMyJtPreDictNoPre(rjhmId, user, Contains.LX_JG_TYPE);
			request.setAttribute("freeItemList", freeItemList);
		} else {
			/**	
			freeItemList = jcqzFixService.listMyJCQZFixRec(rjhmId, user, itemType, false);
			
			if (freeItemList != null && freeItemList.size() > 0) {
				request.setAttribute("freeItem", packFreeItemList(freeItemList, xtype));
				request.setAttribute("freeItemList", freeItemList);
			}
			 * */

			freeItemList = workService.listMyJCFixRec(rjhmId, user, itemType, false);
			if (freeItemList != null && freeItemList.size() > 0) {
				request.setAttribute("freeItem", packFreeItemList(freeItemList, xtype));
				// request.setAttribute("freeItemList", freeItemList);
			}
			
		}
		// request.setAttribute("itemList", itemList);
		request.setAttribute("rjhmId", rjhmId);
		request.setAttribute("dateplan", planManageService.findDatePlanPriById(rjhmId));
		request.setAttribute("jctype", jctype);
		request.setAttribute("type", itemType);
		request.setAttribute("xtype", xtype);
		if (itemType == 0) {
			return "check_item";
		} else {
			return "test_item";
		}
	}

	/**
	 * 封装自选项目
	 */
	@SuppressWarnings("unchecked")
	private Map<String, List> packFreeItemList(List items, int xtype) {
		Map<String, List> itemMap = new LinkedHashMap<String, List>();
		String unit = null;
		// String preSetDevision = null;
		for (int i = 0; i < items.size(); i++) {
			if (xtype == 0) {
				// unit = ((JCFixrec)
				// items.get(i)).getFixitem().getSecUnitName();
				// 根据项目查询预设分工
				unit = presetDivisionService.findPresetRelateByFixitemId(
						((JCFixrec) items.get(i)).getFixitem().getThirdUnitId()).getClsName();

			} else {
//				unit = ((JCQZFixRec) items.get(i)).getItems().getItemName();
				unit = presetDivisionService.findPresetRelateByFixitemId(((JCFixrec) items.get(i)).getFixitem().getThirdUnitId()).getClsName();
			}
			if (itemMap.get(unit) == null) {
				itemMap.put(unit, new ArrayList());
			}
			itemMap.get(unit).add(items.get(i));
		}
		return itemMap;
	}

	/**
	 * 工人查看中修签认项目
	 */
	@SuppressWarnings("unchecked")
	public String listZxRatifyItems() throws Exception {
		int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));
		// 根据日计划ID查找日计划,签字页面报活
		String jctype = queryService.findDatePlanPriById(rjhmId).getJcType();
		// int
		// nodeId=queryService.findDatePlanPriById(rjhmId).getNodeid().getJcFlowId();
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");

		// 判断是否是探伤组
		int tsflag = 0;
		DictProTeam tsTeam = workService.findDictProTeamByPY(Contains.TSZ_PY);
		if (tsTeam != null && tsTeam.getProteamid().equals(user.getBzid())) {
			tsflag = 1;
		}
		request.setAttribute("tsflag", tsflag);

		short itemType = Short.parseShort(request.getParameter("type"));// 0：检查项目
																		// 1：检测项目
		int xtype = Integer.parseInt(request.getParameter("xtype"));// 0：检修
																	// 1：临修、加改
																	// 2：秋整、春鉴
		List itemList = null;
		List freeItemList = null;// 自选项目
		if (xtype == 0) {
			itemList = workService.listMyJCZxFixRec(rjhmId, user, itemType, true);
			freeItemList = workService.listMyJCZxFixRec(rjhmId, user, itemType, false);
			if (freeItemList != null && freeItemList.size() > 0) {
				request.setAttribute("freeItem", packZxFreeItemList(freeItemList, xtype));
			}
		}
		request.setAttribute("itemList", itemList);
		request.setAttribute("rjhmId", rjhmId);
		request.setAttribute("dateplan", planManageService.findDatePlanPriById(rjhmId));
		request.setAttribute("jctype", jctype);
		request.setAttribute("type", itemType);
		request.setAttribute("xtype", xtype);
		if (itemType == 0) {
			return "zx_check_item";
		} else {
			return "zx_test_item";
		}
	}

	/**
	 * 封装中修自选项目
	 */
	@SuppressWarnings("unchecked")
	private Map<String, List> packZxFreeItemList(List items, int xtype) {
		Map<String, List> itemMap = new LinkedHashMap<String, List>();
		String unit = null;
		JCZXFixRec zxFixRec = null;
		for (int i = 0; i < items.size(); i++) {
			if (xtype == 0) {
				// 根据项目查询预设分工
				zxFixRec = (JCZXFixRec) items.get(i);
				unit = presetDivisionService.findPresetRelateByZxFixitemId(zxFixRec.getItemId().getId(),
						zxFixRec.getJcType()).getClsName();
			} else {
				unit = ((JCQZFixRec) items.get(i)).getItems().getItemName();
			}
			if (itemMap.get(unit) == null) {
				itemMap.put(unit, new ArrayList());
			}
			itemMap.get(unit).add(items.get(i));
		}
		return itemMap;
	}

	public String workerRatifyInput() throws Exception {
		String role = request.getParameter("role");
		String type = request.getParameter("type");
		String qtype = request.getParameter("qtype");
		String xtype = request.getParameter("xtype");
		String ids = request.getParameter("ids");
		String rjhmid = request.getParameter("rjhmId");
		if (Integer.parseInt(type) == 1) {

			JCFixrec fixRec = this.workService.queryJCFixrecByID(new Long(Integer.valueOf(ids)));
			JCFixitem fixItem = this.workService.queryJCFixitemByID(fixRec.getFixitem().getThirdUnitId());
			request.setAttribute("itemUnit", fixItem.getUnit());
		}
		request.setAttribute("type", type);// 0：检查项目 1：检测项目
		request.setAttribute("qtype", qtype);// 0:非全签 1：全签
		request.setAttribute("xtype", xtype);// 0：检修 1：临修、加改 2：秋整、春鉴
		request.setAttribute("ids", ids);// 选择签字的ID
		request.setAttribute("rjhmId", rjhmid);// 日计划ID
		request.setAttribute("role", role);// 角色 worker：工人 foreman 工长
		return "ratify_dialog";
	}

	/**
	 * 中修
	 * 
	 * @return
	 * @throws Exception
	 */
	public String workerZxRatifyInput() throws Exception {
		String role = request.getParameter("role");
		String type = request.getParameter("type");
		String qtype = request.getParameter("qtype");
		String xtype = request.getParameter("xtype");
		String ids = request.getParameter("ids");
		String rjhmid = request.getParameter("rjhmId");
		if (Integer.parseInt(type) == 1) {

			JCZXFixRec zxFixRec = this.workService.queryJCZxFixrecByID(new Long(Integer.valueOf(ids)));
			JCZXFixItem zxFixItem = this.workService.queryJCZxFixitemByID(zxFixRec.getItemId().getId());
			request.setAttribute("itemUnit", zxFixItem.getUnit());
		}
		request.setAttribute("type", type);// 0：检查项目 1：检测项目
		request.setAttribute("qtype", qtype);// 0:非全签 1：全签
		request.setAttribute("xtype", xtype);// 0：检修 1：临修、加改 2：秋整、春鉴
		request.setAttribute("ids", ids);// 选择签字的ID
		request.setAttribute("rjhmId", rjhmid);// 日计划ID
		request.setAttribute("role", role);// 角色 worker：工人 foreman 工长
		return "zx_ratify_dialog";
	}

	/**
	 * 工人完工签认 1、判断用户是否是指定的检修人 2、判断检修人是否存在，若存在修改检修情况等信息，若不存在还需要修改检修人签名名字
	 * 3、若是检测项目，判断值是否在标准范围内
	 */
	@SuppressWarnings("unchecked")
	public String workerRatify() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out = response.getWriter();
		try {
			// String username = request.getParameter("username");
			// String password = request.getParameter("password");
			// String cardnum = request.getParameter("cardnum");

			short type = Short.parseShort(request.getParameter("type"));// 0：检查项目
																		// 1：检测项目
			int qtype = Integer.parseInt(request.getParameter("qtype"));// 0:非全签
																		// 1：全签
			int xtype = Integer.parseInt(request.getParameter("xtype"));// 0：检修
																		// 1：临修、加改
																		// 2：秋整、春鉴
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));// 日计划ID
			JSONObject itemJsonObj = null;
			String checkInfo = request.getParameter("checkInfo");
			if ("".equals(checkInfo) || null == checkInfo) {
				// 检测项目json字符串
				String itemString = request.getParameter("itemString");
				itemJsonObj = new JSONObject(itemString);
			}
			String ids = request.getParameter("ids");// 选择的记录ID字符串"-"隔开
			String result = "success";
			UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
			if (usersPrivs == null) {
				result = "login_failure";// 登陆错误
			} else {
				if (xtype == 0) {// 0：检修
					result = workService.updateJCFixRecOfWokerRatify(type, qtype, rjhmId, checkInfo, ids, usersPrivs,
							itemJsonObj);
				} else if (xtype == 1) {// 1：临修、加改
					result = jtPreDictService.updateJtPreDictOfWorkerRatify(qtype, rjhmId, checkInfo, ids, usersPrivs,
							Contains.LX_JG_TYPE);
				} else {// 2：秋整、春鉴
//					result = jcqzFixService.updateJCQZFixRecOfWorkerRatify(type, qtype, rjhmId, checkInfo, ids,
//							usersPrivs, itemJsonObj);
					/** 下列代码皆在 2015-10-13 编写。   */
					result = workService.updateJCFixRecOfWokerRatify(type, qtype, rjhmId, checkInfo, ids, usersPrivs,
							itemJsonObj);
					/** 由于秋整不需要工长签字，所以直接将记录状态设置为2（即工长已签字）*/
					JCFixrec jcFixrec = null;
					System.out.println(ids);
					List<String> idList=new ArrayList<String>();
					if(ids != null){
						String[] idArr=ids.split("-");
						for (String id : idArr) {
							idList.add(id);
						}
					}else{
						Iterator<String> it=itemJsonObj.keys();
						while (it.hasNext()) {
							idList.add(it.next());
						}
					}
					
					for (String id : idList) {
						jcFixrec = workService.getJCFixrecById(Long.parseLong(id));
						jcFixrec.setRecStas((short)2);
						workService.updateJCFixRec(jcFixrec);
					}
					/**   工人所有项目签字完毕，更改jcflowrec 节点*/
					Long count=qzService.countUnFinish(rjhmId, usersPrivs.getBzid());
					if(count == 0){
						
						JCFlowRec rec=qzService.findJCFlowRec(rjhmId, usersPrivs.getBzid());
						rec.setFinishStatus(1);
						rec.setFinishTime(new Date(System.currentTimeMillis()));
						qzService.updateJcFlowRec(rec);
					}
				}
			}
			JSONObject obj = new JSONObject();
			obj.put("result", result);
			obj.put("fixEmp", usersPrivs.getXm());
			obj.put("times", YMDHMS_SDFORMAT.format(new Date()));
			out.write(obj.toString());
		} catch (Exception e) {
			out.write("value_failure");
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
		return null;
	}

	/**
	 * 工人中修完工签认 1、判断用户是否是指定的检修人 2、判断检修人是否存在，若存在修改检修情况等信息，若不存在还需要修改检修人签名名字
	 * 3、若是检测项目，判断值是否在标准范围内
	 */
	@SuppressWarnings("unchecked")
	public String workerZxRatify() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out = response.getWriter();
		try {
			short type = Short.parseShort(request.getParameter("type"));// 0：检查项目
																		// 1：检测项目
			int qtype = Integer.parseInt(request.getParameter("qtype"));// 0:非全签
																		// 1：全签
			int xtype = Integer.parseInt(request.getParameter("xtype"));// 0：检修
																		// 1：临修、加改
																		// 2：秋整、春鉴
			int rjhmId = Integer.parseInt(request.getParameter("rjhmId"));// 日计划ID
			JSONObject itemJsonObj = null;
			String checkInfo = request.getParameter("checkInfo");
			if ("".equals(checkInfo) || null == checkInfo) {
				// 检测项目json字符串
				String itemString = request.getParameter("itemString");
				itemJsonObj = new JSONObject(itemString);
			}
			String ids = request.getParameter("ids");// 选择的记录ID字符串"-"隔开
			String result = "success";
			UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
			if (usersPrivs == null) {
				result = "login_failure";// 登陆错误
			} else {
				if (xtype == 0) {// 0：检修
					result = workService.updateJCZxFixRecOfWokerRatify(type, qtype, rjhmId, checkInfo, ids, usersPrivs,
							itemJsonObj);
				}
			}
			out.write(result);
		} catch (Exception e) {
			out.write("value_failure");
			e.printStackTrace();
		} finally {
			out.flush();
			out.close();
		}
		return null;
	}

	/**
	 * 判断修程修次 0：检修项目 1：临修、加改项目 2：秋整、春鉴项目
	 */
	private int getItemType(String jcfix) {
		int type = 0;
		String temp = jcfix.replaceAll("[0-9]", "");
		if (Contains.PY_LX.equalsIgnoreCase(temp) || Contains.PY_JG.equalsIgnoreCase(temp)
				|| Contains.PY_ZZ.equalsIgnoreCase(temp)) {
			type = 1;
		} else if (Contains.PY_QZ.equalsIgnoreCase(temp) || Contains.PY_CJ.equalsIgnoreCase(temp)) {
			type = 2;
		}
		return type;
	}

	/**
	 * 根据机车型号判断机车内型
	 */
	private String getJcsType(String jctype) {
		String temp = jctype.trim().toUpperCase().substring(0, 2);
		if ("DF".equals(temp)) {
			return "内燃机车";
		} else if ("SS".equals(temp)) {
			return "电力机车";
		} else {
			return "和谐机车";
		}
	}

	/**
	 * 进入填写配件信息页面
	 * 
	 * @return
	 */
	public String pjNumInput() {
		//将静态配件id设置成锚点标示，保存在session里
		request.getSession().setAttribute("zx_status_flag", request.getParameter("stdPjId"));
		
		long zxRecId = Long.parseLong(request.getParameter("zxRecId"));
		JCZXFixRec zxFixRec = workService.findJCZXFixRec(zxRecId);
		Integer amount = zxFixRec.getItemId().getAmount();
		if (null != amount) {
			request.setAttribute("amount", amount);
		}
		request.setAttribute("zxRecId", zxRecId);
		request.setAttribute("type", request.getParameter("type"));// 1:检查项目
																	// 2：检测项目
		request.setAttribute("stdPjId", request.getParameter("stdPjId"));// 静态配件ID
		request.setAttribute("planId", request.getParameter("planId"));// 日计划ID
		return "pjNumInput";
	}

	public String pjNumUpdateInput() {
		//将静态配件id设置成锚点标示，保存在session里
		request.getSession().setAttribute("zx_status_flag", request.getParameter("stdPjId"));
		
		String upPJNum = request.getParameter("upPJNum");
		String[] upPjNumArray = upPJNum.split(",");
		long zxRecId = Long.parseLong(request.getParameter("zxRecId"));
		JCZXFixRec zxFixRec = workService.findJCZXFixRec(zxRecId);
		Integer amount = zxFixRec.getItemId().getAmount();
		if (null != amount) {
			request.setAttribute("amount", amount);
		}
		request.setAttribute("zxRecId", zxRecId);
		request.setAttribute("upPjNumArray", upPjNumArray);
		request.setAttribute("type", request.getParameter("type"));// 1:检查项目
																	// 2：检测项目
		request.setAttribute("stdPjId", request.getParameter("stdPjId"));// 静态配件ID
		request.setAttribute("planId", request.getParameter("planId"));// 日计划ID
		return "pjNumUpdateInput";
	}

	/**
	 * 保存配件编号信息
	 * 
	 * @return
	 */
	public String savePjNum() {
		try {
			response.setContentType("text/html; charset=GBK");
			PrintWriter out = response.getWriter();
			long zxRecId = Long.parseLong(request.getParameter("zxRecId"));
			PJDynamicInfo pJDynamicInfo = null;
			PJFixRecord pJFixRecord = null;
			String pjNums = request.getParameter("pjNum");
			String pjNumsOld = request.getParameter("pjNumsOld");
			String[] pjNumsOldArray = null;
			JCZXFixRec zxFixRec = workService.queryJCZxFixrecByID(zxRecId);
			String[] pjNumArray = pjNums.split(",");
			String result = "success";
			DatePlanPri datePlanPri = null;
			for (int i = 0; i < pjNumArray.length; i++) {
				if ("未启用".equals(pjNumArray[i])) {
					continue;
				} else {
					Long existPjNum = workService.countPjInfoByPjNum(pjNumArray[i]);// 查找动态配件信息表中是否存在该配件编号
					if (existPjNum != null && existPjNum == 0) {// 配件编号不存在
						result = "noexist-" + i;
						break;
					}
				}
			}
			if (result.equals("success")) {
				if (!"".equals(pjNumsOld) && null != pjNumsOld) {
					pjNumsOldArray = pjNumsOld.split(",");
					for (int i = 0; i < pjNumsOldArray.length; i++) {
						if ("未启用".equals(pjNumsOldArray[i])) {
							continue;
						} else {
							pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumsOldArray[i]);
							pJFixRecord = workService.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
							if (null != pJFixRecord) {
								pJFixRecord.setRjhmId(null);
								workService.saveOrUpdatePJFixRecord(pJFixRecord);
							}
							pJDynamicInfo.setGetOnNum(null);
							pJDynamicInfo.setStorePosition(0);
							workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
						}
					}
				}
				for (int i = 0; i < pjNumArray.length; i++) {
					if ("未启用".equals(pjNumArray[i])) {
						continue;
					} else {
						pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumArray[i]);
						pJFixRecord = workService.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
						datePlanPri = zxFixRec.getDyPrecId();
						if (null != pJFixRecord) {
							pJFixRecord.setRjhmId(datePlanPri.getRjhmId());
							workService.saveOrUpdatePJFixRecord(pJFixRecord);
						}
						pJDynamicInfo.setGetOnNum(datePlanPri.getJcType() + "-" + datePlanPri.getJcnum());
						pJDynamicInfo.setStorePosition(2);
						workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
					}
				}
				if (zxFixRec.getNodeId().intValue() == Contains.ZX_FG_NODEID) {// 分解节点设置下车编号
					zxFixRec.setDownPjNum(pjNums);
				} else if (zxFixRec.getNodeId().intValue() == Contains.ZX_CSZZ_NODEID) {// 组装试验节点设置上车编号
					zxFixRec.setUpPjNum(pjNums);
				}
				workService.saveOrUpdateJCZXFixRec(zxFixRec);
			}
			out.write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 保存配件编号信息
	 * 
	 * @return
	 */
	public String saveXXPjNum() {
		try {
			response.setContentType("text/html; charset=GBK");
			PrintWriter out = response.getWriter();
			int planId = Integer.parseInt(request.getParameter("planId"));
			int xtype = Integer.parseInt(request.getParameter("xtype"));
			PJDynamicInfo pJDynamicInfo = null;
			PJFixRecord pJFixRecord = null;
			String pjNums = request.getParameter("pjNum");
			String pjNumsOld = request.getParameter("pjNumsOld");
			String[] pjNumsOldArray = null;
			String[] pjNumArray = pjNums.split(",");
			String result = "success";
			DatePlanPri datePlanPri = planManageService.findDatePlanPriById(planId);
			for (int i = 0; i < pjNumArray.length; i++) {
				if ("未启用".equals(pjNumArray[i])) {
					continue;
				} else {
					Long existPjNum = workService.countPjInfoByPjNum(pjNumArray[i]);// 查找动态配件信息表中是否存在该配件编号
					if (existPjNum != null && existPjNum == 0) {// 配件编号不存在
						result = "noexist-" + i;
						break;
					}
				}
			}
			if (result.equals("success")) {
				if (!"".equals(pjNumsOld) && null != pjNumsOld) {
					pjNumsOldArray = pjNumsOld.split(",");
					for (int i = 0; i < pjNumsOldArray.length; i++) {
						if ("未启用".equals(pjNumsOldArray[i])) {
							continue;
						} else {
							//以下两条语句矛盾，有问题。
							pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumsOldArray[i]);
							pJFixRecord = workService.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
							
							if (null != pJFixRecord) {
								pJFixRecord.setRjhmId(null);
								workService.saveOrUpdatePJFixRecord(pJFixRecord);
							}
							pJDynamicInfo.setGetOnNum(null);
							pJDynamicInfo.setStorePosition(0);
							workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
						}
					}
				}
				for (int i = 0; i < pjNumArray.length; i++) {
					if ("未启用".equals(pjNumArray[i])) {
						continue;
					} else {
						pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumArray[i]);
						pJFixRecord = workService.findPJFixRecordByPjDid(pJDynamicInfo.getPjdid());
						if (null != pJFixRecord) {
							pJFixRecord.setRjhmId(datePlanPri.getRjhmId());
							workService.saveOrUpdatePJFixRecord(pJFixRecord);
						}
						pJDynamicInfo.setGetOnNum(datePlanPri.getJcType() + "-" + datePlanPri.getJcnum());
						pJDynamicInfo.setStorePosition(2);
						workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
					}
				}
				switch (xtype) {
				case 0:// 小辅修
					JCFixrec jcFixrec = workService.queryJCFixrecByID(Long.parseLong(request.getParameter("recId")));
					jcFixrec.setUpPjNum(pjNums);
					workService.updateJCFixRec(jcFixrec);
					break;
				case 1:// 临修
					JtPreDict jtPreDict = jtPreDictService.findJtPreDictById(Integer.parseInt(request
							.getParameter("recId")));
					jtPreDict.setUpPjNum(pjNums);
					jtPreDictService.saveOrUpdateJtPreDict(jtPreDict);
					break;
				case 2:// 秋整
					JCQZFixRec jcqzFixRec = jcqzFixService.getJCQZFixRec(Long.parseLong(request.getParameter("recId")));
					jcqzFixRec.setUpPjNum(pjNums);
					jcqzFixService.updateJCQZFixRec(jcqzFixRec);
					break;
				}
			}
			out.write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 * 选择动态配件信息
	 * //planId=${planId}&type=update
	 * @return
	 * @throws UnsupportedEncodingException
	 */
	public String choiceDyPjInfo() throws UnsupportedEncodingException {
		String pjName = request.getParameter("pjName");
		String pjNum = request.getParameter("pjNum");
		String urlName = request.getParameter("urlName");
		String stdpjid = request.getParameter("stdPjId");
		String type = request.getParameter("type");
		String planId = request.getParameter("planId");
		
		DatePlanPri datePlan = null;
		String jcType = null;
		if (null != planId) {
			datePlan = planManageService.findDatePlanPriById(Integer.parseInt(planId));
			jcType = datePlan.getJcType();
		}
		if (pjNum != null && !"".equals(pjNum)) {
			pjNum = pjNum.trim();
		}
		if (pjName != null && !"".equals(pjName)) {
			pjName = URLDecoder.decode(pjName, "UTF-8").trim();// 十六制转为中文
			urlName = URLEncoder.encode(pjName, "UTF-8").trim();// 中文转为十六制编码
		} else {
			if (stdpjid != null && !"".equals(stdpjid)) {
				try {
					pjName = workService.findPJStaticInfoById(Long.parseLong(stdpjid)).getPjName();
					urlName = URLEncoder.encode(pjName, "UTF-8");// 中文转为十六制编码
				} catch (Exception e) {
					pjName = null;
				}
			}
		}
		
		request.setAttribute("pm", workService.findPJDynamicInfo(type, pjName, pjNum, jcType));
		request.setAttribute("pjName", pjName);
		request.setAttribute("urlName", urlName);
		request.setAttribute("pjNum", pjNum);
		request.setAttribute("stdpjid", stdpjid);
		request.setAttribute("planId", planId);
		request.setAttribute("type", type);
		if ("add".equals(type)) {
			return "choicedypj";
		//2015-5-22，黄亮，添加新页面， 报活流程中，返回选择配件页面
		}else if("reportPJ".equals(type)){
			return "choiceDypjUpdateReport";
		}else {
			return "choicedypjupdate";
		}

	}

	/**
	 * 查询配件的检修记录
	 * 
	 * @return
	 */
	public String findPJRecorder() {
		Long pjId = Long.parseLong(request.getParameter("pjId"));
		request.setAttribute("pjDy", workService.findPJDynamicInfoById(pjId));
		request.setAttribute("pjRecs", workService.findPJFixRecord(pjId));
		return "pjRecorder";
	}

	/**
	 * 查看配件详细信息
	 * 
	 * @return
	 */
	public String findPjDetailRecorder() {
		Long pjId = Long.parseLong(request.getParameter("pjId"));
		Long planId = null;
		request.setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		request.setAttribute("pjDy", workService.findPJDynamicInfoById(pjId));
		request.setAttribute("pjDetailRecs", workService.findPJFixRecord(pjId, planId));
		return "pjDetailRecorder";
	}

	/**
	 * 统计班组报活
	 * 
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String countBZJtPreDict() throws Exception {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String roles = user.getRoles();
		JSONArray array = new JSONArray();
		List list = jtPreDictService.countUnfinishJtPreDict(user.getBzid(), user.getRoles());
		JSONObject jsonObject = null;
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			jsonObject = new JSONObject();
			jsonObject.accumulate("jctype", obj[0]);
			jsonObject.accumulate("jcnum", obj[1]);
			jsonObject.accumulate("rjhmId", obj[2]);
			jsonObject.accumulate("xx", obj[3]);
			jsonObject.accumulate("projectType", obj[4]);
			jsonObject.accumulate("count", obj[5]);
			array.put(jsonObject);
		}
		response.setContentType("text/plain");
		response.getWriter().print(array.toString());
		return null;
	}

	/**
	 * 统计交车工长未签认完成信息
	 * 
	 * @return
	 * @throws JSONException
	 * @throws IOException
	 */
	public String countJCGZUnSigned() throws Exception {
		List list = jtPreDictService.countJCGZUnSigned();
		JSONArray array = new JSONArray();
		JSONObject jsonObject = null;
		for (int i = 0; i < list.size(); i++) {
			Object[] obj = (Object[]) list.get(i);
			jsonObject = new JSONObject();
			jsonObject.accumulate("jctype", obj[0]);
			jsonObject.accumulate("jcnum", obj[1]);
			jsonObject.accumulate("rjhmId", obj[2]);
			jsonObject.accumulate("xx", obj[3]);
			jsonObject.accumulate("projectType", obj[4]);
			jsonObject.accumulate("unfinishReportCount", obj[5]);
			jsonObject.accumulate("unsignedJCRecCount", obj[6]);
			jsonObject.accumulate("unsignedJCZXRecCount", obj[7]);
			array.put(jsonObject);
		}
		response.setContentType("text/plain");
		response.getWriter().print(array.toString());
		return null;
	}

	/**
	 * 交车项目初始化
	 */
	public String finishItemInput() {
		HttpServletRequest request = ServletActionContext.getRequest();
		UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
		String result = "";
		String rjhmId = request.getParameter("rjhmId");
		Map<String, List<YSJCRec>> itemListMap = null;
		List<YSJCRec> ySJCRecListGR = null;
		List<YSJCRec> ySJCRecList = null;
		// 查询交车记录表是否有记录
		Long count = ysjcRecService.countYSJCRec(Integer.valueOf(rjhmId));
		if (count <= 0) {
			// 如果记录表不存在 生成记录
			ysjcRecService.addYSJCRec(Integer.valueOf(rjhmId));
		}
//		// 查询记录
//		ySJCRecList = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId),usersPrivs.getBzid());
//		// 封装成以classify为键的Map
//		itemListMap = packJcItemList(ySJCRecList);
//		request.setAttribute("itemListMap", itemListMap);
		request.setAttribute("rjhmId", rjhmId);

		if (usersPrivs.getRoles().equals(",GR,") || usersPrivs.getRoles().equals(",GZ,")) {
			// 查询记录
			ySJCRecListGR = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId),usersPrivs.getBzid());
			// 封装成以classify为键的Map
			itemListMap = packJcItemList(ySJCRecListGR);
			request.setAttribute("itemListMap", itemListMap);
			
			// 工人工长
			result = "jcitemList";
		} else if (usersPrivs.getRoles().equals(",ZJY,") || usersPrivs.getRoles().equals(",JSY,")) {
			// 查询记录
			ySJCRecList = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId));
			// 封装成以classify为键的Map
			itemListMap = packJcItemList(ySJCRecList);
			request.setAttribute("itemListMap", itemListMap);
			
			// 质检技术
			result = "jcitemzjjsList";
		} else if (usersPrivs.getRoles().equals(",YSY,")) {
			// 查询记录
			ySJCRecList = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId));
			// 封装成以classify为键的Map
			itemListMap = packJcItemList(ySJCRecList);
			request.setAttribute("itemListMap", itemListMap);
			
			// 验收员
			result = "jcitemysList";
		}
		return result;
	}

	/**
	 * 封装交车项目 1.将交车项目按classify分类打包
	 */
	@SuppressWarnings("unchecked")
	private Map<String, List<YSJCRec>> packJcItemList(List<YSJCRec> itemList) {
		Map<String, List<YSJCRec>> itemListMap = new LinkedHashMap<String, List<YSJCRec>>();
		String classify = null;
		for (int i = 0; i < itemList.size(); i++) {
			classify = itemList.get(i).getClassify();
			if (itemListMap.get(classify) == null) {
				itemListMap.put(classify, new ArrayList());
			}
			itemListMap.get(classify).add(itemList.get(i));
		}
		return itemListMap;
	}

	/**
	 * 交车项目 签认
	 */
	@SuppressWarnings("unchecked")
	public String finishItemSign() throws Exception {
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
		String rjhmId = request.getParameter("rjhmId");
		String itemString = request.getParameter("itemString");
		JSONObject itemJsonObj = new JSONObject(itemString);
		List<Integer> recIdList = new ArrayList();
		try {
			// 更新交车项目记录
			if (usersPrivs.getRoles().equals(",GR,") || usersPrivs.getRoles().equals(",GZ,")) {
				// 工人工长
				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					String id = itemIter.next();
					YSJCRec ySJCRec = ysjcRecService.getYSJCRecById(Integer.valueOf(id));
					ySJCRec.setFixSituation((String) itemJsonObj.get(id));
					ySJCRec.setFixemp(usersPrivs.getXm());
					ySJCRec.setFixEmpTime(YMDHMS_SDFORMAT.format(new Date()));
					ysjcRecService.updateYSJCRec(ySJCRec);
				}
			} else if (usersPrivs.getRoles().equals(",ZJY,") || usersPrivs.getRoles().equals(",JSY,")) {
				// 质检技术
				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					recIdList.add(Integer.valueOf(itemIter.next()));
				}
				ysjcRecService.updateSign(recIdList, 1, usersPrivs.getXm(), 0, Integer.valueOf(rjhmId));

			} else if (usersPrivs.getRoles().equals(",YSY,")) {
				// 验收员

				for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
					recIdList.add(Integer.valueOf(itemIter.next()));
				}
				ysjcRecService.updateSign(recIdList, 2, usersPrivs.getXm(), 0, Integer.valueOf(rjhmId));
			}
			out.write("success");
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}

	/**
	 * 判断工人是否签认完全
	 */
	public String isFinishWorker() throws Exception {
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		String rjhmId = request.getParameter("rjhmId");
		// 查询记录
		List<YSJCRec> ySJCRecList = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId));
		for (YSJCRec ysjcRec : ySJCRecList) {
			String fixEmp = ysjcRec.getFixemp();
			String fixEmpTime = ysjcRec.getFixEmpTime();
			if (null == fixEmp && null == fixEmpTime) {
				out.write("failure");
			}
		}
		return null;
	}

	/**
	 * 交车项目 签认(怀化)
	 */
	@SuppressWarnings("unchecked")
	public String finishItemSignHuaihua() throws Exception {
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		UsersPrivs usersPrivs = (UsersPrivs) request.getSession().getAttribute("session_user");
		String itemString = request.getParameter("itemString");
		JSONObject itemJsonObj = new JSONObject(itemString);
		try {
			// 更新交车项目记录
			for (Iterator<String> itemIter = itemJsonObj.keys(); itemIter.hasNext();) {
				String id = itemIter.next();
				YSJCRec ySJCRec = ysjcRecService.getYSJCRecById(Integer.valueOf(id));
				ySJCRec.setFixSituation((String) itemJsonObj.get(id));
				ySJCRec.setFixemp(usersPrivs.getXm());
				ySJCRec.setFixEmpTime(YMDHMS_SDFORMAT.format(new Date()));
				ysjcRecService.updateYSJCRec(ySJCRec);
			}
			out.write("success");
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}

	/**
	 * 探伤裂损情况
	 */
	public String dealSituationRatify() throws Exception {
		Long id = Long.parseLong(request.getParameter("id"));
		String deal = request.getParameter("deal");
		workService.updateJCFixRecOfDealSituation(id, deal);
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		try {
			out.write("success");
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}

	/**
	 * 复探签字
	 */
	public String reptJCFixRecSign() throws Exception {
		PrintWriter out = null;
		response.setContentType("text/html; charset=GBK");
		out = response.getWriter();
		String ids = request.getParameter("ids");
		if (ids != null) {
			String[] idsArr = ids.split("-");
			List<Long> idList = new ArrayList<Long>();
			for (String temp : idsArr) {
				idList.add(Long.parseLong(temp));
			}
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			try {
				workService.updateReptSign(idList, user, YMDHMS_SDFORMAT.format(new Date()), 1);
			} catch (Exception e) {
				out.write("复探签字失败！");
				e.printStackTrace();
			} finally {
				out.flush();
				out.close();
			}
		}
		return null;
	}

	/**
	 * 取消小辅修项目签认
	 * 
	 * @return
	 * @throws IOException
	 */
	public String cancelSign() throws IOException {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Long jcRecId = Long.parseLong(request.getParameter("jcRecId"));
		JCFixrec jcFixRec = workService.queryJCFixrecByID(jcRecId);
		String fixEmp = jcFixRec.getFixEmp();
		String result = "success";
		if (fixEmp != null && !"".equals(fixEmp)) {
			String[] arry = fixEmp.split(",");// ,123,----,123,456,
			if (fixEmp.contains(user.getXm())) {
				if (arry.length == 2) {// 表示只有一个人签认
					jcFixRec.setFixEmp(null);
					jcFixRec.setFixSituation(null);
					jcFixRec.setRecStas((short) 0);
					jcFixRec.setEmpAfformTime(null);
					workService.updateJCFixRec(jcFixRec);
				} else {// 多人签认
					fixEmp = fixEmp.replace(user.getXm() + ",", "");
					jcFixRec.setFixEmp(fixEmp);
					workService.updateJCFixRec(jcFixRec);
				}
			} else {
				result = "no_user";
			}
		}
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		try {
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}

	/**
	 * 取消中修项目签认
	 * 
	 * @return
	 * @throws IOException
	 */
	public String cancelZXSign() throws IOException {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Long jcRecId = Long.parseLong(request.getParameter("jcRecId"));
		JCZXFixRec jcFixRec = workService.queryJCZxFixrecByID(jcRecId);
		String fixEmp = jcFixRec.getFixEmp();
		String result = "success";
		if (fixEmp != null && !"".equals(fixEmp)) {
			String[] arry = fixEmp.split(",");// ,123,----,123,456,
			if (fixEmp.contains(user.getXm())) {
				if (arry.length == 2) {// 表示只有一个人签认
					jcFixRec.setFixEmp(null);
					jcFixRec.setFixSituation(null);
					jcFixRec.setRecStas((short) 0);
					jcFixRec.setFixEmpTime(null);
					workService.saveOrUpdateJCZXFixRec(jcFixRec);
				} else {// 多人签认
					fixEmp = fixEmp.replace(user.getXm() + ",", "");
					jcFixRec.setFixEmp(fixEmp);
					workService.saveOrUpdateJCZXFixRec(jcFixRec);
				}
			} else {
				result = "no_user";
			}
		}
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		try {
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}
	/**
	 * 取消中修项目复探签认
	 * 唐倩 2015-6-29
	 * @return
	 * @throws IOException
	 */
	public String cancelZXReptSign() throws IOException {
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Long jcRecId = Long.parseLong(request.getParameter("jcRecId"));
		JCZXFixRec jcFixRec = workService.queryJCZxFixrecByID(jcRecId);
		String rept = jcFixRec.getRept();
		String result = "success";
		if (rept != null && !"".equals(rept)) {
			jcFixRec.setRept(null);
			jcFixRec.setReptAffirmTime(null);
			workService.saveOrUpdateJCZXFixRec(jcFixRec);
		}
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		try {
			out.write(result);
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		} finally {
			if (null != out) {
				out.close();
			}
		}
		return null;
	}
	/**
	 * 禁用中修组装项目
	 * 
	 * @return
	 */
	public String ajaxEnableZxFixItem() {
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recId = request.getParameter("recId");
			JCZXFixRec zxFixRecord = workService.findZxFixRecordById(Long.parseLong(recId));
			zxFixRecord.setFixEmpTime(YMDHMS_SDFORMAT.format(new Date()));
			zxFixRecord.setFixEmp(dealString(zxFixRecord.getFixEmp(), user.getXm()));
			zxFixRecord.setFixSituation("未启用");
			zxFixRecord.setRecStas((short) 1);
			workService.saveOrUpdateJCZXFixRec(zxFixRecord);
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		} finally {
			if (pw != null) {
				pw.write(result);
				pw.close();
			}
		}
		return result;
	}
	/**
	 * 一键禁用中修组装项目
	 * 唐倩 2015-6-24 增加一键禁用功能
	 * @return
	 */
	public String ajaxEnableZxFixItems() {
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recIds = request.getParameter("recIds");
			if (recIds != null) {
				String[] recIdsArr = recIds.split("-");
				for (String temp : recIdsArr) {
					JCZXFixRec zxFixRecord = workService.findZxFixRecordById(Long.parseLong(temp));
					zxFixRecord.setFixEmpTime(YMDHMS_SDFORMAT.format(new Date()));
					zxFixRecord.setFixEmp(dealString(zxFixRecord.getFixEmp(), user.getXm()));
					zxFixRecord.setFixSituation("未启用");
					zxFixRecord.setRecStas((short) 1);
					workService.saveOrUpdateJCZXFixRec(zxFixRecord);
				}
				
			}
			
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		} finally {
			if (pw != null) {
				pw.write(result);
				pw.close();
			}
		}
		return result;
	}
	/**
	 * 中修检测项目启用、禁用操作
	 * 唐倩 2015-6-24 增加一键禁用功能
	 * @return
	 */
	public String ajaxZxFixTesItems() {
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recIds = request.getParameter("recIds");
			Long flag = Long.parseLong(request.getParameter("flag"));
			if (recIds != null) {
				String[] recIdsArr = recIds.split("-");
				for (String temp : recIdsArr) {
					JCZXFixRec zxFixRecord = workService.findZxFixRecordById(Long.parseLong(temp));
					zxFixRecord.setFixEmpTime(YMDHMS_SDFORMAT.format(new Date()));
					zxFixRecord.setFixEmp(dealString(zxFixRecord.getFixEmp(), user.getXm()));
					zxFixRecord.setRecStas((short) 1);
					if(flag == 0){//启用中修项目
						if("未启用".equals(zxFixRecord.getFixSituation()))
							zxFixRecord.setFixSituation("");
					}else{//禁用中修项目
						zxFixRecord.setFixSituation("未启用");
					}
					workService.saveOrUpdateJCZXFixRec(zxFixRecord);
				}
				
			}
			
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		} finally {
			if (pw != null) {
				pw.write(result);
				pw.close();
			}
		}
		return result;
	}
	/**
	 * 禁用和启用小辅修项目
	 * 唐倩 2015-6-26
	 * @return
	 */
	public String ajaxEnableFixItems() {
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recIds = request.getParameter("recIds");
			Long flag = Long.parseLong(request.getParameter("flag"));
			if (recIds != null) {
				String[] recIdsArr = recIds.split("-");
				for (String temp : recIdsArr) {
					JCFixrec fixRecord = workService.queryJCFixrecByID(Long.parseLong(temp));
					fixRecord.setEmpAfformTime(YMDHMS_SDFORMAT.format(new Date()));
					fixRecord.setFixEmp(dealString(fixRecord.getFixEmp(), user.getXm()));
					fixRecord.setRecStas((short) 1);
					if(flag == 0){//启用小辅修项目
						fixRecord.setFixSituation("");
					}else{//禁用小辅修项目
						fixRecord.setFixSituation("未启用");
					}
					workService.updateJCFixRec(fixRecord);
				}
				
			}
			
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		} finally {
			if (pw != null) {
				pw.write(result);
				pw.close();
			}
		}
		return result;
	}

	/**
	 * 去除重复字符串
	 */
	private String dealString(String oldStr, String subStr) {
		String result = "";
		if (oldStr == null || "".equals(oldStr)) {
			result = "," + subStr + ",";
		} else {
			if (oldStr.indexOf("," + subStr + ",") >= 0) {
				result = oldStr;
			} else {
				result = oldStr + subStr + ",";
			}
		}
		return result;
	}

}
