package com.repair.plan.service;

import java.util.List;
import java.util.Map;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcFixSeq;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JGPlanContent;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.MonPlanPri;
import com.repair.common.pojo.MonPlanRecorder;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.pojo.WeekPlanPri;
import com.repair.common.pojo.WeekPlanRecorder;
import com.repair.common.util.PageModel;

public interface PlanManageService {
	
	
	/**
	 * 查找机车走行
	 * @return
	 */
	List<JtRunKiloRec> findJtRunKiloRecs();
	
	/**
	 * 查找实施月计划（除作废和完成之外）
	 * @return
	 */
	List<MonPlanPri> findMonDatePriByImplement();
	
	/**
	 * 保存月计划
	 * @param monPlanPri
	 */
	void saveMonPlanPri(MonPlanPri monPlanPri);
	
	/**
	 * 删除月计划
	 * @param monPlanPri
	 */
	void deleteMonPlanPri(Integer monPlanId);
	
	/**
	 * 删除月计划
	 * @param monPlanPri
	 */
	void deleteMonPlanPri(MonPlanPri monPlanPri);
	
	/**
	 * 根据月计划ID查找月计划实体
	 * @param monPlanId
	 * @return
	 */
	MonPlanPri findMonPlanPriById(Integer monPlanId);
	
	/**
	 * 根据月计划ID查找该计划下的检修机车记录实体
	 * @param monPlanId
	 * @return
	 */
	List<MonPlanRecorder> findMonPlanRecorders(Integer monPlanId);
	
	/**
	 * 保存月计划检修记录
	 * @param monPlanRecorder
	 */
	Integer saveMonPlanRecorder(Integer monPlanId, Long[] runIds);
	
	/**
	 * 保存或修改月计划检修记录
	 * @param monPlanRecorder
	 */
	void saveOrUpdateMonPlanRecorder(MonPlanRecorder monPlanRecorder);
	
	/**
	 * 保存或修改周计划检修记录
	 * @param weekPlanRecorder
	 */
	void saveOrUpdateWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder);
	
	/**
	 * 根据ID查找月计划检修机车记录实体
	 * @param monPrecId
	 * @return
	 */
	MonPlanRecorder findMonPlanRecorderById(Long monPrecId);
	
	/**
	 * 删除月计划检修机车记录
	 * @param planRecorder
	 */
	void deleteMonPlanRecorder(MonPlanRecorder planRecorder);
	
	/**
	 * 根据ID查找机车走行实体
	 * @param runKiloRecId
	 * @return
	 */
	JtRunKiloRec findJtRunKiloRecById(Long runKiloRecId);
	
	/**
	 * 查询修程修次
	 * @return
	 */
	List<DictJcFixSeq> findDictJcFixSeqs();
	
	/**
	 * 提交审核月计划
	 * @param monPlanId
	 */
	void submitAuditMonPlanPri(Integer monPlanId);
	
	/**
	 * 正式发布月计划
	 * @param monPlanId
	 */
	void officialIssueMonPlanPri(Integer monPlanId);
	
	/**
	 * 审核通过月计划
	 * @param monPlanId
	 */
	void auditPassMonPlanPri(Integer monPlanId);
	
	/**
	 * 根据状态查找月计划
	 * @param status
	 * @return
	 */
	List<MonPlanPri> findMonPlanPriByStatus(Short status);
	
	/**
	 * 更新月计划检修机车记录状态
	 * @param monPrecIds
	 * @param status
	 */
	void updateMonPlanRecorderStatus(Long[] monPrecIds, Short status);
	
	/**
	 * 查找周计划（除作废和完成之外）
	 * @return
	 */
	List<WeekPlanPri> findWeekPlanPriByImplement();
	
	/**
	 * 根据ID查找周计划实体
	 * @param weekPriId
	 * @return
	 */
	WeekPlanPri findWeekPlanPriById(Integer weekPriId);
	
	/**
	 * 根据周计划查找检修机车记录
	 * @param weekPriId
	 * @return
	 */
	List<WeekPlanRecorder> findWeekPlanRecorderByWeekPlan(Integer weekPriId);
	
	/**
	 * 根据ID查找周计划机车检修记录实体
	 * @param wekPrecId
	 * @return
	 */
	WeekPlanRecorder findWeekPlanRecorderById(Long wekPrecId);
	
	/**
	 * 删除周计划机车检修记录
	 * @param weekPlanRecorder
	 */
	void deleteWeekPlanRecorder(WeekPlanRecorder weekPlanRecorder);
	
	/**
	 * 保存周计划
	 * @param weekPlanPri
	 */
	void saveWeekPlanPri(WeekPlanPri weekPlanPri);
	
	/**
	 * 删除周计划
	 * @param weekPlanPri
	 */
	void deleteWeekPlanPri(WeekPlanPri weekPlanPri);
	
	/**
	 * 保存周计划机车检修记录
	 * @param weekPlanRecorder
	 */
	void saveWeekPlanRecorder(Long[] wekPrecIds, WeekPlanPri weekPlanPri);
	
	/**
	 * 正式发布周计划
	 * @param weekPriId
	 */
	void officialIssueWeekPlanPri(Integer weekPriId);
	
	/**
	 * 查找再修日计划
	 * @return
	 */
	List<DatePlanPri> findInRepairDailyPlan();
	
	/**
	 * 根据角色查找用户
	 * @param roleName
	 * @return
	 */
	List<UsersPrivs> findUsersPrivsByRoleName(String roleName);
	
	/**
	 * 根据ID查找用户实体
	 * @param userId
	 * @return
	 */
	UsersPrivs findUsersPrivsById(Long userId);
	
	/**
	 * 根据状态查找周计划机车检修记录
	 * @param status
	 * @return
	 */
	List<WeekPlanRecorder> findWeekPlanRecordersByStatus(Short status);
	
	/**
	 * 保存日计划
	 * @param datePlanPri
	 */
	Integer saveDailyPlan(DatePlanPri datePlanPri);
	
	/**
	 * 根据ID查找日计划实体
	 * @param rjhmId
	 * @return
	 */
	DatePlanPri findDatePlanPriById(Integer rjhmId);
	
	/**
	 * 修改日计划
	 * @param datePlanPri
	 * @return
	 */
	Integer updateDailyPlan(DatePlanPri datePlanPri);
	
	/**
	 * 修改日计划
	 * @param datePlanPri
	 * @return
	 */
	public void saveOrUpdateDatePlanPri(DatePlanPri datePlanPri);
	
	/**
	 * 删除日计划
	 * @param datePlanPri
	 * @return
	 */
	Integer deleteDailyPlan(Integer rjhmId);
	
	/**
	 * 查找日计划对应的检修内容（临修加改检修项目）
	 * @param rjhmId
	 * @return
	 */
	List<JtPreDict> findJtPreDictByDatePlan(Integer rjhmId);
	
	/**
	 * 添加报活信息（临修加改检修项目）
	 * @param preDict
	 */
	void saveJtPreDict(JtPreDict preDict);
	
	/**
	 * 删除报活信息（临修加改检修项目）
	 * @param preDictIds
	 */
	void deleteJtPreDict(Integer[] preDictIds);
	
	/**
	 * 根据状态查找日计划
	 * @param status
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByStatus(Integer status);
	
	/**
	 * 根据具体班组查找报活日计划（派工）
	 * @param proteamid
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByJtPreDict(Long proteamid);
	
	/**
	 * 根据具体班组或报活状态查找报活日计划
	 * @param proteamid
	 * @param status
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByJtPreDict(Long proteamid, Short status);
	
	/**
	 * 根据角色查找报活的签字日计划
	 * @param roleType 1:技术员，2:质检员，3:交车工长，4:验收员
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByJtPreDictSign(Long userid,Integer roleType);
	
	/**
	 * 工长强制完成
	 */
	public String updateForcFinishJCFlow(Integer rjhmId,Long bzId,Integer nodeId);
	
	/**
	 * 判断当前添加的月计划记录是否已存在于周计划记录
	 */
	public boolean exitWeekPlanRe(Long[] wekPrecIds, WeekPlanPri weekPlanPri);
	
	/**
	 * 流程节点扭转
	 * @param rjhmId 日计划ID
	 * @param userId 用户ID
	 * @param noteId 下一个节点ID
	 * @returns 1:机车检修流程为空，2:根据流程节点查找检修项目对应班组为空，3:成功
	 */
	public Integer nodeToReverse(int rjhmId, Long userId, int noteId);
	
	/**
	 * 判断当日机车计划是否已存在
	 * @param jcType 机车类型
	 * @param userId 机车编号
	 * @param fixFreque 修程修次
	 */
	public DatePlanPri dailyIsExist(String jcType, String jcNum, String fixFreque);
	
	/**
	 * 查询所有的月计划信息
	 * @return
	 */
	public List<MonPlanPri> queryMonPlanPri();
	
	/**
	 * 根据月计划ID查找该计划下的检修机车记录实体
	 * @param monPlanId
	 * @return
	 */
	PageModel<MonPlanRecorder> queryMonPlanRecorders(Integer monPlanId);
	
	/**
	 * 查询周计划记录信息
	 * @param monPlanId
	 * @param planType
	 * @return
	 */
	public List<WeekPlanRecorder> queryWeekPlanRecorder(Integer monPlanId,Short planType);
	
	/**
	 * 查找机车型号
	 * @return
	 */
	List<DictJcStype> findDictJcStype();
	
	/**
	 * 统计加改信息
	 */
	public List listJGPlanContent();
	
	/**
	 * 根据项目，车型统计加改信息
	 */
	public List listJGPlan(String jgContent,String jcType);
	
	/**
	 * 查找机车类型
	 * */
	public List<String> findJcTypes();

	/**
	 * 查找加改项目
	 * */
	public List<String> findJgItems();

	/**
	 * 保存新增加改项目
	 * */
	public void saveJgItem(JGPlanContent jPlan);
	
	/**
	 * 保存加改日计划
	 * */
	public void saveItemDatePlan(DatePlanPri datePlanPri);
	
	/**
	 * 保存加改报活
	 * */
	public void saveItemJtPreDict(JtPreDict jtPreDict);
	
	
	/**
	 * 编辑加改信息
	 */
	public List editeJGPlanContent();
	
	/**
	 * 根据项目查找加改信息
	 */
	public List findJgByitem(String content);
	
	/**
	 * 删除加改项目
	 */
	public String deleteJGPlanContent(JGPlanContent content);
	
	/**
	 * 编辑加改项目
	 */
	public String updateJgItem(JGPlanContent jPlan);

	/**
	 * 查询各车型配属数量
	 * */
	public List findJcAcounts();
	
	/**
	 * 查询加改项目汇总
	 * */
	public Map<String,List<Map<String,String>>> findJcItemAcount();
	
	/**
	 * 查询加改项目机车列表
	 * */
	public List findJcItemList(String itemName, String jctype);
	
	/**
	 * 根据id编辑加改项目
	 */
	public String updateJgItemById(JGPlanContent jPlan);
	
	/**
	 * 保存计划信息
	 * @param mainPlan
	 * @param list
	 */
	public void savePlan(MainPlan mainPlan,List<MainPlanDetail> list);
	
	/**
	 * 查询时间段内的计划详情
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<MainPlanDetail> findMainPlanDetail(String startTime,String endTime);
	
	/**
	 * 根据ID查询MainPlan信息
	 * @param Id
	 * @return
	 */
	public MainPlan findMainPlanById(Long Id);
	
	/**
	 * 根据主计划ID查询计划详细信息
	 * @param mainPlanId
	 * @return
	 */
	public List<MainPlanDetail> findMainPlanDetailByMainId(Long mainPlanId);
	
	/**
	 * 保存或更新主计划信息
	 * @param mainPlan
	 */
	public void saveOrUpdateMainPlan(MainPlan mainPlan);
	
	/**
	 * 删除计划信息
	 * @param mainPlanId
	 * @param mainPlanDetailId
	 */
	public void delPlan(String mainPlanId,String mainPlanDetailId);
	
	/**
	 * 查询主计划列表
	 * @return
	 */
	public List<MainPlan> findMainPlanList();
	
	/**
	 * 查询主计划列表
	 * @return
	 */
	public PageModel<MainPlan> findMainPlanList(String startTime,String endTime);
	
	/**
	 * 根据ID查询计划详细信息
	 * @param id
	 * @return
	 */
	public MainPlanDetail findMainPlanDetailById(Long id);
	
	/**
	 * 保存计划详细信息
	 * @param mainPlanDetail
	 */
	public void saveOrUpdateMainPlanDetail(MainPlanDetail mainPlanDetail);
	
	/**
	 * 根据时间查询主计划表
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<MainPlan> findMainPlanByTime(String startTime,String endTime);
	
	/**
	 * 查询加改项目是否已经存在
	 * */
	public long findJGPlanContent(String item);
	
	/**
	 * 更新计划详情表中特定字段特定值
	 * @param id
	 * @param inputName
	 * @param inputVal
	 */
	public void updateMainPlanDetial(Long id,String inputName,String inputVal);
	
	/**
	 * 根据状态查找已发布日计划
	 * @param status
	 * @return
	 */
	List<MainPlanDetail> findMainPlanDetailByStatusAndTime();
	
	/**
	 * 根据id查找计划明细
	 * @param detailId
	 * @return
	 */
	public void updateStatusByDatePlan(Long detailId,DatePlanPri datePlan);
	
	/**
	 * 删除日计划时更新计划表
	 */
	public void updateStatusBydeleteDatePlan(Integer rjhmid);
}
