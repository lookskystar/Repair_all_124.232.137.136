package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFlowRec;

public interface JcFlowRecDao {
	/**
	 * 保存或修改流程记录
	 * @param flowRec
	 */
	void saveOrUpdate(JCFlowRec flowRec);
	
	/**
	 * 调用存储过程将数据插入记录表
	 */
	void saveJcFixRec(DatePlanPri datePlanPri);
	
	/**
	 * 调用存储过程将数据插入记录表
	 */
	void saveJcFixRec(DatePlanPri datePlanPri, int noteid);
	
	/**
	 * 统计日计划查询未完成的记录
	 */
	public Long countUnfinishRec(int rjhmId,int nodeId);
	
	/**
	 * 根据日计划和班组查询
	 */
	public JCFlowRec getJCFlowRec(int rjhmId,long bzId,int nodeId);
	
	/**
	 * 更新机车检修记录班组信息
	 * @param rjhmId
	 * @param proteamId
	 */
	void updateJcFixRecProteam(int rjhmId,Long proteamId);
	
	/**
	 * 更新机车检修记录班组信息
	 * @param rjhmId
	 * @param proteamId:负责包修班组
	 * @param workTeamList:不进行保修班组集合
	 */
	void updateJcFixRecProteam(int rjhmId,Long proteamId,List<Long> workTeamList);
	
	/**
	 * 查询相应机车类型和修程修次下班组是否有需要签认的项目
	 * @param datePlanPri
	 * @return
	 */
	public Long countJcFixItemByBZ(DatePlanPri datePlanPri,Long proteamId);
	
	/**
	 * 查询日计划下检修记录是否存在,存在则不再进行插入相关检修信息，防止重复记录出现
	 * @param rjhmId
	 * @param projectType
	 * @return
	 */
	public Long countFixRecByPlanId(int rjhmId,int projectType);
	
	
}
