package com.repair.work.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictFailure;
import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCDivision;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.PresetDivision;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.Page;

/**
 * 报活Service
 * @author Administrator
 *
 */
public interface JtPreDictService {
	/**
	 * 根据日计划和班组获取报活项目
	 * @return
	 */
	public List<JtPreDict> getJtPreDict(Integer rjhmId,Long bzId);
	
	/**
	 * 根据日计划查找我报的活
	 * @param rjhmId
	 * @return
	 */
	List<JtPreDict> findMyReportJtPreDict(Integer rjhmId,String gonghao);
	
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
	 * 查找一级部件
	 * @param jcType
	 * @return
	 */
	List<DictFirstUnit> findDictFirstUnitAll(String jcType);
	
	/**
	 * 根据一级部件查询二级部件
	 * @param firstunitid
	 * @return
	 */
	List<DictSecunit> findDictSecunitByFirstId(Long firstunitid);
	
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
	 * @param flag true 我的分工 false非我的分工
	 */
	public List<JtPreDict> listMyJtPreDict(int rjhmId,UsersPrivs userId,Short type, boolean flag);
	
	/**
	 * 查询分工
	 * @param rjhmId 日计划ID
	 * @param userid 用户ID
	 * @param type 3:临修加改 其他均为报活
	 */
	public List<JtPreDict> listMyJtPreDictNoPre(int rjhmId,UsersPrivs userId,Short type);
	
	
	
	/**
	 * 根据ID查找报活内容
	 * @param preDictId
	 * @return
	 */
	JtPreDict findJtPreDictById(Integer preDictId);
	
	/**
	 * 工人签字
	 * @param qtype 0:非全签 1：全签
	 * @param rjhmId 日计划ID
	 * @param checkInfo 检查情况
	 * @param ids 选择的记录ID字符串"-"隔开
	 * @param worker 用户
	 * @param type 3:为临修加改 其他均为报活
	 * @return noprivilege_failure:不是指定的检修人  success:成功
	 */
	public String updateJtPreDictOfWorkerRatify(int qtype,int rjhmId,String checkInfo,String ids,UsersPrivs worker,short type);
	
	/**
	 * 报活派工
	 * @param preDictId
	 * @param userids
	 * @return
	 */
	JtPreDict updateJtPreDictDistribution(Integer preDictId, Long[] userids);
	
	/**
	 * 删除报活派工
	 * @param preDictId
	 * @return
	 */
	void deleteJtPreDictDistribution(JtPreDict preDict);
	
	/**
	 * 更新报活派工
	 * @param preDictId
	 * @return
	 */
	void saveOrUpdateJtPreDict(JtPreDict preDict);
	
	/**
	 * 取消派工
	 */
	void delJtPreDictOfCancle(Integer preDictId);
	
	/**
	 * 作废报活
	 */
	void delJtPreDictOfAbolish(Integer preDict);
	
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
	 * 工长修改报活信息
	 * @param preDictIds
	 * @param userIds
	 */
	public void updateJtPreDict(String[] preDictIds,String[] userIds);
	
	/**
	 * 工长删除报活信息
	 * @param preDictIds
	 */
	public void deleteJtPreDict(String[] preDictIds);
	
	/**
	 * 查询故障信息总数
	 * @return
	 */
	public Long queryAllDictFailure(Map<String, String> conditionMap);
	
	/**
	 * 查询故障信息
	 * @param DictFailure id
	 */
	public DictFailure queryDictFailureById(int id);
	
	/**
	 * 分页查询故障信息
	 * @param DictFailure
	 * @return
	 */
	public List<DictFailure> queryDictFailurePage(Page page, Map<String, String> conditionMap);
	
	/**
	 * 添加故障信息
	 * @param DictFailure
	 * @return
	 */
	public boolean saveOrUpdateDictFailure(DictFailure dictFailure);
	
	/**
	 *  删除故障信息
	 * @param DictFailure
	 * @return
	 */
	public String deleteDictFailure(DictFailure dictFailure);
	
	/**
	 * 统计班组未完成的报活
	 * 返回值  {车型,车号,日计划ID,修程修次,未完成数量,类型(中修或小辅修)}  如{SS3B,123,123,X1,10,0}
	 */
	public List countUnfinishJtPreDict(Long bzId,String roles);
	
	/**
	 * 统计交车工长未签认完成信息
	 * 返回值  {车型,车号,日计划ID,修程修次,未完成数量,类型(中修或小辅修)}  如{SS3B,123,123,X1,10,0}
	 * @return
	 */
	public List countJCGZUnSigned();
	
}
