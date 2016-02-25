package com.repair.part.dao;

import java.util.List;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PJFixFlow;
import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.util.PageModel;

public interface PJFixFlowDao {

	/**
	 * 根据流程类型查询对应的流程
	 * @param flowTypeId
	 * @return
	 */
	List<PJFixFlow> findPJFixFlowListByFlowType(int flowTypeId);

	/**
	 * 根据静态配件查询当前流程的班组
	 * 
	 * @param pjsid
	 * @param nodeId
	 * @return
	 */
	List<DictProTeam> findFixFlowTeam(Long pjsid, Long nodeId);
	
	/**
	 * 根据静态配件查询当前流程的班组
	 * 
	 * @param pjsid
	 * @param nodeId
	 * @return
	 */
	List<DictProTeam> findFixFlowTeam(Long pjsid);

	/**
	 * 新增一条配件检修流程记录
	 * @param flowRecord
	 */
	void savePJFixFlowRecord(PJFixFlowRecord flowRecord);

	/**
	 * 分页查询当前班组所有未完成的检修配件（配件流程检修节点记录）
	 * @param teamId
	 * @return
	 */
	PageModel findPageModelPJFixFlowRecordByBZId(long teamId);

	/**
	 * 根据流程记录id获取流程记录
	 * @param flowRecId
	 * @return
	 */
	PJFixFlowRecord getPJFixFlowRecordById(Long flowRecId);

	/**
	 * 修改配件检修流程记录
	 * @param fixFlowRecord
	 */
	void updatePJFixFlowRecord(PJFixFlowRecord fixFlowRecord);

	/**
	 * 查询当前流程节点的所有流程记录
	 * @param fixFlowRecord 当前流程节点的流程记录
	 * @return
	 */
	List<PJFixFlowRecord> findPJFixFlowRecordListByFlowId(PJFixFlowRecord fixFlowRecord);


}
