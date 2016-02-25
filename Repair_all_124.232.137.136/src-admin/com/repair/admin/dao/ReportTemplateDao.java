package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.ItemRelation;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCFixrec;

public interface ReportTemplateDao {
	
	/**
	 * 查询报表模板项目
	 */
	public List<ItemRelation> listItemRelation(String jcType);
	
	/**
	 * 查询检修项目
	 */
	public List<JCFixitem> listJCFixitem(String jcType,Integer firstUnitId);
	
	/**
	 * 查询机车类型
	 */
	public List<DictJcStype> listDictSTypes();
	
	/**
	 * 更新报表模板项目
	 */
	public void updateItemRelation(int id,String itemsIds);
	
	/**
	 * 查询一级部件
	 */
	public List<DictFirstUnit> listDictFirstUnits(String jctype);
	
	/**下面的方法用于前台报表生成查询**/
	
	/**
	 * 判断项目是否关联模板项目
	 */
	public Long countItemRelation(String jctype);
	
	/**
	 * 查询模板项目中的一级部件
	 */
	public List<DictFirstUnit> listFirstUnitsOfTemplate(String jctype);
	
	/**
	 * 查询报表
	 * @param jctype 机车类型
	 * @param xcxc 修程修次
	 * @param firstUnitId 大部件ID
	 * @param rjhmId 日计划ID
	 */
	public List<ItemRelation> listItemRelation(String jctype,String xcxc,Integer firstUnitId);
	
	/**
	 * 根据日计划ID以及关联的项目ID查询检修记录
	 * @param rjhmId 日计划ID
	 * @param itemIds 关联项目ID
	 */
	public List<JCFixrec> listJCFixrec(Integer rjhmId,String itemIds);
}
