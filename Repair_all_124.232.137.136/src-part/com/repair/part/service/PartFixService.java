package com.repair.part.service;

import java.util.List;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.PJDatePlan;
import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJFixFlow;
import com.repair.common.pojo.PJFixFlowRecord;
import com.repair.common.pojo.PJFixRecord;
import com.repair.common.pojo.PJPresetDivision;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.pojo.PJUnitPart;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface PartFixService {

	/**
	 * 查询所有的配件检修日计划
	 * @return
	 */
	PageModel findPageModelPartPlan();

	/**
	 * 查找所有的机车类型
	 * @return
	 */
	List<String> findJcTypeValueFromDictFirstUnit();
	
	/**
	 * 根据机车类型值和机车专业分页查询配件
	 * @param jcTypeVal 机车类型值
	 * @param firstUnitId 机车专业
	 * @return
	 */
	PageModel findPageModelPJStaticInfoByJcTypeAndProfession(String jcTypeVal,Long firstUnitId,String keyword);

	/**
	 * 根据机车类型值查找一级部件（专业）
	 * @param jcType
	 * @return
	 */
	List<DictFirstUnit> findDictFirstUnitsByJcType(String jcType);

	/**
	 * 根据静态配件id获取静态配件
	 * @param pjsid 静态配件id
	 * @return
	 */
	PJStaticInfo getPJStaticInfo(long pjId);

	/**
	 * 根据静态配件id分页查询对应的动态配件
	 * @param pjsid静态配件id
	 * @param flag 标识：1表示日计划时选择配件，2表示填写大部件的子配件
	 * @return
	 */
	PageModel findPageModelPJDynamicByPJSid(long pjsid,int flag);

	/**
	 * 查选当前日计划已经选择了的动态配件
	 * @param pid 日计划id
	 * @return
	 */
	List findPartChoicedByDatePlan(long pid);

	/**
	 * 根据日计划id获取日计划
	 * @param planId 配件检修日计划id
	 * @return
	 */
	PJDatePlan getPJDatePlanById(long planId);

	/**
	 * 根据动态配件id获取动态配件
	 * @param pjdId 动态配件id
	 * @return
	 */
	PJDynamicInfo getPJDynamicInfoById(long pjdId);

	/**
	 * 新增一条配件检修记录
	 * @param pjFixRecord
	 */
	void savePJFixRecord(PJFixRecord pjFixRecord);

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

	PageModel findPageModelPJFixFlowRecordByBZId(long teamId);

	/**
	 * 根据流程记录id获取流程记录
	 * @param flowRecId
	 * @return
	 */
	PJFixFlowRecord getPJFixFlowRecordById(Long flowRecId);

	/**
	 * 根据静态配件、流程节点和班组查询当前班组的检修项目
	 * @param pjSid 静态配件id
	 * @param flowId 流程id
	 * @param bzId 班组id
	 * @return
	 */
	PageModel findPageModelPJFixItemByPjSid(long pjSid, long flowId, long bzId);

	/**
	 * 根据日计划id和动态配件id查询当前配件的检修记录（唯一的）
	 * @param planId 日计划id
	 * @param pjDid 动态配件id
	 * @return
	 */
	Long findPJRecIdByDatePlanAndPJDynamic(long planId, long pjDid);

	List findPJFixRecByPJFixFlowRecAndPJRecId(PJFixFlowRecord fixFlowRecord,Long pjRecId);

	/**
	 * 给工人分配配件检修项目
	 * @param items 检修项目id集合
	 * @param userid 工人id
	 * @param userName 工人名
	 * @param flowRecId 当前配件所在流程的流程记录id
	 */
	void saveAssignFixItem(String[] items, String userid, String userName,String flowRecId);

	/**
	 * 分页查询当前用户未完成的检修 项目
	 * @param role
	 * @param user
	 * @return
	 */
	PageModel findPageModelUnfinishedPJFixItem(String role, UsersPrivs user);

	/**
	 * 分页查询工人（工长）未完成的检查项目
	 * @param pjDid 动态配件id
	 * @param teamId 班组id
	 * @return
	 */
	PageModel findPageModelUnfinishedInspectionItem(String pjDid,long teamId,Long pjRecId);
	
	/**
	 * 统计工人、工长检查项目签认数量
	 * @param pjDid
	 * @param teamId
	 * @param pjRecId
	 * @param role
	 * @return
	 */
	Long findSignedInspectionItem(String pjDid,long teamId,Long pjRecId,int role);

	/**
	 * 分页查询工人（工长）未完成的检测项目
	 * @param pjDid 动态配件id
	 * @param teamId 班组id
	 * @return
	 */
	PageModel findPageModelUnfinishedDetectItem(String pjDid,Long teamId,Long pjRecId);
	
	/**
	 * 统计工人、工长检测项目签认数量
	 * @param pjDid
	 * @param teamId
	 * @param pjRecId
	 * @param role
	 * @return
	 */
	Long findSignedDetectItem(String pjDid,long teamId,Long pjRecId,int role);

	/**
	 * 用户签认未完成的配件检修项目
	 * @param user 当前登录的用户
	 * @param records 签认的项目（分配的检修记录）
	 * @param status 检修情况
	 * @param roleFlag 用户的角色标识
	 * @return
	 * @throws Exception 
	 */
	String saveSignFixItem(UsersPrivs user, String records, String status, String roleFlag) throws Exception;
	
	/**
	 * 新增一个日计划
	 * @param datePlan
	 */
	void savePjDatePlan(PJDatePlan datePlan);

	/**
	 * 选择日计划需检修的动态配件
	 * @param pjDatePlan 配件检修日计划
	 * @param pjdidStr 动态配件id集合
	 * @param number 上车编号
	 */
	void saveChoiceDatePlanPJDynamic(PJDatePlan pjDatePlan, String pjdidStr, String number);

	/**
	 * 分页查询正在检修拥有子配件的大部件
	 * @return
	 */
	PageModel findPageModelUnitHasPart();

	/**
	 * 根据配件检修项目中的配件id查询所有子配件
	 * @param pjsid 配件id
	 * @return
	 */
	List<PJStaticInfo> findChildPJByParentPJFromFixItem(long pjsid);

	/**
	 * 保存一条配件检修大部件的子配件记录
	 * @param unitPart
	 */
	void savePJUnitPart(PJUnitPart unitPart);

	/**
	 * 选择大部件的子配件
	 * @param recordid 大部件检修记录
	 * @param pjdids 所选子配件的id
	 * @param user 当前操作用户
	 */
	void saveChoiceUnitPart(String recordid, List<Long> pjdids,UsersPrivs user);

	/**
	 * 检修时产生的报活
	 * @param user 当前用户
	 * @param bzid 指定的班组id
	 * @param bzname 指定的班组名
	 * @param approveVal是否需要审批
	 * @param desc 故障描述
	 * @param pjRecordId 当前检修项目的检修记录id
	 */
	void saveCreatePredict(UsersPrivs user, String bzid, String bzname,
			String approveVal, String desc, Long pjRecordId);

	/**
	 * 查询当前所有报活待派工的项目
	 * @param user 当前用户
	 * @param flag 标识：0表示不需要调度审批的报活，1表示需要调度审批的报活，2表示已完成派工
	 * @return
	 */
	PageModel findPageModelPJPredict(UsersPrivs user, int flag);

	/**
	 * 工长给检修报活派工
	 * @param predictid 报活id
	 * @param userid 工人id
	 * @param userName 工人名
	 */
	void saveAssignPredict(String predictid, String userid, String userName);

	/**
	 * 报活检修签认
	 * @param user 当前用户
	 * @param predictid 报活id
	 * @param flag 标识：1工人签认、2工长签认
	 * @return 返回签认成功或失败的提示信息
	 */
	String saveSignPredict(UsersPrivs user, String predictid, String flag);

	/**
	 * 给需审批的报活指派班组
	 * @param user 当前审批用户
	 * @param predictid 报活id
	 * @param bzid 班组id
	 * @param bzName 班组名
	 */
	void saveAssignPredictBZ(UsersPrivs user, String predictid, String bzid, String bzName);

	/**
	 * 为动态配件生成配件编码
	 * @param pjdidStr 动态配件id
	 * @param pjNum 配件编码
	 */
	String saveCreatePJNum(String pjdidStr, String pjNum,String py);
	
	/**
	 * 为多个动态配件生成配件编码
	 * @param pjdidStr 动态配件id
	 * @param pjNum 配件编码
	 */
	String saveCreatePJNum(String pjIds);

	/**
	 * 工人接活
	 * @param items 配件检修项目id集合
	 * @param user 当前用户
	 * @param flowRecId 当前检修配件的流程记录id
	 */
	void saveChoiceFixItem(String[] items, UsersPrivs user, String flowRecId);

	/**
	 * 选择一个动态配件，并让该配件的所有检修项目产生对应的记录
	 * @param pjDatePlan 日计划id
	 * @param pjdidStr 动态配件id
	 */
	void saveCreatePJFix(PJDatePlan pjDatePlan, String pjdidStr);
	
	/**
	 * 查询当前班组负责检修还未检修完的配件类
	 * @param user
	 * @param tsBzId 探伤班组ID
	 */
	List listUnfinishedPartCount(UsersPrivs user,String jcsType,Long firstUnitId,String pjName,Long tsBzId);

	/**
	 * 分页查询当前班组负责检修还未检修完的配件
	 * @param user
	 * @param type 1:表示查询还未签配件  0:全部
	 */
	PageModel findPageModelPJPartFixRecordByUser(UsersPrivs user,String jcsType,Long firstUnitId,String pjName,String pjNum,Integer type);

	/**
	 * 查询出所有在中心库或班组的待修动态配件
	 * @return
	 */
	PageModel findPageModelPJDynamic(String jcType,Long firstUnitId,String pjName,String pjNum,Integer pjStatus,Long bzId);

	/**
	 * 选择一个动态配件做检修
	 * @param pjdid
	 */
	void saveChoicePJFix(String pjdid);
	
	/**
	 * 选择一个动态配件做检修
	 * @param pjdid
	 */
	void saveChoicePJFixNew(String pjdid);

	/**
	 * 查询所有正在检修的动态配件
	 * @param pjDid 动态配件id
	 * @param user 当前用户
	 * @return
	 */
	PageModel findPageModelFixingPJDynamic(String pjDid, UsersPrivs user,Long pjRecId);

	/**
	 * 填写配件组装编号
	 * @param user 当前用户
	 * @param recId 记录id
	 * @param pjNumber 配件编号
	 * @return
	 */
	String savePjNumberIntoRecord(UsersPrivs user, String recId, String pjNumber);
	
	/**
	 * 查询配件动态信息
	 * @return
	 */
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String pjName,String pjNum);

	/**
	 * 签认检测项目
	 * @param user
	 * @param records
	 * @param status
	 * @return
	 */
	String saveSignDetectFixItem(UsersPrivs user, String records, String status);
	
	/**
	 * 查询检测项目
	 * @param pjdid
	 * @param bzid
	 * @return
	 */
	public List<PJFixRecord> findPJFixRecord(Long pjdid, Long bzid, String flag);
	
	/**
	 * 用户签认未完成的配件检修项目
	 * @param user 当前登录的用户
	 * @param records 签认的项目（分配的检修记录）
	 * @param status 检修情况
	 * @param roleFlag 用户的角色标识
	 * @return
	 * @throws Exception 
	 */
	String saveSignFixItem(UsersPrivs user, String records) throws Exception;
	
	/**
	 * 查找配件检修记录
	 * @param recId
	 * @return
	 */
	public PJFixRecord findPJFixRecordById(Long recId);
	
    /**
     * 保存委外配件检修
     * @param pjdid
     * @param trustFactory
     * @param trustother
     */
	void saveTrustPjFix(Long pjdid,String trustFactory,String trustother);
	
	/**
	 *查询本班组的动态配件信息
	 */
	public List listPJDynamicInfo(String jcType,Long firstUnitId,String pjName, Long bzId);
	
	/**
	 * 查询配件是否存在预设分工
	 * @param pjsId
	 * @return
	 */
	List<PJPresetDivision> findPJStaticInfoPreset(Long pjsId);
	
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
