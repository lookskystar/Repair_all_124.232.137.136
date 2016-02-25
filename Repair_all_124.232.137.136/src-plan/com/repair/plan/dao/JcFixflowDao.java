package com.repair.plan.dao;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;

public interface JcFixflowDao {
	/**
	 * 根据修程修次和机车类型查找首个检修流程节点
	 * @param repairs
	 * @param jctype
	 * @return
	 */
	JCFixflow findJcFixFlowFirstByRepairs(String repairs, String jctype);
	
	/**
	 * 根据流程节点和日计划查找到下一个节点
	 * @param fixflow
	 * @param datePlanPri
	 * @return
	 */
	JCFixflow findNextJcFixFlow(JCFixflow fixflow, DatePlanPri datePlanPri);
}
