package com.repair.work.dao;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.JCFixrec;
import com.repair.common.pojo.JCQZFixRec;
import com.repair.common.pojo.JCZXFixRec;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.UsersPrivs;

/**
 * 签字
 * @author Administrator
 *
 */
public interface SignWorkDao {
	
	/**
	 * 查询在修机车
	 * @param bzId
	 * @param nodeId
	 * @return
	 */
	public List<DatePlanPri> findDyPlanJC(Long bzId, int nodeId);
	
	/**
	 * 质检、技术、交车工长、验收查询机车  查询在修和待验的机车
	 * 2：技术 3:质检 4:交车工长 5：验收
	 */
	public List<DatePlanPri> findDyPlanJCByStatus(int rtype,Long userId);
	
	/**
	 * 查询项目记录(机车)--工长
	 */
	public List<JCFixrec> listJCFixrec(Integer rjhmId,Long bzId,Short recStas);
	
	/**
	 * 查询项目记录(机车)--工长
	 */
	public List<JCZXFixRec> listJCZXFixRec(Integer rjhmId,Long bzId,Short recStas);
	
	/**
	 * 质检、技术、验收、交车工长查询项目记录（机修）
	 * @param roleType 2：技术 3:质检 4:交车工长 5：验收
	 * @param signFlag 0 未签  1 查询所有
	 */
	public List<JCFixrec> listJCFixrec(Integer rjhmId,int roleType,Long userId,Integer signFlag);
	
	/**
	 * 质检、技术、验收、交车工长查询中修项目记录（机修）
	 * @param roleType 2：技术 3:质检 4:交车工长 5：验收
	 * @param signFlag 0 未签  1 查询所有
	 */
	public List<JCZXFixRec> listJCZXFixRec(Integer rjhmId,int roleType,Long userId,Integer signFlag);
	
	/**
	 * 统计未完成的记录(机车)
	 */
	public Long countUnfinishJCFixRec(Integer rjhmId,Long bzId,Short recStas);
	
	/**
	 * 查询待签的项目记录(秋整、春鉴)--工长
	 * @return
	 */
	public List<JCQZFixRec> listJCQZFixRec(Integer rjhmId,Long bzId,Short recStas);
	
	/**
	 * 质检、技术、验收、交车工长查询项目记录（秋整、春鉴）
	 * @param roleType 2：技术 3:质检 4:交车工长 5：验收
	 * @param signFlag 0 未签  1 查询所有
	 */
	public List<JCQZFixRec> listJCQZFixRec(Integer rjhmId,int roleType,Integer signFlag,UsersPrivs user);
	
	/**
	 * 统计未完成的记录(秋整、春鉴)
	 */
	public Long countUnfinishJCQZFixRec(Integer rjhmId,Long bzId,Short recStas);
	
	/**
	 * 查询待签的项目记录(临修、加改)
	 */
	public List<JtPreDict> listJtPreDict(Integer rjhmId,Long bzId,Short recStas,Short itemType);
	
	/**
	 * 质检、技术、验收、交车工长查询项目记录（临修、加改）
	 * @param roleType 2：技术 3:质检 4:交车工长 5：验收
	 * @param signFlag 0 未签  1 查询所有
	 */
	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,Integer signFlag,Short itemType,UsersPrivs user);
	
	
	/**
	 * 统计未完成的记录(临修、加改)
	 */
	public Long countUnfinishJtPreDict(Integer rjhmId,Long bzId,Short recStas,Short itemType);
	
	/**
	 * 统计角色未签认项目数
	 * 0:全部签认
	 * @param roleType 1：工长 2：技术 3:质检) 4:交车工长 5：验收
	 * @param rjhmId
	 * @param usersPrivs
	 * @return
	 */
	public Long countUnfinishJcFixrec(int roleType,Integer rjhmId,UsersPrivs usersPrivs);
	
	/**
	 * 统计中修角色未签认项目数
	 * 0:全部签认
	 * @param roleType 1：工长 2：技术 3:质检) 4:交车工长 5：验收
	 * @param rjhmId
	 * @param usersPrivs
	 * @return
	 */
	public Long countUnfinishJcZxFixrec(int roleType,Integer rjhmId,UsersPrivs usersPrivs);
	
	
	/**
	 * 查询质检或技术没有给自己分配的班组
	 * @param usersPrivs
	 * @return
	 */
	public List<DictProTeam> listNotChargeProTeam(Integer rjhmId);
	
	/**
	 * 查询中修质检或技术没有给自己分配的班组
	 * @param usersPrivs
	 * @return
	 */
	public List<DictProTeam> listZxNotChargeProTeam(Integer rjhmId);
	
    /**
     * 质检或技术查询非班组下的项目记录
     * @param rjhmId
     * @param bzId
     * flag:技术、质检标志 0：技术 
     * @return
     */
	public List<JCFixrec> listNotChargeJCFixrec(int rjhmId,long bzId,UsersPrivs usersPrivs,int flag);
	
    /**
     * 质检或技术查询非班组下的项目记录
     * @param rjhmId
     * @param bzId
     * @return
     */
	public List<JCZXFixRec> listNotChargeJCZxFixrec(int rjhmId,long bzId,UsersPrivs usersPrivs,int flag);
	
	/**
	 * 质检或技术查询非班组下的秋整项目记录
	 * @param rjhmId
	 * @param bzId
	 * @return
	 */
	public List<JCQZFixRec> listNotChargeJCQZFixRec(int rjhmId,long bzId);
	
	/**
	 * 质检或技术查询非班组下的临修加改项目记录
	 * @param rjhmId
	 * @param bzId
	 * @return
	 */
	public List<JtPreDict> listNotChargeJtPreDict(int rjhmId,long bzId);
	
	/**
	 * 统计查询班组下的项目是否完成
	 * 0:未完成
	 * 1：完成
	 * @param rjhmId
	 * @param bzId
	 * flag:质检或技术判别
	 * @return
	 */
	public int countSignedByBz(int rjhmId,long bzId,int roleType);
	
	/**
	 * 统计查询班组下的项目是否完成
	 * 0:未完成
	 * 1：完成
	 * @param rjhmId
	 * @param bzId
	 * flag:质检或技术判别
	 * @return
	 */
	public int countZxSignedByBz(int rjhmId,long bzId,int roleType);
	
	/**
	 * 查找角色所处班组是否签认完成
	 * @return
	 */
	public Long countUnfinishRoleJcFixrec(int roleType, Integer rjhmId,long bzId);
	
	/**
	 * 判断日计划流程节点下班组是否都完成
	 * @param rjhmId
	 * @param nodeId
	 * @return
	 */
	public Long countUnfinishBzFixFlow( Integer rjhmId,int nodeId);
	
	/**
	 * 统计角色未签项目
	 */
	public long countNoSignItemOfRole(int rjhmId,int roleType);
	
	/**
	 * 查询在修机车
	 * @param bzId
	 * @param nodeId
	 * @return
	 */
	public List<DatePlanPri> findDyPlanJCBy(String jcNum, String projectType);
	
	/**
	 * 查询未完成班组信息
	 * roleType:2：技术 3:质检
	 * @param rjhmId
	 * @param roleType
	 * @return
	 */
	public List<Object[]> findUnfinishedBz(int rjhmId,int roleType);
	
	/**
	 * 查询中修未完成班组信息
	 * roleType:2：技术 3:质检
	 * @param rjhmId
	 * @param roleType
	 * @return
	 */
	public List<Object[]> findUnfinishedZXBz(int rjhmId,int roleType);
	
	/**
	 * 查询角色id
	 * */
	public Integer findRoleId(Long userId);

	/**
	 * 统计临修各角色未完成卡控情况
	 * */
	public int findRoleSign(int roleId, int rjhmId);
}
