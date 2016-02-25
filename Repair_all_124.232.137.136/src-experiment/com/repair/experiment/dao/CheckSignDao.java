package com.repair.experiment.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJwd;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DlJcJyMxb;
import com.repair.common.pojo.DlJcJyZb;
import com.repair.common.pojo.JCSignature;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.NrJcJyzb;
import com.repair.common.pojo.UsersPrivs;

public interface CheckSignDao {
	
	/**
	 * 查找待交验机车(相应节点和状态)
	 * @return
	 */
	public List<DatePlanPri> findCheckJc();
	
	/**
	 * 根据节点ID查找待交验机车
	 * @param nodeId
	 * @return
	 */
	public List<DatePlanPri> findCheckJc(int nodeId,Long userId);
	
	/**
	 * 根据节点查询是否存在所有验收未签字--临时急用
	 */
//	public long countAccepterUnSignItem(DatePlanPri datePlanPri); 
	
	/**
	 * 保存签到信息
	 * @param signature
	 */
	public void saveSignature(JCSignature signature);
	
	/**
	 * 根据用户ID和日计划ID查询用户是否已经签到
	 * @param user
	 * @param datePlan
	 * @return
	 */
	public JCSignature findJCSignatureByUserDpId(UsersPrivs user,DatePlanPri datePlan);
	
	/**
	 * 根据日计划ID查找对应的日计划信息
	 * @param rjhmId
	 * @return
	 */
	public DatePlanPri findDatePlanPriById(int rjhmId);
	
	/**
	 * 根据日计划ID查询相应的交验签到信息
	 * @param datePlanId
	 * @return
	 */
	public List<JCSignature> findJCSignatureByDatePlanId(int datePlanId);
	
	/**
	 * 根据日计划ID查询检修班组
	 */
	public List<DictProTeam> listFixProTeam(int datePlanId);
	
	/**
	 * 保存机车车交车检测项目和检测项目明细
	 * @param dljcjtzb
	 */
	public void saveDlJcJyZbMxb(DlJcJyZb dljcjtzb);
	
	/**
	 * 根据日计划ID查询交车检测项目明细信息
	 * @param datePlanId
	 * @return
	 */
	public List<DlJcJyMxb> findDlJcJyMxbByDpId(int datePlanId);
	
	/**
	 * 根据交车检测项目明细Id查询对应的记录信息
	 * @param djmId
	 * @return
	 */
	public DlJcJyMxb findDlJcJyMxbById(int djmId);
	
	/**
	 * 保存检测项目明细信息
	 * @param djm
	 */
	public void saveDlJcJyMxb(DlJcJyMxb djm);
	
	/**
	 * 根据交车检测项目Id和状态查询对应的记录信息
	 * @param jyzId
	 * @param status
	 * @return
	 */
	public List<DlJcJyMxb> findDlJcJyMxbByIdStatus(int jyzId,short status);
	
	/**
	 * 根据日计划查询内燃机车交车检测项目信息
	 * @param dpId
	 * @return
	 */
	public NrJcJyzb findNrJcJyzbByDpId(int dpId); 
	
	/**
	 * 保存内燃机车交车检测项目信息
	 * @param nrJcJyzb
	 */
	public void saveNrJcJyzb(NrJcJyzb nrJcJyzb);
	
	/**
	 * 更新内燃机车交车检测项目信息
	 * @param nrJcJyzb
	 */
	public void updateNrJcJyzb(NrJcJyzb nrJcJyzb);
	
	/**
	 * 根据日计划ID查询交车检测项目信息
	 * @param datePlan
	 * @return
	 */
	public DlJcJyZb findDlJcJyZbByDpId(DatePlanPri datePlan);
	
	/**
	 * 更新日计划信息
	 * @param datePlan
	 */
	public void updateDatePlanPri(DatePlanPri datePlan);
	
	/**
	 * 根据工号查询用户信息
	 * @param gonghao
	 * @return
	 */
	public UsersPrivs getUsersPrivsByGonghao(String gonghao);
	
	/**
	 * 查询报活完成情况
	 * */
	public List<JtPreDict> findPredicts(Integer rjhmId);
	
	/**
	 * 查询机务段信息
	 * @return
	 */
	public List<DictJwd> findDictJwds();
}
