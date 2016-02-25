package com.repair.part.dao;

import java.util.List;
import com.repair.common.pojo.PJDatePlan;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.util.PageModel;
import com.repair.common.pojo.DictFirstUnit;


public interface PJDatePlanDao {
	
	/**
	 * 分页查找所有的配件检修日计划
	 * @return
	 */
	PageModel findPageModelPartPlan();
	/**
	 * 查找所有的机车类型
	 * @return
	 */
	List<String> findJcTypeValueFromDictFirstUnit();
	/**
	 * 根据集成类型查找一级部件（专业）
	 * @param jcType
	 * @return
	 */
	List<DictFirstUnit> findDictFirstUnitsByJcType(String jcType);
	/**
	 * 根据机车类型值和机车专业分页查询配件
	 * @param jcTypeVal 机车类型值
	 * @param firstUnitId 机车专业
	 * @return
	 */
	PageModel findPageModelPJStaticInfoByJcTypeAndProfession(String jcTypeVal,Long firstUnitId,String keyword);
	/**
	 * 新增一个日计划
	 * @param datePlan
	 */
	void savePjDatePlan(PJDatePlan datePlan);
	/**
	 * 根据日计划id获取日计划
	 * @param planId 配件检修日计划id
	 * @return
	 */
	PJDatePlan getPJDatePlanById(long planId);
	/**
	 * 查看日计划已经选择了的动态配件的个数
	 * @param planId 日计划id
	 * @return
	 */
	int findChoicedPJNum(long planId);
	/**
	 * 修改配件检修日计划
	 * @param pjDatePlan
	 */
	void updateDatePlan(PJDatePlan pjDatePlan);
	/**
	 * 查询当前日计划所有的动态配件配件的检修记录（注：一个动态配件对应了一条配件检修记录，不同于配件检修项目的检修记录）
	 * @param pjDatePlan 日计划
	 * @return
	 */
	List<PJFixRecord> findPJDynamicFixRecListByDatePlan(PJDatePlan pjDatePlan);

}
