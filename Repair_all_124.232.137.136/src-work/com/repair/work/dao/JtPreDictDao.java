package com.repair.work.dao;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;

/**
 * 报活业务类
 * @author Administrator
 *
 */
public interface JtPreDictDao {
	
	/**
	 * 根据日计划和班组获取报活项目
	 * @return
	 */
	public List<JtPreDict> getJtPreDict(Integer rjhmId,Long bzId);
	
	/**
	 * 查询我报的活
	 */
	public List<JtPreDict> findMyReportJtPreDict(Integer rjhmId,String gonghao);
	
	/**
	 * 根据日计划查找报活项目
	 * @param rjhmId
	 * @return
	 */
	List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId, Short type);
	
	/**
	 * 根据日计划查找报活项目（除临修加改项目外）
	 * @param rjhmId
	 * @return
	 */
	List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId);
	
	/**
	 * 根据日计划和班组查找该班组报活项目（除临修加改项目外）
	 * @param rjhmId
	 * @param proteamid
	 * @return
	 */
	List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId, Long proteamid, Short status);
	
	/**
	 *  根据日计划和班组查找该班组报活签认项目（除临修加改项目外）
	 * @param rjhmId
	 * @param proteamid
	 * @return
	 */
	List<JtPreDict> findJtPreDictSignItemByDatePlan(Integer rjhmId, Long proteamid);
	
	/**
	 * 根据记录ID查询捆绑的记录
	 */
	List<JtPreDict> findSmJtPreDicts(Integer preDictId);
	
	/**
	 * 报活保存
	 * @param preDict
	 */
	void saveOrUpdate(JtPreDict preDict);
	
	/**
	 * 删除报活信息（临修加改检修项目）
	 * @param preDict
	 */
	void delete(Integer[] preDictIds);
	
	/**
	 * 删除报活信息（临修加改检修项目）
	 * @param preDict
	 * @param rjhmId
	 */
	void delete(Integer preDictIds);
	
	/**
	 * 根据ID查找报活实体
	 * @param preDictIds
	 * @return
	 */
	JtPreDict findJtPreDictById(Integer preDictId);
	
	/**
	 * 根据记录Id删除其捆绑的报活记录
	 */
	void deleteSmJtPreDict(Integer preDictId);
	
	/**
	 * 检测临修加改日计划的报活项目是否分工完成
	 * @param datePlanPri
	 * @return false：没有检修内容或检修内容为分工完成，true：分工完成
	 */
	boolean isJtPreDictDispatchingByDatePlan(DatePlanPri datePlanPri);

	
	/**
	 * 根据ID获取报活
	 */
	public JtPreDict getJtPreDictById(int recId);
	
	/**
	 * 修改派工工人
	 */
	public void updateJtPreDictFixEmp(int recId, String workersId,String workersName);
	
	/**
	 * 查询我的派工
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 */
	public List<DatePlanPri> listMyJtPreDict(long userid,Short type);
	
	/**
	 * 查询我的分工
	 * @param rjhmId 日计划ID
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 * @param signFlag 0:未签  其它 全部
	 * @param flag true 我的分工 false非我的分工
	 */
	public List<JtPreDict> listMyJtPreDict(int rjhmId,UsersPrivs user,Short type,Integer signFlag,boolean flag);
	
	
	/**
	 * 查询分工
	 * @param rjhmId 日计划ID
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 * @param signFlag 0:未签  其它 全部
	 */
	public List<JtPreDict> listMyJtPreDictNoPre(int rjhmId,UsersPrivs user,Short type,Integer signFlag);

	
	/**
	 * 修改
	 */
	public void updateJtPreDict(JtPreDict jtPreDict);
	
	/**
	 * 质检、技术、验收、交车工长查询项目记录（临修、加改）
	 * @param roleType 2：技术 3:质检 4:交车工长 5：验收
	 * @param signFlag 0 未签  1 查询所有
	 */
	public List<JtPreDict> listJtPreDict(Integer rjhmId,int roleType,long userid);
	
	/**
	 * 查询故障表一级部件
	 */
	public List<String> listFirstUnitNameOfDictFailure(); 
	
	/**
	 * 查询故障表二级部件
	 */
	public List<String> listSecUnitNameOfDictFailure(String firstUnitName); 
	
	/**
	 * 查询故障表三级部件
	 */
	public List<String> listThirdUnitNameOfDictFailure(String firstUnitName,String secUnitName); 
	
	/**
	 * 查询故障内容
	 */
	public List<DictFailure> listDictFailure(String firstUnitName,String seccondUnitName,String thirdUnitName);
	
	/**
	 * 根据班组ID和机车类型查询班组下的预设分工信息
	 * @param proTeamId
	 * @return
	 */
	public List<PresetDivision> listPresetDivision(long proTeamId,String jcType);
	
	/**
	 * 根据预设分工类ID和日计划ID查询该预设分工下的作业分工信息
	 * @param divisionId
	 * @param planId
	 * @return
	 */
	public List<JCDivision> listJCDivision(Integer divisionId,Integer planId);
	
	/**
	 * 统计班组未完成的报活
	 * 返回值  {车型,车号,日计划ID,修程修次,未完成数量,类型(中修或小辅修)}  如{SS3B,123,123,X1,10,0}
	 */
	@SuppressWarnings("unchecked")
	public List countUnfinishJtPreDict(Long bzId);
	
	/**
	 * 统计班组未完成的报活
	 * 返回值  {车型,车号,日计划ID,修程修次,未完成数量,类型(中修或小辅修)}  如{SS3B,123,123,X1,10,0}
	 */
	@SuppressWarnings("unchecked")
	public List countUnfinishJtPreDict(Long bzId,String roles);
	
	/**
	 * 统计交车工长未签认完成信息
	 * 返回值  {车型,车号,日计划ID,修程修次,未完成数量,类型(中修或小辅修)}  如{SS3B,123,123,X1,10,0}
	 * @return
	 */
	public List countJCGZUnSigned();
	
}
