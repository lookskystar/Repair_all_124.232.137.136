package com.repair.part.dao;

import java.util.List;

import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.pojo.PJFixItem;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJPredict;
import com.repair.common.pojo.PJPresetRelateID;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface PJFixRecordDao {

	/**
	 * 新增一条配件检修记录
	 * @param pjFixRecord
	 */
	void savePJFixRecord(PJFixRecord pjFixRecord);

	/**
	 * 根据静态配件、流程节点和班组查询当前班组的检修项目
	 * @param pjSid 静态配件id
	 * @param flowId 流程id
	 * @param bzId 班组id
	 * @return
	 */
	PageModel findPageModelPJFixItemByPjSid(long pjSid, long flowId, long bzId);

	/**
	 * 根据检修流程记录和配件检修记录查询当前配件已经分配了的检修项目
	 * @param fixFlowRecord 检修流程记录
	 * @param pjRecId 配件的检修记录id
	 * @return
	 */
	List findPJFixRecByPJFixFlowRecAndPJRecId(PJFixFlowRecord fixFlowRecord,Long pjRecId);

	/**
	 * 根据日计划id和动态配件id查询当前配件的检修记录（唯一的）
	 * @param planId 日计划id
	 * @param pjDid 动态配件id
	 * @return
	 */
	Long findPJRecIdByDatePlanAndPJDynamic(long planId, long pjDid);

	/**
	 * 根据检修项目id获取检修项目
	 * @param itemId
	 * @return
	 */
	PJFixItem getPJFixItemById(long itemId);

	/**
	 * 分页查询当前用户未完成的检修 项目
	 * @param role
	 * @param user
	 * @return
	 */
	PageModel findPageModelUnfinishedPJFixItem(String role, UsersPrivs user);

	/**
	 * 分页查询工人（工长）未完成的检查项目
	 * @param pjdid 动态配件id
	 * @param teamId 班组id
	 * @return
	 */
	PageModel findPageModelUnfinishedInspectionItem(long pjdid,long teamId,Long pjRecId);
	
	/**
	 * 统计工人、工长签认项目数量
	 * @param pjDid
	 * @param teamId
	 * @param pjRecId
	 * @param role
	 * @return
	 */
	Long findSignedInspectionItem(long pjDid,long teamId,Long pjRecId,int role);

	/**
	 * 分页查询工人（工长）未完成的检测项目
	 * @param 动态配件id
	 * @param teamId 班组id
	 * @return
	 */
	PageModel findPageModelUnfinishedDetectItem(long pjdid,Long teamId,Long pjRecId);
	
	/**
	 * 统计工人、工长检测项目签认数量
	 * @param pjDid
	 * @param teamId
	 * @param pjRecId
	 * @param role
	 * @return
	 */
	Long findSignedDetectItem(long pjDid,long teamId,Long pjRecId,int role);

	/**
	 * 根据配件检修记录id获取配件检修记录
	 * @param recId 配件检修记录id
	 * @return
	 */
	PJFixRecord getPJFixRecordById(long recId);

	/**
	 * 修改配件检修记录
	 * @param pjFixRecord 配件检修记录
	 */
	void updatePJFixRecord(PJFixRecord pjFixRecord);

	/**
	 * 根据配件、流程节点和班组查询当前班组在当前流程的所有检修项目id
	 * @param pjsid 静态配件id
	 * @param nodeId 流程节点id
	 * @param bzId 班组id
	 * @return
	 */
	List<Long> findPJFixItemIdsByPJFlowBZ(long pjsid, Long nodeId, long bzId);

	/**
	 * 根据配件检修流程记录和班组查询当前班组在当前节点已经签认了的项目id
	 * @param fixFlowId 配件检修流程记录id
	 * @param bzId 班组id
	 * @return
	 */
	List<Long> findAssignedPJFixItemIdsByPJFlowRecordBZ(long fixFlowId,long bzId);

	/**
	 * 分页查询正在检修拥有子配件的大部件
	 * @return
	 */
	PageModel findPageModelUnitHasPart();

	/**
	 * 新增一个报活
	 * @param predict
	 */
	void savePJPredict(PJPredict predict);

	/**
	 * 查询当前所有报活待派工的项目
	 * @param user 当前用户
	 * @param flag 标识：0表示不需要调度审批的报活，1表示需要调度审批的报活
	 * @return
	 */
	PageModel findPageModelPJPredict(UsersPrivs user, int flag);

	/**
	 * 根据报活id获取报活
	 * @param predictId 报活id
	 * @return
	 */
	PJPredict getPJPredictById(long predictId);

	/**
	 * 修改配件检修报活
	 * @param predict 报活对象
	 */
	void updatePJPredict(PJPredict predict);

	/**
	 * 查询当前班组在当前流程节点的检修项目
	 * @param pjsid 静态配件id
	 * @param nodeId 流程节点id
	 * @param proteamid 班组id
	 * @return
	 */
	List<PJFixItem> findPJFixItemListByPJAndFlowAndTeam(Long pjsid, Long nodeId, Long proteamid);
	
	/**
	 * 查询当前班组在当前流程节点的检修项目
	 * @param pjsid 静态配件id
	 * @param nodeId 流程节点id
	 * @param proteamid 班组id
	 * @return
	 */
	List<PJFixItem> findPJFixItemListByPJAndFlowAndTeam(Long pjsid);
	
	/**
	 * 统计待签认配件
	 * @param type 1:工人 2：工长 3：技术 4：质检 5：交车工长 6：验收
	 * @param isTs 是否为探伤组
	 */
	List listUnfinishedPartCount(Long bzId,Integer type,String jcsType,Long firstUnitId,String pjName,boolean isTs);

	/**
	 *  分页查询当前班组负责检修还未检修完的配件
	 * @param user
	 * @param type 1:表示查询还未签配件  0:全部
	 * @return
	 */
	PageModel findPageModelPJPartFixRecordByBZUser(UsersPrivs user,String jcsType,Long firstUnitId,String pjName,String pjNum,Integer type);

	/**
	 * 根据动态配件id查询当前班组的所有检修项目记录
	 * @param pjDid 动态配件id
	 * @param proteamid 班组id
	 * @return
	 */
	PageModel findPageModelPJFixRecordByPJDidAndBZId(Long pjdid, Long proteamid);

	/**
	 * 除工人和工长外其他角色查询所有正在检修中的配件
	 * @param pjdid 动态配件id
	 * @param user 当前用户
	 * @return
	 */
	PageModel findPageModelFixingPJDynamic(long pjdid, UsersPrivs user,Long pjRecId);

	/**
	 * 查询当前配件的所有检修项目个数
	 * @param pjsid 静态配件id
	 * @return
	 */
	int findPJFixItemCount(long pjsid);

	/**
	 * 查询当前配件的已完成检修的检修项目记录个数
	 * @param pjRecId
	 * @return
	 */
	int findPJFixRecordCount(long pjRecId);
	
	/**
	 * 查询检测项目
	 * @param pjdid
	 * @param bzid
	 * @return
	 */
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long bzid, String flag);
	
	/**
	 * 查询配件检修记录
	 * @param recId
	 * @return
	 */
	public PJFixRecord findPJFixRecordById(Long recId);
	
	/**
	 * 通过预设分类信息查询配件检修记录信息
	 * @param presetId
	 * @param pjRecId
	 * @param type 0：检查项目 1：检测项目
	 * @return
	 */
	public List<PJFixRecord> findPJFixRecordByPresetRelateID(Long presetId,Long pjRecId,int type);
	
	/**
	 * 查询工人在预设分类下是否全部签认完成
	 * @param presetId
	 * @param pjRecId
	 * @param type
	 * @return
	 */
	public int countSignedPreset(Long presetId,Long pjRecId,int type);
	
	/**
	 * 统计检查检测项目预设分类信息
	 * @param presetId
	 * @param type
	 * @return
	 */
	public int countPJPresetItem(Long presetId,int type);
}
