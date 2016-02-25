package com.repair.experiment.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.LinkedHashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletResponse;

import net.sf.json.JSONObject;

import org.apache.struts2.ServletActionContext;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCSignature;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.YSJCRec;
import com.repair.common.util.Contains;
import com.repair.experiment.service.CheckSignService;
import com.repair.plan.service.PlanManageService;
import com.repair.work.service.UsersPrivsService;
import com.repair.work.service.YSJCRecService;

/**
 * 交车验收签到
 * @author Administrator
 *
 */
public class CheckSignAction extends BaseAction{
	
	@Resource(name="checkSignService")
	private CheckSignService checkSignService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="planManageService")
	private PlanManageService planManageService;
	@Resource(name="ysjcRecService")
	private YSJCRecService ysjcRecService;
	
	private NrJcJyzb nrjc;
	
	private long gzId;//工长ID
	private long zjId;//质检ID
	private long ysId;//验收ID
	
	public NrJcJyzb getNrjc() {
		return nrjc;
	}

	public void setNrjc(NrJcJyzb nrjc) {
		this.nrjc = nrjc;
	}
	
	public long getGzId() {
		return gzId;
	}

	public void setGzId(long gzId) {
		this.gzId = gzId;
	}

	public long getZjId() {
		return zjId;
	}

	public void setZjId(long zjId) {
		this.zjId = zjId;
	}

	public long getYsId() {
		return ysId;
	}

	public void setYsId(long ysId) {
		this.ysId = ysId;
	}

	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 进入交车验收签到页面
	 * @return
	 */
	public String checkSignInput(){
		int nodeId=Integer.parseInt(request.getParameter("nodeId"));
		Integer datePlanId=Integer.parseInt(request.getParameter("rjhmId"));
		//UsersPrivs usersPrivs = (UsersPrivs) ServletActionContext.getRequest().getSession().getAttribute("session_user");
		//List<DatePlanPri> checkJcs=checkSignService.findCheckJc(nodeId,usersPrivs.getUserid());
		DatePlanPri dateplanPri=checkSignService.findDatePlanPriById(datePlanId);
		List<JtPreDict> predicts = checkSignService.findPredicts(datePlanId);
		request.setAttribute("count", predicts.size());
		request.setAttribute("datePlanPri",dateplanPri);
		return "checkSignInput";
	}
	
	/**
	 * 角色签到
	 * @return
	 */
	public String roleSign(){
		String datePlanId=request.getParameter("datePlanId");
		String username=request.getParameter("uname");
		String password=request.getParameter("pwd");
		String cardnum = request.getParameter("cardnum");
		UsersPrivs user = null;
		String result="failure";
		
		if(cardnum==null || "".equals(cardnum)){
			user = usersPrivsService.login(username, password);
		}else{
			user = usersPrivsService.getUserPrivsByCard(cardnum);
		}
		if(user==null){
			result="login_failure";
		}else{
			DatePlanPri datePlanPri=null;
			if(datePlanId!=null){
				datePlanPri=checkSignService.findDatePlanPriById(Integer.parseInt(datePlanId));
			}
			JCSignature signature=checkSignService.findJCSignatureByUserDpId(user, datePlanPri);
			if(signature==null){
				signature=new JCSignature();
				signature.setDatePlanId(datePlanPri);
				signature.setUser(user);
				signature.setSignTime(YMDHMS_SDFORMAT.format(new Date()));
				checkSignService.saveSignature(signature);
				result="success";
			}else{//用户已经签认
				result="user_sign";
			}
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
	 * 根据日计划信息得到交验用户信息
	 * @return
	 */
	public String getSignatureByDatePlanId(){
		int datePlanId=Integer.parseInt(request.getParameter("datePlanId"));
		List<JCSignature> signatures=checkSignService.findJCSignatureByDatePlanId(datePlanId);
		List<DictProTeam> teams = checkSignService.listFixProTeam(datePlanId);
		
		Map<Long, String> proTeams = new LinkedHashMap<Long, String>();
		Map<String,List<String>> result = new LinkedHashMap<String,List<String>>();
		for (DictProTeam dictProTeam : teams) {
			proTeams.put(dictProTeam.getProteamid(),dictProTeam.getProteamname());
			result.put(dictProTeam.getProteamname(), new ArrayList<String>());
		}
		StringBuffer buffer = null;
		for (JCSignature sg : signatures) {
			buffer=new StringBuffer();
			buffer.append("{");
			buffer.append("\"gonghao\"").append(":\"").append(sg.getUser().getGonghao()).append("\",");
			buffer.append("\"name\"").append(":\"").append(sg.getUser().getXm()).append("\",");
			buffer.append("\"signTime\"").append(":\"").append(sg.getSignTime()).append("\"");
			buffer.append("}");
			if(sg.getUser().getBzid()==null ||proTeams.get(sg.getUser().getBzid())==null||result.get(proTeams.get(sg.getUser().getBzid()))==null){
				if(result.get("other")==null){
					result.put("other", new ArrayList<String>());
				}
				result.get("other").add(buffer.toString());
			}else{
				result.get(proTeams.get(sg.getUser().getBzid())).add(buffer.toString());
			}
		}
		response.setContentType("text/plain");
		try {
			response.getWriter().write(JSONObject.fromObject(result).toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入交车记录
	 * @return
	 */
	public String checkRecInput(){
		int rjhmId=Integer.parseInt(request.getParameter("dpId"));
		List<YSJCRec> ySJCRecList = null;
		//查询交车记录表是否有记录
		Long count = ysjcRecService.countYSJCRec(rjhmId);
		if(count==0){//如果记录表不存在 生成记录
			ysjcRecService.addYSJCRec(Integer.valueOf(rjhmId));
		}
		ySJCRecList = ysjcRecService.listYSJCRec(Integer.valueOf(rjhmId)) ;
		//封装成以classify为键的Map
		Map<String,List<YSJCRec>> itemListMap = new LinkedHashMap<String, List<YSJCRec>>();
		String classify = null;
		for (int i = 0; i < ySJCRecList.size(); i++) {
			classify = ySJCRecList.get(i).getClassify();
			if(itemListMap.get(classify) == null){
				itemListMap.put(classify, new ArrayList<YSJCRec>());
			}
			itemListMap.get(classify).add(ySJCRecList.get(i));
		}
		request.setAttribute("itemListMap", itemListMap);
		request.setAttribute("rjhmId", rjhmId);
		return "checkRecInput";
	}
	
	/**
	 * 签到不进入交车记录
	 * @return
	 */
	public String ajaxCheckRecInput(){
		HttpServletResponse out = ServletActionContext.getResponse();
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		try {
			datePlanPri.setPlanStatue(1);
			planManageService.saveOrUpdateDatePlanPri(datePlanPri);
			out.getWriter().write("success");
		} catch (Exception e) {
			e.printStackTrace();
			try {
				out.getWriter().write("failure");
			} catch (IOException e1) {
				e1.printStackTrace();
			}
		}
		return null;
	}
	
//	/**
//	 * 交车工长全签
//	 */
//	public String sign() throws Exception {
//		int rjhmId=Integer.parseInt(request.getParameter("dpid"));
//		String result = "failure";
//		
//		if(ysjcRecService.countBefSignRec(rjhmId)==0){
//			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
//			ysjcRecService.updateSign(null, 3, user.getXm(), 1, rjhmId);
//			
//			DatePlanPri datePlanPri = planManageService.findDatePlanPriById(rjhmId);
//			datePlanPri.setPlanStatue(1);//将日计划状态修改为待验
//			checkSignService.updateDatePlanPri(datePlanPri);//更新日计划信息
//		}
//		response.getWriter().print(result);
//		return null;
//	}
	
	/**
	 * 进入用户签认页面
	 * @return
	 */
	public String signDialogInput(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		int djmId=Integer.parseInt(request.getParameter("djmId"));
		int type=Integer.parseInt(request.getParameter("type"));
		DlJcJyMxb djm=checkSignService.findDlJcJyMxbById(djmId);
		DatePlanPri datePlanPri = planManageService.findDatePlanPriById(dpId);
		datePlanPri.setSjqjsj(YMDHMS_SDFORMAT.format(new Date()));
		planManageService.saveOrUpdateDatePlanPri(datePlanPri);
		request.setAttribute("dpId", dpId);//日计划ID
		request.setAttribute("djm", djm);//项目明细ID
		request.setAttribute("type", type);//类型
		return "signDialogInput";
	}
	
	/**
	 * 电力检测项目签认
	 * @return
	 */
	public String signJcItem(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		int djmId=Integer.parseInt(request.getParameter("djmId"));
		//type 1:交车工长  2：质检 技术 3：验收员
		int type=Integer.parseInt(request.getParameter("type"));
		String username=request.getParameter("uname");
		String password=request.getParameter("pwd");
		String jcqk=request.getParameter("jcqk");
		String cardnum = request.getParameter("cardnum");
		
		DlJcJyMxb djm=checkSignService.findDlJcJyMxbById(djmId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);//查询日计划信息
		DlJcJyZb dz=checkSignService.findDlJcJyZbByDpId(datePlanPri);//查询电力机车交车检测项目主表信息
		String result="failure";
		UsersPrivs user = null;
		if(cardnum==null || "".equals(cardnum)){
			user = usersPrivsService.login(username, password);
		}else{
			user = usersPrivsService.getUserPrivsByCard(cardnum);
		}
		if(user==null){
			result="login_failure";
		}else{
			if(roleFlag(type,user,datePlanPri)){
				djm.setJcqk(jcqk);
				if(type==1){
					djm.setJcgz(user.getGonghao());
					djm.setJcgzxm(user.getXm());
				}else if(type==2){
					djm.setZj(user.getGonghao());
					djm.setZjxm(user.getXm());
				}else if(type==3){
					djm.setYs(user.getGonghao());
					djm.setYsxm(user.getXm());
				}
				
//				checkSignService.saveDlJcJyMxb(djm);
//				djm=checkSignService.findDlJcJyMxbById(djmId);
//				if(signAll(djm)){//角色全部签完，将状态改为1
//					djm.setStatus((short)1);
//					checkSignService.saveDlJcJyMxb(djm);
//					//根据检测项目ID和状态查询DlJcJyMxb是否都已经签认完
//					List<DlJcJyMxb> list=checkSignService.findDlJcJyMxbByIdStatus(dz.getJyzId(),(short)0);
//					if(list==null||list.isEmpty()){//全部签认完
//						datePlanPri.setPlanStatue(1);//将日计划状态修改为待验
//						checkSignService.updateDatePlanPri(datePlanPri);
//					}
//				}
				
				checkSignService.saveDlJcJyMxb(djm, dz, datePlanPri, type, djmId);
				result="success";
			}else{
				result="no_authority";//角色不对，没有权限
			}
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
	 * 进入内燃机检测项目签认页面
	 * @return
	 */
	public String checkSignDialogInput(){
		return "checkSignDialogInput";
	}
	
	/**
	 * 内燃机项目签认
	 * @return
	 */
	public String nrCheckSign(){
		String username=request.getParameter("uname");
		String password=request.getParameter("pwd");
		String cardnum = request.getParameter("cardnum");
		UsersPrivs user = null;
		String result="failure";
		
		if(cardnum==null || "".equals(cardnum)){
			user = usersPrivsService.login(username, password);
		}else{
			user = usersPrivsService.getUserPrivsByCard(cardnum);
		}
		
		if(user==null){
			result="login_failure";
		}else{
			if(roleFlag(user)){
				int type=getRole(user);//得到用户角色
				long userId=user.getUserid();//用户ID
				String xm=user.getXm();//姓名
				result=type+"-"+userId+"-"+xm;
			}else{
				result="no_authority";
			}
			
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
	 * 内燃机压缩压力检测项目页面
	 * @return
	 */
	public String nrYsylCheckInput(){
		setCheckInput();
		return "nrYsylCheckInput";
	}
	
	/**
	 * 提交内燃机压缩压力检测项目信息
	 * @return
	 */
	public String nrYsylCheck(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		//查找相应机车的记录信息是否存在
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		if(nrJcJyzb==null){
			getNrJcJyzb(datePlanPri);//设置NrJcJyzb相应信息
			checkSignService.saveNrJcJyzb(nrjc);
		}else{
			nrJcJyzb.setYsyl1(nrjc.getYsyl1());
			nrJcJyzb.setYsyl2(nrjc.getYsyl2());
			nrJcJyzb.setYsyl3(nrjc.getYsyl3());
			nrJcJyzb.setYsyl4(nrjc.getYsyl4());
			nrJcJyzb.setYsyl5(nrjc.getYsyl5());
			nrJcJyzb.setYsyl6(nrjc.getYsyl6());
			nrJcJyzb.setYsyl7(nrjc.getYsyl7());
			nrJcJyzb.setYsyl8(nrjc.getYsyl8());
			nrJcJyzb.setYsyl9(nrjc.getYsyl9());
			nrJcJyzb.setYsyl10(nrjc.getYsyl10());
			nrJcJyzb.setYsyl11(nrjc.getYsyl11());
			nrJcJyzb.setYsyl12(nrjc.getYsyl12());
			nrJcJyzb.setYsyl13(nrjc.getYsyl13());
			nrJcJyzb.setYsyl14(nrjc.getYsyl14());
			nrJcJyzb.setYsyl15(nrjc.getYsyl15());
			nrJcJyzb.setYsyl16(nrjc.getYsyl16());
			nrJcJyzb.setGzId(gzUser);
			checkSignService.updateNrJcJyzb(nrJcJyzb);
		}
		request.setAttribute("message","信息添加或修改成功!");
		return nrYsylCheckInput();
	}
	
	/**
	 * 内燃机滑油压力检测项目页面
	 * @return
	 */
	public String nrHyylCheckInput(){
		setCheckInput();
		return "nrHyylCheckInput";
	}
	
	/**
	 * 提交内燃机滑油压力检测项目信息
	 * @return
	 */
	public String nrHyylCheck(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		//查找相应机车的记录信息是否存在
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		if(nrJcJyzb==null){
			getNrJcJyzb(datePlanPri);//设置NrJcJyzb相应信息
			checkSignService.saveNrJcJyzb(nrjc);
		}else{
			nrJcJyzb.setHyylch1(nrjc.getHyylch1());
			nrJcJyzb.setHyylch2(nrjc.getHyylch2());
			nrJcJyzb.setHyylck1(nrjc.getHyylck1());
			nrJcJyzb.setHyylck2(nrjc.getHyylck2());
			nrJcJyzb.setHyylcq1(nrjc.getHyylcq1());
			nrJcJyzb.setHyylcq2(nrjc.getHyylcq2());
			nrJcJyzb.setHyyles1(nrjc.getHyyles1());
			nrJcJyzb.setHyyles2(nrjc.getHyyles2());
			nrJcJyzb.setHyylhz1(nrjc.getHyylhz1());
			nrJcJyzb.setHyylhz2(nrjc.getHyylhz2());
			nrJcJyzb.setHyylqz1(nrjc.getHyylqz1());
			nrJcJyzb.setHyylqz2(nrjc.getHyylqz2());
			nrJcJyzb.setHyylys1(nrjc.getHyylys1());
			nrJcJyzb.setHyylys2(nrjc.getHyylys2());
			nrJcJyzb.setHyylzs1(nrjc.getHyylzs1());
			nrJcJyzb.setHyylzs2(nrjc.getHyylzs2());
			nrJcJyzb.setGzId(gzUser);
			checkSignService.updateNrJcJyzb(nrJcJyzb);
		}
		request.setAttribute("message","信息添加或修改成功!");
		return nrHyylCheckInput();
	}
	
	/**
	 * 内燃机燃油压力检测项目页面
	 * @return
	 */
	public String nrRyylCheckInput(){
		setCheckInput();
		return "nrRyylCheckInput";
	}
	
	/**
	 *  提交内燃机燃油压力检测项目信息
	 * @return
	 */
	public String nrRyylCheck(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		//查找相应机车的记录信息是否存在
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		if(nrJcJyzb==null){
			getNrJcJyzb(datePlanPri);//设置NrJcJyzb相应信息
			checkSignService.saveNrJcJyzb(nrjc);
		}else{
			nrJcJyzb.setRyyles1(nrjc.getRyyles1());
			nrJcJyzb.setRyyles2(nrjc.getRyyles2());
			nrJcJyzb.setRyyljxj1(nrjc.getRyyljxj1());
			nrJcJyzb.setRyyljxj2(nrjc.getRyyljxj2());
			nrJcJyzb.setRyylys1(nrjc.getRyylys1());
			nrJcJyzb.setRyylys2(nrjc.getRyylys2());
			nrJcJyzb.setGzId(gzUser);
			checkSignService.updateNrJcJyzb(nrJcJyzb);
		}
		request.setAttribute("message","信息添加或修改成功!");
		return nrRyylCheckInput();
	}
	
	/**
	 * 内燃机对地绝缘检测项目页面
	 * @return
	 */
	public String nrDdjyCheckInput(){
		setCheckInput();
		return "nrDdjyCheckInput";
	}
	
	/**
	 *提交内燃机对地绝缘检测项目信息
	 * @return
	 */
	public String nrDdjyCheck(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		//查找相应机车的记录信息是否存在
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		if(nrJcJyzb==null){
			getNrJcJyzb(datePlanPri);//设置NrJcJyzb相应信息
			checkSignService.saveNrJcJyzb(nrjc);
		}else{
			nrJcJyzb.setDdjyk(nrjc.getDdjyk());
			nrJcJyzb.setDdjylc(nrjc.getDdjylc());
			nrJcJyzb.setDdjyz(nrjc.getDdjyz());
			nrJcJyzb.setDdjyzdk(nrjc.getDdjyzdk());
			nrJcJyzb.setDdjyzh(nrjc.getDdjyzh());
			nrJcJyzb.setGzId(gzUser);
			checkSignService.updateNrJcJyzb(nrJcJyzb);
		}
		request.setAttribute("message","信息添加或修改成功!");
		return nrDdjyCheckInput();
	}
	
	
	/**
	 * 内燃机保护装置检测项目页面
	 * @return
	 */
	public String nrBhzzCheckInput(){
		setCheckInput();
		return "nrBhzzCheckInput";
	}
	
	/**
	 * 提交内燃机保护装置检测项目信息
	 * @return
	 */
	public String nrBhzzCheck(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		//查找相应机车的记录信息是否存在
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		if(nrJcJyzb==null){
			getNrJcJyzb(datePlanPri);//设置NrJcJyzb相应信息
			checkSignService.saveNrJcJyzb(nrjc);
		}else{
			nrJcJyzb.setBhzzcs(nrjc.getBhzzcs());
			nrJcJyzb.setBhzzgf(nrjc.getBhzzgf());
			nrJcJyzb.setBhzzgy(nrjc.getBhzzgy());
			nrJcJyzb.setBhzzjx(nrjc.getBhzzjx());
			nrJcJyzb.setBhzzudk(nrjc.getBhzzudk());
			nrJcJyzb.setGzId(gzUser);
			
			datePlanPri.setPlanStatue(1);//将日计划状态修改为待验
			datePlanPri.setZhiJian(nrJcJyzb.getZjId());//设置质检员信息
			datePlanPri.setYanShou(nrJcJyzb.getYsId());//设置验收员信息
			
			checkSignService.updateDatePlanPri(datePlanPri);//更新日计划信息
			checkSignService.updateNrJcJyzb(nrJcJyzb);
		}
		request.setAttribute("message","信息添加或修改成功!");
		return nrBhzzCheckInput();
	}
	
	//日计划中指定的交车工长、质检/技术、验收员可签认
	private boolean roleFlag(int type,UsersPrivs user,DatePlanPri datePlanPri){
		boolean bool=false;
		//日计划中指定的交车工长
		if(type==1&&usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JCGZ)){
			bool=true;
		}else if(type==2&& (usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY)||usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY))){
			bool=true;
		}else if(type==3&&usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY)){
			bool=true;
		}
		return bool;
	}
	
	//交车工长、质检/技术、验收员可签认
	private boolean roleFlag(UsersPrivs user){
		boolean bool=false;
		if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JCGZ)){
			bool=true;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY )|| usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY )){
			bool=true;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY)){
			bool=true;
		}
		return bool;
	}
	
	/**
	 * 得到用户角色 1:交车工长 2：质检员 3：验收员 
	 * @param user
	 * @return
	 */
	private int getRole(UsersPrivs user){
		int type=0;
		if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JCGZ)){
			type=1;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZJY) || usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JSY)){
			type=2;
		}else if(usersPrivsService.isHasRole(user.getUserid(),  Contains.ROLE_NAME_YSY)){
			type=3;
		}
		return type;
	}
	
	/**
	 * 设置进入页面相应信息
	 */
	private void setCheckInput(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		NrJcJyzb nrJcJyzb=checkSignService.findNrJcJyzbByDpId(dpId);
		request.setAttribute("dpId", dpId);
		request.setAttribute("nrJcJyzb", nrJcJyzb);
	}
	/**
	 * 设置NrJcJyzb相应信息
	 * @param datePlanPri
	 */
	private void getNrJcJyzb(DatePlanPri datePlanPri){
		UsersPrivs gzUser=usersPrivsService.getUsersPrivsById(gzId);//获得交车工长信息
		UsersPrivs zjUser=usersPrivsService.getUsersPrivsById(zjId);//获得质检员信息
		UsersPrivs ysUser=usersPrivsService.getUsersPrivsById(ysId);//获得验收员信息
		nrjc.setDpId(datePlanPri.getRjhmId());
		nrjc.setJclx(datePlanPri.getJcType());
		nrjc.setJch(datePlanPri.getJcnum());
		nrjc.setXcxc(datePlanPri.getFixFreque());
		nrjc.setGzId(gzUser);
		nrjc.setZjId(zjUser);
		nrjc.setYsId(ysUser);
	}
	
	/**
	 * 交车工长、质检、验收是否都签完，都签完返回true
	 * @param djm
	 * @return
	 */
	private boolean signAll(DlJcJyMxb djm){
		boolean flag=false;
		boolean gzFlag=djm.getJcgz()!=null&&!djm.getJcgz().equals("");
		boolean zjFlag=djm.getZj()!=null&&!djm.getZj().equals("");
		boolean ysFlag=djm.getYs()!=null&&!djm.getYs().equals("");
		if(gzFlag&&zjFlag&&ysFlag){
			flag=true;
		}
		return flag;
	}
	
	/**
	 * 交车工长、质检技术、验收卡控全签
	 */
	public String sign() throws Exception {
		int rjhmId=Integer.parseInt(request.getParameter("dpid"));
		String result = "failure";
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_signer");
		try {
			if(user.getRoles().equals(",JCGZ,")){
				if(ysjcRecService.countBefSignRec(rjhmId)==0){
					ysjcRecService.updateSign(null, 3, user.getXm(), 1, rjhmId);
					DatePlanPri datePlanPri = planManageService.findDatePlanPriById(rjhmId);
					datePlanPri.setPlanStatue(1);//将日计划状态修改为待验
					checkSignService.updateDatePlanPri(datePlanPri);//更新日计划信息
				}
			}else if(user.getRoles().equals(",JSY,") || user.getRoles().equals(",ZJY,")){
				ysjcRecService.updateSign(null, 1, user.getXm(), 1, rjhmId);
			}else if(user.getRoles().equals(",YSY,")){
				ysjcRecService.updateSign(null, 2, user.getXm(), 1, rjhmId);
			}
			result = "success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		response.getWriter().print(result);
		return null;
	}
}
