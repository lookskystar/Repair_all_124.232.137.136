package com.repair.experiment.dao;

import java.util.List;

import com.repair.common.pojo.JcExperimentItem;

public interface JcExperimentItemDao {

	/**
	 * 查询和当前项目模糊匹配的所有实验项目
	 * @param parentId 试验标识：水阻、高低压等标识id
	 * @param itemname 项目集合代表名 例如：A1a、 B1b
	 * @return
	 */
	List<JcExperimentItem> findExperimentItemListByItemName(int parentId, String itemname);

	/**
	 * 根据机车试验id和试验项目名查询对应的试验项目
	 * @param parentId 机车试验id
	 * @param itemname 试验项目名
	 * @return
	 */
	JcExperimentItem findExperimentItemByItemName(int parentId, String itemname);

	/**
	 * 根据机车试验流程节点和机车类型查询当前机车所有的试验
	 * @param flowId 试验流程节点id
	 * @param jcType  机车类型：SS3B、DF4等
	 * @return
	 */
	List<JcExperimentItem> findJcExperimentsByFlowIdAndJcType(int flowId, String jcType);

	/**
	 * 根据试验项目id查询试验项目
	 * @param itemId 试验项目id
	 * @return
	 */
	JcExperimentItem findExperimentItemById(long itemId);

	/**
	 * 查询当前试验的所有检修项目
	 * @param expId
	 * @return
	 */
	int findExperimentAllItemCount(int expId);

}
