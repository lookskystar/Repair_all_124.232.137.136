package com.repair.admin.dao;

import java.util.List;

import com.repair.common.pojo.DictFirstUnit;
import com.repair.common.pojo.DictJcStype;
import com.repair.common.pojo.DictProTeam;
import com.repair.common.pojo.DictSecunit;
import com.repair.common.pojo.JCFixflow;
import com.repair.common.pojo.JCFixitem;
import com.repair.common.pojo.JCZXFixItem;
import com.repair.common.pojo.PJStaticInfo;
import com.repair.common.util.PageModel;

/**
 * 检修项目Dao类
 * @author Administrator
 *
 */
public interface FixItemDao {
	
	/**
	 * 根据条件查询小辅修检修项目
	 * @return
	 */
	public PageModel<JCFixitem> findJcFixItem(String jcsType,Integer first,Integer second,Long teamId,String itemName,int itemType);
	
	/**
	 * 根据机车类型查询所有的一级部件
	 * @return
	 */
	public List<DictFirstUnit> findDictFirstUnit(String jcsType);
	
	/**
	 * 根据一级部件获得二级部件
	 * @param firstUnitId
	 * @return
	 */
	public List<DictSecunit> findDictSecunit(Long firstUnitId);
	
	/**
	 * 查询所有的作业班组
	 * @return
	 */
	public List<DictProTeam> findDictProTeam();
	
	/**
	 * 查询机车类型信息
	 * @return
	 */
	public List<DictJcStype> findDictJcStype();
	
	/**
	 * 查询机车流程
	 * @return
	 */
	public List<JCFixflow> findJCFixflow();
	
	/**
	 * 根据ID查询项目信息
	 * @param thirdUnitId
	 * @return
	 */
	public JCFixitem findJCFixitemById(int thirdUnitId);
	
	/**
	 * 保存项目信息
	 * @param fixItem
	 */
	public void saveOrUpdateFixItem(JCFixitem fixItem);

	/**
	 * 删除项目
	 */
	public void deleteItemInfo(int itemid);
	
	/**
	 * 列出所有静态配件
	 * @return
	 */
	public List<PJStaticInfo> listPJStaticInfo();
	
	/**
	 * 根据条件查询中修检修项目
	 * @return
	 */
	public PageModel<JCZXFixItem> findJcZxFixItem(String jcsType, Integer first, Long teamId, String itemName,int itemType);
	
	/**
	 * 删除中修项目
	 */
	public void deleteZxItemInfo(int itemid);
	
	/**
	 * 根据ID查询中修项目信息
	 */
	public JCZXFixItem findJCZXFixItemById(int Id);
	
	/**
	 * 新增项目信息
	 */
	public void saveZxFixItem(JCZXFixItem zxfixItem);
	
	/**
	 * 修改项目信息
	 */
	public void updateZxFixItem(JCZXFixItem zxfixItem);
}
