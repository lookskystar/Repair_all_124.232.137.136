package com.repair.part.action;

import java.io.IOException;
import java.io.PrintWriter;
import java.io.UnsupportedEncodingException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.apache.struts2.interceptor.ServletRequestAware;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PJDatePlan;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.common.util.ParseUtil;
import com.repair.part.service.PJManageService;
import com.repair.part.service.PartFixService;
import com.repair.work.service.UsersPrivsService;
import com.repair.work.service.WorkService;

public class PartFixAction implements ServletRequestAware{

	private HttpServletRequest request;
	@Resource(name="partFixService")
	private PartFixService partFixService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="pjManageService")
	private PJManageService pjManageService;
	@Resource(name="workService")
	private WorkService workService;
	
	/**
	 * 格式化时间2012-12-12 11:05:06
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	public static final SimpleDateFormat YMDHMS_SDFORMAT2 = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	private PageModel pageModel;
	private PJDatePlan datePlan;
	private PJFixRecord pjFixRecord;
	
	private List<Long> pjdids;
	
	//查询条件机车型号
	private String jcsType;
	//查询条件一级部件
	private Long firstUnitId;
	//配件名称
	private String pjName;
	//配件编号
	private String pjNum;
	//配件状态
	private Integer pjStatus;
	
	/**
	 * 动态配件分类展示
	 * @return
	 */
	public String listPJDynamicInfo(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		List list =partFixService.listPJDynamicInfo(jcsType, firstUnitId, pjName, user.getBzid());
		request.setAttribute("repairParts", list);
		return "listPJDynamicInfo";
	}
	
	/**
	 * 动态配件列表
	 * @return
	 */
	public String pjDynamicList(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		request.setAttribute("flowTypes", pjManageService.findPJFixFlowType());
		String urlName=request.getParameter("urlName");
		if(pjName !=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(pjNum!=null && !"".equals(pjNum)){
			pjNum = pjNum.trim();
		}
		pageModel = partFixService.findPageModelPJDynamic(jcsType,firstUnitId,pjName,pjNum,pjStatus,user.getBzid());
		setPageModel(pageModel);
		request.setAttribute("urlName", urlName);
		return "pjDynamicList";
	}
	
	/**
	 * 选择一个或多个配件做检修
	 */
	public void choicePJFix(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String pjdid = request.getParameter("pjdid");
			partFixService.saveChoicePJFixNew(pjdid);
		} catch (IOException e) {
			result = "error";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
	}
	
	
	/**
	 * 进入选择日计划的配件页面
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String toChoicePJS() throws UnsupportedEncodingException{
		String jcTypeVal = request.getParameter("jcTypeVal");
		String profession = request.getParameter("firstUnitId");
		String flag = request.getParameter("flag");//标识符：flag为null时表示初次进入页面
		List<String> jcTypeValues = partFixService.findJcTypeValueFromDictFirstUnit();
		if(flag != null){
			Long firstUnitId = Long.parseLong(profession);
			String keyword = request.getParameter("keyword")==null?"":request.getParameter("keyword");
			String key = request.getParameter("key");
			if(key !=null){
				keyword = URLDecoder.decode(key, "UTF-8");//十六制转为中文
			}else{
				key = URLEncoder.encode(keyword, "UTF-8");//中文转为十六制编码
			}
			pageModel = partFixService.findPageModelPJStaticInfoByJcTypeAndProfession(jcTypeVal,firstUnitId,keyword);
			request.setAttribute("keyword", keyword);
			request.setAttribute("key", key);
		}
		request.setAttribute("jcTypeValues", jcTypeValues);
		setPageModel(pageModel);
		request.setAttribute("jcTypeVal",jcTypeVal);
		request.setAttribute("firstUnitId", profession);
		request.setAttribute("flag", flag);
		return "choicePJS";
	}
	
	/**
	 * 根据机车型号查询专业（一级部件）
	 */
	public void findFirstUintByJcType(){
		PrintWriter pw = null;
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String jcType = request.getParameter("jcType");
			List<DictFirstUnit> firstUnits = partFixService.findDictFirstUnitsByJcType(jcType);
			StringBuffer json = new StringBuffer("[");
			for (DictFirstUnit firstUnit : firstUnits) {
				json.append("{\"id\":").append(firstUnit.getFirstunitid()).append(",");
				json.append("\"name\":\"").append(firstUnit.getFirstunitname()).append("\"},");
			}
			json = json.deleteCharAt(json.lastIndexOf(","));
			json.append("]");
			pw.write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.close();
			}
		}
	}
	
	/**
	 * 进入选择动态配件页面
	 * @return
	 */
	public String toChoicePJDynamic(){
		String pjSid = request.getParameter("pjsid");
		String amount = request.getParameter("amount");
		String planId = request.getParameter("planId");
		long pjsid = Long.parseLong(pjSid);
		pageModel = partFixService.findPageModelPJDynamicByPJSid(pjsid,1);
		setPageModel(pageModel);
		long pid = Long.parseLong(planId);
		List parts = partFixService.findPartChoicedByDatePlan(pid);
		request.setAttribute("parts", parts);
		request.setAttribute("amount", amount);
		request.setAttribute("planId", planId);
		return "choiceDynamicInfo";
	}
	
	
	/**
	 * 产生动态配件编码（pjNum为null时表示需自动生成，不为空时为手动输入）
	 */
	public void createPJNum(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String pjdidStr = request.getParameter("pjdid");
			String pjNum = request.getParameter("pjNum");
			String py = request.getParameter("py");
			result = partFixService.saveCreatePJNum(pjdidStr,pjNum,py);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	/**
	 * 选择多个配件产生配件编码
	 */
	public void createMostPJNum(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String pjIds=request.getParameter("pjIds");
			result = partFixService.saveCreatePJNum(pjIds);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.flush();
				pw.close();
			}
		}
	}
	
	
	
	/**
	 * 统计未完成的检修静态配件
	 */
	public String unfinishedPartCount(){
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		if(pjName!=null){
			pjName = pjName.trim();
		}
		if(pjNum!=null){
			pjNum = pjNum.trim();
		}
		DictProTeam tsTeam = workService.findDictProTeamByPY(Contains.TSZ_PY);
		List list = partFixService.listUnfinishedPartCount(user,jcsType,firstUnitId,pjName,tsTeam.getProteamid());
		request.setAttribute("list", list);
		return "unfinishedPartCount";
	}
	
	/**
	 * 未完成的检修配件（工长派工/工人接活开始第一个页面）
	 * @return
	 */
	public String unfinishedPart(){
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		int type = ParseUtil.parseInt(request.getParameter("type"), 0);
		String urlName=request.getParameter("urlName");
		if(pjName!=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(pjNum!=null){
			pjNum = pjNum.trim();
		}
		pageModel = partFixService.findPageModelPJPartFixRecordByUser(user,jcsType,firstUnitId,pjName,pjNum,type);
		setPageModel(pageModel);
		request.setAttribute("type", type);
		request.setAttribute("urlName", urlName);
		return "unfinishedPart";
	}
	
	/**
	 * 进入签认页面
	 * @return
	 */
	public String toSignItem(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String pjDid = request.getParameter("pjdid");
		Long pjRecId=Long.parseLong(request.getParameter("pjRecId"));
		String role = user.getRoles();
		request.setAttribute("pjdid", pjDid);
		request.setAttribute("pjRecId", pjRecId);
		DictProTeam tsTeam = workService.findDictProTeamByPY(Contains.TSZ_PY);
		if(role.contains(",GR,") || role.contains(",GZ,")){
			return "workerSign";
		}else{
			pageModel = partFixService.findPageModelFixingPJDynamic(pjDid,user,pjRecId);
			setPageModel(pageModel);
			request.setAttribute("tsbzid", tsTeam.getProteamid());
			return "othersSign";
		}
	}
	
	/**
	 * 进入检查项目
	 * @return
	 */
	public String toInspectionItem(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String pjDid = request.getParameter("pjdid");
		Long pjRecId=Long.parseLong(request.getParameter("pjRecId"));
		PJDynamicInfo pjDynamicInfo=partFixService.getPJDynamicInfoById( Long.parseLong(pjDid));
		setPageModel(partFixService.findPageModelUnfinishedInspectionItem(pjDid,user.getBzid(),pjRecId));
		String role = user.getRoles();
		request.setAttribute("pjdid", pjDid);
		request.setAttribute("pjRecId", pjRecId);
		DictProTeam tsTeam = workService.findDictProTeamByPY(Contains.TSZ_PY);
		if(role.contains(",GR,")){
			//判断是否是探伤组
			int tsflag = 0;
			if(tsTeam!=null && tsTeam.getProteamid().equals(user.getBzid())){
				tsflag = 1;
			}
			request.setAttribute("tsflag", tsflag);
			Long signed=partFixService.findSignedInspectionItem(pjDid,user.getBzid(),pjRecId,0);
			request.setAttribute("signed", signed);
			//查询该配件大类是否存在预设分工
			List<PJPresetDivision> pjPresets=partFixService.findPJStaticInfoPreset(pjDynamicInfo.getPjStaticInfo().getPjsid());
			if(pjPresets!=null&&pjPresets.size()>0){
				List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
				Map<String,Object> map=null;
				for(PJPresetDivision pjPreset:pjPresets){
					int count=partFixService.countPJPresetItem(pjPreset.getPresetId(), 0);
					if(count!=0){//检查项目存在预设分类
						map=new HashMap<String,Object>();
						map.put("presetId", pjPreset.getPresetId());
						map.put("presetName", pjPreset.getPresetName());
						map.put("signed", partFixService.countSignedPreset(pjPreset.getPresetId(), pjRecId, 0));
						list.add(map);
					}
				}
				request.setAttribute("pjPresets", list);
				return "preset_inspectionItem";
			}else{
				return "inspectionItem";
			}
		}else{
			Long signed=partFixService.findSignedInspectionItem(pjDid,user.getBzid(),pjRecId,1);
			request.setAttribute("signed", signed);
			request.setAttribute("tsbzid", tsTeam.getProteamid());
			return "leadInspectionItem";
		}
	}
	
	/**
	 * 进入检测项目
	 * 
	 * @return
	 */
	public String toDetectItem(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String pjDid = request.getParameter("pjdid");
		Long pjRecId=Long.parseLong(request.getParameter("pjRecId"));
		PJDynamicInfo pjDynamicInfo=partFixService.getPJDynamicInfoById( Long.parseLong(pjDid));
		setPageModel(partFixService.findPageModelUnfinishedDetectItem(pjDid,user.getBzid(),pjRecId));
		String role = user.getRoles();
		request.setAttribute("pjdid", pjDid);
		request.setAttribute("pjRecId", pjRecId);
		if(role.contains(",GR,")){
			Long signed=partFixService.findSignedDetectItem(pjDid,user.getBzid(),pjRecId,0);
			request.setAttribute("signed", signed);
			//查询该配件大类是否存在预设分工
			List<PJPresetDivision> pjPresets=partFixService.findPJStaticInfoPreset(pjDynamicInfo.getPjStaticInfo().getPjsid());
			if(pjPresets!=null&&pjPresets.size()>0){
				List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
				Map<String,Object> map=null;
				for(PJPresetDivision pjPreset:pjPresets){
					int count=partFixService.countPJPresetItem(pjPreset.getPresetId(), 1);
					if(count!=0){//检查项目存在预设分类
						map=new HashMap<String,Object>();
						map.put("presetId", pjPreset.getPresetId());
						map.put("presetName", pjPreset.getPresetName());
						map.put("signed", partFixService.countSignedPreset(pjPreset.getPresetId(), pjRecId, 1));
						list.add(map);
					}
				}
				request.setAttribute("pjPresets", list);
				return "preset_detectItem";
			}else{
				return "detectItem";
			}
		}else{
			Long signed=partFixService.findSignedDetectItem(pjDid,user.getBzid(),pjRecId,1);
			request.setAttribute("signed", signed);
			return "leadDetectItem";
		}
	}
	
	/**
	 * ajax得到配件检修项目
	 * @return
	 * @throws IOException 
	 * @throws JSONException 
	 */
	public String ajaxGetPJFixRec() throws IOException, JSONException{
		Long presetId=Long.parseLong(request.getParameter("presetId"));
		Long pjRecId=Long.parseLong(request.getParameter("pjRecId"));
		int type=Integer.parseInt(request.getParameter("type"));//0:检查项目 1：检测项目
		List<PJFixRecord> pjFixRecs=partFixService.findPJFixRecordByPresetRelateID(presetId, pjRecId, type);
		if(pjFixRecs!=null&&pjFixRecs.size()>0){
			JSONArray array=new JSONArray();
			JSONObject obj=null;
			for(PJFixRecord pjFixRec:pjFixRecs){
				obj=new JSONObject();
				obj.put("pjRecId", pjFixRec.getPjRecId());
				obj.put("recstas", pjFixRec.getRecstas());
				obj.put("pjname", pjFixRec.getPjname());
				obj.put("posiName", pjFixRec.getPosiName());
				obj.put("fixItem", pjFixRec.getFixItem());
				obj.put("fixemp", pjFixRec.getFixemp());
				if(pjFixRec.getEmpaffirmtime()!=null){
					obj.put("empaffirmtime",YMDHMS_SDFORMAT2.format(pjFixRec.getEmpaffirmtime()));
				}else{
					obj.put("empaffirmtime",pjFixRec.getEmpaffirmtime());
				}
				obj.put("fixsituation", pjFixRec.getFixsituation());
				//探伤情况
				obj.put("dealSituaton", pjFixRec.getDealSituaton());
				obj.put("rept", pjFixRec.getRept());
				obj.put("reptAffirmTime", pjFixRec.getReptAffirmTime());
				
				obj.put("pjNum", pjFixRec.getPjNum());
				obj.put("preStatus", pjFixRec.getPreStatus());
				if(pjFixRec.getPjFixItem().getAmount()==null){
					obj.put("amount",0);
				}else{
					obj.put("amount", pjFixRec.getPjFixItem().getAmount());
				}
				obj.put("lead", pjFixRec.getLead());
				obj.put("min", pjFixRec.getPjFixItem().getMinVal());
				obj.put("max", pjFixRec.getPjFixItem().getMaxVal());
				obj.put("unit", pjFixRec.getUnit());
				array.put(obj);
			}
			JSONObject object=new JSONObject();
			object.put("datas", array);
			ServletActionContext.getResponse().getWriter().write(object.toString());
		}else{
			ServletActionContext.getResponse().getWriter().write("no_data");
		}
		return null;
	}
	/**
	 * 签认未完成的检修项目
	 * @return
	 */
	public void signFixItem(){
		PrintWriter pw = null;
		String msg = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String records = request.getParameter("records");
			String status = request.getParameter("status");
			String roleFlag = request.getParameter("roleFlag");
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			msg = partFixService.saveSignFixItem(user,records,status,roleFlag);
		} catch (Exception e) {
			msg = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(msg);
				pw.close();
			}
		}
	} 
	
	/**
	 * 工长卡控全签
	 * @return
	 */
	public String signAllDetectItem(){
		PrintWriter pw = null;
		String result = "success";
		String records = "";
		String recId = "";
		String pjDid = request.getParameter("pjDid");
		String flag = request.getParameter("flag");
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		try {
			pw = ServletActionContext.getResponse().getWriter();
			List<PJFixRecord> list = partFixService.findPJFixRecord(Long.parseLong(pjDid),user.getBzid(), flag);
			if(list.size() > 0){
				for(int i = 0; i < list.size(); i++){
					recId = list.get(i).getPjRecId().toString();
					if(i != list.size()-1){
						records += recId + ",";
					}else{
						records += recId;
					}
				}
				result = partFixService.saveSignFixItem(user,records);
			}else{
				result = "noItem";
			}
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		return null;
	}
	
	/**
	 * 签认(修改)检测项目
	 */
	public void signDetectItem(){
		PrintWriter pw = null;
		String msg = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String records = request.getParameter("recId");
			String status = request.getParameter("status");
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			msg = partFixService.saveSignDetectFixItem(user,records,status);
		} catch (Exception e) {
			msg = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(msg);
				pw.close();
			}
		}
	}
	
	/**
	 * 选择动态配件信息
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String choiceDyPjInfo() throws UnsupportedEncodingException{
		String pjName=request.getParameter("pjName");
		String pjNum=request.getParameter("pjNum");
		String urlName=request.getParameter("urlName");
		String stdpjid = request.getParameter("stdPjId");
		String type = request.getParameter("type");
		if(pjName !=null && !"".equals(pjName)){
			pjName = URLDecoder.decode(pjName, "UTF-8");//十六制转为中文
			urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
		}else{
			if(stdpjid!=null && !"".equals(stdpjid)){
				try{
					pjName = workService.findPJStaticInfoById(Long.parseLong(stdpjid)).getPjName();
					urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
				}catch(Exception e){
					pjName = null;
				}
			}
		}
		PageModel<PJDynamicInfo> pm = workService.findPJDynamicInfo(type,pjName,pjNum,null);
		request.setAttribute("pm", pm );
		request.setAttribute("pjName", pjName);
		request.setAttribute("urlName", urlName);
		request.setAttribute("stdpjid", stdpjid);
		request.setAttribute("pjNum", pjNum);
		return "choicedypj";
	}
	
	/**
	 * 输入组装配件编号INIT
	 */
	public String inputPJNumInit(){
		String recId = request.getParameter("recId");
		PJFixRecord pJFixRecord = partFixService.findPJFixRecordById(Long.parseLong(recId));
		request.setAttribute("amount", pJFixRecord.getPjFixItem().getAmount());
		request.setAttribute("stdpjid", pJFixRecord.getPjFixItem().getChildPJId());
		request.setAttribute("recId", recId);
		return "addPJNum";
	}
	
	/**
	 * 输入组装的配件编号
	 */
	public void inputPJNum(){
		PrintWriter pw = null;
		String msg = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String recId = request.getParameter("recId");
			String pjNumber = request.getParameter("pjNumber");
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			msg = partFixService.savePjNumberIntoRecord(user,recId,pjNumber);
		} catch (Exception e) {
			msg = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(msg);
				pw.close();
			}
		}
	}
	
	/**
	 * 探伤裂损情况
	 */
	public String dealSituationRatify() throws Exception{
		Long id = Long.parseLong(request.getParameter("id"));
		String deal = request.getParameter("deal");
		workService.updatePJFixRecOfDealSituation(id, deal);
		HttpServletResponse response = ServletActionContext.getResponse();
		response.setContentType("text/html; charset=GBK");
		PrintWriter out = response.getWriter();
		try {
			out.write("success");
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
	 * 复探签字
	 */
	public String reptPJFixRecSign() throws Exception {
		String ids = request.getParameter("ids");
		if(ids!=null){
			String[] idsArr = ids.split("-");
			List<Long> idList = new ArrayList<Long>();
			for (String temp : idsArr) {
				idList.add(Long.parseLong(temp));
			}
			UsersPrivs user = (UsersPrivs)request.getSession().getAttribute("session_user");
			try {
				workService.updateReptSign(idList, user, YMDHMS_SDFORMAT.format(new Date()), 2);
			} catch (Exception e) {
				e.printStackTrace();
			}
		}
		return null;
	}
	
	/**
	 * 进入修改配件信息页面
	 * @return
	 */
	public String pjNumUpdateInput(){
		String pJNum = request.getParameter("pJNum");
		Long pjRecId = Long.parseLong(request.getParameter("pjRecId"));
		String[] pJNumArray = pJNum.split(",");
		PJFixRecord pJFixRecord = partFixService.findPJFixRecordById(pjRecId);
		Integer amount = pJFixRecord.getPjFixItem().getAmount();
		if(null != amount){
			request.setAttribute("amount", amount);
		}
		
		/**
		 * 2016-01-18  16:09         周云韬
		 * 工人配件检修项目签认处，当已经输入了配件编码，需要修改时，这时【选择配件编码】对话框配件名称处为静态配件名称，此处加入了判断
		 * 当配件检修项目子配件ID字段的值不为null时，配件名称处显示的是与当前检修项目相关的子配件的名称
		 * */
		if(pJFixRecord.getPjFixItem().getChildPJId() != null){
			request.setAttribute("stdPjId", pJFixRecord.getPjFixItem().getChildPJId());
		}else{
			request.setAttribute("stdPjId", pJFixRecord.getPjDynamicInfo().getPjStaticInfo().getPjsid());
		}
		
		
		request.setAttribute("pjRecId", pjRecId);
		request.setAttribute("fixItem", pJFixRecord.getPjFixItem().getFixItem());
		request.setAttribute("amount", amount);
		request.setAttribute("pJNumArray", pJNumArray);
		return "pjNumUpdateInput";
	}
	
	/**
	 * 修改组装配件编号
	 */
	public void pjNumUpdate(){
		PrintWriter pw = null;
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String pjNums=request.getParameter("pjNum");
		String pjNumsOld = request.getParameter("pjNumsOld");
		String pjRecId = request.getParameter("pjRecId");
		PJDynamicInfo pJDynamicInfo = null;
		String[] pjNumsOldArray = null;
		String[] pjNumArray=pjNums.split(",");
		String result="success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			for(int i=0;i<pjNumArray.length;i++){
				Long existPjNum=workService.countPjInfoByPjNum(pjNumArray[i]);//查找动态配件信息表中是否存在该配件编号
				if(existPjNum!=null&&existPjNum==0){//配件编号不存在
					result="noexist-"+i;
					break;
				}
			}
			if(result.equals("success")){
				if(!"".equals(pjNumsOld) && null != pjNumsOld){
					pjNumsOldArray = pjNumsOld.split(",");
					for (int i = 0; i < pjNumsOldArray.length; i++) {
						pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumsOldArray[i]);
						pJDynamicInfo.setStorePosition(0);
						workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
					}
				}
				for (int i = 0; i < pjNumArray.length; i++) {
					pJDynamicInfo = workService.findPJDynamicInfoByNum(pjNumArray[i]);
					pJDynamicInfo.setStorePosition(2);
					workService.saveOrUpdatePJDynamicInfo(pJDynamicInfo);
				}
				partFixService.savePjNumberIntoRecord(user,pjRecId,pjNums);
			}
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		
	}
	
	
	/**
	 * 获取所有的班组
	 */
	public void obtainBZ(){
		PrintWriter pw = null;
		try {
			pw = ServletActionContext.getResponse().getWriter();
			StringBuffer json = new StringBuffer("[");
			List<DictProTeam> teams = usersPrivsService.findBZList(); 
			if(teams!=null && teams.size()>0){
				for (DictProTeam team : teams) {
					json.append("{\"id\":").append(team.getProteamid()).append(",");
					json.append("\"name\":\"").append(team.getProteamname()).append("\"},");
				}
				json = json.deleteCharAt(json.lastIndexOf(","));
			}
			json.append("]");
			pw.write(json.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.close();
			}
		}
		
	}
	
	/**
	 * 用户报活
	 */
	public void createPredict(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String approveVal = request.getParameter("approve");
			String bzid = request.getParameter("bzId");
			String bzname = request.getParameter("bzName");
			String desc = request.getParameter("description");
			Long pjRecordId = pjFixRecord.getPjRecId();
		    partFixService.saveCreatePredict(user,bzid,bzname,approveVal,desc,pjRecordId);
		} catch (IOException e) {
			result = "error";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
	}
	
	/**
	 * 进入需要调度审批的报活页面
	 * @return
	 */
	public String approvePredictList(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		if(null != user.getBzid()){
			pageModel = partFixService.findPageModelPJPredict(user,1);
		}
		return "approvePredictList";
	}
	
	/**
	 * 进入指派班组页面
	 * @return
	 */
	public String toChoiceBZ(){
		List<DictProTeam> bzs =  usersPrivsService.findBZList();
		request.setAttribute("bzs", bzs);
		return "bzList";
	}
	
	/**
	 * 给报活指派班组
	 * @return
	 */
	public void choiceBZ(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String predictid = request.getParameter("predictId");
			String bzid = request.getParameter("bzId");
			String bzName = request.getParameter("bzName");
			partFixService.saveAssignPredictBZ(user,predictid,bzid,bzName);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
	}
	
	/**
	 * 进入工长对报活派工的页面
	 * @return
	 */
	public String toAssignPredict(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		pageModel = partFixService.findPageModelPJPredict(user,0);
		return "predictList";
	}
	
	/**
	 * 进入当前用户所在班组成员列表页面
	 * @return
	 */
	public String workerList(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		pageModel = usersPrivsService.findPageModelBZWorkers(user);
		return "choiceWorker";
	}
	
	/**
	 * 给配件报活派工
	 */
	public void assignPredict(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			String predictid = request.getParameter("predictId");
			String userid = request.getParameter("userId");
			String userName = request.getParameter("userName");
			partFixService.saveAssignPredict(predictid,userid,userName);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
	}
	
	
	/**
	 * 进入报活签认页面
	 * @return
	 */
	public String toSignPredict(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		if(null != user.getBzid()){
			pageModel = partFixService.findPageModelPJPredict(user,2);
		}
		return "signPredictList";
	}
	
	/**
	 * 报活签认
	 * @return
	 */
	public void signPredict(){
		PrintWriter pw = null;
		String result = "操作成功";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String predictid = request.getParameter("predictId");
			String flag = request.getParameter("flag");
			result = partFixService.saveSignPredict(user,predictid,flag);
		} catch (IOException e) {
			result = "操作失败";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		
	}
	
	/**
	 * 进入正在检修的拥有子配件的配件页面
	 * @return
	 */
	public String unitPartRecord(){
		pageModel = partFixService.findPageModelUnitHasPart();
		setPageModel(pageModel);
		return "unitPartList";
	}
	
	/**
	 * 进入大部件所有的子配件的列表页面
	 * @return
	 */
	public String unitChildPart(){
		String pjSid = request.getParameter("pjsid");
		String recordId = request.getParameter("recordId");
		long pjsid = Long.parseLong(pjSid);
		List pjs = partFixService.findChildPJByParentPJFromFixItem(pjsid);
		request.setAttribute("pjs", pjs);
		request.setAttribute("recordId", recordId);
		return "unitChildPart";
	}
	
	/**
	 * 进入选择配件页面（填写大部件的子配件时）
	 * @return
	 */
	public String toUnitChoicePart(){
		String pjsid = request.getParameter("pjsid");
		long pjSid = Long.parseLong(pjsid);
		pageModel = partFixService.findPageModelPJDynamicByPJSid(pjSid,2);
		setPageModel(pageModel);
		request.setAttribute("pjsid", pjsid);
		return "unitChoicePart";
	}
	
	/**
	 * 选择子配件
	 * @return
	 */
	public String unitChoicePart(){
		String recordid = request.getParameter("recordId");
		if(pjdids!=null){
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			partFixService.saveChoiceUnitPart(recordid,pjdids,user);
		}
		return unitPartRecord();
	}
	
	/**
	 * 禁用配件检修项目
	 * @return
	 */
	public String ajaxEnablePartFixItem(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recId = request.getParameter("recId");
			PJFixRecord pJFixRecord = partFixService.findPJFixRecordById(Long.parseLong(recId));
			pJFixRecord.setEmpaffirmtime(new Date());
			pJFixRecord.setFixemp(user.getXm());
			pJFixRecord.setFixsituation("未启用");
			partFixService.savePJFixRecord(pJFixRecord);
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		return null;
	}
	
	/**
	 * 启用配件检修项目
	 * @return
	 */
	public String ajaxAblePartFixItem(){
		PrintWriter pw = null;
		String result = "success";
		try {
			pw = ServletActionContext.getResponse().getWriter();
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			String recId = request.getParameter("recId");
			PJFixRecord pJFixRecord = partFixService.findPJFixRecordById(Long.parseLong(recId));
			pJFixRecord.setEmpaffirmtime(new Date());
			pJFixRecord.setFixemp(user.getXm());
			pJFixRecord.setFixsituation("");
			partFixService.savePJFixRecord(pJFixRecord);
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		return null;
	}
	
	/**
	 * 一键禁用或启用配件检修项目
	 * 唐倩 2015-6-25
	 * @return
	 */
	public String ajaxEAblePartFixItems(){
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
					PJFixRecord pJFixRecord = partFixService.findPJFixRecordById(Long.parseLong(temp));
					pJFixRecord.setEmpaffirmtime(new Date());
					pJFixRecord.setFixemp(user.getXm());
					if(flag == 1){//启用检修配件
						pJFixRecord.setFixsituation("");
					}else{//禁用检修配件
						pJFixRecord.setFixsituation("未启用");
					}
					partFixService.savePJFixRecord(pJFixRecord);
				}
			}
		} catch (Exception e) {
			result = "failure";
			e.printStackTrace();
		}finally{
			if(pw != null){
				pw.write(result);
				pw.close();
			}
		}
		return null;
	}
	/**
	 * 进入委外检修页面
	 * @return
	 */
	public String trustOutsideFixInput(){
		Long pjdid=Long.parseLong(request.getParameter("pjdid"));
		request.setAttribute("pjDynamic", partFixService.getPJDynamicInfoById(pjdid));
		return "trustFix";
	}
	
	/**
	 * 委外检修
	 * @return
	 */
	public String trustOutsideFix(){
		HttpServletResponse response=ServletActionContext.getResponse();
		Long pjdid=Long.parseLong(request.getParameter("pjdid"));
		String trustFactory=request.getParameter("trustFactory");
		String trustother=request.getParameter("trustother");
		partFixService.saveTrustPjFix(pjdid, trustFactory, trustother);
		response.setContentType("text/plain");
		try {
			response.getWriter().write("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public PageModel getPageModel() {
		return pageModel;
	}

	public void setPageModel(PageModel pageModel) {
		this.pageModel = pageModel;
	}

	public PJDatePlan getDatePlan() {
		return datePlan;
	}

	public void setDatePlan(PJDatePlan datePlan) {
		this.datePlan = datePlan;
	}

	public PJFixRecord getPjFixRecord() {
		return pjFixRecord;
	}

	public void setPjFixRecord(PJFixRecord pjFixRecord) {
		this.pjFixRecord = pjFixRecord;
	}

	public List<Long> getPjdids() {
		return pjdids;
	}

	public void setPjdids(List<Long> pjdids) {
		this.pjdids = pjdids;
	}

	@Override
	public void setServletRequest(HttpServletRequest req) {
		this.request = req;
	}

	public String getJcsType() {
		return jcsType;
	}

	public void setJcsType(String jcsType) {
		this.jcsType = jcsType;
	}

	public Long getFirstUnitId() {
		return firstUnitId;
	}

	public void setFirstUnitId(Long firstUnitId) {
		this.firstUnitId = firstUnitId;
	}

	public String getPjName() {
		return pjName;
	}

	public void setPjName(String pjName) {
		this.pjName = pjName;
	}

	public String getPjNum() {
		return pjNum;
	}

	public void setPjNum(String pjNum) {
		this.pjNum = pjNum;
	}

	public Integer getPjStatus() {
		return pjStatus;
	}

	public void setPjStatus(Integer pjStatus) {
		this.pjStatus = pjStatus;
	}
}
