package com.repair.part.dao;

import java.util.List;

import com.repair.common.pojo.PJDynamicInfo;
import com.repair.common.pojo.PJUnitPart;
import com.repair.common.util.PageModel;

public interface PJDynamicInfoDao {

	/**
	 * 根据静态配件id分页查询对应的动态配件
	 * @param pjsid静态配件id
	 * @param flag 标识：1表示日计划时选择配件，2表示填写大部件的子配件
	 * @return
	 */
	PageModel findPageModelPJDynamicByPJSid(long pjsid,int flag);

	/**
	 * 查选当前日计划已经选择了的动态配件
	 * @param pid 日计划id
	 * @return
	 */
	List findPartChoicedByDatePlan(long pid);

	/**
	 * 根据动态配件id获取动态配件
	 * @param pjdId 动态配件id
	 * @return
	 */
	PJDynamicInfo getPJDynamicInfoById(long pjdId);

	/**
	 * 修改配件动态信息
	 * @param pjDynamicInfo
	 */
	void updatePJDynamicInfo(PJDynamicInfo pjDynamicInfo);

	/**
	 * 保存一条配件检修大部件的子配件记录
	 * @param unitPart
	 */
	void savePJUnitPart(PJUnitPart unitPart);

	/**
	 * 根据配件出厂编码查询动态配件
	 * @param pjNum 配件编码
	 * @return
	 */
	List<PJDynamicInfo> findPJDynamicInfoListByPJNum(String pjNum);

	/**
	 * 查询中心库或班组的待修动态配件
	 * @return
	 */
	PageModel findPageModelPJDynamic(String jcType,Long firstUnitId,String pjName,String pjNum,Integer pjStatus,Long bzId);
	
	/**
	 * 查询配件动态信息
	 * @return
	 */
	public PageModel<PJDynamicInfo> findPJDynamicInfo(String pjName,String pjNum);
	
	/**
	 *查询本班组的动态配件信息
	 */
	public List listPJDynamicInfo(String jcType,Long firstUnitId,String pjName, Long bzId);
	
	/**
	 * 批量更新动态配件存储位置
	 */
	public Integer changePJDynamicInfoStorePosition(List<String> pjdidList, Integer position, Integer pjStatus);

}
