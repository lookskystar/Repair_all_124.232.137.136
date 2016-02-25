package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.MonPlanRecorder;
import com.repair.common.util.PageModel;

public interface MonPlanRecorderDao {
	/**
	 * 保存月计划检修机车记录
	 * @param monPlanRecorder
	 */
	void saveOrUpdate(MonPlanRecorder monPlanRecorder);
	
	/**
	 * 根据月计划ID查找该计划下的检修机车记录实体
	 * @param monPlanId
	 * @return
	 */
	List<MonPlanRecorder> findMonPlanRecorders(Integer monPlanId);
	
	/**
	 * 根据ID查找月计划检修机车记录实体
	 * @param monPrecId
	 * @return
	 */
	MonPlanRecorder findMonPlanRecorderById(Long monPrecId);
	
	/**
	 * 删除月计划检修机车记录
	 * @param planRecorder
	 */
	void deleteMonPlanRecorder(MonPlanRecorder planRecorder);
	
	/**
	 * 修改月计划下机车检修记录状态
	 * @param monPlanId
	 * @param beforeStatus
	 * @param afterStatus
	 */
	void updateMonPlanRecorderByMonPlan(Integer monPlanId, Short beforeStatus, Short afterStatus);
	
	/**
	 * 修改月计划机车检修记录状态
	 * @param monPrecIds
	 * @param status
	 */
	void updateMonPlanRecorderStatusByIds(Long[] monPrecIds, Short status);
	
	/**
	 * 根据月计划ID查找该计划下的检修机车记录实体
	 * @param monPlanId
	 * @return
	 */
	PageModel<MonPlanRecorder> queryMonPlanRecorders(Integer monPlanId);
}
