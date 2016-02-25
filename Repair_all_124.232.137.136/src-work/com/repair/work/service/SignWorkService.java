package com.repair.work.service;

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
public interface SignWorkService {
	/**
	 * 查询在修机车
	 * @param bzId
	 * @param nodeId
	 * @return
	 */
	public List<DatePlanPri> findDyPlanJC(Long bzId, int nodeId);
	
	/**
	 * 质检、技术、交车工长、验收查询机车 查询在修和待验的机车
	 * 2：技术 3:质检 4:交车工长 5：验收
	 */
	public List<DatePlanPri> findDyPlanJCByStatus(int rtype,Long userId);
	
	/**
	 * 查询待签的项目记录(机车)
	 * @param rjhmId 日计划
	 * @param user 登陆用户
	 * @param roleType 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * @return
	 */
	public List<JCFixrec> listSignJCFixrec(int rjhmId,UsersPrivs user,int roleType);
	
	/**
	 * 查询中修待签的项目记录(机车)
	 * @param rjhmId 日计划
	 * @param user 登陆用户
	 * @param roleType 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * @return
	 */
	public List<JCZXFixRec> listSignJCZxFixrec(int rjhmId,UsersPrivs user,int roleType);
	
	/**
	 * 签字(机修)
	 * @param rtype 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * 工长签名流程： 1、判断该班组是否全部完成 2、判断是否进入下一个流程
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划
	 * @param ids 选择的记录IDS "11-12"
	 * @param usersPrivs 签名用户
	 * @return failure:签名失败   noprivilege_failure:没有权限或没有可签项目!   success:成功
	 */
	public String updateJCFixRecOfSign(int rtype,int qtype,int rjhmId,String ids,UsersPrivs usersPrivs);
	
	/**
	 * 中修签字(机修)
	 * @param rtype 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * 工长签名流程： 1、判断该班组是否全部完成 2、判断是否进入下一个流程
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划
	 * @param ids 选择的记录IDS "11-12"
	 * @param usersPrivs 签名用户
	 * @return failure:签名失败   noprivilege_failure:没有权限或没有可签项目!   success:成功
	 */
	public String updateJCZxFixRecOfSign(int rtype,int qtype,int rjhmId,String ids,UsersPrivs usersPrivs);
	
	/**
	 * 查询待签的项目记录(秋整、春鉴)
	 * @param rjhmId 日计划
	 * @param bzId 班组ID
	 * @param type 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * @return 
	 */
	public List<JCQZFixRec> listSignJCQZFixRec(int rjhmId,UsersPrivs user,int roleType);
	
	/**
	 * 签字(秋整、春鉴)
	 * @param rtype 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * 工长签名流程： 1、判断该班组是否全部完成 2、判断是否进入下一个流程
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划
	 * @param ids 选择的记录IDS "11-12"
	 * @param usersPrivs 签名用户
	 * @return failure:签名失败   noprivilege_failure:没有权限或没有可签项目!  success:成功
	 */
	public String updateJCQZFixRecOfSign(int rtype,int qtype,int rjhmId,String ids,UsersPrivs usersPrivs);
	
	/**
	 * 查询待签的项目记录(临修、加改)
	 * @param rjhmId 日计划
	 * @param bzId 班组ID
	 * @param type 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * @param itemType 3:临修加改 其他报活
	 * @return
	 */
	public List<JtPreDict> listSignJtPreDict(int rjhmId,UsersPrivs user,int roleType,Short itemType);
	
	/**
	 * 签字(临修、加改)
	 * @param rtype 1：工长 2：技术 3:质检 4:交车工长 5：验收
	 * 工长签名流程： 1、判断该班组是否全部完成 2、判断是否进入下一个流程
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划
	 * @param ids 选择的记录IDS "11-12"
	 * @param usersPrivs 签名用户
	 * @param itemType 3:临修加改 其他报活
	 * @return failure:签名失败   noprivilege_failure:没有权限或没有可签项目!  success:成功
	 */
	public String updateJtPreDictOfSign(int rtype,int qtype,int rjhmId,String ids,UsersPrivs usersPrivs,Short itemType);
	
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
	 * 查询在修机车
	 * @param bzId
	 * @param nodeId
	 * @return
	 */
	public List<DatePlanPri> findDyPlanJCBy(String jcNum, String projectType);
	
	/**
	 * 查询未完成班组信息
	 * roleType:2：技术 3:质检
	 * jcType:0:小辅修 1：中修
	 * @param rjhmId
	 * @param roleType
	 * @return
	 */
	public List<Map<String,Object>> findUnfinishedBz(int rjhmId,int roleType,int jcType);
	
	/**
	 * 报活补签
	 * */
	public String updateReSignReport(UsersPrivs usersPrivs,String dealSituation,Integer preDictId);
	
	/**
	 * 角色补签
	 * */
	public String updateLeadReSignReport(UsersPrivs usersPrivs,Integer preDictId);
	
	/**
	 * 检查质检 技术 交车工长 验收 临修车签认完成情况 
	 * 1 质检未完成 2 技术未完成 3 交车工长未完成 4 验收未完成
	 * */
	public int checkRoleSign(int rihmId);
}
