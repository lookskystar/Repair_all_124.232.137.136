package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.MonPlanPri;

public interface MonPlanPriDao {
	/**
	 * 查询月计划（除作废和完成之外）
	 * @return
	 */
	List<MonPlanPri> findMonDatePri();
	/**
	 * 根据状态查找月计划
	 * @param status
	 * @return
	 */
	List<MonPlanPri> findMonDatePri(Short status);
	/**
	 * 保存月计划
	 * @param monPlanPri
	 */
	void saveOrUpdate(MonPlanPri monPlanPri);
	
	/**
	 * 删除月计划
	 * @param monPlanId
	 */
	void deleteMonPlanPri(Integer monPlanId);
	
	/**
	 * 删除月计划
	 * @param monPlanPri
	 */
	void deleteMonPlanPri(MonPlanPri monPlanPri);
	
	/**
	 * 根据月计划ID查找月计划实体
	 * @param monPlanId
	 * @return
	 */
	MonPlanPri findMonDatePriById(Integer monPlanId);
	
	/**
	 * 修改月计划状态
	 * @param monPlanId
	 * @param status
	 */
	void updateStatus(Integer monPlanId, Short status);
	
	/**
	 * 查询所有的月计划信息
	 * @return
	 */
	public List<MonPlanPri> queryMonPlanPri();
}
