package com.repair.work.dao;

import java.util.List;

import com.repair.common.pojo.JCQZRange;

public interface JCQZRangeDao {

	/**
	 * 获取今年计划 的秋整范围
	 * @return long    
	 * @throws
	 */
	public List<JCQZRange> listPlanJCQZRange();
	
	
	/**
	 * 获取机车类型今年 计划完成数量
	 * @return long    
	 */
	public Long getJcTypePlanTotalCount(String jctype);
	
	/**
	 * 获取机车类型今年 实际完成数量
	 * @return long    
	 */
	public Long getJcTypeRealTotalCount(String jctype);
}
