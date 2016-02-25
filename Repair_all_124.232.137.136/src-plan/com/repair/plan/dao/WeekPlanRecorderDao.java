package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.WeekPlanRecorder;

public interface WeekPlanRecorderDao {
	/**
	 * 根据周计划查找计划检修机车
	 * @param weekPriId
	 * @return
	 */
	List<WeekPlanRecorder> findWeekPlanRecorderByWeekPlan(Integer weekPriId);
	
	/**
	 * 根据ID查找周计划机车检修记录实体
	 * @param weekPriId
	 * @return
	 */
	WeekPlanRecorder findWeekPlanPriById(Long wekPrecId);
	
	/**
	 * 删除周计划机车检修记录
	 * @param weekPlanRecorder
	 */
	void deleteWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder);
	
	/**
	 * 保存周计划机车检修记录
	 * @param weekPlanRecorder
	 */
	void saveOrUpdate(WeekPlanRecorder weekPlanRecorder);
	
	/**
	 * 修改周计划下机车检修记录状态
	 * @param monPlanId
	 * @param beforeStatus
	 * @param afterStatus
	 */
	void updateWeekPlanRecorderByWeekPlan(Integer weekPriId, Short status);
	
	/**
	 * 根据状态值查找周计划检修机车记录
	 * @param status
	 * @return
	 */
	List<WeekPlanRecorder> findWeekPlanRecordersByStatus(Short status);
	
	/**
	 * 根据机车信息更新状态
	 * @param jcType
	 * @param jcNum
	 */
	void updateStatusByTrain(String jcType, String jcNum, String fixFreque, Short status);
	
	/**
	 * 查询周计划记录信息
	 * @param monPlanId
	 * @param planType
	 * @return
	 */
	public List<WeekPlanRecorder> queryWeekPlanRecorder(Integer monPlanId,Short planType);
	
	/**
	 * 根据状态值查找已发布日计划
	 * @param status
	 * @return
	 */
	List<MainPlanDetail> findMainPlanDetailByStatusAndTime();
	
	/**
	 * 根据id查找周计划详细
	 * @param id
	 * @return
	 */
	public MainPlanDetail findTimeByDatePlan(Long detailId);

	/**
	 * 更新计划详细表兑现状态
	 * @param detailId
	 * @param i
	 * @param datePlan
	 */
	public void updateStatusByDatePlan(Long detailId,Integer status,DatePlanPri datePlan);
	
	/**
	 * 删除日计划时更新计划表
	 */
	public void updateStatusBydeleteDatePlan(Integer rjhmid);
}
