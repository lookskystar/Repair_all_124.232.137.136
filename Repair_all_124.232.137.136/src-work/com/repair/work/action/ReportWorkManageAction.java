package com.repair.work.action;

import static com.repair.common.util.WebUtil.dateConvertString;
import static com.repair.common.util.WebUtil.fileUpload;
import static com.repair.common.util.WebUtil.getSessionUsersPrivs;
import static com.repair.common.util.WebUtil.isEmpty;
import static com.repair.common.util.WebUtil.isUser;

import java.io.File;
import java.io.IOException;
import java.io.PrintWriter;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.io.FileUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.CometUtil;
import com.repair.common.util.ImageZipUtil;
import com.repair.common.util.Page;
import com.repair.plan.action.BaseAction;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.plan.service.PlanManageService;
import com.repair.plan.vo.Dispatch;
import com.repair.query.service.QueryService;
import com.repair.work.service.JtPreDictService;
import com.repair.work.service.SignWorkService;
import com.repair.work.service.UsersPrivsService;
//import com.sun.security.auth.UserPrincipal;

/**
 * 报活管理控制
 * @author zx
 *
 */
public class ReportWorkManageAction extends BaseAction{

	private static final long serialVersionUID = -8883526397215488541L;
	
	@Resource(name = "planManageService")
	private PlanManageService planManageService;
	@Resource(name = "pdiFroemanManageService")
	private PdiFroemanManageService pdiFroemanManageService;
	@Resource(name = "jtPreDictService")
	private JtPreDictService jtPreDictService;
	@Resource(name = "usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name = "signWorkService")
	private SignWorkService signWorkService;
	@Resource(name="queryService")
	private QueryService queryService;
	
	private JtPreDict preDict;
	private Dispatch dispatch;
	private DictFailure dictFailure;
	
	private String id;
	private String type;
	private File image;
	private String imageFileName;
	private String savePath;
	private String params;
	private String userName;
	private String password;
	private String dealSituation;
	private String cardNum;
	private String role;
	//签认接活标志 1签认 2接活
	private int flag; 
	//Ajax获取图片文件,与控件type=File中的name属性一样  
	private File fileMaterial;
	//Ajax获取图片文件名称,相应的name属性名称+FileName  
	private String fileMaterialFileName;

	/**
	 * 报活操作
	 * @return
	 */
	public String reportWork() {
		request.put("datePlanPris", planManageService.findDatePlanPriByStatus(3));
		UsersPrivs user = (UsersPrivs) ServletActionContext.getRequest().getSession().getAttribute("session_user");
		if (!isEmpty(id)) {
			List<JtPreDict> jtPreDicts = jtPreDictService.findMyReportJtPreDict(Integer.parseInt(id),user.getGonghao());
			request.put("jtPreDicts", jtPreDicts);
		}
		return "reportwork";
	}
	
	/**
	 * 通过Ajax获得一级部件下的二级部件信息
	 * @return
	 * @throws JSONException 
	 */
	public String ajaxGetDictSecunit() throws JSONException{
		int type = Integer.parseInt(ServletActionContext.getRequest().getParameter("type"));
		String first = ServletActionContext.getRequest().getParameter("first");
		String second = ServletActionContext.getRequest().getParameter("second");
		String third = ServletActionContext.getRequest().getParameter("third");
		List<String> unitNames = new ArrayList<String>();
		List<DictFailure> failures = new ArrayList<DictFailure>();
		if(type==0){
			unitNames = jtPreDictService.listSecUnitNameOfDictFailure(first);
			failures = jtPreDictService.listDictFailure(first, null, null);
		}else if(type==1){
			unitNames = jtPreDictService.listThirdUnitNameOfDictFailure(first,second);
			failures = jtPreDictService.listDictFailure(first, second, null);
		}else{
			failures = jtPreDictService.listDictFailure(first, second, third);
		}
		JSONObject map = new JSONObject();
		JSONObject obj=null;
		JSONArray array=new JSONArray();
		for(String ds: unitNames){
			obj=new JSONObject();
			obj.put("unitName", ds);
			array.put(obj);
		}
		map.put("unit", array);
		array=new JSONArray();
		for (DictFailure failure : failures) {
			obj=new JSONObject();
			obj.put("content", failure.getContent());
			obj.put("score", failure.getScore());
			array.put(obj);
		}
		map.put("failure", array);
		ServletActionContext.getResponse().setContentType("plain/text");
		try {
			ServletActionContext.getResponse().getWriter().print(map.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 通过班组ID得到班组下的预设分工类信息
	 * @return
	 * @throws JSONException 
	 */
	public String ajaxGetDivision() throws JSONException{
		long proTeamId=Long.parseLong(ServletActionContext.getRequest().getParameter("proTeamId"));
		String jcType=ServletActionContext.getRequest().getParameter("jcType");
		List<PresetDivision> presetDivisions=jtPreDictService.listPresetDivision(proTeamId, jcType);
		JSONObject map = new JSONObject();
		JSONObject obj=null;
		JSONArray array=new JSONArray();
		for(PresetDivision division:presetDivisions){
			obj=new JSONObject();
			obj.put("divisionId", division.getProSetId());
			obj.put("divisionName", division.getClsName());
			array.put(obj);
		}
		map.put("division", array);
		ServletActionContext.getResponse().setContentType("plain/text");
		try {
			ServletActionContext.getResponse().getWriter().print(map.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 报活输入
	 * @return
	 */
	public String jtPreDictInput() {
		request.put("dictProTeams", pdiFroemanManageService.findWorkDictProTeam());
		String rjhmId = (String) request.get("id");
		if (!isEmpty(type)) {
			request.put("dictFirstUnits", jtPreDictService.listFirstUnitNameOfDictFailure());
			request.put("rjhmId", rjhmId);
//			request.put("dictSecUnits", jtPreDictService.listSecUnitNameOfDictFailure(null));
		}
		//工人、交车工长、段长报活提交的target不同
		request.put("roleType", ServletActionContext.getRequest().getParameter("roleType"));
		return "jtpredictinput";
	}
	
	/**
	 * 报活确认
	 * @return
	 * @throws Exception 
	 */
	public String jtPreDictConfirm() throws Exception {
		//REQUEST、RESPONSE、WRITE
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		PrintWriter out = response.getWriter();
		//日计划ID
		String rjhmId = request.getParameter("rjhmId");
		DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.valueOf(rjhmId));
		//保存报活
		JtPreDict preDict = new JtPreDict();
		//日计划
		preDict.setDatePlanPri(datePlanPri);
		//报活日期
		preDict.setRepTime(dateConvertString(new Date()));
		//机车类型
		preDict.setJcType(datePlanPri.getJcType());
		//机车编号
		preDict.setJcNum(datePlanPri.getJcnum());
		//报活处所
		String repPosi = request.getParameter("sjbj");
		preDict.setRepPosi(repPosi);
		//报活情况
		String repsituation = request.getParameter("explain");
		preDict.setRepsituation(repsituation);
		//报活人工号
		String repempNo = request.getParameter("gonghao");
		preDict.setRepempNo(repempNo);
		//报活人姓名
		String repemp = request.getParameter("repemp");
		preDict .setRepemp(repemp);
		//报活类型
		String type = request.getParameter("type");
		preDict.setType(Short.parseShort(type));
		//设置报活得分
		String score = request.getParameter("score");
		preDict.setScore(Integer.parseInt(score));
		//班组ID
		String proteamId = request.getParameter("proteamId");
		DictProTeam dictProTeam = null;
		if (0 == Integer.valueOf(proteamId)){
			dictProTeam = pdiFroemanManageService.findDictProTeamById((long)26);
			//更改状态  --交车组
			preDict.setRecStas((short)0);
			preDict.setProTeamId(null);
		}else{
			dictProTeam = pdiFroemanManageService.findDictProTeamById(Long.parseLong(proteamId));
			//更改状态 --作业班组
			preDict.setRecStas((short)2);
			preDict.setProTeamId(dictProTeam);
		}
		
		//报活图片
		String imgUrl = request.getParameter("imgUrl");
		if(!"".equals(imgUrl) && null != imgUrl){
			preDict.setImgUrl(imgUrl);
		}
		try {
			planManageService.saveJtPreDict(preDict);
			out.write("success");
			CometUtil.send(Integer.valueOf(rjhmId), datePlanPri.getFixFreque(), Long.parseLong(proteamId), datePlanPri.getJcType(), datePlanPri.getJcnum(), Integer.valueOf(datePlanPri.getProjectType()), datePlanPri.getNodeid().getJcFlowId());
		} catch (Exception e) {
			e.printStackTrace();
			out.write("failure");
		}finally{
			if(null != out){
				out.close();
			}
		}
		return null;
	}
	
	/**
	 * 进入报活修改页面
	 * @return
	 */
	public String jtPreDictUpdateInput(){
		int preDictId = Integer.valueOf(ServletActionContext.getRequest().getParameter("preDictId"));
		request.put("dictProTeams", pdiFroemanManageService.findDictProTeam());
		if (!isEmpty(type)) {
			request.put("dictFirstUnits", jtPreDictService.listFirstUnitNameOfDictFailure());
		}
		request.put("preDict", jtPreDictService.findJtPreDictById(preDictId));
		return "jtPreDictUpdateInput";
	}
	
	/**
	 * 更新报活记录信息
	 * @return
	 */
	public String jtPreDictUpdate(){
		int preDictId = Integer.valueOf(ServletActionContext.getRequest().getParameter("preDictId"));
		JtPreDict jtPreDict=jtPreDictService.findJtPreDictById(preDictId);
		Integer divisionId=preDict.getDivisionId();
		Integer planId=preDict.getDatePlanPri().getRjhmId();
		if (isUser()) {
			if (null != preDict) {
				try {
					if (null != image) {
						String filePath = fileUpload(image, imageFileName, savePath);
						jtPreDict.setImgUrl(filePath);
					}
					
					if(divisionId!=null){
						List<JCDivision> list=jtPreDictService.listJCDivision(divisionId, planId);
						if(list!=null&&list.size()>0){
							String fixEmpId=",";
							String fixEmp="";
							for(JCDivision jcd:list){
								fixEmpId+=jcd.getUser().getUserid()+",";
								fixEmp+=jcd.getUser().getXm()+",";
							}
							jtPreDict.setFixEmp(fixEmp.substring(0, fixEmp.length()-1));
							jtPreDict.setFixEmpId(fixEmpId);
						}
					}
					jtPreDict.setType(preDict.getType());
					DictProTeam dictProTeam=new DictProTeam();
					dictProTeam.setProteamid(preDict.getProTeamId().getProteamid());
					jtPreDict.setProTeamId(dictProTeam);
					if (preDict.getProTeamId().getProteamid()==0){//交车组
						jtPreDict.setRecStas((short)0);
						jtPreDict.setProTeamId(null);
					}
					jtPreDict.setDivisionId(preDict.getDivisionId());
					jtPreDict.setRepsituation(preDict.getRepsituation());
					jtPreDict.setRepPosi(preDict.getRepPosi());
					jtPreDict.setRepempNo(preDict.getRepempNo());
					jtPreDict.setRepemp(preDict.getRepemp());
					
					planManageService.saveJtPreDict(jtPreDict);
					id = preDict.getDatePlanPri().getRjhmId()+"";
					request.put("message", "报活修改成功！");
				} catch (IOException e) {
					request.put("message", "报活失败，上传文件发生错误！");
					throw new RuntimeException("上传文件发生错误！");
				}
				
			}
		} else {
			request.put("message", "报活修改失败，用户登录失效！");
		}
		
		return reportWork();
	}
	
	/**
	 * 
	 * 报活删除
	 * @return
	 * @throws IOException 
	 */
	public String jtPreDictDelete(){
		int preDictId = Integer.valueOf(ServletActionContext.getRequest().getParameter("id"));
		HttpServletResponse out = ServletActionContext.getResponse();
		try {
//作废
//			JtPreDict jtPreDict = this.jtPreDictService.findJtPreDictById(preDictId);
//			jtPreDict.setRecStas(new Short((short) -1));
//			this.jtPreDictService.saveOrUpdateJtPreDict(jtPreDict);
			planManageService.deleteJtPreDict(new Integer[]{preDictId});
			out.getWriter().print("success");
		} catch (IOException e) {
			try {
				out.getWriter().print("failure");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 报活详细
	 * @return
	 */
	public String reportWorkDetail() {
		if (!isEmpty(id)) {
			request.put("jtPreDict", jtPreDictService.findJtPreDictById(Integer.parseInt(id)));
		}
		return "reportworkdetail";
	}
	
	/**
	 * 报活派工
	 * @return
	 */
	public String reportWorkDistribution() {
		if (isUser()) {
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			if ("foreman".equals(role)) {
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDict(usersPrivs.getBzid()));
			} else {
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDict(null));
			}
		} else {
			request.put("message", "报活派工查询失败，用户登录失效！");
		}
		return "reportworkdistribution";
	}
	
	/**
	 * 派工输入
	 * @return
	 */
	public String distributionInput() {
		if (isUser()) {
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			if (!isEmpty(id)) {
				if ("foreman".equals(role)) {
					request.put("jtPreDicts", jtPreDictService.findJtPreDictByDatePlan(Integer.parseInt(id),usersPrivs.getBzid(), (short)2));
					request.put("usersPrivs", usersPrivsService.listUsersByBzId(usersPrivs.getBzid()));
				} else {
					List<JtPreDict> dicts = jtPreDictService.findJtPreDictByDatePlan(Integer.parseInt(id), null, (short)1);
					List<JtPreDict> smDicts = null;
					String bzNames = "";
					for (JtPreDict jtPreDict : dicts) {
						if(jtPreDict.getProTeamId()!=null){
							bzNames = jtPreDict.getProTeamId().getProteamname()+",";
							smDicts = jtPreDictService.findSmJtPreDicts(jtPreDict.getPreDictId());
							for (JtPreDict temp : smDicts) {
								bzNames += temp.getProTeamId().getProteamname()+",";
							}
							jtPreDict.setSmBzNames(bzNames);
						}
					}
					request.put("jtPreDicts", dicts);
					request.put("dictProTeams", pdiFroemanManageService.findDictProTeam());
				}
				ServletActionContext.getRequest().setAttribute("rjhmId", id);
			}
		} else {
			request.put("message", "派工操作失败，用户登录失效！");
		}
		return "distributioninput";
	}
	
	/**
	 * 调度员派工输入
	 * @return
	 */
	public String distributionDispatchingInput() {
//		request.put("dictProTeams", pdiFroemanManageService.findDictProTeam());
//		if (!isEmpty(params)) {
//			request.put("dictProTeam",pdiFroemanManageService.findDictProTeamById(Long.parseLong(params)));
//		}
		String[] bzIds = params.split(",");
		String bzNames = "";
		for (int i = 0; i < bzIds.length; i++) {
			bzNames += pdiFroemanManageService.findDictProTeamById(Long.parseLong(bzIds[i])).getProteamname() +",";
		}
		ServletActionContext.getRequest().setAttribute("bzNames", bzNames);
		ServletActionContext.getRequest().setAttribute("rjhmId", ServletActionContext.getRequest().getParameter("rjhmId"));
		return "distributiondispatchinginput";
	}
	
	/**
	 * 调度员派工确定
	 * @return
	 * @throws IOException 
	 */
	public String distributionDispatchingConfirm() throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("plain/text");
		if (isUser()) {
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			if (!isEmpty(id) && null != dispatch) {
				List<Integer> preIds = new ArrayList<Integer>();
				String[] temp = id.split(",");
				for (int i = 0; i < temp.length; i++) {
					preIds.add(Integer.parseInt(temp[i]));
				}
				id = jtPreDictService.findJtPreDictById(preIds.get(0)).getDatePlanPri().getRjhmId()+"";
				DatePlanPri datePlanPri = planManageService.findDatePlanPriById(Integer.valueOf(id));
				String result = pdiFroemanManageService.updateDispatching(preIds, dispatch, usersPrivs,1);//1为交车组判别字段
				response.getWriter().print(result);
				String[] bzids = dispatch.getBzIds().split(",");
				for (String bzid : bzids) {
					CometUtil.send(Integer.valueOf(id), datePlanPri.getFixFreque(),Long.parseLong(bzid), datePlanPri.getJcType(), datePlanPri.getJcnum(), Integer.valueOf(datePlanPri.getProjectType()), datePlanPri.getNodeid().getJcFlowId());
				}
			}
		} else {
			response.getWriter().print("login_failure");
		}
		return null;
	}
	
	/**
	 * 调度员派工取消
	 * @return
	 * @throws IOException
	 */
	public String distributionCancelConfirm() throws IOException {
		if (isUser()) {
			if (!isEmpty(id)) {
				JtPreDict preDict = null;
				String[] temp = id.split(",");
				List<JtPreDict> smPreDicts = null;
				boolean flag = true;
				for (int i = 0; i < temp.length; i++) {
					preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(temp[i]));
					if (preDict.getRecStas()==0) {
						request.put("message", "派工取消成功！");
					}else if(preDict.getRecStas()==1){
						
						smPreDicts = jtPreDictService.findSmJtPreDicts(preDict.getPreDictId());
						for (JtPreDict dt : smPreDicts) {
							if(dt.getRecStas()>1){
								flag = false;
								break;
							}
						}
						if(flag){
							jtPreDictService.delJtPreDictOfCancle(Integer.parseInt(temp[i]));
							request.put("message", "派工取消成功！");
						}else{
							request.put("message", "班组已分工或已完成，不能取消！");
						}
					}else{
						request.put("message", "班组已分工或已完成，不能取消！");
					}
					id = preDict.getDatePlanPri().getRjhmId()+"";
				}
			}
		} else {
			request.put("message", "派工取消失败，用户登录失效！");
		}
		return distributionInput();
	}
	
	/**
	 * 作废报活
	 * @return
	 */
	public String abolishJtPreDictOfAbolish(){
		if (isUser()) {
			if (!isEmpty(id)) {
				JtPreDict preDict = null;
				String[] temp = id.split(",");
				List<JtPreDict> smPreDicts = null;
				boolean flag = true;
				for (int i = 0; i < temp.length; i++) {
					preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(temp[i]));
					if (preDict.getRecStas()==0) {
						request.put("message", "作废成功！");
					}else if(preDict.getRecStas()==1){
						
						smPreDicts = jtPreDictService.findSmJtPreDicts(preDict.getPreDictId());
						for (JtPreDict dt : smPreDicts) {
							if(dt.getRecStas()>1){
								flag = false;
								break;
							}
						}
						if(flag){
							jtPreDictService.delJtPreDictOfAbolish(Integer.parseInt(temp[i]));
							request.put("message", "作废成功！");
						}else{
							request.put("message", "班组已分工或已完成，不能作废！");
						}
					}else{
						request.put("message", "班组已分工或已完成，不能作废！");
					}
					id = preDict.getDatePlanPri().getRjhmId()+"";
				}
			}
		} else {
			request.put("message", "派工取消失败，用户登录失效！");
		}
		return distributionInput();
	}
	
	/**
	 * 派工确认
	 * @return
	 */
	public String distributionConfirm() {
		if (isUser()) {
			if ("foreman".equals(role)) {
				if (!isEmpty(id)&&!isEmpty(params)) {
					String[] preDictIds=id.split(",");
					String[] userIds=params.split(",");
					JtPreDict preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(preDictIds[0]));
					jtPreDictService.updateJtPreDict(preDictIds, userIds);
//					JtPreDict preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(id));
//					if (isEmpty(preDict.getFixEmpId()) && isEmpty(preDict.getFixEmp())) {
//						String[] strs = params.split(",");
//						if (!isEmpty(strs)) {
//							Long[] userids = new Long[strs.length];
//							for (int i = 0; i < strs.length; i++) {
//								userids[i] = Long.parseLong(strs[i]);
//							}
//							preDict = jtPreDictService.updateJtPreDictDistribution(Integer.parseInt(id), userids);
//							request.put("message", "派工成功！");
//						}
//					} else {
//						request.put("message", "该报活已经派工，请先取消派工！");
//					}
					request.put("message", "派工成功！");
					id = preDict.getDatePlanPri().getRjhmId()+"";
				}
			} else {
				
			}
		} else {
			request.put("message", "派工失败，用户登录失效！");
		}
		return distributionInput();
	}
	
	/**
	 * 删除派工确定
	 * @return
	 */
	public String deleteDistributionConfirm() {
		if (isUser()) {
			if (!isEmpty(id)) {
				String[] preDictIds=id.split(",");
				JtPreDict preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(preDictIds[0]));
				jtPreDictService.deleteJtPreDict(preDictIds);
//				JtPreDict preDict = jtPreDictService.findJtPreDictById(Integer.parseInt(id));
//				if (isEmpty(preDict.getFixEmpId()) && isEmpty(preDict.getFixEmp())) {
//					request.put("message", "不能删除，该报活还未派工！");
//				} else {
//					if (isEmpty(preDict.getDealFixEmp()) && isEmpty(preDict.getFixEndTime())) {
//						preDict.setFixEmp(null);
//						preDict.setFixEmpId(null);
//						if (isEmpty(preDict.getVerifier())) {
//							preDict.setRecStas((short)1);
//						} else {
//							preDict.setRecStas((short)0);
//						}
//						jtPreDictService.deleteJtPreDictDistribution(preDict);
//						request.put("message", "删除派工成功！");
//					} else {
//						request.put("message", "删除派工失败，检修人已签认！");
//					}
//				}
				request.put("message", "删除派工成功！");
				id = preDict.getDatePlanPri().getRjhmId()+"";
			}
		} else {
			request.put("message", "删除派工失败，用户登录失效！");
		}
		return distributionInput();
	}
	
	/**
	 * 报活项目处理
	 * @return
	 */
	public String reportWorkSign() {
		if (isUser()) {
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDict(usersPrivs.getBzid(), (short)2));
			if ("worker".equals(role)) {
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDict(usersPrivs.getBzid(), (short)2));
				//return "receive_report_work";
			} else if ("foreman".equals(role)) {
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDict(usersPrivs.getBzid(), (short)3));
			} else if ("tech".equals(role)) {//技术
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDictSign(usersPrivs.getUserid(),1));
			} else if ("qi".equals(role)) {//质检
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDictSign(usersPrivs.getUserid(),2));
			} else if ("comm".equals(role)) {//交车工长
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDictSign(usersPrivs.getUserid(),3));
			} else {//验收
				request.put("datePlanPris", planManageService.findDatePlanPriByJtPreDictSign(usersPrivs.getUserid(),4));
			}
		} else {
			request.put("message", "查询报活计划失败，用户登录失效！");
		}
		return "reportworksign";
	}
	
	/**
	 * 报活项目--工人worker 工长foreman 技术tech 质检qi 交车工长comm 验收accept
	 * @return
	 */
	public String reportWorkSignItem() {
		if (isUser()&&!isEmpty(id)) {
			UsersPrivs usersPrivs = getSessionUsersPrivs();
			//根据日计划ID查找日计划,签字页面报活
			request.put("jctype", queryService.findDatePlanPriById(Integer.valueOf(id)).getJcType());
			request.put("rjhmid", id);
			if ("worker".equals(role)) {
				request.put("preDicts", jtPreDictService.listMyJtPreDict(Integer.parseInt(id), usersPrivs, (short)1,true));
				//自选报活项目
				//request.put("freePreDicts", jtPreDictService.listMyJtPreDict(Integer.parseInt(id), usersPrivs, (short)1,false));
				request.put("freePreDicts", jtPreDictService.listMyJtPreDictNoPre(Integer.parseInt(id), usersPrivs, (short)1));
			} else if ("foreman".equals(role)) {
				request.put("preDicts", jtPreDictService.findJtPreDictSignItemByDatePlan(Integer.parseInt(id),usersPrivs.getBzid()));
			} else if ("qi".equals(role)||"tech".equals(role)) {//质检员或技术员进入质检报活签认页面
				List<JtPreDict> jtPreDicts=null;
				if("qi".equals(role)){//质检
					jtPreDicts=jtPreDictService.listJtPreDict(Integer.parseInt(id), 3,usersPrivs.getUserid());
				}else{//技术
					jtPreDicts=jtPreDictService.listJtPreDict(Integer.parseInt(id), 2,usersPrivs.getUserid());
				}
				Map<String,List<JtPreDict>> map=null;
				if(jtPreDicts!=null&&jtPreDicts.size()>0){
					map=new HashMap<String,List<JtPreDict>>();
					for(JtPreDict jtPreDict:jtPreDicts){
						String bzName=jtPreDict.getProTeamId().getProteamname();
						if(map.get(bzName)==null){
							map.put(bzName, new ArrayList<JtPreDict>());
						}
						map.get(bzName).add(jtPreDict);
					}
				}
				request.put("map",map);
				return "qitech_reportworksignitem";
			} else if ("comm".equals(role)) {
				request.put("preDicts", jtPreDictService.listJtPreDict(Integer.parseInt(id), 4,usersPrivs.getUserid()));
			} else {
				request.put("preDicts", jtPreDictService.listJtPreDict(Integer.parseInt(id), 5,usersPrivs.getUserid()));
			}
		} else {
			request.put("message", "查询签认报活项目失败，用户登录失效！");
		}
		return "reportworksignitem";
	}
	
	/**
	 * 报活项目签认输入
	 * @return
	 */
	public String reportWorkItemSignInput() {
		return "reportworkitemsigninput";
	}
	
	/**
	 * 报活项目签认确认
	 * @return
	 * @throws IOException 
	 */
	public String reportWorkItemSignConfirm() throws IOException {
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("plain/text");
		if (isUser()&&!isEmpty(id)) {
			UsersPrivs privs = getSessionUsersPrivs();
				if ("worker".equals(role)||"foreman_worker".equals(role)) {//工长可以处理报活项目
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = jtPreDictService.updateJtPreDictOfWorkerRatify(0, Integer.parseInt(id), dealSituation, params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = jtPreDictService.updateJtPreDictOfWorkerRatify(1, Integer.parseInt(id), dealSituation, null, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				} else if ("foreman".equals(role)) {
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = signWorkService.updateJtPreDictOfSign(1, 0, Integer.parseInt(id), params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = signWorkService.updateJtPreDictOfSign(1, 1, Integer.parseInt(id), params, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				} else if ("tech".equals(role)) {
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = signWorkService.updateJtPreDictOfSign(2, 0, Integer.parseInt(id), params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = signWorkService.updateJtPreDictOfSign(2, 1, Integer.parseInt(id), params, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				} else if ("qi".equals(role)) {
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = signWorkService.updateJtPreDictOfSign(3, 0, Integer.parseInt(id), params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = signWorkService.updateJtPreDictOfSign(3, 1, Integer.parseInt(id), params, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				} else if ("comm".equals(role)){
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = signWorkService.updateJtPreDictOfSign(4, 0, Integer.parseInt(id), params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = signWorkService.updateJtPreDictOfSign(4, 1, Integer.parseInt(id), params, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				} else {
					if ("1".equals(type)) {
						if (!isEmpty(params)) {
							String result = signWorkService.updateJtPreDictOfSign(5, 0, Integer.parseInt(id), params, privs, (short)0);
							if ("success".equals(result)) {
								response.getWriter().print("success");
							} else {
								response.getWriter().print("noprivilege_failure");
							}
						}
					} else {
						String result = signWorkService.updateJtPreDictOfSign(5, 1, Integer.parseInt(id), params, privs, (short)0);
						if ("success".equals(result)) {
							response.getWriter().print("success");
						} else {
							response.getWriter().print("noprivilege_failure");
						}
					}
				}
		} else {
			response.getWriter().print("login_failure");
		}
		return null;
	}
	
	private int num = 1;
	private int size = 10;
	/**
	 * 故障管理
	 * @return
	 */
	public String dictFailureList() { 
		HttpServletRequest request = ServletActionContext.getRequest();
		//查询所有专业
		request.setAttribute("dictFirstUnitList", jtPreDictService.listFirstUnitNameOfDictFailure());
		
		//条件封装
		String yjbj = request.getParameter("yjbj");
		String ejbj = request.getParameter("ejbj");
		String sjbj = request.getParameter("sjbj");
		String keys = request.getParameter("keys");
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("yjbj", yjbj);
		conditionMap.put("ejbj", ejbj);
		conditionMap.put("sjbj", sjbj);
		conditionMap.put("keys", keys);
		
		//查询数据总数
		int rowCount = new Long(jtPreDictService.queryAllDictFailure(conditionMap)).intValue();
		//Page封装
		Page page = new Page(size, num, rowCount);
		
		//分页查询所有故障
		request.setAttribute("dictFailureList", jtPreDictService.queryDictFailurePage(page, conditionMap));
		request.setAttribute("page", page);
		return "dictFailureList";
	}
	
	/**
	 * 故障管理
	 * @return
	 * @throws JSONException 
	 * @throws IOException 
	 */
	public String ajaxDictFailureList() throws Exception{ 
		HttpServletResponse out = ServletActionContext.getResponse();
		HttpServletRequest request = ServletActionContext.getRequest();
		
		//条件封装
		String yjbj = request.getParameter("yjbj");
		String ejbj = request.getParameter("ejbj");
		String sjbj = request.getParameter("sjbj");
		String keys = request.getParameter("keys");
		Map<String, String> conditionMap = new HashMap<String, String>();
		conditionMap.put("yjbj", yjbj);
		conditionMap.put("ejbj", ejbj);
		conditionMap.put("sjbj", sjbj);
		conditionMap.put("keys", keys);
		
		//查询数据总数
		int rowCount = new Long(jtPreDictService.queryAllDictFailure(conditionMap)).intValue();
		//Page封装
		Page page = new Page(size, num, rowCount);
		//查询当前页DictFailure
		List<DictFailure> dictFailureList = jtPreDictService.queryDictFailurePage(page, conditionMap);
		JSONArray array = new JSONArray();
		JSONObject obj = null;
		for(DictFailure dictFailure:dictFailureList){
			obj = new JSONObject();
			obj.put("dictId", dictFailure.getId());
			obj.put("dictYjbj", dictFailure.getFirstUnitName());
			obj.put("dictEjbj", dictFailure.getSecUnitName());
			obj.put("dictSjbj", dictFailure.getThirdUnitName());
			obj.put("dictContent", dictFailure.getContent());
			obj.put("score", dictFailure.getScore());
			array.put(obj);
		}
		JSONObject dictObject = new JSONObject();
		dictObject.put("datas", array);
		dictObject.put("num", num);
		dictObject.put("pageFirst", page.getFirst());
		dictObject.put("pageLast", page.getLast());
		out.getWriter().print(dictObject.toString());
		return null;
	}
	
	/**
	 * 故障添加输入
	 * @return
	 */
	public String dictFailureAddInput() { 
		//查询所有专业
		request.put("dictFirstUnitList", jtPreDictService.listFirstUnitNameOfDictFailure());
		return "dictFailureAddInput";
	}
	
	/**
	 * 故障添加
	 * @return
	 */
	public String dictFailureAdd() { 
		HttpServletRequest request = ServletActionContext.getRequest();
		boolean flag = this.jtPreDictService.saveOrUpdateDictFailure(dictFailure);
		if(flag){
			request.setAttribute("message", "故障添加成功！");
		}else{
			request.setAttribute("message", "故障添加失败！");
		}
		return "listDictFailure";
	}
	
	/**
	 * 故障编辑输入
	 * @return
	 */
	public String dictFailureEditeInput() { 
		HttpServletRequest request = ServletActionContext.getRequest();
		//当前页码
		int num = Integer.valueOf(request.getParameter("num"));
		//查询所有专业
		request.setAttribute("dictFirstUnitList", jtPreDictService.listFirstUnitNameOfDictFailure());
		Integer dictId = Integer.valueOf(request.getParameter("dictId"));
		//获得当前DictFailure
		DictFailure dictFailure = jtPreDictService.queryDictFailureById(dictId);
		request.setAttribute("dictFailure", dictFailure);
		request.setAttribute("num", num);
		return "dictFailureEditeInput";
	}
	
	/**
	 * 故障编辑
	 * @return
	 */
	public String dictFailureEdite() { 
		HttpServletRequest request = ServletActionContext.getRequest();
		String firstUnitName = request.getParameter("firstUnitName");
		String secUnitName = request.getParameter("secUnitName");
		String thirdUnitName = request.getParameter("thirdUnitName");
		String content = request.getParameter("content");
		String score = request.getParameter("score");
		Integer dictId = Integer.valueOf(request.getParameter("dictId"));
		//获得当前DictFailure
		DictFailure dictFailure = jtPreDictService.queryDictFailureById(dictId);
		if(!"".equals(firstUnitName)){
			dictFailure.setFirstUnitName(firstUnitName);
		}
		if(!"".equals(secUnitName)){
			dictFailure.setSecUnitName(secUnitName);
		}
		if(!"".equals(thirdUnitName)){
			dictFailure.setThirdUnitName(thirdUnitName);
		}
		dictFailure.setContent(content);
		dictFailure.setScore(Integer.parseInt(score));
		boolean flag = this.jtPreDictService.saveOrUpdateDictFailure(dictFailure);
		if(flag){
			request.setAttribute("message", "故障编辑成功！");
		}else{
			request.setAttribute("message", "故障编辑失败！");
		}
		return "listDictFailure";
	}
	
	/**
	 * 故障删除
	 * @return
	 * @throws Exception 
	 */
	public String dictFailureDelete() throws Exception { 
		String result = "";
		HttpServletResponse out = ServletActionContext.getResponse();
		String[] dictIdArray = ServletActionContext.getRequest().getParameter("dicts").split(",");
		for(int i=1; i< dictIdArray.length; i++){
			DictFailure dictFailure = jtPreDictService.queryDictFailureById(Integer.valueOf(dictIdArray[i]));
			result = jtPreDictService.deleteDictFailure(dictFailure);
		}
		if(result.equals("success")){
			out.getWriter().write("success");
		}else{
			out.getWriter().write("failure");
		}
		return null;
	}
	
	/**通过Ajax获取图片信息  
     * @return  
     * @throws IOException   
     */  
    public String ajaxGetImage() throws IOException{  
    	HttpServletResponse response=ServletActionContext.getResponse(); 
        response.setContentType("text/plain");  
        response.setCharacterEncoding("utf-8");  
        if(fileMaterial!=null){  
            String fileName = UUID.randomUUID()+fileMaterialFileName.substring(fileMaterialFileName.indexOf("."));
            SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy/MM/dd");
            String filePath = "reportwork" + "/" +  dateFormat.format(new Date());
            String fileRealPath=ServletActionContext.getServletContext().getRealPath(filePath);
    		File sysmfile = new File(fileRealPath);
    		if (!fileMaterial.exists()) {
    			fileMaterial.mkdirs();
    		}
            FileUtils.copyFile(fileMaterial, new File(sysmfile.getPath() + "/" + fileName));
            response.getWriter().print(filePath+"/"+fileName+",图片上传成功!");
        }else{  
            response.getWriter().print("请添加要上传的图片!");  
        }  
        return null;  
    }  

	/**
	 * 报活项目补签
	 * @return
	 */
	public String reportWorkItemReSignInput() {
		return "re_sign";
	}

	/**
	 * 报活项目补签确认 
	 * */
	public String reportWorkReSignConfirm() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("plain/text");
		Integer preDictId = Integer.parseInt(request.getParameter("params"));
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String dealSituation = request.getParameter("dealSituation");
		
		UsersPrivs user = usersPrivsService.login(name, pwd);
		if(user == null){
			response.getWriter().print("login_failure");
		}else{
			String result = signWorkService.updateReSignReport(user, dealSituation, preDictId);
			response.getWriter().print(result);
		}
		return null;
	}
	
	/**
	 * 角色卡控补签报活
	 * */
	public String reportLeadItemReSignInput(){
		return "lead_re_sign";
	}
	
	/**
	 * 角色补签确认
	 * */
	public String reportLeadReSignConfirm() throws Exception{
		HttpServletRequest request = ServletActionContext.getRequest();
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("plain/text");
		
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		
		String strs = request.getParameter("params");
		String[] predicts = strs.split(",");
		
		UsersPrivs user = usersPrivsService.login(name, pwd);
		if(user == null){
			response.getWriter().print("login_failure");
		}else{
			String result = "flaure";
			for(int i=0;i<predicts.length;i++){
				result = signWorkService.updateLeadReSignReport(user, Integer.parseInt(predicts[i]));
			}
			response.getWriter().print(result);
		}
		return null;
	}
	
	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getType() {
		return type;
	}

	public Dispatch getDispatch() {
		return dispatch;
	}

	public void setDispatch(Dispatch dispatch) {
		this.dispatch = dispatch;
	}

	public void setType(String type) {
		this.type = type;
	}

	public JtPreDict getPreDict() {
		return preDict;
	}

	public void setPreDict(JtPreDict preDict) {
		this.preDict = preDict;
	}

	public File getImage() {
		return image;
	}

	public void setImage(File image) {
		this.image = image;
	}

	public String getImageFileName() {
		return imageFileName;
	}

	public void setImageFileName(String imageFileName) {
		this.imageFileName = imageFileName;
	}

	public String getSavePath() {
		return savePath;
	}

	public void setSavePath(String savePath) {
		this.savePath = savePath;
	}

	public String getParams() {
		return params;
	}

	public void setParams(String params) {
		this.params = params;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getPassword() {
		return password;
	}

	public void setPassword(String password) {
		this.password = password;
	}

	public String getDealSituation() {
		return dealSituation;
	}

	public void setDealSituation(String dealSituation) {
		this.dealSituation = dealSituation;
	}

	public String getCardNum() {
		return cardNum;
	}

	public void setCardNum(String cardNum) {
		this.cardNum = cardNum;
	}

	public String getRole() {
		return role;
	}

	public void setRole(String role) {
		this.role = role;
	}

	public int getFlag() {
		return flag;
	}

	public void setFlag(int flag) {
		this.flag = flag;
	}

	public DictFailure getDictFailure() {
		return dictFailure;
	}

	public void setDictFailure(DictFailure dictFailure) {
		this.dictFailure = dictFailure;
	}

	public int getNum() {
		return num;
	}

	public void setNum(int num) {
		this.num = num;
	}
	
	public File getFileMaterial() {
		return fileMaterial;
	}

	public void setFileMaterial(File fileMaterial) {
		this.fileMaterial = fileMaterial;
	}

	public String getFileMaterialFileName() {
		return fileMaterialFileName;
	}

	public void setFileMaterialFileName(String fileMaterialFileName) {
		this.fileMaterialFileName = fileMaterialFileName;
	}
	
}
