package com.repair.part.action;

import java.io.IOException;
import java.io.UnsupportedEncodingException;
import java.lang.reflect.InvocationTargetException;
import java.net.URLDecoder;
import java.net.URLEncoder;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.Iterator;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.commons.lang.StringUtils;
import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.opensymphony.xwork2.ModelDriven;
import com.repair.common.pojo.Addvancetip;
import com.repair.common.pojo.Deliverytip;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PDeliverytip;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixFlowType;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJHandoverRecord;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.Storetip;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.common.util.PageModel;
import com.repair.part.service.PJManageService;
import com.repair.plan.dao.DictProTeamDao;
import com.repair.plan.service.PdiFroemanManageService;
import com.repair.work.service.WorkService;

/**
 * 配件管理
 * @author Administrator
 *
 */
public class PJManageAction implements ModelDriven<PDeliverytip>{
	
	private PDeliverytip pDeliverytip = null;
	
	@Override
	public PDeliverytip getModel() {
		if(pDeliverytip == null){
			pDeliverytip = new  PDeliverytip();
		}
		return pDeliverytip;
	}
	
	@Resource(name = "pdiFroemanManageService")
	private PdiFroemanManageService pdiFroemanManageService;
	@Resource(name="pjManageService")
	private PJManageService pjManageService;
	@Resource(name="workService")
	private WorkService workService;
	@Resource(name = "dictProTeamDao")
	private DictProTeamDao dictProTeamDao;
	
	private HttpServletRequest request=ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	//查询条件机车型号
	private String jcsType;
	//查询条件一级部件
	private Long firstUnitId;
	//查询条件一级部件名称
	private String firstUnitName;
	//查询条件流程类型ID
	private Integer flowTypeId;
	// 配件状态
	private Integer pjStatus;
	//配件名称
	private String pjName;
	//配件编号
	private String pjNum;
	//存储位置
	private Integer storePosition;
	//静态配件Bean类
	private PJStaticInfo pjStatic;
	//动态配件Bean类
	private PJDynamicInfo pjDy;
	
	//配件ID信息
	private Long pjId;
	
	private String id;
	private String ids;
	
	//配件库存单
	private Storetip storetip; 
	
	//配件预领单
	private Addvancetip addvancetip;
	
	
	/**
	 * 进入静态配件信息列表
	 * @return
	 * @throws UnsupportedEncodingException 
	 */
	public String staticPJListInput(){
		UsersPrivs user = (UsersPrivs) ServletActionContext.getRequest().getSession().getAttribute("session_user");
		Long bzId = user.getBzid();
		DictProTeam dictProTeam = null;
		Integer workFlag = null;
		Integer zxWorkFlag = null;
		if(bzId != null){
			dictProTeam = dictProTeamDao.findDictProTeamById(bzId);
			workFlag = dictProTeam.getWorkflag();
			zxWorkFlag = dictProTeam.getZxFlag();
		}
		String urlName=request.getParameter("urlName");
		List<DictJcStype> jcsTypes = pjManageService.findDictJcStype();
		List<PJFixFlowType> flowTypes = pjManageService.findPJFixFlowType();
		List<DictFirstUnit> firstunits = pjManageService.findDictFirstUnit(jcsType);
		if(pjName !=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		
		PageModel<PJStaticInfo> pm = new PageModel<PJStaticInfo>();//分页
		if(dictProTeam == null){
			pm = pjManageService.findPJStaticInfo1(jcsType,firstUnitName,flowTypeId,pjName, null);
		}else {
			if((workFlag == null || workFlag == 0) &&  (zxWorkFlag == null || zxWorkFlag == 0)){
				pm = pjManageService.findPJStaticInfo1(jcsType,firstUnitName,flowTypeId,pjName, null);
			}else {
				pm = pjManageService.findPJStaticInfo1(jcsType,firstUnitName,flowTypeId,pjName, bzId.toString());
			}
		}
		request.setAttribute("pm", pm);
		request.setAttribute("urlName", urlName);
		request.setAttribute("jcsTypes", jcsTypes);
		request.setAttribute("flowTypes", flowTypes);
		request.setAttribute("firstunits", firstunits);
		return "staticPJList";
	}
	
	/**
	 * ajax得到一级部件
	 * @return
	 * @throws JSONException 
	 */
	public String ajaxGetFirstUnit() throws JSONException{
		String jcsType=request.getParameter("jcsType");
		List<DictFirstUnit> firstunits=pjManageService.findDictFirstUnit(jcsType);
		JSONArray array=new JSONArray();
		JSONObject map=new JSONObject();
		JSONObject obj=null;
		for(DictFirstUnit firstUnit:firstunits){
			obj=new JSONObject();
			obj.put("firstUnitId", firstUnit.getFirstunitid());
			obj.put("firstUnitName",firstUnit.getFirstunitname());
			array.put(obj);
		}
		map.put("firstUnits", array);
		response.setContentType("plain/text");
		try {
			response.getWriter().print(map.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入添加静态信息页面
	 * @return
	 */
	public String addPjStaticInfoInput(){
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		request.setAttribute("flowTypes", pjManageService.findPJFixFlowType());
		return "addPjStaticInfo";
	}
	
	/**
	 * 添加静态配件信息
	 * @return
	 */
	public String addPjStaticInfo(){
		pjStatic.setJwdCode("0805");
		pjStatic.setVisitRecord(0);
		pjManageService.saveOrUpdatePJStaticInfo(pjStatic);
		request.setAttribute("message", "静态配件信息添加成功!");
		return staticPJListInput();
	}
	
	/**
	 * 进入修改配件信息页面
	 * @return
	 */
	public String updatePjStaticInfoInput(){
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		request.setAttribute("flowTypes", pjManageService.findPJFixFlowType());
		request.setAttribute("pjStatic", pjManageService.findPJStaticInfoById(pjId));
		return "updatePjStaticInfo";
	}
	
	/**
	 * 更新配件静态信息
	 * @return
	 */
	public String updatePjStaticInfo(){
		PJStaticInfo pjStaticInfo=pjManageService.findPJStaticInfoById(pjStatic.getPjsid());
		pjStaticInfo.setJwdCode("0805");
		pjStaticInfo.setVisitRecord(0);
		pjStaticInfo.setJcType(pjStatic.getJcType());
		pjStaticInfo.setLowestStore(pjStatic.getLowestStore());
		pjStaticInfo.setMostStore(pjStatic.getMostStore());
		PJFixFlowType pjFixFlowType=new PJFixFlowType();
		pjFixFlowType.setFlowTypeId(pjStatic.getPjFixFlowType().getFlowTypeId());
		pjStaticInfo.setPjFixFlowType(pjFixFlowType);
		pjStaticInfo.setPjName(pjStatic.getPjName());
		DictFirstUnit firstUnit=new DictFirstUnit();
		firstUnit.setFirstunitid(pjStatic.getFirstUnit().getFirstunitid());
		pjStaticInfo.setFirstUnit(firstUnit);
		pjManageService.saveOrUpdatePJStaticInfo(pjStaticInfo);
		request.setAttribute("message", "静态配件信息修改成功!");
		return staticPJListInput();
	}
	
	/**
	 * 删除静态配件信息
	 * @return
	 */
	public String delPjStaticInfo(){
		String pjIds=request.getParameter("pjIds");
		request.setAttribute("message", pjManageService.delPJStaticInfo(pjIds));
		return staticPJListInput();
	}
	
	/**
	 * 进入动态配件信息列表
	 * @return
	 */
	public String dyPJListInput(){
		UsersPrivs user = (UsersPrivs) ServletActionContext.getRequest().getSession().getAttribute("session_user");
		Long bzId = user.getBzid();
		DictProTeam dictProTeam = null;
		Integer workFlag = null;
		Integer zxWorkFlag = null;
		if(bzId != null){
			dictProTeam = dictProTeamDao.findDictProTeamById(bzId);
			workFlag = dictProTeam.getWorkflag();
			zxWorkFlag = dictProTeam.getZxFlag();
		}
		String urlName=request.getParameter("urlName");
		if(pjName !=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(pjNum !=null && !"".equals(pjNum)){
			pjNum = pjNum.trim();
		}
		String getOnNum = request.getParameter("getOnNum");
		if(getOnNum!=null && !"".equals(getOnNum)){
			getOnNum = getOnNum.toUpperCase().trim();
		}
		PageModel<PJDynamicInfo> pm = null;
		if(dictProTeam == null){
			pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, null);
		}else {
			if((workFlag == null || workFlag == 0) &&  (zxWorkFlag == null || zxWorkFlag == 0)){
				pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, null);
			}else {
				pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, bzId.toString());
			}
		}
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		request.setAttribute("pm", pm);
		request.setAttribute("urlName", urlName);
		request.setAttribute("getOnNum", getOnNum);
		return "dyPJList";
	}
	//唐倩 2015-7-28处理IE6中文参数过长最后一个字乱码问题
	public String dyPJListInput1(){
		UsersPrivs user = (UsersPrivs) ServletActionContext.getRequest().getSession().getAttribute("session_user");
		Long bzId = user.getBzid();
		DictProTeam dictProTeam = null;
		Integer workFlag = null;
		Integer zxWorkFlag = null;
		if(bzId != null){
			dictProTeam = dictProTeamDao.findDictProTeamById(bzId);
			workFlag = dictProTeam.getWorkflag();
			zxWorkFlag = dictProTeam.getZxFlag();
		}
		String urlName=request.getParameter("urlName");
		if(pjName !=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				//唐倩 2015-7-14处理IE6中文参数过长最后一个字乱码问题
				pjName = pjName.substring(0,pjName.length()-2);
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		if(pjNum !=null && !"".equals(pjNum)){
			pjNum = pjNum.trim();
		}
		String getOnNum = request.getParameter("getOnNum");
		if(getOnNum!=null && !"".equals(getOnNum)){
			getOnNum = getOnNum.toUpperCase().trim();
		}
		PageModel<PJDynamicInfo> pm = null;
		if(dictProTeam == null){
			pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, null);
		}else {
			if((workFlag == null || workFlag == 0) &&  (zxWorkFlag == null || zxWorkFlag == 0)){
				pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, null);
			}else {
				pm = pjManageService.findPJDynamicInfo(jcsType,firstUnitId,pjName,pjNum,pjStatus,storePosition,getOnNum, bzId.toString());
			}
		}
		request.setAttribute("jcsTypes", pjManageService.findDictJcStype());
		request.setAttribute("pm", pm);
		request.setAttribute("urlName", urlName);
		request.setAttribute("getOnNum", getOnNum);
		return "dyPJList";
	}
	/**
	 * 进入添加动态配件信息页面
	 * @return
	 * 
	 */
	public String addPjDyInfoInput(){
		Long pjDid=request.getParameter("pjdId")==null?0:Long.parseLong(request.getParameter("pjdId"));
		Long pjSid=request.getParameter("pjsId")==null?0:Long.parseLong(request.getParameter("pjsId"));
		String pjsId = request.getParameter("pjsId");
		PJDynamicInfo dyInfo=pjManageService.findPJDynamicInfoById(pjDid);
		PJStaticInfo staticInfo=pjManageService.findPJStaticInfoById(pjSid);
		String pjName=null;
		String pjsName=null;
		if(dyInfo==null&&staticInfo!=null){
			pjName=staticInfo.getPjName();
			pjsName=staticInfo.getPjName();
		}else if(dyInfo!=null&&staticInfo!=null){
			pjName=dyInfo.getPjName();
			pjsName=staticInfo.getPjName();
		}
//		String pjName=request.getParameter("pjName");
//		if(pjName==null){
//			pjName=request.getParameter("pjsName");
//		}
//		String pjsName =  request.getParameter("pjsName");
		request.setAttribute("pjName",pjName);
		request.setAttribute("pjsName",pjsName);
		request.setAttribute("pjsId", pjsId);
		request.setAttribute("py", staticInfo==null?"":staticInfo.getPy());
		return "addPjDyInfo";
	}
	
	/**
	 * 添加配件动态信息
	 * @return
	 */
	public String addPjDyInfo(){
		String amount=request.getParameter("amount");
		if(amount!=null&&!"".equals(amount)){
			int length=Integer.parseInt(amount);
			PJDynamicInfo pjDynamic=null;
			for(int i=0;i<length;i++){
				pjDynamic=new PJDynamicInfo();
				pjDynamic.setPjName(pjDy.getPjName());
				pjDynamic.setPjStaticInfo(pjDy.getPjStaticInfo());
				pjDynamic.setStorePosition(pjDy.getStorePosition());
				pjDynamic.setPjStatus(pjDy.getPjStatus());
				pjManageService.saveOrUpdatePJDynamicInfo(pjDynamic);
				if(pjDy.getPjStatus()==0){//合格配件 ,添加一条记录
					PJFixRecord pjFixRec=new PJFixRecord();
					pjFixRec.setPjDynamicInfo(pjDynamic);
					pjFixRec.setPjname(pjDy.getPjName());
					pjFixRec.setType(3);//新增良好
					pjFixRec.setRecstas(7);
					pjManageService.savePJFixRecord(pjFixRec);
				}
			}
		}else{
			if(pjDy.getPjNum()!=null&&!"".equals(pjDy.getPjNum())){
				//查询配件编码是否存在
				PJDynamicInfo exsitPjDy=pjManageService.findPJDynamicInfoByPJNum(pjDy.getPjNum());
				if(exsitPjDy!=null){
					request.setAttribute("message", "配件编码已经存在!");
					return dyPJListInput();
				}
			}
			pjManageService.saveOrUpdatePJDynamicInfo(pjDy);
			if(pjDy.getPjStatus()==0){//合格配件 ,添加一条记录
				PJFixRecord pjFixRec=new PJFixRecord();
				pjFixRec.setPjDynamicInfo(pjDy);
				pjFixRec.setPjname(pjDy.getPjName());
				pjFixRec.setType(3);//新增良好
				pjFixRec.setRecstas(7);
				pjManageService.savePJFixRecord(pjFixRec);
			}
		}
//		pjManageService.saveOrUpdatePJDynamicInfo(pjDy);
//		if(pjDy.getPjStatus()==0){//合格配件 ,添加一条记录
//			PJFixRecord pjFixRec=new PJFixRecord();
//			pjFixRec.setPjDynamicInfo(pjDy);
//			pjFixRec.setPjname(pjDy.getPjName());
//			pjFixRec.setType(3);//新增良好
//			pjFixRec.setRecstas(7);
//			pjManageService.savePJFixRecord(pjFixRec);
//		}
		request.setAttribute("message", "动态配件信息添加成功!");
		return dyPJListInput();
	}
	
	/**
	 * 判断配件编码是否唯一
	 * @throws IOException 
	 */
	public String ajaxUniquePJNum() throws IOException{
		String pjnum = request.getParameter("pjnum").trim();
		Long pjdid=request.getParameter("pjdid")==null?null:Long.parseLong(request.getParameter("pjdid"));
		long count =  pjManageService.uniquePJNum(pjnum,pjdid);
		ServletActionContext.getResponse().getWriter().print(count);
		return null;
	}
	
	/**
	 * 进入修改动态配件信息页面
	 * @return
	 */
	public String updatePjDyInfoInput(){
		request.setAttribute("pjDy", pjManageService.findPJDynamicInfoById(pjId));
		return "updatePjDyInfo";
	}
	
	/**
	 * 修改配件动态信息
	 * @return
	 */
	public String updatePjDyInfo(){
		PJDynamicInfo pjDynamicInfo= pjManageService.findPJDynamicInfoById(pjDy.getPjdid());
		pjDynamicInfo.setPjName(pjDy.getPjName());
		PJStaticInfo pjStaticInfo=new PJStaticInfo();
		pjStaticInfo.setPjsid(pjDy.getPjStaticInfo().getPjsid());
		pjDynamicInfo.setPjStaticInfo(pjStaticInfo);
		pjDynamicInfo.setPjNum(pjDy.getPjNum());
		pjDynamicInfo.setFactoryNum(pjDy.getFactoryNum());
		pjDynamicInfo.setStorePosition(pjDy.getStorePosition());
		pjDynamicInfo.setPjStatus(pjDy.getPjStatus());
		//pjDynamicInfo.setFixFlowName(pjDy.getFixFlowName());
		pjManageService.saveOrUpdatePJDynamicInfo(pjDynamicInfo);
		request.setAttribute("message", "动态配件信息修改成功!");
		return dyPJListInput();
	}
	
	/**
	 * 删除动态配件信息
	 * @return
	 */
	public String delPjDyInfo(){
		String pjIds=request.getParameter("pjIds");
		request.setAttribute("message", pjManageService.delPJDyInfo(pjIds));
		return dyPJListInput();
	}
	
	/**
	 * 配件交接记录
	 * @return
	 */
	public String handoverRecord() {
		PageModel<Map<PJHandoverRecord, List<PJDynamicInfo>>> pageModel = pjManageService.findHandoverRecord();
		request.setAttribute("hrs", pageModel);
		return "handoverRecord";
	}
	
	/**
	 * 添加配件交接记录输入
	 * @return
	 */
	public String addHandoverRecordInput() {
		PJHandoverRecord handoverRecord = new PJHandoverRecord();
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		if (null != user) {
			handoverRecord.setComunitPeo(user.getXm());
		}
		if (null != handoverRecord) {
			pjManageService.addHandoverRecord(handoverRecord);
			request.setAttribute("message", "配件交接单添加成功！");
		} else {
			request.setAttribute("message", "配件交接单添加失败！");
		}
		return handoverRecord();
	}
	
	/**
	 * 查找要交接的动态配件
	 * @return
	 */
	public String findDynamicHandover() {
		request.setAttribute("pjdynamics", pjManageService.findPJDynamicInfoHandover(pjStatus,pjName,pjNum));
		return "dynamicHandover";
	}
	
	/**
	 * 添加配件到交接记录中
	 * @return
	 */
	public String addDynamicPJToHandoverRecord() {
		if (null != id && !"".equals(id) && null != ids && !"".equals(ids)) {
			String[] strs = ids.split(",");
			if (null != strs && strs.length > 0) {
				List<Long> list = new ArrayList<Long>();
				for (String s : strs) {
					list.add(Long.parseLong(s));
				}
				pjManageService.updatePJDynamicInfo(Integer.parseInt(id), list);
				request.setAttribute("message", "交接单添加配件成功！");
			}
		} else {
			request.setAttribute("message", "交接单添加配件失败！");
		}
		return handoverRecord();
	}
	
	/**
	 * 交接
	 * @return
	 */
	public String handover() {
		PJHandoverRecord handoverRecord = pjManageService.findPJHandoverRecord(Integer.parseInt(id));
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		if (null != user) {
			handoverRecord.setReceiptPeo(user.getXm());
			handoverRecord.setHandoverTime(new Date());
		}
		if (null != handoverRecord) {
			pjManageService.addHandoverRecord(handoverRecord);
			request.setAttribute("message", "配件交接成功！");
		} else {
			request.setAttribute("message", "配件交接失败！");
		}
		return handoverRecord();
	}
	
	/**
	 * 从交接记录中删除配件
	 * @return
	 */
	public String deleteDynamicFromHandoverRecord() {
		if (null != id && !"".equals(id)) {
			PJDynamicInfo pjDynamicInfo = pjManageService.findPJDynamicInfoById(Long.parseLong(id));
			pjDynamicInfo.setHandoverRecord(null);
			pjManageService.saveOrUpdatePJDynamicInfo(pjDynamicInfo);
			request.setAttribute("message", "配件从交接记录中删除成功！");
		}
		return handoverRecord();
	}
	
	/**
	 * 查询配件的检修记录
	 * @return
	 */
	public String findPJRecorder(){
		String pjnum=request.getParameter("pjnum");
		PJDynamicInfo pjDynamic=null;
		if(pjnum!=null&&!"".equals(pjnum)){
			pjDynamic=pjManageService.findPJDynamicInfoByPJNum(pjnum);
		}else{
			pjDynamic= pjManageService.findPJDynamicInfoById(pjId);
		}
		request.setAttribute("pjDy", pjDynamic);
		request.setAttribute("pjRecs", pjManageService.findPJFixRecord(pjDynamic.getPjdid()));
		return "pjRecorder";
	}
	
	/**
	 * 查看配件详细信息
	 * @return
	 */
	public String findPjDetailRecorder(){
		Long recId=Long.parseLong(request.getParameter("recId"));
		request.setAttribute("tsbzid", workService.findDictProTeamByPY(Contains.TSZ_PY).getProteamid());
		request.setAttribute("pjDy", pjManageService.findPJDynamicInfoById(pjId));
		request.setAttribute("pjDetailRecs", pjManageService.findPJFixRecord(pjId,recId));
		return "pjDetailRecorder";
	}
	
	/**
	 * 将配件修改为待修状态
	 * @return
	 */
	public String updateStatus(){
		String pjIds=request.getParameter("pjIds");
		request.setAttribute("message", pjManageService.updatePjStatus(pjIds));
		return dyPJListInput();
	}
	
	/**
	 * 选择物资编号
	 * @return
	 */
	public String choiceWzNum(){
		String urlName=request.getParameter("urlName");
		if(pjName !=null && !"".equals(pjName)){
			try {
				pjName = URLDecoder.decode(pjName, "UTF-8").trim();//十六制转为中文
				urlName = URLEncoder.encode(pjName, "UTF-8");//中文转为十六制编码
			} catch (UnsupportedEncodingException e) {
				e.printStackTrace();
			}
		}
		request.setAttribute("urlName", urlName);
		request.setAttribute("pageModel", pjManageService.findDictWzNum(pjName));
		return "choiceWzNum";
	}
	
	/**
	 * 进入配件记录查询页面
	 * 
	 * */
	public String inputPartRecord() {
		String jcStype = request.getParameter("jcStype");
		if (jcStype == null || "".equals(jcStype)) {
			jcStype = "SS3B";
		}
		List<DictJcStype> jcStypes = pjManageService.findDictJcStype();
		List<DictFirstUnit> firstUnits = pjManageService
				.findDictFirstUnit(jcStype);
		List<Map<String, Object>> arrays = new ArrayList<Map<String, Object>>();
		List<?> list = pjManageService.findPartCount(jcStype);
		Map<String, Object> data = null;

		for (DictFirstUnit firstUnit : firstUnits) {
			data = new HashMap<String, Object>();
			data.put("firstunitid", firstUnit.getFirstunitid());
			data.put("firstunitname", firstUnit.getFirstunitname());
			data.put("hg", pjManageService.findCountParts(firstUnit
					.getFirstunitid(), 0, jcStype));
			data.put("jx", pjManageService.findCountParts(firstUnit
					.getFirstunitid(), 3, jcStype));
			data.put("dx", pjManageService.findCountParts(firstUnit
					.getFirstunitid(), 1, jcStype));
			data.put("sc", pjManageService.findCountPartsOnTrain(firstUnit
					.getFirstunitid(), 2, jcStype));
			arrays.add(data);
		}
		request.setAttribute("jcStype", jcStype);
		request.setAttribute("jcStypes", jcStypes);
		request.setAttribute("firstUnit", arrays);
		request.setAttribute("list", list);
		return "inputPartRecord";
	}
	
	/**
	 * ajax更新配件状态信息
	 * @return
	 */
	public String ajaxUpdatePjComments(){
		Long pjdId=Long.parseLong(request.getParameter("pjdId"));
		String comments=request.getParameter("comments");
		pjManageService.updatePjComments(pjdId, comments);
		try {
			ServletActionContext.getResponse().getWriter().print("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 配件交接单查询页面
	 * @return
	 */
	public String exchangeTipsList(){
		List<DictJcStype> jcsTypes = pjManageService.findDictJcStype();
		List<DictProTeam>  dictProTeams = pdiFroemanManageService.findWorkDictProTeam();
		PageModel<Deliverytip>  pm = pjManageService.findDeliverytip(pDeliverytip);
		request.setAttribute("pm", pm);
		request.setAttribute("dictProTeams", dictProTeams);
		request.setAttribute("getoffnum", pDeliverytip.getGetoffnum());
		request.setAttribute("jcsTypes", jcsTypes);
		request.setAttribute("fixproteam", pDeliverytip.getFixproteam());
		request.setAttribute("deliverydate", pDeliverytip.getDeliverydate());
		request.setAttribute("pjname", pDeliverytip.getPjname());
		return "exchangeTipsList";
	}
	
	/**
	 * 配件交接单添加页面
	 * @return
	 */
	public String exchangeTipsAddInput(){
		List<DictProTeam>  dictProTeams = pdiFroemanManageService.findWorkDictProTeam();
		request.setAttribute("dictProTeams", dictProTeams);
		return "exchangeTipsAdd";
	}
	
	/**
	 * 添加配件交接单
	 * @throws IOException 
	 */
	public void exchangeTipsAdd() throws IOException{
		String msg = "";
		try {
			pjManageService.saveDeliverytip(pDeliverytip);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	/**
	 * 删除配件交接单
	 * @throws IOException 
	 */
	public void exchangeTipsDelete() throws IOException{
		String msg = "";
		List<String> indexs = new ArrayList<String>();
		String[] ids = request.getParameter("items").split(",");
		for (String id : ids) {
			indexs.add(id);
		}
		try {
			pjManageService.deleteDeliverytip(indexs);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	/**
	 * 配件交接单 承修班组签章
	 * @throws IOException
	 */
	public void exchangeTipsFixSign() throws IOException{
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String msg = "";
		List<String> indexs = new ArrayList<String>();
		String[] ids = request.getParameter("items").split(",");
		for (String id : ids) {
			indexs.add(id);
		}
		try {
			pjManageService.fixSignDeliverytip(indexs, user.getXm());
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	} 
	
	
	/**
	 * 配件交接单 配件库签章
	 * @return
	 */
	public String exchangeTipsOfStore (){
		String id = request.getParameter("id");
		try {
			PDeliverytip pDeliverytip = pjManageService.findexchangeTipsById(id);
			request.setAttribute("pDeliverytip", pDeliverytip);
		} catch (IllegalAccessException e) {
			e.printStackTrace();
		} catch (InvocationTargetException e) {
			e.printStackTrace();
		}
		return "exchangeTipsOfStore";
	}

	/**
	 * 配件预领单查询页面
	 * @return
	 */
	public String addvanceTipsList(){
		String getonnum = request.getParameter("getonnum");
		String pjname = request.getParameter("pjname");
		String pjnum = request.getParameter("pjnum");
		String addvanceperson = request.getParameter("addvanceperson");
		String addvancedate = request.getParameter("addvancedate");
		List<DictJcStype> jcsTypes = pjManageService.findDictJcStype();
		PageModel<Addvancetip>  pm = pjManageService.addvanceTipsList(getonnum, pjname, pjnum, addvanceperson, addvancedate, null);
		request.setAttribute("pm", pm);
		request.setAttribute("getonnum", getonnum);
		request.setAttribute("pjname", pjname);
		request.setAttribute("pjnum", pjnum);
		request.setAttribute("addvanceperson", addvanceperson);
		request.setAttribute("addvancedate", addvancedate);
		request.setAttribute("jcsTypes", jcsTypes);
		return "addvanceTipsList";
	}
	
	/**
	 * 关联配件预领单查询页面
	 * @return
	 */
	public String choiceAddvanceTipsList(){
		String getonnum = request.getParameter("getonnum");
		String pjname = request.getParameter("pjname");
		String pjnum = request.getParameter("pjnum");
		String addvanceperson = request.getParameter("addvanceperson");
		String addvancedate = request.getParameter("addvancedate");
		PageModel<Addvancetip>  pm = pjManageService.addvanceTipsList(getonnum, pjname, pjnum, addvanceperson, addvancedate, "choice");
		request.setAttribute("pm", pm);
		return "choiceAddvanceTipsList";
	}
	
	/**
	 * 添加配件预领单
	 * @throws IOException
	 */
	public void addvanceTipsAdd() throws IOException{
		String msg = "";
		try {
			pjManageService.addvanceTipsAdd(addvancetip);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	/**
	 * 关联配件预领单
	 * @throws IOException
	 */
	public void addvanceTipsDependence() throws IOException{
		JSONObject obj = null;
		Addvancetip addvancetip = null;
		String id = request.getParameter("id");
		try {
			addvancetip = pjManageService.addvanceTipsDependence(id) ;
			obj = new JSONObject(addvancetip);
		} catch (Exception e) {
			e.printStackTrace();
		} finally{
			response.getWriter().write(obj.toString());
		}
	}
	
	/**
	 * 删除配件预领单
	 * @throws IOException 
	 */
	public void addvanceTipsDelete() throws IOException{
		String msg = "";
		List<String> indexs = new ArrayList<String>();
		String[] ids = request.getParameter("items").split(",");
		for (String id : ids) {
			indexs.add(id);
		}
		try {
			pjManageService.deleteAddvancetip(indexs);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	/**
	 * 配件预领单 配件库签章
	 * @throws IOException
	 */
	public void addvanceTipsStoreSign() throws IOException{
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		String msg = "";
		List<String> indexs = new ArrayList<String>();
		String[] ids = request.getParameter("items").split(",");
		for (String id : ids) {
			indexs.add(id);
		}
		try {
			pjManageService.addvanceTipsStoreSign(indexs, user.getXm());
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	
	/**
	 * 配件库存单查询页面
	 * @return
	 */
	public String storeInputTipsList(){
		String getofnum = request.getParameter("getofnum");
		String pjname = request.getParameter("pjname");
		String pjnum = request.getParameter("pjnum");
		String handler = request.getParameter("handler");
		String inputdate = request.getParameter("inputdate");
		List<DictJcStype> jcsTypes = pjManageService.findDictJcStype();
		PageModel<Storetip>  pm = pjManageService.storeInputTipsList(getofnum, pjname, pjnum, handler, inputdate, null);
		request.setAttribute("pm", pm);
		request.setAttribute("getofnum", getofnum);
		request.setAttribute("pjname", pjname);
		request.setAttribute("pjnum", pjnum);
		request.setAttribute("handler", handler);
		request.setAttribute("inputdate", inputdate);
		request.setAttribute("jcsTypes", jcsTypes);
		return "storeInputTipsList";
	}
	
	/**
	 * 添加配件库存单
	 * @return
	 */
	public void storeInputTipsAdd() throws IOException{
		String msg = "";
		try {
			pjManageService.saveStoreInputTips(storetip);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	/**
	 * 删除配件库存单
	 * @return
	 * @throws IOException 
	 */
	
	public void storeInputTipsDelete() throws IOException{
		String msg = "";
		List<String> indexs = new ArrayList<String>();
		String[] ids = request.getParameter("items").split(",");
		for (String id : ids) {
			indexs.add(id);
		}
		try {
			pjManageService.deleteStoretip(indexs);
			msg = "success";
		} catch (Exception e) {
			e.printStackTrace();
			msg = "failure";
		} finally{
			response.getWriter().write(msg);
		}
	}
	
	
	/**
	 * 库存统计
	 * @return
	 */
	public String storeCountList() {
		String jcStype = request.getParameter("jcStype");
		if (jcStype == null || "".equals(jcStype)) {
			jcStype = "SS3B";
		}
		List<DictJcStype> jcStypes = pjManageService.findDictJcStype();
		List<DictFirstUnit> firstUnits = pjManageService.findDictFirstUnit(jcStype);
		List<Map<String, Object>> arrays = new ArrayList<Map<String, Object>>();
		List<?> list = pjManageService.findPartCountWith(jcStype);
		Map<String, Object> data = null;
		for (DictFirstUnit firstUnit : firstUnits) {
			data = new HashMap<String, Object>();
			data.put("firstunitid", firstUnit.getFirstunitid());
			data.put("firstunitname", firstUnit.getFirstunitname());
			data.put("count", pjManageService.findCountPart(firstUnit.getFirstunitid(), 0, jcStype, 0));
			arrays.add(data);
		}
		request.setAttribute("jcStype", jcStype);
		request.setAttribute("jcStypes", jcStypes);
		request.setAttribute("firstUnit", arrays);
		request.setAttribute("list", list);
		return "storeCountList";
	}
	
	public String storeCountDetail(){
		String pjName = request.getParameter("pjName");
		String jcType = request.getParameter("jcType");
		PDeliverytip pDeliverytip = new PDeliverytip();
		pDeliverytip.setPjname(pjName);
		List<Map<String, String>> dataList = new ArrayList<Map<String, String>>();
		Map<String, String> dataMap = null;
		//配件交接单
		Deliverytip deliverytip = null;
		PageModel<Deliverytip>  deliverytiPm = pjManageService.findDeliverytip(pDeliverytip);
		for(int i = 0; i < deliverytiPm.getDatas().size(); i++){
			deliverytip = deliverytiPm.getDatas().get(i);
			dataMap = new HashMap<String, String>();
			dataMap.put("date", deliverytip.getReceivedate());
			dataMap.put("income", "");
			dataMap.put("expend", deliverytip.getReceivenum().toString());
			dataMap.put("pjnum", deliverytip.getReceivepjnum());
			dataMap.put("comments", (StringUtils.isNotEmpty(deliverytip.getComments()))? deliverytip.getComments(): "" );
			dataList.add(dataMap);
		}
		//配件库存单
		Storetip storetip = null;
		PageModel<Storetip>  storetipPm = pjManageService.storeInputTipsList(null, pjName, null, null, null, "count");
		for(int i = 0; i < storetipPm.getDatas().size(); i++){
			storetip = storetipPm.getDatas().get(i);
			dataMap = new HashMap<String, String>();
			dataMap.put("date", storetip.getInputdate());
			dataMap.put("income", storetip.getInputnum().toString());
			dataMap.put("expend", "");
			dataMap.put("pjnum", storetip.getPjnum());
			dataMap.put("comments", (StringUtils.isNotEmpty(deliverytip.getComments()))? deliverytip.getComments(): "" );
			dataList.add(dataMap);
		}
		request.setAttribute("dataList", dataList);
		request.setAttribute("pjName", pjName);
		request.setAttribute("jcType", jcType);
		request.setAttribute("deliverytiPm", deliverytiPm);
		request.setAttribute("storetipPm", storetipPm);
		return "storeCountDetail";
	}
	
	public Addvancetip getAddvancetip() {
		return addvancetip;
	}

	public void setAddvancetip(Addvancetip addvancetip) {
		this.addvancetip = addvancetip;
	}
	
	public String addvanceTipsAddInput(){
		return "addvanceTipsAdd";
	}

	public Storetip getStoretip() {
		return storetip;
	}

	public void setStoretip(Storetip storetip) {
		this.storetip = storetip;
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

	public Integer getFlowTypeId() {
		return flowTypeId;
	}

	public void setFlowTypeId(Integer flowTypeId) {
		this.flowTypeId = flowTypeId;
	}

	public String getPjName() {
		return pjName;
	}

	public void setPjName(String pjName) {
		this.pjName = pjName;
	}

	public PJStaticInfo getPjStatic() {
		return pjStatic;
	}

	public void setPjStatic(PJStaticInfo pjStatic) {
		this.pjStatic = pjStatic;
	}

	public Long getPjId() {
		return pjId;
	}

	public void setPjId(Long pjId) {
		this.pjId = pjId;
	}

	public PJDynamicInfo getPjDy() {
		return pjDy;
	}

	public void setPjDy(PJDynamicInfo pjDy) {
		this.pjDy = pjDy;
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

	public String getId() {
		return id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public String getIds() {
		return ids;
	}

	public void setIds(String ids) {
		this.ids = ids;
	}

	public Integer getStorePosition() {
		return storePosition;
	}

	public void setStorePosition(Integer storePosition) {
		this.storePosition = storePosition;
	}

	public String getFirstUnitName() {
		return firstUnitName;
	}

	public void setFirstUnitName(String firstUnitName) {
		this.firstUnitName = firstUnitName;
	}
	
}
