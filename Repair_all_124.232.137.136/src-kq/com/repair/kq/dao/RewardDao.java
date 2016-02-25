package com.repair.kq.dao;

import java.util.List;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQAssessReward;
import com.repair.common.pojo.KQNoticeInfo;
import com.repair.common.pojo.KQUserItem;
import com.repair.common.pojo.KQWorkSet;
import com.repair.common.pojo.KQWorkTimeCount;
import com.repair.common.pojo.UsersPrivs;

public interface RewardDao {
	
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
	 * 修改或保存考核奖励信息
	 * @param reward
	 */
	public void saveOrUpdateKQAssessReward(KQAssessReward reward);
	
	/**
	 * 根据id删除考核奖励信息
	 * @param id
	 */
	public void deleteRewardInfo(Long id);
	
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
	public void deleteNoticeInfo(Long noticeId);
	
	/**
	 * 更新公告状态
	 * @param noticeId
	 * @param status
	 */
	public void updateNoticeStatus(Long noticeId,Integer status);
	
	/**
	 * 根据时间查询信息公告
	 * @return
	 */
	public List<KQNoticeInfo> findKQNoticeInfo(String nowTime);
	
	/**
	 * 根据班组名称获取班组信息
	 * @param proteamName
	 * @return
	 */
	public DictProTeam findDictProTeamByName(String proteamName);
	
	/**
	 * 根据班组ID获取班组信息
	 * @param proteamId
	 * @return
	 */
	public DictProTeam findDictProTeamById(Long proteamId);
	
	/**
	 * 更新公告状态，将过期的公告设置为失效
	 * @param noticeId
	 * @param status
	 */
	public void updateNoticeStatus(Integer status,String nowTime);
	
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
	 * 最新查询工时统计日报
	 * @param proteamId
	 * @param time
	 * @param userName
	 * @param gonghao
	 * @return
	 */
	public List<KQUserItem> findKQUserItem(String time,String gonghao);
	
	/**
	 * 查询月报信息
	 * @param proteamId
	 * @param time
	 * @return
	 */
	public List<Object[]> findMonthReport(Long proteamId,String time);
	
	/**
	 * 最新查询月报信息
	 * @param proteamId
	 * @param time
	 * @return
	 */
	public List<Object[]> findMonthReportNew(Long proteamId,String time);
	
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
	 * 根据用户工号和日期查询考勤排班信息
	 * @param gonghao
	 * @param workDay
	 * @return
	 */
	public KQWorkSet findKQWorkSet(String gonghao,String workDay);
	
	/**
	 * 保存考勤排班信息
	 * @param kqWorkSet
	 */
	public void saveOrUpdateKQWorkSet(KQWorkSet kqWorkSet);
	
	/**
	 * 查询考勤排班信息
	 * @param bzId
	 * @param workMonth
	 * @return
	 */
	public List<KQWorkSet> findKQWorkSet(Long bzId,String workMonth);
	
	/**
	 * 删除考勤排班信息
	 * @param workSet
	 */
	public void deleteKQWorkSet(KQWorkSet workSet);
	
	/**
	 * 统计当前班组月份下是否存在排班信息
	 * @param month
	 * @return
	 */
	public Integer countMonthWorkSet(Long bzId,String month);
	
	/**
	 * 根据用户工号查询用户月份下最后四天排班规则
	 * @param gonghao
	 * @return
	 */
	public List<KQWorkSet> findUserWorkset(String gonghao,List<String> lastFourDays);
}
