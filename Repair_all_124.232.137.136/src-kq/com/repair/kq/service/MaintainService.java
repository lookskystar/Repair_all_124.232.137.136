package com.repair.kq.service;

import java.util.List;

import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.KQEquip;
import com.repair.common.pojo.KQHoliday;
import com.repair.common.pojo.KQRule;
import com.repair.common.pojo.KQWorkTimeItem;

public interface MaintainService {
	
	/**
	 * 查询所有考勤设备
	 */
	List<KQEquip> getEquip();
	
	/**
	 * 新增设备
	 */
	public void saveKQEquip(KQEquip equip);
	
	/**
	 * 根据id查询设备
	 */
	public KQEquip queryEquipById(Long id);
	
	/**
	 * 修改设备信息
	 */
	public void saveOrUpdateEquip(KQEquip equip);
	
	/**
	 * 删除设备
	 */
	public void deleteEquip(KQEquip equip);
	
	/**
	 * 查询考勤设置信息
	 */
	List<KQRule> getRuleInput();
	
	/**
	 * 查询所有班组信息
	 * @return
	 */
	public List<DictProTeam> findDictProTeam();
	
	 /**
	 * 查询节假日信息
	 */
	public List<KQHoliday> getHolidayInput();
	
	/**
	 * 批量添加节假日
	 */
	public void saveHoliday(List<KQHoliday> list);
	
	/**
	 *添加单个节假日
	 */
	public void saveSinHoliday(KQHoliday holiday);
	
	/**
	 * 根据id查询放假安排
	 */
	public KQHoliday queryHolidayById(Long id);
	
	/**
	 * 删除放假安排
	 */
	public void deleteHoliday(KQHoliday holiday);
	
	/**
	 * 修改节假日设置
	 */
	public void saveOrUpdateHoliday(KQHoliday holiday);
	
	/**
	 * 根据id查询考勤规则
	 */
	public KQRule queryRuleById(Long id);
	
	/**
	 * 删除考勤规则
	 */
	public void deleteRule(KQRule rule);
	
	/**
	 * 添加考勤规则
	 */
	public String saveRule(List<KQRule> list);
	
	/**
	 * 修改考勤设置
	 */
	public String saveOrUpdateRule(KQRule rule,Long ruleId);
	
	/**
	 * 根据id查询班组名称
	 */
	public DictProTeam queryBzById(Long bzid);
	
	/**
	 * 查询所有工时项目
	 */
	List<KQWorkTimeItem> getworkTimeItems(Long proteamId,String itemName);
	
	/**
	 * 查询工作班组
	 */
	public List<DictProTeam> findWorkProTeam();
	
	/**
	 * 新增工时项目
	 */
	public void saveWorkTimeItem(KQWorkTimeItem workTimeItem);
	
	/**
	 * 根据id查询工时项目
	 */
	public KQWorkTimeItem queryWorkTimeItemById(Long id);
	
	/**
	 * 修改工时项目信息
	 */
	public void saveOrUpdateWorkTimeItem(KQWorkTimeItem workTimeItem);
	
	/**
	 * 删除工时项目
	 */
	public void delWorkTimeItem(KQWorkTimeItem workTimeItem);
}
