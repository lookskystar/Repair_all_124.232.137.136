package com.repair.kq.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQNoticeInfo;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkSet;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.UsersPrivs;

public interface RewardService {
	
	/**
	 * 查找考核奖励信息
	 * @return
	 */
	public List<KQAssessReward> findKQAssessReward(Long proteamId,String reportTime,String reportPerson,String rewardPerson,Integer status);
	
	/**
	 * 查询所有班组信息
	 * @return
	 */
	public List<DictProTeam> findDictProTeam();
	
	/**
	 * 查找工作班组
	 * @return
	 */
	public List<DictProTeam> findWorkProTeam();
	
	/**
	 * 根据ID获得班组信息
	 * @param id
	 * @return
	 */
	public DictProTeam findDictProTeamById(Long id);
	
	/**
	 * 修改或保存考核奖励信息
	 * @param reward
	 */
	public void saveOrUpdateKQAssessReward(KQAssessReward reward);
	
	/**
	 * 删除考核奖励信息
	 * @param ids
	 */
	public void deleteRewardInfo(String ids);
	
	/**
	 * 根据ID查询考核奖励信息
	 * @param rewardId
	 * @return
	 */
	public KQAssessReward findKQAssessRewardById(Long rewardId);
	
	/**
	 * 根据班组ID查询班组下的人员信息
	 * @param proteamId
	 * @return
	 */
	public List<UsersPrivs> findUsersPrivs(Long proteamId);
	
	/**
	 * 查询信息公告
	 * @return
	 */
	public List<KQNoticeInfo> findKQNoticeInfo();
	
	/**
	 * 根据时间查询信息公告
	 * @return
	 */
	public List<KQNoticeInfo> findKQNoticeInfo(String nowTime);
	
	/**
	 * 增加信息公告
	 * @param noticeInfo
	 */
	public void saveOrUpdateKQNoticeInfo(KQNoticeInfo noticeInfo);
	
	/**
	 * 根据ID查询信息公告
	 * @param noticeId
	 * @return
	 */
	public KQNoticeInfo findKQNoticeInfoById(Long noticeId);
	
	/**
	 * 根据ID删除信息公告
	 * @param ids
	 */
	public void deleteNoticeInfo(String ids);
	
	/**
	 * 更新公告状态
	 * @param noticeId
	 * @param status
	 */
	public void updateNoticeStatus(Long noticeId,Integer status);
	
	/**
	 * 更新公告状态，将过期的公告设置为失效
	 * @param noticeId
	 * @param status
	 */
	public void updateNoticeStatus(Integer status,String nowTime);
	
	/**
	 * 根据班组名称获取班组信息
	 * @param proteamName
	 * @return
	 */
	public DictProTeam findDictProTeamByName(String proteamName);
	
	/**
	 * 查询工时统计日报
	 * @param proteamId
	 * @param time
	 * @param userName
	 * @param gonghao
	 * @return
	 */
	public List<KQWorkTimeCount> findKQWorkTimeCount(Long proteamId,String time,String userName,String gonghao);
	
	/**
	 * 查询工时统计日报
	 * @param proteamId
	 * @param time
	 * @param userName
	 * @param gonghao
	 * @return
	 */
	public List<KQUserItem> findKQUserItem(Long proteamId,String time,String userName,String gonghao);
	
	/**
	 * 查询月报信息
	 * @param proteamId
	 * @param time
	 * @return
	 */
	public List<Map<String,Object>> findMonthReport(Long proteamId,String time);
	
	/**
	 * 最新查询月报信息
	 * @param proteamId
	 * @param time
	 * @return
	 */
	public List<Map<String,Object>> findMonthReportNew(Long proteamId,String time);
	
	/**
	 * 查询工时统计日报
	 * @param proteamId
	 * @param time
	 * @param userName
	 * @param gonghao
	 * @return
	 */
	public List<KQWorkTimeCount> findKQWorkTimeCount(String time,String gonghao);
	
	/**
	 * 最新查询工时统计日报
	 * @param proteamId
	 * @param time
	 * @param userName
	 * @param gonghao
	 * @return
	 */
	public List<KQUserItem> findKQUserItem(String time,String gonghao);
	
	/**
	 * 保存或更新考勤排班信息
	 * @param gonghao
	 * @param xm
	 * @param bzId
	 * @param bzName
	 * @param workMonth
	 * @param workDay
	 * @param workType
	 * @param tdId
	 */
	public String saveOrUpdateKQWorkSet(String gonghao,String xm,String bzId,String bzName,String workMonth,
			String workDay,String workType);
	
	/**
	 * 查询考勤排班信息
	 * @param bzId
	 * @param workMonth
	 * @return
	 */
	public List<KQWorkSet> findKQWorkSet(Long bzId,String workMonth);
	
	/**
	 * 删除考勤排班信息
	 * @param gonghao
	 * @param workDay
	 */
	public String deleteKQWorkSet(String gonghao,String workDay);
	
	/**
	 * 统计当前班组当前月份下是否存在排班信息
	 * @param month
	 * @return
	 */
	public Integer countMonthWorkSet(Long bzId,String month);
	
	/**
	 * 更新或保存排班信息
	 */
	public void saveOrUpdateKQWorkSet(Long bzId,List<String> lastFourDays,int days,String nowMonth);
}
