package com.repair.experiment.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JcExpSignRec;

/**
 * 实验记录DAO
 * @author Administrator
 *
 */
public interface JcExpRecDao {
	/**
	 * 查询机车实验记录
	 * @param rjhmId 日计划ID
	 * @param jceiId 实验主项目ID
	 * @return
	 */
	List<JcExpRec> findJcExpRecs(int rjhmId, long jceiId);
	
	/**
	 * 根据试验项目记录id查询试验项目记录
	 * @param itemRecId 试验项目记录id
	 * @return
	 */
	JcExpRec findJcExpRecById(long itemRecId);

	/**
	 * 新增一条试验检修记录
	 * @param jcExpRec
	 */
	void saveJcExpRec(JcExpRec jcExpRec);

	/**
	 * 获取当前用户所选择的试验项目产生在试验记录中的记录
	 * @param userid 用户id
	 * @param rjhmId 日计划id
	 * @return
	 */
	List findUserChoicedItemRecNames(Long userid, int rjhmId);

	/**
	 * 查询机车检修计划
	 * @param rjhmId 机车检修计划id
	 * @return
	 */
	DatePlanPri findDatePlanPriById(int rjhmId);

	/**
	 * 获取当前试验项目已经签认了的项目
	 * @param rjhmId 日计划id
	 * @param experimentId 当前试验id
	 * @return
	 */
	List findSignedItemRecNameAndVal(int rjhmId, int experimentId);

	/**
	 * 修改试验项目记录
	 * @param jcExpRec
	 */
	void updateJcExpRec(JcExpRec jcExpRec);

	/**
	 * 根据日计划id和试验id查询试验
	 * @param datePlanId
	 * @param expId
	 * @return
	 */
	JcExpRec findJcExperimentByDatePlanAndExpId(int datePlanId, long expId);

	/**
	 * 根据日计划id、试验id和项目名查询对应项目的记录
	 * @param rjhmId 日计划id
	 * @param experimentId 试验id
	 * @param itemName 项目名（A1a或者 g1）
	 * @return
	 */
	List<JcExpRec> findJcExpRecList(int rjhmId, long experimentId, String itemName);
	
	/**
	 * 统计验收员是否都已经签认完全
	 * @param rjhmId
	 * @param experimentId
	 * @return
	 */
	public Long countJcYsExpRecList(int rjhmId, long experimentId);

	/**
	 * 查询用户的角色（角色id集合）
	 * @param userid 用户id
	 * @return
	 */
	List findUserRolesByUserId(Long userid);

	/**
	 * 查询当前试验在当前日计划的所有试验记录
	 * @param rjhmId 日计划id
	 * @param jcFlowId 试验当前所在流程节点id
	 * @param experimentId 试验id
	 * @return
	 */
	List<JcExpRec> findJcExpRecByPlanAndExp(int rjhmId,int jcFlowId, Long experimentId);

	/**
	 * 查询当前日计划除了当前试验的其他试验的记录
	 * @param rjhmId 日计划id
	 * @param experimentId 当前试验id
	 * @return
	 */
	List<JcExpRec> findOthersJcExpRecByPlan(int rjhmId,int jcFlowId, Long experimentId);

	/**
	 * 根据流程节点id查询流程
	 * @param flowId
	 * @return
	 */
	JCFixflow findJcFixflowById(Integer flowId);

	/**
	 * 修改日计划
	 * @param datePlan
	 */
	void updateDatePlanPri(DatePlanPri datePlan);

	/**
	 * 获取当前试验在当前日计划中签认了的记录
	 * @param rjhmId 日计划id
	 * @param parentId 试验项目父级id（试验id）
	 * @return
	 */
	List<JcExpRec> findExperimentAllRec(int rjhmId, int parentId);

	/**
	 * 查询当前流程节点所有的试验
	 * @param rjhmId 日计划id
	 * @param jcFlowId 流程节点id
	 * @return
	 */
	List<JcExpRec> findJcExperimentsByPlanAndFlow(int rjhmId, int jcFlowId);

	/**
	 * 获取水阻试验记录除工人外工长人员签认的检修记录
	 * @param rjhmId 日计划id
	 * @param itemName 试验项目标识
	 * @return
	 */
	JcExpSignRec findJcExpSignRecByPlanAndItemName(int rjhmId, String itemName);

	/**
	 * 保存水阻试验记录除工人外工长人员签认的检修记录
	 * @param signRecord
	 */
	void saveJcExpSignRec(JcExpSignRec signRecord);

	/**
	 * 根据日计划和试验id查询水阻试验记录除工人外工长人员签认的检修记录
	 * @param rjhmId 日计划id
	 * @param experimentId 试验id
	 * @return
	 */
	List<JcExpSignRec> findJcExpSignRecsByPlanAndExp(int rjhmId,long experimentId);

	/**
	 * 更新水阻试验记录除工人外工长人员签认的检修记录
	 * @param signRecord
	 */
	void updateJcExpSignRec(JcExpSignRec signRec);

	/**
	 * 根据日计划查询水阻试验记录除工人外工长人员签认的检修记录
	 * @param rjhmId
	 * @return
	 */
	List<JcExpSignRec> findJcExpSignRecListByPlan(int rjhmId);

	/**
	 * 根据日计划试验和试验项目名查询试验项目记录
	 * @param rjhmId 机车检修日计划
	 * @param experimentId 试验id
	 * @param itemName  试验项目名
	 * @return
	 */
	JcExpRec findJcExpRec(int rjhmId, long experimentId, String itemName);
	
	/**
	 * 修改试验项目记录
	 * @param jcExpRec
	 */
	void deleteJcExpRec(int rjhmId);
}
