package com.repair.experiment.action;

import java.io.IOException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.experiment.service.CheckDealJcService;
import com.repair.experiment.service.CheckSignService;
import com.repair.plan.dao.DatePlanPriDao;
import com.repair.work.service.UsersPrivsService;

/**
 * 机车验收交车
 * @author Administrator
 *
 */
public class CheckDealJcAction extends BaseAction{
	
	@Resource(name="checkDealJcService")
	private CheckDealJcService checkDealJcService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="checkSignService")
	private CheckSignService checkSignService;
	@Resource(name="datePlanPriDao")
	private DatePlanPriDao datePlanPriDao;
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 进入机车验收交车页面
	 * @return
	 */
	public String checkDealJcInput(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		Integer rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(rjhmId);
		List<JtPreDict> predicts = checkSignService.findPredicts(rjhmId);
		String jhjcsj=datePlanPri.getJhjcsj();
		boolean delay=compareDate(jhjcsj);//延迟返回true
		if(datePlanPri.getPlanStatue()==1&&delay){//待验机车并且延迟了
			request.setAttribute("delay", 1);//延迟标识
		}
//		List<Object[]> list=checkDealJcService.findCheckDealDatePlan();
//		List<Map<String,Object>> checkDealJcs=new ArrayList<Map<String,Object>>();
//		for(Object[] obj:list){
//			Map<String,Object> map=new HashMap<String,Object>();
//			map.put("rjhmId", obj[0]);
//			map.put("jcType", obj[1]);
//			map.put("jcnum", obj[2]);
//			map.put("fixFreque", obj[3]);
//			map.put("kcsj", obj[4]);
//			map.put("planStatue", obj[5]);
//			map.put("nodeName", obj[6]);
//			map.put("gongZhang", obj[7]);
//			checkDealJcs.add(map);
//		}
//		request.setAttribute("checkDealJcs", checkDealJcs);
		request.setAttribute("count", predicts.size());
		request.setAttribute("datePlanPri", datePlanPri);
		request.setAttribute("jwds", checkSignService.findDictJwds());
		return "checkDealJcInput";
	}
	
	/**
	 * 进入角色签到页面
	 * @return
	 */
	public String roleSignInput(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		request.setAttribute("dpId", dpId);
		return "roleSignInput";
	}
	
	/**
	 * 角色签认
	 * @return
	 */
	public String roleSign(){
		String username=request.getParameter("uname");
		String password=request.getParameter("pwd");
		String cardnum = request.getParameter("cardnum");
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
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
			if(roleFlag(user,datePlanPri)){
				int type=getRole(user);//得到用户角色
				String gh=user.getGonghao();//工号
				String xm=user.getXm();//姓名
				result=type+"-"+gh+"-"+xm;
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
	 * 保存机车竣工交验单
	 * @return
	 */
	public String saveSignedForFinish(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		short type=Short.parseShort(request.getParameter("status"));
		//String gzgh=request.getParameter("gzgh");
		//String gzxm=request.getParameter("gzxm");
		//String zrgh=request.getParameter("zrgh");
		//String zrxm=request.getParameter("zrxm");
		String ysgh=request.getParameter("ysgh");
		String ysxm=request.getParameter("ysxm");
		String dzgh=request.getParameter("dzgh");
		String dzxm=request.getParameter("dzxm");
		String jcsj = request.getParameter("jcsj");
		String blongarea = request.getParameter("belongArea");
		String fixarea = request.getParameter("fixArea");
		String dealJcType=request.getParameter("dealJcType");
		String reason=request.getParameter("reason");//强制交车时的原因
		
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		datePlanPri.setSjjcsj(jcsj+ ":00");//交车时间 
//		datePlanPri.setSjjcsj(YMDHMS_SDFORMAT.format(new Date()));//交车时间 
		SignedForFinish signedForFinish=new SignedForFinish();
		signedForFinish.setDpId(dpId);
		signedForFinish.setJclx(datePlanPri.getJcType());
		signedForFinish.setJch(datePlanPri.getJcnum());
		signedForFinish.setXcxc(datePlanPri.getFixFreque());
		signedForFinish.setKssj(datePlanPri.getKcsj());
		signedForFinish.setJssj(jcsj);
		//signedForFinish.setJcgzid(gzgh);
		//signedForFinish.setJcgzxm(gzxm);
		//signedForFinish.setJxzrid(zrgh);
		//signedForFinish.setJxzrxm(zrxm);
		signedForFinish.setYsyid(ysgh);
		signedForFinish.setYsyxm(ysxm);
		signedForFinish.setDzid(dzgh);
		signedForFinish.setDzxm(dzxm);
		signedForFinish.setType(type);
		signedForFinish.setBlongArea(blongarea);
		signedForFinish.setFixArea(fixarea);
		//强制交车有原因的话填写交车原因,正常交车如果延迟了，填写相应的延迟原因
		signedForFinish.setReason(reason);
		
		String result="success";
		try {
			if(dealJcType.equals("1")){//正常交车，看是否存在未完成的报活或者报活未派工完
				if(checkDealJcService.findJtPreDictByStatus(1, dpId)!=0){
					result="report_nowork";
				}else if(checkDealJcService.findJtPreDictByStatus(0, dpId)!=0){
					result="report_unfinish";//报活未完成
				}else{
					checkDealJcService.saveSignedForFinish(signedForFinish);
					//将日计划信息中的状态改为已交
					datePlanPri.setPlanStatue(2);
					checkDealJcService.saveDatePlanPri(datePlanPri);
				}
			}else{
				checkDealJcService.saveSignedForFinish(signedForFinish);
				//将日计划信息中的状态改为已交
				datePlanPri.setPlanStatue(2);
				checkDealJcService.saveDatePlanPri(datePlanPri);
			}
		} catch (Exception e1) {
			result="failure";
			e1.printStackTrace();
		}
		response.setContentType("text/plain");
		try {
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	//交车工长、检修主任、验收员、段长可签认
	@SuppressWarnings("unused")
	private boolean roleFlag(UsersPrivs user,DatePlanPri datePlanPri){
		boolean bool=false;
		if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JCGZ)&&datePlanPri.getGongZhang()==user){
			bool=true;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZR)){
			bool=true;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY)){
			bool=true;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_DZ)){
			bool=true;
		}
		return bool;
	}

	/**
	 * 得到用户角色 1:交车工长 2：检修主任 3：驻段验收员 4：段长
	 * @param user
	 * @return
	 */
	private int getRole(UsersPrivs user){
		int type=0;
		if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_JCGZ)){
			type=1;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_ZR)){
			type=2;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_YSY)){
			type=3;
		}else if(usersPrivsService.isHasRole(user.getUserid(), Contains.ROLE_NAME_DZ)){
			type=4;
		}
		return type;
	}
	
	/**
	 * 让计划交车时间与当前时间进行比较
	 * false:当前时间在计划交车时间之前
	 * true:当前时间在计划交车时间之后(延迟)
	 * @param jhjcsj
	 * @return
	 */
	private boolean compareDate(String jhjcsj){
		boolean flag=false;
		if(jhjcsj!=null&&!"".equals(jhjcsj)){
			SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
			Date time;
			try {
				time = sdf.parse(jhjcsj);
				Date now=new Date();
				flag=time.before(now);
			} catch (ParseException e) {
				e.printStackTrace();
			}
		}
		return flag;
	}
	
	public static void main(String[] args)throws Exception {
		String jhjcsj="2014-01-13 17:50";
		SimpleDateFormat sdf=new SimpleDateFormat("yyyy-MM-dd hh:mm");
		Date time=sdf.parse(jhjcsj);
		Date now=new Date();
		System.out.println(time.before(now));
		
	}

	/**
	 * 交车时报活补签
	 * */
	public String reSignInput(){
		Integer rjhmId=Integer.parseInt(request.getParameter("rjhmId"));
		List<JtPreDict> predicts = checkSignService.findPredicts(rjhmId);
		request.setAttribute("preDicts", predicts);
		return "re_report_sign";
	}
}
