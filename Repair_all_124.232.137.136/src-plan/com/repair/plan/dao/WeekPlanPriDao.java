package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.WeekPlanPri;
import com.repair.common.pojo.WeekPlanRecorder;

public interface WeekPlanPriDao {
	/**
	 * 查找周计划（出作废和完成之外）
	 * @return
	 */
	List<WeekPlanPri> findWeekPlanPriByImplement();
	
	/**
	 * 根据ID查找周计划实体
	 * @param weekPriId
	 * @return
	 */
	WeekPlanPri findWeekPlanPriById(Integer weekPriId);
	
	/**
	 * 保存或修改周计划
	 * @param weekPlanPri
	 */
	void saveOrUpdate(WeekPlanPri weekPlanPri);
	
	/**
	 * 删除计划
	 * @param weekPlanPri
	 */
	void delete(WeekPlanPri weekPlanPri);
	
	/**
	 * 修改周计划状态
	 * @param weekPriId
	 * @param status
	 */
	void updateStatus(Integer weekPriId, Short status);
	
}
