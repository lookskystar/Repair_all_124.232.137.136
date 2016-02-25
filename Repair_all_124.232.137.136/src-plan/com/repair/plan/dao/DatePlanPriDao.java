package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;
import com.repair.common.pojo.UsersPrivs;
import com.repair.common.util.PageModel;

public interface DatePlanPriDao {
	/**
	 * 查找日计划
	 * @param status
	 */
	List<DatePlanPri> findDatePlanPriByStatus(Integer status);
	
	/**
	 * 查找新建和再修日计划
	 * @param status
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByInRepair();
	
	/**
	 * 保存或修改日计划
	 * @param datePlanPri
	 */
	void saveOrUpdate(DatePlanPri datePlanPri);
	
	/**
	 * 根据ID查找日计划实体
	 * @param rjhmId
	 * @return
	 */
	DatePlanPri findDatePlanPriById(Integer rjhmId);
	
	/**
	 * 判断日计划机车是否已经再修
	 * @param datePlanPri
	 * @return
	 */
	boolean isJcFixRecByDatePlanPri(Integer rjhmId);
	
	/**
	 * 删除日计划
	 * @param datePlanPri
	 */
	void delete(DatePlanPri datePlanPri);
	
	/**
	 * 修改日计划
	 * @param datePlanPri
	 */
	void merge(DatePlanPri datePlanPri);
	
	/**
	 * 查找交车工长日计划
	 * @return
	 */
	List<DatePlanPri> findDatePlanPriByFroeman(UsersPrivs usersPrivs);
	
	/**
	 * 根据具体班组查找报活日计划
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
	
	List<DatePlanPri> findDatePlanPriByJtPreDictSign(Long userid,Integer roleType);
	
	/**
	 * 判断当日机车计划是否已存在
	 * @param jcType 机车类型
	 * @param userId 机车编号
	 * @param fixFreque 修程修次
	 */
	public DatePlanPri dailyIsExist(String jcType, String jcNum, String fixFreque);
	
	/**
	 * 保存主计划表信息
	 * @param mainPlan
	 */
	public void saveOrUpdateMainPlan(MainPlan mainPlan);
	
	/**
	 * 保存计划表详细信息
	 * @param mainPlanDetail
	 */
	public void saveOrUpdateMainPlanDetail(MainPlanDetail mainPlanDetail);
	
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
	 * 根据主计划表ID删除其信息
	 * @param mainPlanId
	 */
	public void delMainPlanById(Long mainPlanId);
	
	/**
	 * 根据主计划表ID或者计划详细ID删除其信息
	 * @param mainPlanId
	 * @param mainPlanDetailId
	 */
	public void delMainPlanDetailById(Long mainPlanId,Long mainPlanDetailId);
	
	/**
	 * 查询主计划列表
	 * @return
	 */
	public List<MainPlan> findMainPlanList();
	
	/**
	 * 根据时间查询主计划表
	 * @param startTime
	 * @param endTime
	 * @return
	 */
	public List<MainPlan> findMainPlanByTime(String startTime,String endTime);
	
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
	 * 更新计划详情表中特定字段特定值
	 * @param id
	 * @param inputName
	 * @param inputVal
	 */
	public void updateMainPlanDetial(Long id,String inputName,String inputVal);
}
