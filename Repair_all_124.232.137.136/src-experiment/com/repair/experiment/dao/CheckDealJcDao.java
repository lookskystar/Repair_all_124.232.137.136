package com.repair.experiment.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.SignedForFinish;
import com.repair.common.pojo.UsersPrivs;

public interface CheckDealJcDao {
	
	/**
	 * 查找待验机车的日计划信息
	 * @return
	 */
	public List<Object[]> findCheckDealDatePlan();
	
	/**
	 * 保存机车竣工交验单
	 */
	public void saveSignedForFinish(SignedForFinish signedForFinish);
	
	/**
	 * 保存日计划信息
	 * @param datePlanPri
	 */
	public void saveDatePlanPri(DatePlanPri datePlanPri);
	
    /**
     * 根据类型统计报活
     * 0：未完成报活  1：未派工
     * @param type
     * @return
     */
	public int findJtPreDictByStatus(int type,int rjhmId);

}
