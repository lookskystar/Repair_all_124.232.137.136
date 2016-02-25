package com.repair.kq.action;

import java.io.IOException;
import java.math.BigDecimal;
import java.text.DateFormat;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.struts2.ServletActionContext;
import org.json.JSONArray;
import org.json.JSONException;
import org.json.JSONObject;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQSignRec;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Contains;
import com.repair.kq.service.RewardService;
import com.repair.kq.service.SignService;

/**
 * 查询统计Action
 * @author L
 *
 */
public class SignAction {
	
	@Resource(name="signService")
	private SignService signService;
//	@Resource(name="userRolesService")
//	private UserRolesService userRolesService;
	@Resource(name="rewardService")
	private RewardService rewardService;
	
	private KQSignRec signrec;
	private String gonghao;
	private String xm;
	private Long teamId;
	private Integer isResign;
	private Long reSignTypeId;
	private String beginTime;
	private String endTime;
	private String month;
	private Integer status;
	
	
	
	private HttpServletRequest request = ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	public static final SimpleDateFormat YM_SDFORMAT = new SimpleDateFormat("yyyy-MM");
	public static final SimpleDateFormat YMD_FORMAT = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat YMDHM_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm");
	public static final SimpleDateFormat YMDHMS_FORMAT = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
	
	
	public void init(){
		request.setAttribute("dictProTeamList", rewardService.findWorkProTeam());
		request.setAttribute("resignTypeList", signService.listResignType());
	}
	
	/**
	 * 获取当前时间的前一天
	 */
	public  String getBeforeDay(String beforeDay) {	
		Date date =new Date();
		Calendar calendar = Calendar.getInstance();		
		calendar.setTime(date);		
		calendar.add(Calendar.DAY_OF_MONTH, -1);		
		date = calendar.getTime();
		beforeDay=YMD_FORMAT.format(date);
		return beforeDay;	
		
	}
	
	/**
	 * 判断是否为空
	 */
	public  boolean isNotEmpty(String date) {	
		if(date==null||date==""){
			return false;
		}
		return true;
	}
	
	
	
	/**
	 * 进入手工补签页面
	 */
	public String resignInput() throws Exception {
		init();
		String btimeTemp =YMD_FORMAT.format(new Date());
		String etimeTemp =YMD_FORMAT.format(new Date());
		String begin_Time=getBeforeDay(btimeTemp);
		String end_Time=getBeforeDay(etimeTemp);
		List<KQSignRec>  pm=signService.findReSignRec(gonghao, xm,teamId,isResign,reSignTypeId, begin_Time, end_Time);
		request.setAttribute("pm", pm);	
		request.setAttribute("beginTime", begin_Time);	
		request.setAttribute("endTime", end_Time);	
		return "resign";
		
	}
	
	/**
	 * 手工补签页面,查询
	 */
	public String queryresign() throws Exception {
		init();
		List<KQSignRec>  pm=signService.findReSignRec(gonghao,xm,teamId,isResign,reSignTypeId, beginTime, endTime);
		request.setAttribute("pm", pm);	
		return "resign";
		
	}

	/**
	 * 进入新增补签
	 */
	public String addResignInput() throws Exception {
		init();
		String ntime =YMDHMS_FORMAT.format(new Date());
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		List<UsersPrivs> usersList=signService.findUsersByTeamId(user.getBzid());
		KQRule rule=signService.getKQRuleById(user.getBzid());//得到考勤规则
		request.setAttribute("usersList", usersList);
		request.setAttribute("ntime", ntime);
		request.setAttribute("rule", rule);
		return "addresign";
	}
	

	/**
	 * ajax根据工号和日期判断考勤记录是否存在
	 * @return
	 * @throws IOException 
	 */
	public void ajaxKQSignRecExist() throws Exception{
		String result="false";
		String gonghao=request.getParameter("gonghao");
		String signtime=request.getParameter("signtime").substring(0,10);
		KQSignRec exist_rec=signService.getKQSignRecByGD(gonghao, signtime);//判断是否已经存在
		if(exist_rec!=null){
			result="success";
		}
		response.getWriter().print(result);
	}
	
	
	/**
	 * 新增补签
	 * ajax判断是否有规则，是否已经存在
	 */
	public String saveResign() throws Exception {
		DateFormat DFHm = new SimpleDateFormat("HH:mm");
		SimpleDateFormat DFyMdHms = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String result="failure";
		init();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String xm=request.getParameter("xm");
		String gonghao=request.getParameter("gonghao");
		String signtimeA=request.getParameter("signtimeA");
		String signtimeB=request.getParameter("signtimeB");
		String signtimeC=request.getParameter("signtimeC");
		String signtimeD=request.getParameter("signtimeD");
		String signtimeA2=request.getParameter("signtimeA2");
		String signtimeB2=request.getParameter("signtimeB2");
		String operator=request.getParameter("operator");
		String operatorTime=request.getParameter("operatorTime");
		String resignReason=request.getParameter("resignReason");
		Date signtimeA_date=null;
		Date signtimeB_date=null;
		Date signtimeC_date=null;
		Date signtimeD_date=null;
		Date signtimeA2_date=null;
		Date signtimeB2_date=null;
		Date first_start_date=null;
		Date first_end_date=null;
		Date sec_start_date=null;
		Date sec_end_date=null;
		double realAttendance_temp;//实出勤临时值
		double attendance_temp;//应出勤临时值
		long signtimeA_time=0;//上班1签到时间(签到四次时)
		long signtimeB_time=0;
		long signtimeC_time=0;
		long signtimeD_time=0;
		long signtimeA2_time=0;//上班1签到时间(签到两次时)
		long signtimeB2_time=0;
		long first_start_time=0;//上班1时间
		long first_end_time=0;
		long sec_start_time=0;
		long sec_end_time=0;
		long rule_lateNot=0;
		long rule_lateValid=0;
		long rule_leaveEarly=0;
		long rule_afterValid=0;
		KQRule rule=signService.getKQRuleById(user.getBzid());
		rule_lateNot = rule.getLateNot() * 60;// 迟到多久不计
		rule_lateValid = rule.getLateValid() * 60;// 迟到多久算旷工
		rule_leaveEarly = rule.getLeaveEarly() * 60;// 早退多久不计
		rule_afterValid = rule.getAfterValid() * 60;// 早退多久算旷工
		first_start_date = DFHm.parse(rule.getFirstStartTime());// 上班1规则时间
		first_end_date = DFHm.parse(rule.getFirstEndTime());// 下班1规则时间
		sec_start_date = DFHm.parse(rule.getSecStartTime());// 上班2规则时间
		sec_end_date = DFHm.parse(rule.getSecEndTime());// 下班2规则时间
		first_start_time = first_start_date.getTime() / 1000;
		first_end_time = first_end_date.getTime() / 1000;
		sec_start_time = sec_start_date.getTime() / 1000;
		sec_end_time = sec_end_date.getTime() / 1000;
		
		KQSignRec sign = new KQSignRec();// 新增
		if (Integer.parseInt(rule.getDuration()) == 2){//签到四次
					if (isNotEmpty(signtimeA)) {
						signtimeA_date = DFHm.parse(signtimeA.substring(11, 16));// 取时分
						signtimeA_time = signtimeA_date.getTime() / 1000;
					}
					if (isNotEmpty(signtimeB)) {
						signtimeB_date = DFHm.parse(signtimeB.substring(11, 16));
						signtimeB_time = signtimeB_date.getTime() / 1000;

					}
					if (isNotEmpty(signtimeC)) {
						signtimeC_date = DFHm.parse(signtimeC.substring(11, 16));
						signtimeC_time = signtimeC_date.getTime() / 1000;
					}
					if (isNotEmpty(signtimeD)) {
						signtimeD_date = DFHm.parse(signtimeD.substring(11, 16));
						signtimeD_time = signtimeD_date.getTime() / 1000;
					}

					if (signtimeA_time > first_start_time + rule_lateNot
							&& signtimeA_time < first_start_time+ rule_lateValid) {// 判断上午迟到
						sign.setIslate(1);
					} else {
						sign.setIslate(0);
					}
					if (signtimeC_time > sec_start_time + rule_lateNot
							&& signtimeC_time < sec_start_time + rule_lateValid) {// 判断下午迟到
						sign.setIslateB(1);
					} else {
						sign.setIslateB(0);
					}
					if (signtimeB_time < first_end_time - rule_leaveEarly
							&& signtimeB_time > first_end_time- rule_afterValid) {// 判断上午早退
						sign.setIsgoearly(1);
					} else {
						sign.setIsgoearly(0);
					}
					if (signtimeD_time < sec_end_time - rule_leaveEarly
							&& signtimeD_time > sec_end_time - rule_afterValid) {// 判断下午早退
						sign.setIsgoearlyB(1);
					} else {
						sign.setIsgoearlyB(0);
					}
					if (signtimeA_time > first_start_time + rule_lateValid
							|| signtimeB_time != 0
							&& signtimeB_time < first_end_time
									- rule_afterValid
							|| signtimeC_time > sec_start_time + rule_lateValid
							|| signtimeD_time != 0
							&& signtimeD_time < sec_end_time - rule_afterValid) {// 判断旷工
						sign.setIsabsenteeism(1);
					} else {
						sign.setIsabsenteeism(0);
					}
					if (!signtimeA.equals(sign.getSigntimeA())
							&& signtimeA != "") {// 设置补签到标识符
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "1,");
						} else {
							sign.setSignFlag(",1,");
						}
					}
					if (!signtimeB.equals(sign.getSigntimeB())
							&& signtimeB != "") {
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "2,");
						} else {
							sign.setSignFlag(",2,");
						}
					}
					if (!signtimeC.equals(sign.getSigntimeC())
							&& signtimeC != "") {
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "3,");
						} else {
							sign.setSignFlag(",3,");
						}
					}
					if (!signtimeD.equals(sign.getSigntimeD())
							&& signtimeD != "") {
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "4,");
						} else {
							sign.setSignFlag(",4,");
						}
					}
					sign.setSigntimeA(signtimeA);
					sign.setSigntimeB(signtimeB);
					sign.setSigntimeC(signtimeC);
					sign.setSigntimeD(signtimeD);
					sign.setSignCount(2);
					sign.setDay(signtimeA.substring(0, 10));
					attendance_temp=(double)((first_end_time-first_start_time+sec_end_time-sec_start_time)/(60.0*60.0));
					BigDecimal c = new BigDecimal(attendance_temp);
					double attendance = c.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();// 设置为1位小数
					sign.setAttendance(attendance);
					if (isNotEmpty(sign.getSigntimeA())
							&& isNotEmpty(sign.getSigntimeB())
							&& isNotEmpty(sign.getSigntimeC())
							&& isNotEmpty(sign.getSigntimeD())) {// 计算实出勤
						long timeA = DFyMdHms.parse(sign.getSigntimeA())
								.getTime() / 1000;
						long timeB = DFyMdHms.parse(sign.getSigntimeB())
								.getTime() / 1000;
						long timeC = DFyMdHms.parse(sign.getSigntimeC())
								.getTime() / 1000;
						long timeD = DFyMdHms.parse(sign.getSigntimeD())
								.getTime() / 1000;
						realAttendance_temp = (double) ((timeB - timeA + timeD - timeC) / (60.0 * 60.0));
						BigDecimal b = new BigDecimal(realAttendance_temp);
						double realAttendance = b.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();// 设置为1位小数
						sign.setRealAttendance(realAttendance);
					}
					
		}else{
					if (isNotEmpty(signtimeA2)) {
						signtimeA2_date = DFHm.parse(signtimeA2.substring(11, 16));
						signtimeA2_time = signtimeA2_date.getTime() / 1000;
					}
					if (isNotEmpty(signtimeB2)) {
						signtimeB2_date = DFHm.parse(signtimeB2.substring(11, 16));
						signtimeB2_time = signtimeB2_date.getTime() / 1000;
					}

					if (signtimeA2_time > first_start_time + rule_lateNot && signtimeA2_time < first_start_time + rule_lateValid) {// 判断迟到
						sign.setIslate(1);
					} else {
						sign.setIslate(0);
					}
					if (signtimeB2_time < first_end_time - rule_leaveEarly && signtimeB2_time > first_end_time - rule_afterValid) {// 判断早退
						sign.setIsgoearly(1);
					} else {
						sign.setIsgoearly(0);
					}
					if (signtimeA2_time > first_start_time + rule_lateValid
							|| signtimeB2_time != 0 && signtimeB2_time < first_end_time - rule_afterValid) {// 判断旷工
						sign.setIsabsenteeism(1);
					} else {
						sign.setIsabsenteeism(0);
					}

					if (!signtimeA2.equals(sign.getSigntimeA()) && signtimeA2 != "") {// 设置补签到标识符
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "1,");
						} else {
							sign.setSignFlag(",1,");
						}
					}
					if (!signtimeB2.equals(sign.getSigntimeB()) && signtimeB2 != "") {
						if (sign.getSignFlag() != null) {
							sign.setSignFlag(sign.getSignFlag() + "2,");
						} else {
							sign.setSignFlag(",2,");
						}
					}
					sign.setIslateB(0);
					sign.setIsgoearlyB(0);
					sign.setSigntimeA(signtimeA2);
					sign.setSigntimeB(signtimeB2);
					sign.setSignCount(1);
					sign.setDay(signtimeA2.substring(0, 10));
					attendance_temp=(double)((first_end_time-first_start_time)/(60.0*60.0));//计算应出勤
					BigDecimal c = new BigDecimal(attendance_temp);
					double attendance = c.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();
					sign.setAttendance(attendance);
					if (isNotEmpty(sign.getSigntimeA())&& isNotEmpty(sign.getSigntimeB())) {// 计算实出勤
						long timeA = DFyMdHms.parse(sign.getSigntimeA()).getTime() / 1000;
						long timeB = DFyMdHms.parse(sign.getSigntimeB()).getTime() / 1000;
						realAttendance_temp = (double)((timeB - timeA) / (60.0 * 60.0));
						BigDecimal b = new BigDecimal(realAttendance_temp);
						double realAttendance = b.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();//设置为1位小数
						sign.setRealAttendance(realAttendance);
					}
					
			}
		
			sign.setIsresign(1);
			sign.setReSignTypeId(1L);
			sign.setIsovertime(0);
			sign.setProteamId(user.getBzid());
			sign.setXm(xm);
			sign.setGonghao(gonghao);
			sign.setOperator(operator);
			sign.setOperatorTime(operatorTime);
			sign.setResignReason(resignReason);
			try {
				signService.saveOrUpdateKQSignRec(sign);
				result = "success";

			} catch (Exception e) {
				e.printStackTrace();
			}
			
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
		
	}
	
	/**
	 * 进入编辑补签
	 */
	public String editResignInput() throws Exception {
		init();
		String signId = request.getParameter("signId");
		KQSignRec sign=signService.getKQSignRecById(Long.parseLong(signId));
		request.setAttribute("sign", sign);
		request.setAttribute("signId", signId);
		return "editResign";
		
	}
	
	/**
	 * 编辑补签
	 */
	public String editResign() throws Exception {
		DateFormat DFHm = new SimpleDateFormat("HH:mm");
		SimpleDateFormat DFyMdHms = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
		String result="failure";
		init();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String signId = request.getParameter("signId");
		String signtimeA=request.getParameter("signtimeA");
		String signtimeB=request.getParameter("signtimeB");
		String signtimeC=request.getParameter("signtimeC");
		String signtimeD=request.getParameter("signtimeD");
		String signtimeA2=request.getParameter("signtimeA2");
		String signtimeB2=request.getParameter("signtimeB2");
		String resignReason=request.getParameter("resignReason");
		Date signtimeA_date=null;
		Date signtimeB_date=null;
		Date signtimeC_date=null;
		Date signtimeD_date=null;
		Date signtimeA2_date=null;
		Date signtimeB2_date=null;
		Date first_start_date=null;
		Date first_end_date=null;
		Date sec_start_date=null;
		Date sec_end_date=null;
		double realAttendance_temp;//实出勤临时值
		long signtimeA_time=0;//上班1签到时间(签到四次时)
		long signtimeB_time=0;
		long signtimeC_time=0;
		long signtimeD_time=0;
		long signtimeA2_time=0;//上班1签到时间(签到两次时)
		long signtimeB2_time=0;
		long first_start_time=0;//上班1时间
		long first_end_time=0;
		long sec_start_time=0;
		long sec_end_time=0;
		long rule_lateNot=0;
		long rule_lateValid=0;
		long rule_leaveEarly=0;
		long rule_afterValid=0;
		KQRule rule=signService.getKQRuleById(user.getBzid());
		if(rule!=null){//有规则
			rule_lateNot = rule.getLateNot() * 60;// 迟到多久不计
			rule_lateValid = rule.getLateValid() * 60;// 迟到多久算旷工
			rule_leaveEarly = rule.getLeaveEarly() * 60;// 早退多久不计
			rule_afterValid = rule.getAfterValid() * 60;// 早退多久算旷工
			first_start_date = DFHm.parse(rule.getFirstStartTime());// 上班1规则时间
			first_end_date = DFHm.parse(rule.getFirstEndTime());// 下班1规则时间
			sec_start_date = DFHm.parse(rule.getSecStartTime());// 上班2规则时间
			sec_end_date = DFHm.parse(rule.getSecEndTime());// 下班2规则时间
			first_start_time = first_start_date.getTime() / 1000;
			first_end_time = first_end_date.getTime() / 1000;
			sec_start_time = sec_start_date.getTime() / 1000;
			sec_end_time = sec_end_date.getTime() / 1000;

			KQSignRec sign = signService.getKQSignRecById(Long.parseLong(signId));
			if (sign.getSignCount() == 2) {// 签到四次
				if (isNotEmpty(signtimeA)) {
					signtimeA_date = DFHm.parse(signtimeA.substring(11, 16));// 取时分
					signtimeA_time = signtimeA_date.getTime() / 1000;
				}
				if (isNotEmpty(signtimeB)) {
					signtimeB_date = DFHm.parse(signtimeB.substring(11, 16));
					signtimeB_time = signtimeB_date.getTime() / 1000;
					
					
				}
				if (isNotEmpty(signtimeC)) {
					signtimeC_date = DFHm.parse(signtimeC.substring(11, 16));
					signtimeC_time = signtimeC_date.getTime() / 1000;
				}
				if (isNotEmpty(signtimeD)) {
					signtimeD_date = DFHm.parse(signtimeD.substring(11, 16));
					signtimeD_time = signtimeD_date.getTime() / 1000;
				}

				if (signtimeA_time > first_start_time + rule_lateNot&& signtimeA_time < first_start_time + rule_lateValid) {// 判断上午迟到
					sign.setIslate(1);
				} else {
					sign.setIslate(0);
				}
				if (signtimeC_time > sec_start_time + rule_lateNot&& signtimeC_time < sec_start_time + rule_lateValid) {// 判断下午迟到
					sign.setIslateB(1);
				} else {
					sign.setIslateB(0);
				}
				if (signtimeB_time < first_end_time - rule_leaveEarly&& signtimeB_time > first_end_time - rule_afterValid) {// 判断上午早退
					sign.setIsgoearly(1);
				} else {
					sign.setIsgoearly(0);
				}
				if (signtimeD_time < sec_end_time - rule_leaveEarly&& signtimeD_time > sec_end_time - rule_afterValid) {// 判断下午早退
					sign.setIsgoearlyB(1);
				} else {
					sign.setIsgoearlyB(0);
				}
				if (signtimeA_time > first_start_time + rule_lateValid
						|| signtimeB_time != 0&& signtimeB_time < first_end_time - rule_afterValid
						|| signtimeC_time > sec_start_time + rule_lateValid
						|| signtimeD_time != 0&& signtimeD_time < sec_end_time - rule_afterValid) {// 判断旷工
					sign.setIsabsenteeism(1);
				} else {
					sign.setIsabsenteeism(0);
				}
				if (!signtimeA.equals(sign.getSigntimeA()) && signtimeA != "") {// 设置补签到标识符
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "1,");
					} else {
						sign.setSignFlag(",1,");
					}
				}
				if (!signtimeB.equals(sign.getSigntimeB()) && signtimeB != "") {
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "2,");
					} else {
						sign.setSignFlag(",2,");
					}
				}
				if (!signtimeC.equals(sign.getSigntimeC()) && signtimeC != "") {
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "3,");
					} else {
						sign.setSignFlag(",3,");
					}
				}
				if (!signtimeD.equals(sign.getSigntimeD()) && signtimeD != "") {
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "4,");
					} else {
						sign.setSignFlag(",4,");
					}
				}
				sign.setSigntimeA(signtimeA);
				sign.setSigntimeB(signtimeB);
				sign.setSigntimeC(signtimeC);
				sign.setSigntimeD(signtimeD);
				if (isNotEmpty(sign.getSigntimeA())&& isNotEmpty(sign.getSigntimeB())&& isNotEmpty(sign.getSigntimeC())&& isNotEmpty(sign.getSigntimeD())) {// 计算实出勤
					long timeA = DFyMdHms.parse(sign.getSigntimeA()).getTime() / 1000;
					long timeB = DFyMdHms.parse(sign.getSigntimeB()).getTime() / 1000;
					long timeC = DFyMdHms.parse(sign.getSigntimeC()).getTime() / 1000;
					long timeD = DFyMdHms.parse(sign.getSigntimeD()).getTime() / 1000;
					realAttendance_temp = (double)((timeB - timeA + timeD - timeC)/ (60.0 * 60.0));
					BigDecimal b = new BigDecimal(realAttendance_temp);
					double realAttendance = b.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();//设置为1位小数
					sign.setRealAttendance(realAttendance);
				}

			} else {
				if (isNotEmpty(signtimeA2)) {
					signtimeA2_date = DFHm.parse(signtimeA2.substring(11, 16));
					signtimeA2_time = signtimeA2_date.getTime() / 1000;
				}
				if (isNotEmpty(signtimeB2)) {
					signtimeB2_date = DFHm.parse(signtimeB2.substring(11, 16));
					signtimeB2_time = signtimeB2_date.getTime() / 1000;
				}

				if (signtimeA2_time > first_start_time + rule_lateNot && signtimeA2_time < first_start_time + rule_lateValid) {// 判断迟到
					sign.setIslate(1);
				} else {
					sign.setIslate(0);
				}
				if (signtimeB2_time < first_end_time - rule_leaveEarly && signtimeB2_time > first_end_time - rule_afterValid) {// 判断早退
					sign.setIsgoearly(1);
				} else {
					sign.setIsgoearly(0);
				}
				if (signtimeA2_time > first_start_time + rule_lateValid
						|| signtimeB2_time != 0 && signtimeB2_time < first_end_time - rule_afterValid) {// 判断旷工
					sign.setIsabsenteeism(1);
				} else {
					sign.setIsabsenteeism(0);
				}

				if (!signtimeA2.equals(sign.getSigntimeA()) && signtimeA2 != "") {// 设置补签到标识符
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "1,");
					} else {
						sign.setSignFlag(",1,");
					}
				}
				if (!signtimeB2.equals(sign.getSigntimeB()) && signtimeB2 != "") {
					if (sign.getSignFlag() != null) {
						sign.setSignFlag(sign.getSignFlag() + "2,");
					} else {
						sign.setSignFlag(",2,");
					}
				}
				sign.setIslateB(0);
				sign.setIsgoearlyB(0);
				sign.setSigntimeA(signtimeA2);
				sign.setSigntimeB(signtimeB2);
				if (isNotEmpty(sign.getSigntimeA())&& isNotEmpty(sign.getSigntimeB())) {// 计算实出勤
					long timeA = DFyMdHms.parse(sign.getSigntimeA()).getTime() / 1000;
					long timeB = DFyMdHms.parse(sign.getSigntimeB()).getTime() / 1000;
					realAttendance_temp = (double)((timeB - timeA) / (60.0 * 60.0));
					BigDecimal b = new BigDecimal(realAttendance_temp);
					double realAttendance = b.setScale(1,BigDecimal.ROUND_HALF_UP).doubleValue();//设置为1位小数
					sign.setRealAttendance(realAttendance);
				}
			}// end of else
			sign.setIsresign(1);
			sign.setIsovertime(0);
			sign.setResignReason(resignReason);
			sign.setReSignTypeId(1L);
			try {
				signService.saveOrUpdateKQSignRec(sign);
				result = "success";

			} catch (Exception e) {
				e.printStackTrace();
			}
		}else{
			result="norule";
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
		
	}
	
	
	
	/**
	 * 进入考勤日报
	 */
	public String queryKQDayInput() throws Exception {
        init();
        List<DictProTeam>  dictProTeamList=rewardService.findWorkProTeam();
        String btimeTemp =YMD_FORMAT.format(new Date());
		String etimeTemp =YMD_FORMAT.format(new Date());
		String begin_Time=getBeforeDay(btimeTemp);
		String end_Time=getBeforeDay(etimeTemp);
		List<KQSignRec>  signreclist=signService.KQDayQuery(gonghao, xm,dictProTeamList.get(0).getProteamid(), begin_Time, end_Time);
		request.setAttribute("signreclist", signreclist);	
		request.setAttribute("teamId", dictProTeamList.get(0).getProteamid());	
		request.setAttribute("beginTime", begin_Time);	
		request.setAttribute("endTime", end_Time);	
		return "query_kqday";
		
	}
	
	/**
	 * 考勤日报,查询
	 */
	public String queryKQDay() throws Exception {
        init();
		List<KQSignRec>  signreclist=signService.KQDayQuery(gonghao, xm,teamId, beginTime, endTime);
		request.setAttribute("signreclist", signreclist);	
		return "query_kqday";
		
	}
	
	/**
	 * 进入考勤月报
	 */
	public String queryKQMonthInput() throws Exception {
        init();
        List<DictProTeam>  dictProTeamList=rewardService.findWorkProTeam();
        // 处理时间
        if(month==null){
			 month=YM_SDFORMAT.format(new Date());
		 }
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM_SDFORMAT.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        List<Map<Object, Object>> monthCount = signService.findMonthSign(dictProTeamList.get(0).getProteamid(), gonghao, xm, month);
        request.setAttribute("teamId", dictProTeamList.get(0).getProteamid());	
        if(monthCount!=null&&monthCount.size()>0){
			 request.setAttribute("monthCount", monthCount);
		 }
        request.setAttribute("maxMonthDay", maxMonthDay);
		return "query_kqmonth";
		
	}
	
	/**
	 * 考勤月报,查询
	 */
	public String queryKQMonth() throws Exception {
        init();
        // 处理时间
        if(month==null){
			 month=YM_SDFORMAT.format(new Date());
		 }
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM_SDFORMAT.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        List<Map<Object, Object>> monthCount = signService.findMonthSign(teamId, gonghao, xm, month);
        if(monthCount!=null&&monthCount.size()>0){
			 request.setAttribute("monthCount", monthCount);
		 }
        request.setAttribute("maxMonthDay", maxMonthDay);
		return "query_kqmonth";
		
	}
	
	
	/**
	 * 进入考勤汇总，按用户名
	 */
	public String queryKQMonthByXmInput() throws Exception {
        init();
        List<DictProTeam>  dictProTeamList=rewardService.findWorkProTeam();
        // 处理时间
        if(month==null){
			 month=YM_SDFORMAT.format(new Date());
		 }
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM_SDFORMAT.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        List<Map<Object, Object>> monthCount = signService.findMonthSignByXm(dictProTeamList.get(0).getProteamid(), gonghao, xm, month);
        request.setAttribute("teamId", dictProTeamList.get(0).getProteamid());	
        if(monthCount!=null&&monthCount.size()>0){
			 request.setAttribute("monthCount", monthCount);
		 }
        request.setAttribute("maxMonthDay", maxMonthDay);
		return "query_kqmonthbyxm";
		
	}
	
	/**
	 * 考勤汇总,查询
	 */
	public String queryKQMonthByXm() throws Exception {
        init();
        // 处理时间
        if(month==null){
			 month=YM_SDFORMAT.format(new Date());
		 }
		Calendar calendar  = Calendar.getInstance();
		Date monthNow =  YM_SDFORMAT.parse(month);
		calendar.setTime(monthNow);
		// 获得当前月的实际最大天数
		int maxMonthDay = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);
        
        List<Map<Object, Object>> monthCount = signService.findMonthSignByXm(teamId, gonghao, xm, month);
        if(monthCount!=null&&monthCount.size()>0){
			 request.setAttribute("monthCount", monthCount);
		 }
        request.setAttribute("maxMonthDay", maxMonthDay);
		return "query_kqmonthbyxm";
		
	}
	
	/**
	 * (查询月报)进入查看签到详情
	 */
	public String querysignInfo() throws Exception {
		init();
		String gonghao=request.getParameter("gonghao");
		String day=request.getParameter("date");
		KQSignRec signrec=signService.getKQSignRecByGD(gonghao, day);
		List<Object[]>  basicSign=null;
		String signTimeB=null;
		String signTimeD=null;
		if(signrec!=null){
			if(isNotEmpty(signrec.getSigntimeB())){
				signTimeB=signrec.getSigntimeB().substring(0, 10);
			}
			if(isNotEmpty(signrec.getSigntimeD())){
				signTimeD=signrec.getSigntimeD().substring(0, 10);
			}
			if(signrec.getSignCount()==1){//签到两次
				if(isNotEmpty(signTimeB)&&!signrec.getDay().equals(signTimeB)){
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),signTimeB,1);
				}else{
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),null,0);
				}
			}else{//签到四次
				if(isNotEmpty(signTimeD)&&!signrec.getDay().equals(signTimeD)){
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),signTimeD,1);
				}else{
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),null,0);
				}
			}
			request.setAttribute("signrec", signrec);
			request.setAttribute("basicSign", basicSign);
		}
		return "resume";
	}
	
	/**
	 * (查询日报)进入查看签到详情
	 */
	public String signInfoListInput() throws Exception {
		init();
		KQSignRec signrec=signService.getKQSignRecById(Long.valueOf(request.getParameter("signId")));
		List<Object[]>  basicSign=null;
		String signTimeB=null;
		String signTimeD=null;
		if(signrec!=null){
			if(isNotEmpty(signrec.getSigntimeB())){
				signTimeB=signrec.getSigntimeB().substring(0, 10);
			}
			if(isNotEmpty(signrec.getSigntimeD())){
				signTimeD=signrec.getSigntimeD().substring(0, 10);
			}
			if(signrec.getSignCount()==1){//签到两次
				if(isNotEmpty(signTimeB)&&!signrec.getDay().equals(signTimeB)){
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),signTimeB,1);
				}else{
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),null,0);
				}
			}else{//签到四次
				if(isNotEmpty(signTimeD)&&!signrec.getDay().equals(signTimeD)){
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),signTimeD,1);
				}else{
					 basicSign=signService.findBasicSign(signrec.getGonghao(), signrec.getDay(),null,0);
				}
			}
			request.setAttribute("signrec", signrec);
			request.setAttribute("basicSign", basicSign);
		}
		return "signrecInfo";
	}
	
	/**
	 * 进入休假录入页面
	 */
	public String noworkEditInput(){
		init();
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		List<UsersPrivs> usersList=signService.findUsersByTeamId(user.getBzid());
		request.setAttribute("usersList", usersList);	
		return "noworkEdit";
	}
	
	/**
	 * 保存休假
	 */
	public String saveNoWork() throws Exception{
		String result="failure";
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		KQRule rule=signService.getKQRuleById(user.getBzid());
		String jsonStr=request.getParameter("jsonStr");
		JSONArray jsonArray=new JSONArray(jsonStr);
		JSONObject jsonObject=null;
		KQSignRec signrec=null;
		List<KQSignRec> list=new ArrayList<KQSignRec>();
		for(int i=0;i<jsonArray.length();i++){
			jsonObject=jsonArray.optJSONObject(i);
			signrec=new KQSignRec();
			signrec.setProteamId(user.getBzid());
			signrec.setGonghao(jsonObject.optString("gonghao"));
			signrec.setXm(jsonObject.optString("xm"));
			signrec.setNoworkBegintime(jsonObject.optString("startTime"));
			signrec.setNoworkEndtime(jsonObject.optString("endTime"));
			signrec.setIsresign(1);
			signrec.setIslate(0);
			signrec.setIslateB(0);
			signrec.setIsgoearly(0);
			signrec.setIsgoearlyB(0);
			signrec.setIsovertime(0);
			signrec.setIsabsenteeism(0);
			signrec.setSignCount(Integer.parseInt(rule.getDuration()));
			signrec.setReSignTypeId(Long.parseLong(jsonObject.optString("reSignTypeId")));
			signrec.setOperator(user.getXm());
			signrec.setOperatorTime(YMDHMS_FORMAT.format(new Date()));
			signrec.setResignReason(jsonObject.optString("resignReason"));
			signrec.setDay(jsonObject.optString("startTime").substring(0, 10));
			list.add(signrec);
		}
		try {
			signService.saveOrUpdateKQSignRec(list);
			result="success";
		} catch (Exception e) {
			e.printStackTrace();
		}
		ServletActionContext.getResponse().getWriter().print(result);
		return null;
	}
	
	
	/**
	 * ajax得到班组下的用户信息
	 * @return
	 */
	public String ajaxGetTeamUser() throws JSONException, IOException{
		Long teamId=Long.parseLong(request.getParameter("teamId"));
		List<UsersPrivs> users=signService.findUsersByTeamId(teamId);
		JSONObject obj=null;
		JSONArray array=new JSONArray();
		if(users!=null&&users.size()>0){
			for(UsersPrivs user:users){
				obj=new JSONObject();
				obj.put("xm", user.getXm());
				array.put(obj);
			}
		}
		JSONObject json=new JSONObject();
		json.put("users", array);
		response.getWriter().print(json.toString());
		return null;
	}
	
	
	/**
	 * 进入工人签认页面
	 */
	public String signInput() throws Exception {
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		Integer status=0;
		String etimeTemp =YMD_FORMAT.format(new Date());
		List<KQUserItem> userItemList=signService.findKQUserItem(user.getUserid(),null,status,beginTime,etimeTemp);
		request.setAttribute("userItemList", userItemList);
		request.setAttribute("status", status);
		request.setAttribute("endTime", etimeTemp);
		return "sign";
	}
	
	/**
	 * 工人签认页面,查询
	 */
	public String querySign() throws Exception {
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		List<KQUserItem> userItemList=signService.findKQUserItem(user.getUserid(),null,status,beginTime,endTime);
		request.setAttribute("userItemList", userItemList);
		return "sign";
	}
	
	
	/**
	 * 保存工人签认(批量)
	 */
	public String saveSign() throws Exception{
		String result="failure";
		String userItemIdArray[] = ServletActionContext.getRequest().getParameter("checks").split("-");
		if (userItemIdArray.length > 0) {
			signService.updateKQUserItemSign(userItemIdArray, YMDHMS_FORMAT.format(new Date()));
			result = "success";
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
		
	}
	
	
	/**
	 * 工人签认
	 */
	public String confirmSign() {
		String result="failure";
		String Id = request.getParameter("Id");
		String workNote=request.getParameter("workNote");
		KQUserItem userItem=signService.getKQUserItemById(Long.parseLong(Id));
		userItem.setStatus(1);
		userItem.setWorkNote(workNote);
		userItem.setSignTime(YMDHMS_FORMAT.format(new Date()));
		try {
			signService.updateKQUserItem(userItem);
			result="success";
			ServletActionContext.getResponse().getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	
	/**
	 * 进入工长结转页面
	 */
	public String carryOverInput() throws Exception {
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		Integer status=1;
		String etimeTemp =YMD_FORMAT.format(new Date());
		List<KQUserItem> userItemList=signService.findKQUserItem(null,user.getBzid(),status,beginTime,etimeTemp);
		List<UsersPrivs> usersList=signService.findUsersByTeamId(user.getBzid());
		request.setAttribute("usersList", usersList);
		request.setAttribute("userItemList", userItemList);
		request.setAttribute("status", status);
		request.setAttribute("endTime", etimeTemp);
		return "carryOver";
	}
	
	/**
	 * 工长结转页面,查询
	 */
	public String queryCarryOver() throws Exception {
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		List<KQUserItem> userItemList=signService.findKQUserItem(null,user.getBzid(),status,beginTime,endTime);
		List<UsersPrivs> usersList=signService.findUsersByTeamId(user.getBzid());
		request.setAttribute("userItemList", userItemList);
		request.setAttribute("usersList", usersList);
		return "carryOver";
	}
	
	
	/**
	 * 保存工长结转(批量)
	 */
	public String saveCarryOver() throws Exception{
		String result="failure";
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String userItemIdArray[] = ServletActionContext.getRequest().getParameter("checks").split("-");
		if (userItemIdArray.length > 0) {
			signService.updateKQUserItemOver(userItemIdArray, user.getUserid(), YMDHMS_FORMAT.format(new Date()));
			result = "success";
		}
		response.setContentType("text/plain");
		response.getWriter().write(result);
		return null;
		
	}
	
	
	/**
	 * 工长结转
	 */
	public String confirmOver() {
		String result="failure";
		UsersPrivs user=(UsersPrivs)request.getSession().getAttribute("session_user");
		String Id = request.getParameter("Id");
		String workScore=request.getParameter("workScore");
		KQUserItem userItem=signService.getKQUserItemById(Long.parseLong(Id));
		userItem.setStatus(2);
		userItem.setOverUser(user.getUserid());
		userItem.setWorkScore(Integer.parseInt(workScore));
		userItem.setOverTime(YMDHMS_FORMAT.format(new Date()));
		try {
			signService.updateKQUserItem(userItem);
			result="success";
			ServletActionContext.getResponse().getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改备注
	 */
	public String commitNote(){
		String result=null;
		String Id = request.getParameter("Id");
		String workNote=request.getParameter("workNote");
		try {
			signService.updateKQUserItem(Long.parseLong(Id), workNote);
			result="success";
			ServletActionContext.getResponse().getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 修改工时得分
	 */
	public String commitScore(){
		String result=null;
		String Id = request.getParameter("Id");
		String workScore=request.getParameter("workScore");
		try {
			signService.updateKQUserItemScore(Long.parseLong(Id), Integer.parseInt(workScore));
			result="success";
			ServletActionContext.getResponse().getWriter().print(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	public KQSignRec getSignrec() {
		return signrec;
	}

	public void setSignrec(KQSignRec signrec) {
		this.signrec = signrec;
	}

	public String getGonghao() {
		return gonghao;
	}

	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}

	public String getXm() {
		return xm;
	}

	public void setXm(String xm) {
		this.xm = xm;
	}

	public Long getTeamId() {
		return teamId;
	}

	public void setTeamId(Long teamId) {
		this.teamId = teamId;
	}

	public Integer getIsResign() {
		return isResign;
	}

	public void setIsResign(Integer isResign) {
		this.isResign = isResign;
	}

	public Long getReSignTypeId() {
		return reSignTypeId;
	}

	public void setReSignTypeId(Long reSignTypeId) {
		this.reSignTypeId = reSignTypeId;
	}

	public String getBeginTime() {
		return beginTime;
	}

	public void setBeginTime(String beginTime) {
		this.beginTime = beginTime;
	}

	public String getEndTime() {
		return endTime;
	}

	public void setEndTime(String endTime) {
		this.endTime = endTime;
	}

	public String getMonth() {
		return month;
	}

	public void setMonth(String month) {
		this.month = month;
	}

	public Integer getStatus() {
		return status;
	}

	public void setStatus(Integer status) {
		this.status = status;
	}


}
