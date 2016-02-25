package com.repair.kq.action;

import java.io.IOException;
import java.text.ParseException;
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
import org.json.JSONObject;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQNoticeInfo;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkSet;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.service.RewardService;

/**
 * 考核奖励Action
 * @author dell
 *
 */
public class RewardAction {
	
	@Resource(name="rewardService")
	private RewardService rewardService;
	private HttpServletRequest request=ServletActionContext.getRequest();
	private HttpServletResponse response=ServletActionContext.getResponse();
	
	/**
	 * 格式化时间
	 */
	public static final SimpleDateFormat YMD_SDFORMAT = new SimpleDateFormat("yyyy-MM-dd");
	public static final SimpleDateFormat YM_SDFORMAT = new SimpleDateFormat("yyyy-MM");
	
	private KQAssessReward reward;
	private KQNoticeInfo notice;
	
	public KQAssessReward getReward() {
		return reward;
	}

	public void setReward(KQAssessReward reward) {
		this.reward = reward;
	}
	
	public KQNoticeInfo getNotice() {
		return notice;
	}

	public void setNotice(KQNoticeInfo notice) {
		this.notice = notice;
	}

	//考核奖励查询条件
	private Long proteamId;
	private String reportTime;
	private String reportPerson;
	private String rewardPerson;
	
	//工时统计
	private String time;
	private String userName;
	private String gonghao;
	
	/**
	 * 进入考核奖励信息页面
	 * @return
	 */
	public String rewardInfoInput(){
		List<KQAssessReward> rewards=rewardService.findKQAssessReward(proteamId, reportTime, reportPerson, rewardPerson,null);
		request.setAttribute("rewards", rewards);
		return "rewardInfo";
	}
	
	/**
	 * 进入添加考核奖励页面
	 * @return
	 */
	public String addRewardInfoInput(){
		List<DictProTeam> proteams=rewardService.findDictProTeam();
		request.setAttribute("proteams", proteams);
		return "addRewardInfo";
	}
	
	/**
	 * 添加考核奖励信息
	 * @return
	 */
	public String addRewardInfo(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		DictProTeam proteam=rewardService.findDictProTeamById(reward.getProteam().getProteamid());
		reward.setReportTime(YMD_SDFORMAT.format(new Date()));
		reward.setProteamName(proteam.getProteamname());
		reward.setReportPerson(user.getXm());
		reward.setRewardStatus(0);//状态为新建
		rewardService.saveOrUpdateKQAssessReward(reward);
		request.setAttribute("message", "考核奖励信息添加成功!");
		return rewardInfoInput();
	}
	
	/**
	 * ajax删除考核奖励信息
	 * @return
	 */
	public String ajaxDelRewardInfo(){
		String ids=request.getParameter("ids");
		String result="failure";
		if(ids!=null&&!"".equals(ids)){
			rewardService.deleteRewardInfo(ids);
			result="success";
		}
		try {
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (IOException e) {
		}
		return null;
	}
	
	/**
	 * 进入更新考核奖励信息页面
	 * @return
	 */
	public String updateRewardInfoInput(){
		String rewardId=request.getParameter("rewardId");
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			List<DictProTeam> proteams=rewardService.findDictProTeam();
			request.setAttribute("proteams", proteams);
			request.setAttribute("kqReward", kqReward);
		}
		return "updateRewardInfo";
	}
	
	/**
	 * 更新考核奖励信息
	 * @return
	 */
	public String updateRewardInfo(){
		String rewardId=request.getParameter("rewardId");
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			kqReward.setProteam(reward.getProteam());
			kqReward.setRewardPerson(reward.getRewardPerson());
			kqReward.setRewardTime(reward.getRewardTime());
			kqReward.setRewardContent(reward.getRewardContent());
			kqReward.setRewardAdd(reward.getRewardAdd());
			kqReward.setRewardSub(reward.getRewardSub());
			kqReward.setRewardStandard(reward.getRewardStandard());
			kqReward.setRewardNote(reward.getRewardNote());
			rewardService.saveOrUpdateKQAssessReward(kqReward);
			request.setAttribute("message", "考核信息修改成功!");
		}
		return rewardInfoInput();
	}
	
	/**
	 * 进入完善确认考核奖励信息页面
	 * @return
	 */
	public String completeRewardInfoInput(){
		String rewardId=request.getParameter("rewardId");
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			//根据班组ID查询班组下的人员信息
			List<UsersPrivs> users=rewardService.findUsersPrivs(kqReward.getProteam().getProteamid());
			request.setAttribute("kqReward", kqReward);
			request.setAttribute("users", users);
		}
		return "completeRewardInfo";
	}
	
	/**
	 * ajax根据班组ID获取班组下面的用户信息
	 * @return
	 */
	public String ajaxGetUser()throws Exception{
		String proteamId=request.getParameter("proteamId");
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		if(proteamId!=null&&!"".equals(proteamId)){
			List<UsersPrivs> users=rewardService.findUsersPrivs(Long.parseLong(proteamId));
			if(users!=null&&users.size()>0){
				for(UsersPrivs user:users){
					obj=new JSONObject();
					obj.put("userId", user.getUserid());
					obj.put("userName", user.getXm());
					array.put(obj);
				}
			}
		}
		try {
			response.setContentType("text/plain");
			response.getWriter().write(array.toString());
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 完善确认考核奖励信息
	 * @return
	 */
	public String completeRewardInfo(){
		String rewardId=request.getParameter("rewardId");
		String reward_person=request.getParameter("reward_person");
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			kqReward.setRewardPerson(reward_person);
			kqReward.setRewardStatus(1);
			rewardService.saveOrUpdateKQAssessReward(kqReward);
			request.setAttribute("message", "考核信息完善确认成功!");
		}
		return rewardInfoInput();
	}
	
	/**
	 * 审核考核奖励信息
	 * @return
	 */
	public String checkRewardInfo(){
		String rewardId=request.getParameter("rewardId");
		String result="failure";
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			kqReward.setRewardStatus(2);
			rewardService.saveOrUpdateKQAssessReward(kqReward);
			result="success";
		}
		try {
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (IOException e) {
		}
		return null;
	}
	
	/**
	 * 进入查询考核奖励信息页面
	 * @return
	 */
	public String queryRewardInput(){
		List<KQAssessReward> rewards=rewardService.findKQAssessReward(proteamId, reportTime, reportPerson, rewardPerson,2);
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		request.setAttribute("rewards", rewards);
		return "queryReward";
	}
	
	/**
	 * 进入通知公告信息页面
	 * @return
	 */
	public String noticeInfoInput(){
		//更新已近失效的公告,2:失效公告
		rewardService.updateNoticeStatus(2,YMD_SDFORMAT.format(new Date()));
		List<KQNoticeInfo> noticeInfos=rewardService.findKQNoticeInfo();
		request.setAttribute("noticeInfos", noticeInfos);
		return "noticeInfo";
	}
	
	/**
	 * 进入新增公告信息页面
	 * @return
	 */
	public String addNoticeInfoInput(){
		String rewardId=request.getParameter("rewardId");
		if(rewardId!=null&&!"".equals(rewardId)){
			KQAssessReward kqReward=rewardService.findKQAssessRewardById(Long.parseLong(rewardId));
			request.setAttribute("kqReward", kqReward);
		}
		return "addNoticeInfo";
	}
	
	/**
	 * 添加公告信息
	 * @return
	 */
	public String addNoticeInfo(){
		UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
		notice.setNoticeTime(YMD_SDFORMAT.format(new Date()));
		notice.setNoticePerson(user.getXm());
		notice.setNoticeStatus(0);
		rewardService.saveOrUpdateKQNoticeInfo(notice);
		request.setAttribute("message", "公告信息添加成功!");
		return noticeInfoInput();
	}
	
	/**
	 * ajax删除公告信息
	 * @return
	 */
	public String ajaxDelNoticeInfo(){
		String ids=request.getParameter("ids");
		String result="failure";
		if(ids!=null&&!"".equals(ids)){
			rewardService.deleteNoticeInfo(ids);
			result="success";
		}
		try {
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (IOException e) {
		}
		return null;
	}

	/**
	 * 进入修改公告信息页面
	 * @return
	 */
	public String updateNoticeInfoInput(){
		String noticeId=request.getParameter("noticeId");
		if(noticeId!=null&&!"".equals(noticeId)){
			KQNoticeInfo noticeInfo=rewardService.findKQNoticeInfoById(Long.parseLong(noticeId));
			request.setAttribute("noticeInfo", noticeInfo);
		}
		return "updateNoticeInfo";
	}
	
	/**
	 * 修改公告信息
	 * @return
	 */
	public String updateNoticeInfo(){
		String noticeId=request.getParameter("noticeId");
		if(noticeId!=null&&!"".equals(noticeId)){
			KQNoticeInfo noticeInfo=rewardService.findKQNoticeInfoById(Long.parseLong(noticeId));
			noticeInfo.setNoticeTitle(notice.getNoticeTitle());
			noticeInfo.setNoticeContent(notice.getNoticeContent());
			noticeInfo.setNoticeTime(YMD_SDFORMAT.format(new Date()));
			noticeInfo.setStartTime(notice.getStartTime());
			noticeInfo.setEndTime(notice.getEndTime());
			noticeInfo.setNoticeDept(notice.getNoticeDept());
			rewardService.saveOrUpdateKQNoticeInfo(noticeInfo);
			request.setAttribute("message", "公告信息修改成功!");
		}
		return noticeInfoInput();
	}
	
	/**
	 * ajax更新公告状态
	 * @return
	 */
	public String ajaxUpdateNoticeStatus(){
		String noticeId=request.getParameter("noticeId");
		String status=request.getParameter("status");
		String result="failure";
		if(noticeId!=null&&!"".equals(noticeId)){
			rewardService.updateNoticeStatus(Long.parseLong(noticeId), Integer.parseInt(status));
			result="success";
		}
		try {
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 查询日期内的公告信息
	 * @return
	 */
	public String queryDateNotice()throws Exception{
		String nowTime=YMD_SDFORMAT.format(new Date());
		List<KQNoticeInfo> noticeInfos=rewardService.findKQNoticeInfo(nowTime);
		JSONArray array=new JSONArray();
		JSONObject obj=null;
		if(noticeInfos!=null&&noticeInfos.size()>0){
			for(KQNoticeInfo noticeInfo:noticeInfos){
				obj=new JSONObject();
				obj.put("noticeId",noticeInfo.getId());
				obj.put("noticeTitle",noticeInfo.getNoticeTitle());
				obj.put("noticeContent", noticeInfo.getNoticeContent());
				array.put(obj);
			}
		}
		response.setContentType("text/plain");
		response.getWriter().write(array.toString());
		return null;
	}
	
	/**
	 * 进入查看公告信息页面
	 * @return
	 */
	public String detailNoticeInfoInput(){
		String noticeId=request.getParameter("noticeId");
		if(noticeId!=null&&!"".equals(noticeId)){
			KQNoticeInfo noticeInfo=rewardService.findKQNoticeInfoById(Long.parseLong(noticeId));
			request.setAttribute("noticeInfo", noticeInfo);
		}
		return "detailNoticeInfo";
	}
	
	/**
	 * 进入Excel导入页面
	 * @return
	 */
	public String uploadExcelInput(){
		return "upload_reward_excel";
	}
	
	//工时统计查询模块
	/**
	 * 查询工时日报
	 */
	public String queryDayReport(){
		if(time==null){
			 time=YMD_SDFORMAT.format(new Date());
		 }
		List<KQWorkTimeCount> workTimes=rewardService.findKQWorkTimeCount(proteamId, time, userName, gonghao);
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		request.setAttribute("workTimes", workTimes);
		return "queryDayReport";
	}
	
	/**
	 * 查询工时月报
	 * @return
	 */
	public String queryMonthReport(){
		 if(time==null){
			 time=YM_SDFORMAT.format(new Date());
		 }
		 List<Map<String,Object>> workCounts=rewardService.findMonthReport(proteamId, time);
		 List<DictProTeam> proteams=rewardService.findWorkProTeam();
		 request.setAttribute("proteams", proteams);
		 if(workCounts!=null&&workCounts.size()>0){
			 request.setAttribute("workCounts", workCounts);
		 }
		return "queryMonthReport";
	}
	
	/**
	 * 得到用户每月下得分详细信息
	 * @return
	 */
	public String queryMonthDetail(){
		String time=request.getParameter("time");
		String gonghao=request.getParameter("gonghao");
		List<KQWorkTimeCount>  workTimes=rewardService.findKQWorkTimeCount(time, gonghao);
		request.setAttribute("workTimes", workTimes);
		request.setAttribute("time", time);
		request.setAttribute("userName", request.getParameter("userName"));
		return "queryMonthDetail";
	}
	
	/**
	 * 最新查询工时日报
	 * @return
	 */
	public String queryDayReportNew(){
		if(time==null){
			 time=YMD_SDFORMAT.format(new Date());
		}
		if(proteamId==null){
			UsersPrivs user = (UsersPrivs) request.getSession().getAttribute("session_user");
			proteamId=user.getBzid();
		}
		List<KQUserItem> userItems=rewardService.findKQUserItem(proteamId, time, userName, gonghao);
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		request.setAttribute("userItems", userItems);
		return "queryDayReportNew";
	}
	
	/**
	 * 最新查询工时月报
	 * @return
	 */
	public String queryMonthReportNew(){
		 if(time==null){
			 time=YM_SDFORMAT.format(new Date());
		 }
		 List<Map<String,Object>> workCounts=rewardService.findMonthReportNew(proteamId, time);
		 List<DictProTeam> proteams=rewardService.findWorkProTeam();
		 request.setAttribute("proteams", proteams);
		 if(workCounts!=null&&workCounts.size()>0){
			 request.setAttribute("workCounts", workCounts);
		 }
		return "queryMonthReportNew";
	}
	
	/**
	 * 最新得到用户每月下得分详细信息
	 * @return
	 */
	public String queryMonthDetailNew(){
		String time=request.getParameter("time");
		String gonghao=request.getParameter("gonghao");
		List<KQUserItem>  userItems=rewardService.findKQUserItem(time, gonghao);
		request.setAttribute("userItems", userItems);
		request.setAttribute("time", time);
		request.setAttribute("userName", request.getParameter("userName"));
		return "queryMonthDetailNew";
	}
	
	//考勤排班模块
	/**
	 * 进入考勤排班页面
	 */
	public String workSetInput(){
		String proteamId=request.getParameter("proteamId");
		String days=request.getParameter("days");//获取一个月内的天数
		if(time==null){
			 time=YM_SDFORMAT.format(new Date());
		}
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		 
		if(proteamId!=null&&!"0".equals(proteamId)){
			List<UsersPrivs> users=rewardService.findUsersPrivs(Long.parseLong(proteamId));
			List<KQWorkSet> workSets=rewardService.findKQWorkSet(Long.parseLong(proteamId), time);
			request.setAttribute("users", users);
			request.setAttribute("days", Integer.parseInt(days));
			request.setAttribute("proteam", rewardService.findDictProTeamById(Long.parseLong(proteamId)));
			request.setAttribute("selectStr", getSelectStr(workSets));
		}
		return "workSet";
	}
	
    /**
     * 保存考勤排班信息
     * @return
     */
	public String ajaxSaveWorkSet(){
		String gonghao=request.getParameter("gonghao");
		String xm=request.getParameter("xm");
		String bzId=request.getParameter("proteamId");
		String bzName=request.getParameter("proteamName");
		String workMonth=request.getParameter("workMonth");
		String workDay=request.getParameter("workDay");
		String workType=request.getParameter("workType");
		try {
			String result=rewardService.saveOrUpdateKQWorkSet(gonghao, xm, bzId, bzName, workMonth, workDay, workType);
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (IOException e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * ajax删除考勤排班信息
	 * @return
	 */
	public String ajaxDelWorkSet(){
		String gonghao=request.getParameter("gonghao");
		String workDay=request.getParameter("workDay");
		try {
			String result=rewardService.deleteKQWorkSet(gonghao, workDay);
			response.setContentType("text/plain");
			response.getWriter().write(result);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return null;
	}
	
	/**
	 * 进入添加考勤排班页面
	 * @return
	 */
	public String addWorkSetInput_old(){
		String proteamId=request.getParameter("proteamId");
		String days=request.getParameter("days");//获取一个月内的天数
		if(time==null){
			 time=YM_SDFORMAT.format(new Date());
		}
		List<DictProTeam> proteams=rewardService.findWorkProTeam();
		request.setAttribute("proteams", proteams);
		 
		if(proteamId!=null&&!"0".equals(proteamId)){
			List<UsersPrivs> users=rewardService.findUsersPrivs(Long.parseLong(proteamId));
			List<KQWorkSet> workSets=rewardService.findKQWorkSet(Long.parseLong(proteamId), time);
			request.setAttribute("users", users);
			request.setAttribute("days", Integer.parseInt(days));
			request.setAttribute("proteam", rewardService.findDictProTeamById(Long.parseLong(proteamId)));
			String selectStr=getSelectStr(workSets);
			System.out.println(selectStr);
			request.setAttribute("selectStr", getSelectStr(workSets));
		}
		return "addWorkSet";
	}
	
	/**
	 * 进入添加考勤排班页面 第二版本
	 * @return
	 */
	public String addWorkSetInput(){
		String proteamId=request.getParameter("proteamId");
		String days=request.getParameter("days");//获取一个月内的天数
		if(time==null){
			 time=YM_SDFORMAT.format(new Date());
		}
		
		if(proteamId!=null&&!"0".equals(proteamId)){
			//得到上一个月
			String forwardMonth=getForwardMonth(time);
			//得到本月是否存在排班
			int nowMonthWorksetCount=rewardService.countMonthWorkSet(Long.parseLong(proteamId), time);
			//得到上一个月是否存在排班
			int forwardMonthWorksetCount=rewardService.countMonthWorkSet(Long.parseLong(proteamId), forwardMonth);
			//本月没有排班，并且上一个月有排班计划，就根据上个月的排班，得到本月班组下的排班计划信息，并插入到数据库中
			if(nowMonthWorksetCount==0&&forwardMonthWorksetCount>0){
				//得到上一个月的最后四天，根据最后四天的规则，来制定下一个月的规则
				List<String> lastFourDays=getLastFourDaysOfMonth(forwardMonth);
				rewardService.saveOrUpdateKQWorkSet(Long.parseLong(proteamId), lastFourDays, Integer.parseInt(days), time);
			}
			
			List<UsersPrivs> users=rewardService.findUsersPrivs(Long.parseLong(proteamId));
			List<KQWorkSet> workSets=rewardService.findKQWorkSet(Long.parseLong(proteamId), time);
			request.setAttribute("users", users);
			request.setAttribute("days", Integer.parseInt(days));
			request.setAttribute("proteam", rewardService.findDictProTeamById(Long.parseLong(proteamId)));
			request.setAttribute("selectStr", getSelectStr(workSets));
		}
		return "addWorkSet";
	}
	
	
	/**
	 * 获取下拉列表字符串
	 * @param workSets
	 * @return
	 */
	private String getSelectStr(List<KQWorkSet> workSets){
		StringBuilder sb=new StringBuilder("");
		if(workSets!=null&&workSets.size()>0){
			String[] array=null;
			String selectId=null;
			for(KQWorkSet workSet:workSets){
				array=workSet.getWorkDay().split("-");
				selectId=workSet.getGonghao()+"_"+Integer.parseInt(array[2]);
				sb.append(selectId+"-"+workSet.getWorkType()+",");
			}
			sb.deleteCharAt(sb.length()-1);
		}
		return sb.toString();
	}
	
	/**
	 * 根据年月字符串得到这个月的最后四天
	 * @param dateStr yyyy-MM:2014-07
	 * @return
	 */
	private List<String> getLastFourDaysOfMonth(String dateStr){
		List<String> dayArray=new ArrayList<String>();
		try {
			Date date=YM_SDFORMAT.parse(dateStr);
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.set(Calendar.DAY_OF_MONTH,1);
			cal.roll(Calendar.DAY_OF_MONTH,-4);
			dayArray.add(YMD_SDFORMAT.format(cal.getTime()));
			cal.roll(Calendar.DAY_OF_MONTH,1);
			dayArray.add(YMD_SDFORMAT.format(cal.getTime()));
			cal.roll(Calendar.DAY_OF_MONTH,1);
			dayArray.add(YMD_SDFORMAT.format(cal.getTime()));
			cal.roll(Calendar.DAY_OF_MONTH,1);
			dayArray.add(YMD_SDFORMAT.format(cal.getTime()));
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dayArray;
	}
	
	/**
	 * 根据当前月字符串获得上一个月
	 * @param dateStr
	 * @return
	 */
	@SuppressWarnings("static-access")
	private String getForwardMonth(String dateStr){
		String fowardMonth="";
		try {
			Date date = YM_SDFORMAT.parse(dateStr);
			Calendar cal=Calendar.getInstance();
			cal.setTime(date);
			cal.add(cal.MONTH, -1);
			fowardMonth=YM_SDFORMAT.format(cal.getTime());
		} catch (ParseException e) {
			e.printStackTrace();
		}
		return fowardMonth;
	}
	
	public Long getProteamId() {
		return proteamId;
	}

	public void setProteamId(Long proteamId) {
		this.proteamId = proteamId;
	}

	public String getReportTime() {
		return reportTime;
	}

	public void setReportTime(String reportTime) {
		this.reportTime = reportTime;
	}

	public String getReportPerson() {
		return reportPerson;
	}

	public void setReportPerson(String reportPerson) {
		this.reportPerson = reportPerson;
	}

	public String getRewardPerson() {
		return rewardPerson;
	}

	public void setRewardPerson(String rewardPerson) {
		this.rewardPerson = rewardPerson;
	}

	public String getTime() {
		return time;
	}

	public void setTime(String time) {
		this.time = time;
	}

	public String getUserName() {
		return userName;
	}

	public void setUserName(String userName) {
		this.userName = userName;
	}

	public String getGonghao() {
		return gonghao;
	}

	public void setGonghao(String gonghao) {
		this.gonghao = gonghao;
	}
}
