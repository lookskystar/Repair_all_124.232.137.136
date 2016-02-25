package com.repair.experiment.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JcExpRec;
import com.repair.common.pojo.JcExpSignRec;
import com.repair.common.pojo.JcExperimentItem;
import com.repair.common.pojo.UsersPrivs;

public interface ExperimentService {


	/**
	 * 获取当前用户的所选择试验的项目名字符集
	 * @param userid 用户id
	 * @param rjhmId 机车日计划id
	 * @return
	 */
	String findChoicedItemStrs(Long userid, int rjhmId);

	/**
	 * 查询一个机车检修日计划
	 * @param rjhmId 日计划id
	 * @return
	 */
	DatePlanPri findDatePlanPriById(int rjhmId);

	/**
	 * 根据机车试验流程节点和机车类型查询当前机车所有的试验
	 * @param flowId 试验流程节点id
	 * @param jcType  机车类型：SS3B、DF4等
	 * @return
	 */
	List<JcExperimentItem> findJcExperimentsByFlowIdAndJcType(int flowId,String jcType);

	/**
	 * 工人签认试验项目
	 * @param user 当前登录用户
	 * @param itemName 试验项目名
	 * @param itemVal  所填值
	 * @param rjhmId  机车检修日计划id
	 * @param experimentId  试验id
	 */
	void saveSignExperimentItemByWorker(UsersPrivs user, String itemName,
			String itemVal, int rjhmId, long experimentId);

	/**
	 * 查询当前用户在当前日计划中已经签认的试验项目
	 * @param expId 试验id
	 * @param rjhmId 日计划id
	 * @return
	 */
	Map<String, String> findSignedExpItems(String expId, int rjhmId);

	/**
	 * 修改某个试验项目记录的值
	 * @param user 当前用户
	 * @param itemRecId 试验项目记录id
	 * @param itemVal  试验值
	 */
	String saveChangeExpItemRecValByWorker(UsersPrivs user, long itemRecId,String itemVal);

	/**
	 * 进入试验时，判断试验的记录是否产生，若产生则不生成记录，否则生成一条试验记录
	 * @param rjhmId 日计划id
	 * @param expId 试验id
	 */
	void saveJcExperimentByDatePlanAndExpId(int rjhmId, String expId);

	/**
	 * 领导签认试验项目
	 * @param user 当前用户
	 * @param itemName 项目名
	 * @param rjhmId 日计划id
	 * @param experimentId 试验id
	 * @param roleFlag 角色标识符
	 * @return 操作成功返回success,操作失败返回error
	 */
	String saveSignExperimentItemByLead(UsersPrivs user, String itemName,int rjhmId, long experimentId, String roleFlag);

	/**
	 * 全签试验项目（除工人外的角色）
	 * @param user 当前用户
	 * @param rjhmId 日计划id
	 * @param experimentId 试验id
	 * @param roleFlag 角色标识符
	 * @return 操作成功返回success,操作失败返回error
	 */
	String saveSignExperimentItemAll(UsersPrivs user, int rjhmId,Long experimentId, String roleFlag);

	/**
	 * 签认试验时间
	 * @param user 当前用户
	 * @param expTime 试验时间
	 * @param rjhmId 日计划id
	 * @param experimentId 试验id
	 */
	void saveSignJcExperimentTime(UsersPrivs user, String expTime, int rjhmId,
			Long experimentId);

	/**
	 * 根据日计划和试验id查询试验的试验记录
	 * @param rjhmId 日记id
	 * @param expId 试验id
	 * @return
	 */
	JcExpRec findJcExperimentByDatePlanAndExpId(int rjhmId, String expId);

	/**
	 * 根据日计划和试验id查询水阻试验额外的签认记录
	 * @param rjhmId 日计划id
	 * @param expId 试验id
	 * @return
	 */
	List<JcExpSignRec> findJcExpSignRecsByPlanAndExp(int rjhmId, String expId);

}
