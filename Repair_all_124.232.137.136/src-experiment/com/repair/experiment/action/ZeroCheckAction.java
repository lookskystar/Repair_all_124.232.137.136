package com.repair.experiment.action;

import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.ZeroCheck;
import com.repair.experiment.service.CheckDealJcService;
import com.repair.experiment.service.CheckSignService;
import com.repair.experiment.service.ZeroCheckService;
import com.repair.work.service.UsersPrivsService;

/**
 * 零公里检查和机车转出运用
 * @author Administrator
 *
 */
public class ZeroCheckAction extends BaseAction{
	@Resource(name="zeroCheckService")
	private ZeroCheckService zeroCheckService;
	@Resource(name="usersPrivsService")
	private UsersPrivsService usersPrivsService;
	@Resource(name="checkSignService")
	private CheckSignService checkSignService;
	@Resource(name="checkDealJcService")
	private CheckDealJcService checkDealJcService;
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMDHMS_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	/**
	 * 进入零公里检查页面
	 * @return
	 */
	public String zeroCheckInput(){
		//查找已交机车信息
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		List<DatePlanPri> checkJcs=zeroCheckService.findCheckDatePlanPri(user);
		request.setAttribute("checkJcs", checkJcs);
		return "zeroCheckInput";
	}
	
	/**
	 * 进入签认框
	 * @return
	 */
	public String zeroSignDialog(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		request.setAttribute("dpId", dpId);
		return "zeroSignDialog";
	}
	
	/**
	 * 零公里签到
	 * @return
	 */
	public String zeroSign(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		String username=request.getParameter("uname");
		String password=request.getParameter("pwd");
		String cardnum = request.getParameter("cardnum");
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
			//需要角色判断的话进行相应的角色判断
			ZeroCheck zeroCheck=zeroCheckService.findZeroCheckByUserDpId(datePlanPri, user);
			if(zeroCheck==null){
				zeroCheck=new ZeroCheck();
				zeroCheck.setDpId(datePlanPri);
				zeroCheck.setSignTime(YMDHMS_SDFORMAT.format(new Date()));
				zeroCheck.setUserId(user);
				zeroCheckService.saveZeroCheck(zeroCheck);
				result="success";
			}else{
				result="user_sign";//用户已经签认
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
	 * 显示签认用户信息
	 * @return
	 */
	public String zeroSignMsg(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		List<ZeroCheck> zeroChecks=zeroCheckService.findZeroCheckByDpId(dpId);
		request.setAttribute("zeroChecks", zeroChecks);
		request.setAttribute("dpId", dpId);
		request.setAttribute("plan", checkSignService.findDatePlanPriById(dpId));
		return "zeroSignMsg";
	}
	
	/**进入机车转出运用页面
	 * 
	 * @return
	 */
	public String jcRollOutInput(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		//查找已交机车信息
		List<DatePlanPri> checkJcs=zeroCheckService.findCheckDatePlanPri(user);
		request.setAttribute("checkJcs", checkJcs);
		request.setAttribute("rjhmId", request.getParameter("rjhmId"));
		return "jcRollOutInput";
	}
	
	/**
	 * 将机车转出
	 * @return
	 */
	public String jcRollOut(){
		int dpId=Integer.parseInt(request.getParameter("dpId"));
		DatePlanPri datePlanPri=checkSignService.findDatePlanPriById(dpId);
		datePlanPri.setPlanStatue(3);
		checkDealJcService.saveDatePlanPri(datePlanPri);
		response.setContentType("text/plain");
		try {
			response.getWriter().write("success");
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}

}
