package com.repair.plan.dao;

import java.util.List;

import com.repair.common.pojo.DatePlanPri;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.JGPlanContent;
import com.repair.common.pojo.JtPreDict;
import com.repair.common.pojo.JtRunKiloRec;
import com.repair.common.pojo.MainPlan;
import com.repair.common.pojo.MainPlanDetail;

public interface JtRunKiloRecDao {
	/**
	 * 查找机车走行
	 * @return
	 */
	List<JtRunKiloRec> findJtRunKiloRec();
	
	/**
	 * 根据ID查找机车走行实体
	 * @param runKiloRecId
	 * @return
	 */
	JtRunKiloRec findJtRunKiloRecById(Long runKiloRecId);
	
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
	 * 查找机车类型
	 * */
	public List<String> findJcTypes();
	
	/**
	 * 查找加改项目
	 * */
	public List<String> findJgItems();
	
	
	/**
	 * 根据项目，车型统计加改信息
	 */
	public List listJGPlan(String jgContent,String jcType);
	
	/**
	 * 保存加改日计划
	 * */
	public void saveItemDatePlan(DatePlanPri datePlanPri);
	
	/**
	 * 保存加改报活
	 * */
	public void saveItemJtPreDict(JtPreDict jtPreDict);
	
	/**
	 * 保存新增加改项目
	 * */
	public void saveJgItem(JGPlanContent jPlan);
	
	/**
	 * 编辑加改信息
	 */
	public List editeJGPlanContent();
	
	/**
	 * 根据项目查找加改信息
	 */
	public List<JGPlanContent> findJgByitem(String content);
	
	/**
	 * 删除加改项目
	 */
	public String deleteJGPlanContent(JGPlanContent content);
	
	/**
	 * 编辑加改项目
	 */
	public String updateJgItem(JGPlanContent jPlan);
	

	/**
	 * 根据id编辑加改项目
	 */
	public String updateJgItemById(JGPlanContent jPlan);
	
	/**
	 * 查询各车型配属数量
	 * */
	public List findJcAcounts();
	
	/**
	 * 查询数量
	 * */
	public List findJcItemAcount();
	
	/**
	 * 查询加改项目机车列表
	 * */
	public List findJcItemList(String itemName, String jctype);
	
	/**
	 * 查询加改项目是否已经存在
	 * */
	public long findJGPlanContent(String item);
}
