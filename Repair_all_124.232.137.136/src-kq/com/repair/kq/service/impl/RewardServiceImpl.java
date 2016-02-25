package com.repair.kq.service.impl;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQNoticeInfo;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkSet;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.UsersPrivs;
import com.repair.kq.dao.RewardDao;
import com.repair.kq.service.RewardService;

public class RewardServiceImpl implements RewardService{
	
	@Resource(name="rewardDao")
	private RewardDao rewardDao;

	@Override
	public List<KQAssessReward> findKQAssessReward(Long proteamId,String reportTime,String reportPerson,String rewardPerson,Integer status) {
		return rewardDao.findKQAssessReward(proteamId, reportTime, reportPerson, rewardPerson,status);
	}

	@Override
	public List<DictProTeam> findDictProTeam() {
		return rewardDao.findDictProTeam();
	}
	
	@Override
	public List<DictProTeam> findWorkProTeam() {
		return rewardDao.findWorkProTeam();
	}

	@Override
	public void saveOrUpdateKQAssessReward(KQAssessReward reward) {
		rewardDao.saveOrUpdateKQAssessReward(reward);
	}

	@Override
	public void deleteRewardInfo(String ids) {
		String[] array=ids.split(",");
		for(String id:array){
			rewardDao.deleteRewardInfo(Long.parseLong(id));
		}
	}

	@Override
	public KQAssessReward findKQAssessRewardById(Long rewardId) {
		return rewardDao.findKQAssessRewardById(rewardId);
	}

	@Override
	public List<UsersPrivs> findUsersPrivs(Long proteamId) {
		return rewardDao.findUsersPrivs(proteamId);
	}

	@Override
	public void deleteNoticeInfo(String ids) {
		String[] array=ids.split(",");
		for(String id:array){
			rewardDao.deleteNoticeInfo(Long.parseLong(id));
		}
	}

	@Override
	public List<KQNoticeInfo> findKQNoticeInfo() {
		return rewardDao.findKQNoticeInfo();
	}

	@Override
	public KQNoticeInfo findKQNoticeInfoById(Long noticeId) {
		return rewardDao.findKQNoticeInfoById(noticeId);
	}

	@Override
	public void saveOrUpdateKQNoticeInfo(KQNoticeInfo noticeInfo) {
		rewardDao.saveOrUpdateKQNoticeInfo(noticeInfo);
	}

	@Override
	public void updateNoticeStatus(Long noticeId, Integer status) {
		rewardDao.updateNoticeStatus(noticeId, status);
	}
	
	@Override
	public void updateNoticeStatus(Integer status,String nowTime) {
		rewardDao.updateNoticeStatus(status, nowTime);
	}

	@Override
	public List<KQNoticeInfo> findKQNoticeInfo(String nowTime) {
		return rewardDao.findKQNoticeInfo(nowTime);
	}

	@Override
	public DictProTeam findDictProTeamByName(String proteamName) {
		return rewardDao.findDictProTeamByName(proteamName);
	}

	@Override
	public List<KQWorkTimeCount> findKQWorkTimeCount(Long proteamId,
			String time, String userName, String gonghao) {
		return rewardDao.findKQWorkTimeCount(proteamId, time, userName, gonghao);
	}
	
	@Override
	public List<KQUserItem> findKQUserItem(Long proteamId,
			String time, String userName, String gonghao) {
		return rewardDao.findKQUserItem(proteamId, time, userName, gonghao);
	}
	
	@Override
	public List<KQUserItem> findKQUserItem(String time,String gonghao) {
		return rewardDao.findKQUserItem(time,gonghao);
	}

	@Override
	public List<Map<String,Object>> findMonthReport(Long proteamId, String time) {
		List<Object[]> workCounts=rewardDao.findMonthReport(proteamId, time);
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Map<String,Object> map=null;
		DictProTeam proteam=null;
		for(Object[] obj:workCounts){
			proteam=rewardDao.findDictProTeamById(Long.parseLong(obj[0]+""));
			map=new HashMap<String,Object>();
			map.put("proteamName", proteam.getProteamname());
			map.put("gonghao", obj[1]);
			map.put("userName", obj[2]);
			map.put("score", obj[3]);
			list.add(map);
		}
		return list;
	}
	
	@Override
	public List<Map<String,Object>> findMonthReportNew(Long proteamId, String time) {
		List<Object[]> workCounts=rewardDao.findMonthReportNew(proteamId, time);
		List<Map<String,Object>> list=new ArrayList<Map<String,Object>>();
		Map<String,Object> map=null;
		DictProTeam proteam=null;
		for(Object[] obj:workCounts){
			proteam=rewardDao.findDictProTeamById(Long.parseLong(obj[0]+""));
			map=new HashMap<String,Object>();
			map.put("proteamName", proteam.getProteamname());
			map.put("gonghao", obj[1]);
			map.put("userName", obj[2]);
			map.put("score", obj[3]);
			list.add(map);
		}
		return list;
	}

	@Override
	public List<KQWorkTimeCount> findKQWorkTimeCount(String time, String gonghao) {
		return rewardDao.findKQWorkTimeCount(time, gonghao);
	}

	@Override
	public DictProTeam findDictProTeamById(Long id) {
		return rewardDao.findDictProTeamById(id);
	}

	@Override
	public String saveOrUpdateKQWorkSet(String gonghao, String xm, String bzId,
			String bzName, String workMonth, String workDay, String workType) {
		String result="failure";
		KQWorkSet workSet=rewardDao.findKQWorkSet(gonghao, workDay);
		if(workSet==null){
			workSet=new KQWorkSet();
			workSet.setGonghao(gonghao);
			workSet.setXm(xm);
			workSet.setBzId(Long.parseLong(bzId));
			workSet.setBzName(bzName);
			workSet.setWorkMonth(workMonth);
			workSet.setWorkDay(workDay);
			workSet.setWorkType(Integer.parseInt(workType));
			workSet.setTemplate(Integer.parseInt(workType));
			rewardDao.saveOrUpdateKQWorkSet(workSet);
			result="save";
		}else{
			workSet.setWorkType(Integer.parseInt(workType));
			rewardDao.saveOrUpdateKQWorkSet(workSet);
			result="update";
		}
		return result;
	}

	@Override
	public List<KQWorkSet> findKQWorkSet(Long bzId, String workMonth) {
		return rewardDao.findKQWorkSet(bzId, workMonth);
	}

	@Override
	public String deleteKQWorkSet(String gonghao, String workDay) {
		String result="failure";
		KQWorkSet workSet=rewardDao.findKQWorkSet(gonghao, workDay);
		if(workSet!=null){
			rewardDao.deleteKQWorkSet(workSet);
			result="success";
		}
		return result;
	}

	@Override
	public Integer countMonthWorkSet(Long bzId,String month) {
		return rewardDao.countMonthWorkSet(bzId,month);
	}

	@Override
	public void saveOrUpdateKQWorkSet(Long bzId,List<String> lastFourDays,int days,String nowMonth) {
		List<UsersPrivs> users=rewardDao.findUsersPrivs(bzId);
		DictProTeam proteam=rewardDao.findDictProTeamById(bzId);
		
		for(UsersPrivs user:users){
			//查询用户上一个月最后四天的排班计划
			List<KQWorkSet> workSets=rewardDao.findUserWorkset(user.getGonghao(), lastFourDays);
			if(workSets!=null&&workSets.size()>0){
				List<Integer> userWorkSetRules=this.getUserWorksetRule(lastFourDays,workSets);
				List<Integer> userMonthWorkTypes=this.getUserMonthWorkType(userWorkSetRules, days);
				for(int i=0;i<userMonthWorkTypes.size();i++){
					if(userMonthWorkTypes.get(i)!=0){
						KQWorkSet workSet=new KQWorkSet();
						workSet.setGonghao(user.getGonghao());
						workSet.setXm(user.getXm());
						workSet.setBzId(bzId);
						workSet.setBzName(proteam.getProteamname());
						workSet.setWorkMonth(nowMonth);
						if(i<9){
							workSet.setWorkDay(nowMonth+"-0"+(i+1));
						}else{
							workSet.setWorkDay(nowMonth+"-"+(i+1));
						}
						workSet.setWorkType(userMonthWorkTypes.get(i));
						workSet.setTemplate(userMonthWorkTypes.get(i));
						rewardDao.saveOrUpdateKQWorkSet(workSet);
					}
				}
			}else{
				continue;
			}
		}
	}
	
	/**
	 * 得到用户排班规则
	 * @param lastFourDays
	 * @param workSets
	 * @return
	 */
	private List<Integer> getUserWorksetRule(List<String> lastFourDays,List<KQWorkSet> workSets){
		List<Integer> userRules=new ArrayList<Integer>();
		for(String day:lastFourDays){
			boolean flag=true;
			for(KQWorkSet workSet:workSets){
				if(workSet.getWorkDay().equals(day)){
					userRules.add(workSet.getTemplate());
					flag=false;
					break;
				}
			}
			if(flag){
				userRules.add(0);
				flag=true;
			}
		}
		return userRules;
	}
	
	/**
	 * 根据用户上个月最后四天排班规则得到用户下一个月的排班类型
	 * 0:休息  1：白班 2：晚班
	 * @param userWorkSetRules:用户上一个月最后四天排班信息-->[1,2,0,0]
	 * @param days:本月天数-->31
	 * @return [1,2,0,0,1,2,0,0...]共31个
	 */
	private List<Integer> getUserMonthWorkType(List<Integer> userWorkSetRules,int days){
		List<Integer> userMonthWorkTypes=new ArrayList<Integer>();
		int len=userWorkSetRules.size();
		for(int i=len;i<len+days;i++){
			int index=i%len;
			userMonthWorkTypes.add(userWorkSetRules.get(index));
		}
		return userMonthWorkTypes;
	}
}
