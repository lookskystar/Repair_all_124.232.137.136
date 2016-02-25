package com.repair.work.action;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
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
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCCharge;
import com.repair.common.pojo.JCChoice;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJPresetRelateID;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.PresetRelateID;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.part.service.PJManageService;
import com.repair.work.service.PresetDivisionService;
import com.repair.work.service.UsersPrivsService;

/**
 * 预设分工
 * @author Administrator
 *
 */
public class PresetDivisionAction {
	
	@Resource(name="presetDivisionService")
	private PresetDivisionService presetDivisionService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="pjManageService")
	private PJManageService pjManageService;
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	/**
	 * 进入预设分类页面
	 * @return
	 */
	public String presetDivisionInput(){
		String jcType=request.getParameter("jcType");
		Integer nodeId = Integer.parseInt(request.getParameter("nodeId"));
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Long proteamid = null;
		if(request.getParameter("bzid")!=null && !"".equals(request.getParameter("bzid"))){
			proteamid  = Long.parseLong(request.getParameter("bzid"));
		}
		if(jcType==null){
			jcType="SS3B";//默认为DF4
		}
		//根据机车类型和班组ID查询预设分类信息
		if (null != proteamid) {
			List<PresetDivision> presets=presetDivisionService.getPresetDivisonByTypeId(jcType, proteamid,nodeId);
			request.setAttribute("presets", presets);
			//根据班组ID和机车类型查询班组下的项目
			List<JCFixitem>  jcFixitem=presetDivisionService.getJCFixitemByBzId(jcType,proteamid,nodeId);
			Map<String,List<JCFixitem>> itemMap = new HashMap<String, List<JCFixitem>>();
			String secUnitName = null;
			for (JCFixitem it : jcFixitem) {
				secUnitName = it.getSecUnitName();
				if(itemMap.get(secUnitName)==null){
					itemMap.put(secUnitName, new ArrayList<JCFixitem>());
				}
				itemMap.get(secUnitName).add(it);
			}
			request.setAttribute("itemMap", itemMap);
			//request.setAttribute("jcFixitem", jcFixitem);
		}
		//机车型号
		List<DictJcStype> dictJcTypeList = presetDivisionService.listJcSType();
		//查询所有的工作班组
		List<DictProTeam> dictProTeamList = this.presetDivisionService.findWorkDictProTeam();
		request.setAttribute("nodeId", nodeId);
		request.setAttribute("jcType", jcType);
		request.setAttribute("proteamid", proteamid);
		request.setAttribute("dictJcTypeList", dictJcTypeList);
		request.setAttribute("dictProTeamList", dictProTeamList);
		return "presetDivision";
	}
	
	/**
	 * 进入中修预设分类页面
	 * @return
	 */
	public String presetZxDivisionInput(){
		String jcType=request.getParameter("jcType");
		Integer nodeId = Integer.parseInt(request.getParameter("nodeId"));
		String zxFlag=request.getParameter("zxFlag");//中修判别字段
		Long proteamid = null;
		if(request.getParameter("bzid")!=null && !"".equals(request.getParameter("bzid"))){
			proteamid  = Long.parseLong(request.getParameter("bzid"));
		}
		if(jcType==null){
			jcType="SS3B";//默认为DF4
		}
		//根据机车类型和班组ID查询预设分类信息
		if (null != proteamid) {
			List<PresetDivision> presets=presetDivisionService.getPresetDivisonByTypeId(jcType, proteamid,nodeId);
			request.setAttribute("presets", presets);
			//根据班组ID和机车类型查询班组下的项目
			List<JCZXFixItem>  jcFixitem=presetDivisionService.getJCZxFixitemByBzId(jcType,proteamid,nodeId);
			Map<String,List<JCZXFixItem>> itemMap = new HashMap<String, List<JCZXFixItem>>();
			String secUnitName = null;
			for (JCZXFixItem it : jcFixitem) {
				secUnitName = it.getUnitName();
				if(itemMap.get(secUnitName)==null){
					itemMap.put(secUnitName, new ArrayList<JCZXFixItem>());
				}
				itemMap.get(secUnitName).add(it);
			}
			request.setAttribute("itemMap", itemMap);
		}
		int zx=zxFlag==null?0:1;
		//机车型号
		List<DictJcStype> dictJcTypeList = presetDivisionService.listJcSType();
		//查询所有的工作班组
		List<DictProTeam> dictProTeamList = this.presetDivisionService.findWorkDictProTeam(zx);
		request.setAttribute("nodeId", nodeId);
		request.setAttribute("jcType", jcType);
		request.setAttribute("proteamid", proteamid);
		request.setAttribute("dictJcTypeList", dictJcTypeList);
		request.setAttribute("dictProTeamList", dictProTeamList);
		return "zx_presetDivision";
	}
	
	/**
	 * 进入配件预设分类管理页面
	 * @return
	 */
	public String pjPresetDivisionInput(){
		String id=request.getParameter("pjsId");
		if(id!=null&&!"".equals(id)){
			Long pjsId=Long.parseLong(id);
			List<PJPresetDivision> presets=presetDivisionService.findPJPresetDivision(pjsId);
			List<PJFixItem> pjFixItems=presetDivisionService.findPJFixItem(pjsId);
			Map<String,List<PJFixItem>> itemMap=new HashMap<String,List<PJFixItem>>();
			for(PJFixItem pjFixItem:pjFixItems){
				String pjName=pjFixItem.getPjName();
				if(itemMap.get(pjName)==null){
					itemMap.put(pjName, new ArrayList<PJFixItem>());
				}
				itemMap.get(pjName).add(pjFixItem);
			}
			request.setAttribute("presets", presets);
			request.setAttribute("itemMap", itemMap);
		}
		//机车型号
		List<DictJcStype> dictJcTypeList = presetDivisionService.listJcSType();
		//查询所有的工作班组
		List<DictProTeam> dictProTeamList = this.presetDivisionService.findWorkDictProTeam(1);
		request.setAttribute("dictJcTypeList", dictJcTypeList);
		request.setAttribute("dictProTeamList", dictProTeamList);
		
		String jcType=request.getParameter("jcType");
		String bzid=request.getParameter("bzid");
		if(jcType!=null&&bzid!=null){
			List<PJStaticInfo> pjStaticInfos=presetDivisionService.findPJStaticInfo(jcType, bzid);
			request.setAttribute("pjsId",id);
			request.setAttribute("pjStaticInfos", pjStaticInfos);
			request.setAttribute("jcType", request.getParameter("jcType"));
			request.setAttribute("bzid", request.getParameter("bzid"));
		}
		return "pj_presetDivision";
	}
	
	/**
	 * ajax得到配件项目名称
	 * @return
	 * @throws JSONException 
	 * @throws IOException 
	 */
	public String ajaxGetPjName() throws JSONException, IOException{
		String jcType=request.getParameter("jcType");
		String bzid=request.getParameter("bzid");
		List<PJStaticInfo> pjStaticInfos=presetDivisionService.findPJStaticInfo(jcType, bzid);
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		if(pjStaticInfos!=null&&pjStaticInfos.size()>0){
			for(PJStaticInfo pjStaticInfo:pjStaticInfos){
				obj=new JSONObject();
				obj.put("pjsId", pjStaticInfo.getPjsid());
				obj.put("pjName", pjStaticInfo.getPjName());
				array.put(obj);
			}
			JSONObject object=new JSONObject();
			object.put("datas", array);
			response.setContentType("text/plain");
			response.getWriter().write(object.toString());
		}else{
			response.getWriter().write("no_data");
		}
		return null;
	}
	
	/**
	 * 进入添加预设大类
	 */
	public String savePresetDivisionInput() throws Exception {
		//UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		//request.setAttribute("users", usersPrivsService.listUsersByBzId(user.getBzid()));
		Long proteamid= Long.parseLong(request.getParameter("bzid"));
		request.setAttribute("users", usersPrivsService.listUsersByBzId(proteamid));
		request.setAttribute("nodeId", request.getParameter("nodeId"));
		request.setAttribute("jctype", request.getParameter("jctype"));
		request.setAttribute("bzid", proteamid);
		return "addPressetDivision";
	}
	
	/**
	 * 进入添加预设大类
	 */
	public String saveZxPresetDivisionInput() throws Exception {
		//UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		//request.setAttribute("users", usersPrivsService.listUsersByBzId(user.getBzid()));
		Long proteamid= Long.parseLong(request.getParameter("bzid"));
		request.setAttribute("users", usersPrivsService.listUsersByBzId(proteamid));
		request.setAttribute("nodeId", request.getParameter("nodeId"));
		request.setAttribute("jctype", request.getParameter("jctype"));
		request.setAttribute("bzid", proteamid);
		return "zx_addPressetDivision";
	}
	
	/**
	 * 进入配件添加预设分工大类页面
	 * @return
	 */
	public String savePJPresetDivisionInput(){
		Long pjsId=Long.parseLong(request.getParameter("pjsId"));
	    PJStaticInfo pjStaticInfo=pjManageService.findPJStaticInfoById(pjsId);
	    request.setAttribute("pjStaticInfo", pjStaticInfo);
		return "pj_addPressetDivision";
	}
	
	/**
	 * 保存配件预设分工信息
	 * @return
	 */
	public String savePJPresetDivision(){
		Long pjsId=Long.parseLong(request.getParameter("pjsId"));
		PJStaticInfo pjStaticInfo=pjManageService.findPJStaticInfoById(pjsId);
		String presetName=request.getParameter("presetName");
		PJPresetDivision pjPreset=new PJPresetDivision();
		pjPreset.setPjsId(pjStaticInfo);
		pjPreset.setPresetName(presetName);
		presetDivisionService.savePJPresetDivision(pjPreset);
		response.setContentType("text/plain");
		try {
			response.getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 添加预设分工信息
	 * @return
	 */
	public String savePresetDivision()throws Exception{
		String clsName=request.getParameter("clsName");//预设分类名称
		String jcValue=request.getParameter("jcValue");//机车类型
		String workers = request.getParameter("workers");//检修人ID
		String workerNames = request.getParameter("workerNames");//检修人姓名
		String bzid = request.getParameter("bzid");//班组ID
		Integer nodeId = Integer.parseInt(ServletActionContext.getRequest().getParameter("nodeId"));
		PresetDivision pd=new PresetDivision();
		pd.setClsName(clsName);
		pd.setJcValue(jcValue);
		pd.setNodeId(nodeId);
		pd.setFixEmpIds(","+workers);
		pd.setFixEmpNames(","+workerNames);
		DictProTeam proteam=new DictProTeam();
//		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Long proteamid = Long.parseLong(bzid);
		proteam.setProteamid(proteamid);//班组ID从session中取
		pd.setProTeam(proteam);
		presetDivisionService.savePresetDivison(pd);
		response.setContentType("text/plain");
		response.getWriter().print("success");
		return null;
	}
	
	/**
	 * 进入修改
	 */
	public String updatePresetDivisionInput() throws Exception {
		String presetId=request.getParameter("presetId");
		String bzid = request.getParameter("bzid");
		PresetDivision division = presetDivisionService.getPresetDivisionById(Integer.parseInt(presetId));
		request.setAttribute("division", division);
		//UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		request.setAttribute("users", usersPrivsService.listUsersByBzId(Long.parseLong(bzid)));
		return "updatePressetDivision";
	}
	
	/**
	 * 进入修改
	 */
	public String updateZxPresetDivisionInput() throws Exception {
		String presetId=request.getParameter("presetId");
		String bzid = request.getParameter("bzid");
		PresetDivision division = presetDivisionService.getPresetDivisionById(Integer.parseInt(presetId));
		request.setAttribute("division", division);
		//UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		request.setAttribute("users", usersPrivsService.listUsersByBzId(Long.parseLong(bzid)));
		return "zx_updatePressetDivision";
	}
	
	/**
	 * 进入修改配件预设分类页面
	 * @return
	 */
	public String updatePJPresetDivisionInput(){
		String presetId=request.getParameter("presetId");
		PJPresetDivision pjDivsion=presetDivisionService.getPJPresetDivisionById(Long.parseLong(presetId));
		request.setAttribute("pjDivision", pjDivsion);
		return "pj_updatePressetDivision";
	}
	
	/**
	 * 修改配件预设分类信息
	 * @return
	 */
	public String updatePJPresetDivision(){
		String presetId=request.getParameter("presetId");
		Long pjsId=Long.parseLong(request.getParameter("pjsId"));
		String presetName=request.getParameter("presetName");
		PJStaticInfo pjStaticInfo=pjManageService.findPJStaticInfoById(pjsId);
		PJPresetDivision pjDivsion=presetDivisionService.getPJPresetDivisionById(Long.parseLong(presetId));
		pjDivsion.setPresetName(presetName);
		pjDivsion.setPjsId(pjStaticInfo);
		presetDivisionService.savePJPresetDivision(pjDivsion);
		response.setContentType("text/plain");
		try {
			response.getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改
	 */
	public String updatePresetDivision() throws Exception {
		String presetId=request.getParameter("presetId");
		String clsName=request.getParameter("clsName");//预设分类名称
		String workers = request.getParameter("workers");//检修人ID
		String workerNames = request.getParameter("workerNames");//检修人姓名
		PresetDivision division = presetDivisionService.getPresetDivisionById(Integer.parseInt(presetId));
		division.setClsName(clsName);
		division.setFixEmpIds(","+workers);
		division.setFixEmpNames(","+workerNames);
		presetDivisionService.savePresetDivison(division);
		response.setContentType("text/plain");
		response.getWriter().print("success");
		return null;
	}
	
	/**
	 * 根据班组ID,预分类ID得到所有的项目
	 * @return
	 * @throws JSONException 
	 */
	public String getJCFixitemByYsId() throws Exception{
		String ysId=request.getParameter("ysId");
		//根据班组ID和机车类型查询班组下的分解项目
		List<PresetRelateID>  presetRelateId=presetDivisionService.getPresetRelateByYsId(Integer.parseInt(ysId));
		JSONObject obj=new JSONObject();
		JSONArray array=new JSONArray();
		JSONObject obj2=null;
		for(PresetRelateID list:presetRelateId){
			obj2=new JSONObject();
			obj2.put("itemId", list.getFixitem().getThirdUnitId());
			array.put(obj2);
		}
		obj.put("itemIds", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj.toString());
		return null;
	}
	
	/**
	 * 根据班组ID,预分类ID得到所有的项目
	 * @return
	 * @throws JSONException 
	 */
	public String getJCZxFixitemByYsId() throws Exception{
		String ysId=request.getParameter("ysId");
		//根据班组ID和机车类型查询班组下的分解项目
		List<PresetRelateID>  presetRelateId=presetDivisionService.getPresetRelateByYsId(Integer.parseInt(ysId));
		JSONObject obj=new JSONObject();
		JSONArray array=new JSONArray();
		JSONObject obj2=null;
		for(PresetRelateID list:presetRelateId){
			obj2=new JSONObject();
			obj2.put("itemId", list.getJcZXFixItemId().getId());
			array.put(obj2);
		}
		obj.put("itemIds", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj.toString());
		return null;
	}
	
	/**
	 * 根据班组ID,预分类ID得到所有的配件项目
	 * @return
	 * @throws JSONException 
	 */
	public String getPJFixitemByYsId() throws Exception{
		String ysId=request.getParameter("ysId");
		//根据班组ID和机车类型查询班组下的分解项目
		List<PJPresetRelateID>  pjPresetRelateId=presetDivisionService.getPJPresetRelateByYsId(Long.parseLong(ysId));
		JSONObject obj=new JSONObject();
		JSONArray array=new JSONArray();
		JSONObject obj2=null;
		for(PJPresetRelateID list:pjPresetRelateId){
			obj2=new JSONObject();
			obj2.put("itemId", list.getPjFixItemId().getPjItemId());
			array.put(obj2);
		}
		obj.put("itemIds", array);
		response.setContentType("text/plain");
		response.getWriter().print(obj.toString());
		return null;
	}
	
	/**
	 * 将预设分工大类和项目关联
	 * @return
	 * @throws IOException 
	 */
	public String updateJCFixitemYsId() throws IOException{
		String presetId=request.getParameter("presetId");
		String ids=request.getParameter("ids");
	    if(ids!=null){
	    	String[] str=ids.split("-");
	    	presetDivisionService.savePresetRelateId(str,Integer.parseInt(presetId));
	    }else{
	    	presetDivisionService.savePresetRelateId(new String[]{},Integer.parseInt(presetId));
	    }
	    response.setContentType("text/plain");
		response.getWriter().print("success");
		return null;
	}
	
	/**
	 * 将预设分工大类和项目关联
	 * @return
	 * @throws IOException 
	 */
	public String updateJCZxFixitemYsId() throws IOException{
		String presetId=request.getParameter("presetId");
		String ids=request.getParameter("ids");
	    if(ids!=null){
	    	String[] str=ids.split("-");
	    	presetDivisionService.saveZxPresetRelateId(str,Integer.parseInt(presetId));
	    }else{
	    	presetDivisionService.saveZxPresetRelateId(new String[]{},Integer.parseInt(presetId));
	    }
	    response.setContentType("text/plain");
		response.getWriter().print("success");
		return null;
	}
	
	/**
	 * 将预设分工大类和配件项目关联
	 * @return
	 * @throws IOException 
	 */
	public String updatePJFixitemYsId() throws IOException{
		String presetId=request.getParameter("presetId");
		String ids=request.getParameter("ids");
	    if(ids!=null){
	    	String[] str=ids.split("-");
	    	presetDivisionService.savePJPresetRelateId(str,Long.parseLong(presetId));
	    }else{
	    	presetDivisionService.savePJPresetRelateId(new String[]{},Long.parseLong(presetId));
	    }
	    response.setContentType("text/plain");
		response.getWriter().print("success");
		return null;
	}
	
	
	/**
	 * 删除预设分类信息
	 * @return
	 * @throws IOException 
	 */
	public String delPresetDivision() throws IOException{
		String ysId=request.getParameter("ysId");
		presetDivisionService.delPresetDivisonByYsId(Integer.parseInt(ysId));
		response.setContentType("text/plain");
	    response.getWriter().print("success");
		return null;
	}
	
	/**
	 * 删除配件预设分工信息
	 * @return
	 */
	public String delPJPresetDivision(){
		String ysId=request.getParameter("ysId");
		presetDivisionService.delPJPresetDivisonByYsId(Long.parseLong(ysId));
		response.setContentType("text/plain");
	    try {
			response.getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	/**
	 * 进入技术、质检预分工页面
	 * @return
	 */
	@SuppressWarnings("unchecked")
	public String techDivisionInput(){
		List<DictProTeam> proTeams=presetDivisionService.getDictProTeamAll();//查询所有班组信息
		List<UsersPrivs> usersPrivsList = usersPrivsService.getZJJSUsers();//查询质检技术员
		String userId = request.getParameter("userId");
		UsersPrivs user = null;
		List<DictProTeam> checkProTeams = null;
		if(!"".equals(userId) && null != userId){
			user = (UsersPrivs)usersPrivsService.getUsersPrivsById(Integer.valueOf(userId));
			//查询用户已分班组
			checkProTeams=presetDivisionService.getJCChargeByBzUser(user);
		}
		//用户已选分组信息
		//request.setAttribute("checkProTeams", checkProTeams);
		request.setAttribute("proTeams", proTeams);
		request.setAttribute("userId", userId);
		request.setAttribute("usersPrivsList", usersPrivsList);
		return "techDivisionInput";
	}
	
	/**
	 * 查询质检技术已分班组
	 * @throws JSONException 
	 * @throws IOException 
	 */
	public String ajaxGetCharge() throws JSONException, IOException{
		String userId = request.getParameter("userid");
		UsersPrivs user = null;
		List<DictProTeam> checkProTeams = null;
		if(!"".equals(userId) && null != userId){
			user = (UsersPrivs)usersPrivsService.getUsersPrivsById(Integer.valueOf(userId));
			//查询用户已分班组
			checkProTeams=presetDivisionService.getJCChargeByBzUser(user);
		}
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		for(DictProTeam dictProTeam:checkProTeams){
			obj=new JSONObject();
			obj.put("proTeamName", dictProTeam.getProteamname());
			array.put(obj);
		}
		JSONObject DPTObject = new JSONObject();
		DPTObject.put("datas", array);
		response.getWriter().print(DPTObject.toString());
		return null;
	}
	
	
	/**
	 * 根据班组ID获得班组下的所有检修项目
	 * @return
	 */
	public String getTeamItems(){
		String userId = request.getParameter("userid");
		UsersPrivs user = null;
		if(!"".equals(userId) && null != userId){
			user = (UsersPrivs)usersPrivsService.getUsersPrivsById(Integer.valueOf(userId));
		}
		long teamId=Long.parseLong(request.getParameter("teamId"));
		String jcType=request.getParameter("jcType");
		String jcStype=request.getParameter("jcStype");
		List<JCFixitem> fixItems=presetDivisionService.getJCFixitemByBzId(teamId,jcStype);
		//根据用户和班组ID获得用户已分项目信息
		List<JCCharge> ysCharge=presetDivisionService.getJCChargeByItemUserId(user, teamId);
		List<Map<String,Object>> fixItemList=new ArrayList<Map<String,Object>>();
		
		for(JCFixitem jcf:fixItems){
			int status=0;//分配班组标识 0：未分配 1：已经分配
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("thirdUnitId", jcf.getThirdUnitId());
			map.put("itemName", jcf.getItemName());
			map.put("jcsType", jcf.getJcsType());
			if(ysCharge!=null&&ysCharge.size()>0){
				for(JCCharge jc:ysCharge){
					if(jcf==jc.getFixitem()){
						status=1;
						break;
					}
				}
			}
			map.put("status", status);
			fixItemList.add(map);
		}
		
		
		//判断质检技术已分配项目，则不能再次分配
	/*	List<Map<String,Object>> fixItemList=new ArrayList<Map<String,Object>>();
		for(JCFixitem jcf:fixItems){
			int status=0;//分配班组标识 0：未分配 1：已经分配
			Map<String,Object> map=new HashMap<String,Object>();
			//根据项目ID查询项目是否已经分配了管辖班组
			List<JCCharge> list=presetDivisionService.getJCChargeByItemId(jcf.getThirdUnitId());
			map.put("thirdUnitId", jcf.getThirdUnitId());
			map.put("itemName", jcf.getItemName());
			map.put("jcsType", jcf.getJcsType());
			if(null != list &&list.size()>0){
				for(JCCharge jcCharge:list){
					long userId=jcCharge.getUser().getUserid();
					//判断登录用户角色是否在管辖班组信息中分工
					if(isRole(userId,user)){//已分工
						status=1;
						break;
					}
				}
			}
			map.put("status", status);
			fixItemList.add(map);
		}*/
		request.setAttribute("fixItemList", fixItemList);
		return "teamItems";
	}
	
	/**
	 * 保存质检、技术管辖班组信息
	 * @return
	 */
	public String saveCharge(){
		long teamId=Long.parseLong(request.getParameter("teamId"));
		String itemIds=request.getParameter("iteamIds");
		int status=Integer.parseInt(request.getParameter("status"));
		String ids[]=itemIds.split("-");
		String userId = request.getParameter("userId");
		UsersPrivs user = (UsersPrivs)usersPrivsService.getUsersPrivsById(Integer.valueOf(userId));
		boolean zjRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY);
		boolean jsRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY);
		String result="failure";
		if(zjRole||jsRole){//质检和技术可进行分工
			try {
				presetDivisionService.saveCharge(ids, teamId, user, status);
				result="success";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			result="no_authority";//没有权限
		}
		
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 删除质检、技术管辖班组信息
	 * @return
	 */
	public String deleteCharge(){
		String userId = request.getParameter("userid");
		UsersPrivs user = null;
		if(!"".equals(userId) && null != userId){
			user = (UsersPrivs)usersPrivsService.getUsersPrivsById(Integer.valueOf(userId));
		}
		long teamId=Long.parseLong(request.getParameter("teamId"));
		List<JCCharge> jcCharges=presetDivisionService.getJCChargeByItemUserId(user, teamId);
		String result="failure";
		boolean zjRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY);
		boolean jsRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY);
		if(zjRole||jsRole){//质检和技术可进行删除
			if(jcCharges!=null&&jcCharges.size()>0){
				try {
					presetDivisionService.deleteJcCharge(user, teamId);
					result="success";
				} catch (Exception e) {
					e.printStackTrace();
				}
			}else{
				result="no_result";//没有分配信息
			}
		}else{
			result="no_authority";
		}
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public String techDivisionJcInput(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		List<DatePlanPri> divisionJcs=presetDivisionService.getDivsionJc();
		List<JCChoice> jcChoice=presetDivisionService.getJCChoiceByUser(user);
		List<JCChoice> allJcChoice = presetDivisionService.getJCChoice();
		List<Map<String,Object>> divisions=new ArrayList<Map<String,Object>>();
		String[] temp = null;
		
		for(DatePlanPri dp:divisionJcs){
			int status=0;//分配人标识 0：未分配 1：已经分配
			Map<String,Object> map=new HashMap<String,Object>();
			map.put("rjhmId", dp.getRjhmId());
			map.put("jcType", dp.getJcType());
			map.put("jcnum",dp.getJcnum());
			map.put("fixFreque", dp.getFixFreque());
			map.put("kcsj", dp.getKcsj());
			map.put("jcgz", dp.getGongZhang().getXm());
			for(JCChoice jc:jcChoice){
				if(dp==jc.getDpId()){
					status=1;
				}
			}
			temp = getChoiceOfRoles(dp.getRjhmId(),allJcChoice);
			map.put("jsy", temp[0]);
			map.put("zjy", temp[1]);
			map.put("ysy", temp[2]);
			
			map.put("status", status);
			divisions.add(map);
		}
		request.setAttribute("divisionJcs", divisions);
		request.setAttribute("jcChoice", jcChoice);
		return "techDivisionJcInput";
	}
	
	/**
	 * 保存质检技术管辖机车信息
	 * @return
	 */
	public String saveChoice(){
		String dpIds=request.getParameter("dpIds");
		String ids[]=dpIds.split("-");
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		boolean zjRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY);
		boolean jsRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY);
		boolean ysRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY);
		String result="failure";
		if(zjRole||jsRole||ysRole){//质检和技术、验收员可进行分工
			try {
				presetDivisionService.saveChoice(ids,user);
				result="success";
			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			result="no_authority";//没有权限
		}
		
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
    /**
     * 判断登录用户角色是否和已分工用户角色一样
     * @param userId 项目已分工质检、技术ID
     * @param user 登录用户角色
     * @return
     */
	private boolean isRole(long userId,UsersPrivs user){
		boolean flag=false;
		boolean loginZjRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY);//登录为质检员
		boolean loginJsRole=usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY);//登录为技术员
		boolean itemZjRole=usersPrivsService.isHasRole(userId, Contains.ROLE_NAME_ZJY);//项目已分给质检员
		boolean itemJsRole=usersPrivsService.isHasRole(userId, Contains.ROLE_NAME_JSY);//项目已分给技术员
		if(loginZjRole&&itemZjRole){
			flag=true;
		}
		if(loginJsRole&&itemJsRole){
			flag=true;
		}
		return flag;
	}
	
	/**
	 * 获取不同角色的机车负责人
	 */
	private String[] getChoiceOfRoles(Integer rjhmId,List<JCChoice> choices){
		String[] names = new String[]{"","",""};
		UsersPrivs user;
		for (JCChoice jcc : choices) {
			if(jcc.getDpId().getRjhmId().equals(rjhmId)){
				user = jcc.getUserId();
				if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY)){
					names[0] += user.getXm()+",";
				}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY)){
					names[1] += user.getXm()+",";
				}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY)){
					names[2] += user.getXm()+",";
				}
			}
		}
		return names;
	}
}
