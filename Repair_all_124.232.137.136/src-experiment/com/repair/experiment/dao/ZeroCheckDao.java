package com.repair.experiment.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.ZeroCheck;

public interface ZeroCheckDao {
	
	/**
	 * 查找已交机车
	 * @return
	 */
	public List<DatePlanPri> findCheckDatePlanPri(UsersPrivs user);
	
	/**
	 * 保存零公里检查信息
	 * @param zeroCheck
	 */
	public void saveZeroCheck(ZeroCheck zeroCheck);
	
	/**
	 * 根据用户和日计划ID判断用户是否已经签认
	 * @return
	 */
	public ZeroCheck findZeroCheckByUserDpId(DatePlanPri datePlanPri,UsersPrivs user);
	
	/**
	 * 根据当前日计划ID查找相应的零公里检查信息
	 * @param dpId
	 * @return
	 */
	public List<ZeroCheck> findZeroCheckByDpId(int dpId);

}
