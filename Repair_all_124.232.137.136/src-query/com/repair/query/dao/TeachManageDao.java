package com.repair.query.dao;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.TrainFault;
import com.repair.common.util.PageModel;

/**
 * 
 * 技术管理
 * @author eleven
 *
 */
public interface TeachManageDao {
	
	/**
	 * 查询所有临修、加改、超修记录
	 * @param type
	 * @param dateStart
	 * @param dateEnd
	 * @param jcNum
	 * @return
	 */
	public PageModel<DatePlanPri> techManage(String type, String dateStart, String dateEnd, String jcNum);
	
	/**
	 * 查询所有超修记录
	 * @param dateStart
	 * @param dateEnd
	 * @param jcNum
	 * @return
	 */
	public PageModel<DatePlanPri> superFix(String dateStart, String dateEnd, String jcNum);

	
	/**
	 * 零公里检查分析（技术管理）
	 * @param dateStart
	 * @param dateEnd
	 * @param jcNum
	 * @return
	 */
	public PageModel<DatePlanPri> zoreAnalyse(String dateStart, String dateEnd, String jcNum);
	
	/**
	 * 零公里记录查询（技术管理）
	 */
	public PageModel<JtPreDict> zoreRecord(String isTem,Integer id, String dateStart, String dateEnd);
	
	/**
	 * 检修指标统计（技术管理）
	 * @param jctype
	 * @param jcnum
	 * @return
	 */
	public PageModel<DatePlanPri> fixIndexMainten(String jctype, String jcnum, String dateStart, String dateEnd);
	
	/**
	 * 检修指标统计（技术管理）
	 * @param jctype
	 * @param jcnum
	 * @param dateStart
	 * @param dateEnd
	 * @return
	 */
	public PageModel<JtPreDict> preInfoRecord(String type,String yjbj, String ejbj,String jctype, String jcnum, String dateStart, String dateEnd);
	
	/**
	 * 机破信息统计（技术管理）
	 * @param jcnum
	 * @param dateStart
	 * @param dateEnd
	 * @return
	 */
	public PageModel<TrainFault> trainFaultList(String jcType, String jcnum, String dateStart, String dateEnd);
	
	/**
	 * 机破信息添加（技术管理）
	 * @param trainFault
	 * @return
	 */
	public void saveTrainFault(TrainFault trainFault);
	
	/**
	 * 查询机破信息（技术管理）
	 * @param id
	 * @return
	 */
	public TrainFault queryTrainFaultById(Integer id);
	
	/**
	 * 机破信息删除（技术管理）
	 * @param trainFault
	 * @return
	 */
	public void deleteTrainFault(TrainFault trainFault);
	
}
